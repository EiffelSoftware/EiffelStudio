indexing
	description: "Contains information about a button in a toolbar."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TOOL_BAR_BUTTON

inherit
	WEL_STRUCTURE

	WEL_TB_STYLE_CONSTANTS
		export
			{NONE} all
		end

	WEL_TB_STATE_CONSTANTS
		export
			{NONE} all
		end

creation
	make,
	make_button,
	make_check,
	make_check_group,
	make_group,
	make_separator,
	make_by_pointer

feature {NONE} -- Initialization

	make_button (a_bitmap_index, a_command_id: INTEGER) is
			-- Make a button using `a_bitmap_index' and
			-- `a_command_id'.
		do
			make
			set_style (Tbstyle_button)
			set_state (Tbstate_enabled)
			set_bitmap_index (a_bitmap_index)
			set_command_id (a_command_id)
		ensure
			bitmap_index_set: bitmap_index = a_bitmap_index
			command_id_set: command_id = a_command_id
		end

	make_button_with_string (a_bitmap_index, a_string_index, a_command_id: INTEGER) is
			-- Make a button using `a_bitmap_index' and
			-- `a_command_id'.
		do
			make
			set_style (Tbstyle_button)
			set_string_index (a_string_index)
			set_state (Tbstate_enabled)
			set_bitmap_index (a_bitmap_index)
			set_command_id (a_command_id)
		ensure
			bitmap_index_set: bitmap_index = a_bitmap_index
			command_id_set: command_id = a_command_id
		end

	make_check (a_bitmap_index, a_command_id: INTEGER) is
			-- Make a check button using `a_bitmap_index' and
			-- `a_command_id'.
		do
			make
			set_style (Tbstyle_check)
			set_state (Tbstate_enabled)
			set_bitmap_index (a_bitmap_index)
			set_command_id (a_command_id)
		ensure
			bitmap_index_set: bitmap_index = a_bitmap_index
			command_id_set: command_id = a_command_id
		end

	make_check_group (a_bitmap_index, a_command_id: INTEGER) is
			-- Make a check group using `a_bitmap_index' and
			-- `a_command_id'.
		do
			make
			set_style (Tbstyle_checkgroup)
			set_state (Tbstate_enabled)
			set_bitmap_index (a_bitmap_index)
			set_command_id (a_command_id)
		ensure
			bitmap_index_set: bitmap_index = a_bitmap_index
			command_id_set: command_id = a_command_id
		end

	make_group (a_bitmap_index, a_command_id: INTEGER) is
			-- Make an enabled check group using `a_bitmap_index'
			-- and `a_command_id'.
		do
			make
			set_style (Tbstyle_group)
			set_state (Tbstate_enabled)
			set_bitmap_index (a_bitmap_index)
			set_command_id (a_command_id)
		ensure
			bitmap_index_set: bitmap_index = a_bitmap_index
			command_id_set: command_id = a_command_id
		end

	make_separator is
			-- Make a separator providing a small gap between
			-- groups.
		do
			make
			set_style (Tbstyle_sep)
		end

feature -- Access

	bitmap_index: INTEGER is
			-- Zero-based index of button image
		do
			Result := cwel_tbbutton_get_ibitmap (item)
		end

	command_id: INTEGER is
			-- Command identifier associated with the button. This
			-- identifer is used in a Wm_command message when the
			-- button is chosen.
		do
			Result := cwel_tbbutton_get_idcommand (item)
		end

	state: INTEGER is
			-- Button state flags.
			-- See class WEL_TB_STATE_CONSTANTS for values
		do
			Result := cwel_tbbutton_get_fsstate (item)
		end

	style: INTEGER is
			-- Button style flags.
			-- See class WEL_TB_STYLE_CONSTANTS for values
		do
			Result := cwel_tbbutton_get_fsstyle (item)
		end

	data: INTEGER is
			-- Application-defined value
		do
			Result := cwel_tbbutton_get_dwdata (item)
		end

	string_index: INTEGER is
			-- Zero-based index of button string.
		do
			Result := cwel_tbbutton_get_istring (item)
		ensure
			positive_result: Result >= 0
		end

feature -- Element change

	set_bitmap_index (a_bitmap_index: INTEGER) is
			-- Set `bitmap_index' with `a_bitmap_index'.
		do
			cwel_tbbutton_set_ibitmap (item, a_bitmap_index)
		ensure
			bitmap_index_set: bitmap_index = a_bitmap_index
		end

	set_command_id (a_command_id: INTEGER) is
			-- Set `command_id' with `a_command_id'.
		do
			cwel_tbbutton_set_idcommand (item, a_command_id)
		ensure
			command_id_set: command_id = a_command_id
		end

	set_state (a_state: INTEGER) is
			-- Set `state' with `a_state'.
		do
			cwel_tbbutton_set_fsstate (item, a_state)
		ensure
			state_set: state = a_state
		end

	set_style (a_style: INTEGER) is
			-- Set `style' with `a_style'.
		do
			cwel_tbbutton_set_fsstyle (item, a_style)
		ensure
			style_set: style = a_style
		end

	set_data (a_data: INTEGER) is
			-- Set `data' with `a_data'.
		do
			cwel_tbbutton_set_dwdata (item, a_data)
		ensure
			data_set: data = a_data
		end

	set_string_index (a_string_index: INTEGER) is
			-- Set `string_index' with `a_string_index'.
		require
			positive_index: a_string_index >= 0
		do
			cwel_tbbutton_set_istring (item, a_string_index)
		ensure
			string_index_set: string_index = a_string_index
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_tbbutton
		end

feature {NONE} -- Externals

	c_size_of_tbbutton: INTEGER is
		external
			"C [macro <tbbutton.h>]"
		alias
			"sizeof (TBBUTTON)"
		end

	cwel_tbbutton_set_ibitmap (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <tbbutton.h>]"
		end

	cwel_tbbutton_set_idcommand (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <tbbutton.h>]"
		end

	cwel_tbbutton_set_fsstate (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <tbbutton.h>]"
		end

	cwel_tbbutton_set_fsstyle (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <tbbutton.h>]"
		end

	cwel_tbbutton_set_dwdata (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <tbbutton.h>]"
		end

	cwel_tbbutton_set_istring (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <tbbutton.h>]"
		end

	cwel_tbbutton_get_ibitmap (ptr: POINTER): INTEGER is
		external
			"C [macro <tbbutton.h>]"
		end

	cwel_tbbutton_get_idcommand (ptr: POINTER): INTEGER is
		external
			"C [macro <tbbutton.h>]"
		end

	cwel_tbbutton_get_fsstate (ptr: POINTER): INTEGER is
		external
			"C [macro <tbbutton.h>]"
		end

	cwel_tbbutton_get_fsstyle (ptr: POINTER): INTEGER is
		external
			"C [macro <tbbutton.h>]"
		end

	cwel_tbbutton_get_dwdata (ptr: POINTER): INTEGER is
		external
			"C [macro <tbbutton.h>]"
		end

	cwel_tbbutton_get_istring (ptr: POINTER): INTEGER is
		external
			"C [macro <tbbutton.h>]"
		end

end -- class WEL_TOOL_BAR_BUTTON


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

