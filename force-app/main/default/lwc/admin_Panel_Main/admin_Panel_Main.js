import { LightningElement, track, wire } from 'lwc';
import StripeAdminAuth from '@salesforce/apex/AdminAuthenticationController.StripeAdminAuth';
import authorizeNetAdminAuth from '@salesforce/apex/AdminAuthenticationController.authorizeNetAdminAuth';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class TabExample extends LightningElement {
    @track selectedMenuItem = null;
    @track stripeprevMerchant = false;   
    @track authNetprevMerchant = false;    
    
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
    //store input value of merchant name//////////////////////////////////////////************input fileds of Authnet*******///////////////////////////////////////////////////////////////////////////////////////
   
    @track authNetemerchantName;
    authNetMerchantName(event) {
        console.log('thi is inout :'+event.target.value);
  this.authNetemerchantName = event.target.value;
  console.log(this.authNetemerchantName);
}
//store input value of login id 
@track authNetLoginId;
authNetloginIdinput(event) {
    console.log('thi is inout :'+event.target.value);
this.authNetLoginId = event.target.value;
console.log(this.authNetLoginId);
}
//store input value of transaction id
@track authNetTransactoinId;
authNetTransactionIdinput(event) {
    console.log('thi is inout :'+event.target.value);
this.authNetTransactoinId = event.target.value;
console.log(this.authNetTransactoinId);
}
//store input value of merchant name//////////////////////////////////////////************calling authent merchant authentication function*******///////////////////////////////////////////////////////////////////////////////////////
@track authNetcurrentstep = "1";
@track authNetProgressError = false;

authNetresponse;
error;
AuthNethandleButtonClick() {
   console.log('ftn is called');
   authorizeNetAdminAuth({  
    authorizeNetMerchantName: this.authNetemerchantName,
    authorizeNetApiLoginId: this.authNetLoginId,
    authorizeNetTransactionKey: this.authNetTransactoinId })
    .then(result => {
        // Handle the successful response
        console.log('this is the retiurned result 1  :'+JSON.stringify(result));
        console.log('this is the retiurned result 2 :'+result.messages.resultCode.toLowerCase());
       
        this.authNetresponse = result;
        this.error = null;
        this.authNetProgressError =false;
        this.authNetcurrentstep = "2";
 
        if(result.messages.resultCode != null && result.messages.resultCode.toLowerCase() == 'ok')
        {
            console.log('in else if ');
            this.authNetcurrentstep = "3";
            const evt = new ShowToastEvent({
                title: 'Success!',
                message: 'Authentication successful',
                variant: 'success',
            });
            this.dispatchEvent(evt);

                        
                    
        }
        // Handle the case where the authentication with Stripe resulted in an error
        else if(result.messages.resultCode != null && result.messages.resultCode.toLowerCase() == 'error' )
        {
            this.authNetcurrentstep = "3";
            console.log('in else if  : '+result.messages.text);
            this.authNetcurrentstep = "3";
            this.authNetProgressError =true;
            const evt = new ShowToastEvent({
                title: 'Error!',
                message: result.messages.message[0].text,
                variant: 'error',
                mode: 'dismissable'
            });
            this.dispatchEvent(evt);
            

        }
        console.log('final response that is retuned  : ');
       
    })
    .catch(error => {
        // Handle any errors
        console.log('in cach error ');
        this.authNetcurrentstep = "2";
        this.authNetProgressError = true;
        this.response = null;
        this.error = error;
    });
  }

//store input value of merchant name//////////////////////////////////////////************input fileds of stripe*******///////////////////////////////////////////////////////////////////////////////////////
    @track stripemerchantName;
    stripemerchantNameinput(event) {
        console.log('thi is inout :'+event.target.value);
  this.stripemerchantName = event.target.value;
  console.log(this.stripemerchantName);
}
//store input value of secret key 
@track stripesecretKey;
stripesecretKeyinput(event) {
    console.log('thi is inout :'+event.target.value);
this.stripesecretKey = event.target.value;
console.log(this.stripesecretKey);
}
//store input value of publishable key
@track stripepublishKey;
stripepublishKeyinput(event) {
    console.log('thi is inout :'+event.target.value);
this.stripepublishKey = event.target.value;
console.log(this.stripepublishKey);
}
////////////////////////////////////////////////////////////////////calling stripe merchant authenticatioin funtion ////////////////////////////////////////////////////////////////////////////////////////////////////

@track currentstep = "1";
@track stripeProgressError = false;

response;
error;
StripehandleButtonClick() {
   console.log('ftn is called'+ this.current_step);
    StripeAdminAuth({  
        stripeMerchantName: this.stripemerchantName,
        stripeSecretApiKey: this.stripesecretKey,
        stripePublishableApiKey: this.stripepublishKey })
    .then(result => {
        // Handle the successful response
        console.log('this is the retiurned result 1  :'+JSON.stringify(result));
        console.log('this is the retiurned result 2 :'+result.error);
        console.log('this is the retiurned result 3 :'+result.settings);
        this.response = result;
        this.error = null;
        this.stripeProgressError =false;
 
        if(result.settings != 'undefined' && result.settings != undefined )
        {
                        console.log('error is  null  and the display name is ');
                        console.log('this is the input merchant name : '+this.merchantName);

                        if(this.response.settings.dashboard.display_name === this.merchantName)
                        {
                            this.currentstep = "3";
                            this.stripeProgressError = false;
                            console.log('the  display name is correct and the merchant is authenticated');
                            const evt = new ShowToastEvent({
                                title: 'Success!',
                                message: 'Authentication successful',
                                variant: 'success',
                            });
                            this.dispatchEvent(evt);
                           
                        
                        }
                        else if(this.response.settings.dashboard.display_name != this.merchantName)
                        {   
                            this.currentstep = "3";
                            this.stripeProgressError = true;
                            console.log('display name is not correct : '+this.merchantName);
                            const evt = new ShowToastEvent({
                                title: 'Error!',
                                message: 'Merchant Name is Incorrect',
                                variant: 'error',
                                mode: 'dismissable'
                            });
                            this.dispatchEvent(evt);
                          

                        }
                    
        }
        // Handle the case where the authentication with Stripe resulted in an error
        else if(this.response.error !== 'undefined' && this.response.error !== undefined  )
        {
            this.currentstep = "2";
            console.log('error and current step is  : '+this.currentstep);
            console.log('error message  : '+this.response.error.message);
            const evt = new ShowToastEvent({
                title: 'Error!',
                message: this.response.error.message,
                variant: 'error',
                mode: 'dismissable'
            });
            this.dispatchEvent(evt);
            
            

        }
        console.log('final response that is retuned  : ');
       
    })
    .catch(error => {
        // Handle any errors
        this.currentstep = "2";
        this.stripeProgressError = true;
        this.response = null;
        this.error = error;
    });
  }
//store input value of merchant name//////////////////////////////////////////************stripe merchant authentication funtion end*******///////////////////////////////////////////////////////////////////////////////////////
  
  
}