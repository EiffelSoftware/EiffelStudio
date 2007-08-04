indexing
	description	: "[
		An EiffelStudio base implementation for all tools implementing a derviation of an event list tool. The tool is based on the 
		ecosystem event list service {EVENT_LIST_SERVICE_I}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

deferred class
	ES_EVENT_LIST_TOOL_BASE

inherit
	ES_DOCKABLE_TOOL_WINDOW [ES_GRID]
		rename
			user_widget as grid_events
		redefine
			on_before_initialize,
			internal_recycle
		end

feature {NONE} -- Initialization

	on_before_initialize
			-- Use to perform additional creation initializations
		local
			l_service: EVENT_LIST_SERVICE_I
		do
			Precursor {ES_DOCKABLE_TOOL_WINDOW}

				-- Retrieve event list service
			l_service ?= service_provider.query_service ({EVENT_LIST_SERVICE_S})
			if l_service /= Void then
				l_service.item_added_events.subscribe (agent on_event_added)
				l_service.item_changed_events.subscribe (agent on_event_changed)
				l_service.item_removed_events.subscribe (agent on_event_removed)
			end
			event_service := l_service
		end

feature {NONE} -- User interface initialization

	build_tool_interface (a_widget: ES_GRID)
			-- Builds the tools user interface elements.
			-- Note: This function is called prior to showing the tool for the first time.
			--
			-- `a_widget': A widget to build the tool interface using.
		do
			create grid_search_component.make (grid_events)

				-- Prepare search facilities
			create quick_search_bar.make (develop_window)
			quick_search_bar.attach_tool (grid_search_component)
			grid_search_component.enable_search

			update_content_applicable_widgets (item_count > 0)
		end

feature {NONE} -- Clean up

	internal_recycle
			-- Recycle tool.
		do
			Precursor {ES_DOCKABLE_TOOL_WINDOW}

			if event_service /= Void then
				event_service.item_added_events.unsubscribe (agent on_event_added)
				event_service.item_changed_events.unsubscribe (agent on_event_changed)
				event_service.item_removed_events.unsubscribe (agent on_event_removed)
			end
		end

feature {NONE} -- Access

	frozen item_count: NATURAL
			-- Number of items currently managed by the list

	maximum_item_count: NATURAL
			-- Maximum number of items displayable by the list.
			-- Note: Use 0 to indicate no maximum.
		do
			Result := 0
		end

	frozen event_service: EVENT_LIST_SERVICE_I
			-- Event service the user interface is connected to

	grid_search_component: EVS_SEARCHABLE_COMPONENT [STRING]
			-- Helper component to enable grid searching

feature {NONE} -- User interface elements

	quick_search_bar: EB_GRID_QUICK_SEARCH_TOOL
			-- Tool to quick search items

feature -- Status report

	scroll_list_automatically: BOOLEAN
			-- Indicates if the list should automatically scroll to
			-- the last item when a new item is added.
		local
			l_grid: like grid_events
		do
			Result := maximum_item_count = 0
			if Result then
					-- Permits automatic scrolling if the user did not scroll the last added
					-- item out of view.
				l_grid := grid_events
				Result := l_grid.row_count = 0 or else
					l_grid.last_visible_row = l_grid.row (l_grid.row_count)
			end
		end

	destory_old_items_automatically: BOOLEAN
			-- Indicates if old event items should be destroyed automatically in a FIFO fashion.
		do
			Result := maximum_item_count > 0
		end

feature {NONE} -- Basic operations

	find_event_row (a_event_item: EVENT_LIST_ITEM_I): EV_GRID_ROW
			-- Attempts to locate a grid row for event `a_event_item'
		require
			a_event_attached: a_event_item /= Void
			a_event_is_appliable_event: is_appliable_event (a_event_item)
		local
			l_grid: like grid_events
			l_row: EV_GRID_ROW
			l_count, i: INTEGER
		do
			l_grid := grid_events
			from
				i := 1
				l_count := l_grid.row_count
			until
				i > l_count or Result /= Void
			loop
				l_row := l_grid.row (i)
				if l_row.data = a_event_item then
					Result := l_row
				else
					i := i + 1
				end
			end
		end

	do_default_action (a_row: EV_GRID_ROW) is
			-- Performs a default actions for a given row.
			--
			-- `a_row': The row the user requested an action to be performed on.
		require
			a_row_attached: a_row /= Void
			a_row_has_parent: a_row.parent /= Void
			a_row_is_in_grid_events: a_row.index <= grid_events.row_count and then
				grid_events.row (a_row.index) = a_row
		deferred
		end

feature {NONE} -- Navigation

	move_next (a_query_action: FUNCTION [ANY, TUPLE [EVENT_LIST_ITEM_I], BOOLEAN])
			-- Moves to the next item in the errors and warnings list based on some fundamental conditions.
			--
			-- `a_query_function': The function to determine if a matched event list item is applicable.
		require
			a_query_action_attached: a_query_action /= Void
		local
			l_grid: like grid_events
			l_row_count: INTEGER
			l_index: INTEGER
			l_stop_index: INTEGER
			l_row: EV_GRID_ROW
			l_item: EVENT_LIST_ITEM_I
			l_found: BOOLEAN
		do
			l_grid := grid_events
			l_row_count := l_grid.row_count
			if l_row_count > 0 then
				if l_grid.selected_rows.is_empty then
					l_index := 0
				else
					l_row := l_grid.selected_rows.last
					l_index := l_row.index + l_row.subrow_count_recursive
				end
				l_index := l_index + 1
				if l_index > l_row_count then
						-- Cycle index
					l_index := 1
				end

				from
					l_row := Void
				until
					l_found or
					l_index = l_stop_index
				loop
					l_found := False

					l_row := l_grid.row (l_index)
					if l_row.is_show_requested and l_row.is_selectable then
						l_item ?= l_row.data
						l_found := l_item /= Void and then a_query_action.item ([l_item])
					end

					if l_stop_index = 0 then
							-- Set stop index here so the active item gets a chance
							-- to be the next item, which happens when there is only one error item
						l_stop_index := l_index
					end

						-- Increment index
					l_index := l_index + l_row.subrow_count_recursive + 1

					if l_index > l_row_count then
							-- Cycle, if requested
						l_index := 1
					end
				end

				if l_found then
					check l_row_attached: l_row /= Void end
					move_to_row (l_row)
				end
			end
		end

	move_previous (a_query_action: FUNCTION [ANY, TUPLE [EVENT_LIST_ITEM_I], BOOLEAN])
			-- Moves to the previous item in the errors and warnings list based on some fundamental conditions.
			--
			-- `a_query_function': The function to determine if a matched event list item is applicable.
		require
			a_query_action_attached: a_query_action /= Void
		local
			l_grid: like grid_events
			l_row_count: INTEGER
			l_index: INTEGER
			l_stop_index: INTEGER
			l_row: EV_GRID_ROW
			l_item: EVENT_LIST_ITEM_I
			l_found: BOOLEAN
		do
			l_grid := grid_events
			l_row_count := l_grid.row_count
			if l_row_count > 0 then
				if l_grid.selected_rows.is_empty then
					l_index := l_row_count + 1
				else
					l_index := l_grid.selected_rows.first.index
				end
				l_index := l_index - 1
				if l_index = 0 then
						-- Cycle index
					l_index := l_row_count
				end

					-- Retrieve index of root row
				l_row := l_grid.row (l_index)
				if l_row.parent_row_root /= Void then
					l_row := l_row.parent_row_root
					l_index := l_row.index
				end

				from
					l_row := Void
				until
					l_found or
					l_index = l_stop_index
				loop
					l_found := False

					l_row := l_grid.row (l_index)
					check
						l_row_is_root: l_row.parent_row_root = Void or l_row.parent_row_root = l_row
					end
					if l_row.is_show_requested and l_row.is_selectable then
						l_item ?= l_row.data
						l_found := l_item /= Void and then a_query_action.item ([l_item])
					end

					if l_stop_index = 0 then
							-- Set stop index here so the active item gets a chance
							-- to be the next item, which happens when there is only one error item
						l_stop_index := l_index
					end

						-- Increment index
					l_index := l_index - 1
					if l_index = 0 then
							-- Cycle, if requested
						l_index := l_row_count
					end

						-- Retrieve index of root row
					l_row := l_grid.row (l_index)
					if l_row.parent_row_root /= Void then
						l_row := l_row.parent_row_root
						l_index := l_row.index
					end
				end

				if l_found then
					check l_row_attached: l_row /= Void end
					move_to_row (l_row)
				end
			end
		end

	move_to_row (a_row: EV_GRID_ROW)
			-- Navigates to a row
			--
			-- `a_row': A row to navigate to, and process default actions for
		require
			a_row_attached: a_row /= Void
			a_row_has_parent: a_row.parent /= Void
			a_row_is_in_grid_events: a_row.index <= grid_events.row_count and then grid_events.row (a_row.index) = a_row
		do
				-- Select the row to indicate the error moved to
			grid_events.selected_rows.do_all (agent {EV_GRID_ROW}.disable_select)
			a_row.enable_select

				-- Perform default action on row, which should open it in an editor
			do_default_action (a_row)
		end

