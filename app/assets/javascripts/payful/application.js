//= require_tree .


/*
 * 1. read form
 * 2. validate errors
 * 2a. on error, remove preventdefault
 * 3. send data
 * 4. callback data/input data into form
 * 5. send data to controller
 * 6. capybara tests
 * 7. format/mask expiration
 * 8. in controller, accept expiration as date
 */

window.onload = function() {
  let paymentMethod = new PaymentMethodForm('payment-method-form');
  console.log(paymentMethod.init());

  document.getElementById('credit-card-number').value = "4111111111111111";
  document.getElementById('credit-card-cvv').value = "123";
  document.getElementById('credit-card-expires-at').value = "06/18";
  document.getElementById('credit-card-full-name').value = "First Last";

  // FIXME gateway
  Iugu.setAccountID("65778854349B4D4A8080E3841A8B6C63");
  Iugu.setTestMode(true);

  //document.getElementById('payment-method-form').submit();
}


//console.log(PaymentMethodForm().init());
//console.log(PaymentMethodForm().init());
//PaymentMethodForm().init();
