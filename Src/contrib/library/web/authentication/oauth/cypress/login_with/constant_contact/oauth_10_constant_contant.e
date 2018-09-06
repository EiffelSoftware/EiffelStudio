note
	description: "Summary description for {OAUTH_10_CONSTANT_CONTANT}."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Constant Contact API",  "src=http://developer.constantcontact.com/docs/developer-guides/overview-of-api-endpoints.html", "protocol=URI"

class
	OAUTH_10_CONSTANT_CONTANT

obsolete "This API is obsolete, check Constant Contact API to use OAuth2.0"

inherit

	OAUTH_10_API


feature -- Access

	access_token_endpoint: STRING_8
			-- <Precursor>
		do
			Result := Access_token_endpoint_url
		end

	authorization_url (a_token: detachable OAUTH_TOKEN) : STRING_8
			-- <Precursor>
		local
			l_result : STRING
		do
			l_result := Authorize_url
			if a_token /= Void then
				l_result.append(a_token.token.as_string_8)
			end
			Result := l_result
		end

	request_token_endpoint: STRING_8
			-- <Precursor>
		do
			Result := Request_token_endpoint_url
		end

feature {NONE} --Implemantation

	Authorize_url: STRING = "https://oauth.constantcontact.com/ws/oauth/confirm_access?oauth_token="
	Request_token_endpoint_url: STRING = "https://oauth.constantcontact.com/ws/oauth/request_token"
	Access_token_endpoint_url: STRING = "https://oauth.constantcontact.com/ws/oauth/access_token"


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
