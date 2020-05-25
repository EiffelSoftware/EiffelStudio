var eStripeMod = eStripeMod || { };
eStripeMod.HOST_URL = "";
eStripeMod.ORDER_ID = "";
eStripeMod.META_DATA = null;
eStripeMod.main_box = null;

eStripeMod.createElements = function (data, publicKey) {
  var stripe = Stripe(publicKey);
  var elements = stripe.elements();

	eStripeMod.ORDER_ID = data.metadataOrderId;
	eStripeMod.META_DATA = data.metadata;

  // Element styles
  var style = {
    base: {
      fontSize: '16px',
      color: '#32325d',
      fontFamily:
        '-apple-system, BlinkMacSystemFont, Segoe UI, Roboto, sans-serif',
      fontSmoothing: 'antialiased',
      '::placeholder': {
        color: 'rgba(0,0,0,0.4)'
      }
    }
  };

  var card = elements.create('card', { style: style });

  // Add an instance of the card Element into the `card-element` <div>.
  card.mount('#card-element');

  // Element focus ring
  card.on('focus', function() {
    var el = eStripeMod.main_box.querySelector('#card-element');
    el.classList.add('focused');
  });

  card.on('blur', function() {
    var el = eStripeMod.main_box.querySelector('#card-element');
    el.classList.remove('focused');
  });

  var elt_submit = eStripeMod.main_box.querySelector('#submit');
  elt_submit.addEventListener('click', function(evt) {
    evt.preventDefault();
    changeLoadingState(true);
    // Initiate payment
    createPaymentMethodAndCustomer(stripe, card);
  });
};

eStripeMod.init = function (data, publicKey) {
      eStripeMod.createElements(data, publicKey);
}

eStripeMod.create = function (data) {
  Promise.all([eStripeMod.getPublicKey()])
		.then(function(result) {
		    var [publicKey] = result;
		    eStripeMod.init(data, publicKey);
	  }
	);
}

function showCardError(error) {
  changeLoadingState(false);
  // The card was declined (i.e. insufficient funds, card has expired, etc)
  var errorMsg = eStripeMod.main_box.querySelector('.sr-field-error');
  errorMsg.textContent = error.message;
  setTimeout(function() {
    errorMsg.textContent = '';
  }, 8000);
}

function customer_form_value(fn, box) {
  w = box.querySelector('#' + fn);
  if (w == null) {
	return null;
  } else {
    var str = w.value;
	if (str === null || str.length === 0 || !str.trim() ) {
		return null;
	} else {
		return str;
	}
  }
}

var createPaymentMethodAndCustomer = function(stripe, card) {
  var customer = {address: {}};

	// Get data from html form
  customer['email'] = customer_form_value('customer-email', eStripeMod.main_box);
  customer['name'] = customer_form_value ('customer-name', eStripeMod.main_box);
  customer['phone'] = customer_form_value ('customer-phone', eStripeMod.main_box);
  customer['address']['line1'] = customer_form_value ('customer-address-line1', eStripeMod.main_box);
  customer['address']['line2'] = customer_form_value ('customer-address-line2', eStripeMod.main_box);
  customer['address']['city'] = customer_form_value ('customer-address-city', eStripeMod.main_box);
  customer['address']['postal_code'] = customer_form_value ('customer-address-postal-code', eStripeMod.main_box);
  customer['address']['state'] = customer_form_value ('customer-address-state', eStripeMod.main_box);
  customer['address']['country'] = customer_form_value ('customer-address-country', eStripeMod.main_box);
  var cardItems = customer_form_value ('items', eStripeMod.main_box);
  var j_details = {
		  email: customer['email'],
		};
  if (customer['name'] !== null) { j_details['name'] = customer['name']; }
  if (customer['phone'] !== null) { j_details['phone'] = customer['phone']; }
  if (customer['address'] !== null) { j_details['address'] = customer['address']; }

  stripe
    .createPaymentMethod('card', card, {
      billing_details: j_details
    })
    .then(function(result) {
      if (result.error) {
        showCardError(result.error);
      } else {
        createCustomer(stripe, result.paymentMethod.id, customer, JSON.parse(cardItems));
      }
    });
};

