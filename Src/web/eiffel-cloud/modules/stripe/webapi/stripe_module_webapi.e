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

--	WSF_REQUEST_EXPORTER

--	STRIPE_HOOK

create
	make

feature {NONE} -- Router/administration

	setup_webapi_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		local
			cfg: STRIPE_CONFIG
			l_base_path: READABLE_STRING_8
			wh: STRIPE_WEBAPI_HOOK_HANDLER
		do
			if attached module.stripe_api as l_mod_api then
				cfg := l_mod_api.config
				l_base_path := cfg.base_path
				a_router.handle (l_base_path + "/public-key", create {WSF_URI_AGENT_HANDLER}.make (agent get_public_key (?,?,l_mod_api)), a_router.methods_get)

				a_router.handle (l_base_path + "/payment_intents", create {WSF_URI_AGENT_HANDLER}.make (agent post_payment_intents (?,?,l_mod_api)), a_router.methods_post)
				a_router.handle (l_base_path + "/payment_confirmation", create {WSF_URI_AGENT_HANDLER}.make (agent post_payment_intents_confirmation (?,?,l_mod_api)), a_router.methods_post)

				a_router.handle (l_base_path + "/customer_subscription", create {WSF_URI_AGENT_HANDLER}.make (agent post_customer_subscription (?,?,l_mod_api)), a_router.methods_post)
				a_router.handle (l_base_path + "/subscription_confirmation", create {WSF_URI_AGENT_HANDLER}.make (agent post_subscription_confirmation (?,?,l_mod_api)), a_router.methods_post)

				create wh.make (l_mod_api)
				a_router.handle (l_base_path + "/callback/{version}", wh, a_router.methods_post)
				a_router.handle (l_base_path + "/callback", wh, a_router.methods_post)
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
								l_metadata.force (j_order_id.unescaped_string_32, "order.id")
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
