indexing
	description: "Process creation startup information."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_STARTUP_INFO

inherit
	WEL_STRUCTURE

	WEL_STARTUP_CONSTANTS

	WEL_BIT_OPERATIONS

	WEL_FILL_ATTRIBUTES_CONSTANTS

creation
	make

feature -- Access

	title: STRING is
			-- Console application title
		local
			title_pointer: POINTER
			null_pointer: POINTER
		do
			create Result.make (0)
			title_pointer := cwel_startup_info_title (item)
			if title_pointer /= null_pointer then
				Result.from_c (title_pointer)
			end
		end

	x_offset: INTEGER is
			-- X offset, in pixels, of upper left corner of window 
			-- if a new window is created.
		require
			flag_has_startf_use_position: flag_set (flags, Startf_use_position)
		do
			Result := cwel_startup_info_x_offset (item)
		end

	y_offset: INTEGER is
			-- Y offset, in pixels, of upper left corner of window 
			-- if a new window is created.
		require
			flag_has_startf_use_position: flag_set (flags, Startf_use_position)
		do
			Result := cwel_startup_info_y_offset (item)
		end
	
	width: INTEGER is
			-- Width of new window if any
		require
			flag_has_startf_use_size: flag_set (flags, Startf_use_size)
		do
			Result := cwel_startup_info_width (item)
		end
		
	height: INTEGER is
			-- Height of new window if any
		require
			flag_has_startf_use_size: flag_set (flags, Startf_use_size)
		do
			Result := cwel_startup_info_height (item)
		end

	x_character_count: INTEGER is
			-- Console application screen buffer in character columns
		require
			flag_has_startf_use_count_chars: flag_set (flags, Startf_use_count_chars)
		do
			Result := cwel_startup_info_x_char_count (item)
		end

	y_character_count: INTEGER is
			-- Console application screen buffer in character lines 
		require
			flag_has_startf_use_count_chars: flag_set (flags, Startf_use_count_chars)
		do
			Result := cwel_startup_info_y_char_count (item)
		end
	
	fill_attributes: INTEGER is 
			-- Color used for background and text of a console application
			-- See class WEL_FILL_ATTRIBUTE_CONSTANTS for possible value.
		require
			flag_has_startf_use_fill_attributes: flag_set (flags, Startf_use_fill_attributes)
		do
			Result := cwel_startup_info_fill_attribute (item)
		end
		
	flags: INTEGER is
			-- Valid fields
			-- See WEL_STARTUP_FLAGS for possible values.
		do
			Result := cwel_startup_info_flags (item)
		end
	
	show_command: INTEGER is
			-- Default show command used for a GUI application
		require
			flag_has_startf_use_show_window: flag_set (flags, Startf_use_show_window)
		do
			Result := cwel_startup_info_show_command (item)
		end

	std_input: INTEGER is
			-- Standard input process handle
		require
			flag_has_startf_use_std_handles: flag_set (flags, Startf_use_std_handles)
		do
			Result := cwel_startup_info_std_input (item)
		end
	
	std_output: INTEGER is
			-- Standard output process handle
		require
			flag_has_startf_use_std_handles: flag_set (flags, Startf_use_std_handles)
		do
			Result := cwel_startup_info_std_output (item)
		end

	std_error: INTEGER is
			-- Standard error output process handle
		require
			flag_has_startf_use_std_handles: flag_set (flags, Startf_use_std_handles)
		do
			Result := cwel_startup_info_std_error (item)
		end

