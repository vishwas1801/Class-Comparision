/****************************************************************
 Name: ChecklistItemCreateSystemGeneratedDoc
============================================================
Author: Vid
Purpose: DCMM-2387 / Invocable class to start generation of System Generated Documents via DrawLoop
============================================================

****************************************************************/
public with sharing class ChecklistItemCreateSystemGeneratedDoc {
	private static final Map<String, String> checklistCodeMap = new Map<String, String> {
		'Approval Letter' => MasterChecklistDataAccessor.APPROVAL_LETTER
	};
	
	@InvocableMethod(label='Create System Generated Document Checklists' description='Performs logic to generate various System Generated Checklists and Documents')
	public static void createSystemGeneratedChecklistItem(List<CustomApplication> cApps) {
		List<Id> appIds = new List<Id>();
		Set<String> checklistCodes = new Set<String>();
		CaseDataAccessor caseDA = new CaseDataAccessor();
		ChecklistItemGeneratorBySysGenCase sysGenChecklistItemGenerator = new ChecklistItemGeneratorBySysGenCase();
		
		for(CustomApplication cApp : cApps) {
			appIds.add(cApp.appId);
			checklistCodes.add(cApp.docTypeCode);
		}
		setSystemGeneratedChecklistItemCodeTypes(checklistCodes);
		sysGenChecklistItemGenerator.handleChecklistGeneration(caseDA.getCasesByApplicationIds(appIds));
	}
	
	private static void setSystemGeneratedChecklistItemCodeTypes(Set<String> checklistCodes) {
		Set<String> sysGenChecklistCodes = new Set<String>();
		for(String checklistCode : checklistCodes) {
			if(ChecklistItemCreateSystemGeneratedDoc.checklistCodeMap.containsKey(checklistCode)) {
				sysGenChecklistCodes.add(ChecklistItemCreateSystemGeneratedDoc.checklistCodeMap.get(checklistCode));
			}
		}
		
		ChecklistItemGeneratorBySysGenCase.ChecklistItemSystemRequestTypes = sysGenChecklistCodes;
	}
	
	public class CustomApplication {
		@InvocableVariable
		public Id appId;
		@InvocableVariable
		public String docTypeCode;
		
		public CustomApplication() {
		}
	}
}