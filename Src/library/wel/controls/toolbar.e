indexing
	description: "Control window that contains one or more buttons. Each %
		%buttons sends a command message to the parent window when the %
		%user chooses it."
	note: "The common controls dll (WEL_COMMON_CONTROLS_DLL) needs to %
		%be loaded to use this control."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TOOL_BAR

inherit
	WEL_CONTROL
		redefine
			text,
			text_length,
			set_text
		end

	WEL_TB_CONSTANTS
		export
			{NONE} all
		end

	WEL_TB_STYLE_CONSTANTS
		export
			{NONE} all
		end

	WEL_MAIN_ARGUMENTS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make (a_parent: WEL_COMPOSITE_WINDOW; an_id: INTEGER) is
			-- Create a toolbar with `a_parent' as parent and
			-- `an_id' as id.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
		do
			internal_window_make (a_parent, Void, default_style,
				0, 0, 0, 0, an_id, default_pointer)
			set_button_struct_size
			id := an_id
		ensure
			exists: exists
			parent_set: parent = a_parent
			id_set: id = an_id
		end

feature -- Basic operations

	reposition is
			-- Reposition the bar according to the parent.
			-- This function needs to be called in the
			-- `on_size' function of the parent.
		require
			exists: exists
		do
			cwin_send_message (item, Wm_size, 0, 0)
		end

	auto_size is
			-- Resize tooolbar after changes.
			-- An application sends the Tb_autosize message after
			-- causing the size of a toolbar to change either by
			-- setting the button or bitmap size or by adding strings
			-- for the first time.
		require
			exists: exists
		do
			cwin_send_message (item, Tb_autosize, 0, 0)
		end

feature -- Status setting

	check_button (command_id: INTEGER) is
			-- Checks a button identified by `command_id'.
		require
			exists: exists
		do
			cwin_send_message (item, Tb_checkbutton, command_id,
				cwin_make_long (1, 0))
		ensure
			button_is_checked: button_checked (command_id)
		end

	uncheck_button (command_id: INTEGER) is
			-- Unchecks a button identified by `command_id'
		require
			exists: exists
		do
			cwin_send_message (item, Tb_checkbutton, command_id, 0)
		ensure
			button_unchecked: not button_checked (command_id)
		end

	enable_button (command_id: INTEGER) is
			-- Enable the button identified by `command_id'.
		require
			exists: exists
		do
			cwin_send_message (item, Tb_enablebutton, command_id,
				cwin_make_long (1, 0))
		ensure
			button_enabled: button_enabled (command_id)
		end

	disable_button (command_id: INTEGER) is
			-- Disable the button identified by `command_id'.
		require
			exists: exists
		do
			cwin_send_message (item, Tb_enablebutton, command_id, 0)
		ensure
			button_disabled: not button_enabled (command_id)
		end

	show_button (command_id: INTEGER) is
			-- Show the button identified by `command_id'.
		require
			exists: exists
		do
			cwin_send_message (item, Tb_hidebutton, command_id, 0)
		ensure
			button_shown: not button_hidden (command_id)
		end

	hide_button (command_id: INTEGER) is
			-- Hide the button identified by `command_id'.
		require
			exists: exists
		do
			cwin_send_message (item, Tb_hidebutton, command_id,
				cwin_make_long (1, 0))
		ensure
			button_hidden: button_hidden (command_id)
		end

	set_indeterminate_state (command_id: INTEGER) is
			-- Set the indeterminate state of the button
			-- identified by `command_id'.
		require
			exists: exists
		do
			cwin_send_message (item, Tb_indeterminate, command_id,
				cwin_make_long (1, 0))
		ensure
			button_indeterminate: button_indeterminate (command_id)
		end

	clear_indeterminate_state (command_id: INTEGER) is
			-- Clear the indeterminate state of the button
			-- identified by `command_id'.
		require
			exists: exists
		do
			cwin_send_message (item, Tb_indeterminate, command_id, 0)
		ensure
			button_not_indeterminate:
				not button_indeterminate (command_id)
		end

	press_button (command_id: INTEGER) is
			-- Press the button identified by `command_id'.
		require
			exists: exists
		do
			cwin_send_message (item, Tb_pressbutton, command_id,
				cwin_make_long (1, 0))
		ensure
			button_pressed: button_pressed (command_id)
		end

	release_button (command_id: INTEGER) is
			-- Release the button identified by `command_id'.
		require
			exists: exists
		do
			cwin_send_message (item, Tb_pressbutton, command_id, 0)
		ensure
			button_not_pressed: not button_pressed (command_id)
		end

	set_bitmap_size (a_width, a_height: INTEGER) is
			-- Sets the size of the bitmapped images to be added to
			-- the toolbar.
			-- The size can be set only before adding any
			-- bitmaps to the toolbar. If an application does
			-- not explicitly set the bitmap size, the size
			-- defaults to 16 by 15 pixels.
		require
			exists: exists
			positive_width: a_width >=0
			positive_height: a_height >= 0
		do
			cwin_send_message (item, Tb_setbitmapsize, 0,
				cwin_make_long (a_width, a_height))
		end

	set_button_size (a_width, a_height: INTEGER) is
			-- Set the size of the buttons to be added to the
			-- toolbar.
			-- The size can be set only before adding any buttons
			-- to the toolbar. If an application does not
			-- explicitly set the button size, the size defaults
			-- to 24 by 22 pixels.
		require
			exists: exists
			positive_width: a_width >=0
			positive_height: a_height >= 0
			no_existing_buttons: button_count = 0
		do
			cwin_send_message (item, Tb_setbuttonsize, 0,
				cwin_make_long (a_width, a_height))
		end

	set_identifier (index, an_id: INTEGER) is
			-- Set the identifier for the button at zero-based
			-- `index' to `an_id'.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < button_count
		do
			cwin_send_message (item, Tb_setcmdid, index, an_id)
		end

	set_tooltip (a_tooltip: WEL_TOOLTIP) is
			-- Associate a tooltip control with the toolbar.
		require
			exists: exists
			a_tooltip_not_void: a_tooltip /= Void
			a_tooltip_exists: a_tooltip.exists
		do
			cwin_send_message (item, Tb_settooltips,
				a_tooltip.to_integer, 0)
		ensure
			tooltip_exists: tooltip_exists
			tooltip_set: tooltip = a_tooltip
		end

