indexing
    description: "Node for id. Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
    date: "$Date$"
    revision: "$Revision$"

class ID_AS

inherit
	LEAF_AS
		redefine
			is_equal
		end

	ATOMIC_AS
		rename
			string_value as name
		redefine
			is_id,
			is_equivalent,
			is_equal
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		redefine
			is_equal
		end

	HASHABLE
		rename
			hash_code as name_id
		redefine
			is_equal
		end

	DEBUG_OUTPUT
		export
			{NONE} all
		redefine
			is_equal
		end

create
	initialize,
	initialize_from_id

feature {NONE} -- Initialization

	initialize (s: STRING) is
			-- Create a new ID AST node made up
			-- of characters contained in `s'.
		require
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
		do
			names_heap.put (s)
			name_id := names_heap.found_item
		end

	initialize_from_id (a_id: like name_id)
			-- Create a new ID AST node representing a name already in the names heap.
		require
			id_in_names_heap: a_id > 0 and then names_heap.valid_index (a_id)
		do
			name_id := a_id
		end

feature -- Update

	set_name (a_name: like name) is
			-- Set `name' to `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
		do
			initialize (a_name)
		ensure
			name_set: name.is_equal (a_name)
		end

	to_upper
		do
			initialize (name.as_upper)
		end

	to_lower
		do
			initialize (name.as_lower)
		end

feature -- Access

	name_id: INTEGER
			-- ID representing the string in the names heap.

	name: STRING is
			-- Name of this id.
		do
			Result := names_heap.item (name_id)
		ensure then
			Result_ok: Result /= Void and then not Result.is_empty
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_id_as (Current)
		end

feature -- Properties

	is_id: BOOLEAN is True
			-- Is the current atomic node an id?

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' equal to the current object?
		do
			Result := name_id = other.name_id
		end

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := is_equal (other)
		end

feature {NONE} -- Implementation

	debug_output: STRING
		do
			Result := name
		end

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

end -- class ID_AS
