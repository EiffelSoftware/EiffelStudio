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
	make_empty,
	make_by_pointer

feature {NONE} -- Initialization

	make (a_string: STRING) is
			-- Make a C string from `a_string'.
		require
			a_string_not_void: a_string /= Void
		local
			a: ANY
		do
			cwel_set_string_length (a_string.count)
			item := c_calloc (1, a_string.count + 1)
			if item = default_pointer then
				-- Memory allocation problem
				c_enomem
			end
			a := a_string.to_c
			memory_copy ($a, a_string.count + 1)
			shared := False
		ensure
			not_shared: not shared
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
		end

feature -- Access

	string: STRING is
			-- Eiffel string
		do
			!! Result.make (0)
			Result.from_c (item)
		ensure
			result_not_void: Result /= Void
		end
		
	length: INTEGER is
			-- String length
		do
			Result := cwel_string_length
		end
		
feature -- Element change

	set_string (a_string: STRING) is
			-- Set `string' with `a_string'.
		require
			a_string_not_void: a_string /= Void
			valid_count: a_string.count < length
		local
			a: ANY
		do
			cwel_set_string_length (a_string.count)
			a := a_string.to_c
			memory_copy ($a, a_string.count + 1)
		ensure
			string_set: a_string.is_equal (a_string)
		end
		
feature -- Measurement

	structure_size: INTEGER is
			-- String length
		do
			Result := length
		end

feature {NONE} -- Implementation

	cwel_string_length: INTEGER is
		external
			"C [macro %"wel_string.h%"]"
		end
	
	cwel_set_string_length (len: INTEGER) is
		external
			"C [macro %"wel_string.h%"]"
		end

end -- class WEL_STRING

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

