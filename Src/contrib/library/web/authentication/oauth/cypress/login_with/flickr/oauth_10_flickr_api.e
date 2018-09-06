note
	description: "Summary description for {OAUTH_10_FLICKR_API}."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=OAuth Flickr API", "src=http://www.flickr.com/services/api/auth.oauth.html",  "protocol=uri"

class
	OAUTH_10_FLICKR_API

inherit

	OAUTH_10_TEMPLATE_API
			redefine
				request_token_verb,
				access_token_verb
			end

feature -- Access

	request_token_verb: STRING_8
		do
			Result := "GET"
		end

	access_token_verb: STRING_8
		do
			Result := "GET"
		end

feature {NONE} -- Implementation

	authorize_url: STRING = "https://www.flickr.com/services/oauth/authorize?oauth_token="

	request_token_endpoint_url: STRING = "https://www.flickr.com/services/oauth/request_token"

	access_token_endpoint_url: STRING = "https://www.flickr.com/services/oauth/access_token"

note
	copyright: "2013-2013, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
