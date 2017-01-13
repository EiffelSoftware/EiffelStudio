note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MA_ROUTE_TO_ONCE_SEARCHER

create
	make

feature {NONE} -- Initialization

	make (a_mediator: like snapshot_mediator; a_panel: EV_FRAME)
			-- Init
		require
			a_mediator_not_void: a_mediator /= Void
			a_panel_not_void: a_panel /= Void
		do
			result_panel := a_panel
			snapshot_mediator := a_mediator
		end

feature -- Commands

	build_next_route
			-- Build next route
		local
			l_info_box: EV_INFORMATION_DIALOG
		do
			name_table := snapshot_mediator.name_table
			reference_table := snapshot_mediator.reference_table
			once_objects_table := snapshot_mediator.once_object_table
			start_index := snapshot_mediator.selected_index
			if name_table = Void or reference_table = Void or start_index = 0 then
				create l_info_box.make_with_text ("Static object information is not collected.%N%
													%Or start point is not selected.%N%
													%Please select a start point in Object Grid%N%
													%and refresh again with Collecting Statics enabled.")
				l_info_box.show
			else
				build
			end
		end

	reset
			-- Reset
		do
			start_index := 0
			name_table := Void
			reference_table := Void
			wipe_out_results
		end

feature {NONE} -- Results

	result_panel: EV_FRAME
			-- Panel to put result grid

	grid: detachable EV_GRID
			-- Result grid

	fill_results
			-- Fill result
		require
			reference_table_set: attached reference_table
			name_table_set: attached name_table
			route_stack_set: attached route_stack
		local
			l_array: LIST [like start_index]
			l_item: EV_GRID_LABEL_ITEM
			l_column: INTEGER
			l_text: STRING
			l_next_index: like start_index
			l_field_name: detachable STRING
			l_once: STRING
			l_last: BOOLEAN
			l_name_table: like name_table
			l_grid: like grid
		do
			l_grid := grid
			if l_grid = Void then
				create l_grid
				grid := l_grid
				init_grid (l_grid)
				result_panel.extend (l_grid)
			end
			l_column := l_grid.column_count + 1
			if attached route_stack as l_route_stack then
				l_array := l_route_stack.linear_representation
				l_grid.set_row_count_to (l_array.count.max (l_grid.row_count))
				l_grid.set_column_count_to (l_column)
				l_grid.column (l_column).set_title ("Route" + l_column.out)
				from
					l_array.start
				until
					l_array.after
				loop
					if not l_array.islast then
						l_next_index := l_array [l_array.index + 1]
					else
						l_last := True
					end
					if not l_last then
						if attached reference_table as l_reference_table then
							if attached l_reference_table.references_by_referee (l_next_index).item (l_array.item) as l_tuple then
								if attached {STRING} l_tuple.data as l_string then
									l_field_name := l_string
								else
										--|FIXME: 2012/04/06 Shouldn't this be "(unknown)", instead of setting it Void? See review#7644004.
									l_field_name := Void
								end
							else
								l_field_name := once "(unknown)"
							end
						else
								--|FIXME: 2012/04/06 Shouldn't this be "(unknown)", instead of setting it Void? See review#7644004.
							l_field_name := Void
							check reference_table_set: False end -- Implied by precondition
						end
					else
							--|FIXME: 2012/04/06 Shouldn't this be "(unknown)", instead of setting it Void? See review#7644004.
						l_field_name := Void
					end
					if l_field_name = Void then
						l_field_name := once ""
					else
						l_field_name := l_field_name.twin
						l_field_name.prepend (".")
					end
						-- Optimization, since we know that only the first object is once object.
					if l_array.isfirst then
						l_once := once "*"
					else
						l_once := once ""
					end

					create l_text.make (10)
					l_text.append (l_once)
					l_text.append (l_array.item.out)
					l_text.append_character (':')
					l_text.append_character (' ')

					l_name_table := name_table
					if l_name_table = Void then
						check name_table_set: False end -- Implied by precondition
					else
						if attached l_name_table.item (l_array.item) as l_name_table_item then
							l_text.append_character ('{')
							l_text.append (l_name_table_item)
							l_text.append_character ('}')
						end
					end
					l_text.append (l_field_name)
					create l_item.make_with_text (l_text)
					l_item.set_tooltip (l_text)
					l_grid.set_item (l_column, l_array.index, l_item)
					l_array.forth
				end
			else
				check route_stack_set: False end -- Implied by precondition
			end
		end

	wipe_out_results
			-- Wipe out all results.
		do
			result_panel.wipe_out
			grid := Void
		end

	init_grid (a_grid: EV_GRID)
			-- Init grid with copy funcion.
		require
			a_grid_not_void: a_grid /= Void
		do
			a_grid.enable_multiple_item_selection
			a_grid.enable_selection_key_handling
			a_grid.key_press_actions.extend (agent on_grid_key_pressed)
		end

	on_grid_key_pressed (a_key: EV_KEY)
			-- Support Copy.
		require
			a_key_not_void: a_key /= Void
			grid_set: attached grid
		local
			l_env: EV_ENVIRONMENT
			l_grid: like grid
		do
			create l_env
			if attached l_env.application as l_app and then l_app.ctrl_pressed then
				inspect a_key.code
				when {EV_KEY_CONSTANTS}.key_a then
					l_grid := grid
					if l_grid /= Void then
						select_all_row (l_grid)
					else
						check grid_set: False end
					end
				when {EV_KEY_CONSTANTS}.key_c then
					l_grid := grid
					if l_grid /= Void then
						if not l_grid.selected_items.is_empty then
							copy_selected_items (l_grid)
						end
					else
						check grid_set: False end
					end
				else
				end
			end
		end

	select_all_row (a_grid: EV_GRID)
			-- Select all rows of `a_grid'.
		require
			a_grid_not_void: a_grid /= Void
		local
			i, l_count: INTEGER
		do
			l_count := a_grid.row_count
			from
				i := 1
			until
				i > l_count
			loop
				a_grid.row (i).enable_select
				i := i + 1
			end
		end

	copy_selected_items (a_grid: EV_GRID)
			-- Copy all selected items in `a_grid'.
		require
			a_grid_not_void: a_grid /= Void
		local
			i, j, l_column_count, l_row_count, l_column_selected_count: INTEGER
			l_column: EV_GRID_COLUMN
			l_row: EV_GRID_ROW
			l_text: STRING_32
			l_states: SPECIAL [INTEGER]
			l_none, l_part, l_full: INTEGER
			l_has_full: BOOLEAN
		do
				-- Constants for column states.
			l_none := 1
			l_part := 2
			l_full := 3

			l_column_count := a_grid.column_count
			l_row_count := a_grid.row_count
			create l_states.make_filled (0, l_column_count + 1)
			create l_text.make (100)
			from
				i := 1
			until
				i > l_column_count
			loop
				l_column := a_grid.column (i)
				l_column_selected_count := l_column.selected_items.count
				if l_column_selected_count = l_column.count then
					l_states.put (l_full, i)
					l_has_full := True
				elseif l_column_selected_count = 0 then
					l_states.put (l_none, i)
				else
					l_states.put (l_part, i)
				end
				i := i + 1
			end
				-- Put titles, if has full selected column.
			if l_has_full then
				from
					i := 1
				until
					i > l_column_count
				loop
					if l_states.item (i) /= l_none then
						l_column := a_grid.column (i)
						l_text.append (l_column.title)
						l_text.append ("%T")
					end
					i := i + 1
				end
				l_text.append ("%N")
			end

			from
				i := 1
			until
				i > l_row_count
			loop
				l_row := a_grid.row (i)
				if not l_row.selected_items.is_empty then
					from
						j := 1
					until
						j > l_column_count
					loop
						if l_states.item (j) /= l_none then
							if attached {EV_GRID_LABEL_ITEM} l_row.item (j) as l_text_item and then l_text_item.is_selected then
								l_text.append (l_text_item.text)
								l_text.append ("%T")
							else
								l_text.append ("%T")
							end
						end
						j := j + 1
					end
					l_text.append ("%N")
				end
				i := i + 1
			end
			if attached (create {EV_ENVIRONMENT}).application as l_app then
				l_app.clipboard.set_text (l_text)
			else
				check False end -- Implied by application is running
			end
		end

feature {NONE} -- Implementation

	build
			-- Build route.
		require
			reference_table_set: attached reference_table
		local
			l_route_stack: like route_stack
		do
			create l_route_stack.make (1000)
			route_stack := l_route_stack
			if attached reference_table as l_reference_table then
				create visited_references.make (l_reference_table.referee_count)
				if deep_visit_node (start_index) then
					-- Found route
					check
						route_stack_not_empty: not l_route_stack.is_empty
					end
					fill_results
					remove_last_link_to_once
				end
			else
				check reference_table_set: False end -- Implied by precondition
			end
		end

	start_index: NATURAL
			-- Start index of the object

	snapshot_mediator: MA_OBJECT_SNAPSHOT_MEDIATOR
			-- Snapshot mediator

	name_table: detachable HASH_TABLE [STRING, like start_index]
			-- Names of type of objects

	reference_table: detachable MA_REFERENCES_TABLE [like start_index, like start_index]
			-- All object relations

	once_objects_table: detachable HASH_TABLE [like start_index, like start_index]
			-- All once objects

feature {NONE} -- Implementation

	deep_visit_node (a_referee: like start_index): BOOLEAN
			-- Deep visit a node, Ture is found once object.
		require
			reference_table_set: attached reference_table
			route_stack_set: attached route_stack
			visited_references_set: attached visited_references
		local
			l_all_referrers, l_visited_referrers: HASH_TABLE [TUPLE [like start_index, detachable ANY], like start_index]
			l_referrer: like start_index
			l_all_referrers_count: INTEGER
		do
			if is_visited (a_referee) then
				Result := False
			elseif
				attached route_stack as l_route_stack and
				attached reference_table as l_reference_table
			then
				l_route_stack.put (a_referee)
				l_all_referrers := l_reference_table.references_by_referee (a_referee)
				l_all_referrers_count := l_all_referrers.count
				if l_all_referrers_count = 0 then
						-- We reach the end. No referrer.
					Result := is_once_object (a_referee)
				elseif is_once_object (a_referee) then
					Result := True
				elseif attached visited_references as l_visited_references then
					l_visited_referrers := l_visited_references.references_by_referee (a_referee)
					if l_all_referrers_count = l_visited_referrers.count then
							-- Go back one
						Result := False
						l_route_stack.remove
					else
						from
							l_all_referrers.start
						until
							l_all_referrers.after or Result
						loop
							l_referrer := l_all_referrers.key_for_iteration
							if not l_visited_referrers.has_key (l_referrer) then
								l_visited_references.extend (l_referrer, a_referee, Void)
								Result := deep_visit_node (l_referrer)
							end
							l_all_referrers.forth
						end
						if not Result then
							l_route_stack.remove
						end
					end
				else
					check visited_references_set: False end -- Implied by precondition
				end
			else
				check route_stack_set: route_stack /= Void end -- Implied by precondition
				check reference_table_set: reference_table /= Void end -- Implied by precondition
			end
		end

	remove_last_link_to_once
			-- Remove last found link to once in `reference_table'.
			-- So that next searching will not return found routes anymore.
		require
			ready: attached reference_table
		local
			l_referrer, l_referee: like start_index
			l_route: ARRAYED_LIST [like start_index]
		do
			if attached route_stack as l_route_stack and then l_route_stack.count > 1 then
				l_route := l_route_stack.linear_representation
				l_referrer := l_route [1]
				l_referee := l_route [2]
				if attached reference_table as l_table then
					l_table.remove (l_referrer, l_referee)
				else
					check False end -- Implied by precondition `ready'
				end
			end
		end

	is_visited (a_node: like start_index): BOOLEAN
			-- Is `a_node' visited?
		require
			route_stack_set: attached route_stack
		do
			if attached route_stack as l_route_stack then
				Result := l_route_stack.has (a_node)
			else
				check route_stack_set: False end -- Implied by precondition
			end
		end

	is_once_object (a_object: like start_index): BOOLEAN
			-- Is `a_object' once?
		require
			once_objects_table_set: attached once_objects_table
		do
			if attached once_objects_table as l_table then
				Result := l_table.has (a_object)
			else
				check once_objects_table_set: False end -- Implied by precondition
			end
		end

	route_stack: detachable ARRAYED_STACK [like start_index]

	visited_references: detachable MA_REFERENCES_TABLE [like start_index, like start_index]
			-- Visited references.
			-- `visited_backable_nodes.references_by_referee (a_node)' gives all visited references to `a_node'.

invariant
	snapshot_mediator_not_void: snapshot_mediator /= Void
	result_panel_not_void: result_panel /= Void

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"



end
