note
	description: "Bracket expression node."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	BRACKET_AS

inherit
	EXPR_AS
		redefine
			is_detachable_expression
		end

	ID_SET_ACCESSOR

create
	make

feature {NONE} -- Creation

	make (t: like target; o: like operands; l_as, r_as: like lbracket_symbol)
			-- Create bracket expression with target `t' and operands `o'.
		require
			t_not_void: t /= Void
			o_not_void: o /= Void
			o_not_empty: not o.is_empty
		do
			make_id_set
			target := t
			operands :=  o
			lbracket_symbol := l_as
			rbracket_symbol := r_as
		ensure
			target_set: target = t
			operands_set: operands = o
			lbracket_symbol_set: lbracket_symbol = l_as
			rbracket_symbol_set: rbracket_symbol = r_as
			no_routine_id: routine_ids.is_empty
		end

feature -- Roundtrip

	lbracket_symbol, rbracket_symbol: detachable SYMBOL_AS
			-- Symbol "[" and "]" associated with this structure

	index: INTEGER
			-- <Precursor>
		do
			if attached lbracket_symbol as s then
				Result := s.index
			end
		end

feature -- Access

	target: EXPR_AS
			-- Target of bracket expression

	operands: EIFFEL_LIST [EXPR_AS]
			-- Operands of bracket expression

feature -- Status Report

	is_detachable_expression: BOOLEAN = True
			-- <Precursor>

feature -- Location

	left_bracket_location: LOCATION_AS
			-- Location of a left bracket
		do
			Result := operands.first.start_location
		end

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := target.first_token (a_list)
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if a_list = Void then
				Result := operands.last_token (a_list)
			else
				Result := rbracket_symbol
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (target, other.target) and then
				equivalent (operands, other.operands)
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- Process current element.
		do
			v.process_bracket_as (Current)
		end

invariant
	target_not_void: target /= Void
	operands_not_void: operands /= Void
	operands_not_empty: not operands.is_empty

note
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
