indexing
	description: "Specifies the color and usage of an entry in a logical %
		%color palette."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PALETTE_ENTRY

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

creation
	make,
	make_by_pointer

feature {NONE} -- Initialization

	make (a_red, a_green, a_blue, a_flags: INTEGER) is
			-- Make a palette entry with colors
			-- `a_red', `a_green', `a_blue'
			-- For `a_flags', see class WEL_PC_FLAGS_CONSTANTS
		do
			structure_make
			set_red (a_red)
			set_green (a_green)
			set_blue (a_blue)
			set_flags (a_flags)
		ensure
			red_set: red = a_red
			green_set: green = a_green
			blue_set: blue = a_blue
			flags_set: flags = a_flags
		end

feature -- Access

	red: INTEGER is
		do
			Result := cwel_palette_entry_get_red (item)
		end

	green: INTEGER is
		do
			Result := cwel_palette_entry_get_green (item)
		end

	blue: INTEGER is
		do
			Result := cwel_palette_entry_get_blue (item)
		end

	flags: INTEGER is
		do
			Result := cwel_palette_entry_get_flags (item)
		end

feature -- Element change

	set_red (a_red: INTEGER) is
		do
			cwel_palette_entry_set_red (item, a_red)
		ensure
			red_set: red = a_red
		end

	set_green (a_green: INTEGER) is
		do
			cwel_palette_entry_set_green (item, a_green)
		ensure
			green_set: green = a_green
		end

	set_blue (a_blue: INTEGER) is
		do
			cwel_palette_entry_set_blue (item, a_blue)
		ensure
			blue_set: blue = a_blue
		end

	set_flags (a_flags: INTEGER) is
		do
			cwel_palette_entry_set_flags (item, a_flags)
		ensure
			flags_set: flags = a_flags
		end


feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_palette_entry
		end

feature {NONE} -- Externals

	c_size_of_palette_entry: INTEGER is
		external
			"C [macro <palentry.h>]"
		alias
			"sizeof (PALETTEENTRY)"
		end

	cwel_palette_entry_set_red (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <palentry.h>]"
		end

	cwel_palette_entry_set_green (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <palentry.h>]"
		end

	cwel_palette_entry_set_blue (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <palentry.h>]"
		end

	cwel_palette_entry_set_flags (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <palentry.h>]"
		end

	cwel_palette_entry_get_red (ptr: POINTER): INTEGER is
		external
			"C [macro <palentry.h>]"
		end

	cwel_palette_entry_get_green (ptr: POINTER): INTEGER is
		external
			"C [macro <palentry.h>]"
		end

	cwel_palette_entry_get_blue (ptr: POINTER): INTEGER is
		external
			"C [macro <palentry.h>]"
		end

	cwel_palette_entry_get_flags (ptr: POINTER): INTEGER is
		external
			"C [macro <palentry.h>]"
		end

end -- class WEL_PALETTE_ENTRY


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