feature -- Element Change

	set_title (a_title: like title) is
			-- Set `title' with `a_title'.
		require
			non_void_title: a_title /= Void
		do
			create internal_title.make (a_title)
			cwel_startup_info_set_title (item, internal_title.item)
		ensure
			title_set: title.is_equal (a_title)
		end
	
	set_x_offset (an_offset: like x_offset) is
			-- Set `x_offset' with `an_offset'.
		do
			add_flag (Startf_use_position)
			cwel_startup_info_set_x_offset (item, an_offset)
		ensure
			offset_set: x_offset = an_offset
		end
	
	set_y_offset (an_offset: like y_offset) is
			-- Set `y_offset' with `an_offset'.
		do
			add_flag (Startf_use_position)
			cwel_startup_info_set_y_offset (item, an_offset)
		ensure
			offset_set: y_offset = an_offset
		end

	set_width (a_width: like width) is
			-- Set `width' with `a_width'.
		require
			valid_width: a_width > 0
		do
			add_flag (Startf_use_size)
			cwel_startup_info_set_width (item, a_width)
		ensure
			width_set: width = a_width
		end
	
	set_height (a_height: like height) is
			-- Set `height' with `a_height'.
		require
			valid_height: a_height > 0
		do
			add_flag (Startf_use_size)
			cwel_startup_info_set_height (item, a_height)
		ensure
			height_set: height = a_height
		end

	set_x_character_count (a_character_count: like x_character_count) is
			-- Set `character_count' with `a_character_count'.
		require
			valid_count: a_character_count > 0
		do
			add_flag (Startf_use_count_chars)
			cwel_startup_info_set_x_char_count (item, a_character_count)
		ensure
			character_count_set: x_character_count = a_character_count
		end

	set_y_character_count (a_character_count: like y_character_count) is
			-- Set `character_count' with `a_character_count'.
		require
			valid_count: a_character_count > 0
		do
			add_flag (Startf_use_count_chars)
			cwel_startup_info_set_y_char_count (item, a_character_count)
		ensure
			character_count_set: y_character_count = a_character_count
		end

	set_fill_attributes (a_fill_attributes: like fill_attributes) is
			-- Set `fill_attributes' with `a_fill_attributes'.
			-- See class `WEL_FILL_ATTRIBUTES_CONSTANTS' for possible `a_fill_attributes' value.
		require
			valid_fill_attributes: is_valid_fill_attributes (a_fill_attributes)
		do
			add_flag (Startf_use_fill_attributes)
			cwel_startup_info_set_fill_attributes (item, a_fill_attributes)
		ensure
			fill_attributes_set: fill_attributes = a_fill_attributes
		end
	
	set_flags (a_flags: INTEGER) is
			-- Set `flags' with `a_flags'
		require
			valid_flags: is_valid_startup_flags (a_flags)
		do
			cwel_startup_info_set_flags (item, a_flags)
		ensure
			flags_set: flags = a_flags
		end
		
	add_flag (a_flag: INTEGER) is
			-- Add `a_flag' to `flags'.
			-- See class WEL_STARTUP_FLAGS for possible `a_flag' value.
		require
			valid_flag: is_valid_startup_flag (a_flag)
		local
			old_flags: INTEGER
		do
			old_flags := flags
			old_flags := set_flag (old_flags, a_flag)
			cwel_startup_info_set_flags (item, old_flags)
		ensure
			flags_set: flag_set (flags, a_flag)
		end
		
	set_show_command (a_command: like show_command) is
			-- Set `show_command' with `a_command'.
		do
			cwel_startup_info_set_show_command (item, a_command)
		ensure
			show_command_set: show_command = a_command
		end
	
	set_std_input (an_input: INTEGER) is
			-- Set `std_input' with `an_input'.
		do
			cwel_startup_info_set_std_input (item, an_input)
		ensure
			std_input_set: std_input = an_input
		end
	
	set_std_output (an_output: INTEGER) is
			-- Set `std_output' with `an_output'.
		do
			cwel_startup_info_set_std_output (item, an_output)
		ensure
			std_output_set: std_output = an_output
		end
	
	set_std_error (an_error_output: INTEGER) is
			-- Set `std_error' with `an_error_output'.
		do
			cwel_startup_info_set_std_error (item, an_error_output)
		ensure
			error_output_set: std_error = an_error_output
		end

feature {NONE} -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		do
			Result := c_size_of_startup_info
		end

feature {NONE} -- Implementation

	internal_title: WEL_STRING
			-- WEL_STRING object associated with the title		
			
