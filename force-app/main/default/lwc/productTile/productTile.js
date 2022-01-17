import { LightningElement, api, track} from 'lwc';
import PRODUCT_OBJECT from '@salesforce/schema/Product_c__c';
import NAME_FIELD from '@salesforce/schema/Product_c__c.Name';

export default class ProductTile extends LightningElement {
    @api product;

    @track isCartModal = false;
    openCartModal() {
        this.isCartModal = true;
    }
    closeCartModal() {
        this.isCartModal = false;
    }

    // Flexipage provides recordId and objectApiName
    @api objectApiName = PRODUCT_OBJECT.objectApiName;

    selectHandler(event) {
        // Prevents the anchor element from navigating to a URL.
        event.preventDefault();

        const selectedEvent = new CustomEvent('selected', { detail: this.product.Id });
        console.log(this.product.Id);
        // Dispatches the event.
        this.dispatchEvent(selectedEvent);
    }
}