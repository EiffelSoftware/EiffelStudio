indexing
	description: "Singleton that provides an I18N_URI_PARSER"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_I18N_URI_PARSER

feature	-- Shared object
		parser: I18N_URI_PARSER is
				-- shared I18N_URI_PARSER
			once
				create Result
			ensure
				result_not_void: Result /= Void
			end


indexing
	library:   "EiffelBase: Library of reusable components for Eiffel."
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
