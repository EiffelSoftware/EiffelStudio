indexing

	description: "RECT structure"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_RECT

inherit
	EOLE_OBJECT_WITH_POINTER
		redefine
			allocate
		end
	
creation 
	make,
	make_from_rect

feature -- Initialization

	make is
			-- Creation without initialization.
		do
		end

	make_from_rect (r: WEL_RECT) is
			-- Initialization with `r'.
		require
			valid_rect: r /= Void
		do
			init
			set_left (r.x)
			set_right (r.x + r.width)
			set_top (r.y)
			set_bottom (r.y + r.height)
		end

feature -- Element change

	allocate: POINTER is
			-- Allocate memory space for associated C++ structure.
		do
			Result := ole2_rect_allocate
		end

	set_left (l: INTEGER) is
			-- Set 'left' member of corresponding
			-- C++ structure to `l'.			
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_rect_set_left (ole_ptr, l)
		ensure
			left_set: left = l
		end

	set_right (r: INTEGER) is
			-- Set 'right' member of corresponding
			-- C++ structure to `r'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_rect_set_right (ole_ptr, r)
		ensure
			right_set: right = r
		end

	set_top (t: INTEGER) is
			-- Set 'top' member of corresponding
			-- C++ structure to `t'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_rect_set_top (ole_ptr, t)
		ensure
			top_set: top = t
		end

	set_bottom (b: INTEGER) is
			-- Set 'bottom' member of corresponding
			-- C++ structure to `b'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_rect_set_bottom (ole_ptr, b)
		ensure
			bottom_set: bottom = b
		end

	set_rect (l, t, r, b: INTEGER) is
			-- Set members of corresponding C++
			-- structure with `l', `t', `r' and `b'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_rect_set_rect (ole_ptr, l, t, r, b)
		ensure
			rect_set: left = l and top = t and right = r and bottom = b
		end

feature -- Access

	left: INTEGER is
			-- X-coordinate of upper-left corner of rectangle
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_rect_get_left (ole_ptr)
		end

	right: INTEGER is
			-- X-coordinate of lower-right corner of rectangle
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_rect_get_right (ole_ptr)
		end

	top: INTEGER is
			-- Y-coordinate of upper-left corner of rectangle
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_rect_get_top (ole_ptr)
		end

	bottom: INTEGER is
			-- Y-coordinate of lower-right corner of rectangle
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_rect_get_bottom (ole_ptr)
		end
	
feature {NONE} -- externals

	ole2_rect_allocate: POINTER is
		external
			"C"
		alias
			"eole2_rect_allocate"
		end

	ole2_rect_set_left (pthis: POINTER; l: INTEGER) is
		external
			"C"
		alias
			"eole2_rect_set_left"
		end

	ole2_rect_set_right (pthis: POINTER; r: INTEGER) is
		external
			"C"
		alias
			"eole2_rect_set_right"
		end

	ole2_rect_set_top (pthis: POINTER; t: INTEGER) is
		external
			"C"
		alias
			"eole2_rect_set_top"
		end

	ole2_rect_set_bottom (pthis: POINTER; b: INTEGER) is
		external
			"C"
		alias
			"eole2_rect_set_bottom"
		end

	ole2_rect_set_rect (pthis: POINTER; l, t, r, b: INTEGER) is
		external
			"C"
		alias
			"eole2_rect_set_rect"
		end

	ole2_rect_get_left (pthis: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_rect_get_left"
		end

	ole2_rect_get_right (pthis: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_rect_get_right"
		end

	ole2_rect_get_top (pthis: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_rect_get_top"
		end

	ole2_rect_get_bottom (pthis: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_rect_get_bottom"
		end
	
end -- class EOLE_RECT

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


