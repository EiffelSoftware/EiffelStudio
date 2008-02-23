indexing
	description: "Representation of a SERVER"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ISE_SERVER [G -> SERVER_INFO, T -> IDABLE]

inherit
	COMPILER_EXPORTER

	SHARED_SERVER

	SHARED_SCONTROL

feature -- Initialization

	make is
		do
			create tables.make (1)
		end

feature -- Access

	has, frozen server_has (i: INTEGER): BOOLEAN is
			-- Does the server contain an element of id `i'?
		require
			an_id_positive: i > 0
		do
			Result := tbl_has (i)
		end

	server_item, item (an_id: INTEGER): T is
			-- Object of id `an_id'
		require
			an_id_positive: an_id > 0
		deferred
		end

	disk_item (an_id: INTEGER):T is
			-- Object of id `an_id'
		require
			an_id_positive: an_id > 0
		deferred
		end

feature -- Removal

	remove (an_id: INTEGER) is
			-- Remove an element from the Server
		deferred
		ensure
			not_present: not has (an_id)
		end

feature -- Update

	clear is
			-- Clear the server.
		do
			cache.wipe_out
			clear_all
		end

feature -- Server size configuration

	Chunk: INTEGER is
			-- Hash table chunk
			-- We will add `Chunk' element during resizing.
		deferred
		end

feature -- Implementation

	cache: CACHE [T] is
			-- Server cache, to make things faster
		deferred
		ensure
			cache_not_void: Result /= Void
		end

feature {NONE} -- External features

	store_append (f_desc: INTEGER; object, make_index_proc, need_index_proc, s: POINTER): INTEGER is
		external
			"C inline use %"pstore.h%""
		alias
			"[
				return (EIF_INTEGER) store_append ((EIF_INTEGER) $f_desc, (EIF_REFERENCE) $object,
					(fnptr) $make_index_proc, (fnptr) $need_index_proc, (EIF_REFERENCE) $s);
			]"
		end

	retrieve_all (f_desc: INTEGER; pos: INTEGER): T is
		external
			"C | %"pretrieve.h%""
		end

	partial_retrieve (file_desc: INTEGER; pos, nb_obj: INTEGER): T is
		external
			"C | %"pretrieve.h%""
		end

feature -- Traversal

	start is
			-- Bring cursor to first position.
		do
			tables_index := 0
			tbl_forth
		end

	item_for_iteration: G is
			-- Element at current iteration position
		require
			not_off: not after
		do
			Result := current_table.item_for_iteration
		end

	key_for_iteration: INTEGER is
			-- Key at current iteration position
		require
			not_off: not after
		do
			Result := current_table.key_for_iteration
		end

	after: BOOLEAN is
			-- Is cursor past last item?
		do
			Result := current_table = Void
		end

	forth is
			-- Advance cursor to next occupied position,
			-- or off if no such position remains.
		require
			not_off: not after
		local
			l_table: like table_type
		do
			l_table := current_table
			l_table.forth
			if l_table.after then
				tbl_forth
			end
		end

feature -- Status report

	found: BOOLEAN
			-- Did last operation find the item sought?

	found_item: G
			-- Item, if any, yielded by last search operation

	count: INTEGER is
			-- Number of items in table
		local
			i, nb: INTEGER
			l_tables: like tables
			l_table: like table_type
		do
			from
				i := 0
				l_tables := tables
				nb := l_tables.count
			until
				i = nb
			loop
				l_table := l_tables.item (i)
				if l_table /= Void then
					Result := Result + l_table.count
				end
			end
		end

feature -- Search

	search (key: INTEGER) is
			-- Search for item of key `key'.
			-- If found, set found to true, and set
			-- found_item to item associated with `key'.
		local
			l_table: like table_type
			l_default: G
		do
			l_table := table_entry (key)
			if l_table /= Void then
				l_table.search (key)
				found := l_table.found
				found_item := l_table.found_item
			else
				found := False
				found_item := l_default
			end
		ensure
			found_or_not_found: found or not found
			item_if_found: found implies (found_item = tbl_item (key))
		end

