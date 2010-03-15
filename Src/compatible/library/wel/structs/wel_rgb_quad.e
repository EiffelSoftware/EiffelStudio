note
	description: "Describes a color consisting of relative intensities of %
		%red, green, and blue."
	legal: "See notice at end of class."
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

create
	make,
	make_by_pointer

feature {NONE} -- Initialization

	make
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

	red: INTEGER
		require
			exists: exists
		do
			Result := cwel_rgb_quad_get_rgb_red (item)
		end

	green: INTEGER
		require
			exists: exists
		do
			Result := cwel_rgb_quad_get_rgb_green (item)
		end

	blue: INTEGER
		require
			exists: exists
		do
			Result := cwel_rgb_quad_get_rgb_blue (item)
		end

	reserved: INTEGER
		require
			exists: exists
		do
			Result := cwel_rgb_quad_get_rgb_reserved (item)
		end

feature -- Element change

	set_red (a_red: INTEGER)
			-- Set `red' with `a_red'
		require
			exists: exists
		do
			cwel_rgb_quad_set_rgb_red (item, a_red)
		ensure
			red_set: red = a_red
		end

	set_green (a_green: INTEGER)
			-- Set `green' with `a_green'
		require
			exists: exists
		do
			cwel_rgb_quad_set_rgb_green (item, a_green)
		ensure
			green_set: green = a_green
		end

	set_blue (a_blue: INTEGER)
			-- Set `blue' with `a_blue'
		require
			exists: exists
		do
			cwel_rgb_quad_set_rgb_blue (item, a_blue)
		ensure
			blue_set: blue = a_blue
		end

	set_reserved (a_reserved: INTEGER)
			-- Set `reserved' with `a_reserved'
		require
			exists: exists
		do
			cwel_rgb_quad_set_rgb_reserved (item, a_reserved)
		ensure
			reserved_set: reserved = a_reserved
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_rgb_quad
		end

feature {NONE} -- Externals

	c_size_of_rgb_quad: INTEGER
		external
			"C [macro <rgbquad.h>]"
		alias
			"sizeof (RGBQUAD)"
		end

	cwel_rgb_quad_set_rgb_red (ptr: POINTER; value: INTEGER)
		external
			"C [macro <rgbquad.h>]"
		end

	cwel_rgb_quad_set_rgb_green (ptr: POINTER; value: INTEGER)
		external
			"C [macro <rgbquad.h>]"
		end

	cwel_rgb_quad_set_rgb_blue (ptr: POINTER; value: INTEGER)
		external
			"C [macro <rgbquad.h>]"
		end

	cwel_rgb_quad_set_rgb_reserved (ptr: POINTER; value: INTEGER)
		external
			"C [macro <rgbquad.h>]"
		end

	cwel_rgb_quad_get_rgb_red (ptr: POINTER): INTEGER
		external
			"C [macro <rgbquad.h>]"
		end

	cwel_rgb_quad_get_rgb_green (ptr: POINTER): INTEGER
		external
			"C [macro <rgbquad.h>]"
		end

	cwel_rgb_quad_get_rgb_blue (ptr: POINTER): INTEGER
		external
			"C [macro <rgbquad.h>]"
		end

	cwel_rgb_quad_get_rgb_reserved (ptr: POINTER): INTEGER
		external
			"C [macro <rgbquad.h>]"
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
