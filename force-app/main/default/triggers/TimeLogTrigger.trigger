trigger TimeLogTrigger on Time_Log__c (before insert, before update) {
    if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
        TimeLogTriggerHelper.timeSheetValidation(trigger.new);
    }
}