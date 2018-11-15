note
	description: "Summary description for {SSL_MODE_WITH_TWEAK}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SSL_MODE_WITH_TWEAK

feature -- Access

	tweak: detachable MANAGED_POINTER
			-- The value of the tweak for this mode as bytes.

;note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
