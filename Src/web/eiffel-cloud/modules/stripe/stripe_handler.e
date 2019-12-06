note
	description: "Summary description for {STRIPE_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	STRIPE_HANDLER

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
			r: WSF_ROUTER
			p: READABLE_STRING_8
			rep: like new_generic_response
			pay: STRIPE_PAYMENT
		do
			if stripe_api.config.is_valid then
				if
					attached {WSF_STRING} req.path_parameter ("category") as p_cat and
					attached {WSF_STRING} req.path_parameter ("product") as p_prod
				then
					if req.percent_encoded_path_info.ends_with_general ("/terms") then
						rep := new_generic_response (req, res)
						rep.set_redirection (rep.api.location_url ("/terms_of_use", Void)) -- Global site terms of use
						rep.set_main_content ("Terms of use ....")
					else
						create pay.make (p_cat.value, p_prod.value)
						if attached api.hooks.subscribers ({STRIPE_HOOK}) as lst then
							across
								lst as ic
							loop
								if attached {STRIPE_HOOK} ic.item as h then
									h.prepare_payment (pay)
								end
							end
						end
						rep := new_generic_response (req, res)

						if pay.is_prepared then
							rep.add_javascript_url ("https://js.stripe.com/v3/")
							rep.add_javascript_url (rep.module_resource_url (module, "/files/js/elementsModal.js", Void))
							rep.add_style (rep.module_resource_url (module, "/files/css/elementsModal.css", Void), Void)
							rep.add_style (rep.module_resource_url (module, "/files/css/stripe.css", Void), Void)
							rep.set_main_content (card_html(
								<<
									["product.title", pay.title_or_product_name],
									["product.price", pay.price_text],
									["product.category", pay.category],
									["product.name", pay.product_name],
									["title", safe_string (pay.business_name)],
									["business.name", safe_string (pay.business_name)],
									["customer.name", safe_string (pay.customer_name)],
									["customer.email", safe_string (pay.customer_email)],
									["stripe.host_url", stripe_api.cms_api.webapi_path (stripe_api.config.base_path)]
								>>
								))
						else
							rep.set_main_content ("No payment information for <strong>" + html_encoded (pay.title_or_product_name)
									+ "</strong> in category <strong>" + html_encoded (pay.category)
									+ "</strong> !"
								)
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

feature -- Handler

feature -- Resources

	card_html (vars: ITERABLE [TUPLE [name: READABLE_STRING_GENERAL; value: detachable READABLE_STRING_GENERAL]]): STRING_8
		local
			v: detachable READABLE_STRING_GENERAL
		do
			Result := card_tpl.twin
			across
				vars as ic
			loop
				v := ic.item.value
				if v = Void then
					v := ""
				end
				Result.replace_substring_all ("{{" + html_encoded (ic.item.name) + "}}", html_encoded (v))
			end
		end

	card_tpl: STRING = "[
    <div id="startstate" class="">
      <h2>{{title}}</h2>
      <div class="container">
        <div class="price-and-button-container">
          <div>
            <div class="product-name">{{product.title}}</div>
            <div class="product-price">{{product.price}}</div>
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
    window.eStripeEltsModal.setup("{{stripe.host_url}}");  
    window.eStripeEltsModal.create({
      currency: "USD",
      businessName: "{{business.name}}",
      productName: "{{product.name}}",
      productCategory: "{{product.category}}",
      customerEmail: "{{customer.email}}",
      customerName: "{{customer.name}}"
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

