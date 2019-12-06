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
		do
			if attached module.stripe_api as l_mod_api then
				cfg := l_mod_api.config
				a_router.handle (l_mod_api.config.base_path + "/public-key", create {WSF_URI_AGENT_HANDLER}.make (agent get_public_key (?,?,l_mod_api)), a_router.methods_get)
				a_router.handle (l_mod_api.config.base_path + "/payment_intents", create {WSF_URI_AGENT_HANDLER}.make (agent post_payment_intents (?,?,l_mod_api)), a_router.methods_post)
				a_router.handle (l_mod_api.config.base_path + "/webhook", create {WSF_URI_AGENT_HANDLER}.make (agent post_webhook (?,?,l_mod_api)), a_router.methods_post)
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
			l_amount: INTEGER
			l_payment_intent: PAYMENT_INTENT
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
						attached jo.string_item ("productName") as j_prod_name and
						attached jo.string_item ("productCategory") as j_prod_cat and
						attached jo.string_item ("currency") as j_currency
					then
						create pay.make (j_prod_cat.unescaped_string_32, j_prod_name.unescaped_string_32)
						pay.set_price (0, j_currency.unescaped_string_8)
						if attached api.cms_api.hooks.subscribers ({STRIPE_HOOK}) as lst then
							across
								lst as ic
							loop
								if attached {STRIPE_HOOK} ic.item as h then
									h.prepare_payment (pay)
								end
							end
						end
						l_amount := pay.price_in_cents
						if api.config.is_valid then
							l_payment_intent := api.new_card_payment_intent (l_amount, pay.currency)
						end
					end
				end
			end

			rep := new_response (req, res, api)
			if l_payment_intent /= Void then
				rep.add_string_field ("client_secret", l_payment_intent.client_secret)
				rep.add_integer_64_field ("amount", l_payment_intent.amount)
				rep.add_string_field ("currency", l_payment_intent.currency)
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
		do
			rep := new_response (req, res, api)
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

--	prepare_payment (pay: STRIPE_PAYMENT)
--		do
--			if
--		end

feature {NONE} -- Implementation

	new_response (req: WSF_REQUEST; res: WSF_RESPONSE; api: STRIPE_API): HM_WEBAPI_RESPONSE
		do
			create {JSON_WEBAPI_RESPONSE} Result.make (req, res, api.cms_api)
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
