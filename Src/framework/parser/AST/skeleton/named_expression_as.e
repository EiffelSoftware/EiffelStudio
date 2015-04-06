note
	description: "Named expression used in separate instructions."

class
	NAMED_EXPRESSION_AS

inherit
	AST_EIFFEL

create
	make

feature {NONE} -- Creation

	make (e: like expression; a: detachable KEYWORD_AS; n: like name)
			-- Initialize a node from expression `e', "as" keyword `a' (if any) and name `n'.
		do
			expression := e
			if attached a then
				as_keyword_index := a.index
			end
			name := n
		ensure
			expression_set: expression = e
			as_keyword_index_set: attached a implies as_keyword_index = a.index
			name_set: name = n
		end

feature {AST_VISITOR} -- Visitor

	process (v: AST_VISITOR)
			-- <Precursor>
		do
			v.process_named_expression_as (Current)
		end

feature -- Access

	expression: EXPR_AS
			-- Expression.

	name: ID_AS
			-- Variable name.

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- <Precursor>
		do
			Result :=
				equivalent (expression, other.expression) and then
				equivalent (name, other.name)
		end

feature -- Roundtrip

	as_keyword_index: INTEGER
			-- Index of keyword "as" associated with this structure.

	as_keyword (tokens: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "as" associated with this structure.
		do
			Result := keyword_from_index (tokens, as_keyword_index)
		end

	index: INTEGER
			-- <Precursor>
		do
			Result := as_keyword_index
		end

	first_token (tokens: detachable LEAF_AS_LIST): detachable LEAF_AS
			-- <Precursor>
		do
			Result := expression.first_token (tokens)
			if not attached Result and then attached tokens then
				Result := as_keyword (tokens)
			end
			if not attached Result then
				Result := name.first_token (tokens)
			end
		end

	last_token (tokens: detachable LEAF_AS_LIST): detachable LEAF_AS
			-- <Precursor>
		do
			Result := name.last_token (tokens)
			if not attached Result and then attached tokens then
				Result := as_keyword (tokens)
			end
			if not attached Result then
				Result := expression.last_token (tokens)
			end
		end

note
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2015, Eiffel Software"
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
