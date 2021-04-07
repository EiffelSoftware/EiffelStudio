note
	description: "List of items which can be selected by the user."
	legal: "See notice at end of class."
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

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end

create
	make,
	make_by_id,
	make_by_name,
	make_by_pointer,
	make_track

feature {NONE} -- Initialization

	make
			-- Make an empty menu
		do
			item := cwin_create_menu
		end

	make_track
			-- Make an empty track popup menu
		do
			item := cwin_create_popup_menu
		end

feature -- Access

	popup_menu (position: INTEGER): WEL_MENU
			-- Popup menu at the zero-based relative `position'
		require
			exists: exists
			position_large_enough: position >= 0
			position_small_enough: position < count
			popup_exists: popup_exists (position)
		do
			create Result.make_by_pointer (cwin_get_sub_menu (item, position))
		ensure
			result_not_void: Result /= Void
		end

feature -- Element change

	append_string (a_string: READABLE_STRING_GENERAL; an_id: INTEGER)
			-- Append `a_string' with the identifier `an_id' to the
			-- menu.
		require
			exists: exists
			a_string_not_void: a_string /= Void
			positive_id: an_id > 0
			item_not_exists: not item_exists (an_id)
		local
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make(a_string)
			cwin_append_menu (item, Mf_string + Mf_bycommand,
				cwel_integer_to_pointer (an_id), a_wel_string.item)
		ensure
			new_count: count = old count + 1
			item_exists: item_exists (an_id)
			string_set: id_string (an_id).same_string_general (a_string)
		end

	append_popup (a_menu: WEL_MENU; a_title: READABLE_STRING_GENERAL)
			-- Append a popup menu `a_menu' with `a_title' to the
			-- current menu.
		require
			exists: exists
			a_menu_not_void: a_menu /= Void
			a_menu_exists: a_menu.exists
			a_title_not_void: a_title /= Void
		local
			a_wel_string: WEL_STRING
		do
			a_menu.set_shared
				-- `a_menu' must be shared since Windows will
				-- destroy it automatically with `Current'.
			create a_wel_string.make (a_title)
			cwin_append_menu (item, Mf_popup, a_menu.item, a_wel_string.item)
		ensure
			new_count: count = old count + 1
		end

	append_separator
			-- Append a separator to the current menu.
		require
			exists: exists
		do
			cwin_append_menu (item, Mf_separator, default_pointer, default_pointer)
		ensure
			new_count: count = old count + 1
		end

	append_string_with_break (a_string: READABLE_STRING_GENERAL; an_id: INTEGER; has_separator: BOOLEAN)
			-- Append an item with a break to the menu.
			-- All the following items will be set in a new column.
			-- If `has_separator' is True, then a vertical separator
			-- appears between the two columns.
		require
			exists: exists
			a_string_not_void: a_string /= Void
			positive_id: an_id > 0
			item_not_exists: not item_exists (an_id)
		local
			a_wel_string: WEL_STRING
			l_menu_id: POINTER
		do
			create a_wel_string.make(a_string)
			l_menu_id := cwel_integer_to_pointer (an_id)
			if has_separator then
				cwin_append_menu (item, Mf_string + Mf_bycommand + Mf_menubarbreak, l_menu_id, a_wel_string.item)
			else
				cwin_append_menu (item, Mf_string + Mf_bycommand + Mf_menubreak, l_menu_id, a_wel_string.item)
			end
		ensure
			new_count: count = old count + 1
			item_exists: item_exists (an_id)
			string_set: id_string (an_id).same_string_general (a_string)
		end

	append_bitmap (bitmap: WEL_BITMAP; an_id: INTEGER)
			-- Append `bitmap' with the identifier `an_id' to the
			-- menu.
		require
			exists: exists
			bitmap_not_void: bitmap /= Void
			bitmap_exists: bitmap.exists
			positive_id: an_id > 0
			item_not_exists: not item_exists (an_id)
		do
			cwin_append_menu (item, Mf_bitmap + Mf_bycommand,
				cwel_integer_to_pointer (an_id), bitmap.item)
		ensure
			new_count: count = old count + 1
			item_exists: item_exists (an_id)
		end

	insert_string (a_string: READABLE_STRING_GENERAL; a_position, an_id: INTEGER)
			-- Insert `a_string' at zero-based `a_position' with
			-- `an_id'.
		require
			exists: exists
			a_position_large_enough: a_position >= 0
			a_position_small_enough: a_position <= count
			a_string_not_void: a_string /= Void
			positive_id: an_id > 0
			item_not_exists: not item_exists (an_id)
		local
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (a_string)
			cwin_insert_menu (item, a_position, Mf_string + Mf_byposition,
				 cwel_integer_to_pointer (an_id), a_wel_string.item)
		ensure
			new_count: count = old count + 1
			string_set: id_string (an_id).same_string_general (a_string)
		end

	insert_popup (a_menu: WEL_MENU; a_position: INTEGER; a_title: READABLE_STRING_GENERAL)
			-- Insert a popup menu `a_menu' at zero-based `a_position'
			-- with `a_title'.
		require
			exists: exists
			a_menu_not_void: a_menu /= Void
			a_menu_exists: a_menu.exists
			a_title_not_void: a_title /= Void
			a_position_large_enough: a_position >= 0
			a_position_small_enough: a_position <= count
		local
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (a_title)
			cwin_insert_menu (item, a_position, Mf_popup + Mf_byposition,
				a_menu.item, a_wel_string.item)
		ensure
			new_count: count = old count + 1
			popup_menu_set: popup_menu (a_position).item = a_menu.item
		end

	insert_separator (a_position: INTEGER)
			-- Insert a separator at zero-based `a_position'.
		require
			exists: exists
			a_position_large_enough: a_position >= 0
			a_position_small_enough: a_position <= count
		do
			cwin_insert_menu (item, a_position, Mf_separator + Mf_byposition,
				default_pointer, default_pointer)
		ensure
			new_count: count = old count + 1
		end

	insert_bitmap (bitmap: WEL_BITMAP; a_position, an_id: INTEGER)
			-- Insert `bitmap' at zero-based `a_position' with
			-- `an_id'.
		require
			exists: exists
			a_position_large_enough: a_position >= 0
			a_position_small_enough: a_position <= count
			bitmap_not_void: bitmap /= Void
			bitmap_exists: bitmap.exists
			positive_id: an_id > 0
			item_not_exists: not item_exists (an_id)
		do
			cwin_insert_menu (item, a_position, Mf_bitmap + Mf_byposition,
				 cwel_integer_to_pointer (an_id), bitmap.item)
		ensure
			new_count: count = old count + 1
		end

	modify_string (a_string: READABLE_STRING_GENERAL; an_id: INTEGER)
			-- Modify the menu title identified by `an_id' to
			-- `a_string'.
		require
			exists: exists
			a_string_not_void: a_string /= Void
			positive_id: an_id > 0
			item_exists: item_exists (an_id)
		local
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (a_string)
			cwin_modify_menu (item, an_id, Mf_string + Mf_bycommand,
				cwel_integer_to_pointer (an_id), a_wel_string.item)
		ensure
			string_set: id_string (an_id).same_string_general (a_string)
		end

feature -- Removal

	delete_item (an_id: INTEGER)
			-- Delete `an_id' from the menu.
		require
			exists: exists
			positive_id: an_id > 0
			item_exists: item_exists (an_id)
		do
			cwin_delete_menu (item, an_id, Mf_bycommand)
		ensure
			new_count: count = old count - 1
			item_not_exists: not item_exists (an_id)
		end

	delete_position (position: INTEGER)
			-- Delete the item at zero-based `position'.
		require
			exists: exists
			position_large_enough: position >= 0
			position_small_enough: position < count
		do
			cwin_delete_menu (item, position, Mf_byposition)
		ensure
			new_count: count = old count - 1
		end

	remove_position (position: INTEGER)
			-- Remove the item at zero-based `position'.
		require
			exists: exists
			position_large_enough: position >= 0
			position_small_enough: position < count
		do
			cwin_remove_menu (item, position, Mf_byposition)
		ensure
			new_count: count = old count - 1
		end

