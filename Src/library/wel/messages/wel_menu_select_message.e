indexing
	description: "Information about message Wm_menuselect which is sent to %
		%a menu's owner window when the user highlights a menu item."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MENU_SELECT_MESSAGE

inherit
	WEL_MESSAGE_INFORMATION

	WEL_MF_CONSTANTS
		export
			{NONE} all
		end

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end

creation
	make

feature -- Access

	item: INTEGER is
			-- Menu item
		do
			Result := cwin_get_wm_menuselect_cmd (w_param, l_param)
		end

	flags: INTEGER is
			-- Menu flags
		do
			Result := cwin_get_wm_menuselect_flags (w_param,
				l_param)
		end

	menu: WEL_MENU is
			-- Menu clicked
		require
			menu_exists: menu_exists
		do
			create Result.make_by_pointer (h_menu)
		end

	h_menu: POINTER is
			-- Handle of menu clicked
		do
			Result := cwin_get_wm_menuselect_hmenu (w_param,
				l_param)
		end

feature -- Status report

	menu_exists: BOOLEAN is
			-- Does the menu exist?
		do
			Result := h_menu /= default_pointer
		end

	is_bitmap: BOOLEAN is
			-- Is the item a bitmap?
		do
			Result := flag_set (flags, Mf_bitmap)
		end

	checked: BOOLEAN is
			-- Is the item checked?
		do
			Result := flag_set (flags, Mf_checked)
		end

	disabled: BOOLEAN is
			-- Is the item disabled?
		do
			Result := flag_set (flags, Mf_disabled)
		end

	grayed: BOOLEAN is
			-- Is the item grayed?
		do
			Result := flag_set (flags, Mf_grayed)
		end

	highlighted: BOOLEAN is
			-- Is the item highlighted?
		do
			Result := flag_set (flags, Mf_hilite)
		end

	mouse_selected: BOOLEAN is
			-- Is the item selected with the mouse?
		do
			Result := flag_set (flags, Mf_mouseselect)
		end

	owner_drawn: BOOLEAN is
			-- Is the item owner-drawn?
		do
			Result := flag_set (flags, Mf_ownerdraw)
		end

	is_popup: BOOLEAN is
			-- Is the item a popup menu?
		do
			Result := flag_set (flags, Mf_popup)
		end

	is_system_menu: BOOLEAN is
			-- Is the item contained in the system menu?
		do
			Result := flag_set (flags, Mf_sysmenu)
		end

feature {NONE} -- Externals

	cwin_get_wm_menuselect_cmd (wparam, lparam: INTEGER): INTEGER is
		external
			"C [macro <winx.h>] (WPARAM, LPARAM): EIF_INTEGER"
		alias
			"GET_WM_MENUSELECT_CMD"
		end

	cwin_get_wm_menuselect_flags (wparam, lparam: INTEGER): INTEGER is
		external
			"C [macro <winx.h>] (WPARAM, LPARAM): EIF_INTEGER"
		alias
			"GET_WM_MENUSELECT_FLAGS"
		end

	cwin_get_wm_menuselect_hmenu (wparam, lparam: INTEGER): POINTER is
		external
			"C [macro <winx.h>] (WPARAM, LPARAM): EIF_POINTER"
		alias
			"GET_WM_MENUSELECT_HMENU"
		end

end -- class WEL_MENU_SELECT_MESSAGE

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

