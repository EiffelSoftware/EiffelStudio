note
	description: "Summary description for {OAUTH_20_IMGUR_API}."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Authorization and OAuth", "src=https://api.imgur.com/oauth2", "protocol=uri"

class
	OAUTH_20_IMGUR_API

inherit

	OAUTH_20_API
		redefine
			access_token_extractor,
			access_token_verb
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
			create {STRING_8} Result.make_from_string ("https://api.imgur.com/oauth2/token")
		end

	authorization_url (config: OAUTH_CONFIG): detachable STRING_8
			-- Url where you should redirect your users to authneticate
		local
			l_result: STRING_8
		do
			 -- TODO Implement REQUESTED_RESPONSE_TYPE
			if attached config.scope as l_scope then
				create l_result.make_from_string (TEMPLATE_AUTHORIZE_URL + SCOPED_AUTHORIZE_URL)
				l_result.replace_substring_all ("$CLIENT_ID", config.api_key.as_string_8)
			else
				create l_result.make_from_string (TEMPLATE_AUTHORIZE_URL)
				l_result.replace_substring_all ("$CLIENT_ID", config.api_key.as_string_8)
				if attached config.callback as l_callback then
					l_result.replace_substring_all ("$REDIRECT_URI", (create {OAUTH_ENCODER}).encoded_string (l_callback.as_string_8))
				end
			end
		end

feature -- Implementation

	Template_authorize_url: STRING = "https://api.imgur.com/oauth2/authorize?client_id=$CLIENT_ID&response_type=$REQUESTED_RESPONSE_TYPE";


	Scoped_authorize_url: STRING = "&scope=$SCOPE"

	State_authorize_url: STRING = "&state=$APPLICATION_STATE"
end
