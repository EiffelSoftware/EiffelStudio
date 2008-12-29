note
	description: "Imported routines for reading and writing STRING_32 objects using UTF-8 encoding"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	IMPORTED_UTF8_READER_WRITER

feature -- Access

	utf8_rw: UTF8_READER_WRITER
			-- Routines for reading and writing UTF-8 strings
		once
			create Result
		ensure
			result_not_void: Result /= Void
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
