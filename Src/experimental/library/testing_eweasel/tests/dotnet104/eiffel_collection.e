indexing
	description: "[
		A generic ICollection wrapper for Eiffel.
	]"
	date       : "$Date$"
	revision   : "$Revision$"
	legal      : "See notice at end of class."
	status     : "See notice at end of class."

class
	EIFFEL_COLLECTION [G -> SYSTEM_OBJECT]

inherit
	ARRAY_LIST
		rename
			item as item alias "[]"
		redefine
			sync_root,
			add,
			contains,
			index_of_object,
			index_of_object_integer_32,
			index_of_object_integer_32_integer_32,
			insert,
			item,
			remove,
			set_item
		end

create
	make,
	make_from_c,
	make_from_capacity

feature --

	sync_root: G is
			-- Gets an object that can be used to synchronize access to the collection
		do
			Result ?= Precursor {ARRAY_LIST}
		end

feature -- ILIST*:

	add (value: G): INTEGER is
			-- Adds an object to the end of the collection
		do
			Result := Precursor {ARRAY_LIST} (value)
		end

	contains (value: G): BOOLEAN is
			-- Determines whether an element is in the collection
		do
			Result := Precursor {ARRAY_LIST} (value)
		end

	index_of_object (value: G): INTEGER is
			-- Returns the zero-based index of the first occurrence of a value in the collection or in a portion of it.
		do
			Result := Precursor {ARRAY_LIST} (value)
		end

	index_of_object_integer_32 (value: G; start_index: INTEGER): INTEGER is
			-- Returns the zero-based index of the first occurrence of a value in the collection or in a portion of it.
		do
			Result := Precursor {ARRAY_LIST} (value, start_index)
		end

	index_of_object_integer_32_integer_32 (value: G; start_index: INTEGER; count_: INTEGER): INTEGER is
			-- Returns the zero-based index of the first occurrence of a value in the collection or in a portion of it.
		do
			Result := Precursor {ARRAY_LIST} (value, start_index, count_)
		end

	insert (index: INTEGER; value: G) is
			-- Inserts an element into the collection at the specified index.
		do
			Precursor {ARRAY_LIST} (index, value)
		end

	item alias "[]" (index: INTEGER): G is
			-- Gets the element at the specified index.
		do
			Result ?= Precursor {ARRAY_LIST} (index)
		end

	remove (value: G) is
			-- Removes the first occurrence of a specific object from the collection
		do
			Precursor {ARRAY_LIST} (value)
		end

	set_item (index: INTEGER; value: G) is
			-- Sets the element at the specified index.
		do
			Precursor {ARRAY_LIST} (index, value)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EIFFEL_COLLECTION
