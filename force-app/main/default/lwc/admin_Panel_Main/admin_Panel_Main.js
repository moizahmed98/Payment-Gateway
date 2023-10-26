import { LightningElement, track } from 'lwc';
import StripeAdminAuth from '@salesforce/apex/AdminAuthenticationController.StripeAdminAuth';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class TabExample extends LightningElement {
    @track selectedMenuItem = null;
    @track prevMerchant = false;    
    
    handleOnselect(event) {
        var authtabContent = this.template.querySelector('[data-id="authorizeNetContentId"]');
        var skrilltabContent = this.template.querySelector('[data-id="skrillContentId"]');
        var stripetabContent = this.template.querySelector('[data-id="stripeContentId"]');
        var squaretabContent = this.template.querySelector('[data-id="squareContentId"]');
        var gPtabContent = this.template.querySelector('[data-id="globalPaymentontentId"]');
        this.selectedMenuItem = event.detail.value; 
        const selectedItemValue = event.detail.value;
        
       
        
        if(selectedItemValue === 'authorizeNetId')
        {
            
           
            authtabContent.classList.remove("slds-hide");
            authtabContent.classList.add("slds-show");
            stripetabContent.classList.add("slds-hide");
            skrilltabContent.classList.add("slds-hide");
            squaretabContent.classList.add("slds-hide");
            gPtabContent.classList.add("slds-hide");
            
            
        }
        else if(selectedItemValue === 'skrillId')
        {
           
            
            skrilltabContent.classList.remove("slds-hide");
            skrilltabContent.classList.add("slds-show");
            squaretabContent.classList.add("slds-hide");
            gPtabContent.classList.add("slds-hide");
            stripetabContent.classList.add("slds-hide");
            authtabContent.classList.add("slds-hide");
        }
        else if(selectedItemValue === 'stripetabId')
        {
            
            
            stripetabContent.classList.remove("slds-hide");
            stripetabContent.classList.add("slds-show");
            squaretabContent.classList.add("slds-hide");
            gPtabContent.classList.add("slds-hide");
            authtabContent.classList.add("slds-hide");
            skrilltabContent.classList.add("slds-hide");
        }
        else if(selectedItemValue === 'squareId')
        {
         
            
            squaretabContent.classList.remove("slds-hide");
            squaretabContent.classList.add("slds-show");
            gPtabContent.classList.add("slds-hide");
            authtabContent.classList.add("slds-hide");
            skrilltabContent.classList.add("slds-hide");
            stripetabContent.classList.add("slds-hide");
            
        }
        else if(selectedItemValue === 'globalPaymentId')
        {
            
          
            gPtabContent.classList.remove("slds-hide");
            gPtabContent.classList.add("slds-show");
            authtabContent.classList.add("slds-hide");
            skrilltabContent.classList.add("slds-hide");
            stripetabContent.classList.add("slds-hide");
            squaretabContent.classList.add("slds-hide");
        }
    }

    tabonclick(event)
    {
        const currentTabId = event.currentTarget.getAttribute('data-id');
        
   
        
        
        var authorizeNetTab = this.template.querySelector('[data-id="authorizeNetId"]');
        var skrillTab = this.template.querySelector('[data-id="skrillId"]');
        var stripeTab = this.template.querySelector('[data-id="stripetabId"]');
        var squareTab = this.template.querySelector('[data-id="squareId"]');
        var globalPaymentTab = this.template.querySelector('[data-id="globalPaymentId"]');

        var authtabContent = this.template.querySelector('[data-id="authorizeNetContentId"]');
        var skrilltabContent = this.template.querySelector('[data-id="skrillContentId"]');
        var stripetabContent = this.template.querySelector('[data-id="stripeContentId"]');
        var squaretabContent = this.template.querySelector('[data-id="squareContentId"]');
        var gPtabContent = this.template.querySelector('[data-id="globalPaymentontentId"]');

        if(currentTabId === 'authorizeNetId')
        {
            authorizeNetTab.classList.add("slds-is-active");
            skrillTab.classList.remove("slds-is-active");
            stripeTab.classList.remove("slds-is-active");
            squareTab.classList.remove("slds-is-active");
            globalPaymentTab.classList.remove("slds-is-active");



            authtabContent.classList.remove("slds-hide");
            authtabContent.classList.add("slds-show");
            stripetabContent.classList.add("slds-hide");
            skrilltabContent.classList.add("slds-hide");
            squaretabContent.classList.add("slds-hide");
            gPtabContent.classList.add("slds-hide");
            
            
        }
        else if(currentTabId === 'skrillId')
        {
            authorizeNetTab.classList.remove("slds-is-active");
            stripeTab.classList.remove("slds-is-active");
            squareTab.classList.remove("slds-is-active");
            globalPaymentTab.classList.remove("slds-is-active");
            skrillTab.classList.add("slds-is-active");

            skrilltabContent.classList.remove("slds-hide");
            skrilltabContent.classList.add("slds-show");
            squaretabContent.classList.add("slds-hide");
            gPtabContent.classList.add("slds-hide");
            stripetabContent.classList.add("slds-hide");
            authtabContent.classList.add("slds-hide");
        }
        else if(currentTabId === 'stripetabId')
        {
            stripeTab.classList.add("slds-is-active");
            authorizeNetTab.classList.remove("slds-is-active");
            squareTab.classList.remove("slds-is-active");
            globalPaymentTab.classList.remove("slds-is-active");
            skrillTab.classList.remove("slds-is-active");

            stripetabContent.classList.remove("slds-hide");
            stripetabContent.classList.add("slds-show");
            squaretabContent.classList.add("slds-hide");
            gPtabContent.classList.add("slds-hide");
            authtabContent.classList.add("slds-hide");
            skrilltabContent.classList.add("slds-hide");
        }
        else if(currentTabId === 'squareId')
        {
            squareTab.classList.add("slds-is-active");
            stripeTab.classList.remove("slds-is-active");
            authorizeNetTab.classList.remove("slds-is-active");
            globalPaymentTab.classList.remove("slds-is-active");
            skrillTab.classList.remove("slds-is-active");

            squaretabContent.classList.remove("slds-hide");
            squaretabContent.classList.add("slds-show");
            gPtabContent.classList.add("slds-hide");
            authtabContent.classList.add("slds-hide");
            skrilltabContent.classList.add("slds-hide");
            stripetabContent.classList.add("slds-hide");
            
        }
        else if(currentTabId === 'globalPaymentId')
        {
            globalPaymentTab.classList.add("slds-is-active");
            squareTab.classList.remove("slds-is-active");
            stripeTab.classList.remove("slds-is-active");
            authorizeNetTab.classList.remove("slds-is-active");
            skrillTab.classList.remove("slds-is-active");

            gPtabContent.classList.remove("slds-hide");
            gPtabContent.classList.add("slds-show");
            authtabContent.classList.add("slds-hide");
            skrilltabContent.classList.add("slds-hide");
            stripetabContent.classList.add("slds-hide");
            squaretabContent.classList.add("slds-hide");
        }
        
    }
//store input value of merchant name
    @track merchantName;
    merchantNameinput(event) {
        console.log('thi is inout :'+event.target.value);
  this.merchantName = event.target.value;
  console.log(this.merchantName);
}
//store input value of secret key 
@track secretKey;
secretKeyinput(event) {
    console.log('thi is inout :'+event.target.value);
this.secretKey = event.target.value;
console.log(this.secretKey);
}
//store input value of publishable key
@track publishKey;
publishKeyinput(event) {
    console.log('thi is inout :'+event.target.value);
this.publishKey = event.target.value;
console.log(this.publishKey);
}

@track resultresponse;
callApexMethod() {
    StripeAdminAuth({ 
        stripeMerchantName: this.merchantName,
        stripeSecretApiKey: this.secretKey,
        stripePublishableApiKey: this.publishKey
            })
                .then(result => {
                    console.log('this is result'+result[0]);
                    this.resultresponse = result;
                    
                    console.log('this is result stringify :'+ JSON.stringify(this.resultresponse));
                    if (result === 'Success') {
                        
                        // Show a success toast message
                        const evt = new ShowToastEvent({
                            title: 'Success',
                            message: 'Apex method was successful',
                            variant: 'success',
                        });
                        this.dispatchEvent(evt);
                    } else {
                        // Handle other cases as needed
                    }
                })
                .catch(error => {
                    // Handle errors
                    console.error(error);
                });
        }
}