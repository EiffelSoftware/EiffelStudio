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
		end

creation
	make

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

feature -- Access

	width: INTEGER is
			-- Width of the rectangle
		require
			exists: exists
		do
			Result := cwel_size_get_cx (item)
		end

	height: INTEGER is
			-- Height of the rectangle
		require
			exists: exists
		do
			Result := cwel_size_get_cy (item)
		end

feature -- Element change

	set_width (a_width: INTEGER) is
			-- Set `width' with `a_width'
		require
			exists: exists
		do
			cwel_size_set_cx (item, a_width)
		ensure
			width_set: width = a_width
		end

	set_height (a_height: INTEGER) is
			-- Set `height' with `a_height'
		require
			exists: exists
		do
			cwel_size_set_cy (item, a_height)
		ensure
			height_set: height = a_height
		end

feature {WEL_STRUCTURE} -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := cwel_size_of_size
		end

feature {NONE} -- Implementation

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
