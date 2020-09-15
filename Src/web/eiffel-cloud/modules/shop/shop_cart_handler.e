note
	description: "Summary description for {SHOP_CART_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	SHOP_CART_HANDLER

inherit
	CMS_HANDLER
		rename
			make as make_with_cms_api
		end

	WSF_URI_TEMPLATE_HANDLER

create
	make

feature {NONE} -- Initialization

	make (a_mod: SHOP_MODULE; a_mod_api: SHOP_API; a_base_url: READABLE_STRING_8)
		do
			module := a_mod
			make_with_cms_api (a_mod_api.cms_api)
			shop_api := a_mod_api
		end

feature -- API

	module: SHOP_MODULE

	shop_api: SHOP_API

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		local
			rep: like new_generic_response
		do
			if shop_api.config.is_valid then
				if req.is_get_request_method then
					handle_get_cart (req, res)
				elseif req.is_post_request_method then
					handle_post_cart (req, res)
				else
					send_bad_request (req, res)
				end
			else
				rep := new_generic_response (req, res)
				rep.set_main_content ("<div class=%"error%">Shop module is not correctly configured!</div>")
				rep.execute
			end
		end

	handle_get_cart (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_generic_response
		do
			r := cart_get_response (req, res, Void)
			r.execute
		end

	cart_get_response (req: WSF_REQUEST; res: WSF_RESPONSE; a_error_html_message: detachable READABLE_STRING_8): like new_generic_response
		local
			l_html: STRING_8
			l_cart: SHOPPING_CART
			l_cart_count: NATURAL_32
			l_email: READABLE_STRING_8
			l_button_title: READABLE_STRING_GENERAL
			l_user: CMS_USER
			l_is_new_customer: BOOLEAN
			l_form: CMS_FORM
			f_email: WSF_FORM_EMAIL_INPUT
			f: WSF_FORM_FIELD
			f_submit: WSF_FORM_SUBMIT_INPUT
			l_agreement_cb, l_consent_cb: WSF_FORM_CHECKBOX_INPUT
		do
			Result := new_generic_response (req, res)
			Result.add_style (Result.module_resource_url (module, "/files/css/shop.css", Void), Void)
			Result.add_javascript_url (Result.module_resource_url (module, "/files/js/shop.js", Void))
			Result.set_title ("Your shopping cart")
			create l_html.make (1024)
			l_cart := shop_api.active_shopping_cart (req)
			if
				l_cart /= Void and then not l_cart.is_empty and then
				attached {WSF_STRING} req.query_parameter ("remove") as p_remove and then
				p_remove.is_case_insensitive_equal ("all")
			then
				shop_api.clear_shopping_cart (l_cart)
			end
			l_html.append ("<div class=%"shop-cart-page%">")
			if a_error_html_message /= Void then
				l_html.append ("<div class=%"error%">")
				l_html.append (a_error_html_message)
				l_html.append ("</div>%N")
				append_cart_to_html (l_cart, l_html)
			else
				append_cart_to_html (l_cart, l_html)
				if
					attached shop_api.config.shop_id as l_shop_id and then
					attached {STRIPE_MODULE} api.module ({STRIPE_MODULE}) as l_stripe_module
				then
					if l_cart /= Void then
						l_cart_count := l_cart.count
						if l_cart_count > 0 then
							l_user := api.user
							if l_user /= Void then
								l_email := l_user.email
							end
							if
								l_email = Void and then
								attached req.string_item ("shopping_email") as p_email and then
								p_email.is_valid_as_string_8
							then
								l_email := p_email.to_string_8
							end
							if l_email = Void then
								l_html.append ("%N<div class=%"identification%"><h3>Identification</h3>")
								l_html.append ("<p>Please provide an email address where we should send your order information.</p>")
								l_html.append ("[
									<form action="" method="GET"><label for="shopping_email">Email address
										<input type="email" name="shopping_email" id="shopping_email" placeholder="Valid email address"></input>
										<input type="submit" value="Continue"></input>
										</label></form>
									]")
								l_html.append ("</div>")
							else
								if l_cart.email = Void then
									l_cart.set_email (l_email)
									shop_api.save_shopping_cart (l_cart)
								end
								if l_cart.is_onetime then
									create l_form.make (api.location_url (l_stripe_module.payment_link (l_shop_id, l_cart.id.out, l_email), Void), "stripe-payment")
								else
									create l_form.make (api.location_url (l_stripe_module.subscription_checkout_link (l_shop_id, l_cart.id.out, l_email), Void), "stripe-payment")
								end
								l_form.set_method_post
								l_form.extend_html_text ("%N<div class=%"identification%"><h3>Identification</h3>")
								create f_email.make_with_text ("contact_email", l_email)
								f_email.set_label ("Email address")
								f_email.set_description ("You will receive confirmation of your order at the email address you indicated.")
								f_email.enable_required
								f_email.set_disabled (True)
								l_form.extend (f_email)

	--							l_html.append ("<label for=%"contact_email%">Contact email<input type=%"email%" name=%"contact_email%" id=%"contact_email%" value=%"" + html_encoded (l_email) + "%"></input></label>")
								if l_user = Void and attached api.user_api.user_by_email (l_email) as l_shopping_user then
									l_form.extend_html_text ("<p>We found an account for this email %""+ html_encoded (l_email) +"%", <br/>")
									if attached {CMS_AUTHENTICATION_MODULE} api.module ({CMS_AUTHENTICATION_MODULE}) as l_auth_module then
										l_form.extend_html_text ("You can <a href=%"" + api.location_absolute_url (l_auth_module.roc_login_location, Void) + "?destination="+ url_encoded (Result.location) +"%">sign in</a> to continue ...")
									end
									l_form.extend_html_text ("</p>")
								elseif l_user /= Void then
									l_form.extend_html_text ("<br/>%N")
								else
									l_is_new_customer := True
									l_form.extend_html_text ("<p>We cannot find an account for this email %""+ html_encoded (l_email) +"%", <br/>")
									if attached {CMS_AUTHENTICATION_MODULE} api.module ({CMS_AUTHENTICATION_MODULE}) as l_auth_module then
										l_form.extend_html_text ("You can <a href=%"" + api.location_absolute_url (l_auth_module.roc_register_location, Void) + "?destination="+ url_encoded (Result.location) +"%">register a new account</a> to continue ...")
									end
									l_form.extend_html_text ("</p>")
								end
								f := l_stripe_module.new_country_field ("contact_country", "US")
								f.set_label ("Please confirm your country/region")
								l_form.extend (f)

								l_form.extend_html_text ("</div>%N")

								l_form.extend_html_text ("<div class=%"legals%">%N")
								if attached customer_agreement_html as s then
									create l_agreement_cb.make ("customer_agreement")
									l_agreement_cb.set_text_value ("yes")
									l_agreement_cb.set_raw_title (s)
									l_agreement_cb.enable_required
									l_form.extend (l_agreement_cb)
								end

								if attached customer_consent_html as s then
									create l_consent_cb.make ("customer_consent")
									l_consent_cb.set_text_value ("yes")
									l_consent_cb.set_raw_title (s)
									l_consent_cb.enable_required
									l_form.extend (l_consent_cb)
								end
								l_form.extend_html_text ("</div>%N")
								if l_is_new_customer then
									l_button_title := "Proceed as new customer"
								else
									l_button_title := "Proceed"
								end
								create f_submit.make_with_text ("stripe-op", l_button_title)
								f_submit.add_css_class ("button")
								l_form.extend (f_submit)

	--							l_stripe_module.fill_payment_form (l_user, l_email, l_form)
								l_form.append_to_html (Result.wsf_theme, l_html)
							end
						end
					end
				else
					l_html.append ("<div class=%"warning%">Online payment is currently disabled!</div>")
				end
			end
			l_html.append ("</div>")

			Result.set_main_content (l_html)
		end

	customer_agreement_html: detachable READABLE_STRING_8
		local
			tpl_p: PATH
		do
			create tpl_p.make_from_string ("templates")

			if
				attached api.module_theme_resource_location (module, tpl_p.extended ("shop_agreement.tpl")) as loc and then
				attached api.resolved_smarty_template (loc) as tpl
			then
				tpl.set_value (shop_api.config.shop_name, "shop_name")
				Result := tpl.string
			else
				api.log_error (module.name, "Missing shop_agreement.tpl", Void)
			end
		end

	customer_consent_html: detachable READABLE_STRING_8
		local
			tpl_p: PATH
		do
			create tpl_p.make_from_string ("templates")

			if
				attached api.module_theme_resource_location (module, tpl_p.extended ("shop_consent.tpl")) as loc and then
				attached api.resolved_smarty_template (loc) as tpl
			then
				tpl.set_value (shop_api.config.shop_name, "shop_name")
				Result := tpl.string
			else
				api.log_error (module.name, "Missing shop_consent.tpl", Void)
			end
		end

	append_cart_to_html (a_cart: detachable SHOPPING_CART; a_html: STRING_8)
		local
			l_item: SHOPPING_ITEM
			s32: STRING_32
			l_providers: ARRAYED_LIST [READABLE_STRING_32]
			l_intervals: ARRAYED_LIST [READABLE_STRING_8]
			l_interval: READABLE_STRING_8
			l_unique_provider: detachable READABLE_STRING_32
		do
			a_html.append ("<div class=%"shop-cart%"")
			if a_cart /= Void then
				a_html.append (" data-cid=%"" + a_cart.id.out + "%"")
				a_html.append (" data-currency=%"" + a_cart.currency + "%"")
				if attached a_cart.security as l_security then
					a_html.append (" data-sec=%"" + url_encoded (l_security) + "%"")
				end
			end
			a_html.append_character ('>')

			if a_cart = Void or else a_cart.is_empty then
				a_html.append ("<div class=%"warning%">No items</div>")
			else
				create l_providers.make (1); l_providers.compare_objects
				create l_intervals.make (1); l_intervals.compare_objects
				across
					a_cart.items as ic
				loop
					l_item := ic.item
					if not l_providers.has (l_item.provider) then
						l_providers.force (l_item.provider)
					end
					if attached l_item.details as l_item_details then
						if l_item_details.is_monthly then
							l_interval := "/month"
						elseif l_item_details.is_yearly then
							l_interval := "/year"
						elseif l_item_details.is_weekly then
							l_interval := "/week"
						elseif l_item_details.is_daily then
							l_interval := "/day"
						else
							l_interval := Void
						end
						if l_interval /= Void then
							if not l_intervals.has (l_interval) then
								l_intervals.force (l_interval)
							end
						end
					end
				end
				if l_providers.count = 1 then
					l_unique_provider := l_providers.first
				end
				a_html.append ("<table class=%"shop-cart%">")
				if l_unique_provider /= Void then
					a_html.append ("<thead><tr><th>Product(s)</th><th>Item Price</th><th>Quantity</th></tr></thead>")
				else
					a_html.append ("<thead><tr><th>Product</th><th>Provider</th><th>Item Price</th><th>Quantity</th></tr></thead>")
				end
				a_html.append ("<tbody>")
				across
					a_cart.items as ic
				loop
					l_item := ic.item
					a_html.append ("<tr class=%"cart-item%"")
					a_html.append (" data-item-code=%"" + url_encoded (l_item.code) + "%"")
					a_html.append (" data-item-provider=%"" + url_encoded (l_item.provider) + "%"")
					a_html.append_character ('>')
					a_html.append ("<td class=%"cart-item-code%">")
					if attached l_item.details as l_details and then attached l_details.title as l_title then
						a_html.append (html_encoded (l_title))
					else
						a_html.append (html_encoded (l_item.code))
					end
					a_html.append ("</td>")
					if l_unique_provider = Void then
						a_html.append ("<td class=%"cart-item-provider%">")
						a_html.append (html_encoded (l_item.provider))
						a_html.append ("</td>")
					end
					if attached l_item.details as l_item_details then
						a_html.append ("<td class=%"cart-item-data%" data-price=%""+ l_item_details.price_in_cents.out +"%">")
						a_html.append (html_encoded (l_item_details.price_as_string))
						if l_item_details.is_monthly then
							l_interval := "/month"
						elseif l_item_details.is_yearly then
							l_interval := "/year"
						elseif l_item_details.is_weekly then
							l_interval := "/week"
						elseif l_item_details.is_daily then
							l_interval := "/day"
						else
							l_interval := Void
						end
						if l_interval /= Void then
							a_html.append (" ")
							a_html.append (l_interval)
							if not l_intervals.has (l_interval) then
								l_intervals.force (l_interval)
							end
						end
						if attached l_item.data as l_data then
							a_html.append (l_data)
						end
						a_html.append ("</td>")
					else
						a_html.append ("<td class=%"cart-item-data%">N/A</td>")
					end
					a_html.append ("<td class=%"cart-item-count%" data-quantity=%""+ l_item.quantity.out +"%">")
					a_html.append (l_item.quantity.out)
					a_html.append ("</td>")
					a_html.append ("</tr>")
				end
				a_html.append ("<tr class=%"total%"><td/>")
				if l_unique_provider = Void then
					a_html.append ("<td/>")
				end
				a_html.append ("<td class=%"title%">Total:</td><td class=%"total%">")
				a_html.append (html_encoded (a_cart.price_as_string))
				if l_intervals.count = 1 then
					a_html.append (" ")
					a_html.append (l_intervals.first)
				end
				a_html.append ("</td>")
				a_html.append ("</tr>")
				if attached a_cart.currency_sign as l_sign then
					a_html.append ("<tr>")
					if l_unique_provider = Void then
						a_html.append ("<td/><td/><td/>")
					else
						a_html.append ("<td/><td/>")
					end
					a_html.append ("<td class=%"notes%">")
					create s32.make (8)
					s32.append_character (l_sign)
					s32.append_string ({STRING_32} " = ")
					s32.append_string_general (a_cart.currency.as_upper)
					a_html.append (html_encoded (s32) + "</td>")
					a_html.append ("</tr>")
				end

				a_html.append ("</tbody>")
				a_html.append ("</table>")

				a_html.append ("<a href=%""+ module.wipe_out_cart_link (a_cart) +"%" class=%"cart-reset%">Remove all items</a>")
			end
			a_html.append ("</div>")
		end

	handle_post_cart (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_html: STRING_8
			l_cart: SHOPPING_CART
			l_item: SHOPPING_ITEM
			l_code, l_provider: READABLE_STRING_GENERAL
			r: like cart_get_response
			l_err_html: STRING_8
			l_item_interval: STRING
			l_item_interval_count: NATURAL_8
		do
			if attached {WSF_STRING} req.query_parameter ("itemProvider") as p_provider then
				l_provider := p_provider.value
			end
			if attached {WSF_STRING} req.query_parameter ("itemCode") as p_code then
				l_code := p_code.value
			end
			if l_provider /= Void and l_code /= Void then
				create l_item.make (l_code, l_provider)
				l_item.quantity := 1
			end

			create l_html.make_empty
			l_cart := shop_api.active_shopping_cart (req)
			if l_cart = Void then
				create l_cart.make_guest
			else
				shop_api.invoke_shop_fill_cart (l_cart)
			end
			if l_item /= Void then
				shop_api.invoke_shop_fill_cart_item (l_cart, l_item)
				if l_cart.is_item_compatible (l_item) then
					l_cart.add_item (l_item)
				else
					create l_err_html.make_empty
					l_err_html.append ("Impossible to add item <strong>")
					l_err_html.append (html_encoded (l_item.code))
					if attached l_item.title as l_item_title then
						l_err_html.append (" &quot;")
						l_err_html.append (html_encoded (l_item_title))
						l_err_html.append ("&quot;")
					end
					l_err_html.append ("</strong> from <strong>" + html_encoded (l_item.provider) + "</strong>.")
					if attached l_item.details as l_details then
						l_item_interval_count := l_details.interval_count
						inspect
							l_details.interval_type
						when {SHOPPING_ITEM_DETAILS}.interval_type_onetime then
							l_item_interval := "one-time"
						when {SHOPPING_ITEM_DETAILS}.interval_type_daily then
							if l_item_interval_count > 1 then
								l_item_interval := "every " + l_item_interval_count.out + " days"
							else
								l_item_interval := "per day"
							end
						when {SHOPPING_ITEM_DETAILS}.interval_type_weekly then
							if l_item_interval_count > 1 then
								l_item_interval := "every " + l_item_interval_count.out + " weeks"
							else
								l_item_interval := "per week"
							end
						when {SHOPPING_ITEM_DETAILS}.interval_type_monthly then
							if l_item_interval_count > 1 then
								l_item_interval := "every " + l_item_interval_count.out + " months"
							else
								l_item_interval := "per month"
							end
						when {SHOPPING_ITEM_DETAILS}.interval_type_yearly then
							if l_item_interval_count > 1 then
								l_item_interval := "every " + l_item_interval_count.out + " years"
							else
								l_item_interval := "per year"
							end
						else
							l_item_interval := Void
						end
						if l_item_interval /= Void then
							l_err_html.append ("<br/>The payment (<strong>" + l_item_interval + "</strong>) is conflicting with the cart item")
						else
							l_err_html.append ("<br/>The one-time payment is conflicting with the cart item")
						end
						if l_cart.count > 1 then
							l_err_html.append ("s.")
						else
							l_err_html.append (".")
						end
						l_err_html.append ("<br/>This cart contains only <strong>")
						if l_cart.is_yearly then
							l_err_html.append ("yearly")
						elseif l_cart.is_monthly then
							l_err_html.append ("monthly")
						elseif l_cart.is_weekly then
							l_err_html.append ("weekly")
						elseif l_cart.is_daily then
							l_err_html.append ("daily")
						else
							check l_cart.is_onetime end
							l_err_html.append ("one-time")
						end
						l_err_html.append ("</strong> items.")
						l_err_html.append ("<br/><br/>Either remove the conflicting item(s), or choose another item ... ")
						if attached req.http_referer as l_referer then
							l_err_html.append (" <a href=%"" + l_referer + "%">Go Back</a>")
						end
					end
				end
			end
			if l_err_html /= Void then
				r := cart_get_response (req, res, l_err_html)
				r.execute
			else
				if not l_cart.is_empty then
					save_cart (l_cart, res)
				end
				r := cart_get_response (req, res, Void)
				r.set_redirection (r.location)
				r.execute
--				res.redirect_now (req.percent_encoded_path_info)
			end
		end

	save_cart (a_cart: SHOPPING_CART; res: WSF_RESPONSE)
		local
			l_cookie: WSF_COOKIE
			s: STRING_32
		do
			if attached api.user as u then
				a_cart.set_owner (u)
				shop_api.save_user_shopping_cart (a_cart)
			else
				shop_api.save_guest_shopping_cart (a_cart)
				s := "guest_shop_cid=" + a_cart.id.out
				create l_cookie.make (shop_api.config.cookie_name, utf_8_encoded (s))
				l_cookie.set_path ("/")
				res.add_cookie (l_cookie)
			end
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
