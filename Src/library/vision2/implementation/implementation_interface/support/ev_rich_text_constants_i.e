indexing
	description: "[
		Objects that provide access to constants for RTF documents and formatting.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RICH_TEXT_CONSTANTS_I

feature -- Access

	color_table_start: STRING is "{\colortbl ;"
		-- RTF string denoting start of color table.
		
	font_table_start: STRING is "{\rtf1\ansi\ansicpg1252\deff0\deflang1033{\fonttbl"
		-- RTF string denoting start of font table.
		
	highlight_string: STRING is "\highlight"
		-- String denoting highlighting color in RFT.
		
	color_string: STRING is "\cf"
		-- String denoting color in RTF.
		
	start_underline_string: STRING is "\ul"
		-- String denoting start of underlined in RTF.
		
	end_underline_string: STRING is "\ul0"
		-- String denoting end of underlined in RTF.
		
	start_strikeout_string: STRING is "\strike"
		-- String denoting start of striked out in RTF.
		
	end_strikeout_string: STRING is "\strike0"
		-- String denoting end of striked out in RTF.
		
	start_bold_string: STRING is "\b"
		-- String denoting start of bold in RTF.
		
	end_bold_string: STRING is "\b0"
		-- String denoting end of bold in RTF.
		
	start_italic_string: STRING is "\i"
		-- String denoting start of italic in RTF.
		
	end_italic_string: STRING is "\i0"
		-- String denoting end of italic in RTF.
		
	start_vertical_offset: STRING is "\up"
		-- String denoting start of vertical offset in RTF.
		
	font_string: STRING is "\f"
		-- String denoting font index in RTF.
		
	font_size_string: STRING is "\fs"
		-- String denoting font size in RTF.
		
	space_string: STRING is " "
		-- String denoting empty space.
		
	new_paragraph: STRING is "\pard"
		-- String denoting start of standard paragraph.
		
	paragraph_left_aligned: STRING is "\ql"
		-- String denoting start of left aligned paragraph.
		
	paragraph_center_aligned: STRING is "\qc"
		-- String denoting start of center aligned paragraph.
		
	paragraph_right_aligned: STRING is "\qr"
		-- String denoting start of right aligned paragraph.
		
	paragraph_justified: STRING is "\qj"
		-- String denoting start of justified paragraph.
		
	paragraph_left_indent: STRING is "\li"
		-- String denoting left indent of paragraph.
		
	paragraph_right_indent: STRING is "\ri"
		-- String denoting right indent of paragraph.
		
	paragraph_space_before: STRING is "\sb"
		-- String denoting space before paragraph.
		
	paragraph_space_after: STRING is "\sa"
		-- String denoting space after paragraph.
		
	rtf_newline: STRING is "\par%N"
		-- String denoting RTF newline.
		
	rtf_backslash: STRING is "\\"
		-- String denoting RTF backslash.
		
	rtf_open_brace: STRING is "\{"
		-- String denoting RTF open brace.
		
	rtf_close_brace: STRING is "\}"
		-- String denoting RTF close brace.
		
	rtf_red: STRING is "\red"
		-- String denoting red component of a RTF color.
		
	rtf_green: STRING is "\green"
		-- String denoting green component of a RTF color.
	
	rtf_blue: STRING is "\blue"
		-- String denoting blue component of a RTF color.
		
	view_text: STRING is "\viewkind4\uc1\pard"
		-- A STRING constant representing the view type of the RTF document.

	default_font: STRING is "\cf1\highlight2\f0\fs"
	
	rtf_control_character: CHARACTER is '\'
	
	rtf_open_brace_character: CHARACTER is '{'
	
	rtf_close_brace_character: CHARACTER is '}'
	
	rtf_fonttable: STRING is "fonttbl"

end -- class EV_RICH_TEXT_CONSTANTS_I
