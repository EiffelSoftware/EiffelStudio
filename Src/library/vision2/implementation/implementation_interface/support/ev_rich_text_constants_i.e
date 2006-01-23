indexing
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

	color_table_start: STRING is "{\colortbl ;"
		-- RTF string denoting start of color table.
		
	font_table_start: STRING is "{\rtf1\ansi\ansicpg1252\deff0\deflang1033{\fonttbl"
		-- RTF string denoting start of font table.
		
	rtf_highlight_string: STRING is "highlight"
		-- String denoting highlighting color in RFT.
		
	rtf_color_string: STRING is "cf"
		-- String denoting color in RTF.
		
	rtf_underline_string: STRING is "ul"
		-- String denoting underlined in RTF.
		
	rtf_underline_none_string: STRING is "ulnone"
		-- String denoting end of underlined in RTF.
		
	rtf_strikeout_string: STRING is "strike"
		-- String denoting striked out in RTF.
		
	rtf_bold_string: STRING is "b"
		-- String denoting bold in RTF.
		
	rtf_italic_string: STRING is "i"
		-- String denoting italic in RTF.

	rtf_vertical_offset: STRING is "up"
		-- String denoting start of vertical offset in RTF.
		
	rtf_font_string: STRING is "f"
		-- String denoting font index in RTF.
		
	rtf_font_size_string: STRING is "fs"
		-- String denoting font size in RTF.
		
	space_string: STRING is " "
		-- String denoting empty space.
		
	rtf_new_paragraph: STRING is "pard"
		-- String denoting start of standard paragraph.
		
	rtf_paragraph_left_aligned: STRING is "ql"
		-- String denoting start of left aligned paragraph.
		
	rtf_paragraph_center_aligned: STRING is "qc"
		-- String denoting start of center aligned paragraph.
		
	rtf_paragraph_right_aligned: STRING is "qr"
		-- String denoting start of right aligned paragraph.
		
	rtf_paragraph_justified: STRING is "qj"
		-- String denoting start of justified paragraph.
		
	rtf_paragraph_left_indent: STRING is "li"
		-- String denoting left indent of paragraph.
		
	rtf_paragraph_right_indent: STRING is "ri"
		-- String denoting right indent of paragraph.
		
	rtf_paragraph_space_before: STRING is "sb"
		-- String denoting space before paragraph.
		
	rtf_paragraph_space_after: STRING is "sa"
		-- String denoting space after paragraph.
		
	rtf_family_tech: STRING is "ftech"
	
	rtf_family_tech_int: INTEGER is 1
	
	rtf_family_roman: STRING is "froman"
	
	rtf_family_roman_int: INTEGER is 2
	
	rtf_family_swiss: STRING is "fswiss"
	
	rtf_family_swiss_int: INTEGER is 3
	
	rtf_family_script: STRING is "fscript"
	
	rtf_family_script_int: INTEGER is 4
	
	rtf_family_modern: STRING is "fmodern"
	
	rtf_family_modern_int: INTEGER is 5
	
	rtf_family_nill: STRING is "fnill"
	
	rtf_family_nill_int: INTEGER is 6
		
	rtf_newline: STRING is "par"
		-- String denoting RTF newline.
		
	rtf_backslash: STRING is "\\"
		-- String denoting RTF backslash.
		
	rtf_open_brace: STRING is "\{"
		-- String denoting RTF open brace.
		
	rtf_close_brace: STRING is "\}"
		-- String denoting RTF close brace.
		
	rtf_red: STRING is "red"
		-- String denoting red component of a RTF color.
		
	rtf_green: STRING is "green"
		-- String denoting green component of a RTF color.
	
	rtf_blue: STRING is "blue"
		-- String denoting blue component of a RTF color.
		
	view_text: STRING is "\viewkind4\uc1\pard"
		-- A STRING constant representing the view type of the RTF document.

	default_font: STRING is "\cf1\highlight2\f0\fs"
	
	rtf_control_character: CHARACTER is '\'
	
	rtf_open_brace_character: CHARACTER is '{'
	
	rtf_close_brace_character: CHARACTER is '}'
	
	rtf_fonttable: STRING is "fonttbl"
	
	rtf_colortbl: STRING is "colortbl"
	
	rtf_charset: STRING is "fcharset"

	rtf_user_props: STRING is "*"
	
	rtf_info: STRING is "info"
	
	rtf_stylesheet: STRING is "stylesheet"

	rtf_font_charset: STRING is "fcharset";
	

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




end -- class EV_RICH_TEXT_CONSTANTS_I

