
var eStripeMod = eStripeMod || { };
eStripeMod.HOST_URL = "";
eStripeMod.ORDER_ID = "";
eStripeMod.META_DATA = null;
eStripeMod.main_box = null;

eStripeMod.createElements = function (data, paymentIntent, publicKey) {
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
    processPaymentIntent(stripe, paymentIntent, card);
  });
};

eStripeMod.init = function (data, paymentIntent, publicKey) {
	eStripeMod.createElements(data, paymentIntent, publicKey);
}

eStripeMod.create = function (data) {
  Promise.all([eStripeMod.createPaymentIntent(data), eStripeMod.getPublicKey()])
  		.then(function(result) {
		    var [paymentIntent, publicKey] = result;
  			console.log (paymentIntent);
		    eStripeMod.init(data, paymentIntent, publicKey);
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

var processPaymentIntent = function(stripe, paymentIntent, card) {
  var customer = {};

	// Get data from html form
  customer['email'] = customer_form_value('customer-email', eStripeMod.main_box);
  customer['name'] = customer_form_value ('customer-name', eStripeMod.main_box);
  customer['phone'] = customer_form_value ('customer-phone', eStripeMod.main_box);
  var cardItems = customer_form_value ('items', eStripeMod.main_box);
  var j_details = {
		  email: customer['email']
		};
  if (customer['name'] !== null) { j_details['name'] = customer['name']; }
  if (customer['phone'] !== null) { j_details['phone'] = customer['phone']; }

  stripe
	.confirmCardPayment(paymentIntent.client_secret, {
		receipt_email: customer['email'],
		payment_method: {
			card: card,
			billing_details: j_details
		}
	})
	.then(function(result) {
		if (result.error) {
			showCardError(result.error);
		} else {
console.log (result);
			//eStripeMod.stripePaymentHandler();
			handlePayment(stripe, result, JSON.parse(cardItems));
		}
	});
};

function handlePayment(stripe, payment, a_card_items) {
	console.log (payment);
	console.log (a_card_items);
	confirmPayment (payment.paymentIntent);
}

function confirmPayment(payment) {
  return fetch(eStripeMod.HOST_URL + '/payment_confirmation', {
    method: 'post',
    headers: {
      'Content-type': 'application/json'
    },
    body: JSON.stringify({
      paymentId: payment.id
    })
  })
    .then(function(response) {
      return response.json();
    })
    .then(function(pay) {
      orderComplete(pay);
    });
}

eStripeMod.createPaymentIntent = function (data) {
  return fetch(eStripeMod.HOST_URL + "/payment_intents", {
    method: "post",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify(data)
  })
    .then(function(response) {
      return response.json();
    })
    .then(function(paymentIntent) {
      return paymentIntent;
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
var orderComplete = function(payment) {
  console.log (payment);
  changeLoadingState(false);
  var paymentJson = JSON.stringify(payment, null, 2);
  eStripeMod.main_box.querySelectorAll('.payment-view').forEach(function(view) {
    view.classList.add('hidden');
  });
  eStripeMod.main_box.querySelectorAll('.completed-view').forEach(function(view) {
    view.classList.remove('hidden');
  });
  eStripeMod.main_box.querySelector('.order-status').textContent = payment.status;
  l_summary = 'Check your Invoice ...';

	l_charges = payment.charges.data;
	l_charges_count = l_charges.length;

  	for (var i=0; i <  l_charges_count; i++) {
	  l_receipt_url = l_charges[i].receipt_url;
  	  l_summary = l_summary + ' <a href="' + l_receipt_url + '">receipt # ' + i + '</a>';
  	}
  eStripeMod.main_box.querySelector('.order-summary').innerHTML = l_summary;
  //eStripeMod.main_box.querySelector('code').textContent = paymentJson;
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

