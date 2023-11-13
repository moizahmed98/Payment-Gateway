import { LightningElement,track,api,wire } from 'lwc';
import backgroundImage from '@salesforce/resourceUrl/makepaymentbg';
import { getRecord } from 'lightning/uiRecordApi';
import getCreditCards from '@salesforce/apex/MakePayment.getCreditCards';
import stripeTransaction from '@salesforce/apex/TransactionProcessingController.stripeTransaction';
import globalPaymentTransaction from '@salesforce/apex/TransactionProcessingController.globalPaymentTransaction';
import authorizeNetTransaction from '@salesforce/apex/TransactionProcessingController.authorizeNetTransaction';
import stripeTransactionRefund from '@salesforce/apex/TransactionProcessingController.stripeTransactionRefund';
import { ShowToastEvent } from "lightning/platformShowToastEvent";


export default class MakePayment extends LightningElement {
    ////////////////////////////////////////////////////////////  ****Integration****  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

    @api recordId; // Pass the Account Id from the parent component
   

    selectedCreditCardId = null;
    creditCardOptions = [];
    creditCardData = [];
    @wire(getCreditCards, { accountId: '$recordId' })
    wiredCreditCards({ error, data }) {
        if (data) {
            console.log('this is the returned response : '+JSON.stringify(data));
            this.creditCardData = data.reduce((acc, card) => {
                acc[card.Id] = card;
                return acc;
            }, {});
            this.creditCardOptions = data.map(card => ({
                label: card.logicpayment__Card__c,
                value: card.Id
            }));
        } else if (error) {
            // Handle the error
        }
    }
    @track autorizeNet = false;
    @track skrill = false;
    @track stripe = false;
    @track square = false;
    @track globalPayment = false;
    @track paymentGatewayType;
    @track paynowdisabled = true;
    @track amount ='';
    handleCreditCardChange(event) {
        console.log('this is card value : '+event.detail.value);
        this.selectedCreditCardId = event.detail.value;
        this.paynowdisabled = false;

        if (this.creditCardData[this.selectedCreditCardId]) {
            const selectedCard = this.creditCardData[this.selectedCreditCardId];
            const logicpaymentType = selectedCard.logicpayment__Type__c;
            console.log('this is the type : '+logicpaymentType);
            this.paymentGatewayType = logicpaymentType;
            // Now you can use logicpaymentType as the value of logicpayment__Type__c
        }
        console.log('this is the type : '+this.paymentGatewayType);

        if(this.paymentGatewayType == 'Authorize.Net')
        {
            this.autorizeNet = true;
            this.skrill = false;
            this.stripe = false;
            this.square = false;
            this.globalPayment = false;
            
        }
        else if(this.paymentGatewayType == 'Skrill'){
            this.autorizeNet = false;
            this.skrill = true;
            this.stripe = false;
            this.square = false;
            this.globalPayment = false;

        }
        else if(this.paymentGatewayType == 'Stripe'){
            this.autorizeNet = false;
            this.skrill = false;
            this.stripe = true;
            this.square = false;
            this.globalPayment = false;

        }
        else if(this.paymentGatewayType == 'Square'){
            this.autorizeNet = false;
            this.skrill = false;
            this.stripe = false;
            this.square = true;
            this.globalPayment = false;

        }
        else if(this.paymentGatewayType == 'Global Payments'){
            this.autorizeNet = false;
            this.skrill = false;
            this.stripe = false;
            this.square = false;
            this.globalPayment = true;

        }
    }

    ////////////////////////////////////////////////////////////  ****Integration****  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

    backgroundImage = backgroundImage;
   value = 'Pay';

    get options() {
        return [
            { label: 'Send', value: 'Pay' },
            { label: 'Refund', value: 'refund' },
        ];
    }
  handleInputChange(event) {
        // Get the input value
        let inputValue = event.target.value;
        this.amount = event.target.value;
        console.log('Entered Amountttttt :');
       
        // Remove non-numeric characters using a regular expression
        inputValue = inputValue.replace(/[^0-9.]/g, '');

        // Update the input field value with only numeric characters
        event.target.value = inputValue;
        console.log('Entered event.target.value :'+event.target.value);
        this.amount = event.target.value;
        this.paynowdisabled = this.amount === '' ? true : false;
    }

    handleInputAmount(event) {
       
         this.amount = event.target.value;
        console.log(`Entered Amount : `+this.amount);
            
    }
    @track selectedOption = '';
    option1Class = 'radio-button';
    option2Class = 'radio-button';
    @track showSend =true;
    @track showRefund = false;

    @track selectedAction = 'Pay';
    handleButtonClick(event) {
       
        const selectedValue = event.target.value;
        this.selectedAction = selectedValue;
        console.log(`Selected option: `+this.selectedAction);
        
        this.selectedOption = selectedValue;
        if (selectedValue === 'Pay') {
            this.showSend = true;
            this.showRefund = false;
        } else {
            this.showRefund = true;
            this.showSend = false;
            
        }


        // Add any additional logic or actions here based on the selected option
    }
    @track isShowModal = false;

