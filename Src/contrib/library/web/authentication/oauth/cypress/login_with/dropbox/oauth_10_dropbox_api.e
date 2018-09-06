note
	description: "Summary description for {OAUTH_10_DROPBOX_API}."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name= Dropbox API v1", "src=https://blogs.dropbox.com/developers/2017/09/api-v1-shutdown-details/", "protocol=uri"

class
	OAUTH_10_DROPBOX_API

obsolete "This api has been deprecated, please use OAUTH_20_DROPBOX_API"
inherit

	OAUTH_10_API

feature -- Access

	access_token_endpoint: STRING_8
			-- <Precursor>
		do
			Result := "https://api.dropbox.com/1/oauth/access_token"
		end

	authorization_url (a_token: detachable OAUTH_TOKEN) : STRING_8
			-- <Precursor>
		local
			l_result : STRING
		do
			l_result := "https://www.dropbox.com/1/oauth/authorize?oauth_token="
			if a_token /= Void then
				l_result.append(a_token.token.as_string_8)
			end
			Result := l_result
		end

	request_token_endpoint: STRING_8
			-- <Precursor>
		do
			Result := "https://api.dropbox.com/1/oauth/request_token"
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
