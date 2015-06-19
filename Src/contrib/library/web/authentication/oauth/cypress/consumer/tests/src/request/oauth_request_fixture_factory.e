note
	description: "Summary description for {OAUTH_REQUEST_FIXTURE_FACTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_REQUEST_FIXTURE_FACTORY

feature -- Factory

	default_request : OAUTH_REQUEST
		do
			create Result.make ("GET", "http://example.com" )
			Result.add_parameter ({OAUTH_CONSTANTS}.timestamp, "123456")
			Result.add_parameter ({OAUTH_CONSTANTS}.consumer_key, "AS#$^*@&")
			Result.add_parameter ({OAUTH_CONSTANTS}.callback, "http://example/callback")
			Result.add_parameter ({OAUTH_CONSTANTS}.signature, "OAuth-Signature")
		end

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
