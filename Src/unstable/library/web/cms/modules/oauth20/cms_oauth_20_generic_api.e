note
	description: "Generic OAUTH2 API."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_OAUTH_20_GENERIC_API

inherit

	OAUTH_20_API
		redefine
			access_token_extractor,
			access_token_verb
		end

create
	make

feature {NONE} -- Initialize

	make (a_endpoint: READABLE_STRING_8; a_authorize_url: READABLE_STRING_8; a_extractor: READABLE_STRING_8)
		do
			endpoint := a_endpoint
			authorize_url := a_authorize_url
			extractor := a_extractor
		ensure
			endpoint_set: endpoint = a_endpoint
			authorize_url_set: authorize_url = a_authorize_url
			extractor_set: extractor = a_authorize_url
		end

	endpoint: READABLE_STRING_8
			-- 	Url that receives the access token request.

	authorize_url: READABLE_STRING_8
			--

	extractor: READABLE_STRING_8
			-- text, json		

feature -- Access

	access_token_extractor: ACCESS_TOKEN_EXTRACTOR
			-- Return token extractor, by default TOKEN_EXTRACTOR_20.
		do
			if extractor.is_case_insensitive_equal_general ("json") then
				create {JSON_TOKEN_EXTRACTOR} Result
			else
				create {TOKEN_EXTRACTOR_20} Result
			end
		end

	access_token_verb: STRING_8
		do
			Result := "POST"
		end

	access_token_endpoint: STRING_8
			-- Url that receives the access token request
		do
			create Result.make_from_string (endpoint)
		end

	authorization_url (config: OAUTH_CONFIG): detachable STRING_8
			-- Url where you should redirect your users to authneticate
		local
			l_api_key: STRING_8
		do
			l_api_key := config.api_key
			if attached config.scope as l_scope then
				create Result.make_from_string (authorize_url + scoped_authorize_url)
				Result.replace_substring_all ("$CLIENT_ID", l_api_key)
				if attached config.callback as l_callback then
					Result.replace_substring_all ("$REDIRECT_URI", (create {OAUTH_ENCODER}).encoded_string (l_callback))
				end
				if attached config.callback as l_callback then
					Result.replace_substring_all ("$SCOPE", (create {OAUTH_ENCODER}).encoded_string (l_scope))
				end
			else
				create Result.make_from_string (authorize_url + scoped_authorize_url)
				Result.replace_substring_all ("$CLIENT_ID", l_api_key)
				if attached config.callback as l_callback then
					Result.replace_substring_all ("$REDIRECT_URI", (create {OAUTH_ENCODER}).encoded_string (l_callback))
				end
			end
		end

feature -- Implementation

	Scoped_authorize_url: STRING = "&scope=$SCOPE";

end
