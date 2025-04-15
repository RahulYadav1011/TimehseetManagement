public class MissedTimeLogReminder implements Schedulable {
    public void execute(SchedulableContext sc) {
        Set<Id> allUsers = new Set<Id>();
        for (User u : [SELECT Id FROM User WHERE IsActive = true AND UserType = 'Standard']) {
            allUsers.add(u.Id);
        }

        Date today = Date.today();
        Date lastMonday = today.toStartOfWeek();
        Date lastFriday = lastMonday.addDays(4);

        Set<Id> usersWithEntries = new Set<Id>();
        for (AggregateResult ar : [
            SELECT Assigned_To__c FROM Time_Log__c
            WHERE Date__c >= :lastMonday AND Date__c <= :lastFriday
            GROUP BY Assigned_To__c
        ]) {
            usersWithEntries.add((Id)ar.get('Assigned_To__c'));
        }

        Set<Id> missingUsers = new Set<Id>(allUsers);
        missingUsers.removeAll(usersWithEntries);
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        for (User u : [SELECT Id, Email FROM User WHERE Id IN :missingUsers]) {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(new String[] { u.Email });
            mail.setSubject('Reminder: Missing Time Entries');
            mail.setPlainTextBody('You have not logged time for some or all of the past week. Please update your time entries.');
            emails.add(mail);
           
        }
        Messaging.sendEmail( emails);
    }
}