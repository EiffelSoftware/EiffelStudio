indexing
	description: "Window message (WM) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_WM_CONSTANTS

feature -- Access

	Wm_compacting: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_COMPACTING"
		end

	Wm_wininichange: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_WININICHANGE"
		end

	Wm_syscolorchange: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_SYSCOLORCHANGE"
		end

	Wm_querynewpalette: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_QUERYNEWPALETTE"
		end

	Wm_paletteischanging: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_PALETTEISCHANGING"
		end

	Wm_palettechanged: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_PALETTECHANGED"
		end

	Wm_fontchange: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_FONTCHANGE"
		end

	Wm_spoolerstatus: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_SPOOLERSTATUS"
		end

	Wm_devmodechange: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_DEVMODECHANGE"
		end

	Wm_timechange: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_TIMECHANGE"
		end

	Wm_null: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_NULL"
		end

	Wm_user: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_USER"
		end

	Wm_penwinfirst: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_PENWINFIRST"
		end

	Wm_penwinlast: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_PENWINLAST"
		end

	Wm_power: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_POWER"
		end

	Wm_queryendsession: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_QUERYENDSESSION"
		end

	Wm_endsession: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_ENDSESSION"
		end

	Wm_quit: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_QUIT"
		end

	Wm_create: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_CREATE"
		end

	Wm_nccreate: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_NCCREATE"
		end

	Wm_destroy: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_DESTROY"
		end

	Wm_ncdestroy: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_NCDESTROY"
		end

	Wm_showwindow: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_SHOWWINDOW"
		end

	Wm_setredraw: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_SETREDRAW"
		end

	Wm_enable: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_ENABLE"
		end

	Wm_settext: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_SETTEXT"
		end

	Wm_gettext: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_GETTEXT"
		end

	Wm_gettextlength: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_GETTEXTLENGTH"
		end

	Wm_windowposchanging: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_WINDOWPOSCHANGING"
		end

	Wm_windowposchanged: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_WINDOWPOSCHANGED"
		end

	Wm_move: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_MOVE"
		end

	Wm_size: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_SIZE"
		end

	Wm_queryopen: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_QUERYOPEN"
		end

	Wm_close: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_CLOSE"
		end

	Wm_getminmaxinfo: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_GETMINMAXINFO"
		end

	Wm_paint: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_PAINT"
		end

	Wm_erasebkgnd: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_ERASEBKGND"
		end

	Wm_iconerasebkgnd: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_ICONERASEBKGND"
		end

	Wm_ncpaint: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_NCPAINT"
		end

	Wm_nccalcsize: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_NCCALCSIZE"
		end

	Wm_nchittest: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_NCHITTEST"
		end

	Wm_querydragicon: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_QUERYDRAGICON"
		end

	Wm_dropfiles: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_DROPFILES"
		end

	Wm_activate: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_ACTIVATE"
		end

	Wm_activateapp: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_ACTIVATEAPP"
		end

	Wm_ncactivate: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_NCACTIVATE"
		end

	Wm_setfocus: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_SETFOCUS"
		end

	Wm_killfocus: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_KILLFOCUS"
		end

	Wm_keydown: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_KEYDOWN"
		end

	Wm_keyup: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_KEYUP"
		end

	Wm_char: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_CHAR"
		end

	Wm_deadchar: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_DEADCHAR"
		end

	Wm_syskeydown: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_SYSKEYDOWN"
		end

	Wm_syskeyup: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_SYSKEYUP"
		end

	Wm_syschar: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_SYSCHAR"
		end

	Wm_sysdeadchar: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_SYSDEADCHAR"
		end

	Wm_keyfirst: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_KEYFIRST"
		end

	Wm_keylast: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_KEYLAST"
		end

	Wm_mousemove: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_MOUSEMOVE"
		end

	Wm_lbuttondown: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_LBUTTONDOWN"
		end

	Wm_lbuttonup: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_LBUTTONUP"
		end

	Wm_lbuttondblclk: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_LBUTTONDBLCLK"
		end

	Wm_rbuttondown: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_RBUTTONDOWN"
		end

	Wm_rbuttonup: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_RBUTTONUP"
		end

	Wm_rbuttondblclk: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_RBUTTONDBLCLK"
		end

	Wm_mbuttondown: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_MBUTTONDOWN"
		end

	Wm_mbuttonup: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_MBUTTONUP"
		end

	Wm_mbuttondblclk: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_MBUTTONDBLCLK"
		end

	Wm_mousefirst: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_MOUSEFIRST"
		end

	Wm_mouselast: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_MOUSELAST"
		end

	Wm_ncmousemove: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_NCMOUSEMOVE"
		end

	Wm_nclbuttondown: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_NCLBUTTONDOWN"
		end

	Wm_nclbuttonup: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_NCLBUTTONUP"
		end

	Wm_nclbuttondblclk: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_NCLBUTTONDBLCLK"
		end

	Wm_ncrbuttondown: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_NCRBUTTONDOWN"
		end

	Wm_ncrbuttonup: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_NCRBUTTONUP"
		end

	Wm_ncrbuttondblclk: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_NCRBUTTONDBLCLK"
		end

	Wm_ncmbuttondown: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_NCMBUTTONDOWN"
		end

	Wm_ncmbuttonup: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_NCMBUTTONUP"
		end

	Wm_ncmbuttondblclk: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_NCMBUTTONDBLCLK"
		end

	Wm_mouseactivate: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_MOUSEACTIVATE"
		end

	Wm_cancelmode: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_CANCELMODE"
		end

	Wm_timer: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_TIMER"
		end

	Wm_initmenu: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_INITMENU"
		end

	Wm_initmenupopup: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_INITMENUPOPUP"
		end

	Wm_menuselect: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_MENUSELECT"
		end

	Wm_menuchar: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_MENUCHAR"
		end

	Wm_command: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_COMMAND"
		end

	Wm_hscroll: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_HSCROLL"
		end

	Wm_vscroll: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_VSCROLL"
		end

	Wm_cut: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_CUT"
		end

	Wm_copy: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_COPY"
		end

	Wm_paste: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_PASTE"
		end

	Wm_clear: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_CLEAR"
		end

	Wm_undo: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_UNDO"
		end

	Wm_renderformat: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_RENDERFORMAT"
		end

	Wm_renderallformats: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_RENDERALLFORMATS"
		end

	Wm_destroyclipboard: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_DESTROYCLIPBOARD"
		end

	Wm_drawclipboard: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_DRAWCLIPBOARD"
		end

	Wm_paintclipboard: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_PAINTCLIPBOARD"
		end

	Wm_sizeclipboard: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_SIZECLIPBOARD"
		end

	Wm_vscrollclipboard: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_VSCROLLCLIPBOARD"
		end

	Wm_hscrollclipboard: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_HSCROLLCLIPBOARD"
		end

	Wm_askcbformatname: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_ASKCBFORMATNAME"
		end

	Wm_changecbchain: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_CHANGECBCHAIN"
		end

	Wm_setcursor: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_SETCURSOR"
		end

	Wm_syscommand: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_SYSCOMMAND"
		end

	Wm_mdicreate: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_MDICREATE"
		end

	Wm_mdidestroy: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_MDIDESTROY"
		end

	Wm_mdiactivate: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_MDIACTIVATE"
		end

	Wm_mdirestore: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_MDIRESTORE"
		end

	Wm_mdinext: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_MDINEXT"
		end

	Wm_mdimaximize: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_MDIMAXIMIZE"
		end

	Wm_mditile: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_MDITILE"
		end

	Wm_mdicascade: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_MDICASCADE"
		end

	Wm_mdiiconarrange: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_MDIICONARRANGE"
		end

	Wm_mdigetactive: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_MDIGETACTIVE"
		end

	Wm_mdisetmenu: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_MDISETMENU"
		end

	Wm_childactivate: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_CHILDACTIVATE"
		end

	Wm_initdialog: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_INITDIALOG"
		end

	Wm_nextdlgctl: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_NEXTDLGCTL"
		end

	Wm_parentnotify: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_PARENTNOTIFY"
		end

	Wm_enteridle: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_ENTERIDLE"
		end

	Wm_getdlgcode: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_GETDLGCODE"
		end

	Wm_setfont: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_SETFONT"
		end

	Wm_getfont: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_GETFONT"
		end

	Wm_drawitem: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_DRAWITEM"
		end

	Wm_measureitem: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_MEASUREITEM"
		end

	Wm_deleteitem: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_DELETEITEM"
		end

	Wm_compareitem: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_COMPAREITEM"
		end

	Wm_vkeytoitem: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_VKEYTOITEM"
		end

	Wm_chartoitem: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_CHARTOITEM"
		end

	Wm_queuesync: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_QUEUESYNC"
		end

	Wm_commnotify: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_COMMNOTIFY"
		end

	Wm_notify: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WM_NOTIFY"
		end

end -- class WEL_WM_CONSTANTS

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