feature -- Element change

	merge (other: like table_type) is
			-- Merge `other' into Current. If `other' has some elements
			-- with same key as in `Current', replace them by one from
			-- `other'.
		require
			other_not_void: other /= Void
		do
			from
				other.start
			until
				other.after
			loop
				tbl_force (other.item_for_iteration, other.key_for_iteration)
				other.forth
			end
		ensure
			inserted: other.current_keys.linear_representation.for_all (agent tbl_has)
		end

	clear_all is
			-- Reset all items to default values; reset status.
		do
			create tables.make (1)
		end

feature {NONE} -- HASH_TABLE like features

	tbl_computed_default_value: G
			-- Default value of type G
		do
		end

	tbl_item (key: INTEGER): G is
			-- Item associated with `key', if present
			-- otherwise default value of type `G'
		require
			key_valid: key >= 0
		local
			l_table: like table_type
		do
			l_table := table_entry (key)
			if l_table /= Void then
				Result := l_table.item (key)
			end
		ensure
			default_value_if_not_present: (not (tbl_has (key))) implies (Result = tbl_computed_default_value)
		end

	tbl_has (key: INTEGER): BOOLEAN is
			-- Is there an item in the table with key `key'?
		local
			l_table: like table_type
		do
			l_table := table_entry (key)
			Result := l_table /= Void and then l_table.has (key)
		end

	tbl_remove (key: INTEGER) is
			-- Remove item associated with `key', if present.
		local
			l_table: like table_type
		do
			l_table := table_entry (key)
			if l_table /= Void then
				l_table.remove (key)
			end
		ensure
			not_present: not tbl_has (key)
		end

	tbl_put (new: G; key: INTEGER) is
			-- Insert `new' with `key' if there is no other item
			-- associated with the same key.
		require
			key_valid: key >= 0
		do
			safe_table_entry (key).put (new, key)
		ensure
			present: tbl_has (key)
		end

	tbl_force (new: G; key: INTEGER) is
			-- Update table so that `new' will be the item associated
			-- with `key'.
			-- If there was an item for that key, set found
			-- and set found_item to that item.
			-- If there was none, set not found and set
			-- found_item to the default value.
		require
			key_valid: key >= 0
		local
			l_table: like table_type
		do
			l_table := safe_table_entry (key)
			l_table.force (new, key)
			found := l_table.found
			found_item := l_table.found_item
		ensure
			present: tbl_has (key)
			inserted: tbl_item (key) = new
		end

feature {NONE} -- Helpers

	table_type: HASH_TABLE [G, INTEGER] is do end
			-- For typing purposes.

	tables: SPECIAL [like table_type]
			-- All tables for current server.

	tbl_modulo: INTEGER is 100_000
			-- Maximum number of entries per HASH_TABLE.

	tables_index: INTEGER
	current_table: like table_type
			-- Cursor for traversing the server.

	table_entry (key: INTEGER): like table_type is
			-- Table in which `key' is or will be. If not yet present Void.
		require
			key_valid: key >= 0
		local
			i: INTEGER
			l_tables: like tables
		do
			i := key // tbl_modulo
			l_tables := tables
			if i < l_tables.count then
				Result := l_tables.item (i)
			end
		end

	safe_table_entry (key: INTEGER): like table_type is
			-- Table in which `key' is or will be. If not yet present,
			-- we create its associated table and possibly reallocate `tables'.
		require
			key_valid: key >= 0
		local
			i: INTEGER
			l_tables: like tables
		do
			i := key // tbl_modulo
			l_tables := tables
			if i >= l_tables.count then
				l_tables := l_tables.aliased_resized_area (i + 1)
				tables := l_tables
			end
			Result := l_tables.item (i)
			if Result = Void then
				create Result.make (chunk.min (tbl_modulo))
				l_tables.put (Result, i)
			end
		ensure
			table_entry_not_void: Result /= Void
		end

	tbl_forth  is
			-- Initiate a `forth' starting at position  `tables_index'.
		require
			tables_index_non_negative: tables_index >= 0
		local
			i, nb: INTEGER
			l_tables: like tables
			l_table: like table_type
		do
				-- Find first non-void entry in `tables'.
			from
				l_tables := tables
				l_table := Void
				i := tables_index
				nb := l_tables.count
			until
				l_table /= Void or i >= nb
			loop
				l_table := l_tables.item (i)
				if l_table /= Void then
					if not l_table.is_empty then
						l_table.start
					else
						l_table := Void
					end
				end
				i := i + 1
			end
			current_table := l_table
			tables_index := i
		end

invariant
	tables_not_void: tables /= Void

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

end -- class SERVER
