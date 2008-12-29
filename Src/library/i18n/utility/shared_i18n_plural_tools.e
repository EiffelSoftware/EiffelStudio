note
	description: "Class that shares a I18N_PLURAL_TOOLS object"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_I18N_PLURAL_TOOLS

feature -- Shared object

	plural_tools: I18N_PLURAL_TOOLS
		once
			create Result
		ensure
			result_exists: Result /= Void
		end

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