feature {NONE} -- Externals

	c_size_of_startup_info: INTEGER is
		external
			"C [macro %"wel_startup_info.h%"]"
		alias
			"sizeof (STARTUPINFO)"
		end

	cwel_startup_info_title (ptr: POINTER): POINTER is
		external
			"C [macro %"wel_startup_info.h%"] (LPSTARTUPINFO): EIF_POINTER"
		end
	
	cwel_startup_info_x_offset (ptr: POINTER): INTEGER is
		external
			"C [macro %"wel_startup_info.h%"] (LPSTARTUPINFO): EIF_INTEGER"
		end

	cwel_startup_info_y_offset (ptr: POINTER): INTEGER is
		external
			"C [macro %"wel_startup_info.h%"] (LPSTARTUPINFO): EIF_INTEGER"
		end

	cwel_startup_info_width (ptr: POINTER): INTEGER is
		external
			"C [macro %"wel_startup_info.h%"] (LPSTARTUPINFO): EIF_INTEGER"
		end

	cwel_startup_info_height (ptr: POINTER): INTEGER is
		external
			"C [macro %"wel_startup_info.h%"] (LPSTARTUPINFO): EIF_INTEGER"
		end

	cwel_startup_info_x_char_count (ptr: POINTER): INTEGER is
		external
			"C [macro %"wel_startup_info.h%"] (LPSTARTUPINFO): EIF_INTEGER"
		end

	cwel_startup_info_y_char_count (ptr: POINTER): INTEGER is
		external
			"C [macro %"wel_startup_info.h%"] (LPSTARTUPINFO): EIF_INTEGER"
		end

	cwel_startup_info_fill_attribute (ptr: POINTER): INTEGER is
		external
			"C [macro %"wel_startup_info.h%"] (LPSTARTUPINFO): EIF_INTEGER"
		end

	cwel_startup_info_flags (ptr: POINTER): INTEGER is
		external
			"C [macro %"wel_startup_info.h%"] (LPSTARTUPINFO): EIF_INTEGER"
		end

	cwel_startup_info_show_command (ptr: POINTER): INTEGER is
		external
			"C [macro %"wel_startup_info.h%"] (LPSTARTUPINFO): EIF_INTEGER"
		end

	cwel_startup_info_std_input (ptr: POINTER): INTEGER is
		external
			"C [macro %"wel_startup_info.h%"] (LPSTARTUPINFO): EIF_INTEGER"
		end

	cwel_startup_info_std_output (ptr: POINTER): INTEGER is
		external
			"C [macro %"wel_startup_info.h%"] (LPSTARTUPINFO): EIF_INTEGER"
		end

	cwel_startup_info_std_error (ptr: POINTER): INTEGER is
		external
			"C [macro %"wel_startup_info.h%"] (LPSTARTUPINFO): EIF_INTEGER"
		end

	cwel_startup_info_set_title (ptr, a_title: POINTER) is
		external
			"C [macro %"wel_startup_info.h%"] (LPSTARTUPINFO, LPTSTR)"
		end

	cwel_startup_info_set_x_offset (ptr: POINTER; an_integer: INTEGER) is
		external
			"C [macro %"wel_startup_info.h%"] (LPSTARTUPINFO, DWORD)"
		end

	cwel_startup_info_set_y_offset (ptr: POINTER; an_integer: INTEGER) is
		external
			"C [macro %"wel_startup_info.h%"] (LPSTARTUPINFO, DWORD)"
		end

	cwel_startup_info_set_width (ptr: POINTER; an_integer: INTEGER) is
		external
			"C [macro %"wel_startup_info.h%"] (LPSTARTUPINFO, DWORD)"
		end

	cwel_startup_info_set_height (ptr: POINTER; an_integer: INTEGER) is
		external
			"C [macro %"wel_startup_info.h%"] (LPSTARTUPINFO, DWORD)"
		end

	cwel_startup_info_set_x_char_count (ptr: POINTER; an_integer: INTEGER) is
		external
			"C [macro %"wel_startup_info.h%"] (LPSTARTUPINFO, DWORD)"
		end

	cwel_startup_info_set_y_char_count (ptr: POINTER; an_integer: INTEGER) is
		external
			"C [macro %"wel_startup_info.h%"] (LPSTARTUPINFO, DWORD)"
		end

	cwel_startup_info_set_fill_attributes (ptr: POINTER; an_integer: INTEGER) is
		external
			"C [macro %"wel_startup_info.h%"] (LPSTARTUPINFO, DWORD)"
		end

	cwel_startup_info_set_flags (ptr: POINTER; an_integer: INTEGER) is
		external
			"C [macro %"wel_startup_info.h%"] (LPSTARTUPINFO, DWORD)"
		end

	cwel_startup_info_set_show_command (ptr: POINTER; an_integer: INTEGER) is
		external
			"C [macro %"wel_startup_info.h%"] (LPSTARTUPINFO, DWORD)"
		end

	cwel_startup_info_set_std_input (ptr: POINTER; an_integer: INTEGER) is
		external
			"C [macro %"wel_startup_info.h%"] (LPSTARTUPINFO, DWORD)"
		end

	cwel_startup_info_set_std_output (ptr: POINTER; an_integer: INTEGER) is
		external
			"C [macro %"wel_startup_info.h%"] (LPSTARTUPINFO, DWORD)"
		end

	cwel_startup_info_set_std_error (ptr: POINTER; an_integer: INTEGER) is
		external
			"C [macro %"wel_startup_info.h%"] (LPSTARTUPINFO, DWORD)"
		end

end -- class WEL_STARTUP_INFO


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

