note
	description: "Summary description for {STRIPE_MODULE}."
	date: "$Date$"
	revision: "$Revision$"

class
	STRIPE_MODULE_WEBAPI

inherit
	CMS_MODULE_WEBAPI [STRIPE_MODULE]
		redefine
			setup_hooks
		end

	CMS_HOOK_AUTO_REGISTER

--	STRIPE_HOOK

create
	make

feature {NONE} -- Router/administration

	setup_webapi_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		local
			cfg: STRIPE_CONFIG
			l_base_path: READABLE_STRING_8
		do
			if attached module.stripe_api as l_mod_api then
				cfg := l_mod_api.config
				l_base_path := cfg.base_path
				a_router.handle (l_base_path + "/public-key", create {WSF_URI_AGENT_HANDLER}.make (agent get_public_key (?,?,l_mod_api)), a_router.methods_get)

				a_router.handle (l_base_path + "/payment_intents", create {WSF_URI_AGENT_HANDLER}.make (agent post_payment_intents (?,?,l_mod_api)), a_router.methods_post)
				a_router.handle (l_base_path + "/payment_confirmation", create {WSF_URI_AGENT_HANDLER}.make (agent post_payment_intents_confirmation (?,?,l_mod_api)), a_router.methods_post)

				a_router.handle (l_base_path + "/customer_subscription", create {WSF_URI_AGENT_HANDLER}.make (agent post_customer_subscription (?,?,l_mod_api)), a_router.methods_post)
				a_router.handle (l_base_path + "/subscription_confirmation", create {WSF_URI_AGENT_HANDLER}.make (agent post_subscription_confirmation (?,?,l_mod_api)), a_router.methods_post)

				a_router.handle (l_base_path + "/callback", create {WSF_URI_AGENT_HANDLER}.make (agent post_webhook (?,?,l_mod_api)), a_router.methods_post)
			end
		end

feature -- API helpers

	is_valid_api_response (a_response: HTTP_CLIENT_RESPONSE): BOOLEAN
		do
			Result := not a_response.error_occurred and then a_response.status /= 404
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

