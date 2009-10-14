note
	description: "[
		Hash table used to store tags as {IMMUTABLE_STRING_8} but also providing queries for more
		general string arguments.

		`same_keys' uses {READABLE_STRING_8}.same_string for key comparism.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TAG_HASH_TABLE [G]

inherit
	HASH_TABLE [G, IMMUTABLE_STRING_8]
		rename
			has as has_immutable,
			force as force_immutable,
			item as immutable_item,
			search as search_immutable,
			remove as remove_immutable
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

feature -- Query

	has (key: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `access_key' currently used?
		require
			valid_key: valid_key (immutable_string (key))
		do
			Result := has_immutable (immutable_string (key))
		ensure
			default_case: (immutable_string (key) = computed_default_key) implies (Result = has_default)
		end

	same_keys (a_search_key, a_key: IMMUTABLE_STRING_8): BOOLEAN
			-- <Precursor>
		do
			Result := a_search_key.same_string (a_key)
		end

feature -- Element change

	force (new: G; key: IMMUTABLE_STRING_8)
			-- Update table so that `new' will be the item associated
			-- with `key'.
			-- If there was an item for that key, set `found'
			-- and set `found_item' to that item.
			-- If there was none, set `not_found' and set
			-- `found_item' to the default value.
			--
			-- To choose between various insert/replace procedures,
			-- see `instructions' in the Indexing clause.
		require
			key_valid: valid_key (immutable_string (key))
		do
			force_immutable (new, immutable_string (key))
		ensure
			insertion_done: item (immutable_string (key)) = new
			now_present: has (immutable_string (key))
			found_or_not_found: found or not_found
			not_found_if_was_not_present: not_found = not (old has (key))
			same_count_or_one_more: (count = old count) or (count = old count + 1)
			found_item_is_old_item: found implies (found_item = old (item (immutable_string (key))))
			default_value_if_not_found: not_found implies (found_item = computed_default_value)
			default_property: has_default = ((immutable_string (key) = computed_default_key) or ((key /= computed_default_key) and (old has_default)))
		end

	remove (key: READABLE_STRING_GENERAL)
			--
		do
			remove_immutable (immutable_string (key))
		end

	item (key: READABLE_STRING_GENERAL): detachable G
			-- Item associated with `key', if present
			-- otherwise default value of type `G'
		require
			key_valid: valid_key (immutable_string (key))
		do
			Result := immutable_item (immutable_string (key))
		ensure
			default_value_if_not_present: (not (has (immutable_string (key)))) implies (Result = computed_default_value)
		end

feature -- Basic operations

	search (key: READABLE_STRING_GENERAL)
			-- Search for item of key `key'.
			-- If `found', set found to true, and set
			-- `found_item' to item associated with `key'.
		do
			search_immutable (immutable_string (key))
		ensure
			found_or_not_found: found or not_found
			item_if_found: found implies (found_item = item (immutable_string (key)))
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
