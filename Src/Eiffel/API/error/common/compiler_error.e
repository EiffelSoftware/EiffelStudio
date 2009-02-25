note
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

feature {NONE} -- Access

	help_text: attached LIST [STRING]
			-- Full help text loaded from disk.
		local
			l_cache: like help_text_cache
			l_file_name: STRING;
			l_file_path: FILE_NAME;
			l_user_file_path: FILE_NAME
			l_file: PLAIN_TEXT_FILE;
			l_line: STRING
			l_result: detachable ARRAYED_LIST [STRING]
		do
			l_file_name := help_file_name
			l_cache := help_text_cache
			l_result := l_cache.item (l_file_name)
			if attached l_result then
				Result := l_result
			else
					-- No data has been cached, load the text from disk.
				if subcode /= 0 then
					l_file_name.append_integer (subcode)
				end

				create l_file_path.make_from_string (eiffel_layout.error_path.string);
				l_file_path.extend ("short");
				l_file_path.set_file_name (l_file_name);
				l_user_file_path := eiffel_layout.user_priority_file_name (l_file_path, True)
				if attached l_user_file_path then
					l_file_path := l_user_file_path
				end

				create l_file.make (l_file_path.string)
				if l_file.exists then
					create l_result.make (10)
					from l_file.open_read until l_file.end_of_file loop
						l_file.read_line;
						l_line := l_file.last_string
						if attached l_line then
							l_result.extend (create {STRING_8}.make_from_string (l_line))
						end
					end
					l_file.close

						-- Remove empty-last lines
					from l_result.finish until l_result.before or else not l_result.item.is_empty loop
						l_result.remove
						l_result.finish
					end
				else
					create l_result.make (0)
				end

				Result := l_result
				l_cache.put (l_result, l_file_name)
			end
		ensure
			help_text_cache_has_help_file_name: help_text_cache.has (help_file_name)
			result_is_consistent: Result = help_text
		end

	single_line_help_text: attached STRING
			-- Help text for single line error messages.
		local
			l_cache: like single_line_help_text_cache
			l_file_name: STRING
			l_help_text: like help_text
			l_line: STRING
			l_text: STRING
			l_stop: BOOLEAN
			l_result: detachable STRING
			i: INTEGER
		do
			l_file_name := help_file_name
			l_cache := single_line_help_text_cache
			l_result := l_cache.item (l_file_name)
			if attached l_result then
				Result := l_result
			else
				l_help_text := help_text
				if not l_help_text.is_empty then
					create l_text.make (150)
					from l_help_text.start until l_help_text.after or l_stop loop
						l_line := l_help_text.item
						l_stop := not l_text.is_empty and then not l_line.is_empty and then not l_line.item (1).is_space
						if not l_stop then
							l_line := l_line.twin
							l_line.right_adjust
							l_line.left_adjust
							if not l_text.is_empty then
								l_text.append_character (' ')
							end
							l_text.append (l_line)
						end
						l_help_text.forth
					end

						-- Remove error part
					i := l_text.index_of (':', 1)
					if i > 0 then
						l_text.keep_tail (l_text.count - i)
					end
					l_text.right_adjust
					l_text.left_adjust
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

				Result := l_text
				l_cache.put (Result, l_file_name)
			end
		ensure
			single_line_help_text_cache_has_help_file_name: single_line_help_text_cache.has (help_file_name)
			result_is_consistent: Result = single_line_help_text
		end

	help_text_cache: attached HASH_TABLE [ARRAYED_LIST [STRING], STRING]
			-- Cached short help text messages, loaded from disk.
		once
			create Result.make (13)
		end

	single_line_help_text_cache: attached HASH_TABLE [STRING, STRING]
			-- Cached short help text messages, loaded from disk.
		once
			create Result.make (13)
		end

