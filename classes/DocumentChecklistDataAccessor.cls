/****************************************************************
 Name: DocumentChecklistDataAccessor
============================================================
Author: 
Purpose: Data Access for Document_Checklist__c
============================================================

****************************************************************/

/*DELETED ONCE ON BITBUCKET*/
public with sharing class DocumentChecklistDataAccessor implements DocumentChecklistDAO {

	//private final String DOCUMENT_CHECKLIST = 'Document_Checklist__c';

	//private Set<String> documentChecklistFields;

	//public DocumentChecklistDataAccessor(){
	//	Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
	//	this.documentChecklistFields = schemaMap.get(DOCUMENT_CHECKLIST).getDescribe().fields.getMap().keySet();
	//}

	//public Document_Checklist__c getDocumentChecklistByLoanConditionCode(String loanConditionCode) {
	//	QueryBuilder documentChecklistQueryBuilder = new QueryBuilder(DOCUMENT_CHECKLIST);
	//	documentChecklistQueryBuilder.addSelectField(this.documentChecklistFields);
	//	documentChecklistQueryBuilder.addWhereCondition('Loan_Condition_Code__c', loanConditionCode, QueryBuilder.ComparisonOperator.EQUALS);
	//	documentChecklistQueryBuilder.setLimit(1);
	//	return (Document_Checklist__c)Database.query(documentChecklistQueryBuilder.generateQuery());
	//}
}