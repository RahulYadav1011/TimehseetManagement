# TimehseetManagement


force-app/
└── main/
    └── default/
        ├── lwc/
        │   └── timeLogger/
        ├── classes/
        ├── objects/
        │   ├── Time_Log__c/
        │   ├── Project__c/
        │   └── Time_Log_Change_History__c/
        ├── flows/
        └── permissionsets/


Step 1:-  Data Model Design
Define custom objects and fields:

Entities:
User object 
* Project__c
    * Name
    * Description
* Time_Log__c
    * Date__c
    * Hours__c
    * Project__c (Lookup → Project__c)
    * Employee__c (Lookup → User)
* Tracking :- standrd time tracking







  Step 2: Development
  
  UI LWC Components
We’ll create the following LWCs:

 TimeLogEntryForm
For employees to log 8 hours daily.

Backend Logic
* Apex Classes for:
    * Saving time logs with validation
    *     * Sending notifications
* Scheduled Apex/Batch Job
    * Runs daily to check missing entries
    * Sends weekly notifications (Friday)
 







 step -3  Profiles & Permissions
* Access Control:
    * Only Managers and Assigned Employees can access the Time Log component.
    * Sharing Settings: Manager can share records.
* Custom Permission Sets:
    * Time_Tracking_Access
    * Manager_Time_Log_Access

Test Classes for Apex Code



Reports & Dashboards

created report for the daily and for the montly basis


