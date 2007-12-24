indexing
	description: "[
		Ancestor to all errors/warnings defined in the compiler.
		
		All the nodes defined by the Eiffel compiler are descendants of COMPILER_ERROR and are using dynamic binding
		for visiting. This is why there is some code duplication between the code in COMPILER_ERROR and in ERROR_TRACER
		for the display routines defined in COMPILER_ERROR.
		
		When a complete redesign of the error handling is done in the compiler, this code duplication should disappear.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COMPILER_ERROR

inherit
	USER_DEFINED_ERROR

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

feature {ERROR_TRACER} -- Formatting

	build_explain (a_text_formatter: TEXT_FORMATTER) is
			-- Build specific explanation image for current error
			-- in `error_window'.
		require
			valid_st: a_text_formatter /= Void
		deferred
		end

feature -- Output

	trace (a_text_formatter: TEXT_FORMATTER) is
			-- Display full error message in `a_text_formatter'.
		require
			valid_st: a_text_formatter /= Void;
			is_defined: is_defined
		do
			print_error_message (a_text_formatter);
			build_explain (a_text_formatter);
		end;

	trace_single_line (a_text_formatter: TEXT_FORMATTER) is
			-- Display short error, single line message in `a_text_formatter'.
		require
			valid_st: a_text_formatter /= Void;
			is_defined: is_defined
		do
			print_single_line_error_code (a_text_formatter)
			print_single_line_error_message (a_text_formatter)
		end

	trace_primary_context (a_text_formatter: TEXT_FORMATTER) is
			-- Build the primary context string so errors can be navigated to
		require
			valid_st: a_text_formatter /= Void
		do
			if has_associated_file then
				a_text_formatter.add_string (file_name)
			end
		end

feature {NONE} -- Printing for single lines

	print_single_line_error_code (a_text_formatter: TEXT_FORMATTER)
			-- Display a short error code in `a_text_formatter'.
		require
			valid_st: a_text_formatter /= Void
		do
			a_text_formatter.add_error (Current, code)
			if subcode /= 0 then
				a_text_formatter.add ("(")
				a_text_formatter.add_int (subcode)
				a_text_formatter.add ("):")
			else
				a_text_formatter.add (":")
			end
			a_text_formatter.add_space
		end

	print_single_line_error_message (a_text_formatter: TEXT_FORMATTER) is
			-- Displays single line help in `a_text_formatter'.
		require
			valid_st: a_text_formatter /= Void
		local
			l_path: STRING;
			l_file_name: FILE_NAME;
			l_file: PLAIN_TEXT_FILE;
			l_text, l_line: STRING
			l_stop: BOOLEAN
			i: INTEGER
		do
			create l_file_name.make_from_string (eiffel_layout.error_path);
			l_file_name.extend ("short");
			l_file_name.set_file_name (help_file_name);
			l_path := l_file_name.string
			if subcode /= 0 then
				l_path.append_integer (subcode)
			end;
			create l_file.make (l_path);
			if l_file.exists then
				create l_text.make (255)
				from
					l_file.open_read
				until
					l_file.end_of_file or l_stop
				loop
					l_file.read_line;
					l_line := l_file.last_string
					l_stop := not l_text.is_empty and then not l_line.is_empty and then not l_line.item (1).is_space
					if not l_stop then
						l_line.prune_all_leading (' ')
						l_line.prune_all_trailing (' ')
						if not l_text.is_empty then
							l_text.append_character (' ')
						end
						l_text.append (l_line)
					end
				end
				l_file.close

					-- Remove error part
				i := l_text.index_of (':', 1)
				if i > 0 then
					l_text.keep_tail (l_text.count - i)
				end
				l_text.prune_all_leading (' ')
				l_text.prune_all_trailing (' ')
				if not l_text.is_empty then
					if l_text.item (l_text.count) /= '.' and then l_text.item (l_text.count).is_alpha_numeric then
							-- Append missing punctuation
						l_text.append_character ('.')
					end
					if l_text.item (1).is_alpha then
							-- Change initial character to upper case
						l_text.put (l_text.item (1).as_upper, 1)
					end
				end
			end

			if l_text = Void or else l_text.is_empty then
				l_text := once "Unable to retrieve error help information."
			end

			a_text_formatter.add (l_text)
		end

feature {NONE} -- Print for multiple lines

	print_error_message (a_text_formatter: TEXT_FORMATTER) is
			-- Display error in `a_text_formatter'.
		require
			valid_st: a_text_formatter /= Void
		do
			a_text_formatter.add (Error_string);
			a_text_formatter.add (" code: ");
			a_text_formatter.add_error (Current, code);
			if subcode /= 0 then
				a_text_formatter.add ("(");
				a_text_formatter.add_int (subcode);
				a_text_formatter.add (")");
				a_text_formatter.add_new_line
			else
				a_text_formatter.add_new_line;
			end;
			print_short_help (a_text_formatter);
		end;

	frozen print_short_help (a_text_formatter: TEXT_FORMATTER) is
			-- Display help in `a_text_formatter'.
		require
			valid_st: a_text_formatter /= Void
		local
			l_file_name: STRING;
			f_name: FILE_NAME;
			file: PLAIN_TEXT_FILE;
		do
			create f_name.make_from_string (eiffel_layout.error_path);
			f_name.extend ("short");
			f_name.set_file_name (help_file_name);
			l_file_name := f_name
			if subcode /= 0 then
				l_file_name.append_integer (subcode)
			end;
			create file.make (l_file_name);
			if file.exists then
				from
					file.open_read;
				until
					file.end_of_file
				loop
					file.read_line;
					a_text_formatter.add (file.last_string.twin)
					a_text_formatter.add_new_line;
				end;
				file.close;
			else
				a_text_formatter.add_new_line;
				a_text_formatter.add ("No help available for this error");
				a_text_formatter.add_new_line;
				a_text_formatter.add ("(cannot read file: ");
				a_text_formatter.add (l_file_name);
				a_text_formatter.add (")");
				a_text_formatter.add_new_line;
				a_text_formatter.add_new_line;
				a_text_formatter.add ("An error message should always be available.");
				a_text_formatter.add_new_line;
				a_text_formatter.add ("Please contact ISE.");
				a_text_formatter.add_new_line;
				a_text_formatter.add_new_line
			end;
		end;

feature {NONE} -- Implementation

	frozen print_context_of_error (a_context_class: CLASS_C; a_text_formatter: TEXT_FORMATTER) is
			-- Display the line number in `a_text_formatter'.
		require
			valid_line: line > 0
			st_not_void: a_text_formatter /= Void
			a_context_class_not_void: a_context_class /= Void
		do
			initialize_output
			a_text_formatter.add ("Line: ")
			a_text_formatter.add (line.out)
			if a_context_class.lace_class.config_class.has_modification_date_changed then
				a_text_formatter.add (" (source code has changed)")
				a_text_formatter.add_new_line
			elseif not has_source_text then
				a_text_formatter.add (" (source code is not available)")
				a_text_formatter.add_new_line
			elseif line > 0 then
				a_text_formatter.add_new_line
				a_text_formatter.add ("  ")
				if previous_line /= Void then
					if not previous_line.is_empty then
						previous_line.replace_substring_all ("%T", "  ")
					end
					a_text_formatter.add (previous_line)
					a_text_formatter.add_new_line
				end
				a_text_formatter.add ("->")
				if not current_line.is_empty then
					current_line.replace_substring_all ("%T", "  ")
				end
				a_text_formatter.add (current_line)
				a_text_formatter.add_new_line
				if next_line /= Void then
					a_text_formatter.add ("  ")
					if not next_line.is_empty then
						next_line.replace_substring_all ("%T", "  ")
					end
					a_text_formatter.add (next_line)
					a_text_formatter.add_new_line
				end
			end
		end

