note
	description: "[
			API provider for 2-legged OAuth10a for Yelp API (version 2).
			]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Yelp APIv2", "src=http://www.yelp.com.au/developers/documentation/v2/authentication", "protocol=uri"

class
	OAUTH_10_YELPV2_API

obsolete "On June 30, 2018, API v2 will be discontinued and v2 endpoints will no longer work, move to Yelp Fusion https://www.yelp.com/developers/documentation/v3"

inherit

	OAUTH_10_TEMPLATE_API

feature {NONE} -- Implementation

	authorize_url: STRING =""

	request_token_endpoint_url: STRING = ""

	access_token_endpoint_url: STRING = ""

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



