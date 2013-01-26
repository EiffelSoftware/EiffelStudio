note
	description: "[
		Objects that provide access to constants for RTF documents and formatting.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RICH_TEXT_CONSTANTS_I

feature -- Access

	color_table_start: STRING_32 = "{\colortbl ;"
		-- RTF string denoting start of color table.

	font_table_start: STRING_32 = "{\rtf1\ansi\ansicpg1252\uc1\deff0\deflang1033{\fonttbl"
		-- RTF string denoting start of font table.

	rtf_highlight_string: STRING_32 = "highlight"
		-- String denoting highlighting color in RFT.

	rtf_color_string: STRING_32 = "cf"
		-- String denoting color in RTF.

	rtf_unicode_string: STRING_32 = "u"
		-- String denoting underlined in RTF.

	rtf_underline_string: STRING_32 = "ul"
		-- String denoting underlined in RTF.

	rtf_underline_none_string: STRING_32 = "ulnone"
		-- String denoting end of underlined in RTF.

	rtf_strikeout_string: STRING_32 = "strike"
		-- String denoting striked out in RTF.

	rtf_bold_string: STRING_32 = "b"
		-- String denoting bold in RTF.

	rtf_italic_string: STRING_32 = "i"
		-- String denoting italic in RTF.

	rtf_vertical_offset: STRING_32 = "up"
		-- String denoting start of vertical offset in RTF.

	rtf_font_string: STRING_32 = "f"
		-- String denoting font index in RTF.

	rtf_font_size_string: STRING_32 = "fs"
		-- String denoting font size in RTF.

	space_string: STRING_32 = " "
		-- String denoting empty space.

	rtf_new_paragraph: STRING_32 = "pard"
		-- String denoting start of standard paragraph.

	rtf_paragraph_left_aligned: STRING_32 = "ql"
		-- String denoting start of left aligned paragraph.

	rtf_paragraph_center_aligned: STRING_32 = "qc"
		-- String denoting start of center aligned paragraph.

	rtf_paragraph_right_aligned: STRING_32 = "qr"
		-- String denoting start of right aligned paragraph.

	rtf_paragraph_justified: STRING_32 = "qj"
		-- String denoting start of justified paragraph.

	rtf_paragraph_left_indent: STRING_32 = "li"
		-- String denoting left indent of paragraph.

	rtf_paragraph_right_indent: STRING_32 = "ri"
		-- String denoting right indent of paragraph.

	rtf_paragraph_space_before: STRING_32 = "sb"
		-- String denoting space before paragraph.

	rtf_paragraph_space_after: STRING_32 = "sa"
		-- String denoting space after paragraph.

	rtf_family_tech: STRING_32 = "ftech"

	rtf_family_tech_int: INTEGER = 1

	rtf_family_roman: STRING_32 = "froman"

	rtf_family_roman_int: INTEGER = 2

	rtf_family_swiss: STRING_32 = "fswiss"

	rtf_family_swiss_int: INTEGER = 3

	rtf_family_script: STRING_32 = "fscript"

	rtf_family_script_int: INTEGER = 4

	rtf_family_modern: STRING_32 = "fmodern"

	rtf_family_modern_int: INTEGER = 5

	rtf_family_nill: STRING_32 = "fnill"

	rtf_family_nill_int: INTEGER = 6

	rtf_newline: STRING_32 = "par"
		-- String denoting RTF newline.

	rtf_backslash: STRING_32 = "\\"
		-- String denoting RTF backslash.

	rtf_open_brace: STRING_32 = "\{"
		-- String denoting RTF open brace.

	rtf_close_brace: STRING_32 = "\}"
		-- String denoting RTF close brace.

	rtf_unicode_character: STRING_32 = "\u"
			-- String denoting starting of a Unicode character.

	rtf_red: STRING_32 = "red"
		-- String denoting red component of a RTF color.

	rtf_green: STRING_32 = "green"
		-- String denoting green component of a RTF color.

	rtf_blue: STRING_32 = "blue"
		-- String denoting blue component of a RTF color.

	view_text: STRING_32 = "\viewkind4\uc1\pard"
		-- A STRING constant representing the view type of the RTF document.

	default_font: STRING_32 = "\cf1\highlight2\f0\fs"

	rtf_control_character: CHARACTER = '\'

	rtf_open_brace_character: CHARACTER = '{'

	rtf_close_brace_character: CHARACTER = '}'

	rtf_fonttable: STRING_32 = "fonttbl"

	rtf_colortbl: STRING_32 = "colortbl"

	rtf_charset: STRING_32 = "fcharset"

	rtf_user_props: STRING_32 = "*"

	rtf_info: STRING_32 = "info"

	rtf_stylesheet: STRING_32 = "stylesheet"

	rtf_font_charset: STRING_32 = "fcharset";


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




end -- class EV_RICH_TEXT_CONSTANTS_I

