note
	description: "Window style (WS) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_WS_CONSTANTS

feature -- Basic window types

	Ws_overlapped, Ws_tiled: INTEGER = 0
			-- Declared in Windows as WS_OVERLAPPED

	Ws_popup: INTEGER = -2147483648
			-- Declared in Windows as WS_POPUP

	Ws_child: INTEGER = 1073741824
			-- Declared in Windows as WS_CHILD

feature -- Clipping styles

	Ws_clipsiblings: INTEGER = 67108864
			-- Declared in Windows as WS_CLIPSIBLINGS

	Ws_clipchildren: INTEGER = 33554432
			-- Declared in Windows as WS_CLIPCHILDREN

feature -- Generic window states

	Ws_visible: INTEGER = 268435456
			-- Declared in Windows as WS_VISIBLE

	Ws_disabled: INTEGER = 134217728
			-- Declared in Windows as WS_DISABLED

feature -- Main window states

	Ws_minimize, Ws_iconic: INTEGER = 536870912
			-- Declared in Windows as WS_MINIMIZE

	Ws_maximize: INTEGER = 16777216
			-- Declared in Windows as WS_MAXIMIZE

feature -- Main window styles

	Ws_caption: INTEGER = 12582912
			-- Declared in Windows as WS_CAPTION

	Ws_border: INTEGER = 8388608
			-- Declared in Windows as WS_BORDER

	Ws_dlgframe: INTEGER = 4194304
			-- Declared in Windows as WS_DLGFRAME

	Ws_vscroll: INTEGER = 2097152
			-- Declared in Windows as WS_VSCROLL

	Ws_hscroll: INTEGER = 1048576
			-- Declared in Windows as WS_HSCROLL

	Ws_sysmenu: INTEGER = 524288
			-- Declared in Windows as WS_SYSMENU

	Ws_thickframe, Ws_sizebox: INTEGER = 262144
			-- Declared in Windows as WS_THICKFRAME

	Ws_minimizebox: INTEGER = 131072
			-- Declared in Windows as WS_MINIMIZEBOX

	Ws_maximizebox: INTEGER = 65536
			-- Declared in Windows as WS_MAXIMIZEBOX

feature -- Control window styles

	Ws_group: INTEGER = 131072
			-- Declared in Windows as WS_GROUP

	Ws_tabstop: INTEGER = 65536
			-- Declared in Windows as WS_TABSTOP

feature -- Common window styles

	Ws_overlappedwindow, Ws_tiledwindow: INTEGER = 13565952
			-- Declared in Windows as WS_OVERLAPPEDWINDOW

	Ws_popupwindow: INTEGER = -2138570752
			-- Declared in Windows as WS_POPUPWINDOW

	Ws_childwindow: INTEGER = 1073741824
			-- Declared in Windows as WS_CHILDWINDOW

feature -- Extended window styles

	Ws_ex_acceptfiles: INTEGER = 16
			-- Declared in Windows as WS_EX_ACCEPTFILES

	Ws_ex_clientedge: INTEGER = 512
			-- Declared in Windows as WS_EX_CLIENTEDGE

	Ws_ex_contexthelp: INTEGER = 1024
			-- Declared in Windows as WS_EX_CONTEXTHELP

	Ws_ex_controlparent: INTEGER = 65536
			-- Declared in Windows as WS_EX_CONTROLPARENT

	Ws_ex_dlgmodalframe: INTEGER = 1
			-- Declared in Windows as WS_EX_DLGMODALFRAME

	Ws_ex_appwindow: INTEGER = 262144

	Ws_ex_left: INTEGER = 0
			-- Declared in Windows as WS_EX_LEFT

	Ws_ex_leftscrollbar: INTEGER = 16384
			-- Declared in Windows as WS_EX_LEFTSCROLLBAR

	Ws_ex_ltrreading: INTEGER = 0
			-- Declared in Windows as WS_EX_LTRREADING

	Ws_ex_mdichild: INTEGER = 64
			-- Declared in Windows as WS_EX_MDICHILD

	Ws_ex_noparentnotify: INTEGER = 4
			-- Declared in Windows as WS_EX_NOPARENTNOTIFY

	Ws_ex_overlappedwindow: INTEGER = 768
			-- Declared in Windows as WS_EX_OVERLAPPEDWINDOW

	Ws_ex_palettewindow: INTEGER = 392
			-- Declared in Windows as WS_EX_PALETTEWINDOW

	Ws_ex_right: INTEGER = 4096
			-- Declared in Windows as WS_EX_RIGHT

	Ws_ex_rightscrollbar: INTEGER = 0
			-- Declared in Windows as WS_EX_RIGHTSCROLLBAR

	Ws_ex_rtlreading: INTEGER = 8192
			-- Declared in Windows as WS_EX_RTLREADING

	Ws_ex_staticedge: INTEGER = 131072
			-- Declared in Windows as WS_EX_STATICEDGE

	Ws_ex_toolwindow: INTEGER = 128
			-- Declared in Windows as WS_EX_TOOLWINDOW

	Ws_ex_topmost: INTEGER = 8
			-- Declared in Windows as WS_EX_TOPMOST

	Ws_ex_transparent: INTEGER = 32
			-- Declared in Windows as WS_EX_TRANSPARENT

	Ws_ex_windowedge: INTEGER = 256
			-- Declared in Windows as WS_EX_WINDOWEDGE

	Ws_ex_layered: INTEGER = 0x00080000
			-- Declared in Windows as WS_EX_LAYERED

	Ws_ex_noactivate: INTEGER = 0x08000000
			-- Declared in Windows as WS_EX_NOACTIVATE

feature -- Miscellaneous

	Cw_usedefault: INTEGER = -2147483648;
			-- Declared in Windows as CW_USEDEFAULT

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




end -- class WEL_WS_CONSTANTS

