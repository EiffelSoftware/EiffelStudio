indexing
	description: "Defines the attributes of a palette."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_LOG_PALETTE

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

creation
	make,
	make_by_pointer

feature {NONE} -- Initialization

	make (a_version, a_num_entries: INTEGER) is
			-- Make a logical palette version `a_version'
			-- with `a_num_entries' entries
		do
			private_num_entries := a_num_entries
			structure_make
			set_version (a_version)
			set_num_entries (a_num_entries)
		ensure
			version_set: version = a_version
			num_entries_set: num_entries = a_num_entries
		end

feature -- Access

	version: INTEGER is
			-- Windows version number for the structure
			-- Must be 768 for Windows 3.0 and later
		do
			Result := cwel_log_palette_get_version (item)
		end

	num_entries: INTEGER is
			-- Number of palette color entries
		do
			Result := cwel_log_palette_get_num_entries (item)
		end

	pal_entry (index: INTEGER): WEL_PALETTE_ENTRY is
			-- Palette entry at `index'
		require
			index_inf: index >= 0
			index_sup: index < num_entries
		do
			create Result.make_by_pointer (
				cwel_log_palette_get_pal_entry (item, index))
		ensure
			result_not_void: Result /= Void
		end

feature -- Element change

	set_version (a_version: INTEGER) is
			-- Set `version' with `a_version'
		do
			cwel_log_palette_set_version (item, a_version)
		ensure
			version_set: version = a_version
		end

	set_num_entries (a_num_entries: INTEGER) is
			-- Set `num_entries' with `a_num_entries'
		do
			cwel_log_palette_set_num_entries (item, a_num_entries)
		ensure
			num_entries_set: num_entries = a_num_entries
		end

	set_pal_entry (index: INTEGER; a_pal_entry: WEL_PALETTE_ENTRY) is
			-- Set `a_pal_entry' at `index'
		require
			a_pal_entry_not_void: a_pal_entry /= Void
		do
			cwel_log_palette_set_pal_entry_red (item, index,
				a_pal_entry.red)
			cwel_log_palette_set_pal_entry_green (item, index,
				a_pal_entry.green)
			cwel_log_palette_set_pal_entry_blue (item, index,
				a_pal_entry.blue)
			cwel_log_palette_set_pal_entry_flags (item, index,
				a_pal_entry.flags)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		do
			Result := c_size_of_log_palette +
				(private_num_entries * c_size_of_pal_entry)
		end

feature {NONE} -- Implementation

	private_num_entries: INTEGER
			-- Number of entries used to allocate the memory

feature {NONE} -- Externals

	c_size_of_log_palette: INTEGER is
		external
			"C [macro <logpal.h>]"
		alias
			"sizeof (LOGPALETTE)"
		end

	c_size_of_pal_entry: INTEGER is
		external
			"C [macro <logpal.h>]"
		alias
			"sizeof (PALETTEENTRY)"
		end

	cwel_log_palette_set_version (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <logpal.h>]"
		end

	cwel_log_palette_set_num_entries (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <logpal.h>]"
		end

	cwel_log_palette_set_pal_entry_red (ptr: POINTER; index,
			value: INTEGER) is
		external
			"C [macro <logpal.h>]"
		end

	cwel_log_palette_set_pal_entry_green (ptr: POINTER; index,
			value: INTEGER) is
		external
			"C [macro <logpal.h>]"
		end

	cwel_log_palette_set_pal_entry_blue (ptr: POINTER; index,
			value: INTEGER) is
		external
			"C [macro <logpal.h>]"
		end

	cwel_log_palette_set_pal_entry_flags (ptr: POINTER; index,
			value: INTEGER) is
		external
			"C [macro <logpal.h>]"
		end

	cwel_log_palette_get_version (ptr: POINTER): INTEGER is
		external
			"C [macro <logpal.h>]"
		end

	cwel_log_palette_get_num_entries (ptr: POINTER): INTEGER is
		external
			"C [macro <logpal.h>]"
		end

	cwel_log_palette_get_pal_entry (ptr: POINTER; i: INTEGER): POINTER is
		external
			"C [macro <logpal.h>]  (LOGPALETTE*, int): EIF_POINTER"
		end

end -- class WEL_LOG_PALETTE


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

