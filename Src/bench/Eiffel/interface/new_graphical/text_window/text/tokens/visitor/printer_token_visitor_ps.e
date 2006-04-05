indexing
	description: "Editor token visitor for PostScript building."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PRINTER_TOKEN_VISITOR_PS

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

	make is
			-- Initialzation
		do
			create print_color_table.make (max_color_id + 1)
			create print_font_table.make (max_font_id + 1)
			create current_line.make (200)
			create text_processing.make (5000)
		end

feature -- Access

	text: STRING is
			-- Text genrated.
		do
			if not current_line.is_empty then
				process_editor_token_eol (create {EDITOR_TOKEN_EOL}.make)
			end
			Result :=	header +
						new_line + new_line +
						page_definition +
						new_line +
						color_table_string +
						new_line +
						font_table_string +
						new_line +
						ps_routines_definition +
						new_line + new_line +
						ps_end_prolog +
						new_line + new_line +
						ps_moveto_start + new_line +
						text_processing +
						new_line +
						ps_showpage
		end

feature {NONE} -- Visit

	process_editor_token_eol (a_tok: EDITOR_TOKEN_EOL) is
		do
			text_processing.append (current_line_height.max (a_tok.font.height).out)
			text_processing.append (ps_space)
			text_processing.append (ps_new_line + new_line)
			text_processing.append (current_line)
			current_line.clear_all
			current_line_height := 0
			current_line_width := 0
		end

