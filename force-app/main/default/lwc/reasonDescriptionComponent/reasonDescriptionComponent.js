import { LightningElement, api } from 'lwc';
import sendCallout from '@salesforce/apex/ReasonDescriptionController.getReason';
import {ShowToastEvent} from "lightning/platformShowToastEvent";

export default class ReasonDescriptionComponent extends LightningElement {
@api recordId;
    getReason(){
        sendCallout({recordId: this.recordId}).then(()=>{
            this.showNotification('Success','Case updated', 'success');
        }).catch((error) => {
            console.log(error.body.message);
            console.log(error.body.stack);
            this.showNotification('Error', 'Error while making callout.','error');
        });
    }

    showNotification(title, message, variant) {
        const evt = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(evt);
    }
}