note
	description: "Summary description for {OAUTH_20_JWT_API}."
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_20_JWT_API

inherit
	OAUTH_20_API
		redefine
			access_token_extractor,
			access_token_verb,
			create_service
		end

create
	make

feature {NONE} -- Initialization

	make (a_uri: READABLE_STRING_8)
		do
			oauth_2 := a_uri
		ensure
			oauth_2_set: oauth_2 = a_uri
		end

feature -- Access

	access_token_extractor: ACCESS_TOKEN_EXTRACTOR
		do
			create {JSON_TOKEN_EXTRACTOR} Result
		end

	access_token_verb: STRING_8
			-- <Precursor>
		do
			Result := "POST"
		end

	access_token_endpoint: STRING_8
			-- Url that receives the access token request
		do
			create {STRING_8} Result.make_from_string (oauth_2)
		end

	authorization_url (config: OAUTH_CONFIG): detachable STRING_8
			-- Url where you should redirect your users to authneticate
		do
			-- Do nothing
		end

feature -- Service

	create_service (config: OAUTH_JWT_CONFIG): OAUTH_20_JWT_SERVICE
			-- Create an instance of OAUTH service using OAUTH_20 version.
		do
			create Result.make (Current, config)
		end

feature -- Implementation

	oauth_2: STRING
			--  the OAuth 2.0 endpoint described in the JWT.json.
end

