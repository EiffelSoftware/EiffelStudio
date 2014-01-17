note
	description: "Object that represents a prepended item in EIFFEL_LIST"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ERT_PREPENDED_ITEM_MODIFIER

inherit
	ERT_ADDED_ITEM_MODIFIER

create {INTERNAL_COMPILER_STRING_EXPORTER}
	make

feature {NONE} -- Initialization

	make (ast: like attached_ast; a_text: detachable STRING; a_owner: INTEGER; a_index: INTEGER; a_list: like match_list)
			-- Initialize instance.
		require
			ast_not_void: ast /= Void
		do
			attached_ast := ast
			initialize (a_text, a_owner, a_index, -1, a_list)
		ensure
			attached_ast_set: attached_ast = ast
		end

feature -- Applicability

	can_apply: BOOLEAN
			-- Can current modifier be applied?
		do
			Result := attached_ast.can_prepend_text (match_list)
		end

feature -- Operation

	apply
			-- Apply current modifier.
		local
			l_text: STRING
		do
			create l_text.make (text.count + trailing_text.count + leading_text.count + separator.count)
			l_text.append_string (text)
			if is_separator_needed then
				l_text.append_string (separator)
			end
			l_text.append_string (trailing_text)
			l_text.append_string (leading_text)
			attached_ast.prepend_text (l_text, match_list)
			applied := True
		end

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
