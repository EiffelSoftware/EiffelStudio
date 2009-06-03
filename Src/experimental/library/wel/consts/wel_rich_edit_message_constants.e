note
	description: "Rich edit messages."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_RICH_EDIT_MESSAGE_CONSTANTS

feature -- Access

	Em_getcharformat: INTEGER = 1082
			-- Declared in Windows as EM_GETCHARFORMAT

	Em_getparaformat: INTEGER = 1085
			-- Declared in Windows as EM_GETPARAFORMAT

	Em_setbkgndcolor: INTEGER = 1091
			-- Declared in Windows as EM_SETBKGNDCOLOR

	Em_setcharformat: INTEGER = 1092
			-- Declared in Windows as EM_SETCHARFORMAT

	Em_seteventmask: INTEGER = 1093
			-- Declared in Windows as EM_SETEVENTMASK

	Em_setparaformat: INTEGER = 1095
			-- Declared in Windows as EM_SETPARAFORMAT

	Em_charfrompos: INTEGER = 215
			-- Declared in Windows as EM_CHARFROMPOS

	Em_exgetsel: INTEGER = 1076
			-- Declared in Windows as EM_EXGETSEL

	Em_exsetsel: INTEGER = 1079
			-- Declared in Windows as EM_EXSETSEL

	Em_hideselection: INTEGER = 1087
			-- Declared in Windows as EM_HIDESELECTION

	Em_posfromchar: INTEGER = 214
			-- Declared in Windows as EM_POSFROMCHAR

	Em_selectiontype: INTEGER = 1090
			-- Declared in Windows as EM_SELECTIONTYPE

	En_selchange: INTEGER = 1794
			-- Declared in Windows as EN_SELCHANGE

	Em_exlimittext: INTEGER = 1077
			-- Declared in Windows as EM_EXLIMITTEXT

	Em_findtext: INTEGER = 1080
			-- Declared in Windows as EM_FINDTEXT

	Em_findtextex: INTEGER = 1103
			-- Declared in Windows as EM_FINDTEXTEX

	Em_getseltext: INTEGER = 1086
			-- Declared in Windows as EM_GETSELTEXT

	Em_gettextrange: INTEGER = 1099
			-- Declared in Windows as EM_GETTEXTRANGE

	Em_setlimittext: INTEGER = 197
			-- Declared in Windows as EM_SETLIMITTEXT

	Em_exlinefromchar: INTEGER = 1078
			-- Declared in Windows as EM_EXLINEFROMCHAR

	Em_findwordbreak: INTEGER = 1100
			-- Declared in Windows as EM_FINDWORDBREAK

	Em_getwordbreakprocex: INTEGER = 1104
			-- Declared in Windows as EM_GETWORDBREAKPROCEX

	Em_setwordbreakprocex: INTEGER = 1105
			-- Declared in Windows as EM_SETWORDBREAKPROCEX

	Em_canpaste: INTEGER = 1074
			-- Declared in Windows as EM_CANPASTE

	Em_pastespecial: INTEGER = 1088
			-- Declared in Windows as EM_PASTESPECIAL

	Em_streamin: INTEGER = 1097
			-- Declared in Windows as EM_STREAMIN

	Em_streamout: INTEGER = 1098
			-- Declared in Windows as EM_STREAMOUT

	Em_displayband: INTEGER = 1075
			-- Declared in Windows as EM_DISPLAYBAND

	Em_formatrange: INTEGER = 1081
			-- Declared in Windows as EM_FORMATRANGE

	Em_settargetdevice: INTEGER = 1096
			-- Declared in Windows as EM_SETTARGETDEVICE

	Em_requestresize: INTEGER = 1089
			-- Declared in Windows as EM_REQUESTRESIZE

	Em_geteventmask: INTEGER = 1083
			-- Declared in Windows as EM_GETEVENTMASK

	Em_getimecolor: INTEGER = 1129
			-- Declared in Windows as EM_GETIMECOLOR

	Em_getimeoptions: INTEGER = 1131
			-- Declared in Windows as EM_GETIMEOPTIONS

	Em_getoptions: INTEGER = 1102
			-- Declared in Windows as EM_GETOPTIONS

	Em_getpunctuation: INTEGER = 1125
			-- Declared in Windows as EM_GETPUNCTUATION

	Em_getwordwrapmode: INTEGER = 1127
			-- Declared in Windows as EM_GETWORDWRAPMODE

	Em_setimecolor: INTEGER = 1128
			-- Declared in Windows as EM_SETIMECOLOR

	Em_setimeoptions: INTEGER = 1130
			-- Declared in Windows as EM_SETIMEOPTIONS

	Em_setoptions: INTEGER = 1101
			-- Declared in Windows as EM_SETOPTIONS

	Em_setpunctuation: INTEGER = 1124
			-- Declared in Windows as EM_SETPUNCTUATION

	Em_setwordwrapmode: INTEGER = 1126;
			-- Declared in Windows as EM_SETWORDWRAPMODE

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




end -- class WEL_RICH_EDIT_MESSAGE_CONSTANTS

