note
	description: "Summary description for {OAUTH_20_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	OAUTH_20_API

inherit
	OAUTH_API

feature -- Access

	access_token_extractor: ACCESS_TOKEN_EXTRACTOR
			-- Extracts the access token from the contents of an Http Response.
		do
			create {TOKEN_EXTRACTOR_20} Result
		end

	access_token_verb: STRING_8
			-- Http method
		do
			Result := "GET"
		end

	access_token_endpoint: STRING_8
			-- Url that receives the access token request
		deferred
		end

	authorization_url (config: OAUTH_CONFIG): detachable STRING_8
			-- Url where you should redirect your users to authneticate.
		deferred
		end

feature -- Service

	create_service (config: OAUTH_CONFIG): OAUTH_SERVICE_I
			-- Create an instance of OAUTH service  using OAUTH_20 version.
		do
			create {OAUTH_20_SERVICE} Result.make (Current, config)
		end

note
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
