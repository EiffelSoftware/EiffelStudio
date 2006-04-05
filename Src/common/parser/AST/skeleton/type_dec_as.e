indexing
	description:
		"Abstract description of a type declaration. %
		%Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class TYPE_DEC_AS

inherit
	AST_EIFFEL
		redefine
			is_equivalent
		end

	SHARED_NAMES_HEAP

create
	initialize

feature {NONE} -- Initialization

	initialize (i: like id_list; t: like type; c_as: SYMBOL_AS) is
			-- Create a new TYPE_DEC AST node.
		require
			i_not_void: i /= Void
			t_not_void: t /= Void
		do
			id_list := i
			type := t
			colon_symbol := c_as
		ensure
			id_list_set: id_list = i
			type_set: type = t
			colon_symbol_set: colon_symbol = c_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_type_dec_as (Current)
		end

feature -- Roundtrip

	colon_symbol: SYMBOL_AS
		-- Symbol colon associated with this structure

feature -- Access

	id_list: CONSTRUCT_LIST [INTEGER]
			-- List of ids

	type: TYPE_AS
			-- Type

	item_name (i: INTEGER): STRING is
			-- Name of `id' at position `i'.
		require
			valid_index: id_list.valid_index (i)
		do
			Result := Names_heap.item (id_list.i_th (i))
		ensure
			Result_not_void: Result /= Void
			Result_not_empty: not Result.is_empty
		end

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
			-- First token in current AST node
		local
			l_id_list: IDENTIFIER_LIST
		do
			if a_list = Void then
				Result := type.first_token (a_list)
			else
				l_id_list ?= id_list
				Result := l_id_list.id_list.first_token (a_list)
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
			-- Last token in current AST node
		do
			Result := type.last_token (a_list)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equal (id_list, other.id_list) and then
				equivalent (type, other.type)
		end

feature {TYPE_DEC_AS, LOCALS_MERGER} -- Replication

	set_type (t: like type) is
		require
			valid_t: t /= Void
		do
			type := t
		end;

	set_id_list (id: like id_list) is
		require
			valid_t: id /= Void
		do
			id_list := id
		end;

invariant
	type_not_void: type /= Void
	id_list_not_void: id_list /= Void

indexing
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

end -- class TYPE_DEC_AS
