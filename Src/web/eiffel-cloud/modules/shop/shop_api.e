note
	description: "API to handle Shop paymnent."
	date: "$Date$"
	revision: "$Revision$"

class
	SHOP_API

inherit
	CMS_MODULE_API
		rename
			make as make_api
		redefine
			initialize
		end

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_module: SHOP_MODULE; a_api: CMS_API; a_config: SHOP_CONFIG)
		do
			module := a_module
			config := a_config
			make_api (a_api)
			initialize
		end

	initialize
			-- <Precursor>
		do
			Precursor
				-- Storage initialization
			if attached cms_api.storage.as_sql_storage as l_storage_sql then
				create {SHOP_STORAGE_SQL} shop_storage.make (l_storage_sql)
			else
					-- FIXME: in case of NULL storage, should Current be disabled?
				create {SHOP_STORAGE_NULL} shop_storage
			end
		end

feature -- Access

	config: SHOP_CONFIG

	module: SHOP_MODULE

feature {CMS_MODULE} -- Access shop storage.

	shop_storage: SHOP_STORAGE_I

feature -- Access

	new_cart_name: READABLE_STRING_8
		do
			Result := "cart_" + cms_api.new_random_identifier (10, Void)
		end

	new_guest_cart: SHOPPING_CART
		do
			create Result.make_guest (new_cart_name)
		end

	active_shopping_cart (req: WSF_REQUEST): detachable SHOPPING_CART
		local
			s: STRING_32
			i: INTEGER
			u: CMS_USER
		do
			u := cms_api.user
			if u /= Void then
				Result := user_shopping_cart (u)
			end
			if
				(Result = Void or else Result.is_empty) and then
				attached {WSF_STRING} req.cookie (config.cookie_name) as p_cookie
			then
				s := p_cookie.value
				i := s.substring_index ("guest_shop_cid=", 1)
				if i = 1 then
					i := s.index_of ('=', i)
					if i > 0 then
						s.remove_head (i)
						i := s.index_of (';', 1)
						if i > 0 then
							s.keep_head (i - 1)
						end
					end
				end
				Result := guest_shopping_cart (s)
--				create Result.make_guest
--				Result.set_items_from_json_string (utf_8_encoded (p_cookie.value))
				if u /= Void and then Result /= Void and then Result.is_guest then
					Result.set_owner (u)
					save_user_shopping_cart (Result)
				end
			end
			if Result /= Void then
				Result.set_currency (config.default_currency)
				invoke_shop_fill_cart (Result)
				if Result.has_incomplete_item then
					Result.remove_incomplete_items
					save_shopping_cart (Result)
				end
			end
		end

	user_shopping_cart (a_user: CMS_USER): detachable SHOPPING_CART
		do
			Result := shop_storage.user_shopping_cart (a_user)
			if Result = Void and then attached a_user.email as l_email then
				Result := shopping_cart_by_email (l_email)
			end
		end

	shopping_cart (a_cart_name: READABLE_STRING_GENERAL): detachable SHOPPING_CART
		do
			Result := shop_storage.shopping_cart_by_name (a_cart_name)
		end

	shopping_cart_by_email (a_email: READABLE_STRING_8): detachable SHOPPING_CART
		do
			Result := shop_storage.shopping_cart_by_email (a_email)
		end

	guest_shopping_cart (a_cart_name: READABLE_STRING_GENERAL): detachable SHOPPING_CART
		do
			Result := shop_storage.shopping_cart_by_name (a_cart_name)
			if Result = Void and then a_cart_name.is_integer_64 then
				Result := shop_storage.shopping_cart_by_id (a_cart_name.to_integer_64)
			end
		end

	clear_shopping_cart (a_cart: SHOPPING_CART)
		do
			a_cart.items.wipe_out
			if a_cart.is_guest then
				save_guest_shopping_cart (a_cart)
			else
				save_user_shopping_cart (a_cart)
			end
		end

	save_shopping_cart (a_cart: SHOPPING_CART)
		do
			if a_cart.is_guest then
				save_guest_shopping_cart (a_cart)
			else
				save_user_shopping_cart (a_cart)
			end
		end

	save_user_shopping_cart (a_cart: SHOPPING_CART)
		require
			not a_cart.is_guest
		do
			if a_cart.identifier = Void then
				a_cart.set_identifier (new_cart_name)
			end
			shop_storage.save_shopping_cart (a_cart)
		end

	save_guest_shopping_cart (a_cart: SHOPPING_CART)
		require
			a_cart.is_guest
		do
			if a_cart.identifier = Void then
				a_cart.set_identifier (new_cart_name)
			end
			shop_storage.save_shopping_cart (a_cart)
		end

	cart_to_order (a_cart: SHOPPING_CART; a_ref: detachable READABLE_STRING_GENERAL): SHOPPING_ORDER
		require
			not a_cart.is_guest
		local
			l_order_name: detachable READABLE_STRING_8
		do
			if not a_cart.has_details then
				invoke_shop_fill_cart (a_cart)
			end
			l_order_name := a_cart.identifier
			if l_order_name = Void then
				l_order_name := new_cart_name
				a_cart.set_identifier (l_order_name)
				shop_storage.save_shopping_cart (a_cart)
			end
			Result := shop_storage.cart_to_order (a_cart, a_ref, l_order_name)
		end

	order (a_order_name: detachable READABLE_STRING_GENERAL): detachable SHOPPING_ORDER
		do
			if a_order_name /= Void then
				Result := shop_storage.order_by_name (a_order_name)
			end
		end

