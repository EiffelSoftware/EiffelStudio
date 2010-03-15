note
	description	: "Window drawing constants (DT_xxxx, DI_xxxx, ...)"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_DRAWING_CONSTANTS

feature -- DrawText constants (DT_xxxx)

	Dt_top: INTEGER = 0
			-- Declared in Windows as DT_TOP

	Dt_left: INTEGER = 0
			-- Declared in Windows as DT_LEFT

	Dt_center: INTEGER = 1
			-- Declared in Windows as DT_CENTER

	Dt_right: INTEGER = 2
			-- Declared in Windows as DT_RIGHT

	Dt_vcenter: INTEGER = 4
			-- Declared in Windows as DT_VCENTER

	Dt_bottom: INTEGER = 8
			-- Declared in Windows as DT_BOTTOM

	Dt_wordbreak: INTEGER = 16
			-- Declared in Windows as DT_WORDBREAK

	Dt_singleline: INTEGER = 32
			-- Declared in Windows as DT_SINGLELINE

	Dt_expandtabs: INTEGER = 64
			-- Declared in Windows as DT_EXPANDTABS

	Dt_tabstop: INTEGER = 128
			-- Declared in Windows as DT_TABSTOP

	Dt_noclip: INTEGER = 256
			-- Declared in Windows as DT_NOCLIP

	Dt_externalleading: INTEGER = 512
			-- Declared in Windows as DT_EXTERNALLEADING

	Dt_calcrect: INTEGER = 1024
			-- Declared in Windows as DT_CALCRECT

	Dt_noprefix: INTEGER = 2048
			-- Declared in Windows as DT_NOPREFIX

	Dt_internal: INTEGER = 4096
			-- Declared in Windows as DT_INTERNAL

	Dt_hideprefix: INTEGER = 1048576
			-- Declared in Windows as DT_HIDEPREFIX

feature -- DrawImage constants (DI_xxxx)

	Di_compat: INTEGER = 4
			-- Declared in Windows as DI_COMPAT

	Di_defaultsize: INTEGER = 8
			-- Declared in Windows as DI_DEFAULTSIZE

	Di_image: INTEGER = 2
			-- Declared in Windows as DI_IMAGE

	Di_mask: INTEGER = 1
			-- Declared in Windows as DI_MASK

	Di_normal: INTEGER = 3
			-- Declared in Windows as DI_NORMAL

feature -- DrawFrameControl constants (DFC_xxxx, DFCS_xxxx)

	Dfc_button: INTEGER = 4
			-- Declared in Windows as DFC_BUTTON

	Dfc_caption: INTEGER = 1
			-- Declared in Windows as DFC_CAPTION

	Dfc_menu: INTEGER = 2
			-- Declared in Windows as DFC_MENU

	Dfc_popupmenu: INTEGER = 5
			-- Declared in Windows as DFC_POPUPMENU

	Dfc_scroll: INTEGER = 3
			-- Declared in Windows as DFC_SCROLL

	Dfcs_button3state: INTEGER = 8
			-- Declared in Windows as DFCS_BUTTON3STATE

	Dfcs_buttoncheck: INTEGER = 0
			-- Declared in Windows as DFCS_BUTTONCHECK

	Dfcs_buttonpush: INTEGER = 16
			-- Declared in Windows as DFCS_BUTTONPUSH

	Dfcs_buttonradio: INTEGER = 4
			-- Declared in Windows as DFCS_BUTTONRADIO

	Dfcs_buttonradioimage: INTEGER = 1
			-- Declared in Windows as DFCS_BUTTONRADIOIMAGE

	Dfcs_buttonradiomask: INTEGER = 2
			-- Declared in Windows as DFCS_BUTTONRADIOMASK

	Dfcs_captionclose: INTEGER = 0
			-- Declared in Windows as DFCS_CAPTIONCLOSE

	Dfcs_captionhelp: INTEGER = 4
			-- Declared in Windows as DFCS_CAPTIONHELP

	Dfcs_captionmax: INTEGER = 2
			-- Declared in Windows as DFCS_CAPTIONMAX

	Dfcs_captionmin: INTEGER = 1
			-- Declared in Windows as DFCS_CAPTIONMIN

	Dfcs_captionrestore: INTEGER = 3
			-- Declared in Windows as DFCS_CAPTIONRESTORE

	Dfcs_menuarrow: INTEGER = 0
			-- Declared in Windows as DFCS_MENUARROW

	Dfcs_menuarrowright: INTEGER = 4
			-- Declared in Windows as DFCS_MENUARROWRIGHT

	Dfcs_menubullet: INTEGER = 2
			-- Declared in Windows as DFCS_MENUBULLET

	Dfcs_menucheck: INTEGER = 1
			-- Declared in Windows as DFCS_MENUCHECK

	Dfcs_scrollcombobox: INTEGER = 5
			-- Declared in Windows as DFCS_SCROLLCOMBOBOX

	Dfcs_scrolldown: INTEGER = 1
			-- Declared in Windows as DFCS_SCROLLDOWN

	Dfcs_scrollleft: INTEGER = 2
			-- Declared in Windows as DFCS_SCROLLLEFT

	Dfcs_scrollright: INTEGER = 3
			-- Declared in Windows as DFCS_SCROLLRIGHT

	Dfcs_scrollsizegrip: INTEGER = 8
			-- Declared in Windows as DFCS_SCROLLSIZEGRIP

	Dfcs_scrollsizegripright: INTEGER = 16
			-- Declared in Windows as DFCS_SCROLLSIZEGRIPRIGHT

	Dfcs_scrollup: INTEGER = 0
			-- Declared in Windows as DFCS_SCROLLUP

	Dfcs_adjustrect: INTEGER = 8192
			-- Declared in Windows as DFCS_ADJUSTRECT

	Dfcs_checked: INTEGER = 1024
			-- Declared in Windows as DFCS_CHECKED

	Dfcs_flat: INTEGER = 16384
			-- Declared in Windows as DFCS_FLAT

	Dfcs_hot: INTEGER = 4096
			-- Declared in Windows as DFCS_HOT

	Dfcs_inactive: INTEGER = 256
			-- Declared in Windows as DFCS_INACTIVE

	Dfcs_mono: INTEGER = 32768
			-- Declared in Windows as DFCS_MONO

	Dfcs_pushed: INTEGER = 512
			-- Declared in Windows as DFCS_PUSHED

	Dfcs_transparent: INTEGER = 2048
			-- Declared in Windows as DFCS_TRANSPARENT

