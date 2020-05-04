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
			l_html: STRING_8
			l_cart: SHOPPING_CART
			l_cart_count: NATURAL_32
		do
			r := new_generic_response (req, res)
			r.add_style (r.module_resource_url (module, "/files/css/shop.css", Void), Void)
			r.add_javascript_url (r.module_resource_url (module, "/files/js/shop.js", Void))
			r.set_title ("Your shopping cart")
			create l_html.make (1024)
			l_cart := shop_api.active_shopping_cart (req)
			if
				l_cart /= Void and then not l_cart.is_empty and then
				attached {WSF_STRING} req.query_parameter ("remove") as p_remove and then
				p_remove.is_case_insensitive_equal ("all")
			then
				shop_api.clear_shopping_cart (l_cart)
			end
			append_cart_to_html (l_cart, l_html)

			if
				attached shop_api.config.shop_id as l_shop_id and then
				attached {STRIPE_MODULE} api.module ({STRIPE_MODULE}) as l_stripe_module
			then
				if l_cart /= Void then
					l_cart_count := l_cart.count
					if l_cart_count > 0 then
						l_html.append ("<div class=%"actions%">")

						if l_cart.is_onetime then
							l_html.append ("<a href=%""+ api.location_url (l_stripe_module.payment_link (l_shop_id, l_cart.id.out), Void)
									 + "%">Buy now</a>")
						else
							l_html.append ("<a href=%""+ api.location_url (l_stripe_module.subscription_checkout_link (l_shop_id, l_cart.id.out), Void)
									 + "%">Subscribe now</a>")
						end
						l_html.append ("</div>")
					end
				end
			else
				l_html.append ("<div class=%"warning%">Online payment is currently disabled!</div>")
			end

			r.set_main_content (l_html)
			r.execute
		end

	append_cart_to_html (a_cart: detachable SHOPPING_CART; a_html: STRING_8)
		local
			l_item: SHOPPING_ITEM
		do
			a_html.append ("<div class=%"shop-cart%"")
			if a_cart /= Void then
				a_html.append (" data-cid=%"" + a_cart.id.out + "%"")
				if attached a_cart.security as l_security then
					a_html.append (" data-sec=%"" + url_encoded (l_security) + "%"")
				end
			end
			a_html.append_character ('>')

			if a_cart = Void or else a_cart.is_empty then
				a_html.append ("<div class=%"warning%">No item</div>")
			else
				a_html.append ("<table class=%"shop-cart%">")
				a_html.append ("<thead><tr><th>Product</th><th>Provider</th><th>Quantity</th><th>...</th></tr></thead>")
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
					a_html.append (html_encoded (l_item.code))
					a_html.append ("</td>")
					a_html.append ("<td class=%"cart-item-provider%">")
					a_html.append (html_encoded (l_item.provider))
					a_html.append ("</td>")
					a_html.append ("<td class=%"cart-item-count%">")
					a_html.append (l_item.quantity.out)
					a_html.append ("</td>")
					if attached l_item.details as l_item_details then
						a_html.append ("<td class=%"cart-item-data%">")
						a_html.append (l_item_details.price_as_string)
						if l_item_details.is_monthly then
							a_html.append (" /month")
						elseif l_item_details.is_yearly then
							a_html.append (" /year")
						elseif l_item_details.is_weekly then
							a_html.append (" /week")
						elseif l_item_details.is_daily then
							a_html.append (" /day")
						end
						if attached l_item.data as l_data then
							a_html.append (l_data)
						end
						a_html.append ("</td>")
					else
						a_html.append ("<td class=%"cart-item-data%">N/A</td>")
					end
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
			end
			if l_item /= Void then
				l_cart.add_item (l_item)
			end
			save_cart (l_cart, res)
			res.redirect_now (req.percent_encoded_path_info)
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
				res.add_cookie (l_cookie)
			end
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