feature -- Status report

	tooltip_exists: BOOLEAN is
			-- Is there a tooltip associated to the toolbar?
		require
			exists: exists
		do
			Result := cwin_send_message_result (item,
				Tb_gettooltips, 0, 0) /= 0
		end

	tooltip: WEL_TOOLTIP is
			-- The tooltip associated with the toolbar
		require
			tooltip_exists: tooltip_exists
		do
			Result ?= windows.item (cwel_integer_to_pointer (
				cwin_send_message_result (item, Tb_gettooltips,
				0, 0)))
		end

	button_hidden (command_id: INTEGER): BOOLEAN is
			-- Is the button identified by `command_id' hidden?
		require
			exists: exists
		do
			Result := cwin_send_message_result (item,
				Tb_isbuttonhidden, command_id, 0) /= 0
		end

	button_indeterminate (command_id: INTEGER): BOOLEAN is
			-- Is the button identified by `command_id'
			-- indeterminate?
		require
			exists: exists
		do
			Result := cwin_send_message_result (item,
				Tb_isbuttonindeterminate, command_id, 0) /= 0
		ensure
		end

	button_pressed (command_id: INTEGER): BOOLEAN is
			-- Is the button identified by `command_id' pressed?
		require
			exists: exists
		do
			Result := cwin_send_message_result (item,
				Tb_isbuttonpressed, command_id, 0) /= 0
		end

	button_checked (command_id: INTEGER): BOOLEAN is
			-- Is the button identified by `command_id' checked?
		require
			exists: exists
		do
			Result := cwin_send_message_result (item,
				Tb_isbuttonchecked, command_id, 0) /= 0
		end

	button_enabled (command_id: INTEGER): BOOLEAN is
			-- Is the button identified by `command_id' enabled?
		require
			exists: exists
		do
			Result := cwin_send_message_result (item,
				Tb_isbuttonenabled, command_id, 0) /= 0
		end

	button_rect (index: INTEGER): WEL_RECT is
			-- Rectangle of button at the zero-based `index'.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < button_count
		do
			!! Result.make (0, 0, 0, 0)
			cwin_send_message (item, Tb_getitemrect, index, 
				Result.to_integer)
		ensure
			result_not_void: Result /= Void
		end

	i_th_button (index: INTEGER): WEL_TOOL_BAR_BUTTON is
			-- Button at the zero-based `index'.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < button_count
		do
			!! Result.make
			cwin_send_message (item, Tb_getbutton, index,
				Result.to_integer)
		ensure
			result_not_void: Result /= Void
		end

	button_count: INTEGER is
			-- Number of buttons in toolbar
		require
			exists: exists
		do
			Result := cwin_send_message_result (item,
				Tb_buttoncount, 0, 0)
		ensure
			positive_result: Result >= 0
		end

feature -- Element change

	insert_button (index: INTEGER; button: WEL_TOOL_BAR_BUTTON) is
			-- Insert `button' to the left of the button
			-- at the zero-based `index'.
		require
			exists: exists
			button_not_void: button /= Void
			index_large_enough: index >= 0
			index_small_enough: index < button_count
		do
			cwin_send_message (item, Tb_insertbutton, index,
				button.to_integer)
		ensure
			buttons_increased: button_count = old button_count + 1
		end

	add_buttons (buttons: ARRAY [WEL_TOOL_BAR_BUTTON]) is
			-- Add buttons.
		require
			exists: exists
			buttons_not_void: buttons /= Void
			buttons_not_empty: not buttons.empty
		local
			i, j: INTEGER
		do
			from
				i := 0 -- button_count
				j := buttons.lower
			until
				j > buttons.upper
			loop
				cwin_send_message (item, Tb_insertbutton, i,
					buttons.item (j).to_integer)
				i := i + 1
				j := j + 1
			end
		ensure
			count_increased: button_count = old button_count + buttons.count
		end	

	add_bitmaps (bitmap: WEL_TOOL_BAR_BITMAP; bitmap_count: INTEGER) is
			-- Add bitmaps.
		require
			exists: exists
			bitmap_not_void: bitmap /= Void
			positive_bitmap_count: bitmap_count > 0
		do
			cwin_send_message (item, Tb_addbitmap, bitmap_count,
				bitmap.to_integer)
		end

feature -- Removal

	delete_button (index: INTEGER) is
			-- Delete the button at the zero-based `index'.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < button_count
		do
			cwin_send_message (item, Tb_deletebutton, index, 0)
		ensure
			buttons_decreased: button_count = old button_count - 1
		end

feature {NONE} -- Implementation

	class_name: STRING is
			-- Window class name to create
		once
			!! Result.make (0)
			Result.from_c (cwin_toolbar_class)
		end

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Tbstyle_tooltips
		end

	set_button_struct_size is
			-- Set the size of the TBBUTTON structure in order to
			-- determine which version of the common control
			-- dynamic-link library (DLL) is being used.
		require
			exists: exists
		do
			cwin_send_message (item, Tb_buttonstructsize,
				c_size_of_tbbutton, 0)
		end

feature {NONE} -- Externals

	cwin_toolbar_class: POINTER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TOOLBARCLASSNAME"
		end

	c_size_of_tbbutton: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"sizeof (TBBUTTON)"
		end

feature {NONE} -- Inapplicable

	text: STRING is
		do
			Result := ""
		end

	text_length: INTEGER is
		do
		end

	set_text (s: STRING) is
		do
		end

end -- class WEL_TOOL_BAR

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
