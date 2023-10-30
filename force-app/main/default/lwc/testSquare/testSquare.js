import { LightningElement, api, track } from 'lwc';
import SquareJsMod from '@salesforce/resourceUrl/SquareSDKJs';

import { loadScript } from 'lightning/platformResourceLoader';
export default class TestSquare extends LightningElement {

    @track statusMessage = '';
    squareJsInitialized = false;

    async initializeSquareJs() {
        if (this.squareJsInitialized) {
            return;
        }

        try {
            await loadScript(this, SquareJsMod);
            this.squareJsInitialized = true;
        } catch (error) {
            console.error('Error loading Square.js:', error);
        }
    }

    async connectedCallback() {
        this.initializeSquareJs();
        console.log('Callback Working');
        const payments = SquareJsMod.payments('sandbox-sq0idb-RT3u-HhCpNdbMiGg5aXuVg', 'TC4Z3ZEBKRXRH');
        console.log(payments);
        const card = await payments.card();

        await card.attach(this.template.querySelector('.card-container'));
        

        const cardButton = this.template.querySelector('.card-button');
        cardButton.addEventListener('click', async () => {
            const statusContainer = this.template.querySelector('.payment-status-container');

            try {
                const result = await card.tokenize();
                if (result.status === 'OK') {
                    console.log(`Payment token is ${result.token}`);
                    this.statusMessage = 'Payment Successful';
                } else {
                    let errorMessage = `Tokenization failed with status: ${result.status}`;
                    if (result.errors) {
                        errorMessage += ` and errors: ${JSON.stringify(result.errors)}`;
                    }

                    throw new Error(errorMessage);
                }
            } catch (e) {
                console.error(e);
                this.statusMessage = 'Payment Failed';
            }
        });
    }

}