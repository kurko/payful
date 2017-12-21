function submitToGateway() {
  console.log("submitToGateway();")
}

function PaymentMethodForm(id) {
  let form = document.getElementById(id);
  let onFormSubmit = function(e) {
    console.log('onFormSubmit');
    submitToGateway();

    console.log(e);
    e.preventDefault();
    return false;
  }

  return {
    init: function() {
      if (form.addEventListener){
        form.addEventListener("submit", onFormSubmit, false);  //Modern browsers
      } else if(form.attachEvent) {
        form.attachEvent('onsubmit', onFormSubmit);            //Old IE
      }
    }
  };
}
