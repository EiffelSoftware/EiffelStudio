note
	description: "OAuth workflow"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_OAUTH_20_WORKFLOW

inherit

	SHARED_LOGGER

create
	make

feature {NONE} -- Initialization

	make (a_host: READABLE_STRING_32; a_consumer: CMS_OAUTH_20_CONSUMER)
			-- Create an object with the host `a_host'.
		do
			initilize (a_consumer)
			create config.make_default (a_consumer.api_key, a_consumer.api_secret)
			config.set_callback (a_host + "/account/oauth-callback/"+ a_consumer.callback_name)
			config.set_scope (a_consumer.scope)
				--Todo create a generic OAUTH_20_GENERIC_API
			create oauth_api.make (a_consumer.endpoint, a_consumer.authorize_url, a_consumer.extractor)
			api_service := oauth_api.create_service (config)
		end

	initilize (a_consumer: CMS_OAUTH_20_CONSUMER)
		do
				--Use configuration values if any if not defaul
			api_key := a_consumer.api_key
			api_secret := a_consumer.api_secret
			scope := a_consumer.scope
			protected_resource_url := a_consumer.protected_resource_url
		end

feature -- Access

	authorization_url: detachable READABLE_STRING_32
			-- Obtain the Authorization URL.
		do
				-- Obtain the Authorization URL
			write_debug_log (generator + ".authorization_url Fetching the Authorization URL..!")
			if attached api_service.authorization_url (empty_token) as l_authorization_url then
				write_debug_log (generator + ".authorization_url: Got the Authorization URL!")
				write_debug_log (generator + ".authorization_url:" + l_authorization_url)
				Result := l_authorization_url.as_string_32
			end
		end

	sign_request (a_code: READABLE_STRING_32)
			-- Sign request with code `a_code'.
			--! To get the code `a_code' you need to do a request
			--! using the authorization_url
		local
			request: OAUTH_REQUEST
		do
				-- Get the access token.
			write_debug_log (generator + ".sign_request Fetching the access token with code [" + a_code + "]")
			access_token := api_service.access_token_post (empty_token, create {OAUTH_VERIFIER}.make (a_code))
			if attached access_token as l_access_token then
				write_debug_log (generator + ".sign_request Got the Access Token [" + l_access_token.debug_output + "]")
					-- Get the user email
					--! at the moment the scope is mail, but we can change it to get more information.
				create request.make ("GET", protected_resource_url)
				request.add_header ("Authorization", "Bearer " + l_access_token.token)
				api_service.sign_request (l_access_token, request)
				if attached {OAUTH_RESPONSE} request.execute as l_response then
						write_debug_log (generator + ".sign_request Sign_request response [" + l_response.status.out + "]")
					if attached l_response.body as l_body then
						user_profile := l_body
						write_debug_log (generator + ".sign_request User profile [" + l_body + "]")
					end
				end
			end
		end

	user_email: detachable READABLE_STRING_32
			-- Retrieve user email if any.
		local
			l_json: JSON_CONFIG
		do
			if attached user_profile as l_profile then
				create l_json.make_from_string (l_profile)
				if
					attached {JSON_ARRAY} l_json.item ("emails") as l_array and then
					attached {JSON_OBJECT} l_array.i_th (1) as l_object and then
					attached {JSON_STRING} l_object.item ("value") as l_email
				then
					Result := l_email.item
				elseif attached {JSON_STRING} l_json.item ("email") as l_email then
					Result := l_email.unescaped_string_32
				end
			end
		end

feature -- Access

	access_token: detachable OAUTH_TOKEN
			-- JSON representing the access token.

	user_profile: detachable READABLE_STRING_32
			-- JSON representing the user profiles.

feature {NONE} -- Implementation

	oauth_api: CMS_OAUTH_20_GENERIC_API
		-- OAuth 2.0 Google API.

	config: OAUTH_CONFIG
		-- configuration.

	api_service: OAUTH_SERVICE_I
		-- Service.

	api_key: STRING
		-- public key.

	api_secret: STRING
		-- secret key.

	scope: STRING
		-- api scope to access protected resources.

	protected_resource_url: STRING
		-- Resource url.

	empty_token: detachable OAUTH_TOKEN
		-- fake token.

end
