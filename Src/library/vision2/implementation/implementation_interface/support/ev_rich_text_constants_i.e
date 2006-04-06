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

	color_table_start: STRING_32 is
		-- RTF string denoting start of color table.
		once
			Result := "{\colortbl ;"
		ensure
			not_void: Result /= Void
		end

	font_table_start: STRING_32 is
		-- RTF string denoting start of font table.
		once
			Result := "{\rtf1\ansi\ansicpg1252\deff0\deflang1033{\fonttbl"
		ensure
			not_void: Result /= Void
		end

	rtf_highlight_string: STRING_32 is
		-- String denoting highlighting color in RFT.
		once
			Result := "highlight"
		ensure
			not_void: Result /= Void
		end

	rtf_color_string: STRING_32 is
		-- String denoting color in RTF.
		once
			Result := "cf"
		ensure
			not_void: Result /= Void
		end

	rtf_unicode_string: STRING_32 is
		-- String denoting underlined in RTF.
		once
			Result := "u"
		ensure
			not_void: Result /= Void
		end

	rtf_underline_string: STRING_32 is
		-- String denoting underlined in RTF.
		once
			Result := "ul"
		ensure
			not_void: Result /= Void
		end

	rtf_underline_none_string: STRING_32 is
		-- String denoting end of underlined in RTF.
		once
			Result := "ulnone"
		ensure
			not_void: Result /= Void
		end

	rtf_strikeout_string: STRING_32 is
		-- String denoting striked out in RTF.
		once
			Result := "strike"
		ensure
			not_void: Result /= Void
		end

	rtf_bold_string: STRING_32 is
		-- String denoting bold in RTF.
		once
			Result := "b"
		ensure
			not_void: Result /= Void
		end

	rtf_italic_string: STRING_32 is
		-- String denoting italic in RTF.
		once
			Result := "i"
		ensure
			not_void: Result /= Void
		end

	rtf_vertical_offset: STRING_32 is
		-- String denoting start of vertical offset in RTF.
		once
			Result := "up"
		ensure
			not_void: Result /= Void
		end

	rtf_font_string: STRING_32 is
		-- String denoting font index in RTF.
		once
			Result := "f"
		ensure
			not_void: Result /= Void
		end

	rtf_font_size_string: STRING_32 is
		-- String denoting font size in RTF.
		once
			Result := "fs"
		ensure
			not_void: Result /= Void
		end

	space_string: STRING_32 is
		-- String denoting empty space.
		once
			Result := " "
		ensure
			not_void: Result /= Void
		end

	rtf_new_paragraph: STRING_32 is
		-- String denoting start of standard paragraph.
		once
			Result := "pard"
		ensure
			not_void: Result /= Void
		end

	rtf_paragraph_left_aligned: STRING_32 is
		-- String denoting start of left aligned paragraph.
		once
			Result := "ql"
		ensure
			not_void: Result /= Void
		end

	rtf_paragraph_center_aligned: STRING_32 is
		-- String denoting start of center aligned paragraph.
		once
			Result := "qc"
		ensure
			not_void: Result /= Void
		end

	rtf_paragraph_right_aligned: STRING_32 is
		-- String denoting start of right aligned paragraph.
		once
			Result := "qr"
		ensure
			not_void: Result /= Void
		end

	rtf_paragraph_justified: STRING_32 is
		-- String denoting start of justified paragraph.
		once
			Result := "qj"
		ensure
			not_void: Result /= Void
		end

	rtf_paragraph_left_indent: STRING_32 is
		-- String denoting left indent of paragraph.
		once
			Result := "li"
		ensure
			not_void: Result /= Void
		end

	rtf_paragraph_right_indent: STRING_32 is
		-- String denoting right indent of paragraph.
		once
			Result := "ri"
		ensure
			not_void: Result /= Void
		end

	rtf_paragraph_space_before: STRING_32 is
		-- String denoting space before paragraph.
		once
			Result := "sb"
		ensure
			not_void: Result /= Void
		end

	rtf_paragraph_space_after: STRING_32 is
		-- String denoting space after paragraph.
		once
			Result := "sa"
		ensure
			not_void: Result /= Void
		end

	rtf_family_tech: STRING_32 is

		once
			Result := "ftech"
		ensure
			not_void: Result /= Void
		end
	rtf_family_tech_int: INTEGER is 1

	rtf_family_roman: STRING_32 is

		once
			Result := "froman"
		ensure
			not_void: Result /= Void
		end
	rtf_family_roman_int: INTEGER is 2

	rtf_family_swiss: STRING_32 is

		once
			Result := "fswiss"
		ensure
			not_void: Result /= Void
		end
	rtf_family_swiss_int: INTEGER is 3

	rtf_family_script: STRING_32 is

		once
			Result := "fscript"
		ensure
			not_void: Result /= Void
		end
	rtf_family_script_int: INTEGER is 4

	rtf_family_modern: STRING_32 is

		once
			Result := "fmodern"
		ensure
			not_void: Result /= Void
		end
	rtf_family_modern_int: INTEGER is 5

	rtf_family_nill: STRING_32 is

		once
			Result := "fnill"
		ensure
			not_void: Result /= Void
		end
	rtf_family_nill_int: INTEGER is 6

	rtf_newline: STRING_32 is
		-- String denoting RTF newline.
		once
			Result := "par"
		ensure
			not_void: Result /= Void
		end

	rtf_backslash: STRING_32 is
		-- String denoting RTF backslash.
		once
			Result := "\\"
		ensure
			not_void: Result /= Void
		end

	rtf_open_brace: STRING_32 is
		-- String denoting RTF open brace.
		once
			Result := "\{"
		ensure
			not_void: Result /= Void
		end

	rtf_close_brace: STRING_32 is
		-- String denoting RTF close brace.
		once
			Result := "\}"
		ensure
			not_void: Result /= Void
		end

	rtf_unicode_character: STRING_32 is
			-- String denoting starting of a unicode character.
		once
			Result := "\u"
		ensure
			not_void: Result /= Void
		end

	rtf_red: STRING_32 is
		-- String denoting red component of a RTF color.
		once
			Result := "red"
		ensure
			not_void: Result /= Void
		end

	rtf_green: STRING_32 is
		-- String denoting green component of a RTF color.
		once
			Result := "green"
		ensure
			not_void: Result /= Void
		end

	rtf_blue: STRING_32 is
		-- String denoting blue component of a RTF color.
		once
			Result := "blue"
		ensure
			not_void: Result /= Void
		end

	view_text: STRING_32 is
		-- A STRING constant representing the view type of the RTF document.
		once
			Result := "\viewkind4\uc1\pard"
		ensure
			not_void: Result /= Void
		end

	default_font: STRING_32 is

		once
			Result := "\cf1\highlight2\f0\fs"
		ensure
			not_void: Result /= Void
		end
	rtf_control_character: CHARACTER is '\'

	rtf_open_brace_character: CHARACTER is '{'

	rtf_close_brace_character: CHARACTER is '}'

	rtf_fonttable: STRING_32 is

		once
			Result := "fonttbl"
		ensure
			not_void: Result /= Void
		end
	rtf_colortbl: STRING_32 is

		once
			Result := "colortbl"
		ensure
			not_void: Result /= Void
		end
	rtf_charset: STRING_32 is

		once
			Result := "fcharset"
		ensure
			not_void: Result /= Void
		end
	rtf_user_props: STRING_32 is

		once
			Result := "*"
		ensure
			not_void: Result /= Void
		end
	rtf_info: STRING_32 is

		once
			Result := "info"
		ensure
			not_void: Result /= Void
		end
	rtf_stylesheet: STRING_32 is

		once
			Result := "stylesheet"
		ensure
			not_void: Result /= Void
		end
	rtf_font_charset: STRING_32 is

		once
			Result := "fcharset";
		ensure
			not_void: Result /= Void
		end

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