feature -- DrawEdge constants (BDR_xxxx, EDGE_xxxx, BF_xxxx)

	Bdr_raisedinner: INTEGER = 4
			-- Declared in Windows as BDR_RAISEDINNER

	Bdr_sunkeninner: INTEGER = 8
			-- Declared in Windows as BDR_SUNKENINNER

	Bdr_raisedouter: INTEGER = 1
			-- Declared in Windows as BDR_RAISEDOUTER

	Bdr_sunkenouter: INTEGER = 2
			-- Declared in Windows as BDR_SUNKENOUTER

	Edge_bump: INTEGER = 9
			-- Declared in Windows as EDGE_BUMP
			-- Equivalent to `Bdr_sunkeninner' | `Bdr_raisedouter'

	Edge_etched: INTEGER = 6
			-- Declared in Windows as EDGE_ETCHED
			-- Equivalent to `Bdr_sunkenouter' | `Bdr_raisedinner'

	Edge_raised: INTEGER = 5
			-- Declared in Windows as EDGE_RAISED
			-- Equivalent to `Bdr_raisedouter' | `Bdr_raisedinner'

	Edge_sunken: INTEGER = 10
			-- Declared in Windows as EDGE_SUNKEN
			-- Equivalent to `Bdr_sunkeninner' | `Bdr_sunkenouter'

	Bf_adjust: INTEGER = 8192
			-- Declared in Windows as BF_ADJUST

	Bf_bottom: INTEGER = 8
			-- Declared in Windows as BF_BOTTOM

	Bf_bottomleft: INTEGER = 9
			-- Declared in Windows as BF_BOTTOMLEFT

	Bf_bottomright: INTEGER = 12
			-- Declared in Windows as BF_BOTTOMRIGHT

	Bf_diagonal: INTEGER = 16
			-- Declared in Windows as BF_DIAGONAL

	Bf_diagonal_endbottomleft: INTEGER = 25
			-- Declared in Windows as BF_DIAGONAL_ENDBOTTOMLEFT

	Bf_diagonal_endbottomright: INTEGER = 28
			-- Declared in Windows as BF_DIAGONAL_ENDBOTTOMRIGHT

	Bf_diagonal_endtopleft: INTEGER = 19
			-- Declared in Windows as BF_DIAGONAL_ENDTOPLEFT

	Bf_diagonal_endtopright: INTEGER = 22
			-- Declared in Windows as BF_DIAGONAL_ENDTOPRIGHT

	Bf_flat: INTEGER = 16384
			-- Declared in Windows as BF_FLAT

	Bf_left: INTEGER = 1
			-- Declared in Windows as BF_LEFT

	Bf_middle: INTEGER = 2048
			-- Declared in Windows as BF_MIDDLE

	Bf_mono: INTEGER = 32768
			-- Declared in Windows as BF_MONO

	Bf_rect: INTEGER = 15
			-- Declared in Windows as BF_RECT

	Bf_right: INTEGER = 4
			-- Declared in Windows as BF_RIGHT

	Bf_soft: INTEGER = 4096
			-- Declared in Windows as BF_SOFT

	Bf_top: INTEGER = 2
			-- Declared in Windows as BF_TOP

	Bf_topleft: INTEGER = 3
			-- Declared in Windows as BF_TOPLEFT

	Bf_topright: INTEGER = 6
			-- Declared in Windows as BF_TOPRIGHT

