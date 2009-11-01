note
	description: "[
		A compiler error pertaining to the external C compilation.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	C_COMPILER_ERROR

inherit
	COMPILER_ERROR
		redefine
			help_file_name, has_associated_file, print_single_line_error_message,
			trace_primary_context
		end

	ERROR_CONTEXT_PRINTER
		export
			{NONE} all
		end

create
	make,
	make_with_file

feature {NONE} -- Initialization

	make (a_message: like message)
			-- Initializes the C Compiler error with a message.
			--
			-- `a_message': A C compiler error message.
		require
			a_message_attached: a_message /= Void
			not_a_message_is_empty: not a_message.is_empty
		do
			create message.make_from_string (a_message)
		ensure
			message_set: message ~ a_message
		end

	make_with_file (a_message: like message; a_file_name: like file_name; a_line: like line; a_column: like column)
			-- Initializes the C Compiler error with a message.
			--
			-- `a_message': A C compiler error message.
			-- `a_file_name': The file associated with the error.
			-- `a_line': Line number where the error occurred.
			-- `a_column': Line column number where the error occured.
		require
			a_message_attached: a_message /= Void
			not_a_message_is_empty: not a_message.is_empty
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
		do
			make (a_message)
			file_name := a_file_name
			line := a_line
			column := a_column
		ensure
			message_set: message ~ a_message
			file_name_set: file_name = a_file_name
			line_set: line = a_line
			column_set: column = a_column
		end

feature -- Access

	code: STRING
			-- Code error
		do
			Result := "C Compiler Error"
		end

	help_file_name: STRING = "C_COMPILER_ERROR"
			-- Help file name

	message: STRING
			-- Message from C compiler.

	file_name: detachable STRING
			-- Location of the compilation error.

	associated_feature: detachable E_FEATURE assign set_associated_feature
			-- Associated Eiffel feature, if any.

feature -- Element change

	set_associated_feature (a_feature: like associated_feature)
			-- Sets the error's associated feature.
			--
			-- `a_feature': An Eiffel feature the C error pertains to.
		require
			a_feature_attached: attached a_feature
		local
			l_class: CLASS_C
			l_ast: CLASS_AS
			l_match_list: LEAF_AS_LIST
			l_location: LOCATION_AS
		do
			l_class := a_feature.written_class
			associated_feature := a_feature
			associated_class := l_class

				-- Set new location properties.
			file_name := l_class.file_name
			line := 0
			column := 0

				-- Get AST and set line/column information.
			l_ast := a_feature.written_class.ast_server.item (a_feature.written_class.class_id)
			l_match_list := a_feature.written_class.match_list_server.item (a_feature.written_class.class_id)
			if attached l_ast and attached l_match_list then
				if attached l_ast.feature_of_name (a_feature.name, False) as l_feature then
					if
						attached {ROUTINE_AS} l_feature.body.content as l_routine and then
						attached {EXTERNAL_AS} l_routine.routine_body as l_external and then
						attached l_external.alias_name_literal as l_alias
					then
						l_location := l_alias.start_location
					else
						l_location := l_feature.start_location
					end

					if attached l_location then
						line := l_location.line
						column := l_location.column
					end
				end
			end
		ensure
			associated_feature_set: associated_feature = a_feature
			associated_class_set: associated_class = a_feature.written_class
		end

feature -- Status report

	has_associated_file: BOOLEAN
			-- Is current relative to a file?
		do
			Result := attached file_name
		ensure then
			file_name_attached: Result implies attached file_name
		end

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
			-- <Precursor>
		local
			l_message: STRING
		do
			l_message := message
			if not l_message.is_empty then
				a_text_formatter.add (message)
				if l_message[l_message.count].is_alpha_numeric then
					a_text_formatter.add (once ".")
				end
				a_text_formatter.add_new_line
			end
		end

	trace_primary_context (a_text_formatter: TEXT_FORMATTER)
			-- <Precursor>
		do
			if attached associated_feature as l_feature and attached {CLASS_C} associated_class as l_class then
				print_context_feature (a_text_formatter, l_feature, l_class)
			else
				if has_associated_file then
					a_text_formatter.add_string (file_name)
				end
			end
		end

feature {NONE} -- Output

	print_single_line_error_message (a_text_formatter: TEXT_FORMATTER)
			-- Displays single line help in `a_text_formatter'.
		do
			a_text_formatter.add (message)
		end

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