feature {NONE} -- Output

	display_line (a_text_formatter: TEXT_FORMATTER; a_line: STRING) is
			-- Display `a_line' in `a_text_formatter'. It translates `%T' accordingly to `a_text_formatter' specification
			-- which is to call `add_indent'.
		require
			st_not_void: a_text_formatter /= Void
		local
			i: INTEGER
			nb: INTEGER
			c: CHARACTER
		do
			if a_line /= Void then
				from
					nb := a_line.count
				until
					i = nb
				loop
					i := i + 1
					c := a_line.item (i)
					if c = '%T' then
						a_text_formatter.add (" ")
						a_text_formatter.add (" ")
						a_text_formatter.add (" ")
						a_text_formatter.add (" ")
					else
						a_text_formatter.add (c.out)
					end
				end
				a_text_formatter.add_new_line
			end
		end

	display_syntax_line (a_text_formatter: TEXT_FORMATTER; a_line: STRING) is
			-- Display `a_line' which does like `display_line' but with an additional
			-- arrowed line that points out to `column' where syntax issue is located.
		require
			st_not_void: a_text_formatter /= Void
			a_line_not_void: a_line /= Void
		local
			i, nb: INTEGER
			c: CHARACTER
			position, nb_tab: INTEGER
		do
			from
				nb := a_line.count
			until
				i = nb
			loop
				i := i + 1
				c := a_line.item (i)
				if c = '%T' then
					a_text_formatter.add (" ")
					a_text_formatter.add (" ")
					a_text_formatter.add (" ")
					a_text_formatter.add (" ")
					if i <= column then
						nb_tab := nb_tab + 1
					end
				else
					a_text_formatter.add (c.out)
				end
			end
			a_text_formatter.add_new_line
			if column > 0 then
				position := (column - 1) + 3 * nb_tab
			else
				position := 3 * nb_tab
			end
			if position = 0 then
				a_text_formatter.add ("^---------------------------")
				a_text_formatter.add_new_line
			else
				from
					i := 1
				until
					i > position
				loop
					a_text_formatter.add ("-")
					i := i + 1
				end
				a_text_formatter.add ("^")
				a_text_formatter.add_new_line
			end
		end

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
