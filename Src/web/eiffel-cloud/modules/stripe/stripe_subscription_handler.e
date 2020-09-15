note
	description: "Summary description for {STRIPE_SUBSCRIPTION_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	STRIPE_SUBSCRIPTION_HANDLER

inherit
	CMS_HANDLER
		rename
			make as make_with_cms_api
		end

	WSF_URI_TEMPLATE_HANDLER

create
	make

feature {NONE} -- Initialization

	make (a_mod: STRIPE_MODULE; a_mod_api: STRIPE_API; a_base_url: READABLE_STRING_8)
		do
			module := a_mod
			make_with_cms_api (a_mod_api.cms_api)
			stripe_api := a_mod_api
		end

feature -- API

	module: STRIPE_MODULE

	stripe_api: STRIPE_API

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		local
			rep: like new_generic_response
			pay: STRIPE_PAYMENT
			l_user: detachable CMS_USER
			l_user_email: detachable READABLE_STRING_8
			l_params: STRING_TABLE [detachable READABLE_STRING_GENERAL]
		do
			if stripe_api.config.is_valid then
				if
					attached {WSF_STRING} req.path_parameter ("category") as p_cat and
					attached {WSF_STRING} req.path_parameter ("checkout") as p_checkout
				then
					if req.percent_encoded_path_info.ends_with_general ("/terms") then
						rep := new_generic_response (req, res)
						rep.set_redirection (rep.api.location_url ("/terms_of_use", Void)) -- Global site terms of use
						rep.set_main_content ("Terms of use ....")
					else
						l_user := stripe_api.cms_api.user
						if attached req.string_item ("contact_email") as s then
							l_user_email := s.to_string_8
						elseif l_user /= Void then
							l_user_email := l_user.email
						end
						if l_user_email /= Void then
							create pay.make (p_cat.value, p_checkout.value)
							pay.set_customer_email (l_user_email)
							if l_user /= Void then
								pay.set_customer_name (l_user.name)
							end
							stripe_api.invoke_prepare_payment (pay)
							rep := new_generic_response (req, res)

							if pay.is_prepared and then not pay.is_empty then
								if
									attached pay.items as l_pay_items
								then
									across
										l_pay_items as ic
									loop
										if attached {STRIPE_PAYMENT_SUBSCRIPTION_ITEM} ic.item as l_sub_item then
											stripe_api.ensure_plan_exists (l_sub_item.plan, l_sub_item.identifier)
										end
									end
								end

								rep.add_javascript_url ("https://js.stripe.com/v3/")
								rep.add_javascript_url (rep.module_resource_url (module, "/files/js/subscription.js", Void))
								rep.add_style (rep.module_resource_url (module, "/files/css/stripe.css", Void), Void)

								create l_params.make_caseless (10)
								l_params ["checkout_price"] := pay.price_text
								l_params ["checkout_title"] := pay.title_or_code
								l_params ["checkout_name"] := pay.code_or_checkout_id
								l_params ["checkout_items"] := safe_string (pay.items_as_json_string)
								l_params ["checkout_category"] := pay.category
								l_params ["title"] := safe_string (pay.business_name)
								l_params ["business_name"] := safe_string (pay.business_name)
								l_params ["customer_email"] := safe_string (pay.customer_email)
								l_params ["customer_name"] := safe_string (pay.customer_name)
								if attached {WSF_STRING} req.form_parameter ("contact_name") as ws then
									l_params ["customer_name"] := safe_string (ws.value)
								end
								if attached {WSF_STRING} req.form_parameter ("contact_phone") as ws then
									l_params ["customer_phone"] := safe_string (ws.value)
								end
								if attached {WSF_STRING} req.form_parameter ("contact_address_street1") as ws then
									l_params ["customer_address_street1"] := safe_string (ws.value)
								end
								if attached {WSF_STRING} req.form_parameter ("contact_address_street2") as ws then
									l_params ["customer_address_street2"] := safe_string (ws.value)
								end
								if attached {WSF_STRING} req.form_parameter ("contact_address_city") as ws then
									l_params ["customer_address_city"] := safe_string (ws.value)
								end
								if attached {WSF_STRING} req.form_parameter ("contact_address_zip") as ws then
									l_params ["customer_address_postal_code"] := safe_string (ws.value)
								end
								if attached {WSF_STRING} req.form_parameter ("contact_address_state") as ws then
									l_params ["customer_address_state"] := safe_string (ws.value)
								end
								if attached {WSF_STRING} req.form_parameter ("contact_address_country") as ws then
									l_params ["customer_address_country"] := safe_string (ws.value)
								elseif attached {WSF_STRING} req.form_parameter ("contact_country") as ws then
									l_params ["customer_address_country"] := safe_string (ws.value)
								end
								l_params ["order_id"] := safe_string (pay.order_id)
								l_params ["metadata"] := safe_string (pay.meta_data_as_json_string)
								l_params ["stripe_host_url"] := stripe_api.cms_api.webapi_path (stripe_api.config.base_path)

								rep.set_main_content (card_html (l_params))
							else
								if pay.is_empty then
									rep.set_main_content ("Cart is empty")
									rep.add_warning_message ("Shopping cart is empty")
								else
									rep.set_main_content ("No payment information for <strong>" + html_encoded (pay.title_or_code)
											+ " (" + html_encoded (pay.code_or_checkout_id) + ")"
											+ "</strong> in category <strong>" + html_encoded (pay.category)
											+ "</strong> !"
										)
								end
							end
						else
							rep := new_generic_response (req, res)
							if attached {CMS_AUTHENTICATION_MODULE} api.module ({CMS_AUTHENTICATION_MODULE}) as l_auth_module  then
								rep.set_redirection (api.url (l_auth_module.roc_login_location, create {CMS_API_OPTIONS}.make_from_manifest (<<["query", "destination=" + secured_url_content (rep.location)]>>)))
							end
							rep.set_main_content ("We are missing your contact email, please login or register an account first.")
						end
					end
					rep.execute
				else
					send_bad_request (req, res)
				end
			else
				rep := new_generic_response (req, res)
				rep.set_main_content ("<div class=%"error%">Stripe module is not correctly configured!</div>")
				rep.execute
			end
		end

	safe_string (s: detachable READABLE_STRING_GENERAL): READABLE_STRING_GENERAL
		do
			if s = Void then
				Result := ""
			else
				Result := s
			end
		end

	wsf_safe_string (s: detachable WSF_STRING): READABLE_STRING_GENERAL
		do
			if s = Void then
				Result := ""
			else
				Result := s.value
			end
		end