async function createCustomer(stripe, paymentMethod, customer, cardItems) {
  return fetch(eStripeMod.HOST_URL + '/customer_subscription', {
    method: 'post',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      email: customer['email'],
      payment_method: paymentMethod,
	  items: cardItems,
      customer: customer,
	  order_id: eStripeMod.ORDER_ID,
      metadata: eStripeMod.META_DATA
    })
  })
    .then(response => {
      return response.json();
    })
    .then(subscription => {
      handleSubscription(stripe, subscription);
    });
}

function handleSubscription(stripe, subscription) {
  const { latest_invoice } = subscription;
  if (!latest_invoice || latest_invoice === null) {
	  showCardError("Internal error, payment cancelled.");
	  alert ("Internal error, payment cancelled");
  } else {
	  const { payment_intent } = latest_invoice;
	  if (payment_intent) {
		  const { client_secret, status } = payment_intent;

		  if (status === 'requires_action') {
			  stripe.confirmCardPayment(client_secret).then(function(result) {
				  if (result.error) {
					  // Display error message in your UI.
					  // The card was declined (i.e. insufficient funds, card has expired, etc)
					  changeLoadingState(false);
					  showCardError(result.error);
				  } else {
					  // Show a success message to your customer
					  confirmSubscription(subscription.id);
				  }
			  });
		  } else {
			  // No additional information was needed
			  // Show a success message to your customer
			  orderComplete(subscription);
		  }
	  } else {
		  orderComplete(subscription);
	  }
  }
}

function confirmSubscription(subscriptionId) {
  return fetch(eStripeMod.HOST_URL + '/subscription_confirmation', {
    method: 'post',
    headers: {
      'Content-type': 'application/json'
    },
    body: JSON.stringify({
      subscriptionId: subscriptionId
    })
  })
    .then(function(response) {
      return response.json();
    })
    .then(function(subscription) {
      orderComplete(subscription);
    });
}

eStripeMod.getPublicKey = function () {
  return fetch(eStripeMod.HOST_URL + '/public-key', {
    method: 'get',
    headers: {
      'Content-Type': 'application/json'
    }
  })
    .then(function(response) {
      return response.json();
    })
    .then(function(stripePublicKey) {
      return stripePublicKey.publicKey;
    });
}

//getPublicKey();

/* ------- Post-payment helpers ------- */

/* Shows a success / error message when the payment is complete */
var orderComplete = function(subscription) {
  changeLoadingState(false);
  var subscriptionJson = JSON.stringify(subscription, null, 2);
  eStripeMod.main_box.querySelectorAll('.payment-view').forEach(function(view) {
    view.classList.add('hidden');
  });
  eStripeMod.main_box.querySelectorAll('.completed-view').forEach(function(view) {
    view.classList.remove('hidden');
  });
  eStripeMod.main_box.querySelector('.order-status').textContent = subscription.status;
  l_summary = '<a href="' + subscription.latest_invoice.hosted_invoice_url + '">Check your Invoice</a> (<a href="' + subscription.latest_invoice.invoice_pdf + '">PDF</a>)';
  eStripeMod.main_box.querySelector('.order-summary').innerHTML = l_summary;
  //eStripeMod.main_box.querySelector('code').textContent = subscriptionJson;
};

// Show a spinner on subscription submission
var changeLoadingState = function(isLoading) {
  if (isLoading) {
    eStripeMod.main_box.querySelector('#spinner').classList.add('loading');
    eStripeMod.main_box.querySelector('button').disabled = true;

    eStripeMod.main_box.querySelector('#button-text').classList.add('hidden');
  } else {
    eStripeMod.main_box.querySelector('button').disabled = false;
    eStripeMod.main_box.querySelector('#spinner').classList.remove('loading');
    eStripeMod.main_box.querySelector('#button-text').classList.remove('hidden');
  }
};

function setup(a_host_url,a_stripe_box) {
	eStripeMod.HOST_URL=a_host_url;
	eStripeMod.main_box=a_stripe_box;
}
function create(data) {
	return eStripeMod.create(data);
}
function toggleElementsModalVisibility() {
	return eStripeMod.toggleElementsModalVisibility();
}

window.eStripeEltsModal = (() => {
  return {setup, create, toggleElementsModalVisibility };
})();

