indexing
	description	: "Window managment constants (WM_xxxx, ...)"
	status		: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_WINDOW_CONSTANTS

feature -- Window Messages

	Wm_null: INTEGER is 0
			-- Declared in Windows as WM_NULL

	Wm_create: INTEGER is 1
			-- Declared in Windows as WM_CREATE

	Wm_destroy: INTEGER is 2
			-- Declared in Windows as WM_DESTROY

	Wm_move: INTEGER is 3
			-- Declared in Windows as WM_MOVE

	Wm_size: INTEGER is 5
			-- Declared in Windows as WM_SIZE

	Wm_activate: INTEGER is 6
			-- Declared in Windows as WM_ACTIVATE

	Wm_setfocus: INTEGER is 7
			-- Declared in Windows as WM_SETFOCUS

	Wm_killfocus: INTEGER is 8
			-- Declared in Windows as WM_KILLFOCUS

	Wm_enable: INTEGER is 10
			-- Declared in Windows as WM_ENABLE

	Wm_setredraw: INTEGER is 11
			-- Declared in Windows as WM_SETREDRAW

	Wm_settext: INTEGER is 12
			-- Declared in Windows as WM_SETTEXT

	Wm_gettext: INTEGER is 13
			-- Declared in Windows as WM_GETTEXT

	Wm_gettextlength: INTEGER is 14
			-- Declared in Windows as WM_GETTEXTLENGTH

	Wm_paint: INTEGER is 15
			-- Declared in Windows as WM_PAINT

	Wm_close: INTEGER is 16
			-- Declared in Windows as WM_CLOSE

	Wm_queryendsession: INTEGER is 17
			-- Declared in Windows as WM_QUERYENDSESSION

	Wm_quit: INTEGER is 18
			-- Declared in Windows as WM_QUIT

	Wm_queryopen: INTEGER is 19
			-- Declared in Windows as WM_QUERYOPEN

	Wm_erasebkgnd: INTEGER is 20
			-- Declared in Windows as WM_ERASEBKGND

	Wm_syscolorchange: INTEGER is 21
			-- Declared in Windows as WM_SYSCOLORCHANGE

	Wm_endsession: INTEGER is 22
			-- Declared in Windows as WM_ENDSESSION

	Wm_showwindow: INTEGER is 24
			-- Declared in Windows as WM_SHOWWINDOW

	Wm_wininichange: INTEGER is 26
			-- Declared in Windows as WM_WININICHANGE

	Wm_devmodechange: INTEGER is 27
			-- Declared in Windows as WM_DEVMODECHANGE

	Wm_activateapp: INTEGER is 28
			-- Declared in Windows as WM_ACTIVATEAPP

	Wm_fontchange: INTEGER is 29
			-- Declared in Windows as WM_FONTCHANGE

	Wm_timechange: INTEGER is 30
			-- Declared in Windows as WM_TIMECHANGE

	Wm_cancelmode: INTEGER is 31
			-- The WM_CANCELMODE message is sent to cancel certain modes, such as mouse 
			-- capture. 
			-- For example, the system sends this message to the active window when a dialog 
			-- box or message box is displayed. Certain functions also send this message 
			-- explicitly to the specified window regardless of whether it is the active 
			-- window. For example, the EnableWindow function sends this message when 
			-- disabling the specified window. 
			--
			-- Declared in Windows as WM_CANCELMODE

	Wm_setcursor: INTEGER is 32
			-- Declared in Windows as WM_SETCURSOR

	Wm_mouseactivate: INTEGER is 33
			-- Declared in Windows as WM_MOUSEACTIVATE

	Wm_childactivate: INTEGER is 34
			-- Declared in Windows as WM_CHILDACTIVATE

	Wm_queuesync: INTEGER is 35
			-- Declared in Windows as WM_QUEUESYNC

	Wm_getminmaxinfo: INTEGER is 36
			-- Declared in Windows as WM_GETMINMAXINFO

	Wm_iconerasebkgnd: INTEGER is 39
			-- Declared in Windows as WM_ICONERASEBKGND

	Wm_nextdlgctl: INTEGER is 40
			-- Declared in Windows as WM_NEXTDLGCTL

	Wm_spoolerstatus: INTEGER is 42
			-- Declared in Windows as WM_SPOOLERSTATUS

	Wm_drawitem: INTEGER is 43
			-- Declared in Windows as WM_DRAWITEM

	Wm_measureitem: INTEGER is 44
			-- Declared in Windows as WM_MEASUREITEM

	Wm_deleteitem: INTEGER is 45
			-- Declared in Windows as WM_DELETEITEM

	Wm_vkeytoitem: INTEGER is 46
			-- Declared in Windows as WM_VKEYTOITEM

	Wm_chartoitem: INTEGER is 47
			-- Declared in Windows as WM_CHARTOITEM

	Wm_setfont: INTEGER is 48
			-- Declared in Windows as WM_SETFONT

	Wm_getfont: INTEGER is 49
			-- Declared in Windows as WM_GETFONT

	Wm_querydragicon: INTEGER is 55
			-- Declared in Windows as WM_QUERYDRAGICON

	Wm_compareitem: INTEGER is 57
			-- Declared in Windows as WM_COMPAREITEM

	Wm_compacting: INTEGER is 65
			-- Declared in Windows as WM_COMPACTING

	Wm_commnotify: INTEGER is 68
			-- Declared in Windows as WM_COMMNOTIFY

	Wm_windowposchanging: INTEGER is 70
			-- Declared in Windows as WM_WINDOWPOSCHANGING

	Wm_windowposchanged: INTEGER is 71
			-- Declared in Windows as WM_WINDOWPOSCHANGED

	Wm_power: INTEGER is 72
			-- Declared in Windows as WM_POWER

	Wm_notify: INTEGER is 78
			-- Declared in Windows as WM_NOTIFY

	Wm_geticon: INTEGER is 127
			-- Declared in Windows as WM_GETICON

	Wm_seticon: INTEGER is 128
			-- Declared in Windows as WM_SETICON

	Wm_nccreate: INTEGER is 129
			-- Declared in Windows as WM_NCCREATE

	Wm_ncdestroy: INTEGER is 130
			-- Declared in Windows as WM_NCDESTROY

	Wm_nccalcsize: INTEGER is 131
			-- Declared in Windows as WM_NCCALCSIZE

	Wm_nchittest: INTEGER is 132
			-- Declared in Windows as WM_NCHITTEST

	Wm_ncpaint: INTEGER is 133
			-- Declared in Windows as WM_NCPAINT

	Wm_ncactivate: INTEGER is 134
			-- Declared in Windows as WM_NCACTIVATE

	Wm_getdlgcode: INTEGER is 135
			-- Declared in Windows as WM_GETDLGCODE

	Wm_syncpaint: INTEGER is 136
			-- Declared in Windows as WM_SYNCPAINT

	Wm_ncmousemove: INTEGER is 160
			-- Declared in Windows as WM_NCMOUSEMOVE

	Wm_nclbuttondown: INTEGER is 161
			-- Declared in Windows as WM_NCLBUTTONDOWN

	Wm_nclbuttonup: INTEGER is 162
			-- Declared in Windows as WM_NCLBUTTONUP

	Wm_nclbuttondblclk: INTEGER is 163
			-- Declared in Windows as WM_NCLBUTTONDBLCLK

	Wm_ncrbuttondown: INTEGER is 164
			-- Declared in Windows as WM_NCRBUTTONDOWN

	Wm_ncrbuttonup: INTEGER is 165
			-- Declared in Windows as WM_NCRBUTTONUP

	Wm_ncrbuttondblclk: INTEGER is 166
			-- Declared in Windows as WM_NCRBUTTONDBLCLK

	Wm_ncmbuttondown: INTEGER is 167
			-- Declared in Windows as WM_NCMBUTTONDOWN

	Wm_ncmbuttonup: INTEGER is 168
			-- Declared in Windows as WM_NCMBUTTONUP

	Wm_ncmbuttondblclk: INTEGER is 169
			-- Declared in Windows as WM_NCMBUTTONDBLCLK

	Wm_keydown: INTEGER is 256
			-- Declared in Windows as WM_KEYDOWN

	Wm_keyfirst: INTEGER is 256
			-- Declared in Windows as WM_KEYFIRST

	Wm_keyup: INTEGER is 257
			-- Declared in Windows as WM_KEYUP

	Wm_char: INTEGER is 258
			-- Declared in Windows as WM_CHAR

	Wm_deadchar: INTEGER is 259
			-- Declared in Windows as WM_DEADCHAR

	Wm_syskeydown: INTEGER is 260
			-- Declared in Windows as WM_SYSKEYDOWN

	Wm_syskeyup: INTEGER is 261
			-- Declared in Windows as WM_SYSKEYUP

	Wm_syschar: INTEGER is 262
			-- Declared in Windows as WM_SYSCHAR

	Wm_sysdeadchar: INTEGER is 263
			-- Declared in Windows as WM_SYSDEADCHAR

	Wm_keylast: INTEGER is 264
			-- Declared in Windows as WM_KEYLAST

	Wm_initdialog: INTEGER is 272
			-- Declared in Windows as WM_INITDIALOG

	Wm_command: INTEGER is 273
			-- Declared in Windows as WM_COMMAND

	Wm_syscommand: INTEGER is 274
			-- Declared in Windows as WM_SYSCOMMAND

	Wm_timer: INTEGER is 275
			-- Declared in Windows as WM_TIMER

	Wm_hscroll: INTEGER is 276
			-- Declared in Windows as WM_HSCROLL

	Wm_vscroll: INTEGER is 277
			-- Declared in Windows as WM_VSCROLL

	Wm_initmenu: INTEGER is 278
			-- Declared in Windows as WM_INITMENU

	Wm_initmenupopup: INTEGER is 279
			-- Declared in Windows as WM_INITMENUPOPUP

	Wm_menuselect: INTEGER is 287
			-- Declared in Windows as WM_MENUSELECT

	Wm_menuchar: INTEGER is 288
			-- Declared in Windows as WM_MENUCHAR

	Wm_enteridle: INTEGER is 289
			-- Declared in Windows as WM_ENTERIDLE

	Wm_ctlcolormsgbox: INTEGER is 306
			-- Declared in Windows as WM_CTLCOLORMSGBOX

	Wm_ctlcoloredit: INTEGER is 307
			-- Declared in Windows as WM_CTLCOLOREDIT

	Wm_ctlcolorlistbox: INTEGER is 308
			-- Declared in Windows as WM_CTLCOLORLISTBOX

	Wm_ctlcolorbtn: INTEGER is 309
			-- Declared in Windows as WM_CTLCOLORBTN

	Wm_ctlcolordlg: INTEGER is 310
			-- Declared in Windows as WM_CTLCOLORDLG

	Wm_ctlcolorscrollbar: INTEGER is 311
			-- Declared in Windows as WM_CTLCOLORSCROLLBAR

	Wm_ctlcolorstatic: INTEGER is 312
			-- Declared in Windows as WM_CTLCOLORSTATIC

	Wm_mousemove: INTEGER is 512
			-- Declared in Windows as WM_MOUSEMOVE

	Wm_mousefirst: INTEGER is 512
			-- Declared in Windows as WM_MOUSEFIRST

	Wm_lbuttondown: INTEGER is 513
			-- Declared in Windows as WM_LBUTTONDOWN

	Wm_lbuttonup: INTEGER is 514
			-- Declared in Windows as WM_LBUTTONUP

	Wm_lbuttondblclk: INTEGER is 515
			-- Declared in Windows as WM_LBUTTONDBLCLK

	Wm_rbuttondown: INTEGER is 516
			-- Declared in Windows as WM_RBUTTONDOWN

	Wm_rbuttonup: INTEGER is 517
			-- Declared in Windows as WM_RBUTTONUP

	Wm_rbuttondblclk: INTEGER is 518
			-- Declared in Windows as WM_RBUTTONDBLCLK

	Wm_mbuttondown: INTEGER is 519
			-- Declared in Windows as WM_MBUTTONDOWN

	Wm_mbuttonup: INTEGER is 520
			-- Declared in Windows as WM_MBUTTONUP

	Wm_mbuttondblclk: INTEGER is 521
			-- Declared in Windows as WM_MBUTTONDBLCLK

	Wm_mouselast: INTEGER is 521
			-- Declared in Windows as WM_MOUSELAST

	Wm_parentnotify: INTEGER is 528
			-- Declared in Windows as WM_PARENTNOTIFY

	Wm_sizing: INTEGER is 532
			-- Declared in Windows as WM_SIZING

	Wm_capturechanged: INTEGER is 533
			-- Declared in Windows as WM_CAPTURECHANGED

	Wm_moving: INTEGER is 534
			-- Declared in Windows as WM_MOVING

	Wm_powerbroadcast: INTEGER is 536
			-- Declared in Windows as WM_POWERBROADCAST

	Wm_devicechange: INTEGER is 537
			-- Declared in Windows as WM_DEVICECHANGE

	Wm_mdicreate: INTEGER is 544
			-- Declared in Windows as WM_MDICREATE

	Wm_mdidestroy: INTEGER is 545
			-- Declared in Windows as WM_MDIDESTROY

	Wm_mdiactivate: INTEGER is 546
			-- Declared in Windows as WM_MDIACTIVATE

	Wm_mdirestore: INTEGER is 547
			-- Declared in Windows as WM_MDIRESTORE

	Wm_mdinext: INTEGER is 548
			-- Declared in Windows as WM_MDINEXT

	Wm_mdimaximize: INTEGER is 549
			-- Declared in Windows as WM_MDIMAXIMIZE

	Wm_mditile: INTEGER is 550
			-- Declared in Windows as WM_MDITILE

	Wm_mdicascade: INTEGER is 551
			-- Declared in Windows as WM_MDICASCADE

	Wm_mdiiconarrange: INTEGER is 552
			-- Declared in Windows as WM_MDIICONARRANGE

	Wm_mdigetactive: INTEGER is 553
			-- Declared in Windows as WM_MDIGETACTIVE

	Wm_mdisetmenu: INTEGER is 560
			-- Declared in Windows as WM_MDISETMENU

	Wm_entersizemove: INTEGER is 561
			-- Declared in Windows as WM_ENTERSIZEMOVE

	Wm_exitsizemove: INTEGER is 562
			-- Declared in Windows as WM_EXITSIZEMOVE

	Wm_dropfiles: INTEGER is 563
			-- Declared in Windows as WM_DROPFILES

	Wm_mdirefreshmenu: INTEGER is 564
			-- Declared in Windows as WM_MDIREFRESHMENU

	Wm_ime_setcontext: INTEGER is 641
			-- Declared in Windows as WM_IME_SETCONTEXT

	Wm_ime_notify: INTEGER is 642
			-- Declared in Windows as WM_IME_NOTIFY

	Wm_ime_control: INTEGER is 643
			-- Declared in Windows as WM_IME_CONTROL

	Wm_ime_compositionfull: INTEGER is 644
			-- Declared in Windows as WM_IME_COMPOSITIONFULL

	Wm_ime_select: INTEGER is 645
			-- Declared in Windows as WM_IME_SELECT

	Wm_ime_char: INTEGER is 646
			-- Declared in Windows as WM_IME_CHAR

	Wm_ime_keydown: INTEGER is 656
			-- Declared in Windows as WM_IME_KEYDOWN

	Wm_ime_keyup: INTEGER is 657
			-- Declared in Windows as WM_IME_KEYUP

	Wm_mousehover: INTEGER is 673
			-- Require Windows98, Windows NT 4.0 or later
			-- Declared in Windows as WM_MOUSEHOVER

	Wm_mouseleave: INTEGER is 675
			-- Require Windows98, Windows NT 4.0 or later
			-- Declared in Windows as WM_MOUSELEAVE

	Wm_cut: INTEGER is 768
			-- Declared in Windows as WM_CUT

	Wm_copy: INTEGER is 769
			-- Declared in Windows as WM_COPY

	Wm_paste: INTEGER is 770
			-- Declared in Windows as WM_PASTE

	Wm_clear: INTEGER is 771
			-- Declared in Windows as WM_CLEAR

	Wm_undo: INTEGER is 772
			-- Declared in Windows as WM_UNDO

	Wm_renderformat: INTEGER is 773
			-- Declared in Windows as WM_RENDERFORMAT

	Wm_renderallformats: INTEGER is 774
			-- Declared in Windows as WM_RENDERALLFORMATS

	Wm_destroyclipboard: INTEGER is 775
			-- Declared in Windows as WM_DESTROYCLIPBOARD

	Wm_drawclipboard: INTEGER is 776
			-- Declared in Windows as WM_DRAWCLIPBOARD

	Wm_paintclipboard: INTEGER is 777
			-- Declared in Windows as WM_PAINTCLIPBOARD

	Wm_sizeclipboard: INTEGER is 779
			-- Declared in Windows as WM_SIZECLIPBOARD

	Wm_vscrollclipboard: INTEGER is 778
			-- Declared in Windows as WM_VSCROLLCLIPBOARD

	Wm_hscrollclipboard: INTEGER is 782
			-- Declared in Windows as WM_HSCROLLCLIPBOARD

	Wm_askcbformatname: INTEGER is 780
			-- Declared in Windows as WM_ASKCBFORMATNAME

	Wm_changecbchain: INTEGER is 781
			-- Declared in Windows as WM_CHANGECBCHAIN

	Wm_querynewpalette: INTEGER is 783
			-- Declared in Windows as WM_QUERYNEWPALETTE

	Wm_paletteischanging: INTEGER is 784
			-- Declared in Windows as WM_PALETTEISCHANGING

	Wm_palettechanged: INTEGER is 785
			-- Declared in Windows as WM_PALETTECHANGED

	Wm_penwinfirst: INTEGER is 896
			-- Declared in Windows as WM_PENWINFIRST

	Wm_penwinlast: INTEGER is 911
			-- Declared in Windows as WM_PENWINLAST

	Wm_user: INTEGER is 1024
			-- Declared in Windows as WM_USER

