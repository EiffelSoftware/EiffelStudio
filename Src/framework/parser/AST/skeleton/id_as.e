note
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

	initialize (s: STRING)
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

	set_name (a_name: like name)
			-- Set `name' to `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
		do
			initialize (a_name)
		ensure
			name_set: name.is_equal (a_name)
		end

	set_name_id (a_name_id: like name_id)
			-- Set `name' to `a_name'.
		require
			a_name_id_positive: a_name_id > 0
		do
			name_id := a_name_id
		ensure
			name_id_set: name_id = a_name_id
		end

	to_upper
			-- Make sure `name' is in upper case
		local
			l_code: CHARACTER_8
			l_area: SPECIAL [CHARACTER_8]
			l_index: INTEGER
			l_needs_uppering: BOOLEAN
		do
				-- We only want to duplicate string if necessary
			from
				l_area := name.area
				l_index := l_area.count - 2
					-- We have to take null character in to account
			until
				l_index < 0
			loop
				l_code := l_area [l_index]
				if l_code /= l_code.as_upper then
						-- Character is lower case so we make sure `Current' is correctly initialized.
					l_needs_uppering := True
					l_index := -1
				else
					l_index := l_index - 1
				end
			end
			if l_needs_uppering then
				initialize (name.as_upper)
			end
		end

	to_lower
			-- Make sure `name' is in upper case
		local
			l_code: CHARACTER_8
			l_area: SPECIAL [CHARACTER_8]
			l_index: INTEGER
			l_needs_lowering: BOOLEAN
		do
				-- We only want to duplicate string if necessary
			from
				l_area := name.area
				l_index := l_area.count - 2
					-- We have to take null character in to account
			until
				l_index < 0
			loop
				l_code := l_area [l_index]
				if l_code /= l_code.as_lower then
						-- Character is upper case so we make sure `Current' is correctly initialized.
					l_needs_lowering := True
					l_index := -1
				else
					l_index := l_index - 1
				end
			end
			if l_needs_lowering then
				initialize (name.as_lower)
			end
		end

feature -- Access

	name_id: INTEGER
			-- ID representing the string in the names heap.

	name: STRING
			-- Name of this id.
		do
			Result := names_heap.item (name_id)
		ensure then
			Result_ok: Result /= Void and then not Result.is_empty
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_id_as (Current)
		end

feature -- Properties

	is_id: BOOLEAN = True
			-- Is the current atomic node an id?

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is `other' equal to the current object?
		do
			Result := name_id = other.name_id
		end

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := is_equal (other)
		end

feature {NONE} -- Implementation

	debug_output: STRING
		do
			Result := name
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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

end -- class ID_AS
