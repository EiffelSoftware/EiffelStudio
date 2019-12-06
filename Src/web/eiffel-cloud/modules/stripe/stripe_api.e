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

feature -- Settings

	config: STRIPE_CONFIG

feature -- Constant

	stripe_api_url: STRING = "https://api.stripe.com/v1/"

feature -- Factory

	new_card_payment_intent (a_amount: INTEGER; a_currency: READABLE_STRING_GENERAL): detachable PAYMENT_INTENT
			-- `a_amount` in cents, a_currency is lowercase.
		local
			cl: DEFAULT_HTTP_CLIENT
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			jsonp: JSON_PARSER
		do
			create cl
			if attached cl.new_session (stripe_api_url) as sess then
				sess.set_credentials (config.secret_key, "")
				create ctx.make_with_credentials_required
				ctx.add_form_parameter ("amount", a_amount.out)
				ctx.add_form_parameter ("currency", a_currency)
				ctx.add_form_parameter ("payment_method_types[]", "card")
				if attached sess.get ("payment_intents", ctx) as l_response then
					if not l_response.error_occurred and then attached l_response.body as l_body then
						create jsonp.make_with_string (l_body)
						jsonp.parse_content
						if jsonp.is_parsed and then jsonp.is_valid and then attached jsonp.parsed_json_object as j then
							create Result.make_with_json (j)
							print (Result)
						end
					end
				end
			end
		end


note
	copyright: "2011-2019, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

