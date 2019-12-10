var eStripeMod = eStripeMod || { };
eStripeMod.HOST_URL = "";

eStripeMod.browserLocale = function () {
  var lang;
  if (navigator.languages && navigator.languages.length) { // latest versions of Chrome and Firefox set this correctly
    lang = navigator.languages[0];
  } else if (navigator.userLanguage) { // IE only
    lang = navigator.userLanguage;
  } else { // latest versions of Chrome, Firefox, and Safari set this correctly
    lang = navigator.language;
  }
  return lang;
}

eStripeMod.calculateDisplayAmountFromCurrency = function (paymentIntent) {
  var amountToDisplay = paymentIntent.amount;
  amountToDisplay = amountToDisplay / 100;
  return amountToDisplay.toLocaleString(eStripeMod.browserLocale(), {
    style: "currency",
    currency: paymentIntent.currency
  });
}

eStripeMod.init = function (content, paymentIntent, publicKey) {
  var amount = eStripeMod.calculateDisplayAmountFromCurrency(paymentIntent);
  var modal = document.createElement("div");
  modal.className = "ElementsModal--modal";
  modal.innerHTML = `
  <div class="ElementsModal--modal-content">
  <div class="ElementsModal--top-banner">
    <div class="ElementsModal--sales-info">
      <div class="ElementsModal--top">
        <div class="ElementsModal--company">${content.businessName || ""}</div>
        <button class="ElementsModal--close" onClick="window.eStripeEltsModal.toggleElementsModalVisibility()">
          <svg width="20px" height="20px" viewBox="0 0 20 20" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" >
            <defs>
              <path
                d="M10,8.8766862 L13.6440403,5.2326459 C13.9542348,4.92245137 14.4571596,4.92245137 14.7673541,5.2326459 C15.0775486,5.54284044 15.0775486,6.04576516 14.7673541,6.3559597 L11.1238333,9.99948051 L14.7673541,13.6430016 C15.0775486,13.9531961 15.0775486,14.4561209 14.7673541,14.7663154 C14.4571596,15.0765099 13.9542348,15.0765099 13.6440403,14.7663154 L10,11.1222751 L6.3559597,14.7663154 C6.04576516,15.0765099 5.54284044,15.0765099 5.2326459,14.7663154 C4.92245137,14.4561209 4.92245137,13.9531961 5.2326459,13.6430016 L8.87616671,9.99948051 L5.2326459,6.3559597 C4.92245137,6.04576516 4.92245137,5.54284044 5.2326459,5.2326459 C5.54284044,4.92245137 6.04576516,4.92245137 6.3559597,5.2326459 L10,8.8766862 Z"
                id="path-1"
              ></path>
            </defs>
            <g id="Payment-recipes" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd" >
              <g id="Elements-Popup" transform="translate(-816.000000, -97.000000)" >
                <g id="close-btn" transform="translate(816.000000, 97.000000)">
                  <circle id="Oval" fill-opacity="0.3" fill="#AEAEAE" cx="10" cy="10" r="10" ></circle>
                  <mask id="mask-2" fill="white">
                    <use xlink:href="#path-1"></use>
                  </mask>
                  <use id="Mask" fill-opacity="0.5" fill="#FFFFFF" opacity="0.5" xlink:href="#path-1" ></use>
                </g>
              </g>
            </g>
          </svg>
        </button>
      </div>
      <div class="ElementsModal--product ElementsModal--details">${content.productName || ""}</div>
      <div class="ElementsModal--price ElementsModal--details">${amount}</div>
      <div class="ElementsModal--email ElementsModal--details">${content.customerEmail || ""}</div>
    </div>
  </div>
  <div class="ElementsModal--payment-details">
    <form class="ElementsModal--payment-form" id="payment-form" >
      <div class="form-row">
        <div class="ElementsModal--forms">
          <div class="ElementsModal--form">
            <label for="ElementsModal--card-element">
              <span class="ElementsModal--form-label spacer" >Card details</span >
              <div class="StripeElement" id="card-element">
                <!-- A Stripe Element will be inserted here. -->
              </div>
            </label>
            <!-- Used to display form errors. -->
            <div id="card-errors" class="ElementsModal--error-message" role="alert" ></div>
          </div>

          <div class="ElementsModal--form">
            <input type="hidden" name="amount" value="${amount}" />
            <input type="hidden" name="currency" value="${content.currency}" />
            <input type="hidden" name="description" value="${content.productName}" />
            <button class="ElementsModal--pay-button">Pay ${amount}</button>
          </div>

          <!-- Edit your terms and conditions here   -->
          <div class="footer ElementsModal--footer-text">
            By purchasing this command, you agree to ${content.businessName || "this site"}’s
            <a class="ElementsModal--footer-text" href="terms" >Terms and Conditions.</a>
          </div>
        </div>
      </div>
    </form>
  </div>
</div>
`;
  // insert modal in dom
  document.body.insertBefore(modal, document.body.firstChild);
  eStripeMod.createElements(content, paymentIntent, publicKey);
}

