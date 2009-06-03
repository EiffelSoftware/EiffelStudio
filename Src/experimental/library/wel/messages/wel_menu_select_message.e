note
	description: "Information about message Wm_menuselect which is sent to %
		%a menu's owner window when the user highlights a menu item."
	legal: "See notice at end of class."
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

create
	make

feature -- Access

	item: INTEGER
			-- Menu item
		do
			Result := cwin_get_wm_menuselect_cmd (w_param, l_param)
		end

	flags: INTEGER
			-- Menu flags
		do
			Result := cwin_get_wm_menuselect_flags (w_param,
				l_param)
		end

	menu: WEL_MENU
			-- Menu clicked
		require
			menu_exists: menu_exists
		do
			create Result.make_by_pointer (h_menu)
		end

	h_menu: POINTER
			-- Handle of menu clicked
		do
			Result := cwin_get_wm_menuselect_hmenu (w_param,
				l_param)
		end

feature -- Status report

	menu_exists: BOOLEAN
			-- Does the menu exist?
		do
			Result := h_menu /= default_pointer
		end

	is_bitmap: BOOLEAN
			-- Is the item a bitmap?
		do
			Result := flag_set (flags, Mf_bitmap)
		end

	checked: BOOLEAN
			-- Is the item checked?
		do
			Result := flag_set (flags, Mf_checked)
		end

	disabled: BOOLEAN
			-- Is the item disabled?
		do
			Result := flag_set (flags, Mf_disabled)
		end

	grayed: BOOLEAN
			-- Is the item grayed?
		do
			Result := flag_set (flags, Mf_grayed)
		end

	highlighted: BOOLEAN
			-- Is the item highlighted?
		do
			Result := flag_set (flags, Mf_hilite)
		end

	mouse_selected: BOOLEAN
			-- Is the item selected with the mouse?
		do
			Result := flag_set (flags, Mf_mouseselect)
		end

	owner_drawn: BOOLEAN
			-- Is the item owner-drawn?
		do
			Result := flag_set (flags, Mf_ownerdraw)
		end

	is_popup: BOOLEAN
			-- Is the item a popup menu?
		do
			Result := flag_set (flags, Mf_popup)
		end

	is_system_menu: BOOLEAN
			-- Is the item contained in the system menu?
		do
			Result := flag_set (flags, Mf_sysmenu)
		end

feature {NONE} -- Externals

	cwin_get_wm_menuselect_cmd (wparam, lparam: POINTER): INTEGER
		external
			"C [macro <winx.h>] (WPARAM, LPARAM): EIF_INTEGER"
		alias
			"GET_WM_MENUSELECT_CMD"
		end

	cwin_get_wm_menuselect_flags (wparam, lparam: POINTER): INTEGER
		external
			"C [macro <winx.h>] (WPARAM, LPARAM): EIF_INTEGER"
		alias
			"GET_WM_MENUSELECT_FLAGS"
		end

	cwin_get_wm_menuselect_hmenu (wparam, lparam: POINTER): POINTER
		external
			"C [macro <winx.h>] (WPARAM, LPARAM): EIF_POINTER"
		alias
			"GET_WM_MENUSELECT_HMENU"
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




end -- class WEL_MENU_SELECT_MESSAGE

