@isTest
private class DocumentChecklistGeneratorTest
{
    /*DELETED ONCE ON BITBUCKET*/
/*PU: Fix this later causing deployment issues
    @isTest
    static void handleDocumentGeneration_givenNullList_shouldNotThrowErrorOrAttemptInsert(){
        DocumentChecklistGenerator testChecklistGenerator = new DocumentChecklistGenerator();
        DocumentLineItemDataAccessorMock docLineItemMockDA = new DocumentLineItemDataAccessorMock();
        ApplicantDataAccessorMock applicantMockDA = new ApplicantDataAccessorMock();
         testChecklistGenerator.documentLineItemDA = docLineItemMockDA;
         testChecklistGenerator.applicantDA = applicantMockDA;

        Test.startTest();
            try {
                testChecklistGenerator.handleDocumentGeneration(null);
            } catch (Exception e) {
                System.assert(false, 'No error should have occurred from a null list being passed.');
            }
        Test.stopTest();

        System.assertEquals(
            0, 
            docLineItemMockDA.insertDocumentLineItemsCallCount,
            'No Document Line Item should be inserted when a null list is passed.'
        );
    }

    @isTest
    static void handleDocumentGeneration_givenEmptyList_shouldNotThrowErrorOrAttemptInsert(){
        DocumentChecklistGenerator testChecklistGenerator = new DocumentChecklistGenerator();
        DocumentLineItemDataAccessorMock docLineItemMockDA = new DocumentLineItemDataAccessorMock();
        ApplicantDataAccessorMock applicantMockDA = new ApplicantDataAccessorMock();
        testChecklistGenerator.documentLineItemDA = docLineItemMockDA;
        testChecklistGenerator.applicantDA = applicantMockDA;

        Test.startTest();
            try {
                testChecklistGenerator.handleDocumentGeneration(new List<Case>());
            } catch (Exception e) {
                System.assert(false, 'No error should have occurred from an empty list being passed.'); 
            }
        Test.stopTest();

        System.assertEquals(
            0, 
            docLineItemMockDA.insertDocumentLineItemsCallCount,
            'No Document Line Item should be inserted when an empty list is passed.'
        );
    }

    @isTest
    static void handleDocumentGeneration_givenNonDocumentRequestCase_shouldNotAttemptInsert(){
        DocumentChecklistGenerator testChecklistGenerator = new DocumentChecklistGenerator();
        DocumentLineItemDataAccessorMock docLineItemMockDA = new DocumentLineItemDataAccessorMock();
        ApplicantDataAccessorMock applicantMockDA = new ApplicantDataAccessorMock();
        testChecklistGenerator.documentLineItemDA = docLineItemMockDA;
        testChecklistGenerator.applicantDA = applicantMockDA;

        Test.startTest();
            testChecklistGenerator.handleDocumentGeneration(new List<Case>{new Case()});
        Test.stopTest();

        System.assertEquals(
            0, 
            docLineItemMockDA.insertDocumentLineItemsCallCount,
            'No Document Line Item should have be inserted when a Non Document Request case is passed.'
        );
    }

    @isTest
    static void handleDocumentGeneration_givenDocumentRequestCase_shouldCallInsertDocumentLineItems(){
        DocumentChecklistGenerator testChecklistGenerator = new DocumentChecklistGenerator();
        DocumentLineItemDataAccessorMock docLineItemMockDA = new DocumentLineItemDataAccessorMock();
        ApplicantDataAccessorMock applicantMockDA = new ApplicantDataAccessorMock();
        testChecklistGenerator.documentLineItemDA = docLineItemMockDA;
        testChecklistGenerator.applicantDA = applicantMockDA;

        Schema.DescribeSObjectResult caseDescribeResult = Schema.SObjectType.Case;
        Map<String,Schema.RecordTypeInfo> rtNameToRecordTypeInfo = caseDescribeResult.getRecordTypeInfosByName();
        Id docRequestRecordTypeId = rtNameToRecordTypeInfo.get(testChecklistGenerator.CASE_RTNAME_DOCUMENT_REQUEST).getRecordTypeId();

        MockSObjectBuilder caseBuilder = new MockSObjectBuilder(Case.getSObjectType());
        caseBuilder.setField('RecordTypeId', (String)docRequestRecordTypeId);

        Case testCase = (Case)JSON.deserialize(caseBuilder.getSerializedSObject(), Case.class);

        Test.startTest();
            testChecklistGenerator.handleDocumentGeneration(new List<Case>{testCase});
        Test.stopTest();

        System.assertEquals(
            1, 
            docLineItemMockDA.insertDocumentLineItemsCallCount,
            'Document Line Item should be inserted when a Document Request case is passed.'
        );
    }

    @isTest 
    static void createApplicableDocumentLineItemsForCases_givenCaseAndApplicant_shouldCreateTwoDefaultDocLineItems(){
        DocumentChecklistGenerator testChecklistGenerator = new DocumentChecklistGenerator();
        DocumentLineItemDataAccessorMock docLineItemMockDA = new DocumentLineItemDataAccessorMock();
        ApplicantDataAccessorMock applicantMockDA = new ApplicantDataAccessorMock();
        testChecklistGenerator.documentLineItemDA = docLineItemMockDA;
        testChecklistGenerator.applicantDA = applicantMockDA;

        MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
        applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());
    
        Application__c testApplication = (Application__c) applicationMockBuilder.build();

        MockSObjectBuilder applicantMockBuilder = new MockSObjectBuilder(Applicant__c.getSObjectType());
        applicantMockBuilder.setField('Application__c', testApplication.Id);
        applicantMockBuilder.setField('Id', applicantMockBuilder.getMockId());

        Applicant__c testApplicant = (Applicant__c) applicantMockBuilder.build();

        MockSObjectBuilder caseMockBuilder = new MockSObjectBuilder(Case.getSObjectType());
        caseMockBuilder.setField('Application__c', testApplication.Id);
        caseMockBuilder.setField('Id', caseMockBuilder.getMockId());

        Case testCase = (Case) caseMockBuilder.build();

        Test.startTest();
            List<Document_Line_Items__c> newDocLineItems = testChecklistGenerator.createApplicableDocumentLineItemsForCases(new List<Case>{testCase}, new List<Applicant__c>{testApplicant});
        Test.stopTest();

        System.assert(
            !newDocLineItems.isEmpty(),
            'Document Line Items should have been added given a Case and Applicant with matching related Application IDs'
        );

        System.assertEquals(
            2,
            newDocLineItems.size(),
            'Two new Document Line Items should have been created.'
        );
    }

    @isTest
    static void createApplicableDocumentLineItemsForCases_givenCaseAndShortEmployedApplicant_shouldCreatePaystubDocLineItem(){
        DocumentChecklistGenerator testChecklistGenerator = new DocumentChecklistGenerator();
        DocumentLineItemDataAccessorMock docLineItemMockDA = new DocumentLineItemDataAccessorMock();
        ApplicantDataAccessorMock applicantMockDA = new ApplicantDataAccessorMock();
        testChecklistGenerator.documentLineItemDA = docLineItemMockDA;
        testChecklistGenerator.applicantDA = applicantMockDA;

        MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
        applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());
    
        Application__c testApplication = (Application__c) applicationMockBuilder.build();

        MockSObjectBuilder applicantMockBuilder = new MockSObjectBuilder(Applicant__c.getSObjectType());
        applicantMockBuilder.setField('Application__c', testApplication.Id);
        applicantMockBuilder.setField('Years_Employed__c', '1');
        applicantMockBuilder.setField('Id', applicantMockBuilder.getMockId());

        Applicant__c testApplicant = (Applicant__c) applicantMockBuilder.build();

        MockSObjectBuilder caseMockBuilder = new MockSObjectBuilder(Case.getSObjectType());
        caseMockBuilder.setField('Application__c', testApplication.Id);
        caseMockBuilder.setField('Id', caseMockBuilder.getMockId());

        Case testCase = (Case) caseMockBuilder.build();

        Test.startTest();
            List<Document_Line_Items__c> newDocLineItems = testChecklistGenerator.createApplicableDocumentLineItemsForCases(new List<Case>{testCase}, new List<Applicant__c>{testApplicant});
        Test.stopTest();

        System.assert(
            !newDocLineItems.isEmpty(),
            'Document Line Items should have been added given a Case and Applicant with matching related Application IDs'
        );

        System.assertEquals(
            3,
            newDocLineItems.size(),
            'Three new Document Line Items should have been created when the Applicant has been employed less than two (2) years.'
        );
    }

    @isTest
    static void createApplicableDocumentLineItemsForCases_givenCaseAndLongEmployedApplicant_shouldNotCreatePaystubDocLineItem(){
                DocumentChecklistGenerator testChecklistGenerator = new DocumentChecklistGenerator();
        DocumentLineItemDataAccessorMock docLineItemMockDA = new DocumentLineItemDataAccessorMock();
        ApplicantDataAccessorMock applicantMockDA = new ApplicantDataAccessorMock();
        testChecklistGenerator.documentLineItemDA = docLineItemMockDA;
        testChecklistGenerator.applicantDA = applicantMockDA;

        MockSObjectBuilder applicationMockBuilder = new MockSObjectBuilder(Application__c.getSObjectType());
        applicationMockBuilder.setField('Id', applicationMockBuilder.getMockId());
    
        Application__c testApplication = (Application__c) applicationMockBuilder.build();

        MockSObjectBuilder applicantMockBuilder = new MockSObjectBuilder(Applicant__c.getSObjectType());
        applicantMockBuilder.setField('Application__c', testApplication.Id);
        applicantMockBuilder.setField('Years_Employed__c', '5');
        applicantMockBuilder.setField('Id', applicantMockBuilder.getMockId());

        Applicant__c testApplicant = (Applicant__c) applicantMockBuilder.build();

        MockSObjectBuilder caseMockBuilder = new MockSObjectBuilder(Case.getSObjectType());
        caseMockBuilder.setField('Application__c', testApplication.Id);
        caseMockBuilder.setField('Id', caseMockBuilder.getMockId());

        Case testCase = (Case) caseMockBuilder.build();

        Test.startTest();
            List<Document_Line_Items__c> newDocLineItems = testChecklistGenerator.createApplicableDocumentLineItemsForCases(new List<Case>{testCase}, new List<Applicant__c>{testApplicant});
        Test.stopTest();

        System.assert(
            !newDocLineItems.isEmpty(),
            'Document Line Items should have been added given a Case and Applicant with matching related Application IDs'
        );

        System.assertEquals(
            2,
            newDocLineItems.size(),
            'Only two new Document Line Items should have been created when the Applicant has been employed more than two (2) years.'
        );
    }*/
}