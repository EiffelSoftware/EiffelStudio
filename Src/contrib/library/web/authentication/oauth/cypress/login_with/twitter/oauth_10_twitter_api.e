note
	description: "Summary description for {OAUTH_10_TWITTER_API}."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Authentication", "src=https://developer.twitter.com/en/docs/basics/authentication/overview/oauth", "protocol=uri"

class
	OAUTH_10_TWITTER_API

inherit

	OAUTH_10_API

feature -- Access

	access_token_endpoint : STRING_8
			-- <Precursor>
		local
			l_result : STRING
		do
			l_result := "https://" + Access_token_resource
			Result := l_result
		end


	request_token_endpoint: STRING_8
			-- <Precursor>
		local
			l_result : STRING
		do
			l_result := "https://" + Request_token_resource
			Result := l_result
		end

	authorization_url (token: detachable OAUTH_TOKEN): detachable STRING_8
			-- Url where you should redirect your users to authneticate
		local
			l_result: STRING
		do
			create l_result.make_from_string (Authorize_url)
			if token /= Void then
				l_result.replace_substring_all ("$OAUTH_TOKEN", token.token)
			end
			Result := l_result
		end

feature {NONE} -- Implementation

	Authorize_url: STRING = "https://api.twitter.com/oauth/authorize?oauth_token=$OAUTH_TOKEN"
  	Request_token_resource: STRING = "api.twitter.com/oauth/request_token"
  	Access_token_resource: STRING = "api.twitter.com/oauth/access_token"

note
	copyright: "2013-2017, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
