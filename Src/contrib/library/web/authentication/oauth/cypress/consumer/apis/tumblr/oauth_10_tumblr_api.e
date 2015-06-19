note
	description: "Summary description for {OAUTH_10_TUMBLR_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_10_TUMBLR_API

inherit

	OAUTH_10_TEMPLATE_API

feature {NONE}-- Implementation

	authorize_url: STRING = "https://www.tumblr.com/oauth/authorize?oauth_token"

	request_token_endpoint_url: STRING = "http://www.tumblr.com/oauth/request_token"

	access_token_endpoint_url: STRING = "http://www.tumblr.com/oauth/access_token"

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
