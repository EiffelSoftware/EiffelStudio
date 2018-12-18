note
	description: "Abstract description of an elseif clause of a conditional expression."

class ELSIF_EXPRESSION_AS

inherit
	EXPR_AS
		redefine
			is_detachable_expression
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (c: like condition; e: like expression; l_as, t_as: like elseif_keyword)
			-- Create a new ELSIF AST node.
		require
			c_attached: attached c
			e_attached: attached e
		do
			condition := c
			expression := e
			if attached l_as then
				elseif_keyword_index := l_as.index
			end
			if attached t_as then
				then_keyword_index := t_as.index
			end
		ensure
			condition_set: condition = c
			expression_set: expression = e
			elseif_keyword_set: attached l_as implies elseif_keyword_index = l_as.index
			then_keyword_set: attached t_as implies then_keyword_index = t_as.index
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- Process current element.
		do
			v.process_elseif_expression_as (Current)
		end

feature -- Status report

	is_detachable_expression: BOOLEAN = True
			-- <Precursor>

feature -- Roundtrip

	elseif_keyword_index, then_keyword_index: INTEGER
			-- Index of keyword "elseif" and "then" assoicated with this structure.

	elseif_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "elseif" assoicated with this structure.
		require
			a_list_attached: attached a_list
		local
			i: INTEGER
		do
			i := elseif_keyword_index
			if a_list.valid_index (i) and then attached {KEYWORD_AS} a_list.i_th (i) as k then
				Result := k
			end
		end

	then_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "then" assoicated with this structure.
		require
			a_list_attached: attached a_list
		local
			i: INTEGER
		do
			i := then_keyword_index
			if a_list.valid_index (i) and then attached {KEYWORD_AS} a_list.i_th (i) as k then
				Result := k
			end
		end

	index: INTEGER
			-- <Precursor>
		do
			Result := elseif_keyword_index
		end

feature -- Attributes

	condition: EXPR_AS
			-- Conditional expression.

	expression: EXPR_AS
			-- Value.

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if attached a_list and then elseif_keyword_index /= 0 then
				Result := elseif_keyword (a_list)
			else
				Result := condition.first_token (a_list)
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := expression.last_token (a_list)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object?
		do
			Result := equivalent (condition, other.condition) and
				equivalent (expression, other.expression)
		end

invariant
	condition_attached: attached condition
	expression_attached: attached expression

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2018, Eiffel Software"
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
