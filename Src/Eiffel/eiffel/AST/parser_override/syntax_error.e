indexing

	description:
		"Syntax error."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class SYNTAX_ERROR

inherit
	ERROR
		redefine
			file_name, trace, trace_primary_context, print_single_line_error_message
		end

	SYNTAX_MESSAGE

	SHARED_WORKBENCH

create
	make, init

feature {NONE} -- Initialization

	make (s, e: INTEGER; f: like file_name; m: STRING) is
			-- Create a new SYNTAX_ERROR.
		require
			f_not_void: f /= Void
			m_not_void: m /= Void
		do
			set_position (s, e)
			file_name := f
			error_message := m
			associated_class := system.current_class
		ensure
			line_set: line = s
			column_set: column = e
			file_name_set: file_name = f
			error_message_set: error_message = m
		end

	init (a_parser: EIFFEL_PARSER) is
			-- Initialize `line' and `column' from `a_parser'.
		require
			a_parser_not_void: a_parser /= Void
		local
			a_filename: FILE_NAME
		do
			create a_filename.make_from_string (a_parser.filename)
			make (a_parser.line, a_parser.column, a_filename, a_parser.error_message)
		end

feature -- Properties

	error_message: STRING
			-- Specify syntax issue message.

	file_name: STRING
			-- Path to file where syntax issue happened

	code: STRING is "Syntax Error"
			-- Error code

	syntax_message: STRING is
			-- Specific syntax message.
			-- (By default, it is empty)
		do
			Result := ""
		ensure
			non_void_result: Result /= Void
		end

	associated_class: CLASS_C
			-- Associate class, if any

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
		local
			msg: STRING
		do
			msg := syntax_message
			if not msg.is_empty then
				a_text_formatter.add ("(")
				a_text_formatter.add (msg)
				a_text_formatter.add (")")
				a_text_formatter.add_new_line
			end
		end

	trace (a_text_formatter: TEXT_FORMATTER) is
			-- Debug purpose
		do
			initialize_output
			a_text_formatter.add ("Syntax error at line ")
			a_text_formatter.add_int (line)
				-- Error happened in a class
			if associated_class /= Void then
				a_text_formatter.add (" in class ")
				a_text_formatter.add_class_syntax (Current, associated_class, associated_class.class_signature)
			elseif file_name /= Void then
					-- `associated_class' May be void at degree 6 when parsing partial classes
				a_text_formatter.add (" in file ")
				a_text_formatter.add (file_name)
			end
			if error_message /= Void and then not error_message.is_empty then
				a_text_formatter.add_new_line
				a_text_formatter.add (error_message)
			end
			a_text_formatter.add_new_line
			build_explain (a_text_formatter)
			if has_source_text then
				a_text_formatter.add_new_line
				display_line (a_text_formatter, previous_line)
				display_syntax_line (a_text_formatter, current_line)
				display_line (a_text_formatter, next_line)
			else
				a_text_formatter.add (" (source code is not available)")
				a_text_formatter.add_new_line
			end
		end

	trace_primary_context (a_text_formatter: TEXT_FORMATTER) is
			-- Build the primary context string so errors can be navigated to
		local
			l_class_c: CLASS_C
		do
			l_class_c := associated_class
			if l_class_c /= Void then
				a_text_formatter.add_group (l_class_c.group, l_class_c.group.name)
				a_text_formatter.add (".")
				a_text_formatter.add_class (l_class_c.lace_class)
			elseif file_name /= Void then
				Precursor {ERROR} (a_text_formatter)
			end
		end

feature {NONE} -- Output

	print_single_line_error_message (a_text_formatter: TEXT_FORMATTER) is
			-- Displays single line help in `a_text_formatter'
		do
			initialize_output
			if syntax_message /= Void and then not syntax_message.is_empty then
				a_text_formatter.add (syntax_message)
			else
				a_text_formatter.add ("Syntax error at line ")
				a_text_formatter.add_int (line)
				a_text_formatter.add (".")
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

end -- class SYNTAX_ERROR
