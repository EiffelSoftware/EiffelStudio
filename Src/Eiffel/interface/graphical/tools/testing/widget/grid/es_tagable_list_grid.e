note
	description: "[
		Grid displaying a list of tagable items. The items are retreived from an ACTIVE_COLLECTION_I. The
		items in the grid are kept synchronized with the collection.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TAGABLE_LIST_GRID [G -> TAGABLE_I]

inherit
	ES_TAGABLE_GRID [G]

	ACTIVE_COLLECTION_OBSERVER [G]
		redefine
			on_item_added,
			on_item_removed,
			on_item_changed,
			on_items_reset
		end

create
	make

feature -- Access

	collection: !ACTIVE_COLLECTION_I [G]
			-- <Precursor>
		local
			l_collection: like internal_collection
		do
			l_collection := internal_collection
			check l_collection /= Void end
			Result := l_collection
		end

feature {NONE} -- Access

	internal_collection: ?like collection
			-- Internal storage for `collection'

feature -- Status report

	is_connected: BOOLEAN
			-- <Precursor>
		do
			Result := internal_collection /= Void
		end

	is_interface_usable: BOOLEAN
			-- <Precursor>
		do
			Result := not is_connected or else collection.is_interface_usable
		end

feature -- Status setting

	connect (a_collection: like collection)
			-- List all items of collection in grid.
			--
			-- `a_collection': Collection containing items which are listed in grid.
		require
			not_connected: not is_connected
			a_collection_usable: a_collection.is_interface_usable
		do
			internal_collection := a_collection
			collection.active_collection_connection.connect_events (Current)
			initialize_layout
			fill
		ensure
			connected: is_connected
			collection_set: collection = a_collection
		end

	disconnect
			-- Disconnect from `collection' and clear grid
		require
			connected: is_connected
		do
			collection.active_collection_connection.disconnect_events (Current)
			internal_collection := Void
		end

feature {NONE} -- Query

	row_index_for_item (a_item: G): INTEGER
			-- Row index of item in `grid'. Zero if item is not in grid.
		local
			i: INTEGER
		do
			from
				i := 1
			until
				Result > 0 or i > grid.row_count
			loop
				if {l_data: ES_TAGABLE_GRID_ITEM_DATA [G]} grid.row (i).data then
					if l_data.item = a_item then
						Result := i
					end
				end
				i := i + 1
			end
		end

feature -- Events

	on_item_added (a_collection: !ACTIVE_COLLECTION_I [G]; a_item: !G)
			-- <Precursor>
		local
			l_cursor: DS_LINEAR_CURSOR [G]
			i: INTEGER
		do
			l_cursor := a_collection.items.new_cursor
			from
				l_cursor.start
				i := 1
			until
				l_cursor.item = a_item
			loop
				i := i + 1
				l_cursor.forth
			end
			add_row_for_item (a_item, i)
			l_cursor.go_after
		end

	on_item_removed (a_collection: !ACTIVE_COLLECTION_I [G]; a_item: !G)
			-- <Precursor>
		do
			grid.remove_row (row_index_for_item (a_item))
		end

	on_item_changed (a_collection: !ACTIVE_COLLECTION_I [G]; a_item: !G)
			-- <Precursor>
		local
			l_item: EV_GRID_ITEM
		do
			l_item := computed_grid_item (1, row_index_for_item (a_item))
		end

	on_items_reset (a_collection: !ACTIVE_COLLECTION_I [G])
			-- <Precursor>
		do
			grid.remove_and_clear_all_rows
		end

feature {NONE} -- Implementation

	fill
			-- Fill grid with items in `collection'
		require
			connected: is_connected
			grid_empty: grid.row_count = 0
		local
			l_cursor: DS_LINEAR_CURSOR [!G]
			i: INTEGER
		do
			l_cursor := collection.items.new_cursor
			from
				i := 1
				l_cursor.start
			until
				l_cursor.after
			loop
				add_row_for_item (l_cursor.item, i)
				i := i + 1
				l_cursor.forth
			end
		end

	add_row_for_item (a_item: !G; a_pos: INTEGER)
			-- Insert row for item into grid at given position
		require
			connected: is_connected
			a_item_valid: collection.items.has (a_item)
			a_pos_valid: a_pos > 0 and a_pos <= grid.row_count + 1
		local
			l_row: EV_GRID_ROW
			l_new: ES_TAGABLE_GRID_ITEM_DATA [G]
		do
			grid.insert_new_row (a_pos)
			l_row := grid.row (a_pos)
			check l_row /= Void end
			create l_new.make (l_row, a_item)
		end

note
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
