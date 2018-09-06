note
	description: "Summary description for {OAUTH_10_SSL_TWITTER_API}."
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_10_SSL_TWITTER_API

inherit

	OAUTH_10_TWITTER_API
		redefine
			access_token_endpoint,
			request_token_endpoint,
			authorization_url
		end

feature -- Access

	access_token_endpoint : STRING_8
			-- <Precursor>
		do
			Result := "https://" + Access_token_resource
		end


	request_token_endpoint: STRING_8
			-- <Precursor>
		do
			Result := "https://" + Request_token_resource
		end

	authorization_url (token: OAUTH_TOKEN): detachable STRING_8
			-- Url where you should redirect your users to authneticate
		local
			l_result: STRING
		do
			create l_result.make_from_string (Authenticate_url)
			l_result.replace_substring_all ("$OAUTH_TOKEN", token.token)
			Result := l_result
		end

feature {NONE} -- Implementation

	Authenticate_url: STRING = "https://api.twitter.com/oauth/authenticate?oauth_token=$OAUTH_TOKEN";
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