feature -- Basic operations

	redraw (window: WEL_COMPOSITE_WINDOW)
			-- Redraws the menu bar of the specified window.
			-- If the menu bar changes after the system has created the window,
			-- this function must be called to draw the changed menu bar.
		do
			cwin_draw_menu_bar (window.item)
		end

	hilite_menu_item (window: WEL_COMPOSITE_WINDOW; an_id: INTEGER)
			-- Hilite the item identified by `an_id' in the
			-- `window''s menu.
		require
			exists: exists
			window_not_void: window /= Void
			window_exists: window.exists
			positive_id: an_id > 0
			item_exists: item_exists (an_id)
		do
			cwin_hilite_menu_item (window.item, item, an_id, Mf_bycommand + Mf_hilite)
		end

	unhilite_menu_item (window: WEL_COMPOSITE_WINDOW; an_id: INTEGER)
			-- unhilite the item identified by `an_id' in the
			-- `window''s menu.
		require
			exists: exists
			window_not_void: window /= Void
			window_exists: window.exists
			positive_id: an_id > 0
			item_exists: item_exists (an_id)
		do
			cwin_hilite_menu_item (window.item, item, an_id, Mf_bycommand + Mf_unhilite)
		end

	show_track (x, y: INTEGER; window: WEL_COMPOSITE_WINDOW)
			-- Show a track popup menu at the `x' and `y' absolute
			-- position. `window' will receive the selection in
			-- `on_menu_command'.
		require
			exists: exists
			not_empty: count > 0
			window_not_void: window /= Void
			window_exists: window.exists
		do
			show_track_with_option (x, y, window, default_track_option, Void)
		end

	show_track_with_option (x, y: INTEGER; window: WEL_COMPOSITE_WINDOW; option: INTEGER; rect: detachable WEL_RECT)
			-- Show a track popup menu with `option' at
			-- the `x' and `y' absolute position.
			-- `window' will receive the selection in
			-- `on_menu_command'.
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
		local
			l_null: POINTER
			l_id: INTEGER
		do
				-- From CodeProject:
				--
				-- Many people have had troubles using TrackPopupMenu. They have reported
				-- that the popup menu will often not disappear once the mouse is clicked
				-- outside of the menu, even though they have set the last parameter of
				-- TrackPopupMenu() as NULL. This is a Microsoft "feature", and is by design.
				-- The mind boggles, doesn't it?

				-- Anyway - to workaround this "feature", one must set the current window
				-- as the foreground window before calling TrackPopupMenu. This then causes
				-- a second problem - namely that the next time the menu is displayed it
				-- displays then immediately disappears. To fix this problem, you must
				-- make the currernt application active after the menu disappears.
				-- This can be done by sending a benign message such as WM_NULL to the current window.
			{WEL_API}.set_foreground_window (window.item).do_nothing
			if rect /= Void then
				l_id := {WEL_API}.track_popup_menu (item, option | tpm_returncmd, x, y, 0, window.item, rect.item)
			else
				l_id := {WEL_API}.track_popup_menu (item, option | tpm_returncmd, x, y, 0, window.item, l_null)
			end
			{WEL_API}.post_message (window.item, {WEL_WM_CONSTANTS}.wm_null, l_null, l_null)

			if l_id /= 0 then
					-- The usage of the `tpm_returncmd' flag let us get the ID of the menu
					-- and we can directly call the associated handler of `window' showing the menu.
				window.on_menu_command (l_id)
			end
		end

