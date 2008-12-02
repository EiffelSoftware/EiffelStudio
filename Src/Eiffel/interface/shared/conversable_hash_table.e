indexing
	description: "[
					Hash table that provide a fast way to retrieve key by item.
					This is implemented by two hash table. We build the internal hash table until
					`key' is called. This implies that the first call of `key', `has_item' or `replace_item' might be slow.
					Later calls are fast. Note that element change after first call of `key', `has_item' or `replace_item'
					is twice slower than it was.
					]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONVERSABLE_HASH_TABLE [G -> HASHABLE, H -> HASHABLE]

inherit
	HASH_TABLE [G, H]
		redefine
			has_item,
			copy,
			put,
			replace,
			force,
			replace_key,
			remove,
			wipe_out,
			clear_all,
			make
		end

create
	make

feature -- Initialization

	make (n: INTEGER) is
			-- Allocate hash table for at least `n' items.
			-- The table will be resized automatically
			-- if more than `n' items are inserted.
		do
			Precursor {HASH_TABLE} (n)
			internal_table.make (0)
		end

	make_with_table (other: HASH_TABLE [G, H]) is
			-- Initialize with a hash table.
		require
			a_table_not_void: other /= Void
		do
			make (other.count)
			merge (other)
		end

feature -- Access

	key (a_item: G): ?H is
			-- Key associated with `item', if present;
		do
			if internal_table_built then
				build_internal_table
				internal_table_built := True
			end
			Result := internal_table.item (a_item)
		ensure
			internal_table_built: internal_table_built
		end

	has_item (v: ?G): BOOLEAN is
			-- Does structure include `v'?
			-- (Reference or object equality,
			-- based on `object_comparison'.)
		do
			if not internal_table_built then
				build_internal_table
			end
			Result := internal_table.has (v)
			found_key := internal_table.found_item
		ensure then
			internal_table_built: internal_table_built
		end

	valid_item (a_item: ?G): BOOLEAN is
			-- Valid `a_item'
		do
			Result := internal_table.valid_key (a_item)
		end

	found_key: ?H
			-- Key found during a search with `has_item' to reduce the number of
			-- search for clients

feature -- Element change

	put (new: ?G; a_key: ?H) is
			-- Insert `new' with `key' if there is no other item
			-- associated with the same key.
			-- Make `inserted' true if and only if an insertion has
			-- been made (i.e. `key' was not present).
			-- Set `found_item' to `new' if there is no conflict, otherwise
			-- to previous value.
		do
			Precursor {HASH_TABLE} (new, a_key)
			if internal_table_built then
				internal_table.put (a_key, new)
			end
		end

	replace (new: ?G; a_key: ?H) is
			-- Replace item at `a_key', if present,
			-- with `new'; do not change associated key.
			-- Make `replaced' true if and only if a replacement has
			-- been made (i.e. `key' was present).
		do
			check
				valid_item: valid_item (new)
			end
			Precursor {HASH_TABLE} (new, a_key)
			if internal_table_built then
				internal_table.replace (a_key, new)
			end
		end

	force (new: ?G; a_key: ?H) is
			-- If `a_key' is present, replace corresponding item by `new',
			-- if not, insert item `new' with key `a_key'.
			-- Make `inserted' true.
		do
			check
				valid_item: valid_item (new)
			end
			Precursor {HASH_TABLE} (new, a_key)
			if internal_table_built then
				internal_table.force (a_key, new)
			end
		end

	replace_key (new_key: ?H; old_key: ?H) is
			-- If table contains an item at `old_key',
			-- replace its key by `new_key'.
			-- Make `replaced' true if and only if a replacement has
			-- been made (i.e. `old_key' was present).
		local
			l_old_item: ?G
		do
			Precursor {HASH_TABLE} (new_key, old_key)
			if replaced then
				l_old_item := item (old_key)
				check
					l_old_item_not_void: l_old_item /= Void
				end
				internal_table.replace (new_key, l_old_item)
			end
		end

	replace_item (new_item: ?G; old_item: ?G) is
			-- If table contains `old_item',
			-- replace its key by `new_item'.
			-- Make `item_replaced' true if and only if a replacement has
			-- been made (i.e. `old_item' was present).
		require
			valid_items: valid_item (new_item) and valid_item (old_item)
		local
			l_old_key:? H
		do
			if not internal_table_built then
				build_internal_table
			end
			l_old_key := internal_table.item (old_item)
			if l_old_key /= Void then
				internal_table.replace_key (new_item, old_item)
				replace (new_item, l_old_key)
			end
		ensure
			changed: replaced implies not has_item (old_item)
		end

feature -- Removal

	remove (a_key: H) is
			-- Remove item associated with `key', if present.
			-- Make `removed' true if and only if an item has been
			-- removed (i.e. `key' was not present).
			-- Reset `found_item' to its default value if `removed'.
		local
			l_item: ?G
		do
			if internal_table_built then
				l_item := item (a_key)
				if l_item /= Void then
					internal_table.remove (l_item)
				end
			end
			Precursor {HASH_TABLE} (a_key)
		end

	wipe_out is
			-- Reset all items to default values.
		do
			Precursor
			internal_table.wipe_out
			internal_table_built := False
		end

	clear_all is
			-- Reset all items to default values.
		do
			wipe_out
		end

feature -- Duplication

	copy (other: like Current) is
			-- Re-initialize from `other'.
		do
			Precursor {HASH_TABLE} (other)
			set_internal_table (other.internal_table.twin)
			set_internal_table_buildt (internal_table_built)
		end

feature {CONVERSABLE_HASH_TABLE}-- Implementation

	set_internal_table (t: like internal_table) is
			-- Set `internal_table' with `t'.
		do
			internal_table := t
		end

	set_internal_table_buildt (b: like internal_table_built) is
			-- Set `internal_table_built' with `b'.
		do
			internal_table_built := b
		end

feature {CONVERSABLE_HASH_TABLE} -- Internal access

	internal_table_built: BOOLEAN
			-- Has `key' been called?

	internal_table: HASH_TABLE [H, G]
			-- Internal hash table

feature {NONE} -- Implementation

	build_internal_table is
			-- Build `internal_table' filling with element of current.
		do
			create internal_table.make (count)
			from
				start
			until
				after
			loop
				internal_table.put (key_for_iteration, item_for_iteration)
				forth
			end
		ensure
			internal_table_not_void: internal_table /= Void
		end

invariant
	internal_table_is_not_void: internal_table /= Void

indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
