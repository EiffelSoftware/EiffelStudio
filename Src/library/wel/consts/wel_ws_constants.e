indexing
	description: "Window style (WS) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_WS_CONSTANTS

feature -- Basic window types

	Ws_overlapped, Ws_tiled: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_OVERLAPPED"
		end

	Ws_popup: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_POPUP"
		end

	Ws_child: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_CHILD"
		end

feature -- Clipping styles

	Ws_clipsiblings: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_CLIPSIBLINGS"
		end

	Ws_clipchildren: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_CLIPCHILDREN"
		end

feature -- Generic window states

	Ws_visible: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_VISIBLE"
		end

	Ws_disabled: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_DISABLED"
		end

feature -- Main window states

	Ws_minimize, Ws_iconic: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_MINIMIZE"
		end

	Ws_maximize: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_MAXIMIZE"
		end

feature -- Main window styles

	Ws_caption: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_CAPTION"
		end

	Ws_border: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_BORDER"
		end

	Ws_dlgframe: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_DLGFRAME"
		end

	Ws_vscroll: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_VSCROLL"
		end

	Ws_hscroll: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_HSCROLL"
		end

	Ws_sysmenu: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_SYSMENU"
		end

	Ws_thickframe, Ws_sizebox: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_THICKFRAME"
		end

	Ws_minimizebox: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_MINIMIZEBOX"
		end

	Ws_maximizebox: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_MAXIMIZEBOX"
		end

feature -- Control window styles

	Ws_group: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_GROUP"
		end

	Ws_tabstop: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_TABSTOP"
		end

feature -- Common window styles

	Ws_overlappedwindow, Ws_tiledwindow: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_OVERLAPPEDWINDOW"
		end

	Ws_popupwindow: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_POPUPWINDOW"
		end

	Ws_childwindow: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_CHILDWINDOW"
		end

feature -- Extended window styles

	Ws_ex_acceptfiles: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_EX_ACCEPTFILES"
		end
		
	Ws_ex_clientedge: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_EX_CLIENTEDGE"
		end

	Ws_ex_contexthelp: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_EX_CONTEXTHELP"
		end

	Ws_ex_controlparent: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_EX_CONTROLPARENT"
		end

	Ws_ex_dlgmodalframe: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_EX_DLGMODALFRAME"
		end

	Ws_ex_left: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_EX_LEFT"
		end

	Ws_ex_leftscrollbar: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_EX_LEFTSCROLLBAR"
		end

	Ws_ex_ltrreading: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_EX_LTRREADING"
		end

	Ws_ex_mdichild: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_EX_MDICHILD"
		end

	Ws_ex_noparentnotify: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_EX_NOPARENTNOTIFY"
		end

	Ws_ex_overlappedwindow: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_EX_OVERLAPPEDWINDOW"
		end

	Ws_ex_palettewindow: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_EX_PALETTEWINDOW"
		end

	Ws_ex_right: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_EX_RIGHT"
		end

	Ws_ex_rightscrollbar: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_EX_RIGHTSCROLLBAR"
		end

	Ws_ex_rtlreading: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_EX_RTLREADING"
		end

	Ws_ex_staticedge: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_EX_STATICEDGE"
		end

	Ws_ex_toolwindow: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_EX_TOOLWINDOW"
		end

	Ws_ex_topmost: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_EX_TOPMOST"
		end

	Ws_ex_transparent: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_EX_TRANSPARENT"
		end

	Ws_ex_windowedge: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WS_EX_WINDOWEDGE"
		end

feature -- Miscellaneous

	Cw_usedefault: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CW_USEDEFAULT"
		end

end -- class WEL_WS_CONSTANTS

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

