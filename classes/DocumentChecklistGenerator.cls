/****************************************************************
 Name: DocumentChecklistGenerator
============================================================
Author: Kevin
Purpose: Generate appropriate Document Checklists for Cases
============================================================

****************************************************************/
/*DELETED ONCE ON BITBUCKET*/
public with sharing class DocumentChecklistGenerator implements DocumentChecklistGeneratorInterface {

	//@TestVisible private final String CASE_RTNAME_DOCUMENT_REQUEST = 'Document Request';

	//@TestVisible private final String DOC_LINE_ITEM_NAME_PAYSTUB = 'Paystub';
	//@TestVisible private final String DOC_LINE_ITEM_NAME_FLOOD_INSURANCE_INFO = 'Flood Insurance Company Information';
	//@TestVisible private final String DOC_LINE_ITEM_NAME_PERMANENT_RES_CARD = 'Permanent Resident Card';
	//@TestVisible private final String DOC_LINE_ITEM_NAME_INSURANCE = 'Insurance Information';
	//@TestVisible private final String DOC_LINE_ITEM_NAME_CITIZENSHIP = 'Permanent Resident Card';
	//@TestVisible private final String DOC_LINE_ITEM_NAME_REPRESENTATIVE = 'Name of Representative';

	//private final Integer LEGAL_REPRESENTATIVE_FEE_THRESHOLD = 500;

	//@TestVisible private static ApplicationDAO applicationDA = new ApplicationDataAccessor();
	//@TestVisible private static ApplicantDAO applicantDA = new ApplicantDataAccessor();
	//@TestVisible private static InsuranceDAO insuranceDA = new InsuranceDataAccessor();
	//@TestVisible private static DocumentLineItemDAO documentLineItemDA = new DocumentLineItemDataAccessor();

	//public DocumentChecklistGenerator(){}

	//public void handleDocumentGeneration(List<Case> cases){
	//	if(cases == null || cases.isEmpty()){
	//		return;
	//	}

	//	Schema.DescribeSObjectResult caseDescribeResult = Schema.SObjectType.Case;
	//	Map<String,Schema.RecordTypeInfo> rtNameToRecordTypeInfo = caseDescribeResult.getRecordTypeInfosByName();
	//	Id docRequestRecordTypeId = rtNameToRecordTypeInfo.get(CASE_RTNAME_DOCUMENT_REQUEST).getRecordTypeId();

	//	List<Case> docRequestCases = new List<Case>();

	//	for(Case cas : cases){
	//		if(cas.RecordTypeId == docRequestRecordTypeId){
	//			docRequestCases.add(cas);
	//		}
	//	}

	//	if(!docRequestCases.isEmpty()) {
	//		generateDocumentChecklist(docRequestCases);
	//	}
	//}

	//private void generateDocumentChecklist(List<Case> cases){
	//	List<Id> applicationIds = new List<Id>();
	//	for(Case cas : cases){
	//		applicationIds.add(cas.Application__c);
	//	}

	//	Map<Id,Application__c> relatedApplicationIdToApplicationMap = applicationDA.getApplicationsMapById(applicationIds);
	//	List<Applicant__c> relatedPrimaryApplicants = applicantDA.getPrimaryApplicantsByApplicationId(applicationIds);
	//	Map<Id,List<Insurance__c>> applicationIdToInsuranceListMap = buildApplicationIdToInsuranceListMap(applicationIds);

	//	List<Document_Line_Items__c> documentLineItemsToInsert = new List<Document_Line_Items__c>();
	//	documentLineItemsToInsert.addAll(createApplicableDocumentLineItemsForCases(cases, relatedPrimaryApplicants, relatedApplicationIdToApplicationMap, applicationIdToInsuranceListMap));

	//	try {
	//		documentLineItemDA.insertDocumentLineItems(documentLineItemsToInsert);
	//	} catch(DmlException e) {
	//		System.debug('Error occurred while attempting to insert new Document_Line_Items__c: '+e.getMessage());
	//	}
	//}

	//@TestVisible
	//private List<Document_Line_Items__c> createApplicableDocumentLineItemsForCases(
	//	List<Case> cases,
	//	List<Applicant__c> primaryApplicants,
	//	Map<Id,Application__c> relatedApplicationIdToApplicationMap,
	//	Map<Id,List<Insurance__c>> applicationIdToInsuranceListMap
	//){
	//	List<Document_Line_Items__c> newDocLineItems = new List<Document_Line_Items__c>();

	//	for(Case cas : cases){
	//		for(Applicant__c applicant : primaryApplicants){
	//			if(cas.Application__c == applicant.Application__c){
	//				newDocLineItems.add(generateNewDocumentLineItem(DOC_LINE_ITEM_NAME_FLOOD_INSURANCE_INFO, cas, applicant));
	//				newDocLineItems.add(generateNewDocumentLineItem(DOC_LINE_ITEM_NAME_PERMANENT_RES_CARD, cas, applicant));
					
	//				if(applicant.Years_Employed__c < 2){
	//					newDocLineItems.add(generateNewDocumentLineItem(DOC_LINE_ITEM_NAME_PAYSTUB, cas, applicant));
	//				}

	//				if(!applicant.U_S_Citizen__c){
	//					newDocLineItems.add(generateNewDocumentLineItem(DOC_LINE_ITEM_NAME_CITIZENSHIP, cas, applicant));
	//				}

	//				if(relatedApplicationIdToApplicationMap.containsKey(cas.Application__c)){
	//					if(relatedApplicationIdToApplicationMap.get(cas.Application__c).Legal_Representative_Fee__c > LEGAL_REPRESENTATIVE_FEE_THRESHOLD
	//						&& String.isBlank(relatedApplicationIdToApplicationMap.get(cas.Application__c).Legal_Representative_Name__c)){
	//						newDocLineItems.add(generateNewDocumentLineItem(DOC_LINE_ITEM_NAME_REPRESENTATIVE, cas, applicant));
	//					}
	//				}

	//				if(applicationIdToInsuranceListMap.containsKey(cas.Application__c)){
	//					for(Insurance__c insurance : applicationIdToInsuranceListMap.get(cas.Application__c)){
	//						if(isInsuranceInfoIncomplete(insurance)){
	//							newDocLineItems.add(generateNewDocumentLineItem(DOC_LINE_ITEM_NAME_INSURANCE, cas, applicant));
	//							break;
	//						}
	//					}
	//				}
	//			}
	//		}
	//	}

	//	return newDocLineItems;
	//}

	//private Document_Line_Items__c generateNewDocumentLineItem(String documentName, Case cas, Applicant__c applicant){
	//	return new Document_Line_Items__c(
	//		Name = documentName,
	//		Applicant__c = applicant.Id,
	//		Application__c = applicant.Application__c,
	//		Case__c = cas.Id
	//	);
	//}

	//private Map<Id,List<Insurance__c>> buildApplicationIdToInsuranceListMap(List<Id> applicationIds){
	//	Map<Id,List<Insurance__c>> applicationIdToInsuranceListMap = new Map<Id,List<Insurance__c>>();

	//	List<Insurance__c> relatedInsurances = insuranceDA.getInsurancebyApplicationIds(applicationIds);

	//	for(Insurance__c insurance : relatedInsurances){
	//		if(applicationIdToInsuranceListMap.containsKey(insurance.Application__c)){
	//			applicationIdToInsuranceListMap.get(insurance.Application__c).add(insurance);
	//		} else {
	//			applicationIdToInsuranceListMap.put(insurance.Application__c, new List<Insurance__c>{insurance});
	//		}
	//	}

	//	return applicationIdToInsuranceListMap;
	//}

	//private Boolean isInsuranceInfoIncomplete(Insurance__c insurance){
	//	return (
	//		String.isNotBlank(insurance.Name)
	//		&& String.isNotBlank(insurance.Type_of_Insurance_Coverage__c)
	//		&& (String.isBlank(insurance.Insurance_Company_Name__c)
	//			|| String.isBlank(insurance.Insurance_Agent_Phone_Number__c)
	//			|| String.isBlank(insurance.Insurance_Policy_Number__c)
	//		)
	//	);
	//}
}