/****************************************************************
 Name: LoanDAO
============================================================
Author: 
Purpose: Data Access object for Loan__c
============================================================

****************************************************************/

public interface LoanDAO {
	List<Loan__c> getLoansByApplicationId(Id applicationId);
	List<Loan__c> getLoansByApplicationIds(List<Id> applicationIds);
	void updateLoans(List<Loan__c> loans);
}