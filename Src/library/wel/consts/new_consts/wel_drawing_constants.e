indexing
	description	: "Window drawing constants (DT_xxxx, DI_xxxx, ...)"
	status		: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_DRAWING_CONSTANTS

create
	default_create

feature -- DrawText constants (DT_xxxx)

	Dt_top: INTEGER is 0
			-- Declared in Windows as DT_TOP

	Dt_left: INTEGER is 0
			-- Declared in Windows as DT_LEFT

	Dt_center: INTEGER is 1
			-- Declared in Windows as DT_CENTER

	Dt_right: INTEGER is 2
			-- Declared in Windows as DT_RIGHT

	Dt_vcenter: INTEGER is 4
			-- Declared in Windows as DT_VCENTER

	Dt_bottom: INTEGER is 8
			-- Declared in Windows as DT_BOTTOM

	Dt_wordbreak: INTEGER is 16
			-- Declared in Windows as DT_WORDBREAK

	Dt_singleline: INTEGER is 32
			-- Declared in Windows as DT_SINGLELINE

	Dt_expandtabs: INTEGER is 64
			-- Declared in Windows as DT_EXPANDTABS

	Dt_tabstop: INTEGER is 128
			-- Declared in Windows as DT_TABSTOP

	Dt_noclip: INTEGER is 256
			-- Declared in Windows as DT_NOCLIP

	Dt_externalleading: INTEGER is 512
			-- Declared in Windows as DT_EXTERNALLEADING

	Dt_calcrect: INTEGER is 1024
			-- Declared in Windows as DT_CALCRECT

	Dt_noprefix: INTEGER is 2048
			-- Declared in Windows as DT_NOPREFIX

	Dt_internal: INTEGER is 4096
			-- Declared in Windows as DT_INTERNAL

	Dt_hideprefix: INTEGER is 1048576
			-- Declared in Windows as DT_HIDEPREFIX

feature -- DrawImage constants (DI_xxxx)

	Di_compat: INTEGER is 4
			-- Declared in Windows as DI_COMPAT

	Di_defaultsize: INTEGER is 8
			-- Declared in Windows as DI_DEFAULTSIZE

	Di_image: INTEGER is 2
			-- Declared in Windows as DI_IMAGE

	Di_mask: INTEGER is 1
			-- Declared in Windows as DI_MASK

	Di_normal: INTEGER is 3
			-- Declared in Windows as DI_NORMAL

feature -- DrawFrameControl constants (DFC_xxxx, DFCS_xxxx)

	Dfc_button: INTEGER is 4
			-- Declared in Windows as DFC_BUTTON

	Dfc_caption: INTEGER is 1
			-- Declared in Windows as DFC_CAPTION

	Dfc_menu: INTEGER is 2
			-- Declared in Windows as DFC_MENU

	Dfc_popupmenu: INTEGER is 5
			-- Declared in Windows as DFC_POPUPMENU

	Dfc_scroll: INTEGER is 3
			-- Declared in Windows as DFC_SCROLL

	Dfcs_button3state: INTEGER is 8
			-- Declared in Windows as DFCS_BUTTON3STATE

	Dfcs_buttoncheck: INTEGER is 0
			-- Declared in Windows as DFCS_BUTTONCHECK

	Dfcs_buttonpush: INTEGER is 16
			-- Declared in Windows as DFCS_BUTTONPUSH

	Dfcs_buttonradio: INTEGER is 4
			-- Declared in Windows as DFCS_BUTTONRADIO

	Dfcs_buttonradioimage: INTEGER is 1
			-- Declared in Windows as DFCS_BUTTONRADIOIMAGE

	Dfcs_buttonradiomask: INTEGER is 2
			-- Declared in Windows as DFCS_BUTTONRADIOMASK

	Dfcs_captionclose: INTEGER is 0
			-- Declared in Windows as DFCS_CAPTIONCLOSE

	Dfcs_captionhelp: INTEGER is 4
			-- Declared in Windows as DFCS_CAPTIONHELP

	Dfcs_captionmax: INTEGER is 2
			-- Declared in Windows as DFCS_CAPTIONMAX

	Dfcs_captionmin: INTEGER is 1
			-- Declared in Windows as DFCS_CAPTIONMIN

	Dfcs_captionrestore: INTEGER is 3
			-- Declared in Windows as DFCS_CAPTIONRESTORE

	Dfcs_menuarrow: INTEGER is 0
			-- Declared in Windows as DFCS_MENUARROW

	Dfcs_menuarrowright: INTEGER is 4
			-- Declared in Windows as DFCS_MENUARROWRIGHT

	Dfcs_menubullet: INTEGER is 2
			-- Declared in Windows as DFCS_MENUBULLET

	Dfcs_menucheck: INTEGER is 1
			-- Declared in Windows as DFCS_MENUCHECK

	Dfcs_scrollcombobox: INTEGER is 5
			-- Declared in Windows as DFCS_SCROLLCOMBOBOX

	Dfcs_scrolldown: INTEGER is 1
			-- Declared in Windows as DFCS_SCROLLDOWN

	Dfcs_scrollleft: INTEGER is 2
			-- Declared in Windows as DFCS_SCROLLLEFT

	Dfcs_scrollright: INTEGER is 3
			-- Declared in Windows as DFCS_SCROLLRIGHT

	Dfcs_scrollsizegrip: INTEGER is 8
			-- Declared in Windows as DFCS_SCROLLSIZEGRIP

	Dfcs_scrollsizegripright: INTEGER is 16
			-- Declared in Windows as DFCS_SCROLLSIZEGRIPRIGHT

	Dfcs_scrollup: INTEGER is 0
			-- Declared in Windows as DFCS_SCROLLUP

	Dfcs_adjustrect: INTEGER is 8192
			-- Declared in Windows as DFCS_ADJUSTRECT

	Dfcs_checked: INTEGER is 1024
			-- Declared in Windows as DFCS_CHECKED

	Dfcs_flat: INTEGER is 16384
			-- Declared in Windows as DFCS_FLAT

	Dfcs_hot: INTEGER is 4096
			-- Declared in Windows as DFCS_HOT

	Dfcs_inactive: INTEGER is 256
			-- Declared in Windows as DFCS_INACTIVE

	Dfcs_mono: INTEGER is 32768
			-- Declared in Windows as DFCS_MONO

	Dfcs_pushed: INTEGER is 512
			-- Declared in Windows as DFCS_PUSHED

	Dfcs_transparent: INTEGER is 2048
			-- Declared in Windows as DFCS_TRANSPARENT

