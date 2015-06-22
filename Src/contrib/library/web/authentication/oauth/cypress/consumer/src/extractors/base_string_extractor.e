note
	description: "Simple command object that extracts a base string from a OAUTH_REQUEST"
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=OAuthSpec","src=http://oauth.net/core/1.0/#anchor14", "protocol=uri"

deferred class
	BASE_STRING_EXTRACTOR

feature -- Extract

	extract (a_request: OAUTH_REQUEST): STRING_8
			-- Extract an url-encoded base string from the `a_request'
		deferred
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
