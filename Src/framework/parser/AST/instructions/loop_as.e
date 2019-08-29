note
	description	: "Abstract description of an Eiffel loop instruction. %
				  %Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class LOOP_AS

inherit
	INSTRUCTION_AS

	ASSERTION_FILTER

create
	initialize

feature {NONE} -- Initialization

	initialize (t: like iteration; f: like from_part; i: like invariant_part;
		v: like variant_part; s: like stop;
		c: like compound; e: like end_keyword; f_as, i_as, u_as, l_as: detachable KEYWORD_AS; r, bc: detachable SYMBOL_AS)
			-- Create a new LOOP AST node.
		require
			t_or_s_attached: t /= Void or s /= Void
			e_or_c_attached: attached e or attached bc
		do
			iteration := t
			from_part := f
			full_invariant_list := i
			invariant_part := filter_tagged_list (full_invariant_list)
			variant_part := v
			stop := s
			compound := c
			end_keyword := e
			end_symbol := bc
			if attached f_as then
				from_keyword_index := f_as.index
			end
			if i_as /= Void then
				invariant_keyword_index := i_as.index
			end
			if u_as /= Void then
				until_keyword_index := u_as.index
			end
			if attached l_as then
				loop_index := l_as.index
			elseif attached r then
				loop_index := r.index
			end
		ensure
			iteration_set: iteration = t
			from_part_set: from_part = f
			full_invariant_list_set: full_invariant_list = i
			variant_part_set: variant_part = v
			stop_set: stop = s
			compound_set: compound = c
			end_keyword_set: end_keyword = e
			end_symbol_set: end_symbol = bc
			from_keyword_set: attached f_as implies from_keyword_index = f_as.index
			invariant_keyword_set: i_as /= Void implies invariant_keyword_index = i_as.index
			until_keyword_set: u_as /= Void implies until_keyword_index = u_as.index
			loop_keyword_set: attached l_as implies loop_index = l_as.index
			repeat_symbol_set: attached r implies loop_index = r.index
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_loop_as (Current)
		end

feature -- Roundtrip

	full_invariant_list: like invariant_part
			-- Invariant assertion list that contains both complete and incomplete assertions.
			-- e.g. "tag:expr", "tag:", "expr"

	from_keyword_index, invariant_keyword_index, until_keyword_index, loop_index: INTEGER
			-- Index of keyword "from", "invariant", "until" and "loop" associated with this structure

	from_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "from" associated with this structure
		require
			a_list_not_void: a_list /= Void
			not_is_symbolic: attached iteration as i implies not i.is_symbolic
		do
			Result := keyword_from_index (a_list, from_keyword_index)
		end

	repeat_symbol (a_list: LEAF_AS_LIST): detachable SYMBOL_AS
			-- Symbol "⟳" associated with this structure.
		require
			a_list_not_void: a_list /= Void
			is_symbolic: attached iteration as i and then i.is_symbolic
		do
			if a_list.valid_index (loop_index) then
				Result := {SYMBOL_AS} / a_list [loop_index]
			end
		end

	invariant_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "invariant" associated with this structure
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

	loop_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "loop" associated with this structure.
		require
			a_list_not_void: a_list /= Void
			not_is_symbolic: attached iteration as i implies not i.is_symbolic
		do
			Result := keyword_from_index (a_list, loop_index)
		end

	index: INTEGER
			-- <Precursor>
		do
			Result := loop_index
		end

feature -- Attributes

	iteration: detachable ITERATION_AS
			-- Iteration

	from_part: detachable EIFFEL_LIST [INSTRUCTION_AS]
			-- from compound

	invariant_part: detachable EIFFEL_LIST [TAGGED_AS]
			-- invariant list

	variant_part: detachable VARIANT_AS
			-- Variant list

	stop: detachable EXPR_AS
			-- Stop test

	compound: detachable EIFFEL_LIST [INSTRUCTION_AS]
			-- Loop compound

	end_keyword: detachable KEYWORD_AS
			-- Line number where `end' keyword is located.

	end_symbol: detachable SYMBOL_AS
			-- Line number where closing block symbol is located.

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if attached iteration as i then
				if i.is_symbolic and then attached a_list then
					Result := repeat_symbol (a_list)
				end
				if not attached Result then
					Result := i.first_token (a_list)
				end
			elseif a_list /= Void and from_keyword_index /= 0 then
				Result := from_keyword (a_list)
			elseif attached from_part as l_from then
				Result := l_from.first_token (a_list)
			elseif a_list /= Void and invariant_keyword_index /= 0 then
				Result := invariant_keyword (a_list)
			elseif attached invariant_part as l_inv then
				Result := l_inv.first_token (a_list)
			elseif attached variant_part as l_var then
				Result := l_var.first_token (a_list)
			elseif a_list /= Void and until_keyword_index /= 0 then
				Result := until_keyword (a_list)
			elseif attached stop as l_stop then
				Result := l_stop.first_token (a_list)
			end
		end

	end_leaf: LEAF_AS
		do
			Result := end_keyword
			if not attached Result then
				Result := end_symbol
				check from_invariant: attached Result then end
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := end_leaf.last_token (a_list)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (compound, other.compound) and then
				equivalent (iteration, other.iteration) and then
				equivalent (from_part, other.from_part) and then
				equivalent (invariant_part, other.invariant_part) and then
				equivalent (stop, other.stop) and then
				equivalent (variant_part, other.variant_part)
		end

invariant
	iteration_or_stop_attached: iteration /= Void or stop /= Void
	end_keyword_or_symbol_attached: attached end_keyword or attached end_symbol

note
	ca_ignore: "CA011", "CA011: too many arguments"
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
