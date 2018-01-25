/****************************************************************
 Name: LOR_AuraService
============================================================
Author: 
Purpose: LOR for Aura Service
============================================================

****************************************************************/
public with sharing class LOR_AuraService {

	@TestVisible private static ApplicationDAO applicationDA = new ApplicationDataAccessor();
	@TestVisible private static ApplicantDAO applicantDA = new ApplicantDataAccessor();
	@TestVisible private static DisasterDAO disasterDA = new DisasterDataAccessor();
	@TestVisible private static LoanDAO loanDA = new LoanDataAccessor();
	@TestVisible private static PropertyDAO propertyDA = new PropertyDataAccessor();
	@TestVisible private static AssetIncomesDAO assetIncomesDA = new AssetIncomesDataAccessor();
	@TestVisible private static IRSTranscriptsDAO irsTranscriptsDA = new IRSTranscriptsDataAccessor();
	@TestVisible private static InsuranceDAO insuranceDA = new InsuranceDataAccessor();
	@TestVisible private static ProcessingApplicationReviewDAO processingApplicationReviewDA = new ProcessingApplicationReviewDataAccessor();
	@TestVisible private static OtherAssistanceDAO otherAssistanceDA = new OtherAssistanceDataAccessor();

	@AuraEnabled
	public static Application__c getApplicationById(Id applicationId){
		try {
			return applicationDA.getApplicationById(applicationId);
		} catch(QueryException e){
			throw new AuraHandledException(e.getMessage());
		}
	}

	@AuraEnabled
	public static List<Applicant__c> getApplicantsAndRelatedContactsByApplicationId(Id applicationId){
		try {
			return applicantDA.getApplicantsAndRelatedContactsByApplicationId(applicationId);
		} catch(QueryException e){
			throw new AuraHandledException(e.getMessage());
		}
	}

	@AuraEnabled
	public static List<Loan__c> getLoansByApplicationId(Id applicationId){
		try {
			return loanDA.getLoansByApplicationId(applicationId);
		} catch(QueryException e){
			throw new AuraHandledException(e.getMessage());
		}
	}

	@AuraEnabled
	public static Disaster__c getDisasterById(Id disasterId){
		try {
			return disasterDA.getDisasterById(disasterId);
		} catch(QueryException e){
			throw new AuraHandledException(e.getMessage());
		}
	}

	@AuraEnabled
	public static List<Property__c> getDamagedPropertiesAndLossVerificationsByApplicationId(Id applicationId){
		try {
			return propertyDA.getDamagedPropertiesAndLossVerificationsByApplicationId(applicationId);
		} catch(QueryException e) {
			throw new AuraHandledException(e.getMessage());
		}
	}

	@AuraEnabled
	public static List<Asset_Incomes__c> getAssetIncomesByApplicationId(Id applicationId){
		try {
			return assetIncomesDA.getAssetIncomesByApplicationId(applicationId);
		} catch(QueryException e) {
			throw new AuraHandledException(e.getMessage());
		}
	}

	@AuraEnabled
	public static List<IRS_Transcripts__c> getIRSTranscriptsByApplicationId(Id applicationId){
		try {
			return irsTranscriptsDA.getIRSTranscriptsByApplicationId(applicationId);
		} catch(QueryException e) {
			throw new AuraHandledException(e.getMessage());
		}
	}

	@AuraEnabled
	public static List<Insurance__c> getActiveInsurancePoliciesByApplicationId(Id applicationId){
		try {
			return insuranceDA.getActiveInsuranceByApplicationId(applicationId);
		} catch(QueryException e) {
			throw new AuraHandledException(e.getMessage());
		}
	}

	@AuraEnabled
	public static List<Processing_Application_Review__c> getProcessingApplicationReviewsByApplicationId(Id applicationId){
		try {
			return processingApplicationReviewDA.getProcessingApplicationReviewsByAppIds(new List<Id>{applicationId});
		} catch(QueryException e) {
			throw new AuraHandledException(e.getMessage());
		}
	}

	@AuraEnabled
	public static List<Other_Assistance__c> getOtherAssistancebyApplicationId(Id applicationId){
		try {
			return otherAssistanceDA.getOtherAssistancebyApplicationId(applicationId);
		} catch(QueryException e) {
			throw new AuraHandledException(e.getMessage());
		}
	}

	@AuraEnabled
	public static List<String> getPicklistOptions(String sObjectDevName, String fieldDevName){
		Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
		List<Schema.PicklistEntry> picklistEntries = schemaMap.get(sObjectDevName).getDescribe().fields.getMap().get(fieldDevName).getDescribe().getPicklistValues();

		List<String> picklistOptions = new List<String>();
		for(Schema.PicklistEntry entry : picklistEntries){
			picklistOptions.add(entry.getLabel());
		}
		return picklistOptions;
	}
}