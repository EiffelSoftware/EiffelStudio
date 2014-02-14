note
	description: "Object that represents an existing item (which appears before any modification) in EIFFEL_LIST"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ERT_EXISTING_ITEM_MODIFIER

inherit
	ERT_LIST_ITEM_MODIFIER

create
	make

feature -- Initialization

	make (a_item_ast: like item_ast; a_separator_ast: like separator_ast;  a_owner: INTEGER; a_index: INTEGER; a_list: like match_list)
			-- Initialize instance.
		require
			ast_not_void: a_item_ast /= Void
		do
			item_ast := a_item_ast
			separator_ast := a_separator_ast
			initialize (Void, a_owner, a_index, 0, a_list)
		ensure
			item_ast_set: item_ast = a_item_ast
			separator_ast_set: separator_ast = a_separator_ast
		end

feature -- Applicability

	can_apply: BOOLEAN
			-- Can current modifier be applied?
		do
			Result := True
			if text /= Void then
				Result := item_ast.can_replace_text (match_list)
			end
			if is_separator_needed then
				if separator_ast = Void then
					Result := item_ast.can_append_text (match_list)
				end
			else
				if attached separator_ast as l_ast then
					Result := l_ast.can_replace_text (match_list)
				end
			end
		end

feature -- Operation

	apply
			-- Apply current modifier.
		do
			if attached text as l_text then
				item_ast.replace_text (l_text, match_list)
			end
			if is_separator_needed then
				if separator_ast = Void and attached separator as l_sep then
					item_ast.append_text (l_sep, match_list)
				end
			else
				if attached separator_ast as l_ast then
					l_ast.replace_text ("", match_list)
				end
			end
			applied := True
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Setting

	set_text (a_text: STRING)
			-- Set `text' with `a_text'.
			-- `a_text' is empty means remove current item.
		require
			a_text_not_void: a_text /= Void
		do
			text := a_text.twin
		ensure
			text_set: text ~ a_text
		end

feature	-- Status reporting

	already_has_separator: BOOLEAN
			-- Does current item already has a separator?
		do
			Result := separator_ast /= Void
		end

	is_removed: BOOLEAN
			-- Is current item removed?
		do
			Result := attached text as l_text and then l_text.is_empty
		end

feature

	item_ast: AST_EIFFEL
			-- Item AST node

	separator_ast: detachable AST_EIFFEL
			-- Separator AST node, if any

invariant
	item_ast_not_void: item_ast /= Void

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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