eStripeMod.toggleElementsModalVisibility = function () {
  var modal = document.querySelector(".ElementsModal--modal");
  modal.classList.toggle("ElementsModal--show-modal");
}

eStripeMod.createPaymentIntent = function (content) {
  return fetch(eStripeMod.HOST_URL + "/payment_intents", {
    method: "post",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify(content)
  })
    .then(function(response) {
      return response.json();
    })
    .then(function(paymentIntent) {
      return paymentIntent;
    });
}

eStripeMod.getPublicKey = function () {
  return fetch(eStripeMod.HOST_URL + "/public-key", {
    method: "get",
    headers: {
      "Content-Type": "application/json"
    }
  })
    .then(function(response) {
      return response.json();
    })
    .then(function(stripePublicKey) {
      return stripePublicKey.publicKey;
    });
}

eStripeMod.create = function (content) {
  Promise.all([eStripeMod.createPaymentIntent(content), eStripeMod.getPublicKey()]).then(function(
    result
  ) {
    var [paymentIntent, publicKey] = result;
    eStripeMod.init(content, paymentIntent, publicKey);
  });

  // UI enhancement to dismiss the Elements modal when the user clicks
  // outside of the modal and in the window.
  function dismissElementsModalOnWindowClick(event) {
    var modal = document.querySelector(".ElementsModal--modal");
    if (
      event.target === modal &&
      modal.classList[1] === "ElementsModal--show-modal"
    ) {
      toggleElementsModalVisibility();
    }
  }
  window.addEventListener("click", dismissElementsModalOnWindowClick);

  // Allows the user to dismiss the Elements modal when using the esc key
  document.addEventListener("keyup", function(event) {
    if (event.defaultPrevented) {
      return;
    }

    var key = event.key || event.keyCode;

    if (key === "Escape" || key === "Esc" || key === 27) {
      var modal = document.querySelector(".ElementsModal--modal");
      if (modal.classList[1] === "ElementsModal--show-modal") {
        toggleElementsModalVisibility();
      }
    }
  });
}

eStripeMod.createElements = function (content, paymentIntent, publicKey) {
  var stripe = Stripe(publicKey);

  // Create an instance of Elements.
  var elements = stripe.elements();

  // Custom styling can be passed to options when creating an Element.
  // (Note that this  uses a wider set of styles than the guide below.)
  var style = {
    base: {
      color: "#32325d",
      fontFamily: "-apple-system, BlinkMacSystemFont, sans-serif",
      fontSmoothing: "antialiased",
      fontSize: "16px",
      "::placeholder": {
        color: "#aab7c4"
      }
    },
    invalid: {
      color: "#fa755a",
      iconColor: "#fa755a"
    }
  };

  // Create an instance of the card Element.
  var card = elements.create("card", {
    style: style
  });
  // Add an instance of the card Element into the `card-element` <div>.
  card.mount("#card-element");

  // Handle payment submission when user clicks the pay button.
  var form = document.getElementById("payment-form");
  form.addEventListener("submit", function(event) {
    event.preventDefault();

    stripe
      .confirmCardPayment(paymentIntent.client_secret, {
		description: content.productName,
		receipt_email: content.customerEmail,
        payment_method: {
          card: card,
          billing_details: { email: content.customerEmail, name: content.customerName }
        }
      })
      .then(function(result) {
        if (result.error) {
          var displayError = document.getElementById("card-errors");
          displayError.textContent = result.error.message;
        } else {
          eStripeMod.stripePaymentHandler();
        }
      });
  });
}

// Implement logic to handle the users authorization for payment.
// Here you will want to redirect to a successful payments page, or update the page.
eStripeMod.stripePaymentHandler = function () {
  toggleElementsModalVisibility();
  document.getElementById("endstate").style.display = "block";
  document.getElementById("startstate").style.display = "none";
}

function setup(a_host_url) {
	eStripeMod.HOST_URL=a_host_url;
}
function create(content) {
	return eStripeMod.create(content);
}
function toggleElementsModalVisibility() {
	return eStripeMod.toggleElementsModalVisibility();
}

window.eStripeEltsModal = (() => {
  return {setup, create, toggleElementsModalVisibility };
})();

