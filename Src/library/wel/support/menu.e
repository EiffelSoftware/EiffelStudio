indexing
	description: "List of item which can be selected by the user."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MENU

inherit
	WEL_RESOURCE

	WEL_MF_CONSTANTS
		export
			{NONE} all
		end

	WEL_TPM_CONSTANTS
		export
			{NONE} all
		end

creation
	make,
	make_by_id,
	make_by_name,
	make_by_pointer,
	make_track

feature {NONE} -- Initialization

	make is
			-- Make an empty menu
		do
			item := cwin_create_menu
		end

	make_track is
			-- Make an empty track popup menu
		do
			item := cwin_create_popup_menu
		end

feature -- Access

	popup_menu (position: INTEGER): WEL_MENU is
			-- Popup menu at the zero-based relative `position'
		require
			exists: exists
			popup_exists: popup_exists (position)
		do
			!! Result.make_by_pointer (cwin_get_sub_menu (item,
				position))
		ensure
			result_not_void: Result /= Void
		end

feature -- Element change

	append_string (a_string: STRING; an_id: INTEGER) is
			-- Append `a_string' with the identifier `an_id' to the
			-- menu.
		require
			exists: exists
			a_string_not_void: a_string /= Void
			item_not_exists: not item_exists (an_id)
		local
			a: ANY
		do
			a := a_string.to_c
			cwin_append_menu (item, Mf_string + Mf_bycommand,
				an_id, $a)
		ensure
			new_count: count = old count + 1
			item_exists: item_exists (an_id)
			string_set: id_string (an_id).is_equal (a_string)
		end

	append_popup (a_menu: WEL_MENU; a_title: STRING) is
			-- Append a popup menu `a_menu' with `a_title' to the
			-- current menu.
		require
			exists: exists
			a_menu_not_void: a_menu /= Void
			a_title_not_void: a_title /= Void
		local
			a: ANY
		do
			a := a_title.to_c
			cwin_append_menu (item, Mf_popup,
				a_menu.to_integer, $a)
		ensure
			new_count: count = old count + 1
		end

	append_separator is
			-- Append a separator to the current menu.
		require
			exists: exists
		do
			cwin_append_menu (item, Mf_separator, 0,
				default_pointer)
		ensure
			new_count: count = old count + 1
		end

	insert_string (a_string: STRING; a_position, an_id: INTEGER) is
			-- Insert `a_string' at zero-based `position' with
			-- `an_id'.
		require
			exists: exists
			a_position_large_enough: a_position >= 0
			a_position_small_enough: a_position <= count
			a_string_not_void: a_string /= Void
			item_not_exists: not item_exists (an_id)
		local
			a: ANY
		do
			a := a_string.to_c
			cwin_insert_menu (item, a_position,
				Mf_string + Mf_bycommand, an_id, $a)
		ensure
			new_count: count = old count + 1
			string_set: id_string (an_id).is_equal (a_string)
		end

	insert_popup (a_menu: WEL_MENU; a_position: INTEGER; a_title: STRING) is
			-- Insert a popup menu `a_menu' at zero-based `position'
			-- with `a_title'.
		require
			exists: exists
			a_menu_not_void: a_menu /= Void
			a_title_not_void: a_title /= Void
			a_position_large_enough: a_position >= 0
			a_position_small_enough: a_position <= count
		local
			a: ANY
		do
			a := a_title.to_c
			cwin_insert_menu (item, a_position,
				Mf_popup + Mf_bycommand, a_menu.to_integer, $a)
		ensure
			new_count: count = old count + 1
			popup_menu_set: popup_menu (a_position).item = a_menu.item
		end

	insert_separator (a_position: INTEGER) is
			-- Insert a separator at zero-based `position'.
		require
			exists: exists
			a_position_large_enough: a_position >= 0
			a_position_small_enough: a_position <= count
		do
			cwin_insert_menu (item, a_position,
				Mf_separator, 0, default_pointer)
		ensure
			new_count: count = old count + 1
		end

	modify_string (a_string: STRING; an_id: INTEGER) is
			-- Modify the menu title identified by `an_id' to
			-- `a_string'.
		require
			exists: exists
			a_string_not_void: a_string /= Void
			item_exists: item_exists (an_id)
		local
			a: ANY
		do
			a := a_string.to_c
			cwin_modify_menu (item, an_id,
				Mf_string + Mf_bycommand, an_id, $a)
		ensure
			string_set: id_string (an_id).is_equal (a_string)
		end

