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
			process_notification_info,
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

	WEL_TBN_CONSTANTS
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

	make (a_parent: WEL_WINDOW; an_id: INTEGER) is
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
			-- An application sends the TB_AUTOSIZE message after
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
			no_bitmap_present: not has_bitmap
		do
			cwin_send_message (item, Tb_setbitmapsize, 0, cwin_make_long (a_width, a_height))
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

	enable_hot_item (command_id: INTEGER) is
			-- Set hot item for button identified by `command_id'.
		require
			exists: exists
		do
			cwin_send_message (item, Tb_sethotitem, command_id, 0)
		end

	disable_hot_item is
			-- Unset the hot item.
		require
			exists: exists
		do
			cwin_send_message (item, Tb_sethotitem, -1, 0)
		end

feature -- Status report

	has_bitmap: BOOLEAN
			-- Does the toolbar contains one bitmap or more?

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
			Result ?= window_of_item (cwel_integer_to_pointer (
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
			create Result.make (0, 0, 0, 0)
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
			create Result.make
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

	last_bitmap_index: INTEGER
			-- Last bitmap index added by `add_bitmaps'.

	last_string_index: INTEGER
			-- Last string index added by `add_strings'.

feature -- Element change

	insert_button (index: INTEGER; button: WEL_TOOL_BAR_BUTTON) is
			-- Insert `button' to the left of the button
			-- at the zero-based `index'.
		require
			exists: exists
			button_not_void: button /= Void
			index_large_enough: index >= 0
			index_small_enough: index <= button_count
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
			buttons_not_empty: not buttons.is_empty
			no_void_button: not buttons.has (Void)
		local
			i: INTEGER
		do
			from
				i := buttons.lower
			until
				i > buttons.upper
			loop
				insert_button (button_count, buttons.item (i))
				i := i + 1
			end
		ensure
			count_increased: button_count = old button_count + buttons.count
		end	

	add_bitmaps (tb_bitmap: WEL_TOOL_BAR_BITMAP; bitmap_count: INTEGER) is
			-- Add bitmaps.
		require
			exists: exists
			bitmap_not_void: tb_bitmap /= Void
			positive_bitmap_count: bitmap_count > 0
		do
			last_bitmap_index := cwin_send_message_result (item, Tb_addbitmap, bitmap_count, tb_bitmap.to_integer)
			has_bitmap := True
		end

	add_strings (strings: ARRAY [STRING]) is
			-- Add strings to the toolbar.
		require
			exists: exists
			string_not_void: strings /= Void
			strings_not_empty: not strings.is_empty
		local
			i: INTEGER
			s: STRING
			wel_s: WEL_STRING
		do
			from
				i := strings.lower
				s := create {STRING}.make (0)
			until
				i > strings.upper
			loop
				s.append_string (strings.item (i))
				s.append_character ('%/0/')
				i := i + 1
			end
			s.append_character ('%/0/')
			create wel_s.make (s)
			last_string_index := cwin_send_message_result (item, Tb_addstring, 0, wel_s.to_integer)
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

feature -- Notifications

	on_tbn_getbuttoninfo (info: WEL_NM_TOOL_BAR) is
			-- Retrieves toolbar customization.
		require
			exists: exists
		do
		end

	on_tbn_begindrag (info: WEL_NM_TOOL_BAR) is
			-- The user has begun dragging a button in the toolbar.
		require
			exists: exists
		do
		end

	on_tbn_enddrag (info: WEL_NM_TOOL_BAR) is
			-- The user has stopped dragging a button in the toolbar.
		require
			exists: exists
		do
		end

	on_tbn_beginadjust is
			-- The user has begun customizing the toolbar.
		require
			exists: exists
		do
		end

	on_tbn_endadjust is
			-- The user has stopped customizing the toolbar.
		require
			exists: exists
		do
		end

	on_tbn_reset is
			-- The user has reset the content of the customise
			-- toolbar dialog box.
		require
			exists: exists
		do
		end

	on_tbn_queryinsert (info: WEL_NM_TOOL_BAR) is
			-- A button may be inserted to the left of the
			-- specified button while the user is customizing
			-- the toolbar.
		require
			exists: exists
		do
		end

	on_tbn_querydelete (info: WEL_NM_TOOL_BAR) is
			-- A button may be deleted from the toolbar while
			-- the user is customizing the toolbar.
		require
			exists: exists
		do
		end

	on_tbn_toolbarchange is
			-- The user has customized the toolbar.
		require
			exists: exists
		do
		end

	on_tbn_custhelp is
			-- The user has chosen the Help button in the 
			-- customize toolbar dialog box.
		require
			exists: exists
		do
		end

	on_tbn_dropdown (info: WEL_NM_TOOL_BAR) is
			-- The user clicks a button that uses the 
			-- Tbstyle_dropdown style.
		require
			exists: exists
		do
		end

feature {WEL_COMPOSITE_WINDOW} -- Implementation

	process_notification_info (notification_info: WEL_NMHDR) is
			-- Process a `notification_code' sent by Windows
			-- through the Wm_notify message
		local
			code: INTEGER
			nm_info: WEL_NM_TOOL_BAR 
		do
			code := notification_info.code
			if code = Tbn_getbuttoninfo then
				create nm_info.make_by_nmhdr (notification_info)
				on_tbn_getbuttoninfo (nm_info)
			elseif code = Tbn_begindrag then
				create nm_info.make_by_nmhdr (notification_info)
				on_tbn_begindrag (nm_info)
			elseif code = Tbn_enddrag then
				create nm_info.make_by_nmhdr (notification_info)
				on_tbn_enddrag (nm_info)
			elseif code = Tbn_beginadjust then
				on_tbn_beginadjust
			elseif code = Tbn_endadjust then
				on_tbn_endadjust
			elseif code = Tbn_reset then
				on_tbn_reset
			elseif code = Tbn_queryinsert then
				create nm_info.make_by_nmhdr (notification_info)
				on_tbn_queryinsert (nm_info)
			elseif code = Tbn_querydelete then
				create nm_info.make_by_nmhdr (notification_info)
				on_tbn_querydelete (nm_info)
			elseif code = Tbn_toolbarchange then
				on_tbn_toolbarchange
			elseif code = Tbn_custhelp then
				on_tbn_custhelp
			elseif code = Tbn_dropdown then
				create nm_info.make_by_nmhdr (notification_info)
				on_tbn_dropdown (nm_info)
			end
		end

feature {NONE} -- Implementation

	class_name: STRING is
			-- Window class name to create
		once
			create Result.make (0)
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
			"C [macro <cctrl.h>] : EIF_POINTER"
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
			Result := create {STRING}.make (0)
		end

	text_length: INTEGER is
		do
		end

	set_text (s: STRING) is
		do
		end

end -- class WEL_TOOL_BAR


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

