function submitToGateway(form) {
  console.log("submitToGateway();")

  Iugu.createPaymentToken(form, function(response) {
    if (response.responseerrors) {
      console.log("Erro salvando cartão");
    } else {
      console.log("Token Crédito: " + response.id, response);

      var token = response.id;
      var brand = response.extra_info.brand;
      var last4 = response.extra_info.display_number.match(/([0-9]{4})$/)[0];

      console.log(token);
      console.log(brand);
      console.log(last4);
      document.getElementById('credit-card-token').value = token;
      document.getElementById('credit-card-brand').value = brand;
      document.getElementById('credit-card-last4').value = last4;
      document.getElementById('credit-card-number').value = "";
      document.getElementById('credit-card-cvv').value = "";

      //format.submit();
    }
  });
}

function PaymentMethodForm(id) {
  let form = document.getElementById(id);
  let onFormSubmit = function(e) {
    console.log('onFormSubmit');
    alert(setAccountID)

    // FIXME gateway

    submitToGateway(form);

    e.preventDefault();
    return false;
  }

  return {
    init: function() {
      if (form) {
        if (form.addEventListener){
          form.addEventListener("submit", onFormSubmit, false);  //Modern browsers
        } else if(form.attachEvent) {
          form.attachEvent('onsubmit', onFormSubmit);            //Old IE
        }
      }
    }
  };
}
