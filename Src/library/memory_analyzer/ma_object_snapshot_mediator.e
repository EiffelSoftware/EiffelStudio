indexing
	description: "Objects that show the whole system's memory objects in a grid."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MA_OBJECT_SNAPSHOT_MEDIATOR

inherit
	MA_SINGLETON_FACTORY

create
	make_with_grid

feature -- Initlization

	make_with_grid (a_grid: EV_GRID) is
		require
			a_grid_not_void: a_grid /= Void
		do
			object_grid := a_grid

			object_grid.enable_single_row_selection
			object_grid.enable_tree
			object_grid.enable_partial_dynamic_content
			object_grid.insert_new_column (1)
			object_grid.insert_new_column (2)
			object_grid.insert_new_column (3)
			object_grid.column (1).set_title ("Object type")
			object_grid.column (2).set_title ("Count/Address")
			object_grid.column (3).set_title ("Delta/Start Object")
			object_grid.column (1).header_item.pointer_button_press_actions.force_extend (agent on_grid_header_click (1))
			object_grid.column (2).header_item.pointer_button_press_actions.force_extend (agent on_grid_header_click (2))
			object_grid.column (3).header_item.pointer_button_press_actions.force_extend (agent on_grid_header_click (3))

			object_grid.column (1).header_item.pointer_double_press_actions.force_extend (agent adjust_column_width (1))
			object_grid.column (2).header_item.pointer_double_press_actions.force_extend (agent adjust_column_width (2))
			object_grid.column (3).header_item.pointer_double_press_actions.force_extend (agent adjust_column_width (3))

			object_grid.set_pick_and_drop_mode
			object_grid.set_item_pebble_function (agent pick_item)

--			object_grid.set_item_pebble_function (agent pick_item_for_filter)
			show_memory_map
		ensure
			object_grid_column_added: object_grid.column_count = 3
			object_grid_accept_cursor_set: object_grid.accept_cursor /= Void
			object_grid_deny_curosor_set: object_grid.deny_cursor /= Void
		end

	adjust_column_width (a_column_index: INTEGER) is
			-- adjust a column width to fix the max width of the item its contain
		require
			a_column_index_valid: column_index_valid (a_column_index)
		do
			if object_grid.row_count > 0 then
				object_grid.column (a_column_index).set_width (object_grid.column (a_column_index).required_width_of_item_span (1, object_grid.row_count))
			end
		end

feature -- Command

	show_memory_map is
			-- Show memory map
		local
			l_new_table, l_old_table: HASH_TABLE [INTEGER, INTEGER]
			i: INTEGER
			l_int: INTERNAL
			l_name: STRING
			l_count, l_delta: INTEGER
			l_data: like grid_data
			l_map: HASH_TABLE [ARRAYED_LIST [ANY], INTEGER_32]
		do
				-- Reduce as much as possible relations.
			name_table := Void
			reference_table := Void
			selected_item := Void
			grid_data := Void
			once_object_table := Void
			selected_index := 0
			grid_util.grid_remove_and_clear_all_rows (object_grid)

				-- Get the data right away.
			system_util.collect
			l_new_table := memory.memory_count_map

				-- Process `l_new_table' and fill `output_grid' with associated data.
			from
				create l_int
				l_new_table.start
				l_old_table := last_table
				create l_data.make (l_new_table.count)
				if finding_route_to_once then
					create name_table.make (l_new_table.count * 40)
					create reference_table.make (l_new_table.count * 100)
					create object_table.make (1000)
					build_once_object_table
					l_map := memory.memory_map
					memory.collection_off
				end
				i := 1
			until
				l_new_table.after
			loop
				l_name := l_int.type_name_of_type (l_new_table.key_for_iteration)

				l_count := l_new_table.item_for_iteration

				if finding_route_to_once then
					add_to_reference_table (l_new_table.key_for_iteration, l_map)
				end

					-- Compute `l_delta' now.
				if l_old_table /= Void then
					l_old_table.search (l_new_table.key_for_iteration)
					if l_old_table.found then
						l_delta := l_new_table.item_for_iteration - l_old_table.found_item
						l_old_table.remove (l_new_table.key_for_iteration)
					else
						l_delta := l_new_table.item_for_iteration
					end
				else
					l_delta := l_new_table.item_for_iteration
				end
				l_data.force ([l_name, l_count, l_delta, l_new_table.key_for_iteration], i)
				i := i + 1
				l_new_table.forth
			end

			if l_old_table /= Void and then not l_old_table.is_empty then
				from
					l_old_table.start
				until
					l_old_table.after
				loop
					l_name := l_int.type_name_of_type (l_old_table.key_for_iteration)
					l_count := 0
					l_delta := - l_old_table.item_for_iteration
					l_data.force ([l_name, l_count, l_delta, l_old_table.key_for_iteration], i)
					i := i + 1
					l_old_table.forth
				end
			end

			if finding_route_to_once then
				memory.collection_on
				last_selected_object := Void
			end

			last_table := l_new_table
			grid_data := l_data

			update_grid_content
		end

	set_finding_route_to_once (a_b: BOOLEAN) is
			-- Set `finding_route_to_once' with `b'.
		do
			finding_route_to_once := a_b
		end

