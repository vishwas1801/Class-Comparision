public with sharing class ApplicationTriggerController {

	@TestVisible
	private ApplicationDataPopulatorInterface applicationDataPopulator {
		get {
			if(this.applicationDataPopulator == null){
				this.applicationDataPopulator = new ApplicationDataPopulator();
			}
			return this.applicationDataPopulator;
		}
		set;
	}

	public ApplicationTriggerController(){}

	public void beforeInsert(List<Application__c> applications){
		applicationDataPopulator.populateDataOnNewApplications(applications);
	}
}