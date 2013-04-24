note
	description: "Specifies a range of characters in a rich edit control."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CHARACTER_RANGE

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

create
	make,
	make_by_pointer,
	make_empty

feature {NONE} -- Initialization

	make (a_minimum, a_maximum: INTEGER)
			-- Make a char range structure and set `maximum',
			-- `minimum', with `a_maximum', `a_minimum'
		require
			positive_minimum: a_minimum >= 0
			valid_bounds: a_minimum <= a_maximum + 1
		do
			structure_make
			set_range (a_minimum, a_maximum)
		ensure
			minimum_set: minimum = a_minimum
			maximum_set: maximum = a_maximum
		end

	make_empty
			-- Make an empty character range structure.
		do
			structure_make
		ensure
			minimum_set: minimum = 0
			maximum_set: maximum = 0
		end

feature -- Access

	minimum: INTEGER
			-- Index of first intercharacter position
		do
			Result := cwel_charrange_get_cpmin (item)
		end

	maximum: INTEGER
			-- Index of last intercharacter position
		do
			Result := cwel_charrange_get_cpmax (item)
		end

feature -- Element change

	set_range (a_minimum, a_maximum: INTEGER)
			-- Set `minimum' with `a_minimum' and
			-- `maximum' with `a_maximum'
		require
			positive_minimum: a_minimum >= 0
			valid_bounds: a_minimum <= a_maximum + 1
		do
			cwel_charrange_set_cpmin (item, a_minimum)
			cwel_charrange_set_cpmax (item, a_maximum)
		ensure
			minimum_set: minimum = a_minimum
			maximum_set: maximum = a_maximum
		end


feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := cwel_size_of_charrange
		end

feature {NONE} -- Externals

	cwel_size_of_charrange: INTEGER
		external
			"C [macro <chrrange.h>]"
		alias
			"sizeof (CHARRANGE)"
		end

	cwel_charrange_set_cpmin (ptr: POINTER; value: INTEGER)
		external
			"C [macro <chrrange.h>]"
		end

	cwel_charrange_set_cpmax (ptr: POINTER; value: INTEGER)
		external
			"C [macro <chrrange.h>]"
		end

	cwel_charrange_get_cpmin (ptr: POINTER): INTEGER
		external
			"C [macro <chrrange.h>]"
		end

	cwel_charrange_get_cpmax (ptr: POINTER): INTEGER
		external
			"C [macro <chrrange.h>]"
		end

invariant
	positive_minimum: minimum >= 0
	valid_minumum_maximum: minimum <= maximum + 1

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
