
const functions = require("firebase-functions");
const stripe = require('stripe')(functions.config().stripe.testkey)


exports.stripePay = functions.https.onRequest(async (req, res) => {

    const stripeVendorAccount = "acct_1J55gI2RiTCOL2Qz";

    const fee = (req.query.amount / 100) | 0;



    stripe.paymentMethods.create(
        {
            payment_method: req.query.paym,
        }, {
        stripeAccount: stripeVendorAccount
    },
        function (err, clonedPaymentMethod) {
            if (err !== null) {
                console.log('Error clone: ', err);
                res.send('error');
            } else {
                console.log('clonedPaymentMethod: ', clonedPaymentMethod);

                stripe.paymentIntents.create(
                    {
                        amount: req.query.amount,
                        currency: req.query.currency,
                        payment_method: clonedPaymentMethod.id,
                        confirmation_method: 'automatic',
                        confirm: true,
                        application_fee_amount: fee,
                        description: req.query.description,
                    }, {
                    stripeAccount: stripeVendorAccount
                },
                    function (err, paymentIntent) {
                        // asynchronously called
                        const paymentIntentReference = paymentIntent;
                        if (err !== null) {
                            console.log('Error payment Intent: ', err);
                            res.send('error');
                        }

                        else {
                            console.log('Created paymentintent: ', paymentIntent);
                            res.json({ paymentIntent: paymentIntent, stripeAccount: stripeVendorAccount });
                        }
                    }
                );


            }




        });

    // res.send('error');
});



//firebase functions:config:set stripe.testkey="sk_test_51Io5n5SFuluemEibMZCKUkmOBBlPkXq5UeMKmCGMzWIVztREcwfdehJ1d7tvbYhxgLzG9EEJx3PjLVg3gabFmiwA00UqdnvHOa"
