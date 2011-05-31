note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	HTML_TABLE_CONSTANTS

feature

	Table_start: STRING = "<TABLE"
	Table_end  : STRING = "</TABLE>"

	Caption_start: STRING = "<CAPTION"
	Caption_end  : STRING = "</CAPTION>"

	Colspan: STRING = " COLSPAN="
	Rowspan: STRING = " ROWSPAN="
	Border : STRING = " BORDER="

	Col_start: STRING = "<TD"
	Col_end  : STRING = "</TD>"

	Row_start: STRING = "<TR"
	Row_end  : STRING = "</TR>"

	Tag_start: STRING = "<"
	Tag_end  : STRING = ">"

	NewLine: STRING = "%N"

	Top   : STRING = "TOP"
	Bottom: STRING = "BOTTOM"
	Left  : STRING = "LEFT"
	Right : STRING = "RIGHT"
	Center: STRING = "CENTER"

	Width : STRING = " WIDTH="
	Align : STRING = " ALIGN="
	Valign: STRING = " VALIGN="
	NoWrap: STRING = " NOWRAP"

	BgColor   : STRING = " BGCOLOR="
	BackGround: STRING = " BACKGROUND="
	BorderColor     : STRING = " BORDERCOLOR="
	BorderColorLight: STRING = " BORDERCOLORLIGHT="
	BorderColorDark : STRING = " BORDERCOLORDARK=";

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




end -- class HTML_TABLE_CONSTANTS

