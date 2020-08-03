note
	description: "Summary description for {STRIPE_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	STRIPE_PAYMENT_HANDLER

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
					elseif attached stripe_api.cms_api.user as l_user then
						create pay.make (p_cat.value, p_checkout.value)
						stripe_api.invoke_prepare_payment (pay)
						rep := new_generic_response (req, res)

						if pay.is_prepared then
							rep.add_javascript_url ("https://js.stripe.com/v3/")
							rep.add_javascript_url (rep.module_resource_url (module, "/files/js/onetime_payment.js", Void))
							rep.add_style (rep.module_resource_url (module, "/files/css/stripe.css", Void), Void)

							create l_params.make_caseless (10)
							l_params ["checkout_type"] := "onetime"
							l_params ["checkout_price"] := pay.price_text
							l_params ["checkout_title"] := pay.title_or_checkout_id
							l_params ["checkout_items"] := safe_string (pay.items_as_json_string)
							l_params ["checkout_category"] := pay.category
							l_params ["checkout_name"] := pay.title_or_checkout_id
							l_params ["title"] := safe_string (pay.business_name)
							l_params ["business_name"] := safe_string (pay.business_name)
							l_params ["customer_email"] := safe_string (pay.customer_email)
							l_params ["customer_name"] := safe_string (pay.customer_name)

							l_params ["order_id"] := safe_string (pay.order_id)
							l_params ["metadata"] := safe_string (pay.meta_data_as_json_string)
							l_params ["stripe_host_url"] := stripe_api.cms_api.webapi_path (stripe_api.config.base_path)

							rep.set_main_content (card_html (l_params))
						else
							rep.set_main_content ("No payment information for <strong>" + html_encoded (pay.title_or_checkout_id)
									+ "</strong> in category <strong>" + html_encoded (pay.category)
									+ "</strong> !"
								)
						end
					else
						rep := new_generic_response (req, res)
						if attached {CMS_AUTHENTICATION_MODULE} api.module ({CMS_AUTHENTICATION_MODULE}) as l_auth_module  then
							rep.set_redirection (api.url (l_auth_module.roc_login_location, create {CMS_API_OPTIONS}.make_from_manifest (<<["query", "destination=" + secured_url_content (rep.location)]>>)))
						end
						rep.set_main_content ("Please login or register an account first.")

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

feature -- Handler

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
    <div id="startstate" class="">
      <h2>{{title}}</h2>
      <div class="container">
        <div class="price-and-button-container">
          <div>
            <div class="product-name">{{checkout_title}}</div>
            <div class="product-price">{{checkout_price}}</div>
          </div>
          <button
            type="button"
            class="btn"
            onClick="window.eStripeEltsModal.toggleElementsModalVisibility();"
          >
            Proceed payment
          </button>
        </div>
      </div>
    </div>
    <div id="endstate" class="endstate">
      <h2>{{title}}</h2>
      <div class="success-message">
        <div class="success-text">
          Payment completed. <br />
        </div>
      </div>
    </div>
  <script defer>
    window.eStripeEltsModal.setup("{{stripe_host_url}}");  
    window.eStripeEltsModal.create({
      currency: "USD",
      businessName: "{{business_name}}",
      productName: "{{checkout_name}}",
      productCategory: "{{checkout_category}}",
      customerEmail: "{{customer_email}}",
      customerName: "{{customer_name}}",
      metadataOrderId: "{{order_id}}"
    });
    
    // Remove the comment for this to automatically open the modal demo
    // when the page is loaded
    // window.eStripeEltsModal.toggleElementsModalVisibility();
  </script>

	]"


note
	copyright: "2011-2019, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