feature -- Window styles

	Ws_overlapped, Ws_tiled: INTEGER is 0
			-- Declared in Windows as WS_OVERLAPPED

	Ws_popup: INTEGER is -2147483648
			-- Declared in Windows as WS_POPUP

	Ws_child: INTEGER is 1073741824
			-- Declared in Windows as WS_CHILD

	Ws_clipsiblings: INTEGER is 67108864
			-- Declared in Windows as WS_CLIPSIBLINGS

	Ws_clipchildren: INTEGER is 33554432
			-- Declared in Windows as WS_CLIPCHILDREN

	Ws_visible: INTEGER is 268435456
			-- Declared in Windows as WS_VISIBLE

	Ws_disabled: INTEGER is 134217728
			-- Declared in Windows as WS_DISABLED

	Ws_minimize, Ws_iconic: INTEGER is 536870912
			-- Declared in Windows as WS_MINIMIZE

	Ws_maximize: INTEGER is 16777216
			-- Declared in Windows as WS_MAXIMIZE

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

	Ws_group: INTEGER is 131072
			-- Declared in Windows as WS_GROUP

	Ws_tabstop: INTEGER is 65536
			-- Declared in Windows as WS_TABSTOP

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

	Cw_usedefault: INTEGER is -2147483648
			-- Declared in Windows as CW_USEDEFAULT

