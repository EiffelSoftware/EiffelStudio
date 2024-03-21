note
	description: "API to handle Stripe paymnent."
	date: "$Date$"
	revision: "$Revision$"

class
	STRIPE_API

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

	make (a_api: CMS_API; a_config: STRIPE_CONFIG)
		do
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
				create {STRIPE_STORAGE_SQL} stripe_storage.make (l_storage_sql)
			else
					-- FIXME: in case of NULL storage, should Current be disabled?
				create {STRIPE_STORAGE_NULL} stripe_storage
			end
		end

feature -- Settings

	config: STRIPE_CONFIG

feature {CMS_MODULE} -- Access nodes storage.

	stripe_storage: STRIPE_STORAGE_I

feature -- Constant

	stripe_api_url: STRING = "https://api.stripe.com/v1/"

feature -- API helpers

	is_valid_api_response (a_response: HTTP_CLIENT_RESPONSE): BOOLEAN
		do
			Result := not a_response.error_occurred and then
					a_response.status /= 404 and then
					a_response.status /= 400
		end

	valid_api_json_object_response (a_response: HTTP_CLIENT_RESPONSE): detachable JSON_OBJECT
		local
			jsonp: JSON_PARSER
		do
			if
				is_valid_api_response (a_response) and then
				attached a_response.body as l_body
			then
				create jsonp.make_with_string (l_body)
				jsonp.parse_content
				if jsonp.is_parsed and then jsonp.is_valid then
					Result := jsonp.parsed_json_object
				end
			end
		end

feature -- Payment intents

	new_card_payment_intent (a_amount: NATURAL_32; a_currency: READABLE_STRING_GENERAL): detachable STRIPE_PAYMENT_INTENT
			-- `a_amount` in cents, a_currency is lowercase.
		require
			a_amount_not_zero: a_amount /= 0
		local
			cl: DEFAULT_HTTP_CLIENT
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
		do
			create cl
			if attached cl.new_session (stripe_api_url) as sess then
				sess.set_credentials (config.secret_key, "")
				create ctx.make_with_credentials_required
				ctx.add_form_parameter ("amount", a_amount.out)
				ctx.add_form_parameter ("currency", a_currency)
				ctx.add_form_parameter ("payment_method_types[]", "card")
				if attached sess.post ("payment_intents", ctx, Void) as l_response then
					if attached valid_api_json_object_response (l_response) as j then
						create Result.make_with_json (j)
						debug
							print (Result)
						end
					end
				end
			end
		end

	payment_intent (a_payment_id: READABLE_STRING_GENERAL): detachable STRIPE_PAYMENT_INTENT
		local
			cl: DEFAULT_HTTP_CLIENT
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
		do
			create cl
			if attached cl.new_session (stripe_api_url) as sess then
				sess.set_credentials (config.secret_key, "")
				create ctx.make_with_credentials_required
				ctx.add_form_parameter ("expand[]", "invoice.payment_intent")
				ctx.add_form_parameter ("expand[]", "charges.data")
				if attached sess.get ("payment_intents/" + url_encoded (a_payment_id), ctx) as l_response then
					if attached valid_api_json_object_response (l_response) as j then
						create Result.make_with_json (j)
						debug
							print (Result)
						end
					end
				end
			end
		end

feature -- Event

	event (a_event_id: READABLE_STRING_GENERAL): detachable STRIPE_EVENT
		local
			cl: DEFAULT_HTTP_CLIENT
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
		do
			create cl
			if attached cl.new_session (stripe_api_url) as sess then
				sess.set_credentials (config.secret_key, "")
				create ctx.make_with_credentials_required
				if attached sess.get ("events/" + url_encoded (a_event_id), ctx) as l_response then
					if attached valid_api_json_object_response (l_response) as j then
						create Result.make_with_json (j)
						debug
							print (Result)
						end
					end
				end
			end
		end

