indexing

	description: "ULARGE_INTEGER structure"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_LARGE_INTEGER

inherit
	EOLE_OBJECT_WITH_POINTER
		redefine
			allocate
		end
		
feature -- Element change

	allocate: POINTER is
			-- Allocate memory space for associated C++ structure.
		do
			Result := ole2_large_integer_allocate
		end

	set_low_part (l: INTEGER) is
			-- Set 'LowPart' member of
			-- corresponding C++ structure.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_large_integer_set_low_part (ole_ptr, l)
		ensure
			low_part_set: low_part = l
		end

	set_high_part (h: INTEGER) is
			-- Set 'HighPart' member of
			-- corresponding C++ structure.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_large_integer_set_high_part (ole_ptr, h)
		ensure
			high_part_set: high_part = h
		end

feature -- Access

	low_part: INTEGER is
			-- Value of 'LowPart' member of
			-- corresponding C++ structure
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_large_integer_get_low_part (ole_ptr)
		end

	high_part: INTEGER is
			-- Value of 'HighPart' member of
			-- corresponding C++ structure
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_large_integer_get_high_part (ole_ptr)
		end
	
feature {NONE} -- Externals

	ole2_large_integer_allocate: POINTER is
		external
			"C"
		alias
			"eole2_large_integer_allocate"
		end

	ole2_large_integer_set_low_part (this: POINTER; l: INTEGER) is
		external
			"C"
		alias
			"eole2_large_integer_set_low_part"
		end

	ole2_large_integer_set_high_part (this: POINTER; h: INTEGER) is
		external
			"C"
		alias
			"eole2_large_integer_set_high_part"
		end

	ole2_large_integer_get_low_part (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_large_integer_get_low_part"
		end

	ole2_large_integer_get_high_part (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_large_integer_get_high_part"
		end
	
end -- class EOLE_LARGE_INTEGER

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
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


