import { LightningElement, track } from 'lwc';

export default class TabExample extends LightningElement {
    @track selectedMenuItem = null;
    
    handleOnselect(event) {
        this.selectedMenuItem = event.detail.value; 
        const selectedItemValue = event.detail.value;
        var authtabContent = this.template.querySelector('[data-id="authorizeNetContentId"]');
        var skrilltabContent = this.template.querySelector('[data-id="skrillContentId"]');
        var stripetabContent = this.template.querySelector('[data-id="stripeContentId"]');
        var squaretabContent = this.template.querySelector('[data-id="squareContentId"]');
        var gPtabContent = this.template.querySelector('[data-id="globalPaymentontentId"]');
       
        
        if(selectedItemValue == 'authorizeNetId')
        {
            
           
            authtabContent.classList.remove("slds-hide");
            authtabContent.classList.add("slds-show");
            stripetabContent.classList.add("slds-hide");
            skrilltabContent.classList.add("slds-hide");
            squaretabContent.classList.add("slds-hide");
            gPtabContent.classList.add("slds-hide");
            
            
        }
        else if(selectedItemValue == 'skrillId')
        {
           
            
            skrilltabContent.classList.remove("slds-hide");
            skrilltabContent.classList.add("slds-show");
            squaretabContent.classList.add("slds-hide");
            gPtabContent.classList.add("slds-hide");
            stripetabContent.classList.add("slds-hide");
            authtabContent.classList.add("slds-hide");
        }
        else if(selectedItemValue == 'stripetabId')
        {
            
            
            stripetabContent.classList.remove("slds-hide");
            stripetabContent.classList.add("slds-show");
            squaretabContent.classList.add("slds-hide");
            gPtabContent.classList.add("slds-hide");
            authtabContent.classList.add("slds-hide");
            skrilltabContent.classList.add("slds-hide");
        }
        else if(selectedItemValue == 'squareId')
        {
         
            
            squaretabContent.classList.remove("slds-hide");
            squaretabContent.classList.add("slds-show");
            gPtabContent.classList.add("slds-hide");
            authtabContent.classList.add("slds-hide");
            skrilltabContent.classList.add("slds-hide");
            stripetabContent.classList.add("slds-hide");
            
        }
        else if(selectedItemValue == 'globalPaymentId')
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

        if(currentTabId == 'authorizeNetId')
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
        else if(currentTabId == 'skrillId')
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
        else if(currentTabId == 'stripetabId')
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
        else if(currentTabId == 'squareId')
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
        else if(currentTabId == 'globalPaymentId')
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
}