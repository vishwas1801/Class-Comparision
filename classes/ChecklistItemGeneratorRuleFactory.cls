/****************************************************************
 Name:  ChecklistItemGeneratorRuleFactory
============================================================
Author: Lenny
Purpose: JIRA#2148,2138,2170                                                                                                            
============================================================

****************************************************************/
public with sharing class ChecklistItemGeneratorRuleFactory {
	public ChecklistItemGeneratorRuleFactory() {}

	public List<ChecklistItemRuleInterface> getApplicableLCRelatedChecklistItemGeneratorRules(){
		List<ChecklistItemRuleInterface> rulesList = new List<ChecklistItemRuleInterface>();

		rulesList.add(new CISharedOrCommonImprovementsRule());
		rulesList.add(new CICondominiumRepairsRule());
		rulesList.add(new CIReleaseAssignmentOfProceedsRule());
		rulesList.add(new CIAssignmentOfPendingLawsuitRule());
		rulesList.add(new CILeaseExtensionRequirementRule());
		rulesList.add(new CISubmitFutureLeasesRule());
		rulesList.add(new CIProofOfHazardInsuranceRule());

		return rulesList;
	}
}