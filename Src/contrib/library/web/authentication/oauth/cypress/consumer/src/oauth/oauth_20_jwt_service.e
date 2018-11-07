note
	description: "Summary description for {OAUTH_20_JWT_SERVICE}."
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_20_JWT_SERVICE

inherit

	OAUTH_20_SERVICE
		redefine
			access_token_post,
			config
		end
create
	make

feature -- Status Report

	is_client_secret_required: BOOLEAN
			-- Is client secret required?, by default false.

	is_client_id_required: BOOLEAN
			-- Is client secret required?, by default false.

feature -- Change Element

	enable_client_secret
		do
			is_client_secret_required := True
		ensure
			is_client_secret_required_true: is_client_secret_required = True
		end

	enable_client_id
		do
			is_client_id_required := True
		ensure
			is_client_id_required_true: is_client_id_required = True
		end

feature -- Access

	access_token_post (a_request_token: detachable OAUTH_TOKEN; a_verifier: detachable OAUTH_VERIFIER): detachable OAUTH_TOKEN
			-- retrieve an access token using a request token
			-- (obtained previously)
		local
			l_request: OAUTH_REQUEST
		do
			create l_request.make (api.access_token_verb, api.access_token_endpoint)
			if attached config.grant_type as l_grant_type then
				l_request.add_body_parameter ({OAUTH_CONSTANTS}.grant_type, l_grant_type)
			end
			if is_client_id_required and then not config.api_key.is_empty then
				l_request.add_body_parameter ({OAUTH_CONSTANTS}.client_id, config.api_key)
			end
			if is_client_secret_required and then not config.api_secret.is_empty then
				l_request.add_body_parameter ({OAUTH_CONSTANTS}.client_secret, config.api_secret)
			end
			if attached config.scope as l_scope then
				l_request.add_body_parameter ({OAUTH_CONSTANTS}.scope, l_scope)
			end
			l_request.add_header ("User-Agent", "Cypress OAuth20 JWT")
			l_request.add_body_parameter ("assertion", config.assertion)

			if attached l_request.execute as l_response then
				if attached l_response.body as l_body then
					Result := api.access_token_extractor.extract (l_body)
				end
			end
		end

feature -- Config

	config: OAUTH_JWT_CONFIG

;note
	copyright: "2013-2018, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
