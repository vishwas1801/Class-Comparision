@isTest
private class ContentVersionTriggerControllerTest
{
	@isTest
	static void beforeUpdate_givenAnyData_shouldCallHandleDocumentLinks(){
		List<ContentVersion> newContentVersions = new List<ContentVersion>();
		Map<Id,ContentVersion> oldContentVersionsMap = new Map<Id,ContentVersion>();

		ContentDocumentLinkerMock linkerMock = new ContentDocumentLinkerMock();

		Test.startTest();
			ContentVersionTriggerController testController = new ContentVersionTriggerController();
			testController.contentDocumentLinker = linkerMock;
			testController.beforeUpdate(newContentVersions, oldContentVersionsMap);
		Test.stopTest();

		System.assertEquals(1, linkerMock.handleDocumentLinksCallCount);
	}

	public class ContentDocumentLinkerMock implements ContentDocumentLinkerInterface {
		public Integer handleDocumentLinksCallCount { get; private set; }

		public ContentDocumentLinkerMock(){
			handleDocumentLinksCallCount = 0;
		}

		public void handleDocumentLinks(List<ContentVersion> newVersions, Map<Id,ContentVersion> oldVersionsMap){
			handleDocumentLinksCallCount++;
		}
	}
}