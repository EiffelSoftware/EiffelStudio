indexing
	description: "Describes a color consisting of relative intensities of %
		%red, green, and blue."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_RGB_QUAD

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

creation
	make,
	make_by_pointer

feature {NONE} -- Initialization

	make is
		do
			structure_make
			set_red (0)
			set_green (0)
			set_blue (0)
			set_reserved (0)
		ensure
			red_set: red = 0
			green_set: green = 0
			blue_set: blue = 0
			reserved_set: reserved = 0
		end

feature -- Access

	red: INTEGER is
		require
			exists: exists
		do
			Result := cwel_rgb_quad_get_rgb_red (item)
		end

	green: INTEGER is
		require
			exists: exists
		do
			Result := cwel_rgb_quad_get_rgb_green (item)
		end

	blue: INTEGER is
		require
			exists: exists
		do
			Result := cwel_rgb_quad_get_rgb_blue (item)
		end

	reserved: INTEGER is
		require
			exists: exists
		do
			Result := cwel_rgb_quad_get_rgb_reserved (item)
		end

feature -- Element change

	set_red (a_red: INTEGER) is
			-- Set `red' with `a_red'
		require
			exists: exists
		do
			cwel_rgb_quad_set_rgb_red (item, a_red)
		ensure
			red_set: red = a_red
		end

	set_green (a_green: INTEGER) is
			-- Set `green' with `a_green'
		require
			exists: exists
		do
			cwel_rgb_quad_set_rgb_green (item, a_green)
		ensure
			green_set: green = a_green
		end

	set_blue (a_blue: INTEGER) is
			-- Set `blue' with `a_blue'
		require
			exists: exists
		do
			cwel_rgb_quad_set_rgb_blue (item, a_blue)
		ensure
			blue_set: blue = a_blue
		end

	set_reserved (a_reserved: INTEGER) is
			-- Set `reserved' with `a_reserved'
		require
			exists: exists
		do
			cwel_rgb_quad_set_rgb_reserved (item, a_reserved)
		ensure
			reserved_set: reserved = a_reserved
		end

feature {WEL_STRUCTURE} -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_rgb_quad
		end

feature {NONE} -- Externals

	c_size_of_rgb_quad: INTEGER is
		external
			"C [macro <rgbquad.h>]"
		alias
			"sizeof (RGBQUAD)"
		end

	cwel_rgb_quad_set_rgb_red (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <rgbquad.h>]"
		end

	cwel_rgb_quad_set_rgb_green (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <rgbquad.h>]"
		end

	cwel_rgb_quad_set_rgb_blue (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <rgbquad.h>]"
		end

	cwel_rgb_quad_set_rgb_reserved (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <rgbquad.h>]"
		end

	cwel_rgb_quad_get_rgb_red (ptr: POINTER): INTEGER is
		external
			"C [macro <rgbquad.h>]"
		end

	cwel_rgb_quad_get_rgb_green (ptr: POINTER): INTEGER is
		external
			"C [macro <rgbquad.h>]"
		end

	cwel_rgb_quad_get_rgb_blue (ptr: POINTER): INTEGER is
		external
			"C [macro <rgbquad.h>]"
		end

	cwel_rgb_quad_get_rgb_reserved (ptr: POINTER): INTEGER is
		external
			"C [macro <rgbquad.h>]"
		end

end -- class WEL_RGB_QUAD

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
