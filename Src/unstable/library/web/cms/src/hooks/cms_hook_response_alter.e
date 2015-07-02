note
	description: "[
			Hook providing a way to alter the cms response itself.
			It is recommanded to use finer cms hook, but this hook is quite general.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_HOOK_RESPONSE_ALTER

inherit
	CMS_HOOK

feature -- Hook

	response_alter (a_response: CMS_RESPONSE)
		deferred
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