feature {NONE} -- UI manipulation

	update_content_applicable_widgets (a_enable: BOOLEAN)
			-- Updates widgets on tool that require content to exist
			--
			-- `a_enable': True to indicate there is content available, False otherwise
		require
			item_count_positive: a_enable implies item_count > 0
			item_count_is_zero: not a_enable implies item_count = 0
		do
		end

feature {NONE} -- Query

	is_appliable_event (a_event_item: EVENT_LIST_ITEM_I): BOOLEAN
			-- Determines if event `a_event_item' can be shown with the current event list tool
		do
			Result := True
		end

	category_pixmap_from_task (a_task: EVENT_LIST_ITEM_I): EV_PIXMAP
			-- Retrieves a pixmap associated with a tasks category
			--
			-- `a_task': The task to query a category of
			-- `a_pixmap': The pixmap representing the task's category
		require
			a_task_attached: a_task /= Void
		do
			inspect a_task.category
			when {EVENT_LIST_ITEM_CATEGORIES}.compilation then
				Result := stock_pixmaps.compile_animation_8_icon
			else
				-- No matching category
			end
		end

feature {NONE} -- Events

	on_event_added (a_service: EVENT_LIST_SERVICE_I; a_event_item: EVENT_LIST_ITEM_I)
			-- Called when a event item is added to the event service.
			--
			-- `a_service': Event service where event was added.
			-- `a_event_item': The event item added to the service.
		require
			a_service_attached: a_service /= Void
			a_event_attached: a_event_item /= Void
			a_service_contains_a_event: a_service.all_items.has (a_event_item)
		local
			l_add: BOOLEAN
			l_event_item: EVENT_LIST_ITEM_I
			l_grid: like grid_events
			l_row: EV_GRID_ROW
			l_count: INTEGER
		do
			if is_appliable_event (a_event_item) then
				l_grid := grid_events
				l_count := l_grid.row_count

				l_add := maximum_item_count = 0 or else item_count < maximum_item_count
				if not l_add and then destory_old_items_automatically and then l_count > 0 then
						-- Remove top grid item
					l_event_item ?= l_grid.row (1).data
					check
						l_event_attached: l_event_item /= Void
					end
					on_event_removed (a_service, l_event_item)
				end

				check
					item_count_small_enough: maximum_item_count = 0 or else item_count < maximum_item_count
				end

					-- Add grid item
				l_count := l_grid.row_count + 1
				l_grid.set_row_count_to (l_count)
				l_row := l_grid.row (l_count)
					-- Set row information and items
				l_row.set_data (a_event_item)
				populate_event_grid_row_items (a_event_item, l_row)

				item_count := item_count + 1

				if scroll_list_automatically then
					l_row.ensure_visible
				end

				if item_count = 1 then
						-- First item to be added
					update_content_applicable_widgets (True)
				end
			end
		ensure then
			a_event_find_event_row: is_appliable_event (a_event_item) implies find_event_row (a_event_item) /= Void
			item_count_increased: is_appliable_event (a_event_item) implies item_count = old item_count + 1
		end

	on_event_removed (a_service: EVENT_LIST_SERVICE_I; a_event_item: EVENT_LIST_ITEM_I) is
			-- Called after a event item has been removed from the service `a_service'
			--
			-- `a_service': Event service where the event was removed.
			-- `a_event_item': The event item removed from the service.
		require
			a_service_attached: a_service /= Void
			a_event_attached: a_event_item /= Void
			not_a_service_contains_a_event: not a_service.all_items.has (a_event_item)
		local
			l_grid: like grid_events
			l_row: EV_GRID_ROW
			l_row_count: INTEGER
			l_index: INTEGER
			l_selected: BOOLEAN
		do
			if is_appliable_event (a_event_item) then
				check
					item_count_big_enough: item_count >= 1
				end

				item_count := item_count - 1

				l_row := find_event_row (a_event_item)
				if l_row /= Void then
					l_selected := l_row.is_selected

					l_grid := grid_events
					l_index := l_row.index
					l_grid.remove_row (l_index)

					if item_count > 0 and then l_selected then
							-- The row was selected so we need to change the selection
						l_row := Void

						l_row_count := l_grid.row_count
						if l_row_count > 0 then
							if l_index > l_row_count then
								l_index := l_row_count
							end

							from until
								l_index = 0 or (l_row /= Void and then l_row.is_show_requested and l_row.is_selectable)
							loop
								l_row := l_grid.row (l_index)
								if l_row.parent_row_root /= Void then
										-- Select top most rows only
									l_row := l_row.parent_row_root
									l_index := l_row.index
								end
								l_index := l_index - 1
							end

							if l_row /= Void and then l_row.is_show_requested and then l_row.is_selectable then
								check l_row_visible: l_row.is_show_requested end
									-- Select most applicable row
								l_grid.select_row (l_row.index)
							end
						end
					end

				end

				if item_count = 0 then
						-- Last item to be removed
					update_content_applicable_widgets (False)
				end
			end
		ensure then
			not_a_event_find_event_row: is_appliable_event (a_event_item) implies find_event_row (a_event_item) = Void
			item_count_increased: is_appliable_event (a_event_item) implies item_count = old item_count - 1
		end

	on_event_changed (a_service: EVENT_LIST_SERVICE_I; a_event_item: EVENT_LIST_ITEM_I)
			-- Called after a event item has been changed.
			--
			-- `a_service': Event service where the event was changed.
			-- `a_event_item': The event item that was changed.
		require
			a_service_attached: a_service /= Void
			a_event_attached: a_event_item /= Void
			a_service_contains_a_event: a_service.all_items.has (a_event_item)
		local
			l_row: EV_GRID_ROW
		do
			if is_appliable_event (a_event_item) then
				l_row := find_event_row (a_event_item)
				if l_row /= Void then
						-- Re-creates event row
					populate_event_grid_row_items (a_event_item, l_row)
				end
			end
		ensure then
			a_event_find_event_row: find_event_row (a_event_item) /= Void
		end

	on_grid_events_item_pointer_double_press (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_item: EV_GRID_ITEM) is
			-- Called when the user double clicks the grid
		do
			if a_item /= Void and then a_item.row /= Void then
					-- Row can be void because the header raises the double press events.
				do_default_action (a_item.row)
			end
		end

feature {NONE} -- Factory

	create_widget: ES_GRID is
			-- Create a new container widget upon request
		do
			create Result
			Result.enable_single_row_selection
			Result.enable_column_separators
			Result.enable_row_separators
			Result.set_separator_color (colors.grid_line_color)
			Result.enable_default_tree_navigation_behavior (True, True, True, True)
			Result.pointer_double_press_item_actions.extend (agent on_grid_events_item_pointer_double_press)
		end

	populate_event_grid_row_items (a_event_item: EVENT_LIST_ITEM_I; a_row: EV_GRID_ROW)
			-- Populates a grid row's item on a given row using the event `a_event_item'.
			--
			-- `a_event_item': A event to base the creation of a grid row on.
			-- `a_row': The row to create items on.
		require
			a_event_attached: a_event_item /= Void
			a_event_is_appliable_event: is_appliable_event (a_event_item)
			a_row_attached: a_row /= Void
			grid_events_has_row: a_row.index <= grid_events.row_count and then grid_events.row (a_row.index) = a_row
			a_row_has_event_item_data: a_row.data = a_event_item
		deferred
		ensure
			a_row_has_event_item_data: a_row.data = a_event_item
		end

invariant
	grid_events_attached: is_initialized implies grid_events /= Void
	event_service_attached: event_service /= Void

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

end
