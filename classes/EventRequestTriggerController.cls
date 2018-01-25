public with sharing class EventRequestTriggerController {
	@TestVisible
	private EventRequestStageUpdateHandlerInterface stageUpdateHandler {
	    get {
	        if(this.stageUpdateHandler == null){
	            this.stageUpdateHandler = new EventRequestStageUpdateHandler();
	        }
	        return stageUpdateHandler;
	    }
	    set;
	}

	public void afterInsert(List<Event_Request__c> newEventRequests){
		stageUpdateHandler.processEventRequest(newEventRequests);
	}
}