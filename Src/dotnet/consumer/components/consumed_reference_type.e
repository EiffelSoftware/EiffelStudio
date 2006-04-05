indexing
	description: "Type referenced by other types (as parent or interface) to be persisted to XML"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_REFERENCED_TYPE

inherit
	ANY
		redefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; id: INTEGER) is
			-- Set `name' with `a_name'.
			-- Set `assembly_id' with `id'.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
			valid_id: id > 0
		do
			n := a_name
			i := id
		ensure
			name_set: name = a_name
			id_set: assembly_id = id
		end

feature -- Access

	name: STRING is
			-- .NET type name
		do
			Result := n
		end

	assembly_id: INTEGER is
			-- Assembly containing type
		do
			Result := i
		end

	is_by_ref: BOOLEAN is
			-- Is current type a byref one?
		do
			Result := n.item (n.count) = '&'
		end

feature -- Setting

	set_is_by_ref is
			-- Set `is_byref'.
		do
			n.append_character ('&')
		ensure
			is_by_ref_set: is_by_ref
		end

feature {NONE} -- Access

	n: STRING
			-- Internal data for `name'.

	i: INTEGER
			-- Internal data for `assembly_id'.

feature {CONSUMED_ARGUMENT, OVERLOAD_SOLVER, CONSUMED_REFERENCED_TYPE, CONSUMED_TYPE} -- Comparison

	is_equal (other: CONSUMED_REFERENCED_TYPE): BOOLEAN is
			-- Only compare referenced types from same assembly as ids may change for other assemblies!
		do
			Result := other.name.is_equal (name) and other.assembly_id = assembly_id and
				other.is_by_ref = is_by_ref
		end

invariant
	non_void_name: name /= Void
	valid_name: not name.is_empty
	valid_assembly_id: assembly_id > 0

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


end -- class CONSUMED_REFERENCE_TYPE
