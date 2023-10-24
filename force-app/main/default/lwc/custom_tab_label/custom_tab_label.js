import { LightningElement } from 'lwc';
import { loadScript, loadStyle } from 'lightning/platformResourceLoader';
import myResource from '@salesforce/resourceUrl/static_reource_name';


export default class PaymentForm extends LightningElement {
    libInitialized = false;

    renderedCallback() {
        if (this.libInitialized) {
            return;
        }
        this.libInitialized = true;

        Promise.all([
            loadScript(this, myResource + '/v3/filename.js'),
            loadScript(this, myResource + '/v3/filename2.js'), // if needed
        ])
            .then(() => {
                // do your stuff when library is loaded successfully.
            })
            .catch(error => {
                // handle the error
            });
    }
    // Define your Stripe public key
    stripePublicKey = 'pk_test_51NncOzKg6zD1tMM3mVHeFKB0mqgnBVWxTVyfanxA4w1T4AyPFij7RxtyoTFHlvU0w4qsVc9Q1eNHyBpZdkdKipYO00yH6etIj6';
    stripe;

    connectedCallback() {
        this.loadStripeScript()
            .then(() => {
                this.initializeStripe();
            })
            .catch((error) => {
                console.error('Error loading Stripe:', error);
            });
    }

    loadStripeScript() {
        return new Promise((resolve, reject) => {
            const script = document.createElement('script');
            script.src = 'https://js.stripe.com/v3/';
            script.onload = () => {
                resolve();
            };
            script.onerror = (error) => {
                reject(error);
            };
            document.body.appendChild(script);
        });
    }

    initializeStripe() {
        if (this.stripe) {
            return; // Stripe is already initialized
        }

        this.stripe = Stripe(this.stripePublicKey);

        this.template.querySelector('lightning-button').addEventListener('click', () => this.submitPayment());
    }

    submitPayment() {
        console.log("Button clicked");

        // Replace with your form input handling to get card details
        const cardNumber = '4242424242424242'; // Test card number
        const expMonth = 12; // Test expiration month
        const expYear = 25; // Test expiration year
        const cvv = '123'; // Test CVV

        this.stripe.createToken('card', {
            number: cardNumber,
            exp_month: expMonth,
            exp_year: expYear,
            cvc: cvv
        })
        .then((result) => {
            console.log('Stripe API response:', result);

            if (result.token) {
                console.log('Token:', result.token);
                // You can now send this token to your server for payment processing
            } else if (result.error) {
                console.error('Error message:', result.error.message);
            } else {
                console.error('Unexpected result:', result);
            }
        })
        .catch((error) => {
            console.error('Error occurred:', error);
        });
    }
}
