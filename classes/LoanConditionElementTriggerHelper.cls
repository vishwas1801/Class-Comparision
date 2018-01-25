public with sharing class LoanConditionElementTriggerHelper {
	@TestVisible private static LoanConditionElementsEvaluatorInterface loanConditionElementsEvaluator = new LoanConditionElementsEvaluator();

	public LoanConditionElementTriggerHelper(){}

	public void afterInsert(List<Loan_Condition_Element__c> newLoanConditionElements){
		loanConditionElementsEvaluator.flagApplicationIfRequiredLoanConditionElementsCompleted(newLoanConditionElements);
	}

	public void afterUpdate(List<Loan_Condition_Element__c> newLoanConditionElements, Map<Id,Loan_Condition_Element__c> oldLoanConditionElementsMap){
		loanConditionElementsEvaluator.flagApplicationIfRequiredLoanConditionElementsCompleted(newLoanConditionElements);
	}
}