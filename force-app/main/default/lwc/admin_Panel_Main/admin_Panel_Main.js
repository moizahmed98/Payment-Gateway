import { LightningElement, track, wire } from "lwc";
import stripeAdminAuth from "@salesforce/apex/AdminAuthenticationController.stripeAdminAuth";
import authorizeNetAdminAuth from "@salesforce/apex/AdminAuthenticationController.authorizeNetAdminAuth";
import globalPaymentAdminAuth from "@salesforce/apex/AdminAuthenticationController.globalPaymentAdminAuth";
import authNetPrevMerchantName from "@salesforce/apex/AdminAuthenticationController.authNetPrevMerchantName";
import stripePrevMerchantName from "@salesforce/apex/AdminAuthenticationController.stripePrevMerchantName";
import globalPaymentPrevMerchantName from "@salesforce/apex/AdminAuthenticationController.globalPaymentPrevMerchantName";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class TabExample extends LightningElement {
  @track selectedMenuItem = null;
  @track stripeprevMerchant = false;
  @track authNetprevMerchant = false;
  @track authNetprevMerchantName;
  @track globalPaymentprevMerchant = false;
  loaded = true;


  @track loader=false;
  showLoader()
  {
    console.log('Show Loader');
    this.loader=true;
  }
  hideLoader()
  {
    console.log('Hide Loader');
    this.loader=false;
  }
  connectedCallback() {
    // This code will run when the component is connected to the DOM (i.e., when it loads).
    this.callauthNetPrevMerchantName();
  }
  callauthNetPrevMerchantName() {
    authNetPrevMerchantName()
      .then((resultauth) => {
        // Handle the result here
        console.log("this is result" + resultauth);
        if (resultauth != null) {
          this.authNetprevMerchantName = resultauth;
          this.authNetprevMerchant = true;
          this.globalPaymentprevMerchant = false;
          this.stripeprevMerchant = false;
          this.loaded = true;
        } else {
          this.authNetprevMerchant = false;
          this.loaded = true;
        }
      })
      .catch((error) => {
        // Handle errors here
        console.error(error);
      });
  }
  @track stripePrevMerchantNamevalue;
  callstripePrevMerchantName() {
    stripePrevMerchantName()
      .then((resultstripe) => {
        // Handle the result here
        console.log("this is result stripe" + resultstripe);
        if (resultstripe != null) {
          this.stripePrevMerchantNamevalue = resultstripe;
          this.stripeprevMerchant = true;
          this.globalPaymentprevMerchant = false;
          this.authNetprevMerchant = false;
          this.loaded = true;
        } else {
          this.stripeprevMerchant = false;
          this.loaded = true;
        }
      })
      .catch((error) => {
        // Handle errors here
        console.error(error);
      });
  }
  @track globalPaymentPrevMerchantNamevalue;
  callglobalPaymentPrevMerchantName() {
    globalPaymentPrevMerchantName()
      .then((resultGP) => {
        // Handle the result here
        console.log("this is result gp" + resultGP);
        if (resultGP != null) {
          this.globalPaymentPrevMerchantNamevalue = resultGP;
          this.globalPaymentprevMerchant = true;
          this.authNetprevMerchant = false;
          this.stripeprevMerchant = false;
          this.loaded = true;
        } else {
          this.globalPaymentprevMerchant = false;
          this.loaded = true;
        }
      })
      .catch((error) => {
        // Handle errors here
        console.error(error);
      });
  }
  handleOnselect(event) {
    
    var authtabContent = this.template.querySelector(
      '[data-id="authorizeNetContentId"]'
    );
    var skrilltabContent = this.template.querySelector(
      '[data-id="skrillContentId"]'
    );
    var stripetabContent = this.template.querySelector(
      '[data-id="stripeContentId"]'
    );
    var squaretabContent = this.template.querySelector(
      '[data-id="squareContentId"]'
    );
    var gPtabContent = this.template.querySelector(
      '[data-id="globalPaymentontentId"]'
    );
    this.selectedMenuItem = event.detail.value;
    const selectedItemValue = event.detail.value;

    if (selectedItemValue === "authorizeNetId") {
      authtabContent.classList.remove("slds-hide");
      authtabContent.classList.add("slds-show");
      stripetabContent.classList.add("slds-hide");
      skrilltabContent.classList.add("slds-hide");
      squaretabContent.classList.add("slds-hide");
      gPtabContent.classList.add("slds-hide");
    } else if (selectedItemValue === "skrillId") {
      skrilltabContent.classList.remove("slds-hide");
      skrilltabContent.classList.add("slds-show");
      squaretabContent.classList.add("slds-hide");
      gPtabContent.classList.add("slds-hide");
      stripetabContent.classList.add("slds-hide");
      authtabContent.classList.add("slds-hide");
    } else if (selectedItemValue === "stripetabId") {
      stripetabContent.classList.remove("slds-hide");
      stripetabContent.classList.add("slds-show");
      squaretabContent.classList.add("slds-hide");
      gPtabContent.classList.add("slds-hide");
      authtabContent.classList.add("slds-hide");
      skrilltabContent.classList.add("slds-hide");
    } else if (selectedItemValue === "squareId") {
      squaretabContent.classList.remove("slds-hide");
      squaretabContent.classList.add("slds-show");
      gPtabContent.classList.add("slds-hide");
      authtabContent.classList.add("slds-hide");
      skrilltabContent.classList.add("slds-hide");
      stripetabContent.classList.add("slds-hide");
    } else if (selectedItemValue === "globalPaymentId") {
      gPtabContent.classList.remove("slds-hide");
      gPtabContent.classList.add("slds-show");
      authtabContent.classList.add("slds-hide");
      skrilltabContent.classList.add("slds-hide");
      stripetabContent.classList.add("slds-hide");
      squaretabContent.classList.add("slds-hide");
    }
  }

  tabonclick(event) {
    const currentTabId = event.currentTarget.getAttribute("data-id");
    var authorizeNetTab = this.template.querySelector(
      '[data-id="authorizeNetId"]'
    );
    var skrillTab = this.template.querySelector('[data-id="skrillId"]');
    var stripeTab = this.template.querySelector('[data-id="stripetabId"]');
    var squareTab = this.template.querySelector('[data-id="squareId"]');
    var globalPaymentTab = this.template.querySelector(
      '[data-id="globalPaymentId"]'
    );

    var authtabContent = this.template.querySelector(
      '[data-id="authorizeNetContentId"]'
    );
    var skrilltabContent = this.template.querySelector(
      '[data-id="skrillContentId"]'
    );
    var stripetabContent = this.template.querySelector(
      '[data-id="stripeContentId"]'
    );
    var squaretabContent = this.template.querySelector(
      '[data-id="squareContentId"]'
    );
    var gPtabContent = this.template.querySelector(
      '[data-id="globalPaymentontentId"]'
    );

    if (currentTabId === "authorizeNetId") {
      this.callauthNetPrevMerchantName();
      this.loaded = !this.loaded;
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
    } else if (currentTabId === "skrillId") {
      
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
    } else if (currentTabId === "stripetabId") {
      this.loaded = !this.loaded;
      this.callstripePrevMerchantName();
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
    } else if (currentTabId === "squareId") {
      
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
    } else if (currentTabId === "globalPaymentId") {
      this.callglobalPaymentPrevMerchantName();
      this.loaded = !this.loaded;
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

  @track authNetemerchantName = null;
  authNetMerchantName(event) {
    const inputValue = event.target.value;

    // Check if the input is not a single space
    if (inputValue.trim() !== "") {
      this.authNetemerchantName = inputValue;
      console.log("Updated merchant name:", this.authNetemerchantName);
    } else {
      this.authNetemerchantName = null;
      console.log("Invalid input. Merchant name must not be a single space.");
    }
  }
  //store input value of login id
  @track authNetLoginId = null;
  authNetloginIdinput(event) {
    console.log("thi is inout :" + event.target.value);
    this.authNetLoginId = event.target.value;
    console.log(this.authNetLoginId);
  }
  //store input value of transaction id
  @track authNetTransactoinId = null;
  authNetTransactionIdinput(event) {
    console.log("thi is inout :" + event.target.value);
    this.authNetTransactoinId = event.target.value;
    console.log(this.authNetTransactoinId);
  }
  //store input value of merchant name//////////////////////////////////////////************calling authent merchant authentication function*******///////////////////////////////////////////////////////////////////////////////////////
  @track authNetcurrentstep = "1";
  @track authNetProgressError = false;

  authNetresponse;
  error;
  AuthNethandleButtonClick() {
    this.showLoader();
    console.log("ftn is called");
    this.authNetcurrentstep ='1';
    this.authNetProgressError=false;

    if (
      this.authNetemerchantName == null ||
      this.authNetLoginId == null ||
      this.authNetTransactoinId == null
    ) {
      const evt = new ShowToastEvent({
        title: "Error!",
        message: "Please fill all the Input Fields",
        variant: "error",
        mode: "dismissable"
      });
      this.dispatchEvent(evt);
      this.hideLoader();
    } else {
      authorizeNetAdminAuth({
        authorizeNetMerchantName: this.authNetemerchantName,
        authorizeNetApiLoginId: this.authNetLoginId,
        authorizeNetTransactionKey: this.authNetTransactoinId
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
          this.authNetProgressError = false;
          this.authNetcurrentstep = "2";
          const responseRecievedSuccessfully = new ShowToastEvent({
            title: "Response Recieved Successfully!",
            message: "The response has been received.",
            variant: "info", // 'success', 'warning', 'error', or 'info'
            mode: "dismissible" // 'dismissable' or 'pester'
          });
          this.dispatchEvent(responseRecievedSuccessfully);

          if (
            result.messages.resultCode != null &&
            result.messages.resultCode.toLowerCase() == "ok"
          ) {
            console.log("in else if ");
            ////////////////////////////////

            setTimeout(() => {
              this.authNetcurrentstep = "3";
              const evt = new ShowToastEvent({
                title: "Success!",
                message: "Authentication successful",
                variant: "success"
              });
              this.dispatchEvent(evt);
              
              ///////////////////////////////////
              setTimeout(() => {
                this.callauthNetPrevMerchantName();
                this.authNetemerchantName = null;
                this.authNetLoginId = null;
                this.authNetTransactoinId = null;
                this.authNetcurrentstep = "1";
                this.hideLoader();
              }, 2500);
            }, 1500);

            ////////////////////////////////

            /////////////////////////////////
          }
          // Handle the case where the authentication with AUthrize NET resulted in an error
          else if (
            result.messages.resultCode != null &&
            result.messages.resultCode.toLowerCase() == "error"
          ) {
            console.log("in else if  : " + result.messages.text);

            const evt = new ShowToastEvent({
              title: "Error!",
              message: result.messages.message[0].text,
              variant: "error",
              mode: "dismissable"
            });
            setTimeout(() => {
              this.dispatchEvent(evt);
              this.authNetcurrentstep = "3";
              this.authNetProgressError = true;
              this.hideLoader();
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
          this.authNetcurrentstep = "1";
          this.authNetProgressError = true;
          this.response = null;
          this.error = error;
          this.hideLoader();
        });
    }
  }

  //store input value of merchant name//////////////////////////////////////////*********calling globalNEt merchant authentication function**********///////////////////////////////////////////////////////////////////////////////////////

  @track globalPaymentemerchantName = null;
  globalPaymentMerchantName(event) {
    const inputValue = event.target.value;

    // Check if the input is not a single space
    if (inputValue.trim() !== "") {
      this.globalPaymentemerchantName = inputValue;
      console.log("Updated merchant name:", this.globalPaymentemerchantName);
    } else {
      this.globalPaymentemerchantName = null;
      console.log("Invalid input. Merchant name must not be a single space.");
    }
  }
  //store input value of login id
  @track globalPaymentLoginId = null;
  globalPaymentloginIdinput(event) {
    console.log("thi is inout :" + event.target.value);
    this.globalPaymentLoginId = event.target.value;
    console.log(this.globalPaymentLoginId);
  }
  //store input value of transaction id
  @track globalPaymentTransactoinId = null;
  globalPaymentTransactionIdinput(event) {
    console.log("thi is inout :" + event.target.value);
    this.globalPaymentTransactoinId = event.target.value;
    console.log(this.globalPaymentTransactoinId);
  }
  //store input value of merchant name//////////////////////////////////////////************calling authent merchant authentication function*******///////////////////////////////////////////////////////////////////////////////////////
  @track globalPaymentcurrentstep = "1";
  @track globalPaymenterror = false;

  globalPaymentresponse;

  globalPaymenthandleButtonClick() {
    this.showLoader();
    this.globalPaymenterror = false;
    this.globalPaymentcurrentstep ='1';
    console.log("ftn is called");
    if (
      this.globalPaymentemerchantName == null ||
      this.globalPaymentLoginId == null ||
      this.globalPaymentTransactoinId == null
    ) {
      const evt = new ShowToastEvent({
        title: "Error!",
        message: "Please fill all the Input Fields",
        variant: "error",
        mode: "dismissable"
      });
      this.dispatchEvent(evt);
      this.hideLoader();
    } else {
      globalPaymentAdminAuth({
        globalPaymentMerchantName: this.globalPaymentemerchantName,
        globalPaymentAppId: this.globalPaymentLoginId,
        globalPaymentAppKey: this.globalPaymentTransactoinId
      })
        .then((result) => {
          // Handle the successful response
          console.log(
            "this is the retiurned result 1  :" + JSON.stringify(result)
          );
          console.log("this is the retiurned result 2 :" + result.error_code);
          //////////////////////////////////////////

          this.globalPaymentcurrentstep = "2";
          const responseRecievedSuccessfully = new ShowToastEvent({
            title: "Response Recieved Successfully!",
            message: "The response has been received.",
            variant: "info", // 'success', 'warning', 'error', or 'info'
            mode: "dismissible" // 'dismissable' or 'pester'
          });
          this.dispatchEvent(responseRecievedSuccessfully);
          /////////////////////////////////////////

          if (result.error_code == null) {
            console.log("in  if ");
            setTimeout(() => {
              this.globalPaymentcurrentstep = "3";
              const evt = new ShowToastEvent({
                title: "Success!",
                message: "Authentication successful",
                variant: "success"
              });
              this.dispatchEvent(evt);
              
              //////////////////////////////////
              setTimeout(() => {
                this.globalPaymentemerchantName = null;
                this.callglobalPaymentPrevMerchantName();
                this.globalPaymentLoginId = null;
                this.globalPaymentTransactoinId = null;
                this.globalPaymentcurrentstep = "1";
                this.hideLoader();
              }, 2500);
            }, 1500);

            /////////////////////////////////
          }
          // Handle the case where the authentication with GP resulted in an error
          else {
            const evt = new ShowToastEvent({
              title: "Error!",
              message: result.error_code,
              variant: "error",
              mode: "dismissable"
            });
            setTimeout(() => {
              this.dispatchEvent(evt);
              this.globalPaymentcurrentstep = "3";
              this.globalPaymenterror = true;
              this.hideLoader();
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
          this.globalPaymentcurrentstep = "1";
          this.globalPaymenterror = true;
          this.response = null;
          this.error = error;
          this.hideLoader();
        });
    }
  }

  //store input value of merchant name//////////////////////////////////////////************input fileds of stripe*******///////////////////////////////////////////////////////////////////////////////////////
  @track stripemerchantName = null;
  stripemerchantNameinput(event) {
    const inputValue = event.target.value;

    // Check if the input is not a single space
    if (inputValue.trim() !== "") {
      this.stripemerchantName = inputValue;
      console.log("Updated merchant name:", this.stripemerchantName);
    } else {
      this.stripemerchantName = null;
      console.log("Invalid input. Merchant name must not be a single space.");
    }
  }
  //store input value of secret key
  @track stripesecretKey = null;
  stripesecretKeyinput(event) {
    console.log("thi is inout :" + event.target.value);
    this.stripesecretKey = event.target.value;
    console.log(this.stripesecretKey);
  }
  //store input value of publishable key
  @track stripepublishKey = null;
  stripepublishKeyinput(event) {
    console.log("thi is inout :" + event.target.value);
    this.stripepublishKey = event.target.value;
    console.log(this.stripepublishKey);
  }
  ////////////////////////////////////////////////////////////////////calling stripe merchant authenticatioin funtion ////////////////////////////////////////////////////////////////////////////////////////////////////

  @track currentstep = "1";
  @track stripeProgressError = false;

  response;
  error;
  StripehandleButtonClick() {
    this.showLoader();
    this.currentstep = '1';
    this.stripeProgressError = false;
    console.log("ftn is called" );
    if (
      this.stripemerchantName == null ||
      this.stripesecretKey == null ||
      this.stripepublishKey == null
    ) {
      const evt = new ShowToastEvent({
        title: "Error!",
        message: "Please fill all the Input Fields",
        variant: "error",
        mode: "dismissable"
      });
      this.dispatchEvent(evt);
      this.hideLoader();
    } else {
      stripeAdminAuth({
        stripeMerchantName: this.stripemerchantName,
        stripeSecretApiKey: this.stripesecretKey,
        stripePublishableApiKey: this.stripepublishKey
      })
        .then((result) => {
          // Handle the successful response
          console.log(
            "this is the retiurned result 1  :" + JSON.stringify(result)
          );
          console.log("this is the retiurned result 2 :" + result.error);
          console.log("this is the retiurned result 3 :" + result.settings);
          this.response = result;
          this.error = null;
          this.stripeProgressError = false;
          this.currentstep = "2";
          const responseRecievedSuccessfully = new ShowToastEvent({
            title: "Response Recieved Successfully!",
            message: "The response has been received.",
            variant: "info", // 'success', 'warning', 'error', or 'info'
            mode: "dismissible" // 'dismissable' or 'pester'
          });
          this.dispatchEvent(responseRecievedSuccessfully);
          if (result.settings != "undefined" && result.settings != undefined) {
            console.log("error is  null  and the display name is ");
            console.log(
              "this is the input merchant name : " + this.stripemerchantName
            );

           
            /////////////////////////////////////////
            if (
              this.response.settings.dashboard.display_name ===
              this.stripemerchantName
            ) {
              setTimeout(() => {
                this.currentstep = "3";
                this.stripeProgressError = false;
                console.log(
                  "the  display name is correct and the merchant is authenticated"
                );
                const evt = new ShowToastEvent({
                  title: "Success!",
                  message: "Authentication successful",
                  variant: "success"
                });
                this.dispatchEvent(evt);
                
                setTimeout(() => {
                  this.callstripePrevMerchantName();
                  this.stripemerchantName = null;
                  this.stripesecretKey = null;
                  this.stripepublishKey = null;
                  this.currentstep = "1";
                  this.hideLoader();
                }, 2500);
              }, 1500);
              /////////////////////////////////
            } else if (
              this.response.settings.dashboard.display_name !=
              this.stripemerchantName
            ) {
             
              console.log(
                "display name is not correct : " + this.stripemerchantName
              );
              const evt = new ShowToastEvent({
                title: "Error!",
                message: "Merchant Name is Incorrect",
                variant: "error",
                mode: "dismissable"
              });

              setTimeout(() => {
                this.dispatchEvent(evt);
                this.currentstep = "3";
                this.stripeProgressError = true;
                this.hideLoader();
              }, 1500);
            }
          }
          // Handle the case where the authentication with Stripe resulted in an error
          else if (
            this.response.error !== "undefined" &&
            this.response.error !== undefined
          ) {
            console.log("error and current step is  : " + this.currentstep);
            console.log("error message  : " + this.response.error.message);
            const evt = new ShowToastEvent({
              title: "Error!",
              message: this.response.error.message,
              variant: "error",
              mode: "dismissable"
            });
            setTimeout(() => {
              this.dispatchEvent(evt);
              this.currentstep = "3";
              this.stripeProgressError = true;
              this.hideLoader();
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
          this.stripeProgressError = true;
          this.response = null;
          this.error = error;
          this.hideLoader();
        });
    }
  }
  //store input value of merchant name//////////////////////////////////////////************stripe merchant authentication funtion end*******///////////////////////////////////////////////////////////////////////////////////////
}