note
	description: "Editor token visitor for RTF building."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PRINTER_TOKEN_VISITOR_RTF

inherit
	PRINTER_TOKEN_VISITOR
		redefine
			process_editor_token_eol
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

create {EB_PRINTER_TEXT_GENERATOR}
	make

feature {NONE} -- Initialzation

	make
			-- Initialzation
		do
			create print_color_table.make (15)
			create print_font_table.make (3)
			create text_processing.make_from_string (rtf_first_control_words)
		end

feature -- Access

	text: STRING
			-- Text genrated.
		do
				-- We don't need ISE info now.
			--process_ise_info
			create Result.make_from_string (rtf_l_brace)
				Result.append (header_string)
				Result.append (text_processing)
			Result.append (rtf_r_brace)
		end

feature {NONE} -- Visit

	process_editor_token_eol (a_tok: EDITOR_TOKEN_EOL)
		do
			text_processing.append (rtf_eol)
		end

feature {NONE} -- Implementation

	build_token_text (a_tok: EDITOR_TOKEN)
			-- Build token RTF text
		local
			l_color: EV_COLOR
			l_font: EV_FONT
		do
			if not a_tok.is_new_line and then not a_tok.wide_image.is_empty then
				l_color := a_tok.text_color
				l_font := a_tok.font
					-- Color
				text_processing.append (rtf_cf + current_color_number.out)
					-- Font
				text_processing.append (rtf_f + current_font_number.out)
					-- Size
				text_processing.append (rtf_fs + (l_font.height_in_points * 2).out)
					-- Bold?
				if l_font.weight = weight_bold or l_font.weight = weight_black then
					text_processing.append (rtf_b)
				else
					text_processing.append (rtf_b0)
				end
					-- Italian?
				if l_font.shape = shape_italic then
					text_processing.append (rtf_i)
				else
					text_processing.append (rtf_i0)
				end
					-- End control word
				text_processing.append (rtf_space)
					-- Text
				text_processing.append (rtf_escape_text (a_tok.wide_image))
			end
		end

	header_string: STRING
			-- Header string contains color and font table as RTF or definition in PostScript.
		do
			create Result.make (print_color_table.count * 5 + print_font_table.count * 10)
				-- RTF header
			Result.append (rtf_header_font_control_word)
				-- Font table
			Result.append (rtf_l_brace)
				Result.append (rtf_fonttbl)
				Result.append (font_table_string)
			Result.append (rtf_r_brace)

			Result.append (new_line)

				-- Color table
			Result.append (rtf_l_brace)
			Result.append (color_table_string)
			Result.append (rtf_r_brace)
			Result.append (new_line)

				-- Close brace should be added outside.
		ensure
			header_string_not_void: Result /= Void
		end

	text_processing: STRING
			-- Store the temporary text as part of `text'.

feature {NONE} -- String generation

	color_table_string : STRING
			-- Color table string RTF representation
		local
			l_color: EV_COLOR
		do
			create Result.make (print_color_table.count * 40)
			Result.append (rtf_colortbl)
			Result.append (rtf_space)
			from
				print_color_table.start
			until
				print_color_table.after
			loop
				l_color := print_color_table.item
				Result.append (rtf_red + l_color.red_8_bit.out)
				Result.append (rtf_green + l_color.green_8_bit.out)
				Result.append (rtf_blue + l_color.blue_8_bit.out)
				Result.append (rtf_semi_colon)
				print_color_table.forth
			end
		end

	font_table_string : STRING
			-- Font table string RTF representation
		local
			l_font: EV_FONT
		do
			create Result.make (print_font_table.count * 50)
			from
				print_font_table.start
			until
				print_font_table.after
			loop
				l_font := print_font_table.item
				Result.append (rtf_l_brace)
				Result.append (rtf_f + (print_font_table.index - 1).out)
				Result.append (rtf_font_family (l_font))
				Result.append (rtf_font_charset (l_font))
				Result.append (rtf_space)
				Result.append (rtf_font_name (l_font))
				Result.append (rtf_semi_colon)
				Result.append (rtf_r_brace)
				print_font_table.forth
			end
		end

	new_line: STRING = "%N"

feature {NONE} -- RTF Strings

	rtf_space: STRING = " "
			-- End control word

	rtf_l_brace: STRING = "{"

	rtf_r_brace: STRING = "}"

	rtf_semi_colon: STRING = ";"

	rtf_b: STRING = "\b"

	rtf_b0: STRING = "\b0"

	rtf_i: STRING = "\i"

	rtf_i0: STRING = "\i0"

	rtf_eol: STRING = "\par%N"
			-- New line

	rtf_cf: STRING = "\cf"
			-- Color

	rtf_f: STRING = "\f"
			-- Font

	rtf_fs: STRING = "\fs"
			-- Font size

	rtf_red: STRING = "\red"

	rtf_green: STRING = "\green"

	rtf_blue: STRING = "\blue"

	rtf_fonttbl: STRING = "\fonttbl"
			-- Font table control word

	rtf_colortbl: STRING = "\colortbl"
			-- Color table control word

	rtf_first_control_words: STRING = "\viewkind4\uc1"
			-- 4 is normal view, Unicode

	rtf_font_family (a_font: EV_FONT): STRING
			-- RTF font family string representation.
		require
			a_font_not_void: a_font /= Void
		do
			inspect a_font.family
			when family_roman then
				Result := rtf_family_roman
			when family_modern then
				Result := rtf_family_modern
			when family_sans then
				Result := rtf_family_swiss
			when family_screen then
				Result := rtf_family_tech
			when family_typewriter then
				Result := rtf_family_script
			else
				Result := rtf_family_nill
			end
		ensure
			rtf_font_family_not_void: Result /= Void
		end

	rtf_font_charset (a_font: EV_FONT): STRING
			--
		require
			a_font_not_void: a_font /= Void
		do
			Result := rtf_fcharset + a_font.char_set.out
		ensure
			rtf_font_charset_not_void: Result /= Void
		end

	rtf_font_name (a_font: EV_FONT): STRING
			--
		require
			a_font_not_void: a_font /= Void
		do
			Result := a_font.name
		ensure
			rtf_font_name_not_void: Result /= Void
		end

	rtf_escape_text (a_string: STRING): STRING
			--
		require
			a_string_not_void: a_string /= Void
		local
			l_string: STRING
			i: INTEGER
		do
			create l_string.make (a_string.count)
			from
				i := 1
			until
				i > a_string.count
			loop
				if a_string.item (i).code = ('{').code then
					l_string.append_string ("\{")
				elseif a_string.item (i).code = ('}').code then
					l_string.append_string ("\}")
				elseif a_string.item (i).code = ('\').code then
					l_string.append_string ("\\")
				else
					l_string.append_character (a_string.item (i))
				end
				i := i + 1
			end
			Result := l_string
		ensure
			rtf_excape_text_not_void: Result /= Void
		end

	rtf_fcharset: STRING = "\fcharset"

	rtf_family_tech: STRING = "\ftech"

	rtf_family_roman: STRING = "\froman"

	rtf_family_swiss: STRING = "\fswiss"

	rtf_family_script: STRING = "\fscript"

	rtf_family_modern: STRING = "\fmodern"

	rtf_family_nill: STRING = "\fnill"

	rtf_header_font_control_word: STRING = "\rtf1\ansi\ansicpg1252\deff0\deflang1033\deflangfe2052";

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
