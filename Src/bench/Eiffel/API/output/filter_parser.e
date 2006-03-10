indexing

	description:
		"Parser of file descriptions which allow generation of%
		%specific formats (troff, mif, TEX, PostScript) for%
		%output of clickable, short, flat and flat-short."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class FILTER_PARSER

feature {NONE} -- Formats

	format_table: HASH_TABLE [CELL2 [STRING, STRING], STRING];
			-- User-specified formats

	escape_characters: ARRAY [STRING];
			-- User-specified escape characters

	read_formats (filename: STRING) is
			-- Parse `filename' and fill `format_table' with
			-- the user-specified format.
		require
			filename_not_void: filename /= Void;
			not_filename_empty: not filename.is_empty
		local
			construct, before, after: STRING;
			construct_list: LINKED_LIST [STRING];
			in_construct, in_before: BOOLEAN;
			new_format: CELL2 [STRING, STRING];
			normal_format: BOOLEAN;
			escape_char: CHARACTER;
			escape: STRING
		do
			create filter_file.make (filename);
			if filter_file.exists and then filter_file.is_readable then
				filter_file.open_read;
				if filter_file.readable then
					from
						line_nb := 1
					until
						filter_file.end_of_file
					loop
						from
							in_construct := true;
							in_before := false;
							create construct.make (10);
							create construct_list.make;
							before := Void;
							after := Void;
							get_next_character
						until
							read_error or else
							(is_last_meta and then last_char_read = '%N')
						loop
							if in_construct then
								if not is_last_meta then
									construct.extend (last_char_read)
 								elseif last_char_read = ',' then
									construct_list.extend (construct);
										-- synoymn constructs i.e c1, c2
									create construct.make (0)
 								elseif last_char_read = '|' then
									in_construct := false;
									in_before := true;
									create before.make (5)
								else
									syntax_error ("%"|%" expected");
									read_error := true
								end
							elseif in_before then
								if not is_last_meta then
									before.extend (last_char_read)
 								elseif last_char_read = '*' then
									in_before := false;
									create after.make (5)
								else
									syntax_error ("%"*%" expected");
									read_error := true
								end
							else
								if not is_last_meta then
									after.extend (last_char_read)
								else
									syntax_error ("End of line expected");
									read_error := true
								end
							end;
							if not read_error then
								get_next_character
							end
						end;
						if not read_error then
							construct_list.extend (construct);
							from
								construct_list.start
							until
								construct_list.after
							loop
								construct := construct_list.item;
								normal_format := true;
								construct.left_adjust;
								if construct.count >= 7 then
									escape := construct.substring (1, 6);
									escape.to_lower;
									if escape.is_equal ("escape") then
										normal_format := false;
										if before /= Void and after = Void then
											escape_char :=
												construct.item (construct.count);
											construct.right_adjust;
											if construct.count > 6 then
												escape_char :=
													construct.item (construct.count)
											end;
											escape_characters.put (before, escape_char.code)
										else
											syntax_error
													("Escape character expected")
										end
									end
								end;
								if normal_format then
									construct.right_adjust;
									construct.to_lower;
									if
										not construct.is_empty and then
										before /= Void
									then
										create new_format.make (before, after);
										format_table.force (new_format, construct)
debug ("FILTERS")
	io.error.put_string (construct);
	io.error.put_string (" -> ");
	io.error.put_string (before);
	if after /= Void then
		io.error.put_string (" @ ");
		io.error.put_string (after)
	end;
	io.error.put_new_line
end
									elseif construct.is_empty and before /= Void then
										syntax_error ("Construct expected")
									elseif
										not construct.is_empty and before = Void
									then
										syntax_error ("Appearance expected")
									end
								end;
								construct_list.forth
							end
						else
								-- Go to the beginning of the next line
							read_error := false;
							char_in_buffer := false;
							filter_file.read_line;
							line_nb := line_nb + 1
						end
					end;
				end;
				filter_file.close
			else
				io.error.put_string ("Warning: Cannot read filter ");
				io.error.put_string (filename);
				io.error.put_new_line
			end
		end;

	get_next_character is
			-- Go forth one position in the filter file.
			-- Interprete special characters. Put the
			-- read character in last_char_read.
		do
			is_last_meta := false;
			if not char_in_buffer then
				filter_file.read_character
			else
				char_in_buffer := false
			end;
			if not filter_file.end_of_file then
				inspect filter_file.last_character
				when '%%' then
					filter_file.read_character;
					if filter_file.end_of_file then
						syntax_error ("End of line expected");
						read_error := true
					else
						inspect filter_file.last_character
						when 'n', 'N' then
							last_char_read := '%N'
						when 't', 'T' then
							last_char_read := '%T'
						when '%N' then
							line_nb := line_nb + 1;
							from
								filter_file.read_character
							until
								filter_file.end_of_file or else
								(filter_file.last_character /= ' ' and
								filter_file.last_character /= '%T')
							loop
								filter_file.read_character
							end;
							if
								filter_file.end_of_file or else
								filter_file.last_character /= '%%'
							then
								syntax_error ("%"%%%" expected");
								read_error := true;
								if
									not filter_file.end_of_file and then
									filter_file.last_character = '%N'
								then
									line_nb := line_nb + 1
								end
							else
								get_next_character
							end
						else
							last_char_read := filter_file.last_character
						end
					end
				when ',', '|', '*' then
					last_char_read := filter_file.last_character;
					is_last_meta := true
				when '%N' then
					last_char_read := filter_file.last_character;
					is_last_meta := true;
					line_nb := line_nb + 1
				when '-' then
					filter_file.read_character;
					if not filter_file.end_of_file then
						if filter_file.last_character = '-' then
								-- This is a comment. Skip the end of the line.
							filter_file.read_line;
							line_nb := line_nb + 1;
							last_char_read := '%N';
							is_last_meta := true
						else
							char_in_buffer := true;
							last_char_read := '-'
						end
					else
						last_char_read := '-'
					end
				else
					last_char_read := filter_file.last_character
				end
			else
				last_char_read := '%N';
				is_last_meta := true
			end
		end;

	filter_file: PLAIN_TEXT_FILE;
			-- File containing the filter specifications

	last_char_read: CHARACTER;
			-- Last character read

	read_error: BOOLEAN;
			-- Did an error occurred during the line parsing?

	char_in_buffer: BOOLEAN;
			-- Has `filter_file.last_character' been used yet?

	is_last_meta: BOOLEAN;
			-- Is last character read a meta character?

	line_nb: INTEGER;
			-- Number of the line currently parsed

	syntax_error (message: STRING) is
			-- Display a warning message.
		require
			message_not_void: message /= Void
		do
			io.error.put_string ("Warning: filter ");
			io.error.put_string (filter_file.name);
			io.error.put_string ("%N%TSyntax error, line ");
			if last_char_read = '%N' then
				io.error.put_integer (line_nb - 1);
				io.error.put_string (" near ");
				io.error.put_string ("End of line")
			else
				io.error.put_integer (line_nb);
				io.error.put_string (" near ");
				io.error.put_character ('%"');
				io.error.put_character (last_char_read);
				io.error.put_character ('%"')
			end;
			io.error.put_string (": ");
			io.error.put_string (message);
			io.error.put_new_line
		end;

invariant

	format_table_not_void: format_table /= Void;
	escape_characters_not_void:  escape_characters /= Void
	escape_characters_capacity_valid: escape_characters.capacity > {CHARACTER}.max_value

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class FILTER_PARSER