feature -- Resources

	card_html (vars: STRING_TABLE [detachable READABLE_STRING_GENERAL]): STRING_8
		local
			v: detachable READABLE_STRING_GENERAL
			tpl_p: PATH
		do
			create tpl_p.make_from_string ("templates")

			if
				attached api.module_theme_resource_location (module, tpl_p.extended ("checkout.tpl")) as loc and then
				attached api.resolved_smarty_template (loc) as tpl
			then
				across
					vars as ic
				loop
					v := ic.item
					if v = Void then
						v := ""
					end
					tpl.set_value (v, ic.key)
				end
				Result := tpl.string.to_string_8
			else
				Result := card_tpl.twin
				across
					vars as ic
				loop
					v := ic.item
					if v = Void then
						v := ""
					end
					Result.replace_substring_all ("{{" + html_encoded (ic.key) + "}}", html_encoded (v))
				end
				across
					vars as ic
				loop
					v := ic.item
					if v = Void then
						v := ""
					end
					Result.replace_substring_all ("{{raw-" + html_encoded (ic.key) + "}}", utf_8_encoded (v))
				end
			end
		end

	card_tpl: STRING = "[
    <div class="sr-root">
      <div class="sr-main">
        <header class="sr-header">
          <div class="sr-header__logo"></div>
        </header>
        <div class="sr-payment-summary payment-view">
          <h1 class="order-amount">{{checkout_price}}</h1>
          <h4>Subscribe to {{checkout_title}}</h4>
        </div>
        <form>
          <div class="sr-payment-form payment-view">
            <div class="sr-form-row">
              <label for="card-element">
                Payment details
              </label>
              <div class="sr-combo-inputs">
                <div class="sr-combo-inputs-row">
				  <div class="user-contact">
                  <input
                    type="text"
                    id="customer-email"
                    placeholder="Email"
                    autocomplete="cardholder"
                    class="sr-input"
                    value="{{customer_email}}"
                  />
                  <input
                    type="text"
                    id="customer-name"
                    placeholder="Name"
                    class="sr-input"
                    value="{{customer_name}}"
                  />
				  <input
                    type="text"
                    id="customer-phone"
                    placeholder="Phone"
                    class="sr-input"
                    value="{{customer_phone}}"
                  />
				  </div>
				  <div class="user-information">
                  <input
                    type="text"
                    id="customer-address-line1"
                    placeholder="Street #1"
                    class="sr-input"
                    value="{{customer_address_street1}}"
                  />
                  <input
                    type="text"
                    id="customer-address-line2"
                    placeholder="Street #2"
                    class="sr-input"
                    value="{{customer_address_street2}}"
                  />
                  <input
                    type="text"
                    id="customer-address-city"
                    placeholder="City"
                    class="sr-input"
                    value="{{customer_address_city}}"
                  />
                  <input
                    type="text"
                    id="customer-address-postal-code"
                    placeholder="Postal code"
                    class="sr-input"
                    value="{{customer_address_postal_code}}"
                  />
                  <input
                    type="text"
                    id="customer-address-state"
                    placeholder="State"
                    class="sr-input"
                    value="{{customer_address_state}}"
                  />
                  <input
                    type="text"
                    id="customer-address-country"
                    placeholder="Country"
                    class="sr-input"
                    value="{{customer_address_country}}"
                  />                  
				  </div> <!-- info -->
                  <input
                    type="hidden"
                    id="items"
                    value="{{checkout_items}}"
                  />
                </div>
                <div class="sr-combo-inputs-row">
                  <div class="sr-input sr-card-element" id="card-element"></div>
                </div>
              </div>
              <div class="sr-field-error" id="card-errors" role="alert"></div>
            </div>
            <button id="submit">
              <div id="spinner" class="hidden"></div>
              <span id="button-text">Subscribe</span>
            </button>
            <div class="sr-legal-text">
              Your card will be immediately charged
              <span class="order-total">{{checkout_price}}</span>.
            </div>
          </div>
        </form>
        <div class="sr-payment-summary hidden completed-view">
          <h1>Your subscription is <span class="order-status"></span></h1>
          <h4>
            <a>View subscription response:</a>
          </h4>
        </div>
        <div class="sr-section hidden completed-view">
          <div class="sr-callout">
            <pre><code></code></pre>
          </div>
          <button onclick="window.location.href='/'">Back home</button>
        </div>
      </div>
    </div>

  <script defer>
    window.eStripeEltsModal.setup("{{stripe_host_url}}");
    window.eStripeEltsModal.create({
      currency: "USD",
      businessName: "{{business_name}}",
      productTitle: "{{checkout_title}}",
      productName: "{{checkout_name}}",
      productCategory: "{{checkout_category}}",
      customerEmail: "{{customer_email}}",
      customerName: "{{customer_name}}",
      checkoutItems: "{{checkout_items}}",
      metadata: {{raw-metadata}},
      metadataOrderId: "{{order_id}}"
    });
  </script>
	]"


note
	copyright: "2011-2019, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