feature -- Removal

	delete_item (an_id: INTEGER) is
			-- Delete `an_id' from the menu.
		require
			exists: exists
			item_exists: item_exists (an_id)
		do
			cwin_delete_menu (item, an_id, Mf_bycommand)
		ensure
			new_count: count = old count - 1
			item_not_exists: not item_exists (an_id)
		end

feature -- Basic operations

	hilite_menu_item (window: WEL_WINDOW; an_id: INTEGER) is
			-- Hilite the item identified by `an_id' in the
			-- `window''s menu.
		require
			exists: exists
			window_not_void: window /= Void
			window_exists: window.exists
		do
			cwin_hilite_menu_item (window.item, item,
				an_id, Mf_bycommand + Mf_hilite)
		end

	unhilite_menu_item (window: WEL_WINDOW; an_id: INTEGER) is
			-- unhilite the item identified by `an_id' in the
			-- `window''s menu.
		require
			exists: exists
			window_not_void: window /= Void
			window_exists: window.exists
		do
			cwin_hilite_menu_item (window.item, item,
				an_id, Mf_bycommand + Mf_unhilite)
		end

	show_track (x, y: INTEGER; window: WEL_WINDOW) is
			-- Show a track popup menu at the `x' and `y' absolute
			-- position. `window' will receive the selection in
			-- `on_command_menu'
		require
			exists: exists
			not_empty: count > 0
			window_not_void: window /= Void
			window_exists: window.exists
		do
			cwin_track_popup_menu (item, default_track_option,
				x, y, 0, window.item, default_pointer)
		end

	show_track_with_option (x, y: INTEGER; window: WEL_WINDOW;
				option: INTEGER; rect: WEL_RECT) is
			-- Show a track popup menu with `option' at
			-- the `x' and `y' absolute position.
			-- `window' will receive the selection in
			-- `on_command_menu'.
			-- `rect' specifies the portion of the screen
			-- in which the user can select without
			-- dismissing the popup menu. If this parameter
			-- is Void the popup menu is dismissed if the
			-- user clicks outside the popup menu
		require
			exists: exists
			not_empty: count > 0
			window_not_void: window /= Void
			window_exists: window.exists
		do
			if rect /= Void then
				cwin_track_popup_menu (item, option, x, y,
					0, window.item, rect.item)
			else
				cwin_track_popup_menu (item, option, x, y,
					0, window.item, default_pointer)
			end
		end

feature -- Measurement

	count: INTEGER is
			-- Number of items
		require
			exists: exists
		do
			Result := cwin_get_menu_item_count (item)
		ensure
			positive_result: Result >= 0
		end

feature -- Status setting

	check_item (item_id: INTEGER) is
			-- Put a check mark for `item_id'
		require
			exists: exists
			item_exists: item_exists (item_id)
		do
			cwin_check_menu_item (item, item_id,
				Mf_checked + Mf_bycommand)
		ensure
			item_checked: item_checked (item_id)
		end

	uncheck_item (item_id: INTEGER) is
			-- Remove the check mark for `item_id'
		require
			exists: exists
			item_exists: item_exists (item_id)
		do
			cwin_check_menu_item (item, item_id,
				Mf_unchecked + Mf_bycommand)
		ensure
			item_unchecked: not item_checked (item_id)
		end

	enable_item (item_id: INTEGER) is
			-- Enable `item_id'
		require
			exists: exists
			item_exists: item_exists (item_id)
		do
			cwin_enable_menu_item (item, item_id,
				Mf_enabled + Mf_bycommand)
		ensure
			item_enabled: item_enabled (item_id)
		end

	disable_item (item_id: INTEGER) is
			-- Disable `item_id'
		require
			exists: exists
			item_exists: item_exists (item_id)
		do
			cwin_enable_menu_item (item, item_id,
				Mf_disabled + Mf_grayed + Mf_bycommand)
		ensure
			item_disabled: not item_enabled (item_id)
		end

feature -- Status report

	item_exists (an_id: INTEGER): BOOLEAN is
			-- Does `an_id' exists in the menu?
		require
			exists: exists
		do
			Result := cwin_get_menu_state (item, an_id,
				Mf_bycommand) /= 4_294_967_295
			--| 0xFFFFFFFF
		end

	item_checked (item_id: INTEGER): BOOLEAN is
			-- Is `item_id' checked?
		require
			exists: exists
			item_exists: item_exists (item_id)
		do
			Result := cwin_get_menu_state (item, item_id,
				Mf_checked + Mf_bycommand) = Mf_checked
		end

	item_enabled (item_id: INTEGER): BOOLEAN is
			-- Is `item_id' enabled?
		require
			exists: exists
			item_exists: item_exists (item_id)
		do
			Result := cwin_get_menu_state (item, item_id,
				Mf_enabled + Mf_bycommand) = Mf_enabled
		end

	id_string (an_id: INTEGER): STRING is
			-- String associated with `an_id'
		require
			exists: exists
			item_exists: item_exists (an_id)
		local
			a: ANY
		do
			!! Result.make (Max_name_length + 1)
			Result.fill_blank
			a := Result.to_c
			Result.head (cwin_get_menu_string (item, an_id,
				$a, Max_name_length + 1, Mf_bycommand))
		ensure
			result_not_void: Result /= Void
		end

	popup_exists (position: INTEGER): BOOLEAN is
			-- Does a popup menu exists at
			-- the zero-based position?
		require
			exists: exists
		do
			Result := cwin_get_sub_menu (item,
				position) /= default_pointer
		end

feature {NONE} -- Implementation

	default_track_option: INTEGER is
			-- Default option used for `show_track'
		once
			Result := Tpm_leftbutton
		end

	load_item (hinstance, id: POINTER) is
			-- Load menu.
		do
			item := cwin_load_menu (hinstance, id)
		end

	destroy_item is
			-- Destroy menu.
		do
			cwin_destroy_menu (item)
			item := default_pointer
		end

	Max_name_length: INTEGER is 255
			-- Maximum menu name length

