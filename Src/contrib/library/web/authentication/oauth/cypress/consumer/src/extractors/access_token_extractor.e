note
	description: "Summary description for {ACCESS_TOKEN_EXTRACTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ACCESS_TOKEN_EXTRACTOR

feature -- Extractor

	extract (response: READABLE_STRING_8): detachable OAUTH_TOKEN
			-- Extracts the access token from the contents of an Http Response
		require
			not_empty: not response.is_empty
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
