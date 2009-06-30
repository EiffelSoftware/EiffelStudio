note
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XRPC_MUTABLE_ARRAY

inherit
	XRPC_ARRAY
		export
			{ANY} copy_from_array
		redefine
			item
		end

create
	make_empty,
	make_from_array

convert
	make_from_array ({ARRAY [XRPC_VALUE]}),
	to_array: {ARRAY [XRPC_VALUE]}

feature -- Query

	item alias "[]" (a_index: NATURAL): XRPC_VALUE assign put
			-- <Precursor>
		do
			Result := Precursor (a_index)
		end

feature -- Extension

	put (a_item: XRPC_VALUE; a_index: NATURAL)
			-- Replaces an item in the array.
			--
			-- `a_item': New item to insert into the array.
			-- `a_index': The index to place the new item into.
		require
			a_item_attached: attached a_item
			a_index_is_valid_index: is_valid_index (a_index)
		do
			internal_array[a_index.as_integer_32] := a_item

				-- The content has changed as so must the linear representation.
			internal_linear_representation := Void
		ensure
			internal_linear_representation_detached: not attached internal_linear_representation
		end

	extend (a_item: XRPC_VALUE)
			-- Forces a new item to be insert at the end of the array.
			--
			-- `a_item': New item to insert into the array.
		require
			a_item_attached: a_item /= Void
		local
			l_array: like internal_array
		do
			l_array := internal_array
			l_array.force (a_item, l_array.count + 1)

				-- The content has changed as so must the linear representation.
			internal_linear_representation := Void
		ensure
			internal_linear_representation_detached: not attached internal_linear_representation
			count_incremented: count = old count + 1
			a_item_set:
		end

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
