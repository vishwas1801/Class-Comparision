/****************************************************************
 Name:  ChecklistItemElementRuleFactory
============================================================
Author: Lenny
Purpose: JIRA#2148,2170                                                                                                            
============================================================

****************************************************************/
public with sharing class ChecklistItemElementRuleFactory {
	public ChecklistItemElementRuleFactory() {}

	public List<ChecklistItemElementRuleInterface> getApplicableLCERelatedChecklistItemElementRules(){
		List<ChecklistItemElementRuleInterface> rulesList = new List<ChecklistItemElementRuleInterface>();

		rulesList.add(new CESharedRepairResponsibilityRule());
		rulesList.add(new CECaseNumberRule());
		rulesList.add(new CEDefendantTitleRule());
		rulesList.add(new CEDefendantNameRule());
		rulesList.add(new CENameOfCourtRule());	
		rulesList.add(new CEMaximumMonthlyPaymentRule());	
		rulesList.add(new CENumberOfYearsRule());	
		rulesList.add(new CEPropertyNumberRule());
		rulesList.add(new CERealEstateCoverageRule());
		rulesList.add(new CEContentsCoverageRule());
		rulesList.add(new CELossPayeeRule());
		rulesList.add(new CEWindstormRule());

		return rulesList;
	}

	public List<ChecklistItemElementRuleInterface> getApplicableCILevelChecklistItemElementRules(){
		List<ChecklistItemElementRuleInterface> rulesList = new List<ChecklistItemElementRuleInterface>();

		rulesList.add(new CEDefendantTitleRule());
		rulesList.add(new CEDefendantNameRule());
		rulesList.add(new CEAssignmentDateRule());
		rulesList.add(new CESBAAttorneyToSignRule());		
		rulesList.add(new CESewerBackupRule());

		return rulesList;
	}
}