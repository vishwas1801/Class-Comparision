/****************************************************************
 Name: ChecklistItemGenerateSysGDocFlagInvoker
============================================================
Author: Vid
Purpose: DCMM-? / Invocable class to start generation of System Generated Documents via DrawLoop
============================================================

****************************************************************/
public with sharing class ChecklistItemGenerateSysGDocFlagInvoker {
	@InvocableMethod(label='Flag Generate Document on System Generated Document Checklist Items' description='Runs the method to flag the Generate Document field on System Generated Checklist Items')
	public static void flagSystemGeneratedChecklistItemGenerateDocument (List<Id> appIds) {
		ChecklistItemGenerateDocumentFlagger flagger = new ChecklistItemGenerateDocumentFlagger();
		flagger.flagSystemGeneratedChecklistItems(appIds);
	}
}