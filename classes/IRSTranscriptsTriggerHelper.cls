/****************************************************************
 Name: IRSTranscriptsTriggerHelper
============================================================
Author: 
Purpose: Trigger Helper for IRS Transcript Trigger
============================================================

****************************************************************/

public with sharing class IRSTranscriptsTriggerHelper {
	
	@TestVisible
	private ChecklistItemUpdaterInterface checklistItemUpdater = new ChecklistItemUpdaterByIRSTranscript();

	public IRSTranscriptsTriggerHelper(){}

	public void afterInsert(List<IRS_Transcripts__c> newTranscripts){
		checklistItemUpdater.handleChecklistUpdates(newTranscripts);
	}

	public void afterUpdate(List<IRS_Transcripts__c> newTranscripts, Map<Id,IRS_Transcripts__c> oldTranscriptsMap){
		checklistItemUpdater.handleChecklistUpdates(newTranscripts);
	}
}