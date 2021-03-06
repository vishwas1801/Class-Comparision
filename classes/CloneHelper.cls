public class CloneHelper {

  public List<relatedObjects> objectChildren  { get; set; }
  public String               objectTypeName  { get; set; }
  public String               objectName      { get; set; }
  public string 			  objectId 		  { get; set; }
   
  private SObject parentSObject, parentClone;
  
  // Initialisation method called when the clone plus page is loaded.
  // Use the id page parameter to find out what kind of 
  // object we are trying to clone.
  // Then load the object from the database.
  // Finally call the populateObjectChildren method to      
  public cloneHelper(Id parentId)
  {
    // Here we generate a keyprefixmap using the global describe 
    // Then compare that to our object to determine type.  
    Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe(); 
       
    Map<String,String> keyPrefixMap = new Map<String,String>{};
          
    for(String sObj : gd.keySet()){
      Schema.DescribeSObjectResult r =  gd.get(sObj).getDescribe();
      keyPrefixMap.put(r.getKeyPrefix(), r.getName());
    }
      
    String objectID = parentId;
    String objectTypeKey = objectId.subString(0,3);      
    objectTypeName = keyPrefixMap.get(objectTypeKey);
      
    String primaryObjectQueryString = 'SELECT Id, Name FROM '
                                    + objectTypeName
                                    + ' WHERE Id = \''
                                    + objectId
                                    + '\'';
    
    parentSObject = Database.query(primaryObjectQueryString);
    objectName          = '' + parentSObject.get('Name');
    populateObjectChildren();   
    doClone();
  }

  // Get all of the children of the current object that have a 
  // object type contained in the child object types custom setting.
  // Not restricting the child objects to particular types 
  // results in unclonable system objects being added to the options, 
  // which we need to avoid (You will not want to clone these!)
  // Making these object type choices also allows us 
  // focus our efforts on the specific kinds of objects 
  // we want to allow users to clone.  
  public void populateObjectChildren()
  {
       
    objectChildren = new List<relatedObjects>{};
        
    Set<String> childObjectTypes = new Set<String>{};
    
    // read from custom setting   
    childObjectTypes.add('Credit_Bureau__c');
    childObjectTypes.add('IRS_Transcripts__c');
    childObjectTypes.add('Insurance__c');
    
    // Use the sobjecttype describe method to retrieve all 
    // child relationships for the object to be cloned.    
    Schema.DescribeSObjectResult parentDescribe = 
           parentSObject.getSObjectType().getDescribe();
    
    List<Schema.ChildRelationship> childRelationships = parentDescribe.getChildRelationships(); 
          
    // Iterate through each relationship, 
    // and retrieve the related objects. 
        
    for (Schema.ChildRelationship childRelationship : childRelationships)
    {
        
      Schema.SObjectType childObjectType = childRelationship.getChildSObject();
      
      // Only retrieve the objects if their type is 
      // included in the list          
      if (childObjectTypes.contains(childObjectType.getDescribe().getName()))
      {
        List<relatedObjectRow> relatedObjects = 
                         new List<relatedObjectRow>{};
                
        Schema.SObjectField childObjectField = 
                         childRelationship.getField();
                
        String relatedChildSObjectsquery = 
               'SELECT ID, Name FROM ' 
             + childObjectType.getDescribe().getName()
             + ' WHERE '
             + childObjectField.getDescribe().getName()
             + ' = \'' 
             + parentSObject.Id
             + '\''; 
                                                        
        for (SObject childObject : 
             Database.query(relatedChildSObjectsquery))
        {
          relatedObjects.add(new relatedObjectRow(childObject));
        }
            
        if (!relatedObjects.isEmpty())
        {
          objectChildren.add(new relatedObjects(relatedObjects, 
                childObjectType.getDescribe().getLabelPlural(), 
                childObjectField.getDescribe().getName()));
        }  
      }
    }

  }
  
  // Perform the cloning process.
  // First clone the parent, then all of the child objects. 
  // Then redirect the user to the new object page.
  public void doClone()
  {
    parentClone = cloneObjects(new List<sObject>{parentSObject}).get(0);
    parentClone.put('External_Id__c', '100000');
    
    insert parentClone;
    
    cloneChildObjects();
  }
  
  // Clone the selected child objects.
  // Associate the cloned objects with the new cloned parent object.
  public void cloneChildObjects()
  {
        
    List<sObject> clonedObjects = new List<sObject>{};
    List<sObject> selectedRelatedObjects;
     
    for (relatedObjects relatedObject : objectChildren)
    {
      selectedRelatedObjects = new List<sObject>{};  
      clonedObjects = new List<sObject>{};  
      
      for (relatedObjectRow row : relatedObject.objectRows) 
      {
          selectedRelatedObjects.add(row.obj);
      }
      
      if (!selectedRelatedObjects.isEmpty())
      {
        clonedObjects = cloneObjects(selectedRelatedObjects);
       
        
        
        for (sObject clone : clonedObjects)
        {          
          clone.put(relatedObject.relatedFieldName, parentClone.Id);  
        }
        
        system.debug('Inserting clone');
        insert clonedObjects;
          
      }
    }
  }

  // Clone a list of objects to a particular object type
  // Parameters 
  // - List<sObject> sObjects - the list of objects to be cloned 
  // The sObjects you pass in must include the ID field, 
  // and the object must exist already in the database, 
  // otherwise the method will not work.
  public static List<sObject> cloneObjects(List<sObject> sObjects){
                                                
    Schema.SObjectType objectType = sObjects.get(0).getSObjectType();
    
    // A list of IDs representing the objects to clone
    List<Id> sObjectIds = new List<Id>{};
    // A list of fields for the sObject being cloned
    List<String> sObjectFields = new List<String>{};
    // A list of new cloned sObjects
    List<sObject> clonedSObjects = new List<sObject>{};
    
    // Get all the fields from the selected object type using 
    // the get describe method on the object type.    
    if(objectType != null)
    {
      for (Schema.SObjectField objField : 
           objectType.getDescribe().fields.getMap().values())
      { 
        Schema.DescribeFieldResult fieldDesc = objField.getDescribe();
        // If the field type is location, then do not include it,
        // otherwise it will cause a soql exception.
        // Note that excluding the field does not stop the location from
        // being copied to the new cloned object.
        if(fieldDesc.getType() != DisplayType.LOCATION)
        {
          sObjectFields.add(fieldDesc.Name);
        }
      }
    }
    
    // If there are no objects sent into the method, 
    // then return an empty list
    if (sObjects != null || 
        sObjects.isEmpty() || 
        sObjectFields.isEmpty()){
    
      // Strip down the objects to just a list of Ids.
      for (sObject objectInstance: sObjects){
        sObjectIds.add(objectInstance.Id);
      }

      /* Using the list of sObject IDs and the object type, 
         we can construct a string based SOQL query 
         to retrieve the field values of all the objects.*/
    
      String allSObjectFieldsQuery = 'SELECT ' + sObjectFields.get(0); 
    
      for (Integer i=1 ; i < sObjectFields.size() ; i++){
        allSObjectFieldsQuery += ', ' + sObjectFields.get(i);
      }
    
      allSObjectFieldsQuery += ' FROM ' + 
                               objectType.getDescribe().getName() + 
                               ' WHERE ID IN (\'' + sObjectIds.get(0) + 
                               '\'';

      for (Integer i=1 ; i < sObjectIds.size() ; i++){
        allSObjectFieldsQuery += ', \'' + sObjectIds.get(i) + '\'';
      }
    
      allSObjectFieldsQuery += ')';
    
      system.debug('allSObjectFieldsQuery: ' + allSObjectFieldsQuery);
    
      try{
      
        // Execute the query. For every result returned, 
        // use the clone method on the generic sObject 
        // and add to the collection of cloned objects
        for (SObject sObjectFromDatabase:
             Database.query(allSObjectFieldsQuery)){
          clonedSObjects.add(sObjectFromDatabase.clone(false,true));  
        }
    
      } catch (exception e){
      }
      
    }
   
    return clonedSObjects;
    
  }
  
  // Related objects data construct - 
  // used to store a collection of child objects connected to 
  // the head object through the same relationship field.
  public class relatedObjects
  {
    public List<relatedObjectRow> objectRows { get; set; }
    public String                 pluralLabel      { get; set; }
    public String                 relatedFieldName { get; set; }
    
    public relatedObjects(List<relatedObjectRow> objectRows, 
                          String pluralLabel, 
                          String relatedFieldName) 
    {
      this.objectRows       = objectRows;
      this.pluralLabel      = pluralLabel;
      this.relatedFieldName = relatedFieldName;
    }   
  }     

  // An indidual child object row. 
  // Each instance simply contains the object definition
  public class relatedObjectRow
  {
    public sObject obj      { get; set; }
    //public sObject clonedFrom {get; set;}
    
    public relatedObjectRow(Sobject obj)
    {
      this.obj      = obj;
    }
    
    public String getName(){
      try{
        return '' + obj.get('Name');
      } catch (Exception e){
        return '';
      }    
    }   
  }
}