feature -- Access: customer information

	customer_information (a_user: detachable CMS_USER; a_email: detachable READABLE_STRING_8): detachable SHOP_CUSTOMER
		local
			l_stripe_customer_ids: ARRAYED_LIST [READABLE_STRING_GENERAL]
		do
			if a_user /= Void then
				create Result.make_with_user (a_user)
			elseif a_email /= Void then
				create Result.make_with_email (a_email)
			end
			if Result /= Void then
				if attached {STRIPE_API} cms_api.module_api ({STRIPE_MODULE}) as l_stripe_api then
					create l_stripe_customer_ids.make (0)
					if
						attached Result.user as u and then
					 	attached l_stripe_api.customer_ids_by_uid (u) as lst
					then
						l_stripe_customer_ids.append (lst)
					end
					if
						attached Result.email as e and then
					 	attached l_stripe_api.customer_ids_by_email (e) as lst
					then
						l_stripe_customer_ids.append (lst)
					end
					across
						l_stripe_customer_ids as ic
					loop
						if attached {STRIPE_CUSTOMER} l_stripe_api.customer (ic.item) as cust then
							Result.items ["stripe.customer.id"] := cust.id.to_string_32
							if attached cust.name as l_name then
								Result.items ["stripe.customer.name"] := l_name
							end
							if attached cust.address as add then
								Result.items ["stripe.customer.address"] := add.to_string
							end
--							Result.items [ic.item + ".json"] := cust.to_json_string

						end
					end
				end
			end
		end

feature -- Billings

	billings (a_ref: READABLE_STRING_GENERAL): detachable SHOPPING_BILLS
		local
			l_stripe_ref: READABLE_STRING_GENERAL
			i: INTEGER
			l_records: LIST [STRIPE_PAYMENT_RECORD]
			rec: STRIPE_PAYMENT_RECORD
			l_bill: SHOPPING_BILL
		do
			if
				a_ref.starts_with ("stripe.") and then
				attached {STRIPE_API} cms_api.module_api ({STRIPE_MODULE}) as l_stripe_api
			then
				i := a_ref.index_of ('=', 1)
				if i > 0 then
					l_stripe_ref := a_ref.substring (i + 1, a_ref.count)
					if not l_stripe_ref.is_whitespace then
						if a_ref.starts_with ("stripe.payment") then
							l_records := l_stripe_api.payment_records (l_stripe_ref)
						else
							l_records := l_stripe_api.subscription_payment_records (l_stripe_ref)
						end
						if l_records /= Void and then not l_records.is_empty then
							create Result.make (l_records.count)
							across
								l_records as ic
							loop
								rec := ic.item
								create l_bill.make (rec.date)
								l_bill.external_invoice_url := rec.invoice_url
								l_bill.external_receipt_url := rec.receipt_url
								if attached rec.total as l_total_tuple then
									l_bill.set_total_price_as_string ({SHOPPING_CURRENCY_HELPER}.price_in_cents_as_string (l_total_tuple.price_in_cents, l_total_tuple.currency))
								end
								if
									attached rec.invoice as l_invoice and then
									attached l_invoice.status as l_status
								then
									if l_status.is_case_insensitive_equal ("paid") then
										l_bill.set_status_to_paid
									elseif l_status.is_case_insensitive_equal ("open") then
										l_bill.set_status_to_open
									elseif l_status.is_case_insensitive_equal ("void") then
										l_bill.set_status_to_void
									elseif l_status.is_case_insensitive_equal ("draft") then
										l_bill.set_status_to_draft
									end
								end
								Result.items.force (l_bill)
							end
						end
					end
				end
			end
			if
				Result /= Void and then
				attached shop_storage.order_by_reference (a_ref) as l_order
			then
				across
					Result.items as ic
				loop
					ic.item.set_order (l_order)
				end
			end
		end