    showModalBox() {  
        this.isShowModal = true;
        this.currentstep = '1';
        this.ProgressError = false;
    }

    hideModalBox() {  
        this.isShowModal = false;
    }
////////////////////////////////////////////////////////////////////////////****************calling Apex funtion for transaction******************///////////////////////////////////////// 

response;
error;

@track currentstep;
@track ProgressError;

handleClickYes() {
  console.log("ftn is called" +this.recordId);

  if(this.paymentGatewayType == 'Authorize.Net')
        {
            authorizeNetTransaction({
                transactionAction: this.selectedAction,
                transactionAmount: this.amount,
                recordId: this.selectedCreditCardId
              })
                .then((result) => {
                 
        // Handle the successful response
        console.log(
            "this is the retiurned result 1  :" + JSON.stringify(result)
          );
          console.log(
            "this is the retiurned result 2 :" +
              result.messages.resultCode.toLowerCase()
          );
          this.authNetresponse = result;
          this.error = null;
          this.ProgressError = false;
          this.currentstep = "2";
  
          if (
            result.messages.resultCode != null &&
            result.messages.resultCode.toLowerCase() == "ok"
          ) {
            console.log("in else if ");
            this.currentstep = "3";
            const evt = new ShowToastEvent({
              title: "Success!",
              message: "Payment successful",
              variant: "success"
            });
            this.dispatchEvent(evt);
            this.isShowModal = false;
            this.selectedCreditCardId = null;
            this.currentstep = "1";
            this.amount = '';
            this.selectedAction = 'Pay';
            this.currentstep = "1";
            this.paynowdisabled = true;
          }
          // Handle the case where the authentication with AUthrize NET resulted in an error
          else if (
            result.messages.resultCode != null &&
            result.messages.resultCode.toLowerCase() == "error"
          ) {
            this.currentstep = "3";
            console.log("in else if  : " + result.messages.text);
          
            this.ProgressError = true;
            const evt = new ShowToastEvent({
              title: "Error!",
              message: result.messages.message[0].text,
              variant: "error",
              mode: "dismissable"
            });
            this.dispatchEvent(evt);
          }
          
          console.log("final response that is retuned  : ");
        })
        .catch((error) => {
          // Handle any errors
          console.log("in cach error ");
          this.currentstep = "2";
          const evt = new ShowToastEvent({
            title: "Error!",
            message:"The response was not recived",
            variant: "error",
            mode: "dismissable"
          });
          this.dispatchEvent(evt);
          this.ProgressError = true;
          this.response = null;
          this.error = error;
        });
                  console.log("final response that is retuned  : ");
                 
                
            
        }
        else if(this.paymentGatewayType == 'Skrill'){
            
          
        }
        else if(this.paymentGatewayType == 'Stripe'){
           
           if(this.selectedAction == 'Pay') 
            {stripeTransaction({
                transactionAction: this.selectedAction,
                transactionAmount: this.amount,
                recordId: this.selectedCreditCardId
              })
                .then((result) => {
                  
        // Handle the successful response
        console.log(
            "this is the retiurned result 1  :" + JSON.stringify(result)
          );
          console.log("this is the retiurned result 2 :" + result.error);
         // console.log("this is the retiurned result 3 :" + result.settings);
          this.response = result;
          this.error = null;
          this.ProgressError = false;
  
          if (result.error == null ) {
            console.log("error is  null  and the display name is ");
            console.log(
              "this is the input merchant name : " 
            );
  
            
            const evt = new ShowToastEvent({
              title: "Success!",
              message: "Payment successful",
              variant: "success"
            });
            this.dispatchEvent(evt);
            this.isShowModal = false;
            this.selectedCreditCardId = null;
            this.currentstep = "1";
            this.amount = '';
            this.selectedAction = 'Pay';
            this.currentstep = "1";
            this.paynowdisabled = true;
            }
          
          // Handle the case where the authentication with Stripe resulted in an error
          else if (
            result.error !== "undefined" &&
          result.error !== undefined
          ) {
            this.currentstep = "2";
            this.ProgressError = true;
            console.log("error and current step is  : " + this.currentstep);
            console.log("error message  : " + this.response.error.message);
            const evt = new ShowToastEvent({
              title: "Error!",
              message: this.response.error.message,
              variant: "error",
              mode: "dismissable"
            });
            this.dispatchEvent(evt);
           
          }
          console.log("final response that is retuned  : ");
        })
        .catch((error) => {
          // Handle any errors
          this.currentstep = "2";
          const evt = new ShowToastEvent({
            title: "Error!",
            message:"The response was not recived",
            variant: "error",
            mode: "dismissable"
          });
          this.dispatchEvent(evt);
          this.ProgressError = true;
          this.response = null;
          this.error = error;
        });

        this.isShowModal = false;
        this.selectedCreditCardId = null;
        this.amount = '';
        this.selectedAction = 'Pay';
        this.paynowdisabled = true;
        this.currentstep = "1";         

        }
    
    else if (this.selectedAction == 'refund')
    {
        stripeTransactionRefund({
            transactionAction: this.selectedAction,
            transactionAmount: this.amount,
            recordId: this.selectedCreditCardId
          })
            .then((result) => {
             
        // Handle the successful response
        console.log(
            "this is the retiurned result 1  :" + JSON.stringify(result)
          );
          console.log("this is the retiurned result 2 :" + result.error);
          //console.log("this is the retiurned result 3 :" + result.settings);
          this.response = result;
          this.error = null;
          this.ProgressError = false;
  
          if (result.error == null) {
            console.log("error is  null  and the display name is ");
            console.log(
              "this is the input merchant name :"
            );
            const evt = new ShowToastEvent({
              title: "Success!",
              message: "Refund successful",
              variant: "success"
            });
            this.dispatchEvent(evt);
            this.isShowModal = false;
            this.selectedCreditCardId = null;
            this.currentstep = "1";
            this.amount = '';
            this.selectedAction = 'Pay';
            this.currentstep = "1";
            this.paynowdisabled = true;
                
          }
          // Handle the case where the authentication with Stripe resulted in an error
          else if (
            this.response.error !== "undefined" &&
            this.response.error !== undefined
          ) {
            this.currentstep = "2";
            this.ProgressError =true;
            console.log("error and current step is  : " + this.currentstep);
            console.log("error message  : " + this.response.error.message);
            const evt = new ShowToastEvent({
              title: "Error!",
              message: this.response.error.message,
              variant: "error",
              mode: "dismissable"
            });
            this.dispatchEvent(evt);
          }
          console.log("final response that is retuned  : ");
        })
        .catch((error) => {
          // Handle any errors
          this.currentstep = "2";
          const evt = new ShowToastEvent({
            title: "Error!",
            message:"The response was not recived",
            variant: "error",
            mode: "dismissable"
          });
          this.dispatchEvent(evt);
          this.ProgressError = true;
          this.response = null;
          this.error = error;
        });
      
    }

    }
        else if(this.paymentGatewayType == 'Square'){
            
            
           
        }
        else if(this.paymentGatewayType == 'Global Payments'){
          
           
            globalPaymentTransaction({
                transactionAction: this.selectedAction,
                transactionAmount: this.amount,
                recordId: this.selectedCreditCardId
              })
                .then((result) => {
                 // Handle the successful response
        console.log(
            "this is the retiurned result 1  :" + JSON.stringify(result)
          );
          console.log("this is the retiurned result 2 :" + result.error_code);
          this.authNetresponse = result;
          this.error = null;
          this.ProgressError = false;
          this.currentstep = "2";
  
          if (result.error_code == null) {
            console.log("in  if ");
            this.currentstep = "3";
            const evt = new ShowToastEvent({
              title: "Success!",
              message: "Payment successful",
              variant: "success"
            });
            this.dispatchEvent(evt);
            this.isShowModal = false;
            this.selectedCreditCardId = null;
            this.currentstep = "1";
            this.amount = '';
            this.selectedAction = 'Pay';
            this.currentstep = "1";
            this.paynowdisabled = true;
          }
          // Handle the case where the authentication with GP resulted in an error
          else {
            this.currentstep = "3";
            this.ProgressError = true;
            const evt = new ShowToastEvent({
              title: "Error!",
              message: result.detailed_error_description,
              variant: "error",
              mode: "dismissable"
            });
            this.dispatchEvent(evt);
            
          }
          console.log("final response that is retuned  : ");
        
        })
        .catch((error) => {
          // Handle any errors
          console.log("in cach error ");
          const evt = new ShowToastEvent({
            title: "Error!",
            message:"The response was not recived",
            variant: "error",
            mode: "dismissable"
          });
          this.dispatchEvent(evt);
          this.currentstep = "2";
          this.ProgressError = true;
          this.response = null;
          this.error = error;
        });
        
                  
        }
    


  
}

@track  accountName;
  // Use wire service to get the Account record
  @wire(getRecord, { recordId: '$recordId', fields: ['Account.Id', 'Account.Name'] })
  wiredAccount({ error, data }) {
      if (data) {
          this.account = data;
          console.log(data);
          console.log('Account Id:', this.account.fields.Id.value);
          console.log('Account Name:', this.account.fields.Name.value);
          this.accountName = this.account.fields.Name.value;



      } else if (error) {
          console.error('Error loading account data', error);
      }
  }

}