feature -- Handle

	get_public_key (req: WSF_REQUEST; res: WSF_RESPONSE; api: STRIPE_API)
		local
			rep: like new_response
		do
			rep := new_response (req, res, api)
			if api.config.is_valid then
				rep.add_string_field ("publicKey" , api.config.public_key)
			else
				rep.add_boolean_field ("error", True)
				rep.add_string_field ("error_message", "stripe configuration is not valid!")
			end
			rep.execute
		end

	post_payment_intents (req: WSF_REQUEST; res: WSF_RESPONSE; api: STRIPE_API)
		local
			l_amount: NATURAL_32
			l_payment_intent: STRIPE_PAYMENT_INTENT
			buf: STRING
			jp: JSON_PARSER
			rep: like new_response
			pay: STRIPE_PAYMENT
		do
			if attached req.content_type as ct and then ct.same_string ({HTTP_CONSTANTS}.application_json) then
				create buf.make (req.content_length_value.to_integer_32)
				req.read_input_data_into (buf)
				create jp.make_with_string (buf)
				jp.parse_content
				if jp.is_parsed and then jp.is_valid and then attached jp.parsed_json_object as jo then
					if
						attached jo.string_item ("metadataOrderId") as j_order_id and
						attached jo.string_item ("productCategory") as j_prod_cat and
						attached jo.string_item ("currency") as j_currency
					then
						create pay.make (j_prod_cat.unescaped_string_32, j_order_id.unescaped_string_32)
						if attached jo.string_item ("productTitle") as j_prod_title then
							pay.set_title (j_prod_title.unescaped_string_32)
						end
						if attached jo.string_item ("productName") as j_prod_name then
							pay.set_code (j_prod_name.unescaped_string_32)
						end
						pay.set_price (0, j_currency.unescaped_string_8)
						api.invoke_prepare_payment (pay)
						l_amount := pay.price_in_cents
						if api.config.is_valid and then l_amount /= 0 then
							l_payment_intent := api.new_card_payment_intent (l_amount, pay.currency)
						end
					end
				end
			end

			rep := new_response (req, res, api)
			if l_payment_intent /= Void then
				if attached {JSON_WEBAPI_RESPONSE} rep as jrep then
					jrep.import_json_object (l_payment_intent.to_string)
				else
					rep.add_string_field ("client_secret", l_payment_intent.client_secret)
					rep.add_integer_64_field ("amount", l_payment_intent.amount)
					rep.add_string_field ("currency", l_payment_intent.currency)
				end
			else
				rep.add_boolean_field ("error", True)
				if not api.config.is_valid then
					rep.add_string_field ("error_message", "stripe configuration is not valid!")
				end
			end
 			rep.execute
		end

	post_payment_intents_confirmation (req: WSF_REQUEST; res: WSF_RESPONSE; api: STRIPE_API)
		local
			buf: STRING
			jp: JSON_PARSER
			rep: like new_response
			l_payment: STRIPE_PAYMENT_INTENT
		do
			if attached req.content_type as ct and then ct.same_string ({HTTP_CONSTANTS}.application_json) then
				create buf.make (req.content_length_value.to_integer_32)
				req.read_input_data_into (buf)
				create jp.make_with_string (buf)
				jp.parse_content
				if jp.is_parsed and then jp.is_valid and then attached jp.parsed_json_object as jo then
					if
						attached jo.string_item ("paymentId") as j_payment_id and
						api.config.is_valid
					then
						l_payment := api.payment_intent (j_payment_id.unescaped_string_32)
					end
				end
			end
			rep := new_response (req, res, api)
			if l_payment /= Void then
				process_payment_intent (l_payment, Void, Void, Void, rep, api)
			else
				rep.add_boolean_field ("error", True)
				if not api.config.is_valid then
					rep.add_string_field ("error_message", "stripe configuration is not valid!")
				end
			end
			rep.execute
		end

	process_payment_intent (a_payment: STRIPE_PAYMENT_INTENT; cust: detachable STRIPE_CUSTOMER; a_order_id: detachable READABLE_STRING_GENERAL; a_metadata: detachable STRING_TABLE [READABLE_STRING_GENERAL]; rep: like new_response; api: STRIPE_API)
		local
			l_customer: STRIPE_CUSTOMER
			l_validation: STRIPE_PAYMENT_VALIDATION
		do
			l_customer := cust
			if attached {JSON_WEBAPI_RESPONSE} rep as jrep then
				jrep.import_json_object (a_payment.to_string)
			else
				rep.add_string_field ("payment_id", a_payment.id)
			end
			rep.execute
			if a_payment.succeeded then
				api.cms_api.log_debug ({STRIPE_MODULE}.name, "New stripe payment #" + a_payment.id, Void)
				if l_customer = Void then
					if attached a_payment.customer_id as l_cust_id then
						l_customer := api.customer (l_cust_id)
					end
					if l_customer = Void and attached a_payment.receipt_email as l_cust_email then
						create l_customer.make_with_email (l_cust_email)
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
					api.invoke_validate_payment (l_validation)
				end
			end
		end

	post_customer_subscription (req: WSF_REQUEST; res: WSF_RESPONSE; api: STRIPE_API)
		local
			buf: STRING
			jp: JSON_PARSER
			rep: like new_response
			l_customer_email: READABLE_STRING_8
			l_customer: STRIPE_CUSTOMER
			l_payment_method_id: READABLE_STRING_8
			l_plan: STRIPE_PLAN
			l_subscription: STRIPE_SUBSCRIPTION
			lst: ARRAYED_LIST [TUPLE [plan: STRIPE_PLAN; quantity: NATURAL_32]]
			l_identifier: READABLE_STRING_32
			l_quantity: NATURAL_32
			i: INTEGER
			l_metadata: detachable STRING_TABLE [READABLE_STRING_GENERAL]
			l_order_id: detachable READABLE_STRING_GENERAL
		do
			if attached req.content_type as ct and then ct.same_string ({HTTP_CONSTANTS}.application_json) then
				create buf.make (req.content_length_value.to_integer_32)
				req.read_input_data_into (buf)
				create jp.make_with_string (buf)
				jp.parse_content
				if jp.is_parsed and then jp.is_valid and then attached jp.parsed_json_object as jo then
					if
						attached jo.string_item ("email") as j_email and then
						attached jo.string_item ("payment_method") as j_payment_method and
						api.config.is_valid
					then
						l_customer_email := j_email.unescaped_string_8
						l_customer := api.customer_by_email (l_customer_email)
						l_payment_method_id := j_payment_method.unescaped_string_8
						if l_customer = Void then
							create l_customer.make_with_email (l_customer_email)
						end
						if l_customer /= Void then
							if attached jo.object_item ("customer") as j_customer then
								if attached j_customer.object_item ("address") as j_address then
									l_customer.set_address (create {STRIPE_ADDRESS}.make_with_json (j_address))
								end
								if attached j_customer.string_item ("name") as j_phone then
									l_customer.set_name (j_phone.unescaped_string_32)
								end
								if attached j_customer.string_item ("phone") as j_phone then
									l_customer.set_phone (j_phone.unescaped_string_8)
								end
							end
							if attached api.new_customer (l_customer) as l_new_customer then
								l_customer := l_new_customer
							end
						end
						if l_customer /= Void and then l_customer.has_id then
							api.attach_payment_method_to_customer (l_payment_method_id, l_customer)

							if attached jo.array_item ("items") as j_items and then not j_items.is_empty then
								create lst.make (j_items.count)
								across
									j_items as ic
								loop
									if
										attached {JSON_OBJECT} ic.item as j_item and then
										attached j_item.string_item ("identifier") as j_identifier
									then
										l_identifier := j_identifier.unescaped_string_32
										l_plan := api.plan_by_id_or_nickname (l_identifier)
										if l_plan = Void then
												-- Try without the provider name
											i := l_identifier.index_of ('.', 1)
											if i > 0 then
												l_plan := api.plan_by_id_or_nickname (l_identifier.substring (i + 1, l_identifier.count))
											end
