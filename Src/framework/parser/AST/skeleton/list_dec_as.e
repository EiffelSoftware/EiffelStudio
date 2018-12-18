note
	description: "Abstract description of an untyped identifier list declaration."

class LIST_DEC_AS

inherit
	AST_EIFFEL

	SHARED_NAMES_HEAP

create
	initialize

feature {NONE} -- Initialization

	initialize (i: like id_list)
			-- Create a new AST node with the list of identifiers `i'.
		require
			i_not_void: attached i
		do
			id_list := i
		ensure
			id_list_set: id_list = i
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- Process current element.
		do
			v.process_list_dec_as (Current)
		end

feature -- Roundtrip

	index: INTEGER
			-- <Precursor>
		do
			if attached id_list.id_list as l then
				Result := l.first
			end
		end

feature -- Access

	id_list: IDENTIFIER_LIST
			-- List of ids.

	item_name (i: INTEGER): detachable STRING
			-- Name of `id' at position `i'.
			-- item names are ascii compatible.
		require
			valid_index: id_list.valid_index (i)
		do
			Result := Names_heap.item (id_list [i])
		end

	item_name_32 (i: INTEGER): detachable STRING_32
			-- Name of `id' at position `i'.
		require
			valid_index: id_list.valid_index (i)
		do
			Result := Names_heap.item_32 (id_list [i])
		end

	type: detachable TYPE_AS
			-- Specified type (if any).
		do
				-- Void by default.
		end

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
			-- First token in current AST node.
		do
			if
				attached a_list and then
				attached id_list.id_list as l_list and then
				not l_list.is_empty and then
				a_list.valid_index (l_list.first)
			then
				Result := a_list.i_th (l_list.first)
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
			-- Last token in current AST node.
		do
			if
				attached a_list and then
				attached id_list.id_list as l_list and then
				not l_list.is_empty and then
				a_list.valid_index (l_list.first)
			then
				Result := a_list.i_th (l_list.last)
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object?
		do
			Result := equal (id_list, other.id_list)
		end

invariant
	id_list_not_void: id_list /= Void

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
