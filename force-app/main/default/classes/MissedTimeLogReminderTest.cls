@isTest
private class MissedTimeLogReminderTest {
    @isTest static void testExecuteReminder() {
        User u = TestUtils.createTestUser();

        Test.startTest();
        MissedTimeLogReminder job = new MissedTimeLogReminder();
        String jobId = System.schedule('Test Job', '0 0 12 ? * FRI', job);
        Test.stopTest();

        System.assertNotEquals(null, jobId, 'Scheduled job ID should not be null');
    }
}