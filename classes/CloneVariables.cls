global without sharing class CloneVariables {
    
/* 
 *  global static Map<String, String> mapApexMessages() {
        List<ApexMessage__c> msgs = ApexMessage__c.getAll().values();
        Map<String, String> options = new Map<String, String>();
        for (ApexMessage__c msg : msgs) {
            options.put(msg.Name, msg.ApexMessage__c);
        }
        return options;
    } */
    
    global static Map<String, Set<String>> mapChildRelationships() {
        List<Loan_Mod_Clone_Objects__mdt>  childParentList = [SELECT Child_relationship__c ,Parent__c FROM Loan_Mod_Clone_Objects__mdt];
        Map<String, Set<String>> mapOf = new Map<String, Set<String>>();
       for (Loan_Mod_Clone_Objects__mdt relation : childParentList) {
            if (!mapOf.containsKey(relation.Parent__c)) {
                mapOf.put(relation.Parent__c, new Set<String>());
            }
            mapOf.get(relation.Parent__c).add(relation.Child_Relationship__c);
        }
        return mapOf;
    }
    
    global static Map<String, Set<String>> mapFieldExclusions() {
        //List<FieldExclusion__c> excls = FieldExclusion__c.getAll().values();
        Map<String, Set<String>> mapOf = new Map<String, Set<String>>();
       /* for (FieldExclusion__c excl : excls) {
            if (!mapOf.containsKey(excl.sObjectType__c)) {
                mapOf.put(excl.sObjectType__c, new Set<String>());
            }
            mapOf.get(excl.sObjectType__c).add(excl.FieldExclusion__c.toLowerCase());
        }*/
        return mapOf;
    }
    
    
    global static Map<String, Set<String>> mapFieldInclusions() {
        List<Loan_Mod_Clone_Field_Inclusions__mdt> includedFields = [SELECT SObject_API_Name__c ,Field_to_Include_API_Name__c FROM Loan_Mod_Clone_Field_Inclusions__mdt];
        Map<String, Set<String>> mapOf = new Map<String, Set<String>>();
        for (Loan_Mod_Clone_Field_Inclusions__mdt includedField : includedFields) {
            if (!mapOf.containsKey(includedField.SObject_API_Name__c)) {
                mapOf.put(includedField.SObject_API_Name__c, new Set<String>());
                mapOf.get(includedField.SObject_API_Name__c).add('name');  //Add name by default
                mapOf.get(includedField.SObject_API_Name__c).add('external_id__c'); //Add External_Id__c by default. If it does not exist in field list, it will be ignored.
            }
            mapOf.get(includedField.SObject_API_Name__c).add(includedField.Field_to_Include_API_Name__c.toLowerCase());
        }
        return mapOf;
    }
    
    global static Map<String, Map<String, String>> mapFieldDefaults() {
       // List<FieldDefault__c> defs = FieldDefault__c.getAll().values();
        Map<String, Map<String, String>> mapOf = new Map<String, Map<String, String>>();
        
        //mapof.put('Application__c', new Map<String,String>{'external_id__c'=>'10000'});
        //mapof.put('Property__c',new Map<String,String>{'external_id__c'=>'10000'});
       /* for (FieldDefault__c def : defs) {
            if (!mapOf.containsKey(def.sObjectType__c)) {
                mapOf.put(def.sObjectType__c, new Map<String, String>());
            }
            mapOf.get(def.sObjectType__c).put(def.FieldDefault__c.toLowerCase(), def.FieldValue__c);
        }*/
        return mapOf;
    }
    
    //** Maps, held privately so as to only pull once per call
   // private static final Map<String, String> mapApexMessages = UtilsCustomSetting.mapApexMessages();
    private static final Map<String, Set<String>> mapChildRelationships = mapChildRelationships();
    private static final Map<String, Set<String>> mapFieldExclusions = mapFieldExclusions();
    private static final Map<String, Set<String>> mapFieldInclusions = mapFieldInclusions();
    private static final Map<String, Map<String, String>> mapFieldDefaults = mapFieldDefaults();
    
    //** Returns a message for use in APEX error handling, chatter posting, etc
 //   global static String getApexMessage(String msgName) {
 //       return mapApexMessages.get(msgName);
 //   }
    
    //** Returns a set of child relationships to include in the cloning query
    global static Set<String> getChildRelationships(String relName) {
        Set<String> setOf = new Set<String>();
        if (mapChildRelationships.containsKey(relName)) {
            setOf.addAll(mapChildRelationships.get(relName));
        }
        return setOf;
    }
    
    //** Returns a set of fields to exclude from the cloning query
    global static Set<String> getFieldExclusions(String esclName) {
        Set<String> setOf = new Set<String>();
        if (mapFieldExclusions.containsKey(esclName)) {
            setOf.addAll(mapFieldExclusions.get(esclName));
        }
        return setOf;
    }
    
    //** Returns a set of fields to include in the cloning query
    global static Set<String> getFieldInclusions(String sObjectApiName) {
        Set<String> setOf = new Set<String>();
        if (mapFieldInclusions.containsKey(sObjectApiName)) {
            setOf.addAll(mapFieldInclusions.get(sObjectApiName));
        }
        return setOf;
    }
    
    //** Returns a set of fields to exclude from the cloning query
    global static Set<String> getFieldDefaults(String defName) {
        Set<String> setOf = new Set<String>();
        if (mapFieldDefaults.containsKey(defName)) {
            setOf.addAll(mapFieldDefaults.get(defName).keySet());
        }
        return setOf;
    }
    
    //** Returns a set of fields to exclude from the cloning query
    global static String getFieldDefault(String defName, String defValue) {
        if (mapFieldDefaults.containsKey(defName)) {
            if (mapFieldDefaults.get(defName).containsKey(defValue)) {
                return mapFieldDefaults.get(defName).get(defValue);
            }
        }
        return null;
    }
    
}