@isTest
private class EventRequestTriggerControllerTest {
	
	@isTest static void afterInsert_givenAListOfEventRequests_shouldInvokeProcessEventRequest() {
		Event_Request__c testEventRequest = new Event_Request__c(Stage__c = 'Order CRB');
		EventRequestTriggerController controller = new EventRequestTriggerController();
		EventRequestStageUpdateHandlerMock mockHandler = new EventRequestStageUpdateHandlerMock();
		controller.stageUpdateHandler = mockHandler;
		Test.startTest();
			controller.afterInsert(new List<Event_Request__c>{testEventRequest});
		Test.stopTest();

		System.assertEquals(1,mockHandler.processEventRequestCallCount, 
			'processEventRequest method should have been called by in afterInsert method.'
		);	
	}
	
}