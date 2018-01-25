/****************************************************************
 Name:  ApplicantTriggerHelper
============================================================
Author: Lenny //Kevin/Prathyusha
Purpose: JIRA#1870/1774
XXXXX                                                                                                                
============================================================
*/
public with sharing class ApplicantTriggerHelper {
    //public static final String APPLICATION_RECORDTYPE_HOME='Home Loan Application';
    //public static final Set<String> states = new Set<String>{'AK','HI'};
    //public static final Integer INCOME_TABLE_MAX_FAMILY_SIZE  = 8;
    //public static final Integer INCOME_TABLE_GEN_SIZE  = 9999;
    //public static final Map<String,String> locationMap = new Map<String,String>{
    //    'United States' => 'US',
    //    'AK' => 'AK',
    //    'HI' => 'HI',
    //    'Puerto Rico' => 'PR',
    //    'Virgin Islands' => 'VI', 
    //    'American Samoa' => 'AS', 
    //    'Guam' => 'GU', 
    //    'Nothern Mariana Islands' => 'MP', 
    //    'Federated States Of Micronesia' => 'FM'};
    @TestVisible
    private static PrimaryApplicantHandlerInterface primaryHandler = new PrimaryApplicantHandler();
    
    public static void beforeInsertApplicants(List<Applicant__c> newApplicants){
        primaryHandler.setPrimaryApplicantsIfNone(newApplicants);
    }

    public static void afterUpdateApplicants(Map<Id, Applicant__c> oldApplicants, List<Applicant__c> updatedApplicants){
        primaryHandler.updatePrimaryApplicantsAfterUpdate(oldApplicants, updatedApplicants);
    }

    public static void afterInsertApplicants(List<Applicant__c> newApplicants){
        primaryHandler.updatePrimaryApplicants(newApplicants);

        //Set<ID> appIds = new Set<ID>();
        //Map<ID,List<Applicant__c>> appIDToApplicantsMap = new Map<ID,List<Applicant__c>>();
        //for(Applicant__c app:newApplicants){            
        //        appIds.add(app.Application__c);
        //        if(appIDToApplicantsMap.containskey(app.Application__c)){
        //            appIDToApplicantsMap.get(app.Application__c).add(app);              
        //        }
        //        else{
        //            appIDToApplicantsMap.put(app.Application__c,new List<Applicant__c>{app}); 
        //        }
                            
        //}
        
        //runIncomeTest(appIds,appIDToApplicantsMap);
     }  

 /****************************************************************
        Purpose:  Main method that runs business logic to calculate the minimum income for an application.                                                             
        Parameters: List of Application Ids
        Returns: N/A
     ****************************************************************/
      
    
    //public static void runIncomeTest(Set<Id> appIds,Map<ID,List<Applicant__c>> appIDToApplicantsMap){
    //    try{
    //        String stateLocation;
    //        String countryLocation;
    //        String key;
    //        Decimal familySize;
    //        String maxMIKey;
    //        Map<String,Decimal> minIncomeTable;
    //        List<Application__c> updatedApplications = new List<Application__c>();
    //        if(appIds.isEmpty()){
    //            return ;
    //        }
            
    //        minIncomeTable = retrieveMinimumIncomeTable();
            
    //        for(Application__c app: [SELECT Id,Family_Size__c,Minimum_Income__c,SBA_Employee__c,RecordType.Name,
    //                                     (SELECT ID, Contact__r.MailingState, Contact__r.MailingCountry 
    //                                     FROM Applicants__r WHERE Primary_Applicant__c = TRUE
    //                                     LIMIT 1)
    //                                 FROM Application__c WHERE Id in: appIds]){
    //             if(app.Applicants__r.isEmpty()){
    //                for(Applicant__c applicant: appIDToApplicantsMap.get(app.ID)){
    //                    applicant.addError('There is no Primary Applicant assocaited with an application.');                        
    //                }
    //                continue;
    //             }  
    //             if(app.SBA_Employee__c>0 ||app.RecordType.Name!=APPLICATION_RECORDTYPE_HOME){
    //                if(app.Minimum_Income__c>0){
    //                    app.Minimum_Income__c = minIncomeTable.get(key);
    //                    updatedApplications.add(app);
    //                }
    //                continue;
    //             }         
    //            stateLocation = locationMap.get(app.Applicants__r[0].Contact__r.MailingState);  
    //            familySize =  app.Family_Size__c!=null && app.Family_Size__c >INCOME_TABLE_MAX_FAMILY_SIZE?INCOME_TABLE_GEN_SIZE:app.Family_Size__c;    
                
    //            Integer familySizeDiff = Integer.valueof(app.Family_Size__c-INCOME_TABLE_MAX_FAMILY_SIZE);
    //            if(states.contains(stateLocation)){
    //                key= familySize +'_'+stateLocation;
    //                maxMIKey = INCOME_TABLE_GEN_SIZE +'_'+stateLocation;
    //            }
    //            else{
    //                countryLocation = locationMap.get(app.Applicants__r[0].Contact__r.MailingCountry); 
    //                key= familySize+'_'+countryLocation;
    //                maxMIKey = INCOME_TABLE_GEN_SIZE +'_'+countryLocation;
    //            }
    //            System.debug('maxMIKey-----'+maxMIKey); 
    //            System.debug('minIncomeTable-----'+minIncomeTable); 
    //            if(minIncomeTable.get(key)!=null){
    //                if(familySizeDiff>0){
    //                    if(minIncomeTable.get(maxMIKey)!=null){
    //                    app.Minimum_Income__c = (minIncomeTable.get(key))+(familySizeDiff * minIncomeTable.get(maxMIKey));
    //                    }
    //                    else{
    //                        for(Applicant__c applicant: appIDToApplicantsMap.get(app.ID)){
    //                            applicant.addError('Did not find an entry for the Gross Annual Income in the minimum income table, please verify the State, Territory, Country values on the asociated Contact');                       
    //                    }
    //                    }
    //                }
    //                else{
    //                app.Minimum_Income__c = minIncomeTable.get(key);
    //                }
    //                updatedApplications.add(app);
    //            }
    //            else{
    //                for(Applicant__c applicant: appIDToApplicantsMap.get(app.ID)){
    //                    applicant.addError('Did not find an entry for the Gross Annual Income in the minimum income table, please verify the State, Territory, Country values on the asociated Contact');                       
    //                }
    //                continue;   
    //            }           
    //        }
    //        if(updatedApplications.size()>0){
    //            update updatedApplications;
    //        }
    //    }
    //    catch(Exception e){
    //         throw new applicationException('An error occurred while calculating the minimum income'+e.getMessage()); 
    //    }
            
       
    //}
    //public static Map<String,Decimal> retrieveMinimumIncomeTable(){
    //    try{
    //        Map<String,Decimal> minIncomeTableMap = new Map<String,Decimal>();
    //        String fiscalYear= String.valueof(System.Today().year());
    //        Date fyStartDate = date.newInstance(System.Today().year(), 10, 1);
            
    //        fiscalYear = System.Today()>=fyStartDate?String.valueof(System.Today().addYears(1).year()):fiscalYear;
            
    //        if(System.Today()==System.Today() || Cache.Org.get('local.IncomeTable.tableMap')==null){
    //            for(Minimum_Income__c mi:[SELECT Id, Reference_ID__c , Annual_Income__c FROM Minimum_Income__c WHERE Fiscal_Year__c =:fiscalYear]){
    //                minIncomeTableMap.put(mi.Reference_ID__c,mi.Annual_Income__c);  
    //            }           
    //            Cache.Org.put('local.IncomeTable.tableMap', minIncomeTableMap);
    //        }
    //        else{           
    //            Object obj = Cache.Org.get('local.IncomeTable.tableMap');
    //            minIncomeTableMap = (Map<String,Decimal>)obj;
    //            System.debug('----Cache works-----'+minIncomeTableMap);
    //        }
            
            
    //        return minIncomeTableMap;
    //    }
    //    catch(Exception e){
    //        throw new applicationException('An error occurred while retreiving minimum income table data'+e.getMessage());
    //    }
    
    //}
    
    //public class applicationException extends Exception {}
    
}