feature {ERROR_TRACER} -- Formatting

	build_explain (a_text_formatter: TEXT_FORMATTER)
			-- Build specific explanation image for current error
			-- in `error_window'.
		require
			valid_st: a_text_formatter /= Void
		deferred
		end

feature -- Output

	trace (a_text_formatter: TEXT_FORMATTER)
			-- Display full error message in `a_text_formatter'.
		require
			valid_st: a_text_formatter /= Void;
			is_defined: is_defined
		do
			print_error_message (a_text_formatter);
			build_explain (a_text_formatter);
		end;

	trace_single_line (a_text_formatter: TEXT_FORMATTER)
			-- Display short error, single line message in `a_text_formatter'.
		require
			valid_st: a_text_formatter /= Void;
			is_defined: is_defined
		do
			print_single_line_error_code (a_text_formatter)
			print_single_line_error_message (a_text_formatter)
		end

	trace_primary_context (a_text_formatter: TEXT_FORMATTER)
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

	print_single_line_error_message (a_text_formatter: TEXT_FORMATTER)
			-- Displays single line help in `a_text_formatter'.
		require
			valid_st: a_text_formatter /= Void
		do
			a_text_formatter.add (single_line_help_text)
		end

feature {NONE} -- Print for multiple lines

	print_error_message (a_text_formatter: TEXT_FORMATTER)
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

	frozen print_short_help (a_text_formatter: TEXT_FORMATTER)
			-- Display help in `a_text_formatter'.
		require
			valid_st: a_text_formatter /= Void
		local
			l_text: like help_text
		do
			a_text_formatter.add_new_line

			l_text := help_text
			if not l_text.is_empty then
				from l_text.start until l_text.after loop
					if not l_text.is_empty then
						a_text_formatter.add (l_text.item)
					end
					a_text_formatter.add_new_line
					l_text.forth
				end
			else
				a_text_formatter.add ("No help available for this error");
				a_text_formatter.add ("(Cannot read file: ")
				a_text_formatter.add (help_file_name)
				a_text_formatter.add (")");
				a_text_formatter.add_new_line
				a_text_formatter.add ("An error message should always be available.");
				a_text_formatter.add ("Please contact ISE.");
				a_text_formatter.add_new_line
			end
			a_text_formatter.add_new_line
		end

feature {NONE} -- Implementation

	frozen print_context_of_error (a_context_class: CLASS_C; a_text_formatter: TEXT_FORMATTER)
			-- Display the line number in `a_text_formatter'.
		require
			valid_line: line > 0
			st_not_void: a_text_formatter /= Void
			a_context_class_not_void: a_context_class /= Void
		do
			initialize_output
			a_text_formatter.add (once "Line: ")
			a_text_formatter.add (line.out)
			if a_context_class.lace_class.config_class.has_modification_date_changed then
				a_text_formatter.add (once " (source code has changed)")
				a_text_formatter.add_new_line
			elseif not has_source_text then
				a_text_formatter.add (once " (source code is not available)")
				a_text_formatter.add_new_line
			elseif line > 0 then
				a_text_formatter.add_new_line
				a_text_formatter.add (once "  ")
				if previous_line /= Void then
					if not previous_line.is_empty then
						previous_line.replace_substring_all (once "%T", once "  ")
					end
					a_text_formatter.add (previous_line)
					a_text_formatter.add_new_line
				end
				a_text_formatter.add (once "->")
				if not current_line.is_empty then
					current_line.replace_substring_all (once "%T", once "  ")
				end
				a_text_formatter.add (current_line)
				a_text_formatter.add_new_line
				if next_line /= Void then
					a_text_formatter.add (once "  ")
					if not next_line.is_empty then
						next_line.replace_substring_all (once "%T", once "  ")
					end
					a_text_formatter.add (next_line)
					a_text_formatter.add_new_line
				end
			end
		end

feature {NONE} -- Output

	display_line (a_text_formatter: TEXT_FORMATTER; a_line: STRING)
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

	display_syntax_line (a_text_formatter: TEXT_FORMATTER; a_line: STRING)
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

note
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
