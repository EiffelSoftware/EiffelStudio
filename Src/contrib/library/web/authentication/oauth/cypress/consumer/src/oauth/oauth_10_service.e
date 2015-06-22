note
	description: "Summary description for {OAUTH_10_SERVICE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_10_SERVICE
inherit

	OAUTH_SERVICE_I
		export {NONE}
			access_token_post
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

	request_token: detachable OAUTH_TOKEN
			-- retrieve the request token
		local
			l_request: OAUTH_REQUEST
		do
			create l_request.make (api.request_token_verb, api.request_token_endpoint)
			if attached config.callback as l_callback then
				l_request.add_parameter ({OAUTH_CONSTANTS}.callback, l_callback)
			end
			set_oauth_params (l_request, (create {OAUTH_CONSTANTS}).empty_token)
			append_signature (l_request)
			if attached l_request.execute as l_response then
				if attached l_response.body as l_body then
					Result := api.access_token_extractor.extract (l_body)
				end
			end
		end


	access_token_get (a_request_token: detachable OAUTH_TOKEN; a_verifier: OAUTH_VERIFIER): detachable OAUTH_TOKEN
			-- retrieve an access token using a request token
			-- (obtained previously)
		local
			l_request: OAUTH_REQUEST
		do
			create l_request.make (api.access_token_verb, api.access_token_endpoint)
			if  a_request_token /= Void then
				l_request.add_parameter ({OAUTH_CONSTANTS}.token, a_request_token.token)
				l_request.add_parameter ({OAUTH_CONSTANTS}.verifier, a_verifier.value)
				set_oauth_params (l_request, a_request_token)
				append_signature (l_request)
				if attached l_request.execute as l_response then
					if attached l_response.body as l_body then
						Result := api.access_token_extractor.extract (l_body)
					end
				end
			end
		end


	sign_request (a_access_token: OAUTH_TOKEN; a_req: OAUTH_REQUEST)
			-- Signs an OAuth request using an access token (obtained previously)
		do
			a_req.add_parameter ({OAUTH_CONSTANTS}.token,a_access_token.token)
		 	set_oauth_params (a_req, a_access_token)
			append_signature (a_req)
		end

	authorization_url (a_request_token: detachable OAUTH_TOKEN): detachable STRING_8
			-- URL where you should redirect your users to authenticate
			-- your application.
			-- a request token needed to authorize
		do
			Result := api.authorization_url (a_request_token)
		end

feature {NONE} -- Implementation

	internal_version: STRING = "1.0"

	api: OAUTH_10_API

	config: OAUTH_CONFIG


	signature (request: OAUTH_REQUEST; token: OAUTH_TOKEN): STRING
			-- Generate OAuth request signature
		local
			base_string: STRING
			l_signature: STRING
		do
			base_string := api.base_string_extractor.extract (request)
			l_signature:= api.signature_service.signature (base_string, config.api_secret, token.secret)
			Result := l_signature
		end

	set_oauth_params (a_request: OAUTH_REQUEST; a_token: OAUTH_TOKEN)
		do
			a_request.add_parameter ({OAUTH_CONSTANTS}.timestamp, api.timestamp_service.timestamp_in_seconds)
			a_request.add_parameter ({OAUTH_CONSTANTS}.nonce, api.timestamp_service.nonce)
			a_request.add_parameter ({OAUTH_CONSTANTS}.consumer_key, config.api_key)
			a_request.add_parameter ({OAUTH_CONSTANTS}.sign_method, api.signature_service.signature_method)
			a_request.add_parameter ({OAUTH_CONSTANTS}.version, version)

			if config.has_scope and then attached config.scope as l_scope then
				a_request.add_parameter ({OAUTH_CONSTANTS}.scope, l_scope)
			end
			a_request.add_parameter ({OAUTH_CONSTANTS}.signature, signature (a_request, a_token))
		end

	append_signature (a_request: OAUTH_REQUEST)
		local
			l_oauth_header: STRING
		do
			if attached config.signature_type as l_signature then
				if l_signature.is_header then
					l_oauth_header := api.header_extractor.extract (a_request)
					a_request.add_header ({OAUTH_CONSTANTS}.header, l_oauth_header)
				elseif l_signature.is_query_string then
					across
						a_request.oauth_parameters as ic
					loop
						a_request.add_query_string_parameter (ic.key, ic.item)
					end
				end
			end
		end

	access_token_post (a_request_token: detachable OAUTH_TOKEN; a_verifier: detachable OAUTH_VERIFIER): detachable OAUTH_TOKEN
			-- retrieve an access token using a request token
			-- (obtained previously)
		do
			--|Not implemented
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
