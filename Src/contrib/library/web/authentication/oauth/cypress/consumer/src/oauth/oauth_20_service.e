note
	description: "Summary description for {OAUTH_20_SERVICE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_20_SERVICE

inherit

	OAUTH_SERVICE_I
		export
			{NONE} request_token
		end

create
	make

feature {NONE} -- Initialization

	make (an_api: like api; a_config: like config)
		do
			api := an_api
			config := a_config
			version := internal_version
		ensure
			api_set: api = an_api
			config_set: config = a_config
			version_set: version = internal_version
		end

feature -- Access

	access_token_get (a_request_token: detachable OAUTH_TOKEN; a_verifier: OAUTH_VERIFIER): detachable OAUTH_TOKEN
			-- retrieve an access token using a request token
			-- (obtained previously)
		local
			l_request: OAUTH_REQUEST
		do
			create l_request.make (api.access_token_verb, api.access_token_endpoint)
			l_request.add_query_string_parameter ({OAUTH_CONSTANTS}.client_id, config.api_key)
			l_request.add_query_string_parameter ({OAUTH_CONSTANTS}.client_secret, config.api_secret)
			l_request.add_query_string_parameter ({OAUTH_CONSTANTS}.code, a_verifier.value)
			if attached config.callback as l_callback then
				l_request.add_query_string_parameter ({OAUTH_CONSTANTS}.redirect_uri, l_callback)
			end
			if config.has_scope and then attached config.scope as l_scope then
				l_request.add_query_string_parameter ({OAUTH_CONSTANTS}.scope, l_scope)
			end
			if attached l_request.execute as l_response then
				if attached l_response.body as l_body then
					Result := api.access_token_extractor.extract (l_body)
				end
			end
		end

	access_token_post (a_request_token: detachable OAUTH_TOKEN; a_verifier: detachable OAUTH_VERIFIER): detachable OAUTH_TOKEN
			-- retrieve an access token using a request token
			-- (obtained previously)
		local
			l_request: OAUTH_REQUEST
		do
			create l_request.make (api.access_token_verb, api.access_token_endpoint)
			if attached config.grant_type as l_grant_type then
				l_request.add_body_parameter ({OAUTH_CONSTANTS}.grant_type, l_grant_type)
			else
				l_request.add_body_parameter ({OAUTH_CONSTANTS}.grant_type, {OAUTH_CONSTANTS}.authorization_code)
			end
			l_request.add_body_parameter ({OAUTH_CONSTANTS}.client_id, config.api_key)
			l_request.add_body_parameter ({OAUTH_CONSTANTS}.client_secret, config.api_secret)
			if a_verifier /= Void then
				l_request.add_body_parameter ({OAUTH_CONSTANTS}.code, a_verifier.value)
			end
			if attached config.callback as l_callback then
				l_request.add_body_parameter ({OAUTH_CONSTANTS}.redirect_uri, l_callback)
			end
			if config.has_scope and then attached config.scope as l_scope then
				l_request.add_body_parameter ({OAUTH_CONSTANTS}.scope, l_scope)
			end
			if attached l_request.execute as l_response then
				if attached l_response.body as l_body then
					Result := api.access_token_extractor.extract (l_body)
				end
			end
		end

	sign_request (a_access_token: OAUTH_TOKEN; a_req: OAUTH_REQUEST)
			-- Signs an OAuth request using an access token (obtained previously)
		do
			a_req.add_query_string_parameter ({OAUTH_CONSTANTS}.access_token, a_access_token.token)
		end

	authorization_url (a_request_token: detachable OAUTH_TOKEN): detachable STRING_8
			-- URL where you should redirect your users to authenticate
			-- your application.
			-- a request token needed to authorize
		do
			Result := api.authorization_url (config)
		end

feature {NONE} -- Implementation

	internal_version: STRING = "2.0"

	api: OAUTH_20_API

	config: OAUTH_CONFIG

	request_token: detachable OAUTH_TOKEN
			-- retrieve the request token
		do
			-- "Unsupported operation, please use 'getAuthorizationUrl' and redirect your users there"
		end

note
	copyright: "2013-2015, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
