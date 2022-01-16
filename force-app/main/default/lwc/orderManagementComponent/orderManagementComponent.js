import { LightningElement, api, wire, track } from 'lwc';
import getAccountData from '@salesforce/apex/functionsOfOrderApp.getAccountData';

// Importing Apex Class method
import saveProductRecord from '@salesforce/apex/functionsOfOrderApp.saveProductRecord';

// importing to show toast notifictions
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

// imports for Product creation
import NAME_FIELD from '@salesforce/schema/Product_c__c.Name';
import DESCRIPTION_FIELD from '@salesforce/schema/Product_c__c.Description__c';
import IMAGE_FIELD from '@salesforce/schema/Product_c__c.Image__c';
import PRICE_FIELD from '@salesforce/schema/Product_c__c.Price__c';
import { createRecord } from 'lightning/uiRecordApi';

// For picklist values
import TypeField from '@salesforce/schema/Product_c__c.Type__c';
import TYPE_FIELD from '@salesforce/schema/Product_c__c.Type__c';
import FamilyField from '@salesforce/schema/Product_c__c.Family__c';
import FAMILY_FIELD from '@salesforce/schema/Product_c__c.Family__c';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import PRODUCT_OBJECT from '@salesforce/schema/Product_c__c';

import searchProduct from '@salesforce/apex/functionsOfOrderApp.searchProduct';


export default class orderManagementComponent extends LightningElement {

    @api recordId;
    @track accounts;
    @track error;


    @wire(getAccountData, { value: '$recordId' })
    wiredAccounts({ data, error }) {
        if (data) {
            this.accounts = data;
            this.error = undefined;
        } else {
            this.accounts = undefined;
            this.error = error;
        }
    }

    // Modal for Create Product
    @track isModalOpen = false;
    openModal() {
        // to open modal set isModalOpen tarck value as true
        this.isModalOpen = true;
    }
    closeModal() {
        // to close modal set isModalOpen tarck value as false
        this.isModalOpen = false;
    }

    // Modal for Cart
    @track isCartModal = false;
    openCartModal() {
        this.isCartModal = true;
    }
    closeCartModal() {
        this.isCartModal = false;
    }


    // Product__c creation

    // this object have record information

    @track name = NAME_FIELD;
    @track description = DESCRIPTION_FIELD;
    @track image = IMAGE_FIELD;
    @track price = PRICE_FIELD;
    @track type = TYPE_FIELD;
    @track family = FAMILY_FIELD;

    myFields = [NAME_FIELD,DESCRIPTION_FIELD,IMAGE_FIELD,PRICE_FIELD,TYPE_FIELD,FAMILY_FIELD];
    productObject = PRODUCT_OBJECT;

    handleSuccess() {
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Product created',
                variant: 'success',
            }),
        );
        this.isModalOpen = false;
    }

    // For PickList
    // Type__c

    @wire(getObjectInfo, { objectApiName: PRODUCT_OBJECT })
    productInfo;

    @wire(getPicklistValues,
        {
            recordTypeId: '$productInfo.data.defaultRecordTypeId',
            fieldApiName: TypeField,
        }
    )
    leadSourceValues;

    // Family__c

    @wire(getPicklistValues,
        {
            recordTypeId: '$productInfo.data.defaultRecordTypeId',
            fieldApiName: FamilyField
        }
    )
    leadSourceValuesFamily;


    // List of records with search

    @track searchTerm = '';
    @wire(searchProduct, {searchTerm: '$searchTerm'})
	products;


    handleSearchTermChange(event) {
		// Debouncing this method: do not update the reactive property as
		// long as this function is being called within a delay of 300 ms.
		// This is to avoid a very large number of Apex method calls.
		window.clearTimeout(this.delayTimeout);
		const searchTerm = event.target.value;
		// eslint-disable-next-line @lwc/lwc/no-async-operation
		this.delayTimeout = setTimeout(() => {
			this.searchTerm = searchTerm;
		}, 300);
	}

    get hasResults() {
		return (this.products.data.length > 0);
	}


    /*
    @track prodRecord = {
        NAME_FIELD : this.name,
        Description__c : this.description,
        Family__c : this.family,
        Image__c : this.image,
        Type__c : this.type,
        Price__c : this.price
    };
    

    handleNameChange(event) {
        this.prodRecord.Name = event.target.value;
        window.console.log('Name ==> '+this.prodRecord.Name);
    }

    handleDescriptionChange(event) {
        this.prodRecord.Description = event.target.value;
        window.console.log('Description ==> '+this.prodRecord.Description);
    }

    handleTypeChange(event) {
        this.prodRecord.Type = event.target.value;
        window.console.log('Type ==> '+this.prodRecord.Type);
    }

    handleFamilyChange(event) {
        this.prodRecord.Family = event.target.value;
        window.console.log('Family ==> '+this.prodRecord.Family);
    }

    handleImageChange(event) {
        this.prodRecord.Image = event.target.value;
        window.console.log('Image ==> '+this.prodRecord.Image);
    }

    handlePriceChange(event) {
        this.prodRecord.Price = event.target.value;
        window.console.log('Price ==> '+this.prodRecord.Price);
    }


    handleSave() {
        const fields = {};
        fields[NAME_FIELD.fieldApiName] = this.prodRecord.Name;
        const recordInput = { apiName: PRODUCT_OBJECT.objectApiName, fields };
        createRecord(recordInput)
            .then(account => {
                this.accountId = account.id;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Account created',
                        variant: 'success',
                    }),
                );
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
            });
        /*saveProductRecord({ obj: this.prodRecord})
        .then(result => {
            console.log('succes');
            this.message = result;
            console.log('result ===> '+result);

            // Show success messsage
            this.dispatchEvent(new ShowToastEvent({
                    title: 'Success!!',
                    message: 'Product Created Successfully!!',
                    variant: 'success',
                }),
            );
        })
        .catch(error => {
            console.log('error ===> ' + this.error);
            this.error = error.message;
        });
    }
    */
}