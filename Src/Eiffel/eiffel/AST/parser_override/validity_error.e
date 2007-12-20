indexing
	description: "Validity error in parser phase."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

deferred class
	VALIDITY_ERROR

inherit
	ERROR

	SYNTAX_MESSAGE

	SHARED_WORKBENCH

	SHARED_EIFFEL_PARSER

feature {NONE} -- Initialization

	make (s, e: INTEGER; f: like file_name; error_mssage: STRING) is
			-- Create a new SYNTAX_ERROR.
		require
			f_not_void: f /= Void
		do
			set_position (s, e)
			file_name := f
			associated_class := system.current_class
		ensure
			line_set: line = s
			column_set: column = e
			file_name_set: file_name = f
		end

feature -- Properties

	file_name: STRING
			-- Path to file where syntax issue happened

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
		do
			initialize_output
			if associated_class /= Void then
				a_text_formatter.add ("Class: ")
				a_text_formatter.add_class_syntax (Current, associated_class,
						associated_class.class_signature)
				a_text_formatter.add_new_line
			elseif file_name /= Void then
				-- `current_class' May be void at degree 6 when parsing partial classes
				a_text_formatter.add ("Error in file ")
				a_text_formatter.add (file_name)
				a_text_formatter.add_new_line
			end
			a_text_formatter.add ("Line: ")
			a_text_formatter.add_int (line)
				-- Error happened in a class
			a_text_formatter.add_new_line
			if has_source_text then
				display_line (a_text_formatter, previous_line)
				display_syntax_line (a_text_formatter, current_line)
				display_line (a_text_formatter, next_line)
			else
				a_text_formatter.add (" (source code is not available)")
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

end -- class VALIDITY_ERROR
