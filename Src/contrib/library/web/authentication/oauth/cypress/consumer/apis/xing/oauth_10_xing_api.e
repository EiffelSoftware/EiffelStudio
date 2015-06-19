note
	description: "Summary description for {OAUTH_10_XING_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_10_XING_API

inherit

	OAUTH_10_TEMPLATE_API

feature {NONE} -- Implementation


	Authorize_url: STRING = "https://api.xing.com/v1/authorize?oauth_token="
	Request_token_endpoint_url: STRING = "https://api.xing.com/v1/request_token"
	Access_token_endpoint_url: STRING = "https://api.xing.com/v1/access_token"

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
