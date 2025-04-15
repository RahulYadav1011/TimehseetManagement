import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class TimeLogEntryForm extends LightningElement {
    handleSuccess() {
        this.dispatchEvent(
          new ShowToastEvent({
            title: 'Success',
            message: 'Time log submitted successfully.',
            variant: 'success'
          })
        );
      }
    
      handleSubmit(event) {
        const fields = event.detail.fields;
        if (fields.Hours__c > 8) {
          event.preventDefault();
          this.dispatchEvent(
            new ShowToastEvent({
              title: 'Validation Error',
              message: 'You cannot log more than 8 hours in a day.',
              variant: 'error'
            })
          );
        } 
      }
}