/****************************************************************
 Name:  EventRequestParentApplicationUpdater
============================================================
Author: Kevin
Purpose: JIRA #2590
============================================================

****************************************************************/
public with sharing class EventRequestParentApplicationUpdater {
	@TestVisible private static ApplicationDAO applicationDA = new ApplicationDataAccessor();

	public EventRequestParentApplicationUpdater(){}

	public void updateParentApplications(List<Event_Request__c> eventRequests){
		
	}
}