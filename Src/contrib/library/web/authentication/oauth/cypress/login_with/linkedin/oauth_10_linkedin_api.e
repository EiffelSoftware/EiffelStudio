note
	description: "Summary description for {OAUTH_10_LINKEDIN_API}."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=OAuth1.0","src=https://developer.linkedin.com/support/faq", "protocol=URI"
class
	OAUTH_10_LINKEDIN_API

obsolete "[
Existing applications built with OAuth 1.0a will continue to functional normally until such time as we officially announce its sunset.
Using or transitioning to OAuth 2.0 OAUTH_20_LINKEDIN_API is strongly encouraged for all applications.
]"	

inherit

	OAUTH_10_TEMPLATE_API

feature {NONE} -- Implementation

	authorize_url: STRING ="https://api.linkedin.com/uas/oauth/authenticate?oauth_token="

	request_token_endpoint_url: STRING = "https://api.linkedin.com/uas/oauth/requestToken"

	access_token_endpoint_url: STRING = "https://api.linkedin.com/uas/oauth/accessToken"


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
