note
	description: "[
			Hook providing a way to alter a webapi response.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_HOOK_WEBAPI_RESPONSE_ALTER

inherit
	CMS_HOOK

feature -- Hook

	webapi_response_alter (a_response: WEBAPI_RESPONSE)
		deferred
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
