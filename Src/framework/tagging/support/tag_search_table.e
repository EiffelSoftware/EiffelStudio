note
	description: "[
		Search table used to store tags as {IMMUTABLE_STRING_8} but also providing queries for more
		general string arguments.
		
		`same_keys' uses {READABLE_STRING_8}.same_string for key comparism.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TAG_SEARCH_TABLE

inherit
	SEARCH_TABLE [IMMUTABLE_STRING_8]
		rename
			has as has_immutable,
			force as force_immutable,
			item as immutable_item,
			search as search_immutable
		redefine
			same_keys
		end

	TAG_CONVERSION
		undefine
			is_equal,
			copy
		end

create
	make

create {TAG_SEARCH_TABLE}
	make_with_key_tester

feature -- Query

	has (key: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `access_key' currently used?
		require
			valid_key: valid_key (immutable_string (key))
		do
			Result := has_immutable (immutable_string (key))
		end

	same_keys (a_search_key, a_key: IMMUTABLE_STRING_8): BOOLEAN
			-- <Precursor>
		do
			Result := a_search_key.same_string (a_key)
		end

feature -- Element change

	force (key: READABLE_STRING_GENERAL)
			-- If `key' is present, replace corresponding item by `new',
			-- if not, insert item `new' with key `key'.
			-- Set `control' to `Inserted'.
		require
			key_valid: valid_key (immutable_string (key))
		do
			force_immutable (immutable_string (key))
		ensure
			insertion_done: item (key).same_string_general (key)
		end

	item (key: READABLE_STRING_GENERAL): detachable IMMUTABLE_STRING_8
			-- Item associated with `key', if present
			-- otherwise default value of type `G'
		require
			key_valid: valid_key (immutable_string (key))
		do
			Result := immutable_item (immutable_string (key))
		end

feature -- Basic operations

	search (key: READABLE_STRING_GENERAL)
			-- Search for item of key `key'
			-- If found, set `found' to True, and set
			-- `found_item' to item associated with `key'.
		do
			search_immutable (immutable_string (key))
		ensure
			item_if_found: found implies (found_item = content.item (position))
		end

note
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
