import { LightningElement, api, track} from 'lwc';
import TYPE_FIELD from '@salesforce/schema/Product_c__c.Type__c';
import FAMILY_FIELD from '@salesforce/schema/Product_c__c.Family__c';
import PRODUCT_OBJECT from '@salesforce/schema/Product_c__c';
import NAME_FIELD from '@salesforce/schema/Product_c__c.Name';
import DESCRIPTION_FIELD from '@salesforce/schema/Product_c__c.Description__c';
import IMAGE_FIELD from '@salesforce/schema/Product_c__c.Image__c';
import PRICE_FIELD from '@salesforce/schema/Product_c__c.Price__c';

export default class ProductTile extends LightningElement {
    @api product;

    @track isCartModal = false;
    openCartModal() {
        this.isCartModal = true;
    }
    closeCartModal() {
        this.isCartModal = false;
    }

    nameField = NAME_FIELD;

    // Flexipage provides recordId and objectApiName
    @api objectApiName = PRODUCT_OBJECT.objectApiName;
}