feature -- Measurement

	count: INTEGER
			-- Number of items
		require
			exists: exists
		do
			Result := cwin_get_menu_item_count (item)
		ensure
			positive_result: Result >= 0
		end

feature -- Status setting

	check_item (an_id: INTEGER)
			-- Put a check mark for the item identified by `an_id'.
		require
			exists: exists
			positive_id: an_id > 0
			item_exists: item_exists (an_id)
		do
			cwin_check_menu_item (item, an_id, Mf_checked | Mf_bycommand)
		ensure
			item_checked: item_checked (an_id)
		end

	uncheck_item (an_id: INTEGER)
			-- Remove the check mark for the item identified
			-- by `an_id'.
		require
			exists: exists
			positive_id: an_id > 0
			item_exists: item_exists (an_id)
		do
			cwin_check_menu_item (item, an_id, Mf_unchecked | Mf_bycommand)
		ensure
			item_unchecked: not item_checked (an_id)
		end

	enable_item (an_id: INTEGER)
			-- Enable the item idenfied by `an_id'.
		require
			exists: exists
			positive_id: an_id > 0
			item_exists: item_exists (an_id)
		do
			cwin_enable_menu_item (item, an_id, Mf_enabled | Mf_bycommand)
		ensure
			item_enabled: item_enabled (an_id)
		end

	enable_position (position: INTEGER)
			-- Enable the item at zero-based `position'.
		require
			exists: exists
			position_large_enough: position >= 0
			position_small_enough: position < count
		do
			cwin_enable_menu_item (item, position, Mf_enabled | Mf_byposition)
		ensure
			position_enabled: position_enabled (position)
		end

	disable_item (an_id: INTEGER)
			-- Disable the item identified by `an_id'.
		require
			exists: exists
			positive_id: an_id > 0
			item_exists: item_exists (an_id)
		do
			cwin_enable_menu_item (item, an_id, Mf_grayed | Mf_bycommand)
		ensure
			item_disabled: not item_enabled (an_id)
		end

	disable_position (position: INTEGER)
			-- Disable the item at zero-based `position'.
		require
			exists: exists
			position_large_enough: position >= 0
			position_small_enough: position < count
		do
			cwin_enable_menu_item (item, position, Mf_grayed | Mf_byposition)
		ensure
			position_disabled: not position_enabled (position)
		end