feature -- DrawEdge constants (BDR_xxxx, EDGE_xxxx, BF_xxxx)

	Bdr_raisedinner: INTEGER is 4
			-- Declared in Windows as BDR_RAISEDINNER

	Bdr_sunkeninner: INTEGER is 8
			-- Declared in Windows as BDR_SUNKENINNER

	Bdr_raisedouter: INTEGER is 1
			-- Declared in Windows as BDR_RAISEDOUTER

	Bdr_sunkenouter: INTEGER is 2
			-- Declared in Windows as BDR_SUNKENOUTER

	Edge_bump: INTEGER is 9
			-- Declared in Windows as EDGE_BUMP
			-- Equivalent to `Bdr_sunkeninner' | `Bdr_raisedouter'

	Edge_etched: INTEGER is 6
			-- Declared in Windows as EDGE_ETCHED
			-- Equivalent to `Bdr_sunkenouter' | `Bdr_raisedinner'

	Edge_raised: INTEGER is 5
			-- Declared in Windows as EDGE_RAISED
			-- Equivalent to `Bdr_raisedouter' | `Bdr_raisedinner'

	Edge_sunken: INTEGER is 10
			-- Declared in Windows as EDGE_SUNKEN
			-- Equivalent to `Bdr_sunkeninner' | `Bdr_sunkenouter'

	Bf_adjust: INTEGER is 8192
			-- Declared in Windows as BF_ADJUST

	Bf_bottom: INTEGER is 8
			-- Declared in Windows as BF_BOTTOM

	Bf_bottomleft: INTEGER is 9
			-- Declared in Windows as BF_BOTTOMLEFT

	Bf_bottomright: INTEGER is 12
			-- Declared in Windows as BF_BOTTOMRIGHT

	Bf_diagonal: INTEGER is 16
			-- Declared in Windows as BF_DIAGONAL

	Bf_diagonal_endbottomleft: INTEGER is 25
			-- Declared in Windows as BF_DIAGONAL_ENDBOTTOMLEFT

	Bf_diagonal_endbottomright: INTEGER is 28
			-- Declared in Windows as BF_DIAGONAL_ENDBOTTOMRIGHT

	Bf_diagonal_endtopleft: INTEGER is 19
			-- Declared in Windows as BF_DIAGONAL_ENDTOPLEFT

	Bf_diagonal_endtopright: INTEGER is 22
			-- Declared in Windows as BF_DIAGONAL_ENDTOPRIGHT

	Bf_flat: INTEGER is 16384
			-- Declared in Windows as BF_FLAT

	Bf_left: INTEGER is 1
			-- Declared in Windows as BF_LEFT

	Bf_middle: INTEGER is 2048
			-- Declared in Windows as BF_MIDDLE

	Bf_mono: INTEGER is 32768
			-- Declared in Windows as BF_MONO

	Bf_rect: INTEGER is 15
			-- Declared in Windows as BF_RECT

	Bf_right: INTEGER is 4
			-- Declared in Windows as BF_RIGHT

	Bf_soft: INTEGER is 4096
			-- Declared in Windows as BF_SOFT

	Bf_top: INTEGER is 2
			-- Declared in Windows as BF_TOP

	Bf_topleft: INTEGER is 3
			-- Declared in Windows as BF_TOPLEFT

	Bf_topright: INTEGER is 6
			-- Declared in Windows as BF_TOPRIGHT

end -- class WEL_DRAWING_CONSTANTS


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