feature -- Hook invocation		

	invoke_shop_fill_cart (a_cart: SHOPPING_CART)
		do
			if attached cms_api.hooks.subscribers ({SHOP_HOOK}) as lst then
				across
					lst as ic
				loop
					if attached {SHOP_HOOK} ic.item as h then
						h.fill_cart (a_cart)
					end
				end
			end
		end

	invoke_shop_fill_cart_item (a_cart: SHOPPING_CART; a_cart_item: SHOPPING_ITEM)
		do
			if attached cms_api.hooks.subscribers ({SHOP_HOOK}) as lst then
				across
					lst as ic
				loop
					if attached {SHOP_HOOK} ic.item as h then
						h.fill_cart_item (a_cart, a_cart_item)
					end
				end
			end
		end

	invoke_commit_cart (a_cart: SHOPPING_CART; a_order: SHOPPING_ORDER)
		do
			if attached cms_api.hooks.subscribers ({SHOP_HOOK}) as lst then
				across
					lst as ic
				loop
					if attached {SHOP_HOOK} ic.item as h then
						h.commit_cart (a_cart, a_order)
					end
				end
			end
		end

feature -- Email factory

	order_confirmation_email (a_email_addr: READABLE_STRING_8; vars: STRING_TABLE [detachable ANY]): CMS_EMAIL
		local
			res: PATH
			s: STRING_8
			msg: READABLE_STRING_8
		do
			create res.make_from_string ("templates")
			if
				attached cms_api.module_theme_resource_location (module, res.extended ("email_order_confirmation.tpl")) as loc and then
				attached cms_api.resolved_smarty_template (loc) as tpl
			then
				across
					vars as ic
				loop
					if attached ic.item as v then
						tpl.set_value (v, ic.key)
					end
				end
				msg := tpl.string
			else
				create s.make_empty
				s.append ("Thank you for your order at " + cms_api.site_url + " .%N")
				if attached {READABLE_STRING_GENERAL} vars ["invoice_url"] as l_invoice_url then
					s.append ("See your invoice at " + html_encoded (l_invoice_url) + " .")
				elseif attached {STRING_TABLE [READABLE_STRING_GENERAL]} vars ["receipt_or_invoice_urls"] as l_urls then
					s.append ("See documents:%N")
					across
						l_urls as ic
					loop
						s.append (html_encoded (ic.key) + " at " + html_encoded (ic.item) +"%N")
					end
				end
				msg := s
			end

			Result := cms_api.new_html_email (a_email_addr, "Thank you for your order at " + utf_8_encoded (config.shop_name), msg)
		end

	subscription_cycle_confirmation_email (a_email_addr: READABLE_STRING_8; vars: STRING_TABLE [detachable ANY]): CMS_EMAIL
		local
			res: PATH
			s: STRING_8
			msg: READABLE_STRING_8
		do
			--FIXME
			create res.make_from_string ("templates")
			if
				attached cms_api.module_theme_resource_location (module, res.extended ("email_subscription_cycle_confirmation.tpl")) as loc and then
				attached cms_api.resolved_smarty_template (loc) as tpl
			then
				across
					vars as ic
				loop
					if attached ic.item as v then
						tpl.set_value (v, ic.key)
					end
				end
				msg := tpl.string
			else
				create s.make_empty
				s.append ("Subscription paid at " + cms_api.site_url + " .%N")
				if attached {READABLE_STRING_GENERAL} vars ["invoice_url"] as l_invoice_url then
					s.append ("See your invoice at " + html_encoded (l_invoice_url) + " .")
				elseif attached {STRING_TABLE [READABLE_STRING_GENERAL]} vars ["receipt_or_invoice_urls"] as l_urls then
					s.append ("See documents:%N")
					across
						l_urls as ic
					loop
						s.append (html_encoded (ic.key) + " at "+ html_encoded (ic.item) +"%N")
					end
				end
				msg := s
			end
			Result := cms_api.new_html_email (a_email_addr, "Subscription invoice", msg)
		end

note
	copyright: "2011-2019, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

