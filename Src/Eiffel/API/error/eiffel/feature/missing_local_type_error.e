note
	description: "A syntax error for missing local type declaration."

class
	MISSING_LOCAL_TYPE_ERROR

inherit
	FEATURE_ERROR
		redefine
			print_error_message,
			print_single_line_error_message
		end

	SHARED_LOCALE export {NONE} all end
	SHARED_NAMES_HEAP export {NONE} all end

create
	make

feature {NONE} -- Initialization

	make (i: ITERABLE [INTEGER_32]; c: AST_CONTEXT; l: LOCATION_AS)
			-- Initialize an error for local variable names `i' in context `c' at location `l'.
		do
			identifiers := i
			c.init_error (Current)
			set_location (l)
		end

feature {NONE} -- Access

	identifiers: ITERABLE [INTEGER_32]
			-- Identifiers of local variables without type declaration.

feature -- Properties

	code: STRING = "Syntax Error"
			-- <Precursor>

feature {NONE} -- Output

	print_error_message (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			print_error_code (t)
			t.add_new_line
			message.format (t, locale.translation_in_context
					("[
						No type is specified for the local declaration list:
						  {1}
					]",
					"eiffel.error"),
				<<message.list (locals)>>
			)
				-- Make sure any other information about the error comes at a new line.
			t.add_new_line
			t.add_new_line
		end

	print_single_line_error_message (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			message.format (t, locale.translation_in_context ("Missing type declaration for locals {1}", "eiffel.error"), <<message.list (locals)>>)
		end

feature {NONE} -- Formatting

	locals: like message.listable
			-- Collection of formatters to add local variable names.
		do
			create {ITERABLE_FUNCTION [PROCEDURE[ANY, TUPLE [TEXT_FORMATTER]], INTEGER_32]} Result.make
				(agent (local_name: INTEGER_32): PROCEDURE[ANY, TUPLE [TEXT_FORMATTER]]
					do
						Result := agent {TEXT_FORMATTER}.add_local (names_heap.item_32 (local_name))
					end,
				identifiers)
		end

	message: FORMATTED_MESSAGE
			-- A message formatter.
		once
			create Result
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
