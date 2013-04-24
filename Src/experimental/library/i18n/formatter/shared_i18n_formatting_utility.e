note
	description: "Singleton for I18N_FORMATTING_UTILITY"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_I18N_FORMATTING_UTILITY

feature -- Shared object

	fu: I18N_FORMATTING_UTILITY
			-- fu: formatting utility
		once
			create Result
		end

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