feature {NONE} -- Externals

	cwin_create_menu: POINTER is
			-- SDK CreateMenu
		external
			"C [macro <wel.h>]: EIF_POINTER"
		alias
			"CreateMenu ()"
		end

	cwin_create_popup_menu: POINTER is
			-- SDK CreatePopupMenu
		external
			"C [macro <wel.h>]: EIF_POINTER"
		alias
			"CreatePopupMenu ()"
		end

	cwin_append_menu (hmenu: POINTER; flags, new_item: INTEGER;
			a_item: POINTER) is
			-- SDK AppendMenu
		external
			"C [macro <wel.h>] (HMENU, UINT, UINT, LPCSTR)"
		alias
			"AppendMenu"
		end

	cwin_insert_menu (hmenu: POINTER; position, flags, new_item: INTEGER;
			a_item: POINTER) is
			-- SDK InsertMenu
		external
			"C [macro <wel.h>] (HMENU, UINT, UINT, UINT, LPCSTR)"
		alias
			"InsertMenu"
		end

	cwin_get_menu_item_count (hmenu: POINTER): INTEGER is
			-- SDK GetMenuItemCount
		external
			"C [macro <wel.h>] (HMENU): EIF_INTEGER"
		alias
			"GetMenuItemCount"
		end

	cwin_get_sub_menu (hmenu: POINTER; pos: INTEGER): POINTER is
			-- SDK GetSubMenu
		external
			"C [macro <wel.h>] (HMENU, int): EIF_POINTER"
		alias
			"GetSubMenu"
		end

	cwin_check_menu_item (hmenu: POINTER; id, flags: INTEGER) is
			-- SDK CheckMenuItem
		external
			"C [macro <wel.h>] (HMENU, UINT, UINT)"
		alias
			"CheckMenuItem"
		end

	cwin_delete_menu (hmenu: POINTER; id, flags: INTEGER) is
			-- SDK DeleteMenu
		external
			"C [macro <wel.h>] (HMENU, UINT, UINT)"
		alias
			"DeleteMenu"
		end

	cwin_enable_menu_item (hmenu: POINTER; id, flags: INTEGER) is
			-- SDK EnableMenuItem
		external
			"C [macro <wel.h>] (HMENU, UINT, UINT)"
		alias
			"EnableMenuItem"
		end

	cwin_get_menu_state (hmenu: POINTER; id, flags: INTEGER): INTEGER is
			-- SDK GetMenuState
		external
			"C [macro <wel.h>] (HMENU, UINT, UINT): EIF_INTEGER"
		alias
			"GetMenuState"
		end

	cwin_get_menu_string (hmenu: POINTER; id: INTEGER; buffer: POINTER;
				max: INTEGER; flags: INTEGER): INTEGER is
			-- SDK GetMenuString
		external
			"C [macro <wel.h>] (HMENU, UINT, LPSTR, int, %
				%UINT): EIF_INTEGER"
		alias
			"GetMenuString"
		end

	cwin_load_menu (hinstance: POINTER; id: POINTER): POINTER is
			-- SDK LoadMenu
		external
			"C [macro <wel.h>] (HINSTANCE, LPCSTR): EIF_POINTER"
		alias
			"LoadMenu"
		end

	cwin_destroy_menu (hmenu: POINTER) is
			-- SDK DestroyMenu
		external
			"C [macro <wel.h>] (HMENU)"
		alias
			"DestroyMenu"
		end

	cwin_track_popup_menu (hmenu: POINTER; flags, x, y,
			reserved: INTEGER; hwnd, rect: POINTER) is
			-- SDK TrackPopupMenu
		external
			"C [macro <wel.h>] (HMENU, UINT, int, int, int, %
				%HWND, RECT *)"
		alias
			"TrackPopupMenu"
		end

	cwin_modify_menu (hmenu: POINTER; id, flags, new_id: INTEGER;
			new_name: POINTER) is
			-- SDK ModifyMenu
		external
			"C [macro <wel.h>] (HMENU, UINT, UINT, UINT, LPCSTR)"
		alias
			"ModifyMenu"
		end

	cwin_hilite_menu_item (hwnd: POINTER; hmenu: POINTER;
			id, flags: INTEGER) is
			-- SDK HiliteMenuItem
		external
			"C [macro <wel.h>] (HWND, HMENU, UINT, UINT)"
		alias
			"HiliteMenuItem"
		end

end -- class WEL_MENU

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
