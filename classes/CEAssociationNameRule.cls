/****************************************************************
 Name:  CEAssociationNameRule
============================================================
Author: Lenny
Purpose: JIRA#2437                                                                                                            
============================================================

****************************************************************/
public with sharing class CEAssociationNameRule implements ChecklistItemElementRuleInterface{

	public Checklist_Item_Element__c applyRuleAndCreateChecklistItemElement(ChecklistItemElementGenerationCriteria generationCriteria){
		MasterChecklistData mcData = MasterChecklistData.getInstance();
		Loan_Condition_Element__c element = generationCriteria.relatedElement;
		Checklist_Item__c item = generationCriteria.relatedChecklistItem;
		Master_Checklist__c associationNameChecklist = 
			mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.ASSOC_NAME);

		if(item.Master_Checklist__c == mcData.getMasterChecklistByChecklistCode(MasterChecklistDataAccessor.ASSIGN_INSURANCE).Id
			&& element.Id == null
		){
			return new Checklist_Item_Element__c(
				Name = associationNameChecklist.Name,
				Checklist_Item__c = item.Id,
				Master_Checklist__c = associationNameChecklist.Id,
				Required__c = false
			);
    	}

		return null;
	}
}