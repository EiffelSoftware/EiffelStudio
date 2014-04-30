note
	description: "[
		Specifies a range of characters in a rich edit control. Very similar to
		WEL_CHARACTER_RANGE except that it also includes a WEL_STRING for storing the text.
		]"
	win32: "TEXTRANGE"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TEXT_RANGE

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

create
	make

feature {NONE} -- Initialization

	make (nb, a_minimum, a_maximum: INTEGER)
			-- Make a TEXTRANGE structure of size `nb' code units and set `maximum',
			-- `minimum', with `a_maximum', `a_minimum'
		require
			non_negative_count: nb >= 0
			positive_minimum: a_minimum >= 0
			valid_bounds: a_minimum <= a_maximum + 1
		do
			structure_make
			create text.make_empty (nb)
			cwel_charrange_set_text (item, text.item)
			create range.make_by_pointer (item)
			range.set_shared
			range.set_range (a_minimum, a_maximum)
		ensure
			minimum_set: range.minimum = a_minimum
			maximum_set: range.maximum = a_maximum
		end

feature -- Access

	range: WEL_CHARACTER_RANGE
			-- Range associated with Current.

	text: WEL_STRING
			-- Structure containing characters

feature -- Element change

	set_range (a_minimum, a_maximum: INTEGER)
			-- Set `minimum' with `a_minimum' and
			-- `maximum' with `a_maximum'
		require
			positive_minimum: a_minimum >= 0
			valid_bounds: a_minimum <= a_maximum + 1
		do
			range.set_range (a_minimum, a_maximum)
		ensure
			minimum_set: range.minimum = a_minimum
			maximum_set: range.maximum = a_maximum
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := cwel_size_of_textrange
		end

feature {NONE} -- Externals

	cwel_size_of_textrange: INTEGER
		external
			"C inline use <richedit.h>"
		alias
			"return sizeof (TEXTRANGE);"
		end

	cwel_charrange_set_text (ptr: POINTER; str: POINTER)
		external
			"C inline use <richedit.h>"
		alias
			"((TEXTRANGE *) $ptr)->lpstrText = (LPTSTR) $str;"
		end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
