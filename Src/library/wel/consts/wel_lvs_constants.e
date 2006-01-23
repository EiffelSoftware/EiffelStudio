indexing
	description	: "List view style (LVS) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_LVS_CONSTANTS

obsolete
	"use WEL_LIST_VIEW_CONSTANTS instead"

feature -- Style

	Lvs_alignleft: INTEGER is 2048
			-- Declared in Windows as LVS_ALIGNLEFT

	Lvs_aligntop: INTEGER is 0
			-- Declared in Windows as LVS_ALIGNTOP

	Lvs_autoarrange: INTEGER is 256
			-- Declared in Windows as LVS_AUTOARRANGE

	Lvs_editlabels: INTEGER is 512
			-- Declared in Windows as LVS_EDITLABELS

	Lvs_icon: INTEGER is 0
			-- Declared in Windows as LVS_ICON

	Lvs_list: INTEGER is 3
			-- Declared in Windows as LVS_LIST

	Lvs_nocolumnheader: INTEGER is 16384
			-- Declared in Windows as LVS_NOCOLUMNHEADER

	Lvs_nolabelwrap: INTEGER is 128
			-- Declared in Windows as LVS_NOLABELWRAP

	Lvs_noscroll: INTEGER is 8192
			-- Declared in Windows as LVS_NOSCROLL

	Lvs_ownerdrawfixed: INTEGER is 1024
			-- Declared in Windows as LVS_OWNERDRAWFIXED

	Lvs_report: INTEGER is 1
			-- Declared in Windows as LVS_REPORT

	Lvs_shareimagelists: INTEGER is 64
			-- Declared in Windows as LVS_SHAREIMAGELISTS

	Lvs_showselalways: INTEGER is 8
			-- Declared in Windows as LVS_SHOWSELALWAYS

	Lvs_singlesel: INTEGER is 4
			-- Declared in Windows as LVS_SINGLESEL

	Lvs_smallicon: INTEGER is 2
			-- Declared in Windows as LVS_SMALLICON

	Lvs_sortascending: INTEGER is 16
			-- Declared in Windows as LVS_SORTASCENDING

	Lvs_sortdescending: INTEGER is 32;
			-- Declared in Windows as LVS_SORTDESCENDING

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




end -- class WEL_LVS_CONSTANTS

