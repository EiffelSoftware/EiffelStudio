note
	description: "Abstract description of an Eiffel loop expression."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class LOOP_EXPR_AS

inherit
	EXPR_AS

	ASSERTION_FILTER

create
	initialize

feature {NONE} -- Initialization

	initialize (f: like iteration; w: like invariant_keyword; i: like invariant_part; u: like until_keyword; c: like exit_condition;
		q: like qualifier_keyword; s: like qualifier_symbol; a: like is_all; e: like expression; v: like variant_part; k: like end_keyword)
			-- Create a new LOOP EXPRESSION AST node.
		require
			f_attached: f /= Void
			e_attached: e /= Void
			at_most_one_qualifier: not attached q or not attached s
		do
			iteration := f
			if w /= Void then
				invariant_keyword_index := w.index
			end
			full_invariant_list := i
			invariant_part := filter_tagged_list (i)
			if u /= Void then
				until_keyword_index := u.index
			end
			exit_condition := c
			if attached q then
				qualifier_index := q.index
			elseif attached s then
				qualifier_index := s.index
			end
			is_all := a
			expression := e
			variant_part := v
			end_keyword := k
		ensure
			iteration_set: iteration = f
			invariant_keyword_set: w /= Void implies invariant_keyword_index = w.index
			full_invariant_list_set: full_invariant_list = i
			until_keyword_set: u /= Void implies until_keyword_index = u.index
			exit_conditionp_set: exit_condition = c
			qualifier_keyword_set: attached q implies qualifier_index = q.index
			qualifier_symbol_set: attached s implies qualifier_index = s.index
			is_all_set: is_all = a
			expression_set: expression = e
			variant_part_set: variant_part = v
			end_keyword_set: end_keyword = k
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_loop_expr_as (Current)
		end

feature -- Roundtrip

	full_invariant_list: like invariant_part
			-- Invariant assertion list that contains both complete and incomplete assertions.
			-- e.g. "tag:expr", "tag:", "expr"

	invariant_keyword_index: INTEGER
			-- Index of keyword "invariant".

	until_keyword_index: INTEGER
			-- Index of keyword "until".

	qualifier_index: INTEGER
			-- Index of keyword "all"/"some".

	invariant_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "invariant" associated with this structure.
		require
			a_list_not_void: a_list /= Void
		do
			Result := keyword_from_index (a_list, invariant_keyword_index)
		end

	until_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "until"  associated with this structure
		require
			a_list_not_void: a_list /= Void
		do
			Result := keyword_from_index (a_list, until_keyword_index)
		end

	qualifier_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "all" or "some" associated with this structure.
		require
			a_list_not_void: a_list /= Void
		do
			Result := keyword_from_index (a_list, qualifier_index)
		end

	qualifier_symbol (a_list: LEAF_AS_LIST): detachable SYMBOL_AS
			-- Symbol "∀" or "∃" associated with this structure.
		require
			a_list_not_void: a_list /= Void
		do
			if a_list.valid_index (qualifier_index) then
				Result := {SYMBOL_AS} / a_list [qualifier_index]
			end
		end

	index: INTEGER
			-- <Precursor>
		do
			Result := qualifier_index
		end

feature -- Attributes

	iteration: ITERATION_AS
			-- Iteration part

	invariant_part: detachable EIFFEL_LIST [TAGGED_AS]
			-- Invariant part

	exit_condition: detachable EXPR_AS
			-- Exit condition

	is_all: BOOLEAN
			-- Is it "all" qualifier?

	expression: EXPR_AS
			-- Loop expression

	variant_part: detachable VARIANT_AS
			-- Variant part

	end_keyword: detachable KEYWORD_AS
			-- Line number where `end' keyword is located

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if iteration.is_symbolic and then attached a_list then
				Result := qualifier_symbol (a_list)
			end
			if not attached Result then
				Result := iteration.first_token (a_list)
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if attached end_keyword as l_keyword then
				Result := l_keyword.last_token (a_list)
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (iteration, other.iteration) and then
				equivalent (invariant_part, other.invariant_part) and then
				equivalent (exit_condition, other.exit_condition) and then
				equivalent (variant_part, other.variant_part) and then
				is_all = other.is_all and then
				equivalent (expression, other.expression)
		end

invariant
	iteration_attached: iteration /= Void
	expression_attached: expression /= Void

note
	ca_ignore:
		"CA011", "CA011: too many arguments"
	copyright:	"Copyright (c) 1984-2019, Eiffel Software"
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
