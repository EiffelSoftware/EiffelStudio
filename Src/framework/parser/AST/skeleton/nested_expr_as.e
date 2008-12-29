note
	description:
			"Abstract description of a nested call `target.message' where %
			%the target is a parenthesized expression. Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class NESTED_EXPR_AS

inherit
	CALL_AS
		redefine
			is_equivalent
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (t: like target; m: like message; d_as, l_as, r_as: like dot_symbol)
			-- Create a new NESTED CALL AST node.
		require
			t_not_void: t /= Void
			m_not_void: m /= Void
		do
			target := t
			message := m
			if d_as /= Void then
				dot_symbol_index := d_as.index
			end
			if l_as /= Void then
				lparan_symbol_index := l_as.index
			end
			if r_as /= Void then
				rparan_symbol_index := r_as.index
			end
		ensure
			target_set: target = t
			message_set: message = m
			dot_symbol_set: d_as /= Void implies dot_symbol_index = d_as.index
			lparan_symbol_set: l_as /= Void implies lparan_symbol_index = l_as.index
			rparan_symbol_set: r_as /= Void implies rparan_symbol_index = r_as.index
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_nested_expr_as (Current)
		end

feature -- Roundtrip

	dot_symbol_index: INTEGER
			-- Index of symbol "." associated with this structure

	lparan_symbol_index, rparan_symbol_index: INTEGER
			-- Index of symbol "(" and ")" associated with this structure

	dot_symbol (a_list: LEAF_AS_LIST): SYMBOL_AS
			-- Symbol "." associated with this structure
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := dot_symbol_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	lparan_symbol (a_list: LEAF_AS_LIST): SYMBOL_AS
			-- Symbol "(" associated with this structure
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := lparan_symbol_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	rparan_symbol (a_list: LEAF_AS_LIST): SYMBOL_AS
			-- Symbol ")" associated with this structure
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := rparan_symbol_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

feature -- Status report

	has_lparan: BOOLEAN
			-- Does current have `('?
		do
			Result := lparan_symbol_index /= 0
		end

	has_rparan: BOOLEAN
			-- Does current have `('?
		do
			Result := rparan_symbol_index /= 0
		end

feature -- Attributes

	target: EXPR_AS
			-- Target of the call

	message: CALL_AS
			-- Message send to the target

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS
		do
			if a_list /= Void and lparan_symbol_index /= 0 then
				Result := lparan_symbol (a_list)
			end
			if Result = Void then
				Result := target.first_token (a_list)
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS
		do
			Result := message.last_token (a_list)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (message, other.message) and
				equivalent (target, other.target)
		end

invariant
	message_not_void: message /= Void
	target_not_void: target /= Void

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class NESTED_EXPR_AS
