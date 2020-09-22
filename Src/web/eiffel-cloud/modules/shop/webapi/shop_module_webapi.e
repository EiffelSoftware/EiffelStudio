note
	description: "Summary description for {SHOP_MODULE}."
	date: "$Date$"
	revision: "$Revision$"

class
	SHOP_MODULE_WEBAPI

inherit
	CMS_MODULE_WEBAPI [SHOP_MODULE]
		redefine
			setup_hooks
		end

	CMS_HOOK_AUTO_REGISTER

--	SHOP_HOOK

create
	make

feature {NONE} -- Router/administration

	setup_webapi_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		local
			cfg: SHOP_CONFIG
			l_base_path: READABLE_STRING_8
		do
			if attached module.shop_api as l_mod_api then
				cfg := l_mod_api.config
				l_base_path := cfg.base_path
				a_router.handle (l_base_path + "/carts/", create {WSF_URI_AGENT_HANDLER}.make (agent handle_get_carts (?,?,l_mod_api)), a_router.methods_get)
				a_router.handle (l_base_path + "/carts/{cid}", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_get_cart (?,?,l_mod_api)), a_router.methods_get)

				a_router.handle (l_base_path + "/carts/{cid}/{provider}/{code}", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_get_cart_item (?,?,l_mod_api)), a_router.methods_get)
				a_router.handle (l_base_path + "/carts/{cid}/{provider}/{code}", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_update_cart_item (?,?,l_mod_api)), a_router.methods_put_post)
				a_router.handle (l_base_path + "/carts/{cid}/{provider}/{code}", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_delete_cart_item (?,?,l_mod_api)), a_router.methods_delete)

				a_router.handle (l_base_path + "/carts/{cid}/{provider}/{code}/{field}/{value}", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_modify_cart_item (?,?,l_mod_api)), a_router.methods_put)
			end
		end