feature -- Subscriptions

	new_subscription (a_default_payment_method_id: detachable READABLE_STRING_GENERAL; a_customer: STRIPE_CUSTOMER;
			a_plan: STRIPE_PLAN; a_metadata: detachable STRING_TABLE [detachable ANY]): detachable STRIPE_SUBSCRIPTION
		do
			Result := new_subscription_with_ids (a_default_payment_method_id, a_customer.id, <<[a_plan.id, {NATURAL_32} 1]>>, a_metadata)
		end

	new_multiple_plans_subscription (a_default_payment_method_id: detachable READABLE_STRING_GENERAL; a_customer: STRIPE_CUSTOMER;
			a_plan_list: LIST [TUPLE [plan: STRIPE_PLAN; quantity: NATURAL_32]];
			a_metadata: detachable STRING_TABLE [detachable ANY]): detachable STRIPE_SUBSCRIPTION
		local
			lst: ARRAYED_LIST [TUPLE [plan_id: READABLE_STRING_GENERAL; quantity: NATURAL_32]]
		do
			create lst.make (a_plan_list.count)
			across
				a_plan_list as ic
			loop
				lst.force ([ic.item.plan.id, ic.item.quantity])
			end
			Result := new_subscription_with_ids (a_default_payment_method_id, a_customer.id, lst, a_metadata)
		end

	new_subscription_with_ids (a_default_payment_method_id: detachable READABLE_STRING_GENERAL; a_customer_id: READABLE_STRING_GENERAL;
			a_plan_list: ITERABLE [TUPLE [plan_id: READABLE_STRING_GENERAL; quantity: NATURAL_32]];
			a_metadata: detachable STRING_TABLE [detachable ANY]): detachable STRIPE_SUBSCRIPTION
		local
			cl: DEFAULT_HTTP_CLIENT
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			i: INTEGER
		do
			create cl
			if attached cl.new_session (stripe_api_url) as sess then
				sess.set_credentials (config.secret_key, "")
				create ctx.make_with_credentials_required
				ctx.add_form_parameter ("customer", a_customer_id)
				if a_default_payment_method_id /= Void then
					ctx.add_form_parameter ("default_payment_method", a_default_payment_method_id)
				end

				across
					a_plan_list as ic
				loop
					ctx.add_form_parameter ("items[" + i.out + "][plan]", ic.item.plan_id)
					if ic.item.quantity /= 1 then
						ctx.add_form_parameter ("items[" + i.out + "][quantity]", ic.item.quantity.out)
					end
					i := i + 1
				end
				if a_metadata /= Void then
					across
						a_metadata as ic
					loop
						if attached {READABLE_STRING_GENERAL} ic.item as v then
							ctx.add_form_parameter ("metadata[" + cms_api.utf_8_encoded (ic.key) + "]", v)
						end
					end
				end

				ctx.add_form_parameter ("expand[]", "latest_invoice.payment_intent")

				if attached sess.post ("subscriptions", ctx, Void) as l_response then
					if attached valid_api_json_object_response (l_response) as j then
						create Result.make_with_json (j)
						debug
							print (Result)
						end
					end
				end
			end
		end

	invoice (a_invoice_id: READABLE_STRING_GENERAL): detachable STRIPE_INVOICE
		local
			cl: DEFAULT_HTTP_CLIENT
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
		do
			create cl
			if attached cl.new_session (stripe_api_url) as sess then
				sess.set_credentials (config.secret_key, "")
				create ctx.make_with_credentials_required
				ctx.add_form_parameter ("expand[]", "customer")
				ctx.add_form_parameter ("expand[]", "payment_intent")
				ctx.add_form_parameter ("expand[]", "subscription")
				if attached sess.get ("invoices/" + url_encoded (a_invoice_id), ctx) as l_response then
					if attached valid_api_json_object_response (l_response) as j then
						create Result.make_with_json (j)
						debug
							print (Result)
						end
					end
				end
			end
		end

	subscription (a_sub_id: READABLE_STRING_GENERAL): detachable STRIPE_SUBSCRIPTION
		local
			cl: DEFAULT_HTTP_CLIENT
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
		do
			create cl
			if attached cl.new_session (stripe_api_url) as sess then
				sess.set_credentials (config.secret_key, "")
				create ctx.make_with_credentials_required
				ctx.add_form_parameter ("expand[]", "latest_invoice.payment_intent")
				if attached sess.get ("subscriptions/" + url_encoded (a_sub_id), ctx) as l_response then
					if attached valid_api_json_object_response (l_response) as j then
						create Result.make_with_json (j)
						debug
							print (Result)
						end
					end
				end
			end
		end

	subscription_invoices (a_sub: STRIPE_SUBSCRIPTION): detachable LIST [STRIPE_INVOICE]
		local
			cl: DEFAULT_HTTP_CLIENT
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
		do
			if attached a_sub.customer_id as l_customer_id then
				create cl
				if attached cl.new_session (stripe_api_url) as sess then
					sess.set_credentials (config.secret_key, "")
					create ctx.make_with_credentials_required
					ctx.add_query_parameter ("customer", l_customer_id)
