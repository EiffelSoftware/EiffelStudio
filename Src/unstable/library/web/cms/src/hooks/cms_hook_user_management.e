note
	description: "[
			Hook providing a way to apply new user.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_HOOK_USER_MANAGEMENT

inherit
	CMS_HOOK

feature -- Hook

	new_user (a_user: CMS_USER)
		require
			a_user.has_id
		deferred
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
