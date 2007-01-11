indexing
	description: "Code page constants for general encodings"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_PAGE_CONSTANTS

feature -- Access

	utf7: STRING is "UTF-7"

	utf8: STRING is "UTF-8"

	utf16: STRING is "UTF-16"

	utf32: STRING is "UCS-4";
		-- UCS-4 and UTF-32 are functionally identical since ISO 10646.
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
