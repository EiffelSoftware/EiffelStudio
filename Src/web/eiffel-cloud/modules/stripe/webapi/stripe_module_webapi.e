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

	WSF_REQUEST_EXPORTER

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
					jrep.import_json_object (l_payment_intent.to_json_string)
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
				if attached {JSON_WEBAPI_RESPONSE} rep as jrep then
					jrep.import_json_object (l_payment.to_json_string)
				else
					rep.add_string_field ("payment_id", l_payment.id)
				end
				rep.execute
				api.process_payment_intent (l_payment, Void, Void, Void)
			else
				rep.add_boolean_field ("error", True)
				if not api.config.is_valid then
					rep.add_string_field ("error_message", "stripe configuration is not valid!")
				end
			end
			rep.execute
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
				api.process_new_subscription (l_subscription, l_customer, l_order_id, l_metadata)
				if attached {JSON_WEBAPI_RESPONSE} rep as jrep then
					jrep.import_json_object (l_subscription.to_json_string)
				else
					rep.add_string_field ("subscription_id", l_subscription.id)
				end
				rep.execute
			else
				rep.add_boolean_field ("error", True)
				if not api.config.is_valid then
					rep.add_string_field ("error_message", "stripe configuration is not valid!")
				end
				rep.execute
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
				api.process_new_subscription (l_subscription, Void, Void, Void)
				if attached {JSON_WEBAPI_RESPONSE} rep as jrep then
					jrep.import_json_object (l_subscription.to_json_string)
				else
					rep.add_string_field ("subscription_id", l_subscription.id)
				end
				rep.execute
			else
				rep.add_boolean_field ("error", True)
				if not api.config.is_valid then
					rep.add_string_field ("error_message", "stripe configuration is not valid!")
				end
				rep.execute
			end
		end

	safe_webhook_event_data (req: WSF_REQUEST; api: STRIPE_API): TUPLE [buffer: STRING; event: detachable STRIPE_EVENT; signature_verified: BOOLEAN]
			-- Safe event data, either by verifying the signature, or getting a fresh event data from stripe service.
		local
			buf: STRING
			ev: STRIPE_EVENT
			jp: JSON_PARSER
			l_sign: STRIPE_SIGNATURE
			l_sign_verified: BOOLEAN
		do
			create buf.make (req.content_length_value.to_integer_32)
			req.read_input_data_into (buf)

			create l_sign.make (req.meta_string_variable ("HTTP_STRIPE_SIGNATURE"))
			l_sign_verified := l_sign.is_valid and then l_sign.is_content_verified (buf, api.config.signing_secret)

			create jp.make_with_string (buf)
			jp.parse_content
			if
				jp.is_parsed and then jp.is_valid and then attached jp.parsed_json_object as jo
			then
				create ev.make_with_json (jo)
				if l_sign_verified then
					Result := [buf, ev, True]
				else
					Result := [buf, api.event (ev.id), False]
				end
			else
				Result := [buf, Void, l_sign_verified]
			end
		end

	post_webhook (req: WSF_REQUEST; res: WSF_RESPONSE; api: STRIPE_API)
		local
			rep: like new_response
			buf: STRING
			p: PATH
			f: RAW_FILE
			fut: FILE_UTILITIES

			l_useful_id: detachable STRING_32
			l_type: READABLE_STRING_8
			s32: STRING_32
			l_payment_intent_res: PAYMENT_INTENT_SUCCEEDED
			l_invoice: STRIPE_INVOICE
			l_is_livemode: BOOLEAN
			l_sign_verified: BOOLEAN
			l_err: BOOLEAN
			d: like safe_webhook_event_data
		do
			d := safe_webhook_event_data (req, api)
			buf := d.buffer
			l_sign_verified := d.signature_verified

			if attached d.event as event then
				l_type := event.type
				l_is_livemode := event.in_livemode
				if
					not l_is_livemode and
					api.config.is_live_mode
				then
					-- Ignore testing callbacks!!!
				else
					if
						l_type.is_case_insensitive_equal_general ("payment_intent.succeeded") and then
						attached {JSON_OBJECT} event.data as jo
					then
						create l_payment_intent_res.make_with_json (jo)
						if api.is_payment_processed (l_payment_intent_res.id) then
							api.cms_api.log_debug (module.name, "Stripe payment '" + l_payment_intent_res.id + "' is already processed!!!", Void)
						end
						l_useful_id := l_payment_intent_res.id
					elseif
						l_type.is_case_insensitive_equal_general ("payment_intent.failed") and then
						attached {JSON_OBJECT} event.data as jo
					then
						create l_payment_intent_res.make_with_json (jo)
						if api.is_payment_processed (l_payment_intent_res.id) then
							api.cms_api.log_debug (module.name, "Stripe payment '" + l_payment_intent_res.id + "' is already processed!!!", Void)
						end
						l_useful_id := l_payment_intent_res.id
					elseif
						l_type.is_case_insensitive_equal_general ("invoice.payment_succeeded") and then
						attached {JSON_OBJECT} event.data as jo
					then
						create l_invoice.make_with_json (jo)
						if attached l_invoice.payment_intent_id as pi then
							if api.is_payment_processed (pi) then
								api.cms_api.log_error (module.name, "Stripe payment '" + pi + "' is already processed!", Void)
							else
								-- Process ...
								api.record_invoice (l_invoice)
							end
						else
							api.cms_api.log_error (module.name, "Stripe invoice without payment_intent_id!", Void)
						end
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
--					check l_sign_verified !!!
				end
			else
				l_err := True
				l_type := "webhook"
			end

			rep := new_response (req, res, api)
			p := api.cms_api.site_location.extended ("stripe")
			if fut.directory_path_exists (p) then
				create s32.make (20)
				if l_err then
					s32.append_string_general ("ERROR_")
				elseif not l_is_livemode then
					s32.append_string_general ("TEST_")
				end
				s32.append_string_general (req.request_time_stamp.out)
				s32.append_character ('.')
				s32.append_string_general (l_type)
				if l_useful_id /= Void then
					s32.append_character ('.')
					s32.append (l_useful_id)
				end
				create f.make_with_path (p.extended (s32))
				f.create_read_write

				if attached req.raw_header_data as h then
					f.put_string (h.to_string_8)
					f.put_new_line
				elseif attached req.cgi_variables as l_cgi then
					f.put_string (utf_8_encoded (l_cgi.debug_output))
					f.put_new_line
				end

				if attached req.meta_string_variable ("HTTP_STRIPE_SIGNATURE") as s then
					f.put_string ("HTTP_STRIPE_SIGNATURE=" + utf_8_encoded (s))
					f.put_new_line
					if l_sign_verified then
						f.put_string ("Stripe-Signature VERIFIED")
					else
						f.put_string ("Stripe-Signature NOT-VERIFIED")
					end
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