feature {NONE} -- Implementation

	pick_item (a_item: EV_GRID_LABEL_ITEM): MA_STONE is
			-- User pick one item from the grid.
		do
			if a_item /= Void and then a_item.column.index = 1 then
				-- If is an item represent a object. Only an item represent an object has been setted the data.
				if a_item.data /= Void then
					create {MA_OBJECT_STONE} Result.make (a_item.data)
					object_grid.set_accept_cursor (accept_node)
					object_grid.set_deny_cursor (deny_node)
				else
				-- If is an item represent a class.
					create {MA_CLASS_STONE} Result.make (a_item.text)
					object_grid.set_accept_cursor (accept_node_class)
					object_grid.set_deny_cursor (deny_node_class)
				end
			end
		end

	on_grid_header_click (a_column_index: INTEGER) is
			-- User click on the column header of index `a_column_index'.
		require
			a_column_index_valid: column_index_valid (a_column_index)
			output_grid_not_destroyed: not object_grid.is_destroyed
		do
			if object_grid.header.pointed_divider_index = 0 then
				if sorted_column = a_column_index then
						-- We invert the sorting.
					sorting_order := not sorting_order
				else
					sorted_column := a_column_index
					sorting_order := False
				end
				if grid_data /= Void then
					sort_data
					update_grid_content
				end
			end
		end

	sort_data is
			-- Sort `grid_data' according to `sorted_column' and `sorting_order'.
		require
			grid_data_not_void: grid_data /= Void
		local
			l_sorter: DS_QUICK_SORTER [like row_data]
			l_agent_sorter: AGENT_BASED_EQUALITY_TESTER [like row_data]
		do
			inspect
				sorted_column
				when 1 then create l_agent_sorter.make (agent sort_on_type_name)
				when 2 then create l_agent_sorter.make (agent sort_on_count)
				when 3 then create l_agent_sorter.make (agent sort_on_delta)
			end
			create l_sorter.make (l_agent_sorter)
			l_sorter.sort (grid_data)
		end

	update_grid_content is
			-- Fill grid using `grid_data'
		require
			grid_data_not_void: grid_data /= Void
		local
			l_data: like grid_data
			l_row_data: like row_data
			l_item: MA_GRID_LABEL_ITEM
			i, l_count, l_delta: INTEGER
			l_str: STRING
			l_row: EV_GRID_ROW
			l_grid: like object_grid
		do
			from
				l_data := grid_data
				l_grid := object_grid
				grid_util.grid_remove_and_clear_all_rows (l_grid)
				i := 1
				l_data.start
			until
				l_data.after
			loop
				l_row_data := l_data.item_for_iteration
				if not filter.filter_class (l_row_data.type_name) then
					l_str := l_row_data.type_name
					check
						l_str_not_void: l_str /= Void
					end

						-- Set type name
					create l_item.make_with_text (l_str)
					l_item.set_pixmap (icons.object_grid_class_icon)
					l_grid.set_item (1, i, l_item)

						-- Set count
					l_count := l_row_data.number_of_objects
					create l_item.make_with_text (l_count.out)
					l_grid.set_item (2, i, l_item)
					if l_count >= 1 then
						l_row := l_grid.row (i)
						l_row.ensure_expandable
						l_row.expand_actions.extend (agent on_expand_actions_for_type (l_row_data.type_id, l_row))
					end

						-- Set delta
					l_delta := l_row_data.variation_since_last_time
					if l_delta /= 0 then
						create l_item.make_with_text (l_delta.out)
						if l_delta > 0 then
							l_item.set_foreground_color (increased_color)
						else
							l_item.set_foreground_color (decreased_color)
						end
						l_grid.set_item (3, i, l_item)
					end
					i := i + 1
				end
				l_data.forth
			end
				-- We launch a collection, so that no bad information is displayed
				-- for referers.
			system_util.collect
		end

	on_expand_actions_for_type (a_dynamic_type: INTEGER; a_parent_row: EV_GRID_ROW) is
			-- Add all objects of the given dynamic type of `a_dynamic_type' as subnode
			-- of row `a_parent_row'.
		require
			output_grid_not_destroyed: not object_grid.is_destroyed
			a_dynamic_type_non_negative: a_dynamic_type >= 0
			a_parent_row_not_void: a_parent_row /= Void
		local
			l_data: ARRAYED_LIST [ANY]
			l_item: MA_GRID_LABEL_ITEM
			l_check_item: MA_GRID_CHECK_BOX_ITEM
			l_row_index, i: INTEGER
			l_row: EV_GRID_ROW
			l_any: ANY
		do
			if a_parent_row.subrow_count = 0 then

				l_data := memory.memory_map.item (a_dynamic_type)
				if l_data /= Void then

					debug ("larry")
						io.put_string ("%Nin MA_OBJECT_SNAPSHOT_MEDIATOR: void object? " + l_data.count.out + " orignal object is: " + internal.type_name_of_type (a_dynamic_type))
					end
					--| FIXIT: Why get void object here? There sometime a void object...?
					object_grid.insert_new_rows_parented (l_data.count, a_parent_row.index + 1, a_parent_row)
					from
						l_data.start
						l_row_index := a_parent_row.index
						i := l_row_index + 1
					until
						l_data.after
					loop
						if l_data.item /= Void then
							create l_item.make_with_text ((i - l_row_index).out)
							l_item.set_pixmap (icons.object_grid_icon)
							object_grid.set_item (1, i, l_item)
							l_item.set_data (l_data.item)
							l_any := l_data.item
							create l_item.make_with_text (($l_any).out)
							l_item.set_data (l_data.item)
							object_grid.set_item (2, i, l_item)

							create l_check_item.make_with_boolean (False)
							l_check_item.selected_changed_actions.extend (agent on_check_box_selected (?, l_any))
							object_grid.set_item (3, i, l_check_item)

							l_row := object_grid.row (i)
							l_row.ensure_expandable
							l_row.expand_actions.extend (agent on_expand_actions_for_referers (l_any, l_row))
							i := i + 1
						end
						l_data.forth
					end
				end
			end
		end

	on_expand_actions_for_referers (an_object: ANY; a_parent_row: EV_GRID_ROW) is
			-- Add all objects referring to `an_object' as subnode
			-- of row `a_parent_row'.
		require
			output_grid_not_destroyed: not object_grid.is_destroyed
			an_object_not_void: an_object /= Void
			a_parent_row_not_void: a_parent_row /= Void
		local
			l_data: SPECIAL [ANY]
			l_item: MA_GRID_LABEL_ITEM
			l_check_item: MA_GRID_CHECK_BOX_ITEM
			l_row_index: INTEGER
			i, j, nb: INTEGER
			l_int: INTERNAL
			l_any: ANY
			l_row: EV_GRID_ROW
			l_string: STRING
			l_count: INTEGER
		do
			if a_parent_row.subrow_count = 0 then
				l_data := memory.referers (an_object)
				if l_data /= Void then
					create l_int
					from
						j := 0
						nb := l_data.count
					until
						j = nb
					loop
						l_string := l_int.type_name (l_data.item (j))
						if not is_object_from_ma (l_string) then
							l_count := l_count + 1
						end
						j := j + 1
					end
					from
						l_row_index := a_parent_row.index
						i := l_row_index + 1
						j := 0
						nb := l_data.count
						object_grid.insert_new_rows_parented (l_count, i, a_parent_row)
					until
						j = nb
					loop
						l_string := l_int.type_name (l_data.item (j))
						if not is_object_from_ma (l_string) then
							create l_item.make_with_text ((i - l_row_index).out + ": " + l_string)
							l_item.set_data (l_data.item (j))
							l_item.set_pixmap (icons.object_grid_icon)
							object_grid.set_item (1, i, l_item)
							l_any := l_data.item (j)
							create l_item.make_with_text (($l_any).out)
							l_item.set_data (l_data.item (j))
							object_grid.set_item (2, i, l_item)
							create l_check_item.make_with_boolean (False)
							l_check_item.selected_changed_actions.extend (agent on_check_box_selected (?, l_any))
							object_grid.set_item (3, i, l_check_item)
							l_row := object_grid.row (i)
							l_row.ensure_expandable
							l_row.expand_actions.extend (agent on_expand_actions_for_referers (l_data.item (j), l_row))
							i := i + 1
						end
						j := j + 1
					end
				end
			end
		end

	on_check_box_selected (a_check_item: MA_GRID_CHECK_BOX_ITEM; a_object: ANY) is
			-- On check box selected.
		require
			a_check_item_not_void: a_check_item /= Void
		do
			if a_check_item.selected then
				last_selected_object := a_object
				if selected_item /= Void then
					selected_item.set_selected (False)
				end
				selected_item := a_check_item
			end
		end

	add_to_reference_table (a_object_id: INTEGER; a_map: HASH_TABLE [ARRAYED_LIST [ANY], INTEGER_32]) is
			-- Added all referer relations of objects of `a_object_id'.
		require
			tables_created: reference_table /= Void and name_table /= Void
			a_map_not_void: a_map /= Void
		local
			l_name, l_field_name: STRING
			l_int: INTERNAL
			l_objects_of_type: ARRAYED_LIST [ANY]
			l_index: NATURAL
			l_item, l_referee: ANY
			l_field_count: INTEGER
			i: INTEGER
			l_special: SPECIAL [ANY]
			l_tuple: TUPLE
			l_is_special, l_is_tuple: BOOLEAN
		do
			create l_int
			l_name := l_int.type_name_of_type (a_object_id)
			l_objects_of_type := a_map.item (a_object_id)
			l_field_count := l_int.field_count_of_type (a_object_id)
			l_is_special := l_int.is_special_any_type (a_object_id)
			l_is_tuple := l_int.is_tuple_type (a_object_id)
			from
				l_objects_of_type.start
			until
				l_objects_of_type.after
			loop
				l_item := l_objects_of_type.item
				l_index := object_table.index (l_item)
				if last_selected_object /= Void and then l_item = last_selected_object then
					selected_index := l_index
					last_selected_object := Void
				end
					--| Fixme: we don't know whether it is an once object or not.
				name_table.put (l_name, l_index)
				check
					not name_table.conflict
				end
				if l_is_special then
					l_special ?= l_item
					l_field_name := once "(special_field)"
					from
						i := l_special.lower
					until
						i > l_special.upper
					loop
						l_referee := l_special.item (i)
						if l_referee /= Void then
							reference_table.extend (l_index, object_table.index (l_referee), l_field_name)
						end
						i := i + 1
					end
				elseif l_is_tuple then
					l_tuple ?= l_item
					l_field_name := once "(tuple_field)"
					from
						i := l_tuple.lower
					until
						i > l_tuple.upper
					loop
						l_referee := l_tuple.item (i)
						if l_referee /= Void then
							reference_table.extend (l_index, object_table.index (l_referee), l_field_name)
						end
						i := i + 1
					end
				else
					from
						i := 1
					until
						i > l_field_count or l_item = Current
					loop
						l_referee := l_int.field (i, l_item)
						if l_referee /= Void then
							l_field_name := l_int.field_name (i, l_item)
							reference_table.extend (l_index, object_table.index (l_referee), l_field_name)
						end
						i := i + 1
					end
				end
				l_objects_of_type.forth
			end
		end

	build_once_object_table is
			-- Record once object in `once_object_table'.
		local
			l_obj: like once_objects
			i: INTEGER
			l_item: ANY
			l_index: like selected_index
			l_int: INTERNAL
		do
			create l_int
			create once_object_table.make (100)
			l_obj := once_objects
			from
				i := l_obj.lower
			until
				i > l_obj.upper
			loop
				l_item := l_obj.item (i)
				if l_item /= Void then
					l_index := object_table.index (l_item)
					once_object_table.force (l_index, l_index)
				end
				i := i + 1
			end
		end