--											l_plan := api.new_plan (a_amount: NATURAL_32, a_currency, a_interval: READABLE_STRING_GENERAL, a_product: STRIPE_PRODUCT, a_nickname: detachable READABLE_STRING_GENERAL)
										end
										if l_plan /= Void then
											l_quantity := 1
											if attached {JSON_NUMBER} j_item.number_item ("quantity") as q then
												l_quantity := q.natural_64_item.to_natural_32
											end
											lst.force ([l_plan, l_quantity])
										end
									end
								end
							end
							if attached jo.object_item ("metadata") as j_metadata then
								create l_metadata.make_caseless (j_metadata.count)
								across
									j_metadata as ic
								loop
									if attached {JSON_STRING} ic.item as j_item then
										l_metadata.force (j_item.unescaped_string_32, ic.key.unescaped_string_32)
									end
								end
							end
							if attached jo.string_item ("order_id") as j_order_id then
								if l_metadata = Void then
									create l_metadata.make_caseless (1)
								end
								l_metadata.force (j_order_id.unescaped_string_32, "order_id")
								l_order_id := j_order_id.unescaped_string_32
							end
							if lst /= Void and then not lst.is_empty then
								l_subscription := api.new_multiple_plans_subscription (l_payment_method_id, l_customer, lst, l_metadata)
							else
								check should_not_occur: False end
							end
						end
					end
				end
			end
			rep := new_response (req, res, api)
			if l_subscription /= Void then
				process_subscription (l_subscription, l_customer, l_order_id, l_metadata, rep, api)
			else
				rep.add_boolean_field ("error", True)
				if not api.config.is_valid then
					rep.add_string_field ("error_message", "stripe configuration is not valid!")
				end
				rep.execute
			end
		end

	process_subscription (sub: STRIPE_SUBSCRIPTION; cust: detachable STRIPE_CUSTOMER; a_order_id: detachable READABLE_STRING_GENERAL; a_metadata: detachable STRING_TABLE [READABLE_STRING_GENERAL]; rep: like new_response; api: STRIPE_API)
		local
			l_customer: STRIPE_CUSTOMER
			l_validation: STRIPE_PAYMENT_VALIDATION
		do
			l_customer := cust
			if attached {JSON_WEBAPI_RESPONSE} rep as jrep then
				jrep.import_json_object (sub.to_string)
			else
				rep.add_string_field ("subscription_id", sub.id)
			end
			rep.execute
			if sub.is_active then
				api.cms_api.log_debug ({STRIPE_MODULE}.name, "New stripe subscription #" + sub.id, Void)
				if l_customer = Void then
					l_customer := api.subscription_customer (sub)
				end
				if l_customer /= Void then
					create l_validation.make_from_subscription (sub, l_customer)
					if a_metadata /= Void then
						l_validation.import_metadata (a_metadata)
					end
					if a_order_id /= Void then
						l_validation.set_order_id (a_order_id)
					end
					api.invoke_validate_payment (l_validation)
				end
			end
		end

	post_subscription_confirmation (req: WSF_REQUEST; res: WSF_RESPONSE; api: STRIPE_API)
		local
			buf: STRING
			jp: JSON_PARSER
			rep: like new_response
			l_subscription: STRIPE_SUBSCRIPTION
		do
			if attached req.content_type as ct and then ct.same_string ({HTTP_CONSTANTS}.application_json) then
				create buf.make (req.content_length_value.to_integer_32)
				req.read_input_data_into (buf)
				create jp.make_with_string (buf)
				jp.parse_content
				if jp.is_parsed and then jp.is_valid and then attached jp.parsed_json_object as jo then
					if
						attached jo.string_item ("subscriptionId") as j_subscription_id and
						api.config.is_valid
					then
						l_subscription := api.subscription (j_subscription_id.unescaped_string_32)
					end
				end
			end
			rep := new_response (req, res, api)
			if l_subscription /= Void then
				process_subscription (l_subscription, Void, Void, Void, rep, api)
			else
				rep.add_boolean_field ("error", True)
				if not api.config.is_valid then
					rep.add_string_field ("error_message", "stripe configuration is not valid!")
				end
			end
			rep.execute
		end

	post_webhook (req: WSF_REQUEST; res: WSF_RESPONSE; api: STRIPE_API)
		local
			rep: like new_response
			buf: STRING
			p: PATH
			f: RAW_FILE
			fut: FILE_UTILITIES
			jp: JSON_PARSER
			l_sign: READABLE_STRING_32
			l_type: READABLE_STRING_32
			l_useful_id: detachable STRING_32
			s32: STRING_32
			l_payment_intent_res: PAYMENT_INTENT_SUCCEEDED
			l_invoice: STRIPE_INVOICE
			l_is_livemode: BOOLEAN
		do
			create buf.make (req.content_length_value.to_integer_32)
			req.read_input_data_into (buf)

			l_sign := req.meta_string_variable ("HTTP_STRIPE_SIGNATURE")

			create jp.make_with_string (buf)
			jp.parse_content
			if
				jp.is_parsed and then jp.is_valid and then attached jp.parsed_json_object as jo and then
				attached jo.string_item ("type") as js
			then
				l_is_livemode := attached jo.boolean_item ("livemode") as j_livemode and then j_livemode.item

				l_type := js.unescaped_string_32
				if l_type.is_case_insensitive_equal_general ("payment_intent.succeeded") then
					create l_payment_intent_res.make_with_json (jo)
					across
						l_payment_intent_res.charges as ic
					loop
						if
							attached ic.item.billing_details as l_billing and then
							attached l_billing.email as l_email
						then

						end
					end
					l_useful_id := l_payment_intent_res.id
				elseif l_type.is_case_insensitive_equal_general ("payment_intent.created") then
					create l_payment_intent_res.make_with_json (jo)
					l_useful_id := l_payment_intent_res.id
				elseif l_type.is_case_insensitive_equal_general ("invoice.payment_succeeded") then
					create l_invoice.make_with_json (jo)
					create l_useful_id.make_from_string_general (l_invoice.id)
					if attached l_invoice.subscription_id as sub_id then
						l_useful_id.append_character ('.')
						l_useful_id.append_string_general (sub_id)
					end
					if attached l_invoice.payment_intent_id as p_id then
						l_useful_id.append_character ('.')
						l_useful_id.append_string_general (p_id)
					end
				end
			else
				l_type := "webhook"
			end

			rep := new_response (req, res, api)
			p := api.cms_api.site_location.extended ("stripe")
			if fut.directory_path_exists (p) then
				create s32.make (20)
				if not l_is_livemode then
					s32.append_string_general ("TEST_")
				end
				s32.append_string_general (req.request_time_stamp.out)
				s32.append_character ('.')
				s32.append (l_type)
				if l_useful_id /= Void then
					s32.append_character ('.')
					s32.append (l_useful_id)
				end

				create f.make_with_path (p.extended (s32))
				f.create_read_write

				if attached req.raw_header_data as h then
					f.put_string (h.to_string_8)
					f.put_new_line
				end

				if l_sign /= Void then
					f.put_string ("HTTP_STRIPE_SIGNATURE=" + utf_8_encoded (l_sign))
					f.put_new_line
				end

				f.put_string (create {STRING}.make_filled ('=', 8))
				f.put_new_line
				f.put_string (buf)
				f.close
			end
			rep.add_string_field ("status" , "ok")
			rep.execute
		end

feature -- Hooks configuration

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
--			a_hooks.subscribe_to_webapi_response_alter_hook (Current)
--			a_hooks.subscribe_to_hook (Current, {STRIPE_HOOK})
		end

feature {NONE} -- Implementation

	new_response (req: WSF_REQUEST; res: WSF_RESPONSE; api: STRIPE_API): HM_WEBAPI_RESPONSE
		do
			create {JSON_WEBAPI_RESPONSE} Result.make (req, res, api.cms_api)
		end


note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
