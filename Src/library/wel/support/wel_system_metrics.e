indexing
	description	: "System metrics and system configuration settings %
				  %informations."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_SYSTEM_METRICS

inherit
	ANY

	WEL_SM_CONSTANTS
		export
			{NONE} all
		end

feature -- Status report

	window_border_width: INTEGER is
			-- Width of the border of a window
		do
			Result := cwin_get_system_metrics (Sm_cxborder)
		end

	window_border_height: INTEGER is
			-- Height of the border of a window
		do
			Result := cwin_get_system_metrics (Sm_cyborder)
		end

	cursor_width: INTEGER is
			-- Width of the cursor
		do
			Result := cwin_get_system_metrics (Sm_cxcursor)
		end

	cursor_height: INTEGER is
			-- Height of the cursor
		do
			Result := cwin_get_system_metrics (Sm_cycursor)
		end

	dialog_window_frame_width: INTEGER is
			-- Width of window frame for window that
			-- has the `Ws_dlgframe' style
		do
			Result := cwin_get_system_metrics (Sm_cxdlgframe)
		end

	dialog_window_frame_height: INTEGER is
			-- Height of window frame for window that
			-- has the `Ws_dlgframe' style
		do
			Result := cwin_get_system_metrics (Sm_cydlgframe)
		end

	double_click_width: INTEGER is
			-- Width of a rectangle around the location of a
			-- first click in a double-click sequence. The second
			-- click must occur within this rectangle for the
			-- system to consider the two clicks a double-click.
		do
			Result := cwin_get_system_metrics (Sm_cxdoubleclk)
		end

	double_click_height: INTEGER is
			-- Height of a rectangle around the location of a
			-- first click in a double-click sequence. The second
			-- click must occur within this rectangle for the
			-- system to consider the two clicks a double-click.
		do
			Result := cwin_get_system_metrics (Sm_cydoubleclk)
		end

	window_frame_width: INTEGER is
			-- Width of window frame for a window
			-- that can be resized
		do
			Result := cwin_get_system_metrics (Sm_cxframe)
		end

	window_frame_height: INTEGER is
			-- Height of window frame for a window
			-- that can be resized
		do
			Result := cwin_get_system_metrics (Sm_cyframe)
		end

	full_screen_client_area_width: INTEGER is
			-- Width of the client area for a full-screen window
		do
			Result := cwin_get_system_metrics (Sm_cxfullscreen)
		end

	full_screen_client_area_height: INTEGER is
			-- Height of the client area for a full-screen window
		do
			Result := cwin_get_system_metrics (Sm_cyfullscreen)
		end

	maximized_window_width: INTEGER is
			-- Width of a maximized window
		do
			Result := cwin_get_system_metrics (Sm_cxmaximized)
		end

	maximized_window_height: INTEGER is
			-- Height of a maximized window
		do
			Result := cwin_get_system_metrics (Sm_cymaximized)
		end

	horizontal_scroll_bar_arrow_width: INTEGER is
			-- Width of arrow bitmap on horizontal scrollbar
		do
			Result := cwin_get_system_metrics (Sm_cxhscroll)
		end

	horizontal_scroll_bar_arrow_height: INTEGER is
			-- Height of arrow bitmap on horizontal scrollbar
		do
			Result := cwin_get_system_metrics (Sm_cyhscroll)
		end

	horizontal_scroll_bar_thumb_width: INTEGER is
		do
			Result := cwin_get_system_metrics (Sm_cxhthumb)
		end

	icon_width: INTEGER is
			-- Width of an icon
		do
			Result := cwin_get_system_metrics (Sm_cxicon)
		end

	icon_height: INTEGER is
			-- Height of an icon
		do
			Result := cwin_get_system_metrics (Sm_cyicon)
		end

	icon_spacing_width: INTEGER is
			-- Width of rectangular cell that Program Manager
			-- uses to position tiled icons
		do
			Result := cwin_get_system_metrics (Sm_cxiconspacing)
		end

	icon_spacing_height: INTEGER is
			-- Height of rectangular cell that Program Manager
			-- uses to position tiled icons
		do
			Result := cwin_get_system_metrics (Sm_cyiconspacing)
		end

	window_minimum_width: INTEGER is
			-- Minimum width of a window
		do
			Result := cwin_get_system_metrics (Sm_cxmin)
		end

	window_minimum_height: INTEGER is
			-- Minimum height of a window
		do
			Result := cwin_get_system_metrics (Sm_cymin)
		end

	screen_width: INTEGER is
			-- Screen width
		do
			Result := cwin_get_system_metrics (Sm_cxscreen)
		end

	screen_height: INTEGER is
			-- Screen height
		do
			Result := cwin_get_system_metrics (Sm_cyscreen)
		end

	virtual_screen_x: INTEGER is
			-- Screen width
		do
			Result := cwin_get_system_metrics (Sm_xvirtualscreen)
		end

	virtual_screen_y: INTEGER is
			-- Screen height
		do
			Result := cwin_get_system_metrics (Sm_yvirtualscreen)
		end

	virtual_screen_width: INTEGER is
			-- Screen width
		do
			Result := cwin_get_system_metrics (Sm_cxvirtualscreen)
		end

	virtual_screen_height: INTEGER is
			-- Screen height
		do
			Result := cwin_get_system_metrics (Sm_cyvirtualscreen)
		end

	title_bar_width: INTEGER is
			-- Width of bitmaps contained in title bar
		do
			Result := cwin_get_system_metrics (Sm_cxsize)
		end

	title_bar_height: INTEGER is
			-- Height of bitmaps contained in title bar
		do
			Result := cwin_get_system_metrics (sm_cycaption)
		end

	vertical_scroll_bar_arrow_width: INTEGER is
			-- Width of arrow bitmap on vertical scrollbar
		do
			Result := cwin_get_system_metrics (Sm_cxvscroll)
		end

	vertical_scroll_bar_arrow_height: INTEGER is
			-- Height of arrow bitmap on vertical scrollbar
		do
			Result := cwin_get_system_metrics (Sm_cyvscroll)
		end

	vertical_scroll_bar_thumb_height: INTEGER is
			-- Height of vertical scrollbar thumb
		do
			Result := cwin_get_system_metrics (Sm_cyvthumb)
		end

	caption_height: INTEGER is
			-- Height of normal caption area
		do
			Result := cwin_get_system_metrics (Sm_cycaption)
		end

	kanji_window_height: INTEGER is
			-- Height of the Kanji window at the bottom of the
			-- screen. For double-byte character set versions of
			-- Windows only.
		do
			Result := cwin_get_system_metrics (Sm_cykanjiwindow)
		end

	menu_bar_height: INTEGER is
			-- Height of single-line menu bar
		do
			Result := cwin_get_system_metrics (Sm_cymenu)
		end

	dbcs_installed: BOOLEAN is
			-- Is the double-byte character set (DBCS) version
			-- of USER.EXE installed?
		do
			Result := cwin_get_system_metrics (Sm_dbcsenabled) /= 0
		end

	debug_installed: BOOLEAN is
			-- Is the debugging version of USER.EXE installed?
		do
			Result := cwin_get_system_metrics (Sm_debug) /= 0
		end

	popup_menu_right_aligned: BOOLEAN is
			-- Are pop-up menus right-aligned relative to the
			-- corresponding menu-bar item?
		do
			Result := cwin_get_system_metrics (Sm_menudropalignment) /= 0
		end

	mouse_installed: BOOLEAN is
			-- Is a mouse installed?
		do
			Result := cwin_get_system_metrics (Sm_mousepresent) /= 0
		end

	pen_installed: BOOLEAN is
			-- Is a pen installed?
		do
			Result := cwin_get_system_metrics (Sm_penwindows) /= 0
		end

	mouse_button_swapped: BOOLEAN is
			-- Are the meanings of the left and right mouse
			-- buttons swapped?
		do
			Result := cwin_get_system_metrics (Sm_swapbutton) /= 0
		end

feature {NONE} -- Externals

	cwin_get_system_metrics (value: INTEGER): INTEGER is
			-- SDK GetSystemMetrics
		external
			"C [macro <wel.h>] (int): EIF_INTEGER"
		alias
			"GetSystemMetrics"
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_SYSTEM_METRICS