feature -- Window Size constants

	Size_maximized: INTEGER is 2
			-- Declared in Windows as SIZE_MAXIMIZED

	Size_minimized: INTEGER is 1
			-- Declared in Windows as SIZE_MINIMIZED

	Size_restored: INTEGER is 0
			-- Declared in Windows as SIZE_RESTORED

	Size_maxhide: INTEGER is 4
			-- Declared in Windows as SIZE_MAXHIDE

	Size_maxshow: INTEGER is 3
			-- Declared in Windows as SIZE_MAXSHOW


feature -- Show Window (SW) constants

	Sw_hide: INTEGER is 0
			-- Declared in Windows as SW_HIDE

	Sw_minimize: INTEGER is 6
			-- Declared in Windows as SW_MINIMIZE

	Sw_restore: INTEGER is 9
			-- Declared in Windows as SW_RESTORE

	Sw_shownormal: INTEGER is 1
			-- Declared in Windows as SW_SHOWNORMAL

	Sw_show: INTEGER is 5
			-- Declared in Windows as SW_SHOW

	Sw_showmaximized: INTEGER is 3
			-- Declared in Windows as SW_SHOWMAXIMIZED

	Sw_showminimized: INTEGER is 2
			-- Declared in Windows as SW_SHOWMINIMIZED

	Sw_showminnoactive: INTEGER is 7
			-- Declared in Windows as SW_SHOWMINNOACTIVE

	Sw_showna: INTEGER is 8
			-- Declared in Windows as SW_SHOWNA

	Sw_shownoactivate: INTEGER is 4
			-- Declared in Windows as SW_SHOWNOACTIVATE

	Sw_parentclosing: INTEGER is 1
			-- Declared in Windows as SW_PARENTCLOSING

	Sw_parentopening: INTEGER is 3
			-- Declared in Windows as SW_PARENTOPENING

	Sw_otherzoom: INTEGER is 2
			-- Declared in Windows as SW_OTHERZOOM

	Sw_otherunzoom: INTEGER is 4
			-- Declared in Windows as SW_OTHERUNZOOM

