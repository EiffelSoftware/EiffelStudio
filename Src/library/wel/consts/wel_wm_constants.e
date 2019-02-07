note
	description: "Window message (WM) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_WM_CONSTANTS

feature -- Access

	Wm_null: INTEGER = 0
			-- Declared in Windows as WM_NULL

	Wm_create: INTEGER = 1
			-- Declared in Windows as WM_CREATE

	Wm_destroy: INTEGER = 2
			-- Declared in Windows as WM_DESTROY

	Wm_move: INTEGER = 3
			-- Declared in Windows as WM_MOVE

	Wm_size: INTEGER = 5
			-- Declared in Windows as WM_SIZE

	Wm_activate: INTEGER = 6
			-- Declared in Windows as WM_ACTIVATE

	Wm_setfocus: INTEGER = 7
			-- Declared in Windows as WM_SETFOCUS

	Wm_killfocus: INTEGER = 8
			-- Declared in Windows as WM_KILLFOCUS

	Wm_enable: INTEGER = 10
			-- Declared in Windows as WM_ENABLE

	Wm_setredraw: INTEGER = 11
			-- Declared in Windows as WM_SETREDRAW

	Wm_settext: INTEGER = 12
			-- Declared in Windows as WM_SETTEXT

	Wm_gettext: INTEGER = 13
			-- Declared in Windows as WM_GETTEXT

	Wm_gettextlength: INTEGER = 14
			-- Declared in Windows as WM_GETTEXTLENGTH

	Wm_paint: INTEGER = 15
			-- Declared in Windows as WM_PAINT

	Wm_close: INTEGER = 16
			-- Declared in Windows as WM_CLOSE

	Wm_queryendsession: INTEGER = 17
			-- Declared in Windows as WM_QUERYENDSESSION

	Wm_quit: INTEGER = 18
			-- Declared in Windows as WM_QUIT

	Wm_queryopen: INTEGER = 19
			-- Declared in Windows as WM_QUERYOPEN

	Wm_erasebkgnd: INTEGER = 20
			-- Declared in Windows as WM_ERASEBKGND

	Wm_syscolorchange: INTEGER = 21
			-- Declared in Windows as WM_SYSCOLORCHANGE

	Wm_endsession: INTEGER = 22
			-- Declared in Windows as WM_ENDSESSION

	Wm_showwindow: INTEGER = 24
			-- Declared in Windows as WM_SHOWWINDOW

	Wm_wininichange, Wm_settingchange: INTEGER = 26
			-- Declared in Windows as WM_WININICHANGE

	Wm_devmodechange: INTEGER = 27
			-- Declared in Windows as WM_DEVMODECHANGE

	Wm_activateapp: INTEGER = 28
			-- Declared in Windows as WM_ACTIVATEAPP

	Wm_fontchange: INTEGER = 29
			-- Declared in Windows as WM_FONTCHANGE

	Wm_timechange: INTEGER = 30
			-- Declared in Windows as WM_TIMECHANGE

	Wm_cancelmode: INTEGER = 31
			-- Declared in Windows as WM_CANCELMODE

	Wm_setcursor: INTEGER = 32
			-- Declared in Windows as WM_SETCURSOR

	Wm_mouseactivate: INTEGER = 33
			-- Declared in Windows as WM_MOUSEACTIVATE

	Wm_childactivate: INTEGER = 34
			-- Declared in Windows as WM_CHILDACTIVATE

	Wm_queuesync: INTEGER = 35
			-- Declared in Windows as WM_QUEUESYNC

	Wm_getminmaxinfo: INTEGER = 36
			-- Declared in Windows as WM_GETMINMAXINFO

	Wm_painticon: INTEGER = 38
			-- Declared in Windows as WM_PAINTICON

	Wm_iconerasebkgnd: INTEGER = 39
			-- Declared in Windows as WM_ICONERASEBKGND

	Wm_nextdlgctl: INTEGER = 40
			-- Declared in Windows as WM_NEXTDLGCTL

	Wm_spoolerstatus: INTEGER = 42
			-- Declared in Windows as WM_SPOOLERSTATUS

	Wm_drawitem: INTEGER = 43
			-- Declared in Windows as WM_DRAWITEM

	Wm_measureitem: INTEGER = 44
			-- Declared in Windows as WM_MEASUREITEM

	Wm_deleteitem: INTEGER = 45
			-- Declared in Windows as WM_DELETEITEM

	Wm_vkeytoitem: INTEGER = 46
			-- Declared in Windows as WM_VKEYTOITEM

	Wm_chartoitem: INTEGER = 47
			-- Declared in Windows as WM_CHARTOITEM

	Wm_setfont: INTEGER = 48
			-- Declared in Windows as WM_SETFONT

	Wm_getfont: INTEGER = 49
			-- Declared in Windows as WM_GETFONT

	Wm_sethotkey: INTEGER = 50
			-- Declared in Windows as WM_SETHOTKEY

	Wm_gethotkey: INTEGER = 51
			-- Declared in Windows as WM_GETHOTKEY

	Wm_querydragicon: INTEGER = 55
			-- Declared in Windows as WM_QUERYDRAGICON

	Wm_compareitem: INTEGER = 57
			-- Declared in Windows as WM_COMPAREITEM

	Wm_getobject: INTEGER = 61
			-- Declared in Windows as WM_GETOBJECT

	Wm_compacting: INTEGER = 65
			-- Declared in Windows as WM_COMPACTING

	Wm_commnotify: INTEGER = 68
			-- Declared in Windows as WM_COMMNOTIFY

	Wm_windowposchanging: INTEGER = 70
			-- Declared in Windows as WM_WINDOWPOSCHANGING

	Wm_windowposchanged: INTEGER = 71
			-- Declared in Windows as WM_WINDOWPOSCHANGED

	Wm_power: INTEGER = 72
			-- Declared in Windows as WM_POWER

	Wm_copydata: INTEGER = 74
			-- Declared in Windows as WM_COPYDATA

	Wm_canceljournal: INTEGER = 75
			-- Declared in Windows as WM_CANCELJOURNAL

	Wm_notify: INTEGER = 78
			-- Declared in Windows as WM_NOTIFY

	Wm_inputlangchangerequest: INTEGER = 80
			-- Declared in Windows as WM_INPUTLANGCHANGEREQUEST

	Wm_inputlangchange: INTEGER = 81
			-- Declared in Windows as WM_INPUTLANGCHANGE

	Wm_tcard: INTEGER = 82
			-- Declared in Windows as WM_TCARD

	Wm_help: INTEGER = 83
			-- Declared in Windows as WM_HELP

	Wm_userchanged: INTEGER = 84
			-- Declared in Windows as WM_USERCHANGED

	Wm_notifyformat: INTEGER = 85
			-- Declared in Windows as WM_NOTIFYFORMAT

	Wm_contextmenu: INTEGER = 123
			-- Declared in Windows as WM_CONTEXTMENU

	Wm_stylechanging: INTEGER = 124
			-- Declared in Windows as WM_STYLECHANGING

	Wm_stylechanged: INTEGER = 125
			-- Declared in Windows as WM_STYLECHANGED

	Wm_displaychange: INTEGER = 126
			-- Declared in Windows as WM_DISPLAYCHANGE

	Wm_geticon: INTEGER = 127
			-- Declared in Windows as WM_GETICON

	Wm_seticon: INTEGER = 128
			-- Declared in Windows as WM_SETICON

	Wm_nccreate: INTEGER = 129
			-- Declared in Windows as WM_NCCREATE

	Wm_ncdestroy: INTEGER = 130
			-- Declared in Windows as WM_NCDESTROY

	Wm_nccalcsize: INTEGER = 131
			-- Declared in Windows as WM_NCCALCSIZE

	Wm_nchittest: INTEGER = 132
			-- Declared in Windows as WM_NCHITTEST

	Wm_ncpaint: INTEGER = 133
			-- Declared in Windows as WM_NCPAINT

	Wm_ncactivate: INTEGER = 134
			-- Declared in Windows as WM_NCACTIVATE

	Wm_getdlgcode: INTEGER = 135
			-- Declared in Windows as WM_GETDLGCODE

	Wm_syncpaint: INTEGER = 136
			-- Declared in Windows as WM_SYNCPAINT

	Wm_ncmousemove: INTEGER = 160
			-- Declared in Windows as WM_NCMOUSEMOVE

	Wm_nclbuttondown: INTEGER = 161
			-- Declared in Windows as WM_NCLBUTTONDOWN

	Wm_nclbuttonup: INTEGER = 162
			-- Declared in Windows as WM_NCLBUTTONUP

	Wm_nclbuttondblclk: INTEGER = 163
			-- Declared in Windows as WM_NCLBUTTONDBLCLK

	Wm_ncrbuttondown: INTEGER = 164
			-- Declared in Windows as WM_NCRBUTTONDOWN

	Wm_ncrbuttonup: INTEGER = 165
			-- Declared in Windows as WM_NCRBUTTONUP

	Wm_ncrbuttondblclk: INTEGER = 166
			-- Declared in Windows as WM_NCRBUTTONDBLCLK

	Wm_ncmbuttondown: INTEGER = 167
			-- Declared in Windows as WM_NCMBUTTONDOWN

	Wm_ncmbuttonup: INTEGER = 168
			-- Declared in Windows as WM_NCMBUTTONUP

	Wm_ncmbuttondblclk: INTEGER = 169
			-- Declared in Windows as WM_NCMBUTTONDBLCLK

	Wm_ncxbuttondown: INTEGER = 171
			-- Declared in Windows as WM_NCXBUTTONDOWN

	Wm_ncxbuttonup: INTEGER = 172
			-- Declared in Windows as WM_NCXBUTTONUP

	Wm_ncxbuttondblclk: INTEGER = 173
			-- Declared in Windows as WM_NCXBUTTONDBLCLK

	Wm_keydown: INTEGER = 256
			-- Declared in Windows as WM_KEYDOWN

	Wm_keyfirst: INTEGER = 256
			-- Declared in Windows as WM_KEYFIRST

	Wm_keyup: INTEGER = 257
			-- Declared in Windows as WM_KEYUP

	Wm_char: INTEGER = 258
			-- Declared in Windows as WM_CHAR

	Wm_deadchar: INTEGER = 259
			-- Declared in Windows as WM_DEADCHAR

	Wm_syskeydown: INTEGER = 260
			-- Declared in Windows as WM_SYSKEYDOWN

	Wm_syskeyup: INTEGER = 261
			-- Declared in Windows as WM_SYSKEYUP

	Wm_syschar: INTEGER = 262
			-- Declared in Windows as WM_SYSCHAR

	Wm_sysdeadchar: INTEGER = 263
			-- Declared in Windows as WM_SYSDEADCHAR

	Wm_keylast: INTEGER
			-- Declared in Windows as WM_KEYLAST
		external
			"C [macro <winuser.h>]"
		alias
			"WM_KEYLAST"
		end

	Wm_ime_startcomposition: INTEGER = 269
			-- Declared in Windows as WM_IME_STARTCOMPOSITION

	Wm_ime_endcomposition: INTEGER = 270
			-- Declared in Windows as WM_IME_ENDCOMPOSITION

	Wm_ime_composition: INTEGER = 271
			-- Declared in Windows as WM_IME_COMPOSITION

	Wm_ime_keylast: INTEGER
			-- Declared in Windows as WM_IME_KEYLAST
		external
			"C [macro <winuser.h>]"
		alias
			"WM_IME_KEYLAST"
		end

	Wm_initdialog: INTEGER = 272
			-- Declared in Windows as WM_INITDIALOG

	Wm_command: INTEGER = 273
			-- Declared in Windows as WM_COMMAND

	Wm_syscommand: INTEGER = 274
			-- Declared in Windows as WM_SYSCOMMAND

	Wm_timer: INTEGER = 275
			-- Declared in Windows as WM_TIMER

	Wm_hscroll: INTEGER = 276
			-- Declared in Windows as WM_HSCROLL

	Wm_vscroll: INTEGER = 277
			-- Declared in Windows as WM_VSCROLL

	Wm_initmenu: INTEGER = 278
			-- Declared in Windows as WM_INITMENU

	Wm_initmenupopup: INTEGER = 279
			-- Declared in Windows as WM_INITMENUPOPUP

	Wm_menuselect: INTEGER = 287
			-- Declared in Windows as WM_MENUSELECT

	Wm_menuchar: INTEGER = 288
			-- Declared in Windows as WM_MENUCHAR

	Wm_enteridle: INTEGER = 289
			-- Declared in Windows as WM_ENTERIDLE

	Wm_menurbuttonup: INTEGER = 290
			-- Declared in Windows as WM_MENURBUTTONUP

	Wm_menudrag: INTEGER = 291
			-- Declared in Windows as WM_MENUDRAG

	Wm_menugetobject: INTEGER = 292
			-- Declared in Windows as WM_MENUGETOBJECT

	Wm_uninitmenupopup: INTEGER = 293
			-- Declared in Windows as WM_UNINITMENUPOPUP

	Wm_menucommand: INTEGER = 294
			-- Declared in Windows as WM_MENUCOMMAND

	Wm_changeuistate: INTEGER = 295
			-- Declared in Windows as WM_CHANGEUISTATE

	Wm_updateuistate: INTEGER = 296
			-- Declared in Windows as WM_UPDATEUISTATE

	Wm_queryuistate: INTEGER = 297
			-- Declared in Windows as WM_QUERYUISTATE

	Wm_ctlcolordialog: INTEGER = 310
			-- Declared in Windows as WM_CTLCOLORDIALOG

	Wm_mousemove: INTEGER = 512
			-- Declared in Windows as WM_MOUSEMOVE

	Wm_mousefirst: INTEGER = 512
			-- Declared in Windows as WM_MOUSEFIRST

	Wm_lbuttondown: INTEGER = 513
			-- Declared in Windows as WM_LBUTTONDOWN

	Wm_lbuttonup: INTEGER = 514
			-- Declared in Windows as WM_LBUTTONUP

	Wm_lbuttondblclk: INTEGER = 515
			-- Declared in Windows as WM_LBUTTONDBLCLK

	Wm_rbuttondown: INTEGER = 516
			-- Declared in Windows as WM_RBUTTONDOWN

	Wm_rbuttonup: INTEGER = 517
			-- Declared in Windows as WM_RBUTTONUP

	Wm_rbuttondblclk: INTEGER = 518
			-- Declared in Windows as WM_RBUTTONDBLCLK

	Wm_mbuttondown: INTEGER = 519
			-- Declared in Windows as WM_MBUTTONDOWN

	Wm_mbuttonup: INTEGER = 520
			-- Declared in Windows as WM_MBUTTONUP

	Wm_mbuttondblclk: INTEGER = 521
			-- Declared in Windows as WM_MBUTTONDBLCLK

	Wm_mousewheel: INTEGER = 522
			-- Declared in Windows as WM_MOUSEWHEEL

	Wm_xbuttondown: INTEGER = 523
			-- Declared in Windows as WM_XBUTTONDOWN

	Wm_xbuttonup: INTEGER = 524
			-- Declared in Windows as WM_XBUTTONUP

	Wm_xbuttondblclk: INTEGER = 525
			-- Declared in Windows as WM_XBUTTONDBLCLK

	Wm_mouselast: INTEGER
			-- Declared in Windows as WM_MOUSELAST
		external
			"C [macro <winuser.h>]"
		alias
			"WM_MOUSELAST"
		end

	Wm_parentnotify: INTEGER = 528
			-- Declared in Windows as WM_PARENTNOTIFY

	Wm_entermenuloop: INTEGER = 529
			-- Declared in Windows as WM_ENTERMENULOOP

	Wm_exitmenuloop: INTEGER = 530
			-- Declared in Windows as WM_EXITMENULOOP

	Wm_nextmenu: INTEGER = 531
			-- Declared in Windows as WM_NEXTMENU

	Wm_sizing: INTEGER = 532
			-- Declared in Windows as WM_SIZING

	Wm_capturechanged: INTEGER = 533
			-- Declared in Windows as WM_CAPTURECHANGED

	Wm_moving: INTEGER = 534
			-- Declared in Windows as WM_MOVING

	Wm_powerbroadcast: INTEGER = 536
			-- Declared in Windows as WM_POWERBROADCAST

	Wm_devicechange: INTEGER = 537
			-- Declared in Windows as WM_DEVICECHANGE

	Wm_mdicreate: INTEGER = 544
			-- Declared in Windows as WM_MDICREATE

	Wm_mdidestroy: INTEGER = 545
			-- Declared in Windows as WM_MDIDESTROY

	Wm_mdiactivate: INTEGER = 546
			-- Declared in Windows as WM_MDIACTIVATE

	Wm_mdirestore: INTEGER = 547
			-- Declared in Windows as WM_MDIRESTORE

	Wm_mdinext: INTEGER = 548
			-- Declared in Windows as WM_MDINEXT

	Wm_mdimaximize: INTEGER = 549
			-- Declared in Windows as WM_MDIMAXIMIZE

	Wm_mditile: INTEGER = 550
			-- Declared in Windows as WM_MDITILE

	Wm_mdicascade: INTEGER = 551
			-- Declared in Windows as WM_MDICASCADE

	Wm_mdiiconarrange: INTEGER = 552
			-- Declared in Windows as WM_MDIICONARRANGE

	Wm_mdigetactive: INTEGER = 553
			-- Declared in Windows as WM_MDIGETACTIVE

	Wm_mdisetmenu: INTEGER = 560
			-- Declared in Windows as WM_MDISETMENU

	Wm_entersizemove: INTEGER = 561
			-- Declared in Windows as WM_ENTERSIZEMOVE

	Wm_exitsizemove: INTEGER = 562
			-- Declared in Windows as WM_EXITSIZEMOVE

	Wm_dropfiles: INTEGER = 563
			-- Declared in Windows as WM_DROPFILES

	Wm_mdirefreshmenu: INTEGER = 564
			-- Declared in Windows as WM_MDIREFRESHMENU

	Wm_ime_setcontext: INTEGER = 641
			-- Declared in Windows as WM_IME_SETCONTEXT

	Wm_ime_notify: INTEGER = 642
			-- Declared in Windows as WM_IME_NOTIFY

	Wm_ime_control: INTEGER = 643
			-- Declared in Windows as WM_IME_CONTROL

	Wm_ime_compositionfull: INTEGER = 644
			-- Declared in Windows as WM_IME_COMPOSITIONFULL

	Wm_ime_select: INTEGER = 645
			-- Declared in Windows as WM_IME_SELECT

	Wm_ime_char: INTEGER = 646
			-- Declared in Windows as WM_IME_CHAR

	Wm_ime_request: INTEGER = 648
			-- Declared in Windows as WM_IME_REQUEST

	Wm_ime_keydown: INTEGER = 656
			-- Declared in Windows as WM_IME_KEYDOWN

	Wm_ime_keyup: INTEGER = 657
			-- Declared in Windows as WM_IME_KEYUP

	Wm_ncmousehover: INTEGER = 672
			-- Require Windows98, Windows NT 5.0 or later
			-- Declared in Windows as WM_NCMOUSEHOVER

	Wm_mousehover: INTEGER = 673
			-- Require Windows98, Windows NT 4.0 or later
			-- Declared in Windows as WM_MOUSEHOVER

	Wm_ncmouseleave: INTEGER = 674
			-- Require Windows98, Windows NT 5.0 or later
			-- Declared in Windows as WM_NCMOUSELEAVE

	Wm_mouseleave: INTEGER = 675
			-- Require Windows98, Windows NT 4.0 or later
			-- Declared in Windows as WM_MOUSELEAVE

	Wm_cut: INTEGER = 768
			-- Declared in Windows as WM_CUT

	Wm_copy: INTEGER = 769
			-- Declared in Windows as WM_COPY

	Wm_paste: INTEGER = 770
			-- Declared in Windows as WM_PASTE

	Wm_clear: INTEGER = 771
			-- Declared in Windows as WM_CLEAR

	Wm_undo: INTEGER = 772
			-- Declared in Windows as WM_UNDO

	Wm_renderformat: INTEGER = 773
			-- Declared in Windows as WM_RENDERFORMAT

	Wm_renderallformats: INTEGER = 774
			-- Declared in Windows as WM_RENDERALLFORMATS

	Wm_destroyclipboard: INTEGER = 775
			-- Declared in Windows as WM_DESTROYCLIPBOARD

	Wm_drawclipboard: INTEGER = 776
			-- Declared in Windows as WM_DRAWCLIPBOARD

	Wm_paintclipboard: INTEGER = 777
			-- Declared in Windows as WM_PAINTCLIPBOARD

	Wm_sizeclipboard: INTEGER = 779
			-- Declared in Windows as WM_SIZECLIPBOARD

	Wm_vscrollclipboard: INTEGER = 778
			-- Declared in Windows as WM_VSCROLLCLIPBOARD

	Wm_hscrollclipboard: INTEGER = 782
			-- Declared in Windows as WM_HSCROLLCLIPBOARD

	Wm_askcbformatname: INTEGER = 780
			-- Declared in Windows as WM_ASKCBFORMATNAME

	Wm_changecbchain: INTEGER = 781
			-- Declared in Windows as WM_CHANGECBCHAIN

	Wm_querynewpalette: INTEGER = 783
			-- Declared in Windows as WM_QUERYNEWPALETTE

	Wm_paletteischanging: INTEGER = 784
			-- Declared in Windows as WM_PALETTEISCHANGING

	Wm_palettechanged: INTEGER = 785
			-- Declared in Windows as WM_PALETTECHANGED

	Wm_hotkey: INTEGER = 786
			-- Declared in Windows as WM_HOTKEY

	Wm_print: INTEGER = 791
			-- Declared in Windows as WM_PRINT

	Wm_printclient: INTEGER = 792
			-- Declared in Windows as WM_PRINTCLIENT

	Wm_appcommand: INTEGER = 793
			-- Declared in Windows as WM_APPCOMMAND

	Wm_themechanged: INTEGER = 794
			-- Declared in Windows as WM_THEMECHANGED

	Wm_handheldfirst: INTEGER = 856
			-- Declared in Windows as WM_HANDHELDFIRST

	Wm_handheldlast: INTEGER = 863
			-- Declared in Windows as WM_HANDHELDLAST

	Wm_afxfirst: INTEGER = 864
			-- Declared in Windows as WM_AFXFIRST

	Wm_afxlast: INTEGER = 895
			-- Declared in Windows as WM_AFXLAST

	Wm_penwinfirst: INTEGER = 896
			-- Declared in Windows as WM_PENWINFIRST

	Wm_penwinlast: INTEGER = 911
			-- Declared in Windows as WM_PENWINLAST

	Wm_app: INTEGER = 32768
			-- Declared in Windows as WM_APP

	Wm_user: INTEGER = 1024;
			-- Declared in Windows as WM_USER


	Wm_dpichanged: INTEGER = 736
			-- Declared in Windows as WM_DPICHANGED
note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class WEL_WM_CONSTANTS

