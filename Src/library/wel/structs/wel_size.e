indexing
	description: "Specifies the width and height of a rectangle."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SIZE

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		redefine
			default_create
		end

creation
	make, default_create

feature {NONE} -- Initialization

	make (a_width, a_height: INTEGER) is
			-- Make a size and set `width',
			-- `height', with `a_width', `a_height'
		do
			structure_make
			set_width (a_width)
			set_height (a_height)
		ensure
			width_set: width = a_width
			height_set: height = a_height
		end

	default_create is
			-- Make a size where all fields are set to zero.
		do
			structure_make
			set_width (0)
			set_height (0)
		ensure then
			width_set: width = 0
			height_set: height = 0
		end

feature -- Access

	width: INTEGER is
			-- Width of the rectangle
		do
			Result := cwel_size_get_cx (item)
		end

	height: INTEGER is
			-- Height of the rectangle
		do
			Result := cwel_size_get_cy (item)
		end

feature -- Element change

	set_width (a_width: INTEGER) is
			-- Set `width' with `a_width'
		do
			cwel_size_set_cx (item, a_width)
		ensure
			width_set: width = a_width
		end

	set_height (a_height: INTEGER) is
			-- Set `height' with `a_height'
		do
			cwel_size_set_cy (item, a_height)
		ensure
			height_set: height = a_height
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := cwel_size_of_size
		end

feature {NONE} -- Externals

	cwel_size_of_size: INTEGER is
		external
			"C [macro <wsize.h>]"
		alias
			"sizeof (SIZE)"
		end

	cwel_size_get_cx (ptr: POINTER): INTEGER is
		external
			"C [macro <wsize.h>]"
		end

	cwel_size_get_cy (ptr: POINTER): INTEGER is
		external
			"C [macro <wsize.h>]"
		end

	cwel_size_set_cx (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <wsize.h>]"
		end

	cwel_size_set_cy (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <wsize.h>]"
		end

end -- class WEL_SIZE


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

