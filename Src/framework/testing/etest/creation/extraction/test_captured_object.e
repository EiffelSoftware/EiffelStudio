note
	description: "[
		Representation of an debugee object that was captured by {EIFFEL_TEST_CAPTURER}.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_CAPTURED_OBJECT

feature {NONE} -- Initialize

	make_object (a_id: like id; a_type: like type)
			-- Initialize `Current'.
			--
			-- `a_id': Identifier for object.
			-- `a_type': Full type name of captured object
		do
			id := a_id
			type := a_type
		ensure
			id_set: id = a_id
			type_equals_a_type: type.is_equal (a_type)
		end

feature -- Access

	id: NATURAL
			-- Identifier for object
			--
			-- Note: Currently this is just a counter increasing for each object.

	type: STRING_32
			-- Full type name of captured object

	items: LIST [STRING]
			-- Items captured from original object
			--
			-- Note: The items are representet as manifest values. For example:
			--           The natural number 753 is stored as   {NATURAL_32} 753
			--           the character A is stored as          {CHARACTER_8} 'A'
			--           a reference to an other object        "#10"
		require
			has_items: has_items
		do
		end

	attributes: HASH_TABLE [STRING, STRING_32]
			-- Attribues captured from original object
			--
			-- keys: Atttribute names
			-- values: The attribute values when the object was captured
			-- Note: The values are representet as manifest values. For example:
			--           The natural number 753 is stored as   {NATURAL_32} 753
			--           the character A is stored as          {CHARACTER_8} 'A'
			--           a reference to an other object        "#10"
		require
			has_attributes: has_attributes
		do
		end

	string: STRING_32
			-- Content of original string object
		require
			is_string: is_string
		do
		end

feature -- Status report

	is_invariant_applicable: BOOLEAN
			-- Should object satisfy its invariants?
			--
			-- Note: if this is False it means the object was part of the call stack when capturing the
			--       application state, so it does not necessarily satisfy its invariants.

	has_items: BOOLEAN
			-- Does `Current' represent an object with items?
			--
			-- Note: namely these are SPECIAL, TUPLE and descendants of ROUTINE
		do
		end

	has_attributes: BOOLEAN
			-- Does `Current' represent an object with attributes?
		do
		end

	is_string: BOOLEAN
			-- Does `Current' represent a string object?
		do
		end

feature -- Status setting

	set_invariant_applicable (a_is_invariant_applicable: like is_invariant_applicable)
			-- Set `is_invariant_applicable' to `a_is_invariant_applicable'.
		do
			is_invariant_applicable := a_is_invariant_applicable
		ensure
			is_invariant_applicable_set: is_invariant_applicable = a_is_invariant_applicable
		end

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
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
