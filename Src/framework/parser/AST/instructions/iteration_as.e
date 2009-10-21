note

	description: "Abstract node for Iteration part of a loop."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class ITERATION_AS

inherit
	AST_EIFFEL
		redefine
			is_equivalent
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (a: like across_keyword; e: like expression; b: like as_keyword; i: like identifier)
			-- Create a new ITERATION AST node.
		require
			e_attached: e /= Void
			i_attached: i /= Void
		do
			if a /= Void then
				across_keyword_index := a.index
			end
			expression := e
			if b /= Void then
				as_keyword_index := b.index
			end
			identifier := i
		ensure
			across_keyword_set: a /= Void implies across_keyword_index = a.index
			expression_set: expression = e
			as_keyword_set: b /= Void implies as_keyword_index = b.index
			identifier_set: identifier = i
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_iteration_as (Current)
		end

feature -- Roundtrip

	across_keyword_index, as_keyword_index: INTEGER
			-- Index of keyword "across" and "as" associated with this structure

	across_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "across" associated with this structure
		require
			a_list_attached: a_list /= Void
		local
			i: INTEGER
		do
			i := across_keyword_index
			if a_list.valid_index (i) and then attached {KEYWORD_AS} a_list.i_th (i) as r then
				Result := r
			end
		end

	as_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "as" associated with this structure
		require
			a_list_attached: a_list /= Void
		local
			i: INTEGER
		do
			i := as_keyword_index
			if a_list.valid_index (i) and then attached {KEYWORD_AS} a_list.i_th (i) as r then
				Result := r
			end
		end

feature -- Attributes

	expression: EXPR_AS
			-- Expression of iteration

	identifier: ID_AS
			-- Cursor of iteration

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): detachable LEAF_AS
		do
			if a_list /= Void then
				Result := across_keyword (a_list)
			end
			if Result = Void then
				Result := expression.first_token (a_list)
			end
		end

	last_token (a_list: LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := identifier.last_token (a_list)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (expression, other.expression) and then
				equivalent (identifier, other.identifier)
		end

invariant
	expression_attached: expression /= Void
	identifier_attached: identifier /= Void

note
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

end -- class ITERATION_AS
