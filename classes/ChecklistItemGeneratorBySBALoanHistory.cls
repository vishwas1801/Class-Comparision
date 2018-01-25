/****************************************************************
 Name:  ChecklistItemGeneratorBySBALoanHistory
============================================================
Author: Lenny
Purpose: JIRA#1293                                                                                                            
============================================================

****************************************************************/
public with sharing class ChecklistItemGeneratorBySBALoanHistory extends ChecklistItemGenerator{
    @TestVisible private final String CASE_RTNAME_DOCUMENT_REQUEST = 'Document Request';

    @TestVisible private static ApplicationDAO applicationDA = new ApplicationDataAccessor();
    @TestVisible private static ChecklistItemDAO checklistItemDA = new ChecklistItemDataAccessor();
    @TestVisible private static CaseDAO caseDA = new CaseDataAccessor();
    @TestVisible private static MasterChecklistDAO masterChecklistDA = new MasterChecklistDataAccessor();

    public ChecklistItemGeneratorBySBALoanHistory() {}
    
    public void generateChecklistItems(List<Case> cases){}
    public void handleChecklistGeneration(List<SObject> eventRequestSobjects){
        if(eventRequestSobjects == null || eventRequestSobjects.isEmpty()){
            return;
        }

        List<Event_Request__c> eventRequests;
        try{
            eventRequests = (List<Event_Request__c>)eventRequestSobjects;
        } 
        catch (TypeException e) {
            System.debug(e);
            throw new ChecklistItemGeneratorBySBALoanHistoryException(
                'handleChecklistUpdates requires a List of Event Request as input.', e
            );
        }

        if(!eventRequests.isEmpty()){
            generateChecklistItems(eventRequests);
        }
    }


    private void generateChecklistItems(List<Event_Request__c> eventRequests){
        List<String> applicationNumbers = new List<String>();
        for(Event_Request__c request : eventRequests) {
            applicationNumbers.add(request.Application_Number__c);
        }
        List<Application__c> relatedApplications = applicationDA.getApplicationsByApplicationNumber(applicationNumbers);

        List<Id> applicationIds = new List<Id>();
        
        for(Application__c application : relatedApplications) {
            applicationIds.add(application.Id);
        }
        
        Map<Id,Application__c> relatedApplicationIdToApplicationMap = applicationDA.getApplicationsMapById(applicationIds);
        Map<Id, Case> applicationIdToCaseMap = buildApplicationIdToCaseMap(applicationIds);
        Master_Checklist__c loanHistChecklist = masterChecklistDA.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.LOAN_HISTORY_CODE);
        
        List<Checklist_Item__c> checklistItemsToInsert = new List<Checklist_Item__c>();

        for(Id applicationId : applicationIds) {
            checklistItemsToInsert.add(
                createSBALoanHistoryChecklistItemForApplication(
                    applicationIdToCaseMap.get(applicationId),
                    relatedApplicationIdToApplicationMap.get(applicationId),
                    loanHistChecklist
                )
            );
        }

        try {
            checklistItemDA.insertChecklistItems(checklistItemsToInsert);
        } catch(DmlException e) {
            throw new ChecklistItemGeneratorBySBALoanHistoryException('Error occurred while attempting to insert new Checklist_Item__c: '+e.getMessage());
        }
    }


    private Checklist_Item__c createSBALoanHistoryChecklistItemForApplication(
        Case cas, 
        Application__c application,
        Master_Checklist__c loanHistChecklist
    ) {
        return generateNewApplicationLevelChecklistItem(
                    loanHistChecklist, 
                    cas, 
                    application,
                    ChecklistItemDataAccessor.REQUESTED_STATUS,
                    ChecklistItemDataAccessor.INTERFACE_TYPE
        );
    }

    private Map<Id, Case> buildApplicationIdToCaseMap(List<Id> applicationIds) {
        Map<Id, Case> applicationIdToCaseMap = new Map<Id, Case>();

        Schema.DescribeSObjectResult caseDescribeResult = Schema.SObjectType.Case;
        Map<String,Schema.RecordTypeInfo> rtNameToRecordTypeInfo = caseDescribeResult.getRecordTypeInfosByName();
        Id docRequestRecordTypeId = rtNameToRecordTypeInfo.get(CASE_RTNAME_DOCUMENT_REQUEST).getRecordTypeId();

        List<Case> relatedCases = caseDA.getCasesByApplicationIdsAndRecordType(applicationIds, docRequestRecordTypeId);

        for(Case cas : relatedCases) {
            applicationIdToCaseMap.put(cas.Application__c, cas);
        }

        return applicationIdToCaseMap;
    }


    public class ChecklistItemGeneratorBySBALoanHistoryException extends Exception {}
}