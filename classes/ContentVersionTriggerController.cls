public with sharing class ContentVersionTriggerController {

	@TestVisible
	private ContentDocumentLinkerInterface contentDocumentLinker {
		get {
			if(this.contentDocumentLinker == null){
				this.contentDocumentLinker = new ContentDocumentLinker();
			}
			return this.contentDocumentLinker;
		}
		set;
	}

	public ContentVersionTriggerController(){}

	public void beforeUpdate(List<ContentVersion> newVersions, Map<Id,ContentVersion> oldVersionsMap){
		contentDocumentLinker.handleDocumentLinks(newVersions, oldVersionsMap);
	}
}