feature -- Status report

	item_exists (an_id: INTEGER): BOOLEAN
			-- Does `an_id' exist in the menu?
		require
			exists: exists
			positive_id: an_id > 0
		do
			Result := cwin_get_menu_state (item, an_id, Mf_bycommand) /= cwel_menu_item_not_found
		end

	item_checked (an_id: INTEGER): BOOLEAN
			-- Is the item idenfied by `an_id' checked?
		require
			exists: exists
			positive_id: an_id > 0
			item_exists: item_exists (an_id)
		do
			Result := flag_set (cwin_get_menu_state (item, an_id, Mf_bycommand), Mf_checked)
		end

	item_enabled (an_id: INTEGER): BOOLEAN
			-- Is the item idenfied by `an_id' enabled?
		require
			exists: exists
			positive_id: an_id > 0
			item_exists: item_exists (an_id)
		local
			flags:INTEGER
		do
			flags := cwin_get_menu_state (item, an_id, Mf_bycommand)
			Result := not flag_set (flags, Mf_grayed) and not flag_set (flags, Mf_disabled)
		end

	position_enabled (position: INTEGER): BOOLEAN
			-- Is the item at zero-based `position' enabled?
		require
			exists: exists
			position_large_enough: position >= 0
			position_small_enough: position < count
		local
			flags:INTEGER
		do
			flags := cwin_get_menu_state (item, position, Mf_byposition)
			Result := not flag_set (flags, Mf_grayed) and not flag_set(flags, Mf_disabled)
		end

	id_string (an_id: INTEGER): STRING_32
			-- String associated with `an_id'
		require
			exists: exists
			positive_id: an_id > 0
			item_exists: item_exists (an_id)
		local
			a_wel_string: WEL_STRING
			nb: INTEGER
		do
			create a_wel_string.make_empty (Max_name_length + 1)
			nb := cwin_get_menu_string (item, an_id, a_wel_string.item, Max_name_length + 1, Mf_bycommand)
			Result := a_wel_string.substring (1, nb)
		ensure
			result_not_void: Result /= Void
		end

	popup_exists (position: INTEGER): BOOLEAN
			-- Does a popup menu exists at the zero-based position?
		require
			exists: exists
			positive_position: position >= 0
		local
			a_default_pointer: POINTER
		do
			Result := cwin_get_sub_menu (item, position) /= a_default_pointer
		end

feature -- Conversion

	position_to_item_id (position: INTEGER): INTEGER
			-- Retrieve the menu item identifier of a menu item at
			-- the zero-based `position'.
			-- Return 0 if the item at the zero-based
			-- `position' is a separator or a pop-up menu.
		require
			exists: exists
			position_large_enough: position >= 0
			position_small_enough: position < count
		do
			Result := cwin_get_menu_item_id (item, position)
		end

feature {NONE} -- Implementation

	default_track_option: INTEGER
			-- Default option used for `show_track'
		once
			Result := Tpm_rightbutton
		end

	load_item (hinstance, id: POINTER)
			-- Load menu.
		do
			item := cwin_load_menu (hinstance, id)
		end

	destroy_item
			-- Destroy menu.
		local
			a_default_pointer: POINTER
		do
			cwin_destroy_menu (item)
			item := a_default_pointer
		end

	Max_name_length: INTEGER = 255
			-- Maximum menu name length