feature -- Show Window Position (SWP) constants

	Swp_nosize: INTEGER is 1
			-- Declared in Windows as SWP_NOSIZE

	Swp_nomove: INTEGER is 2
			-- Declared in Windows as SWP_NOMOVE

	Swp_nozorder: INTEGER is 4
			-- Declared in Windows as SWP_NOZORDER

	Swp_noredraw: INTEGER is 8
			-- Declared in Windows as SWP_NOREDRAW

	Swp_noactivate: INTEGER is 16
			-- Declared in Windows as SWP_NOACTIVATE

	Swp_framechanged, Swp_drawframe: INTEGER is 32
			-- Declared in Windows as SWP_FRAMECHANGED

	Swp_showwindow: INTEGER is 64
			-- Declared in Windows as SWP_SHOWWINDOW

	Swp_hidewindow: INTEGER is 128
			-- Declared in Windows as SWP_HIDEWINDOW

	Swp_nocopybits: INTEGER is 256
			-- Declared in Windows as SWP_NOCOPYBITS

	Swp_noownerzorder, Swp_noreposition: INTEGER is 512
			-- Declared in Windows as SWP_NOOWNERZORDER

	Swp_nosendchanging: INTEGER is 1024
			-- Declared in Windows as SWP_NOSENDCHANGING

feature -- Window Activate Mode

	Wa_active: INTEGER is 1
			-- Activated by some method other than a mouse click (for 
			-- example, by a call to the SetActiveWindow function or by use 
			-- of the keyboard interface to select the window). 
			--
			-- Declared in Windows as WA_ACTIVE

	Wa_clickactive: INTEGER is 2
			-- Activated by a mouse click.
			--
			-- Declared in Windows as WA_CLICKACTIVE

	Wa_inactive: INTEGER is 0
			-- Deactivated.
			--
			-- Declared in Windows as WA_INACTIVE

end -- class WEL_WINDOW_CONSTANTS


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

