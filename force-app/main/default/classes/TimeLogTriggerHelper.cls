public with sharing class TimeLogTriggerHelper {
    public static void timeSheetValidation(List<Time_Log__c> timelogs) {
        Map<Id, Date> employeeDateMap = new Map<Id, Date>();
        for (Time_Log__c log : timelogs) {
            if (log.Assigned_To__c != null && log.Date__c != null) {
                employeeDateMap.put(log.Assigned_To__c, log.Date__c);
            }
        }
    
        Map<String, Decimal> dailyTotals = new Map<String, Decimal>();
        for (AggregateResult result : [
            SELECT Assigned_To__c, Date__c, SUM(Hours__c) total
            FROM Time_Log__c
            WHERE Assigned_To__c IN :employeeDateMap.keySet()
            AND Date__c IN :employeeDateMap.values()
            GROUP BY Assigned_To__c, Date__c
        ]) {
            String key = result.get('Assigned_To__c') + '_' + result.get('Date__c');
            dailyTotals.put(key, (Decimal)result.get('total'));
        }
    
        for (Time_Log__c log : timelogs) {
            if (log.Assigned_To__c != null && log.Date__c != null) {
                String key = log.Assigned_To__c + '_' + log.Date__c;
                Decimal existingTotal = dailyTotals.get(key) != null ? dailyTotals.get(key) : 0;
                Decimal newTotal = existingTotal + log.Hours__c;
                if (newTotal > 8) {
                    log.addError('Total time logged for the day exceeds 8 hours.');
                }
            }
        }
    }
}