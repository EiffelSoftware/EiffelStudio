note
	description: "Abstract description of a conditional expression."

class IF_EXPRESSION_AS

inherit
	EXPR_AS
		redefine
			is_detachable_expression
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (c: like condition; t: like then_expression;
		ei: like elsif_list; e: like else_expression; el: like end_keyword; i_as, t_as, e_as: like if_keyword)
			-- Create a new IF AST node.
		require
			c_attached: attached c
			t_attached: attached t
			e_attached: attached e
			el_attached: attached el
		do
			condition := c
			then_expression := t
			elsif_list := ei
			else_expression := e
			end_keyword := el
			if attached i_as then
				if_keyword_index := i_as.index
			end
			if attached t_as then
				then_keyword_index := t_as.index
			end
			if attached e_as then
				else_keyword_index := e_as.index
			end
		ensure
			condition_set: condition = c
			then_expression_set: then_expression = t
			elsif_list_set: elsif_list = ei
			else_expression_set: else_expression = e
			end_keyword_set: end_keyword = el
			if_keyword_set: attached i_as implies if_keyword_index = i_as.index
			then_keyword_set: attached t_as implies then_keyword_index = t_as.index
			else_keyword_set: attached e_as implies else_keyword_index = e_as.index
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_if_expression_as (Current)
		end

feature -- Status report

	is_detachable_expression: BOOLEAN = True
			-- <Precursor>

feature -- Roundtrip

	if_keyword_index, then_keyword_index, else_keyword_index: INTEGER
			-- Index of keyword "if", "else" and "then" assoicated with this structure

	if_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "if" assoicated with this structure
		require
			a_list_attached: attached a_list
		local
			i: INTEGER
		do
			i := if_keyword_index
			if a_list.valid_index (i) and then attached {KEYWORD_AS} a_list.i_th (i) as k then
				Result := k
			end
		end

	then_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "then" assoicated with this structure
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

	else_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "else" assoicated with this structure
		require
			a_list_attached: attached a_list
		local
			i: INTEGER
		do
			i := else_keyword_index
			if a_list.valid_index (i) and then attached {KEYWORD_AS} a_list.i_th (i) as k then
				Result := k
			end
		end

	index: INTEGER
			-- <Precursor>
		do
			Result := if_keyword_index
		end

feature -- Attributes

	condition: EXPR_AS
			-- Condition.

	then_expression: EXPR_AS
			-- Expression in Then_part.

	elsif_list: detachable EIFFEL_LIST [ELSIF_EXPRESSION_AS]
			-- Elsif list.

	else_expression: EXPR_AS
			-- Expression in Else_part.

	end_keyword: KEYWORD_AS
			-- "end" keyword token (for position information).

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if not attached a_list then
				Result := condition.first_token (Void)
			elseif if_keyword_index /= 0 then
				Result := if_keyword (a_list)
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := end_keyword.last_token (a_list)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result :=
				equivalent (condition, other.condition) and then
				equivalent (then_expression, other.then_expression) and then
				equivalent (else_expression, other.else_expression) and then
				equivalent (elsif_list, other.elsif_list)
		end

invariant
	condition_attached: attached condition
	then_expression_attached: attached then_expression
	else_expression_attached: attached else_expression
	end_keyword_attached: attached end_keyword

note
	date:           "$Date$"
	revision:       "$Revision$"
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
