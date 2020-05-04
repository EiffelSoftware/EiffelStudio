    <div class="sr-root" id="stripe-box">
      <div class="sr-main">
        <header class="sr-header">
          <div class="sr-header__logo"></div>
		  <h2>{htmlentities}{$title/}{/htmlentities}</h2>
        </header>
        <div class="sr-payment-summary payment-view">
          <h1 class="order-amount">{htmlentities}{$checkout_price/}{/htmlentities}</h1>
          <h4>Subscribe to {htmlentities}{$checkout_title/}{/htmlentities}</h4>
        </div>
        <form>
          <div class="sr-payment-form payment-view">
            <div class="sr-form-row">
              <div class="sr-combo-inputs">
                <div class="sr-combo-inputs-row">
				  <div class="user-contact">
				  <h3>User Contact</h3>
				  <label for="customer-email">Email address</label>
                  <input
                    type="text"
                    id="customer-email"
                    placeholder="Email"
                    autocomplete="cardholder"
                    class="sr-input"
                    value="{htmlentities}{$customer_email/}{/htmlentities}"
                  />
				  <label for="customer-name">Name (first, last)</label>
                  <input
                    type="text"
                    id="customer-name"
                    placeholder="Name"
                    class="sr-input"
                    value="{htmlentities}{$customer_name/}{/htmlentities}"
                  />
				  <label for="customer-phone">Phone (optional)</label>
				  <input
                    type="text"
                    id="customer-phone"
                    placeholder="Phone"
                    class="sr-input"
                    value=""
                  />
				  </div>
				</div>
                <div class="sr-combo-inputs-row">
				  <div class="user-information">
				  <h3>User information</h3>
				  <label for="customer-address-line1">Street address:</label>
                  <input
                    type="text"
                    id="customer-address-line1"
                    placeholder="Street #1"
                    class="sr-input"
                    value=""
                  />
                  <input
                    type="text"
                    id="customer-address-line2"
                    placeholder="Street #2"
                    class="sr-input"
                    value=""
                  />
				  <label for="customer-address-city">City:</label>
                  <input
                    type="text"
                    id="customer-address-city"
                    placeholder="City"
                    class="sr-input"
                    value=""
                  />
				  <label for="customer-address-postal-code">Postal code/ZIP:</label>
                  <input
                    type="text"
                    id="customer-address-postal-code"
                    placeholder="Postal code"
                    class="sr-input"
                    value=""
                  />
				  <label for="customer-address-state">State/Region:</label>
                  <input
                    type="text"
                    id="customer-address-state"
                    placeholder="State"
                    class="sr-input"
                    value=""
                  />
				  <!--
				  <label for="customer-address-country">Country:</label>
                  <input
                    type="text"
                    id="customer-address-country"
                    placeholder="Country"
                    class="sr-input"
                    value=""
                  />
				  -->
				  </div> <!-- info -->
                  <input
                    type="hidden"
                    id="items"
                    value="{htmlentities}{$checkout_items/}{/htmlentities}"
                  />
                </div>
                <div class="sr-combo-inputs-row">
				  <div class="payment-details" style="width: 100%;">
  				  <h3>Payment details</h3>
				  </div>
				</div>
                <div class="sr-combo-inputs-row">
                  <div class="sr-input sr-card-element" id="card-element"></div>
                </div>
              </div>
              <div class="sr-field-error" id="card-errors" role="alert"></div>
            </div>
            <button id="submit">
              <div id="spinner" class="hidden"></div>
              <span id="button-text">Place Order</span>
            </button>
            <div class="sr-legal-text">
              Your card will be immediately charged
              <span class="order-total">{htmlentities}{$checkout_price/}{/htmlentities}</span>.
            </div>
          </div>
        </form>
        <div class="sr-payment-summary hidden completed-view">
          <h1>Your subscription is <span class="order-status"></span></h1>
        </div>
        <div class="sr-section hidden completed-view">
          <div class="sr-callout">
            <div class="order-summary"></div>
            <pre><code></code></pre>
          </div>
          <button onclick="window.location.href='/'">Back home</button>
        </div>
      </div>
    </div>

  <script defer>
    window.eStripeEltsModal.setup("{$stripe_host_url/}", document.getElementById("stripe-box"));
	{literal}window.eStripeEltsModal.create({ {/literal}
      currency: "USD",
      businessName: "{htmlentities}{$business_name/}{/htmlentities}",
      productName: "{htmlentities}{$checkout_name/}{/htmlentities}",
      productCategory: "{htmlentities}{$checkout_category/}{/htmlentities}",
      customerEmail: "{htmlentities}{$customer_email/}{/htmlentities}",
      customerName: "{htmlentities}{$customer_name/}{/htmlentities}",
      checkoutItems: "{htmlentities}{$checkout_items/}{/htmlentities}",
      {if isset="$metadata"}metadata: {$metadata/},{/if}
      metadataOrderId: "{htmlentities}{$order_id/}{/htmlentities}"
	{literal} }); {/literal}
  </script>