feature -- Routes

	handle_get_carts (req: WSF_REQUEST; res: WSF_RESPONSE; api: SHOP_API)
		local
			r: like new_response
			l_cart: SHOPPING_CART
		do
			r := new_response (req, res, api)
			if attached api.cms_api.user as u then
				l_cart := api.user_shopping_cart (u)
				if l_cart /= Void then
					r.add_link ("cart", Void, req.percent_encoded_path_info + url_encoded (l_cart.identifier))
				end
			else
				r.add_boolean_field ("Succeed", False)
			end
			r.execute
		end

	handle_get_cart (req: WSF_REQUEST; res: WSF_RESPONSE; api: SHOP_API)
		local
			r: like new_response
			l_cart: SHOPPING_CART
			tb: STRING_TABLE [detachable ANY]
		do
			r := new_response (req, res, api)
			if attached {WSF_STRING} req.path_parameter ("cid") as p_cid then
				l_cart := api.guest_shopping_cart (p_cid.value)
			end
			if l_cart /= Void then
				create tb.make_caseless (3)
				tb ["items"] := l_cart.items_to_json_string
				if attached l_cart.modification_date as dt then
					tb ["modification_date"] := date_time_to_timestamp_string (dt)
				end
				r.add_table_iterator_field ("cart", tb)
				across
					l_cart.items as ic
				loop
					r.add_link ({STRING_32} "item_" + ic.item.code, Void, req.percent_encoded_path_info + "/" + url_encoded (ic.item.provider) + "/" + url_encoded (ic.item.code))
				end
			else
				r.add_boolean_field ("Succeed", False)
			end
			r.execute
		end

	handle_get_cart_item (req: WSF_REQUEST; res: WSF_RESPONSE; api: SHOP_API)
		local
			r: like new_response
			tb, tb_details: STRING_TABLE [detachable ANY]
		do
			r := new_response (req, res, api)
			if
				attached shop_cart_and_item (req, api) as l_shop_cart_and_item and then
				attached l_shop_cart_and_item.cart_item as l_shop_item
			then
				create tb.make_caseless (3)
				tb["code"] := l_shop_item.code
				tb["provider"] := l_shop_item.provider
				tb["quantity"] := l_shop_item.quantity
				tb["data"] := l_shop_item.data
				if attached l_shop_item.details as l_details then
					create tb_details.make_caseless (3)
					tb_details["currency"] := l_details.currency
					tb_details["price"] := l_details.price
					if l_details.cents_price > 0 then
						tb_details["cents_price"] := l_details.cents_price
					end
					tb["details"] := tb_details
				end
				r.add_table_iterator_field ("item", tb)
			else
				r.add_boolean_field ("Succeed", False)
			end
			r.execute
		end

	handle_update_cart_item (req: WSF_REQUEST; res: WSF_RESPONSE; api: SHOP_API)
		local
			r: like new_response
			l_cart: SHOPPING_CART
			tb, tb_details: STRING_TABLE [detachable ANY]
		do
			r := new_response (req, res, api)
			if
				attached {WSF_STRING} req.path_parameter ("cid") as p_cid
			then
				l_cart := api.guest_shopping_cart (p_cid.value)
			end
			if
				l_cart /= Void and then
				attached {WSF_STRING} req.path_parameter ("provider") as p_provider and then
				attached {WSF_STRING} req.path_parameter ("code") as p_code and then
				attached l_cart.item (p_code.value, p_provider.value) as l_shop_item
			then
				create tb.make_caseless (3)
				tb["code"] := l_shop_item.code
				tb["provider"] := l_shop_item.provider
				tb["quantity"] := l_shop_item.quantity
				tb["data"] := l_shop_item.data
				if attached l_shop_item.details as l_details then
					create tb_details.make_caseless (3)
					tb_details["currency"] := l_details.currency
					tb_details["price"] := l_details.price
					if l_details.cents_price > 0 then
						tb_details["cents_price"] := l_details.cents_price
					end
					tb["details"] := tb_details
				end
				r.add_table_iterator_field ("item", tb)
			else
				r.add_boolean_field ("Succeed", False)
			end
			r.execute
		end

	handle_delete_cart_item (req: WSF_REQUEST; res: WSF_RESPONSE; api: SHOP_API)
		local
			r: like new_response
		do
			r := new_response (req, res, api)
			if
				attached shop_cart_and_item (req, api) as l_shop_cart_and_item and then
				attached {SHOPPING_CART} l_shop_cart_and_item.cart as l_shop_cart and then
				attached l_shop_cart_and_item.cart_item as l_shop_item
			then
				l_shop_cart.remove_item (l_shop_item)
				api.save_shopping_cart (l_shop_cart)
				r.add_boolean_field ("Succeed", not api.has_error)
			else
				r.add_boolean_field ("Succeed", False)
			end
			r.execute
		end

	handle_modify_cart_item (req: WSF_REQUEST; res: WSF_RESPONSE; api: SHOP_API)
		local
			r: like new_response
			nb: NATURAL_32
		do
			r := new_response (req, res, api)
			if
				attached shop_cart_and_item (req, api) as l_shop_cart_and_item and then
				attached l_shop_cart_and_item.cart as l_shop_cart and then
				attached l_shop_cart_and_item.cart_item as l_shop_item and then
				attached {WSF_STRING} req.path_parameter ("field") as p_fieldname and then
				attached {WSF_STRING} req.path_parameter ("value") as p_fieldvalue
			then
				if
					p_fieldname.is_case_insensitive_equal ("quantity") and then
					p_fieldvalue.is_integer
				then
					nb := p_fieldvalue.integer_value.max (0).to_natural_8
					if nb /= l_shop_item.quantity then
						l_shop_item.set_quantity (nb)
						api.save_shopping_cart (l_shop_cart)
						r.add_boolean_field ("Succeed", not api.has_error)
					else
						r.add_boolean_field ("Succeed", False)
					end
				end
				r.add_boolean_field ("Succeed", not api.has_error)
			else
				r.add_boolean_field ("Succeed", False)
			end
			r.execute
		end

feature -- Helper

	shop_cart_and_item (req: WSF_REQUEST; api: SHOP_API): detachable TUPLE [cart: SHOPPING_CART; cart_item: SHOPPING_ITEM]
		local
			l_cart: SHOPPING_CART
		do
			if
				attached {WSF_STRING} req.path_parameter ("cid") as p_cid
			then
				l_cart := api.guest_shopping_cart (p_cid.value)
			end
			if
				l_cart /= Void and then
				attached {WSF_STRING} req.path_parameter ("provider") as p_provider and then
				attached {WSF_STRING} req.path_parameter ("code") as p_code and then
				attached l_cart.item (p_code.value, p_provider.value) as l_shop_item
			then
				Result := [l_cart, l_shop_item]
			end
		end

feature -- Hooks configuration

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
			module.setup_hooks (a_hooks)
		end

feature {NONE} -- Implementation

	new_response (req: WSF_REQUEST; res: WSF_RESPONSE; api: SHOP_API): HM_WEBAPI_RESPONSE
		do
			create {JSON_WEBAPI_RESPONSE} Result.make (req, res, api.cms_api)
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