feature {NONE} -- Externals

	cwin_draw_menu_bar (hwnd: POINTER)
			-- SDK drawMenuBar
		external
			"C [macro <wel.h>] (HWND)"
		alias
			"DrawMenuBar"
		end

	cwin_create_menu: POINTER
			-- SDK CreateMenu
		external
			"C [macro <wel.h>]: EIF_POINTER"
		alias
			"CreateMenu()"
		end

	cwin_create_popup_menu: POINTER
			-- SDK CreatePopupMenu
		external
			"C [macro <wel.h>]: EIF_POINTER"
		alias
			"CreatePopupMenu()"
		end

	cwin_append_menu (hmenu: POINTER; flags: INTEGER; new_item, a_item: POINTER)
			-- SDK AppendMenu
		external
			"C [macro <wel.h>] (HMENU, UINT, UINT_PTR, LPCTSTR)"
		alias
			"AppendMenu"
		end

	cwin_insert_menu (hmenu: POINTER; position, flags: INTEGER; new_item, a_item: POINTER)
			-- SDK InsertMenu
		external
			"C [macro <wel.h>] (HMENU, UINT, UINT, UINT_PTR, LPCTSTR)"
		alias
			"InsertMenu"
		end

	cwin_get_menu_item_count (hmenu: POINTER): INTEGER
			-- SDK GetMenuItemCount
		external
			"C [macro <wel.h>] (HMENU): EIF_INTEGER"
		alias
			"GetMenuItemCount"
		end

	cwin_get_sub_menu (hmenu: POINTER; pos: INTEGER): POINTER
			-- SDK GetSubMenu
		external
			"C [macro <wel.h>] (HMENU, int): EIF_POINTER"
		alias
			"GetSubMenu"
		end

	cwin_check_menu_item (hmenu: POINTER; id, flags: INTEGER)
			-- SDK CheckMenuItem
		external
			"C [macro <wel.h>] (HMENU, UINT, UINT)"
		alias
			"CheckMenuItem"
		end

	cwin_delete_menu (hmenu: POINTER; id, flags: INTEGER)
			-- SDK DeleteMenu
		external
			"C [macro <wel.h>] (HMENU, UINT, UINT)"
		alias
			"DeleteMenu"
		end

	cwin_remove_menu (hmenu: POINTER; id, flags: INTEGER)
			-- SDK RemoveMenu
		external
			"C [macro <wel.h>] (HMENU, UINT, UINT)"
		alias
			"RemoveMenu"
		end

	cwin_enable_menu_item (hmenu: POINTER; id, flags: INTEGER)
			-- SDK EnableMenuItem
		external
			"C [macro <wel.h>] (HMENU, UINT, UINT)"
		alias
			"EnableMenuItem"
		end

	cwin_get_menu_state (hmenu: POINTER; id, flags: INTEGER): INTEGER
			-- SDK GetMenuState
		external
			"C [macro <wel.h>] (HMENU, UINT, UINT): EIF_INTEGER"
		alias
			"GetMenuState"
		end

	cwin_get_menu_string (hmenu: POINTER; id: INTEGER; buffer: POINTER;
				max: INTEGER; flags: INTEGER): INTEGER
			-- SDK GetMenuString
		external
			"C [macro <wel.h>] (HMENU, UINT, LPTSTR, int, %
				%UINT): EIF_INTEGER"
		alias
			"GetMenuString"
		end

	cwin_load_menu (hinstance: POINTER; id: POINTER): POINTER
			-- SDK LoadMenu
		external
			"C [macro <wel.h>] (HINSTANCE, LPCTSTR): EIF_POINTER"
		alias
			"LoadMenu"
		end

	cwin_destroy_menu (hmenu: POINTER)
			-- SDK DestroyMenu
		external
			"C [macro <wel.h>] (HMENU)"
		alias
			"DestroyMenu"
		end

	cwin_modify_menu (hmenu: POINTER; id, flags: INTEGER; new_id, new_name: POINTER)
			-- SDK ModifyMenu
		external
			"C [macro <wel.h>] (HMENU, UINT, UINT, UINT_PTR, LPCTSTR)"
		alias
			"ModifyMenu"
		end

	cwin_hilite_menu_item (hwnd: POINTER; hmenu: POINTER;
			id, flags: INTEGER)
			-- SDK HiliteMenuItem
		external
			"C [macro <wel.h>] (HWND, HMENU, UINT, UINT)"
		alias
			"HiliteMenuItem"
		end

	cwin_get_menu_item_id (hmenu: POINTER; position: INTEGER): INTEGER
			-- SDK GetMenuItemID
		external
			"C [macro <wel.h>] (HMENU, int): EIF_INTEGER"
		alias
			"GetMenuItemID"
		end

	cwel_menu_item_not_found: INTEGER
			-- Value returned by GetMenuState when an item does
			-- not exist.
		external
			"C [macro <wel.h>]"
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

