indexing

	description: "FILETIME structure"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	WEL_FILETIME

inherit
	WEL_STRUCTURE
		redefine
			is_equal
		end

creation
	make, make_from_pointer

feature {NONE} -- Initialization

	make_from_pointer (a_pointer: POINTER) is
			-- Set `item' with `a_pointer'.
		require
			valid_pointer: a_pointer /= Default_pointer
		do
			item := a_pointer
		ensure
			item_set: item = a_pointer
		end

feature -- Access

	high_date_time: INTEGER is
			-- High 32 bits of OLE date/time
		require
			valid_cwel_structure: item /= default_pointer
		do
			Result := cwel_filetime_get_high_date_time (item)
		end
		
	low_date_time: INTEGER is
			-- Low 32 bits of OLE date/time
		require
			valid_cwel_structure: item /= default_pointer
		do
			Result := cwel_filetime_get_low_date_time (item)
		end
		
feature -- Element change

	set_high_date_time (hi_date_time: INTEGER) is
			-- Set high 32 bit of corresponding C++ structure 
			-- to OLE date/time `hi_date_time'.
		require
			valid_cwel_structure: item /= default_pointer
		do
			cwel_filetime_set_high_date_time (item, hi_date_time)
		ensure
			high_date_time_set: high_date_time = hi_date_time
		end

	set_low_date_time (lo_date_time: INTEGER) is
			-- Set low 32 bit of corresponding C++ structure
			-- to OLE date/time `lo_date_time'.
		require
			valid_cwel_structure: item /= default_pointer
		do
			cwel_filetime_set_low_date_time (item, lo_date_time)
		ensure
			low_date_time_set: low_date_time = lo_date_time
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' same as Current?
		do
			Result := other.high_date_time = high_date_time and
						other.low_date_time = low_date_time
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		do
			Result := cwel_size_of_filetime
		end
		
feature {NONE} -- Externals

	cwel_size_of_filetime: INTEGER is
		external
			"C [macro <filetime.h>]"
		alias
			"sizeof (FILETIME)"
		end

	cwel_filetime_set_high_date_time (pointer: POINTER; hi_date_time: INTEGER) is
		external
			"C [macro <filetime.h>]"
		end

	cwel_filetime_set_low_date_time (pointer: POINTER; lo_date_time: INTEGER) is
		external
			"C [macro <filetime.h>]"
		end

	cwel_filetime_get_high_date_time (pointer: POINTER): INTEGER is
		external
			"C [macro <filetime.h>]"
		end

	cwel_filetime_get_low_date_time (pointer: POINTER): INTEGER is
		external
			"C [macro <filetime.h>]"
		end
	
end -- class WEL_FILETIME

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