feature -- DrawState constants (DSS_xxxx, DST_xxxx)

	Dst_bitmap: INTEGER = 4
			-- Declared in Windows as DST_BITMAP

	Dst_complex: INTEGER = 0
			-- Declared in Windows as DST_COMPLEX

	Dst_icon: INTEGER = 3
			-- Declared in Windows as DST_ICON

	Dst_prefixtext: INTEGER = 2
			-- Declared in Windows as DST_PREFIXTEXT

	Dst_text: INTEGER = 1
			-- Declared in Windows as DST_TEXT

	Dss_disabled: INTEGER = 32
			-- Declared in Windows as DSS_DISABLED

	Dss_hideprefix: INTEGER = 512
			-- Declared in Windows as DSS_HIDEPREFIX

	Dss_mono: INTEGER = 128
			-- Declared in Windows as DSS_MONO

	Dss_normal: INTEGER = 0
			-- Declared in Windows as DSS_NORMAL

	Dss_prefixonly: INTEGER = 1024
			-- Declared in Windows as DSS_PREFIXONLY

	Dss_right: INTEGER = 32768
			-- Declared in Windows as DSS_RIGHT

	Dss_union: INTEGER = 16
			-- Declared in Windows as DSS_UNION

feature -- BitBlt and MaskBlt constants

	Srccopy: INTEGER = 13369376
			-- Declared in Windows as SRCCOPY

	Srcpaint: INTEGER = 15597702
			-- Declared in Windows as SRCPAINT

	Srcand: INTEGER = 8913094
			-- Declared in Windows as SRCAND

	Srcinvert: INTEGER = 6684742
			-- Declared in Windows as SRCINVERT

	Srcerase: INTEGER = 4457256
			-- Declared in Windows as SRCERASE

	Notsrccopy: INTEGER = 3342344
			-- Declared in Windows as NOTSRCCOPY

	Notsrcerase: INTEGER = 1114278
			-- Declared in Windows as NOTSRCERASE

	Mergecopy: INTEGER = 12583114
			-- Declared in Windows as MERGECOPY

	Mergepaint: INTEGER = 12255782
			-- Declared in Windows as MERGEPAINT

	Patcopy: INTEGER = 15728673
			-- Declared in Windows as PATCOPY

	Patpaint: INTEGER = 16452105
			-- Declared in Windows as PATPAINT

	Patinvert: INTEGER = 5898313
			-- Declared in Windows as PATINVERT

	Dstinvert: INTEGER = 5570569
			-- Declared in Windows as DSTINVERT

	Blackness: INTEGER = 66
			-- Declared in Windows as BLACKNESS

	Whiteness: INTEGER = 16711778
			-- Declared in Windows as WHITENESS

	Maskpaint: INTEGER = 2229030 -- 0x220326

	R2_black: INTEGER = 1

	R2_notmergepen: INTEGER = 2

	R2_masknotpen: INTEGER = 3

	R2_notcopypen: INTEGER = 4

	R2_maskpennot: INTEGER = 5

	R2_not: INTEGER = 6

	R2_xorpen: INTEGER = 7

	R2_notmaskpen: INTEGER = 8

	R2_maskpen: INTEGER = 9

	R2_notxorpen: INTEGER = 10

	R2_nop: INTEGER = 11

	R2_mergenotpen: INTEGER = 12

	R2_copypen: INTEGER = 13

	R2_mergepennot: INTEGER = 14

	R2_mergepen: INTEGER = 15

	R2_white: INTEGER = 16

feature -- MaskBlt only constants

	Maskcopy: INTEGER
		external
			"C [macro %"wel.h%"]"
		alias
			"MAKEROP4(SRCCOPY, PATCOPY)"
		end

feature -- Status report

	valid_rop2_constant (c: INTEGER): BOOLEAN
			-- Is `c' a valid rop2 constant?
		do
			Result := c = R2_black or else
				c = R2_copypen or else
				c = R2_masknotpen or else
				c = R2_maskpen or else
				c = R2_maskpennot or else
				c = R2_mergenotpen or else
				c = R2_mergepen or else
				c = R2_mergepennot or else
				c = R2_nop or else
				c = R2_not or else
				c = R2_notcopypen or else
				c = R2_notmaskpen or else
				c = R2_notmergepen or else
				c = R2_notxorpen or else
				c = R2_white or else
				c = R2_xorpen
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




end -- class WEL_DRAWING_CONSTANTS

