indexing

	description: "FILETIME structure"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_FILE_TIME

inherit
	EOLE_OBJECT_WITH_POINTER
		redefine
			allocate,
			is_equal
		end
		
feature -- Element change

	allocate: POINTER is
			-- Allocate memory space for associated C++ structure.
		do
			Result := ole2_filetime_allocate
		end

	set_high_date_time (hi_date_time: INTEGER) is
			-- Set high 32 bit of corresponding C++ structure 
			-- to OLE date/time `hi_date_time'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_filetime_set_high_date_time (ole_ptr, hi_date_time)
		ensure
			high_date_time_set: high_date_time = hi_date_time
		end

	set_low_date_time (lo_date_time: INTEGER) is
			-- Set low 32 bit of corresponding C++ structure
			-- to OLE date/time `lo_date_time'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_filetime_set_low_date_time (ole_ptr, lo_date_time)
		ensure
			low_date_time_set: low_date_time = lo_date_time
		end

feature -- Access

	high_date_time: INTEGER is
			-- High 32 bits of OLE date/time
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_filetime_get_high_date_time (ole_ptr)
		end
		
	low_date_time: INTEGER is
			-- Low 32 bits of OLE date/time
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_filetime_get_low_date_time (ole_ptr)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' same as Current?
		do
			Result := other.high_date_time = high_date_time and
						other.low_date_time = low_date_time
		end
		
feature {NONE} -- Externals

	ole2_filetime_allocate: POINTER is
		external
			"C"
		alias
			"eole2_filetime_allocate"
		end;

	ole2_filetime_set_high_date_time (this: POINTER; hi_date_time: INTEGER) is
		external
			"C"
		alias
			"eole2_filetime_set_high_date_time"
		end;

	ole2_filetime_set_low_date_time (this: POINTER; lo_date_time: INTEGER) is
		external
			"C"
		alias
			"eole2_filetime_set_low_date_time"
		end;

	ole2_filetime_get_high_date_time (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_filetime_get_high_date_time"
		end;

	ole2_filetime_get_low_date_time (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_filetime_get_low_date_time"
		end;
	
end -- class EOLE_FILETIME

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1998.
--| Modifications and extensions: copyright (C) ISE, 1998.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

