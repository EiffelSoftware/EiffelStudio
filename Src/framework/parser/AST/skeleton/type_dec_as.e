note
	description: "Abstract description of a typed variables declaration."

class TYPE_DEC_AS

inherit
	LIST_DEC_AS
		rename
			initialize as list_initialize
		redefine
			first_token,
			index,
			is_equivalent,
			last_token,
			process,
			type
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (i: like id_list; t: like type; c_as: like colon_symbol)
			-- Create a new TYPE_DEC AST node.
		require
			i_not_void: i /= Void
			t_not_void: t /= Void
		do
			list_initialize (i)
			type := t
			if c_as /= Void then
				colon_symbol_index := c_as.index
			end
		ensure
			id_list_set: id_list = i
			type_set: type = t
			colon_symbol_set: c_as /= Void implies colon_symbol_index = c_as.index
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_type_dec_as (Current)
		end

feature -- Roundtrip

	colon_symbol_index: INTEGER
			-- Index of symbol colon associated with this structure

	colon_symbol (a_list: LEAF_AS_LIST): detachable SYMBOL_AS
			-- Symbol colon associated with this structure
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := colon_symbol_index
			if a_list.valid_index (i) and then attached {SYMBOL_AS} a_list.i_th (i) as r then
				Result := r
			end
		end

	index: INTEGER
			-- <Precursor>
		do
			Result := colon_symbol_index
		end

feature -- Access

	type: TYPE_AS
			-- <Precursor>

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
			-- First token in current AST nodE
		do
			Result := Precursor (a_list)
			if not attached Result then
				Result := type.first_token (a_list)
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
			-- Last token in current AST node
		do
			Result := type.last_token (a_list)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := Precursor (other) and then equivalent (type, other.type)
		end

feature {TYPE_DEC_AS, AST_FORMAL_GENERICS_PASS2} -- Replication

	set_type (t: like type)
		require
			valid_t: t /= Void
		do
			type := t
		end

invariant
	type_not_void: type /= Void

note
	date: "$Date$"
	revision: "$Revision$"
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
