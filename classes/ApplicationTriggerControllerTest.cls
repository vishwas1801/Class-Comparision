@isTest
private class ApplicationTriggerControllerTest
{
	@isTest
	static void beforeInsert_givenNonNullList_shouldCallPopulateDateOnNewApplications(){
		ApplicationTriggerController testController = new ApplicationTriggerController();
		ApplicationDataPopulatorMock mockApplicationDataPopulator = new ApplicationDataPopulatorMock();
		testController.applicationDataPopulator = mockApplicationDataPopulator;

		List<Application__c> testApplications = new List<Application__c>();

		Test.startTest();
			testController.beforeInsert(testApplications);
		Test.stopTest();

		System.assertEquals(1, mockApplicationDataPopulator.populateDataOnNewApplicationsCallCount);
	}

	public class ApplicationDataPopulatorMock implements ApplicationDataPopulatorInterface {
		public Integer populateDataOnNewApplicationsCallCount;

		public ApplicationDataPopulatorMock(){
			populateDataOnNewApplicationsCallCount = 0;
		}

		public void populateDataOnNewApplications(List<Application__c> applications){
			populateDataOnNewApplicationsCallCount++;
		}
	}
}