feature -- Status report

	is_object_from_ma (a_str: STRING): BOOLEAN is
			-- If the type of object is from MA.
		do
			if a_str /= Void then
				Result := a_str.is_equal (once "MA_GRID_LABEL_ITEM") or else
						a_str.is_equal (once "TUPLE [MA_OBJECT_SNAPSHOT_MEDIATOR, ANY, EV_GRID_ROW]") or else
						--a_str.is_equal (once "MA_OBJECT_SNAPSHOT_MEDIATOR") or else
						a_str.is_equal (once "TUPLE [MA_OBJECT_SNAPSHOT_MEDIATOR, ANY]")
			end
		end

	column_index_valid (a_column_index: INTEGER): BOOLEAN  is
			-- Validate a column index.
		do
			Result := a_column_index > 0 and a_column_index <= object_grid.column_count
		end

	finding_route_to_once: BOOLEAN

feature {NONE} -- Fields

	row_data: TUPLE [type_name: STRING; number_of_objects: INTEGER; variation_since_last_time: INTEGER; type_id: INTEGER] is
			-- Type for the data inserted in `output_grid'
			-- It is [type_name, number_of_objects, variation_since_last_time, type_id].
		do
		end

	object_grid: EV_GRID
			-- the main grid to show object snapshot datas

	sorted_column: INTEGER
			-- Column on which sorting is done.	

	sorting_order: BOOLEAN
			-- If True, sorted from the smaller to the bigger.

	last_table: HASH_TABLE [INTEGER, INTEGER]
			-- Result of last call to `mem.memory_map_count' in `show_memory_map'.

	grid_data: DS_ARRAYED_LIST [like row_data]
			-- Data used to fill grid.

