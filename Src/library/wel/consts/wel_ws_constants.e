indexing
	description: "Window style (WS) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_WS_CONSTANTS

feature -- Basic window types

	Ws_overlapped, Ws_tiled: INTEGER is 0
			-- Declared in Windows as WS_OVERLAPPED

	Ws_popup: INTEGER is -2147483648
			-- Declared in Windows as WS_POPUP

	Ws_child: INTEGER is 1073741824
			-- Declared in Windows as WS_CHILD

feature -- Clipping styles

	Ws_clipsiblings: INTEGER is 67108864
			-- Declared in Windows as WS_CLIPSIBLINGS

	Ws_clipchildren: INTEGER is 33554432
			-- Declared in Windows as WS_CLIPCHILDREN

feature -- Generic window states

	Ws_visible: INTEGER is 268435456
			-- Declared in Windows as WS_VISIBLE

	Ws_disabled: INTEGER is 134217728
			-- Declared in Windows as WS_DISABLED

feature -- Main window states

	Ws_minimize, Ws_iconic: INTEGER is 536870912
			-- Declared in Windows as WS_MINIMIZE

	Ws_maximize: INTEGER is 16777216
			-- Declared in Windows as WS_MAXIMIZE

feature -- Main window styles

	Ws_caption: INTEGER is 12582912
			-- Declared in Windows as WS_CAPTION

	Ws_border: INTEGER is 8388608
			-- Declared in Windows as WS_BORDER

	Ws_dlgframe: INTEGER is 4194304
			-- Declared in Windows as WS_DLGFRAME

	Ws_vscroll: INTEGER is 2097152
			-- Declared in Windows as WS_VSCROLL

	Ws_hscroll: INTEGER is 1048576
			-- Declared in Windows as WS_HSCROLL

	Ws_sysmenu: INTEGER is 524288
			-- Declared in Windows as WS_SYSMENU

	Ws_thickframe, Ws_sizebox: INTEGER is 262144
			-- Declared in Windows as WS_THICKFRAME

	Ws_minimizebox: INTEGER is 131072
			-- Declared in Windows as WS_MINIMIZEBOX

	Ws_maximizebox: INTEGER is 65536
			-- Declared in Windows as WS_MAXIMIZEBOX

feature -- Control window styles

	Ws_group: INTEGER is 131072
			-- Declared in Windows as WS_GROUP

	Ws_tabstop: INTEGER is 65536
			-- Declared in Windows as WS_TABSTOP

feature -- Common window styles

	Ws_overlappedwindow, Ws_tiledwindow: INTEGER is 13565952
			-- Declared in Windows as WS_OVERLAPPEDWINDOW

	Ws_popupwindow: INTEGER is -2138570752
			-- Declared in Windows as WS_POPUPWINDOW

	Ws_childwindow: INTEGER is 1073741824
			-- Declared in Windows as WS_CHILDWINDOW

feature -- Extended window styles

	Ws_ex_acceptfiles: INTEGER is 16
			-- Declared in Windows as WS_EX_ACCEPTFILES

	Ws_ex_clientedge: INTEGER is 512
			-- Declared in Windows as WS_EX_CLIENTEDGE

	Ws_ex_contexthelp: INTEGER is 1024
			-- Declared in Windows as WS_EX_CONTEXTHELP

	Ws_ex_controlparent: INTEGER is 65536
			-- Declared in Windows as WS_EX_CONTROLPARENT

	Ws_ex_dlgmodalframe: INTEGER is 1
			-- Declared in Windows as WS_EX_DLGMODALFRAME

	Ws_ex_left: INTEGER is 0
			-- Declared in Windows as WS_EX_LEFT

	Ws_ex_leftscrollbar: INTEGER is 16384
			-- Declared in Windows as WS_EX_LEFTSCROLLBAR

	Ws_ex_ltrreading: INTEGER is 0
			-- Declared in Windows as WS_EX_LTRREADING

	Ws_ex_mdichild: INTEGER is 64
			-- Declared in Windows as WS_EX_MDICHILD

	Ws_ex_noparentnotify: INTEGER is 4
			-- Declared in Windows as WS_EX_NOPARENTNOTIFY

	Ws_ex_overlappedwindow: INTEGER is 768
			-- Declared in Windows as WS_EX_OVERLAPPEDWINDOW

	Ws_ex_palettewindow: INTEGER is 392
			-- Declared in Windows as WS_EX_PALETTEWINDOW

	Ws_ex_right: INTEGER is 4096
			-- Declared in Windows as WS_EX_RIGHT

	Ws_ex_rightscrollbar: INTEGER is 0
			-- Declared in Windows as WS_EX_RIGHTSCROLLBAR

	Ws_ex_rtlreading: INTEGER is 8192
			-- Declared in Windows as WS_EX_RTLREADING

	Ws_ex_staticedge: INTEGER is 131072
			-- Declared in Windows as WS_EX_STATICEDGE

	Ws_ex_toolwindow: INTEGER is 128
			-- Declared in Windows as WS_EX_TOOLWINDOW

	Ws_ex_topmost: INTEGER is 8
			-- Declared in Windows as WS_EX_TOPMOST

	Ws_ex_transparent: INTEGER is 32
			-- Declared in Windows as WS_EX_TRANSPARENT

	Ws_ex_windowedge: INTEGER is 256
			-- Declared in Windows as WS_EX_WINDOWEDGE

feature -- Miscellaneous

	Cw_usedefault: INTEGER is -2147483648
			-- Declared in Windows as CW_USEDEFAULT

end -- class WEL_WS_CONSTANTS


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

