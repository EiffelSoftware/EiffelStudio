indexing
	description: "A low-level string class to solve some garbage %
		%collector problems (object move). The end-user must not use %
		%this class. Use class STRING instead."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_STRING

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

creation
	make,
	make_empty

feature {NONE} -- Initialization

	make (a_string: STRING) is
			-- Make a C string from `a_string'.
		require
			a_string_not_void: a_string /= Void
		local
			a: ANY
		do
			capacity := a_string.count + 1
			structure_make
			a := a_string.to_c
			memory_copy ($a, capacity)
		ensure
			exists: exists
			--string_set: string.is_equal (a_string)
			capacity_set: capacity = a_string.count + 1
		end

	make_empty (a_length: INTEGER) is
			-- Make an empty C string of `a_length' characters.
		require
			positive_length: a_length >= 0
		local
			s: STRING
		do
			!! s.make (a_length)
			s.fill_blank
			make (s)
		ensure
			exists: exists
			capacity_set: capacity = a_length + 1
		end

feature -- Access

	string: STRING is
			-- Eiffel string
		require
			exists: exists
		do
			!! Result.make (0)
			Result.from_c (item)
		ensure
			result_not_void: Result /= Void
		end

	capacity: INTEGER
			-- String capacity including the null character

feature -- Element change

	set_string (a_string: STRING) is
			-- Set `string' with `a_string'.
		require
			a_string_not_void: a_string /= Void
			count_ok: a_string.count < capacity
		local
			a: ANY
		do
			a := a_string.to_c
			c_strcpy (item, $a)
		ensure
			string_set: a_string.is_equal (a_string)
		end

feature {WEL_STRUCTURE} -- Measurement

	structure_size: INTEGER is
			-- String length
		do
			Result := capacity
		end

feature {NONE} -- Externals

	c_strcpy (destination_ptr, source_ptr: POINTER) is
			-- C strcpy
		external
			"C [macro <string.h>] (char *, char *)"
		alias
			"strcpy"
		end

invariant

	capacity_ok: exists implies string.count < capacity

end -- class WEL_STRING

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