--					ctx.add_query_parameter ("status", "paid")
					ctx.add_query_parameter ("subscription", a_sub.id)
					ctx.add_query_parameter ("limit", "100") -- Max for now ... check how to get the rest (see has_more, starting_after, ... https://docs.stripe.com/api/invoices/list)
					if attached sess.get ("invoices", ctx) as l_response then
						if attached valid_api_json_object_response (l_response) as j then
							if attached {JSON_ARRAY} (j ["data"]) as l_data then
								create {ARRAYED_LIST [STRIPE_INVOICE]} Result.make (l_data.count)
								across
									l_data as ic
								loop
									if attached {JSON_OBJECT} ic.item as l_invoice_obj then
										Result.force (create {STRIPE_INVOICE}.make_with_json (l_invoice_obj))
									end
								end
							end
							debug
								print (Result)
							end
						end
					end
				end
			end
		end

	cancel_subscription (a_subscription: STRIPE_SUBSCRIPTION): detachable STRIPE_SUBSCRIPTION
		local
			cl: DEFAULT_HTTP_CLIENT
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
		do
			create cl
			if attached cl.new_session (stripe_api_url) as sess then
				sess.set_credentials (config.secret_key, "")
				create ctx.make_with_credentials_required
				if attached sess.delete ("subscriptions/" + a_subscription.id, ctx) as l_response then
					if attached valid_api_json_object_response (l_response) as j then
						create Result.make_with_json (j)
						debug
							print (Result)
						end
					end
				end
			end
		end

	subscription_customer (a_sub: STRIPE_SUBSCRIPTION): detachable STRIPE_CUSTOMER
		require
			a_sub.has_id
		do
			if attached a_sub.customer_id as cid then
				Result := customer (cid)
			elseif
				attached a_sub.latest_invoice as l_invoice
			then
				if attached l_invoice.customer_id as cid then
					Result := customer (cid)
				elseif attached l_invoice.customer_email as l_email then
					Result := customer_by_email (l_email)
				end
			end
		end

	process_payment_intent (a_payment: STRIPE_PAYMENT_INTENT; cust: detachable STRIPE_CUSTOMER; a_order_id: detachable READABLE_STRING_GENERAL; a_metadata: detachable STRING_TABLE [READABLE_STRING_GENERAL])
		local
			l_customer: STRIPE_CUSTOMER
			l_validation: STRIPE_PAYMENT_VALIDATION
		do
			l_customer := cust
			if a_payment.succeeded then
				cms_api.log_debug ({STRIPE_MODULE}.name, "New stripe payment #" + a_payment.id, Void)
				if l_customer = Void then
					if attached a_payment.customer_id as l_cust_id then
						l_customer := customer (l_cust_id)
					end
					if attached a_payment.receipt_email as l_cust_email then
						if l_customer = Void then
							create l_customer.make_with_email (l_cust_email)
						elseif attached l_customer.email as e and then not e.is_case_insensitive_equal_general (l_cust_email) then
							l_customer.set_email (l_cust_email)
						end
					end
				end
				if l_customer /= Void then
					--FIXME!!!!
					create l_validation.make_from_payment_intent (a_payment, l_customer)
					if a_metadata /= Void then
						l_validation.import_metadata (a_metadata)
					end
					if a_order_id /= Void then
						l_validation.set_order_id (a_order_id)
					end
					record_payment_intent (a_payment)
					invoke_validate_payment (l_validation)
				end
			end
		end

	process_new_subscription (sub: STRIPE_SUBSCRIPTION; cust: detachable STRIPE_CUSTOMER; a_order_id: detachable READABLE_STRING_GENERAL; a_metadata: detachable STRING_TABLE [READABLE_STRING_GENERAL])
		local
			l_customer: STRIPE_CUSTOMER
			l_validation: STRIPE_PAYMENT_VALIDATION
			l_invoice: STRIPE_INVOICE
		do
			l_customer := cust
			if sub.is_active then
				cms_api.log_debug ({STRIPE_MODULE}.name, "New stripe subscription #" + sub.id, Void)
				if l_customer = Void then
					l_customer := subscription_customer (sub)
				end
				if l_customer /= Void then
					l_invoice := sub.latest_invoice
					create l_validation.make_from_subscription_creation (sub, l_invoice, l_customer)
					if a_metadata /= Void then
						l_validation.import_metadata (a_metadata)
					end
					if a_order_id /= Void then
						l_validation.set_order_id (a_order_id)
					end
					if l_invoice /= Void then
						if
							l_invoice.payment_intent_id = Void and then
							attached invoice (l_invoice.id) as inv
						then
							l_invoice := inv
						end
						if l_invoice.payment_intent_id /= Void then
							record_invoice (l_invoice)
						else
							cms_api.log_error ({STRIPE_MODULE}.name, "Invoice "+ l_invoice.id +" without payment intent id!", Void)
						end
					end
					invoke_validate_payment (l_validation)
				end
			end
		end

	process_subscription_cycle (sub: STRIPE_SUBSCRIPTION; a_invoice: STRIPE_INVOICE)
		require
			attached sub
			attached a_invoice
		local
			l_customer: STRIPE_CUSTOMER
			l_validation: STRIPE_PAYMENT_VALIDATION
		do
			if sub.is_active then
				cms_api.log_debug ({STRIPE_MODULE}.name, "Subscription cycle #" + sub.id, Void)

				if attached a_invoice.customer_id as l_cust_id then
					l_customer := customer (l_cust_id)
				end
				if l_customer = Void then
					l_customer := subscription_customer (sub)
				end
				if l_customer /= Void then
					create l_validation.make_from_subscription_cycle (sub, a_invoice, l_customer)
					if attached a_invoice.metadata as md then
						l_validation.import_metadata (md)
					end
					if attached a_invoice.metadata_string_item ("order.id", True) as l_order_id then
						l_validation.set_order_id (l_order_id)
					end
					invoke_validate_payment (l_validation)
				else
					cms_api.log_debug ({STRIPE_MODULE}.name, "Stripe missing customer for subscription: " + html_encoded (sub.id), Void)
				end
			end
		end

feature -- Payment method

	attach_payment_method_to_customer (a_payment_method_id: READABLE_STRING_GENERAL; a_customer: STRIPE_CUSTOMER)
		require
			a_customer.has_id
		local
			cl: DEFAULT_HTTP_CLIENT
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			l_response: HTTP_CLIENT_RESPONSE
		do
			create cl
			if attached cl.new_session (stripe_api_url) as sess then
				sess.set_credentials (config.secret_key, "")
				create ctx.make_with_credentials_required

				ctx.add_form_parameter ("customer", a_customer.id)
				l_response := sess.post ("payment_methods/" + url_encoded (a_payment_method_id) + "/attach", ctx, Void)
				if l_response /= Void then
					if attached valid_api_json_object_response (l_response) as j then
						debug
							print (j.representation)
						end
					end
				end
			end
		end
feature -- Customers

	customer_by_email (a_email: READABLE_STRING_GENERAL): detachable STRIPE_CUSTOMER
		do
			if attached customer_ids_by_email (a_email) as lst then
				across
					lst as ic
				until
					Result /= Void
				loop
					Result := customer (ic.item)
				end
			end
			if Result = Void then
				if attached customers (0) as lst then
					across
						lst as ic
					until
						Result /= Void
					loop
						Result := ic.item
						if attached Result.email as s and then a_email.is_case_insensitive_equal (s) then
								-- Found
						else
							Result := Void
						end
					end
				end
				if Result /= Void then
					save_customer_id_with_email (a_email, Result.id)
				end
			end
		end

	customer (a_customer_id: READABLE_STRING_GENERAL): detachable STRIPE_CUSTOMER
		local
			cl: DEFAULT_HTTP_CLIENT
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
		do
			create cl
			if attached cl.new_session (stripe_api_url) as sess then
				sess.set_credentials (config.secret_key, "")
				create ctx.make_with_credentials_required

				if attached sess.get ("customers/" + url_encoded (a_customer_id), ctx) as l_response then
					if attached valid_api_json_object_response (l_response) as j then
						create Result.make_with_json (j)
						debug
							print (Result)
						end
					end
				end
			end
		end

	customers (nb: INTEGER): detachable ARRAYED_LIST [STRIPE_CUSTOMER]
		local
			cl: DEFAULT_HTTP_CLIENT
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
		do
			create cl
			if attached cl.new_session (stripe_api_url) as sess then
				sess.set_credentials (config.secret_key, "")
				create ctx.make_with_credentials_required
				if nb > 0 then
					ctx.add_query_parameter ("limit", nb.out)
				end

				if attached sess.get ("customers", ctx) as l_response then
					if attached valid_api_json_object_response (l_response) as j then
						if attached j.array_item ("data") as j_arr then
							create Result.make (j_arr.count)
							across
								j_arr as ic
							loop
								if attached {JSON_OBJECT} ic.item as jo then
									Result.force (create {STRIPE_CUSTOMER}.make_with_json (jo))
								end
							end
						end
					end
				end
			end
		end

	new_customer (a_customer: STRIPE_CUSTOMER): detachable STRIPE_CUSTOMER
		local
			cl: DEFAULT_HTTP_CLIENT
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			l_response: HTTP_CLIENT_RESPONSE
		do
			create cl
			if attached cl.new_session (stripe_api_url) as sess then
				sess.set_credentials (config.secret_key, "")
				create ctx.make_with_credentials_required
				if attached a_customer.description as l_description then
					ctx.add_form_parameter ("description", l_description)
				end
				if attached a_customer.name as l_name then
					ctx.add_form_parameter ("name", l_name)
				end
				if attached a_customer.email as l_email then
					ctx.add_form_parameter ("email", l_email)
				end
				if attached a_customer.phone as l_phone then
					ctx.add_form_parameter ("phone", l_phone)
				end
				if attached a_customer.invoice_settings as l_invoice_settings then
--					if attached l_invoice_settings.custom_fields as l_custom_fields then
--						ctx.add_form_parameter ("invoice_settings[custom_fields]", l_custom_fields)
--					end
					if attached l_invoice_settings.default_payment_method_id as l_default_payment_method_id then
						ctx.add_form_parameter ("invoice_settings[default_payment_method]", l_default_payment_method_id)
					end
					if attached l_invoice_settings.footer as l_footer then
						ctx.add_form_parameter ("invoice_settings[footer]", l_footer)
					end
				end
				if attached a_customer.address as l_address then
					if attached l_address.line1 as l_line1 then
						ctx.add_form_parameter ("address[line1]", l_line1)
					end
					if attached l_address.line2 as l_line2 then
						ctx.add_form_parameter ("address[line2]", l_line2)
					end
					if attached l_address.city as l_city then
						ctx.add_form_parameter ("address[city]", l_city)
					end
					if attached l_address.postal_code as l_postal_code then
						ctx.add_form_parameter ("address[postal_code]", l_postal_code)
					end
					if attached l_address.state as l_state then
						ctx.add_form_parameter ("address[state]", l_state)
					end
					if attached l_address.country as l_country then
						ctx.add_form_parameter ("address[country]", l_country)
					end
				end
				if a_customer.has_id then
					l_response := sess.post ("customers/" + url_encoded (a_customer.id), ctx, Void)
				else
					l_response := sess.post ("customers", ctx, Void)
				end
				if l_response /= Void then
					if attached valid_api_json_object_response (l_response) as j then
						create Result.make_with_json (j)
						if
							Result.has_id and then
							attached Result.email as l_email
						then
							if
								attached cms_api.user as u and then
								attached u.email as u_email and then
								u_email.is_case_insensitive_equal_general (l_email)
							then
								save_customer_id (u, Result.id)
							else
								save_customer_id_with_email (l_email, Result.id)
							end
						end
					end
				end
			end
		end

	customer_ids_by_uid (a_user: CMS_USER): detachable LIST [READABLE_STRING_32]
		require
			a_user.has_id
		do
			Result := stripe_storage.customers_by_uid (a_user)
		end

	customer_ids_by_email (a_email: READABLE_STRING_GENERAL): detachable LIST [READABLE_STRING_32]
		require
			not a_email.is_whitespace
		do
			Result := stripe_storage.customers_by_email (a_email)
		end

	user_by_customer_id (a_customer_id: READABLE_STRING_GENERAL): detachable CMS_USER
		do
			Result := stripe_storage.user_by_customer_id (a_customer_id)
		end

	save_customer_id (a_user: CMS_USER; a_customer_id: READABLE_STRING_GENERAL)
		require
			a_user.has_id
		do
			stripe_storage.save_customer_id (a_customer_id, a_user.id, a_user.email)
		end

	save_customer_id_with_email (a_email: READABLE_STRING_GENERAL; a_customer_id: READABLE_STRING_GENERAL)
		do
			stripe_storage.save_customer_id (a_customer_id, 0, a_email)
		end

feature -- Payment records

	record_invoice (a_invoice: STRIPE_INVOICE)
		do
			stripe_storage.record_invoice (a_invoice)
		end

	record_payment_intent (pi: STRIPE_PAYMENT_INTENT)
		do
			stripe_storage.record_payment_intent (pi)
		end

	is_payment_processed (a_payment_id: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := stripe_storage.is_payment_processed (a_payment_id)
		end

	payment_records (a_ref: READABLE_STRING_GENERAL): detachable LIST [STRIPE_PAYMENT_RECORD]
		do
			Result := stripe_storage.payment_records (a_ref)
		end

	subscription_payment_records (a_ref: READABLE_STRING_GENERAL): detachable LIST [STRIPE_PAYMENT_RECORD]
		local
			pay: STRIPE_PAYMENT_RECORD
		do
			Result := stripe_storage.subscription_payment_records (a_ref)
			if Result = Void or else Result.is_empty then
				if attached subscription (a_ref) as l_stripe_sub then
					if attached subscription_invoices (l_stripe_sub) as lst then
						if Result = Void then
							create {ARRAYED_LIST [STRIPE_PAYMENT_RECORD]} Result.make (lst.count)
						end
						across
							lst as ic
						loop
							if
								attached ic.item as l_invoice and then
								attached l_invoice.payment_intent_id as l_payment_id
							then
								create pay.make (l_payment_id.to_string_32, l_invoice.creation_date)
								pay.set_data (l_invoice.to_json_string)
								Result.force (pay)
							end
						end
					elseif
						attached l_stripe_sub.latest_invoice as l_invoice and then
						attached l_invoice.payment_intent_id as l_payment_id
					then
						create pay.make (l_payment_id.to_string_32, l_invoice.creation_date)
						pay.set_data (l_invoice.to_json_string)
						if Result = Void then
							create {ARRAYED_LIST [STRIPE_PAYMENT_RECORD]} Result.make (1)
						end
						Result.force (pay)
					end
				end
			end
		end

feature -- Plans	

	ensure_plan_exists (a_plan: STRIPE_PLAN; a_default_id: READABLE_STRING_GENERAL)
			-- Ensure `a_plan` exists, if not create or update `a_plan`.
		local
			pl: STRIPE_PLAN
			l_pl_name: READABLE_STRING_GENERAL
			l_product: STRIPE_PRODUCT
		do
			l_pl_name := a_plan.identifier
			if l_pl_name = Void then
				l_pl_name := a_default_id
			end
			pl := plan_by_id_or_nickname (l_pl_name)
			if pl = Void then
				if attached a_plan.product as prod then
					create l_product.make_service_with_name (prod)
				else
					check has_product_id: False end
					create l_product.make_service_with_name (l_pl_name)
				end
				pl := new_plan (a_plan.amount, a_plan.currency, a_plan.interval, l_product, l_pl_name)
			end
			if pl /= Void and then pl.has_id then
				a_plan.set_id (pl.id)
			end
		end

	plan (a_plan_id: READABLE_STRING_GENERAL): detachable STRIPE_PLAN
		local
			cl: DEFAULT_HTTP_CLIENT
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
		do
			create cl
			if attached cl.new_session (stripe_api_url) as sess then
				sess.set_credentials (config.secret_key, "")
				create ctx.make_with_credentials_required

				if attached sess.get ("plans/" + url_encoded (a_plan_id), ctx) as l_response then
					if attached valid_api_json_object_response (l_response) as j then
						create Result.make_with_json (j)
						debug
							print (Result)
						end
					end
				end
			end
		end

	plan_by_nickname (a_nickname: READABLE_STRING_GENERAL): detachable STRIPE_PLAN
		do
			if attached plans (Void, 0) as lst then
				across
					lst as ic
				until
					Result /= Void
				loop
					Result := ic.item
					if attached Result.nickname as n and then a_nickname.is_case_insensitive_equal (n) then
					else
						Result := Void
					end
				end
			end
		end

	plan_by_id_or_nickname (v: READABLE_STRING_GENERAL): detachable STRIPE_PLAN
		do
			Result := plan (v)
			if Result = Void then
				Result := plan_by_nickname (v)
			end
		end

	plans (a_prod_id: detachable READABLE_STRING_GENERAL; nb: INTEGER): detachable ARRAYED_LIST [STRIPE_PLAN]
		local
			cl: DEFAULT_HTTP_CLIENT
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
		do
			create cl
			if attached cl.new_session (stripe_api_url) as sess then
				sess.set_credentials (config.secret_key, "")
				create ctx.make_with_credentials_required
				if a_prod_id /= Void then
					ctx.add_query_parameter ("product", a_prod_id)
				end
				if nb > 0 then
					ctx.add_query_parameter ("limit", nb.out)
				end

				if attached sess.get ("plans", ctx) as l_response then
					if attached valid_api_json_object_response (l_response) as j then
						if attached j.array_item ("data") as j_arr then
							create Result.make (j_arr.count)
							across
								j_arr as ic
							loop
								if attached {JSON_OBJECT} ic.item as jo then
									Result.force (create {STRIPE_PLAN}.make_with_json (jo))
								end
							end
						end
					end
				end
			end
		end

	new_daily_plan (a_amount: NATURAL_32; a_currency: READABLE_STRING_GENERAL; a_product: STRIPE_PRODUCT; a_nickname: detachable READABLE_STRING_GENERAL): detachable STRIPE_PLAN
		do
			Result := new_plan (a_amount, a_currency, "day", a_product, a_nickname)
		end

	new_weekly_plan (a_amount: NATURAL_32; a_currency: READABLE_STRING_GENERAL; a_product: STRIPE_PRODUCT; a_nickname: detachable READABLE_STRING_GENERAL): detachable STRIPE_PLAN
		do
			Result := new_plan (a_amount, a_currency, "week", a_product, a_nickname)
		end

	new_monthly_plan (a_amount: NATURAL_32; a_currency: READABLE_STRING_GENERAL; a_product: STRIPE_PRODUCT; a_nickname: detachable READABLE_STRING_GENERAL): detachable STRIPE_PLAN
		do
			Result := new_plan (a_amount, a_currency, "month", a_product, a_nickname)
		end

	new_yearly_plan (a_amount: NATURAL_32; a_currency: READABLE_STRING_GENERAL; a_product: STRIPE_PRODUCT; a_nickname: detachable READABLE_STRING_GENERAL): detachable STRIPE_PLAN
		do
			Result := new_plan (a_amount, a_currency, "year", a_product, a_nickname)
		end

	new_plan (a_amount: NATURAL_32; a_currency, a_interval: READABLE_STRING_GENERAL; a_product: STRIPE_PRODUCT; a_nickname: detachable READABLE_STRING_GENERAL): detachable STRIPE_PLAN
			-- `a_amount` in cents, a_currency is lowercase.
		local
			cl: DEFAULT_HTTP_CLIENT
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
		do
			create cl
			if attached cl.new_session (stripe_api_url) as sess then
				sess.set_credentials (config.secret_key, "")
				create ctx.make_with_credentials_required
				ctx.add_form_parameter ("amount", a_amount.out)
				ctx.add_form_parameter ("currency", a_currency.as_lower)
				ctx.add_form_parameter ("interval", a_interval.as_lower)
				if a_product.has_id then
					ctx.add_form_parameter ("product", a_product.id)
				elseif attached a_product.name as l_product_name and then not l_product_name.is_whitespace then
					ctx.add_form_parameter ("product[name]", l_product_name)
				end
				if a_nickname /= Void then
					ctx.add_form_parameter ("nickname", a_nickname)
				end

				if attached sess.post ("plans", ctx, Void) as l_response then
					if attached valid_api_json_object_response (l_response) as j then
						create Result.make_with_json (j)
						debug
							print (Result)
						end
					end
				end
			end
		end

feature -- Products

	product (a_product_id: READABLE_STRING_GENERAL): detachable STRIPE_PRODUCT
		local
			cl: DEFAULT_HTTP_CLIENT
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
		do
			create cl
			if attached cl.new_session (stripe_api_url) as sess then
				sess.set_credentials (config.secret_key, "")
				create ctx.make_with_credentials_required

				if attached sess.get ("products/" + url_encoded (a_product_id), ctx) as l_response then
					if attached valid_api_json_object_response (l_response) as j then
						create Result.make_with_json (j)
						debug
							print (Result)
						end
					end
				end
			end
		end

	product_by_name (a_name: READABLE_STRING_GENERAL): detachable STRIPE_PRODUCT
		do
			if attached products (0) as lst then
				across
					lst as ic
				until
					Result /= Void
				loop
					Result := ic.item
					if attached Result.name as n and then a_name.is_case_insensitive_equal (n) then
					else
						Result := Void
					end
				end
			end
		end

	products (nb: INTEGER): detachable ARRAYED_LIST [STRIPE_PRODUCT]
		local
			cl: DEFAULT_HTTP_CLIENT
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
		do
			create cl
			if attached cl.new_session (stripe_api_url) as sess then
				sess.set_credentials (config.secret_key, "")
				create ctx.make_with_credentials_required
				if nb > 0 then
					ctx.add_query_parameter ("limit", nb.out)
				end

				if attached sess.get ("products", ctx) as l_response then
					if attached valid_api_json_object_response (l_response) as j then
						if attached j.array_item ("data") as j_arr then
							create Result.make (j_arr.count)
							across
								j_arr as ic
							loop
								if attached {JSON_OBJECT} ic.item as jo then
									Result.force (create {STRIPE_PRODUCT}.make_with_json (jo))
								end
							end
						end
					end
				end
			end
		end

	new_service_product (a_name: READABLE_STRING_GENERAL): detachable STRIPE_PRODUCT
		do
			Result := new_product (a_name, "service")
		end

	new_good_product (a_name: READABLE_STRING_GENERAL): detachable STRIPE_PRODUCT
		do
			Result := new_product (a_name, "good")
		end

	new_product (a_name, a_type: READABLE_STRING_GENERAL): detachable STRIPE_PRODUCT
			-- New product with name `a_name`, and type either "service" or "good"
		require
			a_type.is_case_insensitive_equal ("service") or a_type.is_case_insensitive_equal ("good")
		local
			cl: DEFAULT_HTTP_CLIENT
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
		do
			create cl
			if attached cl.new_session (stripe_api_url) as sess then
				sess.set_credentials (config.secret_key, "")
				create ctx.make_with_credentials_required
				ctx.add_form_parameter ("name", a_name)
				ctx.add_form_parameter ("type", a_type.as_lower)
				if attached sess.post ("products", ctx, Void) as l_response then
					if attached valid_api_json_object_response (l_response) as j then
						create Result.make_with_json (j)
						debug
							print (Result)
						end
					end
				end
			end
		end

feature -- Hook invokation		

	invoke_prepare_payment (a_pay: STRIPE_PAYMENT)
		do
			if attached cms_api.hooks.subscribers ({STRIPE_HOOK}) as lst then
				across
					lst as ic
				loop
					if attached {STRIPE_HOOK} ic.item as h then
						h.prepare_payment (a_pay)
					end
				end
			end
		end

	invoke_validate_payment (a_validation: STRIPE_PAYMENT_VALIDATION)
		do
			if attached cms_api.hooks.subscribers ({STRIPE_HOOK}) as lst then
				across
					lst as ic
				loop
					if attached {STRIPE_HOOK} ic.item as h then
						h.validate_payment (a_validation)
					end
				end
			end
		end


note
	copyright: "2011-2019, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

