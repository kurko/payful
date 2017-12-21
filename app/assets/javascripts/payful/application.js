//= require_tree .

window.onload = function() {
  let paymentMethod = new PaymentMethodForm('payment-method-form');
  console.log(paymentMethod.init());

  //document.getElementById('payment-method-form').submit();
}


//console.log(PaymentMethodForm().init());
//console.log(PaymentMethodForm().init());
//PaymentMethodForm().init();
