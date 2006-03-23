indexing
	description: "Contains information associated to 'EM_FINDTEXTEX' messages."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_FIND_ARGUMENT

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

create
	make

feature {NONE} -- Initialization

	make (a_range: WEL_CHARACTER_RANGE; to_find: STRING_GENERAL) is
		require
			string_to_find_valid: to_find /= Void
		local
			a: WEL_STRING
		do
			structure_make

			create a.make (to_find)
			set_string_to_find (a)
			set_range (a_range)
		end

feature -- Access

	range: WEL_CHARACTER_RANGE is
			-- Range of search
		do
			create Result.make_by_pointer (cwel_findargument_get_range (item))
		end

	string_to_find: WEL_STRING
			-- String to find

	range_out: WEL_CHARACTER_RANGE is
			-- Range in which text is found
			-- Return (0,0) if no text was found
		do
			create Result.make_by_pointer (cwel_findargument_get_range_out (item))
		end
		
feature -- Element change

	set_range (a_range: WEL_CHARACTER_RANGE) is
		do
			cwel_findargument_set_range (item, a_range.item)
		end

	set_string_to_find (a_string_to_find: WEL_STRING) is
		do
			string_to_find := a_string_to_find
			cwel_findargument_set_string_to_find (item, a_string_to_find.item)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_findargument
		end

feature {NONE} -- Externals

	c_size_of_findargument: INTEGER is
		external
			"C [macro %"wel_find_argument.h%"]"
		alias
			"sizeof (FINDTEXTEX)"
		end

	cwel_findargument_initialize_range_out_min (ptr: POINTER) is
		external
			"C [macro %"wel_find_argument.h%"]"
		end

	cwel_findargument_initialize_range_out_max (ptr: POINTER) is
		external
			"C [macro %"wel_find_argument.h%"]"
		end
		
	cwel_findargument_set_range (ptr, value: POINTER) is
		external
			"C [macro %"wel_find_argument.h%"]"
		end

	cwel_findargument_set_string_to_find (ptr, value: POINTER) is
		external
			"C [macro %"wel_find_argument.h%"]"
		end

	cwel_findargument_get_range (ptr: POINTER): POINTER is
		external
			"C [macro %"wel_find_argument.h%"] (FINDTEXTEX*): EIF_POINTER"
		end

	cwel_findargument_get_string_to_find (ptr: POINTER): POINTER is
		external
			"C [macro %"wel_find_argument.h%"] (FINDTEXTEX*): EIF_POINTER"
		end

	cwel_findargument_get_range_out (ptr: POINTER): POINTER is
		external
			"C [macro %"wel_find_argument.h%"] (FINDTEXTEX*): EIF_POINTER"
		end
		
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_FIND_ARGUMENT