feature -- Access

	reference_table: MA_REFERENCES_TABLE [like selected_index, like selected_index]
			-- Reference addresses mapping at a certain time. [referrer index, referee index]

	object_table: SED_OBJECTS_TABLE
			-- Table to store all indice of objects.

	once_object_table: HASH_TABLE [like selected_index, like selected_index]
			-- Table to store all once objects.

	name_table: HASH_TABLE [STRING, like selected_index]
			-- Names of objects of addresses at a certain time. [Name, index]

	selected_index: NATURAL
			-- Index of `last_selected_object' at a time.

feature {NONE} -- Route building.

	last_selected_object: ANY
			-- A selected object.

	selected_item: MA_GRID_CHECK_BOX_ITEM
			-- All selected items.		

feature {NONE} -- Sorting Implemention

	sort_on_type_name (u, v: like row_data): BOOLEAN is
			-- Compare u, v.
		require
			u_not_void: u /= Void
			v_not_void: v /= Void
		local
			l_string1, l_string2: STRING
		do
			l_string1 := u.type_name
			l_string2 := v.type_name
			check
				l_string1_not_void: l_string1 /= Void
				l_string2_not_void: l_string2 /= Void
			end
			if sorting_order then
				Result := l_string1 < l_string2
			else
				Result := l_string2 < l_string1
			end
		end

	sort_on_count (u, v: like row_data): BOOLEAN is
			-- Compare u, v.
		require
			u_not_void: u /= Void
			v_not_void: v /= Void
		do
			if sorting_order then
				Result := u.number_of_objects < v.number_of_objects
			else
				Result := v.number_of_objects < u.number_of_objects
			end
		end

	sort_on_delta (u, v: like row_data): BOOLEAN is
			-- Compare u, v.
		require
			u_not_void: u /= Void
			v_not_void: v /= Void
		do
			if sorting_order then
				Result := u.variation_since_last_time < v.variation_since_last_time
			else
				Result := v.variation_since_last_time < u.variation_since_last_time
			end
		end

feature {NONE} -- Internal

	once_objects: SPECIAL [ANY] is
		do
			Result := {ISE_RUNTIME}.once_objects (special_any_dynamic_type)
		end

	special_any_dynamic_type: INTEGER is
			-- Dynamic type ID of an instance of `SPECIAL [ANY]'
		local
			a: ARRAY [ANY]
			spec: SPECIAL [ANY]
			l_inte: INTERNAL
		once
			create a.make (0, 0)
			spec := a.area
			create l_inte
			Result := l_inte.dynamic_type (spec)
		end

invariant
	object_grid_not_void: object_grid /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end