feature {NONE} -- Implementation

	build_token_text (a_tok: EDITOR_TOKEN) is
			-- Build RTF text for `a_tok'
		local
			l_color: EV_COLOR
			l_font: EV_FONT
		do
			if not a_tok.image.is_empty then
				l_color := a_tok.text_color
				l_font := a_tok.font
					-- |Fixme: A line may exceed the margin.
--				current_line_width := current_line_width + l_font.string_width (a_tok.image)
--				if current_line_width > max_line_width then
--					process_editor_token_eol (create {EDITOR_TOKEN_EOL}.make)
--				else
					current_line_height := l_font.height.max (current_line_height)
					current_line.append (color_string + current_color_number.out + ps_space + font_string + current_font_number.out + ps_space)
					current_line.append (ps_print_next_line + new_line)
					current_line.append (a_tok.image + new_line)
--				end
			end
		end

	current_line: STRING
			-- Buffer string of line to print

	current_line_height: INTEGER
			-- Line height of current line
			-- The largest height of font in `currrent_line'

	current_line_width: INTEGER
			-- Buffer of current line width.

	color_string: STRING is "color"

	font_string: STRING is "font"

	bold_string : STRING is "Bold"

	italic_string: STRING is "Italic"

	process_ise_info is
			-- Process ISE generation information.
		do
			from
				ise_info_lines.start
			until
				ise_info_lines.after
			loop
				from
					ise_info_lines.item.start
				until
					ise_info_lines.item.after
				loop
					ise_info_lines.item.item.process (Current)
					ise_info_lines.item.forth
				end
				ise_info_lines.forth
			end
		end

	text_processing: STRING
			-- Store the temporary text as part of `text'.

feature {NONE} -- Post Script generation

	color_table_string : STRING is
			-- Color table string RTF representation
		local
			l_color: EV_COLOR
		do
			create Result.make (print_color_table.count * 50)
			from
				print_color_table.start
			until
				print_color_table.after
			loop
				l_color := print_color_table.item
				Result.append (ps_routine_character)
				Result.append (color_string)
				Result.append ((print_color_table.index - 1).out)
				Result.append (ps_space)
				Result.append (ps_l_brace)
				Result.append (l_color.red.out + ps_space + l_color.green.out + ps_space + l_color.blue.out + ps_space)
				Result.append (ps_setrgbcolor)
				Result.append (ps_r_brace)
				Result.append (ps_space)
				Result.append (ps_def)
				Result.append (new_line)
				print_color_table.forth
			end
		end

	font_table_string : STRING is
			-- Font table string RTF representation
		local
			l_font: EV_FONT
			l_font_name: STRING
			l_dashed: BOOLEAN
		do
			create Result.make (print_font_table.count * 70)
			from
				print_font_table.start
			until
				print_font_table.after
			loop
				l_dashed := False
				l_font := print_font_table.item
				l_font_name := l_font.name.twin
				l_font_name.replace_substring_all (" ", ps_dash)
				Result.append (ps_routine_character)
				Result.append (font_string)
				Result.append ((print_font_table.index - 1).out)
				Result.append (ps_space)
				Result.append (ps_l_brace)
				Result.append (ps_routine_character + l_font_name)
				if l_font.weight = weight_bold or l_font.weight = weight_black then
					Result.append (ps_dash + bold_string)
					l_dashed := True
				end
				if l_font.shape = shape_italic then
					if not l_dashed then
						Result.append (ps_dash)
					end
					Result.append (italic_string)
				end
				Result.append (ps_space + ps_findfont)
				Result.append (ps_space + l_font.height_in_points.out + ps_space + ps_scalefont)
				Result.append (ps_space + ps_setfont)
				Result.append (ps_r_brace + ps_space)
				Result.append (ps_def)
				Result.append (new_line)
				print_font_table.forth
			end
		end

	new_line: STRING is "%N"

	header :STRING is "%%!PS-Adobe-1.0"
			-- Header of PostScript.

	left_margin: INTEGER is 1
			-- Inch

	right_margin: INTEGER is 8
			-- Inch

	top_margin: INTEGER is 10
			-- Inch

	bottom_margin: INTEGER is 1
			-- Inch

	max_line_width: INTEGER is
			-- Points
		once
			Result := (right_margin - left_margin) * points_per_inch
		end

	points_per_inch: INTEGER is 72

	page_definition: STRING is
			-- Page definition string.
			-- |Fixme: Page demetion should be set according to device demention.
		once
			Result := "/inch {" + points_per_inch.out + " mul} def" + new_line	+
			"/leftmargin " + left_margin.out + " inch def" + new_line +
			"/rightmargin " + right_margin.out + " inch def" + new_line +
			"/bottommargin " + bottom_margin.out + " inch def" + new_line +
			"/topmargin " + top_margin.out + " inch def" + new_line +
			"/tablength 4 def"
		end

	ps_moveto_start: STRING is "leftmargin topmargin moveto"

	ps_findfont: STRING is "findfont"

	ps_setfont: STRING is "setfont"

	ps_setrgbcolor: STRING is "setrgbcolor"

	ps_scalefont: STRING is "scalefont"

	ps_print_next_line: STRING is "print_next_line"

	ps_new_line: STRING is "new_line"

	ps_end_prolog: STRING is "%%%%EndProlog"

	ps_showpage: STRING is "showpage"

	ps_space: STRING is " "

	ps_routine_character: STRING is "/"

	ps_l_brace: STRING is "{"

	ps_r_brace: STRING is "}"

	ps_def: STRING is "def"

	ps_dash: STRING is "-"

	ps_routines_definition: STRING is
		"[
		/new_line {
			currentpoint exch pop exch sub
			dup bottommargin lt
				{pop newpage}
				{leftmargin exch moveto}
			ifelse
		}def
		/newpage {
			showpage leftmargin topmargin moveto
		} def
		/append { % string char => string
			/char exch def
			/oldstring exch def
			/newstring oldstring length 1 add string def
			newstring 0 oldstring putinterval
			newstring dup dup length 1 sub char put
		} def
		/print_next_line {
			/word () def
			{	currentfile read not
					{exit}
				if
				/char2 exch def
				char2 13 ne char2 10 ne char2 12 ne and and	% New Line character
					{	char2 32 eq char2 9 eq or			 % Tab or Space
							{	word length 0 ne
									{word print_word
									/word () def}
								if
								char2 32 eq
									{( ) show}
									{print_tab}
								ifelse
							}
							{/word word char2 append def}
						ifelse
					}
					{
						word print_word
						/word () def
						exit
					}
				ifelse
			} loop
		} def
		/print_word { % string => -
			/theword exch def
			theword stringwidth pop currentpoint pop add rightmargin gt
				{
					rightmargin leftmargin sub theword stringwidth pop lt
						{theword print_character}
						{new_line theword show}
					ifelse
				}
				{theword show}
			ifelse
		} def
		/print_character { % print the string character by character
			{
				() exch append
				dup stringwidth pop currentpoint pop add
				rightmargin gt
					{new_line}
				if
				show
			} forall
		} def
		/print_tab { % - => -
				% Move to the next tabulation mark
			( ) dup 0 110 put		% char (110) = 'n'
			stringwidth pop tablength mul dup
			currentpoint pop leftmargin sub dup
			4 -1 roll div
				% patch: remove errors due to computation
				% imprecisions (0.99999 instead of 1.0)
			1 tablength div 3 div add
			floor 1 add
			3 -1 roll mul exch sub 0 rmoveto
		} def
		]";

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end
