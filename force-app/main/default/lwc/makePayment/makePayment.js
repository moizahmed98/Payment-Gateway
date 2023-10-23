import { LightningElement,track } from 'lwc';
import backgroundImage from '@salesforce/resourceUrl/makepaymentbg';

export default class MakePayment extends LightningElement {

    backgroundImage = backgroundImage;
    @track selectedCard = '';
    @track cards = [
        { id: '1', name: 'Card 1' },
        { id: '2', name: 'Card 2' },
        { id: '3', name: 'Card 3' },
        { id: '4', name: 'Card 4' },
        { id: '5', name: 'Card 5' }
        
    ];

    get cardOptions() {
        return this.cards.map(card => ({
            label: card.name,
            value: card.id
        }));
    }
    @track autorizeNet = false;
    @track skrill = false;
    @track stripe = false;
    @track square = false;
    @track globalPayment = false;

    handleCardChange(event) {
        this.selectedCard = event.detail.value;
        
        if(this.selectedCard == '1')
        {
            this.autorizeNet = true;
            this.skrill = false;
            this.stripe = false;
            this.square = false;
            this.globalPayment = false;
            
        }
        else if(this.selectedCard == '2'){
            this.autorizeNet = false;
            this.skrill = true;
            this.stripe = false;
            this.square = false;
            this.globalPayment = false;

        }
        else if(this.selectedCard == '3'){
            this.autorizeNet = false;
            this.skrill = false;
            this.stripe = true;
            this.square = false;
            this.globalPayment = false;

        }
        else if(this.selectedCard == '4'){
            this.autorizeNet = false;
            this.skrill = false;
            this.stripe = false;
            this.square = true;
            this.globalPayment = false;

        }
        else if(this.selectedCard == '5'){
            this.autorizeNet = false;
            this.skrill = false;
            this.stripe = false;
            this.square = false;
            this.globalPayment = true;

        }
            
        
    }
    value = 'option1';

    get options() {
        return [
            { label: 'Send', value: 'option1' },
            { label: 'Refund', value: 'option2' },
        ];
    }
    radioButton(event){
        event.stopPropagation();
        event.stopPropagation(); // Prevent event propagation
        const selectedValue = event.target.value;
        // Your logic for handling the radio button click goes here
        console.log(`Selected option: ${selectedValue}`);
        
    }
    handleInputChange(event) {
        // Get the input value
        let inputValue = event.target.value;

        // Remove non-numeric characters using a regular expression
        inputValue = inputValue.replace(/[^0-9.]/g, '');

        // Update the input field value with only numeric characters
        event.target.value = inputValue;
    }
    @track selectedOption = '';
    option1Class = 'radio-button';
    option2Class = 'radio-button';
    @track showSend =true;
    @track showRefund = false;


    handleButtonClick(event) {
       
        const selectedValue = event.target.value;
        
        this.selectedOption = selectedValue;
        if (selectedValue === 'option1') {
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
    }

    hideModalBox() {  
        this.isShowModal = false;
    }

}