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
            console.log('this.creditCardOptions = '+this.creditCardOptions);
            if(this.creditCardOptions.length  === 0) {
              console.log('Nothing in List');
              const updateMain = this.template.querySelector('.desktop-container');
              updateMain.innerHTML = '<div style="display: flex; flex-direction: column; align-items: center; font-size: large;justify-content: space-around;padding: 1em 2em 2.5em 2em;height: 80vh;">   <div><span >To make a payment, please <span style="font-weight: 600;">add at least one card</span> first.</span></div> <br><b>Or</b><br><span>You do not have sufficicent Permissions. Please ask your system administrator.</span></div>';
          }
        } else if (error) {
          console.log('Error is :: '+error);
          console.log('Error');
              const updateMain = this.template.querySelector('.desktop-container');
              updateMain.innerHTML = '<div style="display: flex; flex-direction: column; align-items: center; font-size: large;justify-content: space-around;padding: 1em 2em 2.5em 2em;height: 80vh;">   <div><span >To make a payment, please <span style="font-weight: 600;">add at least one card</span> first.</span></div> <br><b>Or</b><br><span>You do not have sufficicent Permissions. Please ask your system administrator.</span></div>';
          
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
        
        if(this.selectedCreditCardId !=null && this.amount != '')
        {
          this.paynowdisabled = false;
          console.log('this is the value paynowdisabled '+this.paynowdisabled)

        }

        if (this.creditCardData[this.selectedCreditCardId]) {
            const selectedCard = this.creditCardData[this.selectedCreditCardId];
            const logicpaymentType = selectedCard.logicpayment__Type__c;
            console.log('this is the type : '+logicpaymentType);
            this.paymentGatewayType = logicpaymentType;
            this.currentstep = "1";
            this.ProgressError = false;
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
   @track value = 'Pay';

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
        if(this.selectedCreditCardId !=null )
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
        this.value = selectedValue;
        console.log(`Selected option: `+this.value);
        
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
  this.isShowModal = false;
  console.log("thi is the   this.selectedAction : " +  this.value);


  if(this.paymentGatewayType == 'Authorize.Net')
        {
            authorizeNetTransaction({
                transactionAction: this.value,
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
           const responseRecievedSuccessfully = new ShowToastEvent({
            title: 'Response Recieved Successfully!',
            message: ('The response has been received.'),
            variant: 'info', // 'success', 'warning', 'error', or 'info'
            mode: 'dismissible' // 'dismissable' or 'pester'
        });
        this.dispatchEvent(responseRecievedSuccessfully);
       
  
          if (
            result.messages.resultCode != null &&
            result.messages.resultCode.toLowerCase() == "ok"
          ) {
            console.log("in else if ");
            setTimeout(() => {
            this.currentstep = "3";
            if (this.value =='Pay')
            {const evt = new ShowToastEvent({
              title: "Success!",
              message: "Payment successful",
              variant: "success"
            });
            this.dispatchEvent(evt);}
            else{
              const evtr = new ShowToastEvent({
              title: "Success!",
              message: "Refund successful",
              variant: "success"
            });
            this.dispatchEvent(evtr);

            }
            setTimeout(() => {
            this.isShowModal = false;
            this.selectedCreditCardId = null;
            this.currentstep = "1";
            this.amount = '';
            this.value = 'Pay';
            this.showSend = true;
            this.showRefund = false;
            this.currentstep = "1";
            this.paynowdisabled = true;
            this.autorizeNet = false;
            this.skrill = false;
            this.stripe = false;
            this.square = false;
            this.globalPayment = false;
          }, 2500);
        }, 1500);
          }
          // Handle the case where the authentication with AUthrize NET resulted in an error
          else if (
            result.messages.resultCode != null &&
            result.messages.resultCode.toLowerCase() == "error"
          ) {
           
            console.log("in else if  : " + result.messages.text);
          
            
            const evt = new ShowToastEvent({
              title: "Error!"+result.messages.message[0].code,
              message: result.messages.message[0].text,
              variant: "error",
              mode: "dismissable"
            });
            setTimeout(() => {
              this.dispatchEvent(evt);
              this.currentstep = "3";
              this.ProgressError = true;
            }, 1500);
          }
          
          console.log("final response that is retuned  : ");
        })
        .catch((error) => {
          // Handle any errors
          console.log("in cach error ");
          this.currentstep = "1";
          const evt = new ShowToastEvent({
            title: 'Error code: ' + error.status,
            message: error.body.message,
            variant: 'error', // 'success', 'warning', 'error', or 'info'
            mode: 'dismissible' 
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
           
           if(this.value == 'Pay') 
            {stripeTransaction({
                transactionAction: this.value,
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
          
            this.currentstep = "2";
            const responseRecievedSuccessfully = new ShowToastEvent({
              title: 'Response Recieved Successfully!',
              message: ('The response has been received.'),
              variant: 'info', // 'success', 'warning', 'error', or 'info'
              mode: 'dismissible' // 'dismissable' or 'pester'
          });
          this.dispatchEvent(responseRecievedSuccessfully);
         
  
          if (result.error == null ) {
            console.log("error is  null  and the display name is ");
            console.log(
              "this is the input merchant name : " 
            );
            setTimeout(() => {
            this.currentstep = '3';
            const evt = new ShowToastEvent({
              title: "Success!",
              message: "Payment successful",
              variant: "success"
            });
            this.dispatchEvent(evt);
            
         
            setTimeout(() => {
              this.isShowModal = false;
              this.selectedCreditCardId = null;
              this.currentstep = "1";
              this.amount = '';
              this.selectedAction = 'Pay'
              this.showSend = true;
              this.showRefund = false;
              this.currentstep = "1";
              this.paynowdisabled = true;
              this.autorizeNet = false;
              this.skrill = false;
              this.stripe = false;
              this.square = false;
              this.globalPayment = false;
            }, 2500);
          }, 1500);
            }
          
          // Handle the case where the authentication with Stripe resulted in an error
          else if (
            result.error !== "undefined" &&
          result.error !== undefined
          ) {
            
            console.log("error and current step is  : " + this.currentstep);
            console.log("error message  : " + this.response.error.message);
            const evt = new ShowToastEvent({
              title: "Error!"+this.response.error.code,
              message: this.response.error.message,
              variant: "error",
              mode: "dismissable"
            });
            setTimeout(() => {
            this.dispatchEvent(evt);
            this.currentstep = "3";
            this.ProgressError = true;
          }, 1500);
          }
          console.log("final response that is retuned  : ");
        })
        .catch((error) => {
          // Handle any errors
          this.currentstep = "1";
          const evt = new ShowToastEvent({
            title: 'Error code: ' + error.status,
            message: error.body.message,
            variant: 'error', // 'success', 'warning', 'error', or 'info'
            mode: 'dismissible' 
          });
          this.dispatchEvent(evt);
          this.ProgressError = true;
          this.response = null;
         
          this.error = error;
        });

      

        }
    
    else if (this.value == 'refund')
    {
        stripeTransactionRefund({
            transactionAction: this.value,
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
            this.currentstep = "2";
            const responseRecievedSuccessfully = new ShowToastEvent({
              title: 'Response Recieved Successfully!',
              message: ('The response has been received.'),
              variant: 'info', // 'success', 'warning', 'error', or 'info'
              mode: 'dismissible' // 'dismissable' or 'pester'
          });
          this.dispatchEvent(responseRecievedSuccessfully);
            setTimeout(() => {
            this.currentstep = '3';
            const evt = new ShowToastEvent({
              title: "Success!",
              message: "Refund successful",
              variant: "success"
            });
            this.dispatchEvent(evt);
            
            setTimeout(() => {
              this.isShowModal = false;
              this.selectedCreditCardId = null;
              this.currentstep = "1";
              this.amount = '';
              this.value = 'Pay';
              this.showSend = true;
              this.showRefund = false;
              this.currentstep = "1";
              this.paynowdisabled = true;
              this.autorizeNet = false;
              this.skrill = false;
              this.stripe = false;
              this.square = false;
              this.globalPayment = false;
            }, 2500);
          }, 1500);
                
          }
          // Handle the case where the authentication with Stripe resulted in an error
          else if (
            this.response.error !== "undefined" &&
            this.response.error !== undefined
          ) {
            if (this.response.error.message == 'To process the refund, please initiate one or more send transactions. Thank you!.')
            {
             
              const evt = new ShowToastEvent({
                title: "Error!"+result.error.code,
                message: result.error.message,
                variant: "error",
                mode: "dismissable"
              });
                this.dispatchEvent(evt);
                this.currentstep = '1';
                this.ProgressError = true;
            }
            else{
              this.currentstep = "2";
              const responseRecievedSuccessfully = new ShowToastEvent({
                title: 'Response Recieved Successfully!',
                message: ('The response has been received.'),
                variant: 'info', // 'success', 'warning', 'error', or 'info'
                mode: 'dismissible' // 'dismissable' or 'pester'
            });
            this.dispatchEvent(responseRecievedSuccessfully);

           
            console.log("error and current step is  : " + this.currentstep);
            console.log("error message  : " + this.response.error.message);
            const evt = new ShowToastEvent({
              title: "Error!"+this.response.error.code,
              message: this.response.error.message,
              variant: "error",
              mode: "dismissable"
            });
            setTimeout(() => {
              this.dispatchEvent(evt);
              this.currentstep = "3";
              this.ProgressError = true;
            }, 1500);
          }}
          console.log("final response that is retuned  : ");
        
      })
      
        .catch((error) => {
          // Handle any errors
          this.currentstep = "1";
          const evt = new ShowToastEvent({
            title: 'Error code: ' + error.status,
            message: error.body.message,
            variant: 'error', // 'success', 'warning', 'error', or 'info'
            mode: 'dismissible' 
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
                transactionAction: this.value,
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
          const responseRecievedSuccessfully = new ShowToastEvent({
            title: 'Response Recieved Successfully!',
            message: ('The response has been received.'),
            variant: 'info', // 'success', 'warning', 'error', or 'info'
            mode: 'dismissible' // 'dismissable' or 'pester'
        });
        this.dispatchEvent(responseRecievedSuccessfully);
          
            this.currentstep = "2";
         
  
          if (result.error_code == null) {
            console.log("in  if ");
            setTimeout(() => {
            this.currentstep = "3";
            if (this.value =='Pay')
            {const evt = new ShowToastEvent({
              title: "Success!",
              message: "Payment successful",
              variant: "success"
            });
            this.dispatchEvent(evt);}
            else{
              const evtr = new ShowToastEvent({
              title: "Success!",
              message: "Refund successful",
              variant: "success"
            });
            this.dispatchEvent(evtr);

            }
            setTimeout(() => {
              this.isShowModal = false;
              this.selectedCreditCardId = null;
              this.currentstep = "1";
              this.amount = '';
              this.value = 'Pay';
              this.showSend = true;
              this.showRefund = false;
              this.currentstep = "1";
              this.paynowdisabled = true;
              this.autorizeNet = false;
              this.skrill = false;
              this.stripe = false;
              this.square = false;
              this.globalPayment = false;
            }, 2500);
          }, 1500);
          }
          // Handle the case where the authentication with GP resulted in an error
          else {
            
            const evt = new ShowToastEvent({
              title: "Error!"+result.detailed_error_code,
              message: result.detailed_error_description,
              variant: "error",
              mode: "dismissable"
            });
            
            setTimeout(() => {
              this.currentstep = "3";
              this.ProgressError = true;
              this.dispatchEvent(evt);
            }, 1500);
            
          }
          console.log("final response that is retuned  : ");
        
        })
        .catch((error) => {
          // Handle any errors
          console.log("in cach error ");
          const evt = new ShowToastEvent({
                           title: 'Error code: ' + error.status,
                            message: error.body.message,
                            variant: 'error', // 'success', 'warning', 'error', or 'info'
                            mode: 'dismissible' 
          });
          this.dispatchEvent(evt);
          this.currentstep = "1";
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