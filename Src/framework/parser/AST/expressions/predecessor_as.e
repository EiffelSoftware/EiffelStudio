note
	description: "AST representation of a predecessor access."

class
	PREDECESSOR_AS

inherit
	EXPR_AS
	ID_SET_ACCESSOR

create
	initialize

feature {NONE} -- Initialization

	initialize (n: like name; s: like predecessor_symbol)
			-- Create a new predecessor AST node with name `n` and symbol `s`.
		require
			attached n
		do
			make_id_set
			name := n
			if attached s then
				predecessor_symbol_index := s.index
			end
		ensure
			name = n
			predecessor_symbol_set: attached s implies predecessor_symbol_index = s.index
			routine_ids.is_empty
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- <Precursor>
		do
			v.process_predecessor_as (Current)
		end

feature -- Roundtrip

	predecessor_symbol_index: INTEGER
			-- Index of symbol "@" associated with this structure.

	predecessor_symbol (a_list: detachable LEAF_AS_LIST): detachable SYMBOL_AS
			-- Symbol "@" associated with this structure.
		local
			i: INTEGER
		do
			if attached a_list then
				i := predecessor_symbol_index
				if a_list.valid_index (i) then
					Result := {like predecessor_symbol} / a_list [i]
				end
			end
		end

	index: INTEGER
			-- <Precursor>
		do
			Result := predecessor_symbol_index
		end

feature -- Attributes

	name: ID_AS
			-- The name of the variable.

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := predecessor_symbol (a_list)
			if not attached Result then
				Result := name
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := name
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (name, other.name)
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
