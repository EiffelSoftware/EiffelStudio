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
					required="required"
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
					required="required"
                    id="customer-phone"
                    placeholder="Phone"
                    class="sr-input"
                    value="{htmlentities}{$customer_phone/}{/htmlentities}"
                  />
				  </div>
				</div>
                <div class="sr-combo-inputs-row">
				  <div class="user-information">
				  <h3>User information</h3>
				  <label for="customer-address-line1">Street address:</label>
                  <input
                    type="text"
					required="required"
                    id="customer-address-line1"
                    placeholder="Street #1"
                    class="sr-input"
                    value="{htmlentities}{$customer_address_street1/}{/htmlentities}"
                  />
                  <input
                    type="text"
                    id="customer-address-line2"
                    placeholder="Street #2"
                    class="sr-input"
                    value="{htmlentities}{$customer_address_street2/}{/htmlentities}"
                  />
				  <label for="customer-address-city">City:</label>
                  <input
                    type="text"
					required="required"
                    id="customer-address-city"
                    placeholder="City"
                    class="sr-input"
                    value="{htmlentities}{$customer_address_city/}{/htmlentities}"
                  />
				  <label for="customer-address-postal-code">Postal code/ZIP:</label>
                  <input
                    type="text"
					required="required"
                    id="customer-address-postal-code"
                    placeholder="Postal code"
                    class="sr-input"
                    value="{htmlentities}{$customer_address_postal_code/}{/htmlentities}"
                  />
				  <label for="customer-address-state">State/Region:</label>
                  <input
                    type="text"
					required="required"
                    id="customer-address-state"
                    placeholder="State"
                    class="sr-input"
                    value="{htmlentities}{$customer_address_state/}{/htmlentities}"
                  />
				  <label for="customer-address-country">Country:</label>
					<select name="customer-address-country" 
					  required="required"
					  id="customer-address-country"
                      class="sr-input"
					>
					  <option value="">...</option>
					  <option value="AU" {if condition="$customer_address_country ~ 'AU'"}selected="selected"{/if}>Australia</option>
					  <option value="AT" {if condition="$customer_address_country ~ 'AT'"}selected="selected"{/if}>Austria</option>
					  <option value="BE" {if condition="$customer_address_country ~ 'BE'"}selected="selected"{/if}>Belgium</option>
					  <option value="BR" {if condition="$customer_address_country ~ 'BR'"}selected="selected"{/if}>Brazil</option>
					  <option value="CA" {if condition="$customer_address_country ~ 'CA'"}selected="selected"{/if}>Canada</option>
					  <option value="CN" {if condition="$customer_address_country ~ 'CN'"}selected="selected"{/if}>China</option>
					  <option value="DK" {if condition="$customer_address_country ~ 'DK'"}selected="selected"{/if}>Denmark</option>
					  <option value="FI" {if condition="$customer_address_country ~ 'FI'"}selected="selected"{/if}>Finland</option>
					  <option value="FR" {if condition="$customer_address_country ~ 'FR'"}selected="selected"{/if}>France</option>
					  <option value="DE" {if condition="$customer_address_country ~ 'DE'"}selected="selected"{/if}>Germany</option>
					  <option value="HK" {if condition="$customer_address_country ~ 'HK'"}selected="selected"{/if}>Hong Kong</option>
					  <option value="IE" {if condition="$customer_address_country ~ 'IE'"}selected="selected"{/if}>Ireland</option>
					  <option value="IT" {if condition="$customer_address_country ~ 'IT'"}selected="selected"{/if}>Italy</option>
					  <option value="JP" {if condition="$customer_address_country ~ 'JP'"}selected="selected"{/if}>Japan</option>
					  <option value="LU" {if condition="$customer_address_country ~ 'LU'"}selected="selected"{/if}>Luxembourg</option>
					  <option value="MY" {if condition="$customer_address_country ~ 'MY'"}selected="selected"{/if}>Malaysia</option>
					  <option value="MX" {if condition="$customer_address_country ~ 'MX'"}selected="selected"{/if}>Mexico</option>
					  <option value="NL" {if condition="$customer_address_country ~ 'NL'"}selected="selected"{/if}>Netherlands</option>
					  <option value="NZ" {if condition="$customer_address_country ~ 'NZ'"}selected="selected"{/if}>New Zealand</option>
					  <option value="NO" {if condition="$customer_address_country ~ 'NO'"}selected="selected"{/if}>Norway</option>
					  <option value="PT" {if condition="$customer_address_country ~ 'PT'"}selected="selected"{/if}>Portugal</option>
					  <option value="SG" {if condition="$customer_address_country ~ 'SG'"}selected="selected"{/if}>Singapore</option>
					  <option value="ES" {if condition="$customer_address_country ~ 'ES'"}selected="selected"{/if}>Spain</option>
					  <option value="SE" {if condition="$customer_address_country ~ 'SE'"}selected="selected"{/if}>Sweden</option>
					  <option value="CH" {if condition="$customer_address_country ~ 'CH'"}selected="selected"{/if}>Switzerland</option>
					  <option value="GB" {if condition="$customer_address_country ~ 'GB'"}selected="selected"{/if}>United Kingdom</option>
					  <option value="US" {if condition="$customer_address_country ~ 'US'"}selected="selected"{/if}>United States</option>
					</select>
				  </label>
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
          <h1>Your order is <span class="order-status"></span></h1>
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
