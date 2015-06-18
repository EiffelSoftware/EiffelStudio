note
	description: "Summary description for {OAUTH_10_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	OAUTH_10_API
inherit

	OAUTH_API

feature -- Access

	access_token_extractor: ACCESS_TOKEN_EXTRACTOR
		do
			create {TOKEN_EXTRACTOR_10} Result
		end

	base_string_extractor: BASE_STRING_EXTRACTOR
		do
			create {STRING_EXTRACTOR_10} Result
		end

	header_extractor: HEADER_EXTRACTOR
		do
			create {HEADER_EXTRACTOR_10} Result
		end

	request_token_extractor: ACCESS_TOKEN_EXTRACTOR
		do
			create {TOKEN_EXTRACTOR_10} Result
		end

	signature_service: SIGNATURE_SERVICE
		do
			create {HMAC_SHA1_SIGNATURE_SERVICE} Result
		end

	timestamp_service: TIMESTAMP_SERVICE
		do
			create {TIMESTAMP_SERVICE_10} Result
		end

	access_token_verb: STRING_8
		do
			Result := "POST"
		end

	request_token_verb: STRING_8
		do
			Result := "POST"
		end


	access_token_endpoint: STRING_8
			-- Url that receives the access token request
		deferred
		end

	request_token_endpoint: STRING_8
			-- URL that receives the access token requests.
		deferred
		end

	authorization_url (token: detachable OAUTH_TOKEN): detachable STRING_8
			-- Url where you should redirect your users to authneticate
		deferred
		end

feature -- Service

	create_service (config: OAUTH_CONFIG): OAUTH_SERVICE_I
		do
			create {OAUTH_10_SERVICE} Result.make (Current, config)
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
