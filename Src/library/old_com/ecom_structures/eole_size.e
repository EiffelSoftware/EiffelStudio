indexing

	description: "SIZE structure"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_SIZE

inherit
	EOLE_OBJECT_WITH_POINTER
		redefine
			allocate
		end
	
feature -- Element Change

	allocate: POINTER is
			-- Allocate memory space for associated C++ structure.
		do
			Result := ole2_size_allocate
		end

	set_cx (x: INTEGER) is
			-- Set x-extent with `x'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_size_set_cx (ole_ptr, x)
		ensure
			cx_set: cx = x
		end

	set_cy (y: INTEGER) is
			-- Set y-extent with `y'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_size_set_cy (ole_ptr, y)
		ensure
			cy_set: cy = y
		end

	set_size (x, y: INTEGER) is
			-- Set both x-extent and y-extent with `x' and `y'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_size_set_size (ole_ptr, x, y)
		ensure
			size_set: cx = x and cy = y
		end

feature -- Access

	cx: INTEGER is
			-- x-extent
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_size_get_cx (ole_ptr)
		end

	cy: INTEGER is
			-- y-extent
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_size_get_cy (ole_ptr)
		end
	
feature {NONE} -- Externals

	ole2_size_allocate: POINTER is
		external
			"C"
		alias
			"eole2_size_allocate"
		end

	ole2_size_set_cx (pthis: POINTER; x: INTEGER) is
		external
			"C"
		alias
			"eole2_size_set_cx"
		end

	ole2_size_set_cy (pthis: POINTER; y: INTEGER) is
		external
			"C"
		alias
			"eole2_size_set_cy"
		end

	ole2_size_set_size (pthis: POINTER; x, y: INTEGER) is
		external
			"C"
		alias
			"eole2_size_set_size"
		end

	ole2_size_get_cx (pthis: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_size_get_cx"
		end

	ole2_size_get_cy (pthis: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_size_get_cy"
		end
	
end -- class EOLE_SIZE

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

