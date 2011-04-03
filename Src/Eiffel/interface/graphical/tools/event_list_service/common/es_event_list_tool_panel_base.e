note
	description	: "[
		An EiffelStudio base implementation for all tools implementing a derviation of an event list tool. The tool is based on the 
		ecosystem event list service {EVENT_LIST_S}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	ES_EVENT_LIST_TOOL_PANEL_BASE

inherit
	ES_DOCKABLE_TOOL_PANEL [ES_GRID]
		rename
			user_widget as grid_events
		redefine
			on_before_initialize,
			on_after_initialized,
			internal_recycle,
			internal_detach_entities
		end

	EVENT_LIST_OBSERVER
		redefine
			on_locked,
			on_unlocked,
			on_event_item_added,
			on_event_item_removed,
			on_event_item_changed,
			on_event_item_adopted
		end

feature {NONE} -- Initialization

	on_before_initialize
			-- <Precursor>
		do
			Precursor {ES_DOCKABLE_TOOL_PANEL}

				-- Connect the observer to the event list service.
			if event_list.is_service_available then
				event_list.service.event_list_connection.connect_events (Current)
			end
		end

	on_after_initialized
			-- <Precursor>
		do
				-- Set dynamic function for view optimzations in the grid.
			grid_events.set_dynamic_content_function (agent (ia_row, ia_col: INTEGER; ia_grid: like grid_events): EV_GRID_ITEM
					-- Set partially dynamic content function for populating event list items.
				local
					l_row: EV_GRID_ROW
				do
					l_row := ia_grid.row (ia_row)
					if attached {EVENT_LIST_ITEM_I} l_row.data as l_event_item then
							-- Only for the first request
						populate_event_grid_row_items (l_event_item, l_row)
						ia_grid.grid_row_fill_empty_cells (l_row)
						Result := l_row.item (ia_col)
						if Result = Void then
							create Result
						end
					else
						create {EV_GRID_ITEM} Result
					end
			end (?, ?, grid_events))
			grid_events.disable_vertical_scrolling_per_item

				-- Register action to display context menus.
			register_action (grid_events.pointer_button_release_actions, agent (ia_widget: ES_GRID; ia_x, ia_y, ia_button: INTEGER_32; ia_x_tilt, ia_y_tilt, ia_pressure: REAL_64; ia_screen_x, ia_screen_y: INTEGER_32)
				local
					l_item: EV_GRID_ITEM
				do
					if ia_button = {EV_POINTER_CONSTANTS}.right then
						if ia_widget.is_header_displayed then
							l_item := ia_widget.item_at_virtual_position (ia_x, ia_y - ia_widget.header.height)
						else
							l_item := ia_widget.item_at_virtual_position (ia_x, ia_y)
						end
						if l_item /= Void then
							show_context_menu (l_item, ia_x, ia_y)
						end
					end
				end (grid_events, ?, ?, ?, ?, ?, ?, ?, ?))

			Precursor

			if event_list.is_service_available and then event_list.service.is_locked then
					-- If the service has already performed a lock, but the UI was not initialized then we need
					-- to call the lock handler now.
				on_locked (event_list.service)
			end

			if item_count = 0 then
					-- Attempt synchronization
				synchronize_event_list_items
			end
			update_content_applicable_widgets (item_count > 0)

			if not event_list.is_service_available then
					-- The event list service is not available to disable the tool.
				widget.disable_sensitive
			end
		end

feature {NONE} -- Clean up

	internal_recycle
			-- Recycle tool.
		local
			l_event_list: EVENT_LIST_S
		do
			if event_list.is_service_available then
				l_event_list := event_list.service
				if l_event_list.event_list_connection.is_connected (Current) then
					l_event_list.event_list_connection.disconnect_events (Current)
				end
			end
			Precursor
		end

	internal_detach_entities
			-- <Precursor>
		do
			internal_grid_wrapper := Void
			Precursor
		ensure then
			internal_grid_wrapper_deatched: internal_grid_wrapper = Void
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

feature {NONE} -- Status report

	is_appliable_event (a_event_item: EVENT_LIST_ITEM_I): BOOLEAN
			-- Determines if event `a_event_item' can be shown with the current event list tool
		do
			Result := True
		end

feature {NONE} -- Status report: Behaviour

	is_event_list_scrolled_automatically: BOOLEAN
			-- Indicates if the list should automatically scroll to the last item when a new item is added.
		local
			l_grid: like grid_events
		do
			Result := maximum_item_count = 0
			if Result then
					-- Permits automatic scrolling if the user did not scroll the last added
					-- item out of view.
				l_grid := grid_events
				Result := l_grid.row_count = 0 or else
					(l_grid.is_displayed and then l_grid.last_visible_row = l_grid.row (l_grid.row_count))
			end
		end

	is_event_list_synchronized_on_initialized: BOOLEAN
			-- Indicates if synchonization with the event list service should be performed when initializing.
		do
				-- By default for list that destory items automatically
				-- there will be not synchronization, because the will typically be logging tools.
			Result := not has_maximum_list_length
		end

	has_maximum_list_length: BOOLEAN
			-- Indicates if old event items should be destroyed automatically in a FIFO fashion.
		do
			Result := maximum_item_count > 0
		end

feature {NONE} -- Status setting

	frozen enable_copy_to_clipboard
			-- Enables copying of grid items to the clipboard.
		do
			grid_wrapper.set_selection_function (agent selected_text)
			grid_wrapper.enable_copy
		end

feature {NONE} -- Query

	selected_text: STRING_32
			-- Retrieves selected item's text
		local
			i, j, l_column_count, l_row_count, l_column_selected_count: INTEGER
			l_column: EV_GRID_COLUMN
			l_row: EV_GRID_ROW
			l_text: STRING_32
			l_row_text: STRING_32
			l_states: SPECIAL [INTEGER]
			l_none, l_part, l_full: INTEGER
			l_has_full: BOOLEAN
			l_grid: EV_GRID
		do
				-- Constants for column states.
			l_none := 1
			l_part := 2
			l_full := 3

			l_grid := grid_events
			l_column_count := l_grid.column_count
			l_row_count := l_grid.row_count
			create l_states.make_filled (0, l_column_count + 1)
			create l_text.make (100)
			from
				i := 1
			until
				i > l_column_count
			loop
				l_column := l_grid.column (i)
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
						l_column := l_grid.column (i)
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
				l_row := l_grid.row (i)
				if not l_row.selected_items.is_empty then
					from
						j := 1
					until
						j > l_column_count
					loop
						if l_states.item (j) /= l_none then
							if l_row.item (j).is_selected then
								l_row_text := row_item_text (l_row.item (j))
								if not l_row_text.is_empty then
									l_text.append (l_row_text)
								end
							end
							l_text.append ("%T")
						end
						j := j + 1
					end
					l_text.append ("%N")
				end
				i := i + 1
			end
			Result := l_text
		ensure
			result_attached: attached Result
		end

	row_text (a_row: EV_GRID_ROW): STRING_32
			-- Retrieves text for a given row.
			--
			-- `a_row': A row to retrieve a textual representation of.
			-- `Result': The textual representation of `a_row'.
		require
			a_row_attached: a_row /= Void
			not_a_row_is_destroyed: not a_row.is_destroyed
		local
			l_text: STRING_32
			l_item: EV_GRID_ITEM
			l_count, i: INTEGER
		do
			create Result.make_empty
			l_count := a_row.count
			from i := 1 until i > l_count loop
				l_item := a_row.item (i)
				if attached l_item then
					l_text := row_item_text (l_item)
					if not l_text.is_empty then
						Result.append (l_text)
						Result.append_character ('%T')
					end
				end
				i := i + 1
			end
			if not Result.is_empty then
				Result.prune_all_trailing ('%T')
			end
		ensure
			result_attached: attached Result
		end

	row_item_text (a_item: EV_GRID_ITEM): STRING_32
			-- Extracts a string representation of a grid row's cell item.
			--
			-- `a_item': Grid item to retrieve string representation for.
			-- `Result': A string representation of the item or Void if not string representation could be created.
		require
			a_item_attached: a_item /= Void
			not_a_item_is_destroyed: not a_item.is_destroyed
			a_item_is_parented: a_item.is_parented
		local
			l_label_item: EV_GRID_LABEL_ITEM
			l_string: STRING_GENERAL
		do
			l_label_item ?= a_item
			if l_label_item /= Void then
				Result := l_label_item.text
			end
			if Result = Void or else Result.is_empty then
					-- There might be string information in the item data, use that.
				l_string ?= a_item.data
				if l_string /= Void then
					Result := l_string.to_string_32
				end
			end
			if Result = Void then
				create Result.make_empty
			end
		ensure
			result_attached: Result /= Void
		end

	category_icon_from_event_item (a_event_item: EVENT_LIST_ITEM_I): EV_PIXMAP
			-- Retrieves a pixmap associated with a event item's category.
			--
			-- `a_event_item': The event item to query a category of.
			-- `a_pixmap': The pixmap representing the event item's category.
		require
			a_event_item_attached: a_event_item /= Void
		do
			inspect a_event_item.category
			when {ENVIRONMENT_CATEGORIES}.compilation then
				Result := stock_pixmaps.compile_animation_7_icon
			when {ENVIRONMENT_CATEGORIES}.refactoring then
				Result := stock_pixmaps.refactor_rename_icon
			when {ENVIRONMENT_CATEGORIES}.editor then
				Result := stock_pixmaps.general_document_icon
			when {ENVIRONMENT_CATEGORIES}.debugger then
				Result := stock_pixmaps.debugger_environment_force_execution_mode_icon
			else
				-- No matching category
			end
		end

	priority_icon_from_event_item (a_event_item: EVENT_LIST_ITEM_I): EV_PIXMAP
			-- Retrieves a pixmap associated with a event item's priority.
			--
			-- `a_event_item': The event item to query a category of.
			-- `a_pixmap': The pixmap representing the event items's priority.
		require
			a_event_item_attached: a_event_item /= Void
		do
			inspect a_event_item.priority
			when {PRIORITY_LEVELS}.low then
				Result := stock_pixmaps.priority_low_icon
			when {PRIORITY_LEVELS}.normal then
				--| Just return Void
			when {PRIORITY_LEVELS}.high then
				Result := stock_pixmaps.priority_high_icon
			end
		end

	find_event_row (a_event_item: EVENT_LIST_ITEM_I): EV_GRID_ROW
			-- Attempts to locate a grid row for event `a_event_item'
		require
			a_event_attached: a_event_item /= Void
			a_event_is_appliable_event: is_appliable_event (a_event_item)
		local
			l_grid: like grid_events
			l_row: EV_GRID_ROW
			i: INTEGER
		do
			l_grid := grid_events
			from
					-- Count backwards as it is more optimal for use in item insertion/removal.
				i := l_grid.row_count
			until
				i = 0
			loop
				l_row := l_grid.row (i)
				if l_row.data = a_event_item then
					Result := l_row
					i := 0
				else
					i := i - 1
				end
			end
		end

feature {NONE} -- Helpers

	frozen event_list: SERVICE_CONSUMER [EVENT_LIST_S]
			-- Access to an event list service {EVENT_LIST_S} consumer
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

	frozen grid_wrapper: EVS_GRID_WRAPPER [EV_GRID_ROW]
			-- A grid helper class
		do
			Result := internal_grid_wrapper
			if Result = Void then
				create Result.make (grid_events)
				internal_grid_wrapper := Result
				auto_recycle (internal_grid_wrapper)
			end
		ensure
			result_attached: Result /= Void
			result_consistent: Result = Result
		end

feature {NONE} -- Basic operations

	do_default_action (a_row: EV_GRID_ROW)
			-- Performs a default actions for a given row.
			--
			-- `a_row': The row the user requested an action to be performed on.
		require
			is_interface_usable: is_interface_usable
			a_row_attached: a_row /= Void
			a_row_has_parent: a_row.parent /= Void
			a_row_is_in_grid_events: a_row.index <= grid_events.row_count and then
				grid_events.row (a_row.index) = a_row
		deferred
		end

	show_context_menu (a_item: EV_GRID_ITEM; a_x: INTEGER; a_y: INTEGER)
			-- Called to show a context menu at the relative X/Y coordinates to `grid_events'
			--
			-- `a_item': The grid item to display a context menu for.
			-- `a_x': The relative X position on `grid_events'.
			-- `a_t': The relative Y position on `grid_events'.
		require
			is_interface_usable: is_interface_usable
			a_item_attached: a_item /= Void
			a_item_parented: a_item.row /= Void
			a_item_parented_to_grid_events: a_item.row.parent = grid_events
			a_x_positive: a_x > 0
			a_y_positive: a_y > 0
		do
		end

	synchronize_event_list_items
			-- Synchronized the event list items already pushed to the service before the tool was shown.
			-- Note: Do not call more than once and only during initialization.
		require
			is_initialized: is_initialized
			is_event_list_synchronized_on_initialized: is_event_list_synchronized_on_initialized
		local
			l_service: EVENT_LIST_S
			l_items: DS_BILINEAR [EVENT_LIST_ITEM_I]
			l_cursor: DS_BILINEAR_CURSOR [EVENT_LIST_ITEM_I]
			l_applicable_items: DS_ARRAYED_LIST [EVENT_LIST_ITEM_I]
			l_transition: ES_POPUP_TRANSITION_WINDOW
			l_locked: BOOLEAN
			l_count, i: INTEGER
		do
			if event_list.is_service_available then
					-- Fake all events to synchronize what is in the event list with the Current panel.
				check no_rows_added: grid_events.row_count = 0 end
				l_service := event_list.service
				l_items := l_service.all_items

				if not l_items.is_empty then
						-- Perform lock, for UI optimization purposes.
					if not l_service.is_locked then
						l_service.lock
						l_locked := True
					end

						-- Perform optimization to only display what is necessary.
						-- This involves extracting only applicable items, and if a maximum item count is
						-- set, the ensuring we do not add more than the maximum.
					l_count := l_items.count
					if has_maximum_list_length then
						l_count := maximum_item_count.as_integer_32.min (l_count)
					end
					create l_applicable_items.make (l_count)

					l_cursor := l_items.new_cursor
					from l_cursor.finish until i = l_count or l_cursor.before loop
						if attached l_cursor.item as l_item and then is_appliable_event (l_item) then
							l_applicable_items.put_last (l_item)
							i := i + 1
						end
						l_cursor.back
					end
					if not l_cursor.off then
							-- Prevent memory leak.
						l_cursor.start
						l_cursor.back
					end

					if l_applicable_items.count > 100 then
							-- Display a transition window if the error count is high
						create l_transition.make_with_icon (locale_formatter.translation (l_synchronizing_errors), tool_descriptor.icon)
						l_transition.show_on_active_window
					end

						-- Go through the applicable items and add them to the error list tool.
						-- Note: We loop backwards because the items were added backwards, and for some tools
						--       order will be quite important.
					from l_applicable_items.finish until l_applicable_items.before loop
						if attached l_applicable_items.item_for_iteration as l_item then
								-- Fake the item added event.
							on_event_item_added (l_service, l_item)
						end
						l_applicable_items.back
					end

					if l_transition /= Void and then l_transition.is_shown then
							-- Hide any transition window.
						l_transition.hide
					end

					if l_locked then
							-- Perform unlock, for UI optimization purposes.
						l_service.unlock
					end
				end
			end
		end

	update_content_applicable_widgets (a_enable: BOOLEAN)
			-- Updates widgets on tool that require content to exist
			--
			-- `a_enable': True to indicate there is content available, False otherwise
		require
			item_count_positive: a_enable implies grid_events.row_count > 0
			item_count_is_zero: not a_enable implies grid_events.row_count = 0
		do
		end

feature {NONE} -- Basic operations: Navigation

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
			l_valid_rows: BOOLEAN
		do
			l_grid := grid_events
			l_row_count := l_grid.row_count
			if l_row_count > 0 then
					-- Check there are visible and selectable items
				l_valid_rows := False
				from l_index := 1 until l_index >= l_row_count or l_valid_rows loop
					l_row := l_grid.row (l_index)
					l_valid_rows := l_row.is_show_requested and l_row.is_selectable
					l_index := l_index + l_row.subrow_count_recursive + 1
				end

				if l_valid_rows then
						-- There are selectable rows
					if l_grid.selected_rows.is_empty then
							-- Fetch last row's root row
						l_row := l_grid.row (l_row_count)
						if l_row.parent_row /= Void then
							l_row := l_row.parent_row_root
						end
					else
							-- Fetch selected row's root row (as child may be selected)
						l_row := l_grid.selected_rows.last
						if l_row.parent_row /= Void then
							l_row := l_row.parent_row_root
						end
					end

						-- Ensure row is visible
					if not l_row.is_show_requested and l_row.is_selectable then
							-- Located row is not shown, find previous shown row
						l_stop_index := l_row.index
						from until l_row.is_show_requested and l_row.is_selectable loop
							l_index := l_row.index + l_row.subrow_count_recursive + 1
							if l_index = l_row_count then
								l_index := 1
							end
							l_row := l_grid.row (l_index)
						end
					end

						-- Set selected index and stop-index
					l_index := l_row.index
					l_stop_index := l_index
					check
						l_stop_index_is_root_row: l_grid.row (l_index).parent_row = Void
					end

						-- Shift index
					l_index := l_index + l_row.subrow_count_recursive + 1
					if l_index > l_row_count then
							-- Cycle index
						l_index := 1
					end

						-- Iterate through the rows forwards
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

						if not l_found then
								-- Increment index
							l_index := l_index + l_row.subrow_count_recursive + 1
							if l_index > l_row_count then
									-- Cycle, if requested
								l_index := 1
							end

								-- Retrieve index of root row
							l_row := l_grid.row (l_index)
						end
					end

					if not l_found and then l_stop_index > 0 then
							-- The stopping index row might be the only selectable row, so we fake a match to ensure the move actions
							-- are performed.
						l_row := l_grid.row (l_stop_index)
						check
							l_row_is_root_row: l_row.parent_row = Void
						end
						l_found := True
					end

					if l_found then
						check l_row_attached: l_row /= Void end
						move_to_row (l_row)
					end
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
			l_valid_rows: BOOLEAN
		do
			l_grid := grid_events
			l_row_count := l_grid.row_count
			if l_row_count > 0 then
					-- Check there are visible and selectable items
				l_valid_rows := False
				from l_index := 1 until l_index >= l_row_count or l_valid_rows loop
					l_row := l_grid.row (l_index)
					l_valid_rows := l_row.is_show_requested and l_row.is_selectable
					l_index := l_index + l_row.subrow_count_recursive + 1
				end

				if l_valid_rows then
						-- There are selectable rows

					if l_grid.selected_rows.is_empty then
							-- Fetch last row's root row
						l_row := l_grid.row (1)
					else
							-- Fetch selected row's root row (as child may be selected)
						l_row := l_grid.selected_rows.first
						if l_row.parent_row /= Void then
								-- There is parent row, which means the child was selected, skip to the next row (or first)
								-- so the selected row's root row will be choosen as the previous row.
							l_row := l_row.parent_row_root
							if l_row.index + l_row.subrow_count_recursive + 1 <= l_row_count then
								l_row := l_grid.row (l_row.index + l_row.subrow_count_recursive + 1)
							else
								l_row := l_grid.row (1)
							end
						end
					end

						-- Ensure row is visible
					if not l_row.is_show_requested and l_row.is_selectable then
							-- Located row is not shown, find previous shown row
						l_stop_index := l_row.index
						from until l_row.is_show_requested and l_row.is_selectable loop
							l_index := l_row.index - 1
							if l_index = 0 then
								l_index := l_row_count
							end
							l_row := l_grid.row (l_index)
							if l_row.parent_row /= Void then
								l_row := l_row.parent_row_root
							end
						end
					end

						-- Set selected index and stop-index
					l_index := l_row.index
					l_stop_index := l_index
					check
						l_stop_index_is_root_row: l_grid.row (l_index).parent_row = Void
					end

						-- Shift index
					l_index := l_index - 1
					if l_index = 0 then
							-- Cycle index
						l_index := l_row_count
					end

						-- Retrieve index of root row
					l_row := l_grid.row (l_index)
					if l_row.parent_row /= Void then
						l_index := l_row.parent_row_root.index
					end

						-- Iterate through the rows backwacks
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

						if not l_found then
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
					end

					if not l_found and then l_stop_index > 0 then
							-- The stopping index row might be the only selectable row, so we fake a match to ensure the move actions
							-- are performed.
						l_row := l_grid.row (l_stop_index)
						check
							l_row_is_root_row: l_row.parent_row = Void
						end
						l_found := True
					end

					if l_found then
							-- Perform row actions
						check l_row_attached: l_row /= Void end
						move_to_row (l_row)
					end
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

feature {NONE} -- Removal

	remove_event_list_row (a_row: EV_GRID_ROW)
			-- Removes a single event list row.
			--
			-- `a_row': The event list row to remove.
		require
			is_interface_usable: is_interface_usable
			a_row_attached: a_row /= Void
			a_row_parented_to_grid_events: a_row.parent = grid_events
		do
			if event_list.is_service_available and then attached {EVENT_LIST_ITEM_I} a_row.data as l_item then
				event_list.service.prune_event_item (l_item)
			end
		end

	remove_all_selected_event_list_rows
			-- Removes all the selected event list rows.
		require
			is_interface_usable: is_interface_usable
			is_multiple_row_selection_enabled: grid_events.is_multiple_row_selection_enabled
		local
			l_selected: ARRAYED_LIST [EV_GRID_ROW]
		do
			l_selected := grid_events.selected_rows
			if l_selected /= Void and then not l_selected.is_empty then
				l_selected.do_all (agent remove_event_list_row)
			end
		end

feature {NONE} -- Sort handling

	frozen enable_sorting_on_columns (a_columns: ARRAY [EV_GRID_COLUMN])
			-- Enables sorting on a selected set of columns
			--
			-- `a_columns': The columns to enable sorting on.
		require
			a_columns_attached: a_columns /= Void
		local
			l_wrapper: like grid_wrapper
			l_sort_info: EVS_GRID_TWO_WAY_SORTING_INFO [EV_GRID_ROW]
			l_column: EV_GRID_COLUMN
			l_upper, i: INTEGER
		do
			l_wrapper := grid_wrapper
			l_wrapper.enable_auto_sort_order_change
			if l_wrapper.sort_action = Void then
				l_wrapper.set_sort_action (agent sort_handler)
			end

			from
				i := a_columns.lower
				l_upper := a_columns.upper
			until i > l_upper loop
				l_column := a_columns [i]
				check l_column_attached: l_column /= Void end
				if l_column /= Void then
					create l_sort_info.make (agent sorting_row_comparer (?, ?, ?, l_column.index), {EVS_GRID_TWO_WAY_SORTING_ORDER}.ascending_order)
					l_sort_info.enable_auto_indicator
					l_wrapper.set_sort_info (l_column.index, l_sort_info)
				end
				i := i + 1
			end
		end

	frozen sorting_row_comparer (a_row, a_other_row: EV_GRID_ROW; a_order: INTEGER_32; a_column: INTEGER): BOOLEAN
			-- Agent function used to determine row order.
			--
			-- `a_row': The primary row to check.
			-- `a_row': The secondary row to check.
			-- `a_order': An order determined by order constants from {EVS_GRID_TWO_WAY_SORTING_ORDER}.
			-- `a_column': The column index requested to be sorted.
			-- `Result': True to indicate `a_row' is less than `a_other_row', False otherwise.
		require
			row_a_valid: a_row /= Void
			row_b_valid: a_other_row /= Void
			a_order_is_valid: a_order = {EVS_GRID_TWO_WAY_SORTING_ORDER}.ascending_order or a_order = {EVS_GRID_TWO_WAY_SORTING_ORDER}.descending_order
			a_column_is_valid_index: a_column > 0 and a_column <= grid_events.column_count
		local
			l_res: like compare_rows
		do
			l_res := compare_rows (a_row, a_other_row, a_column)
			if a_order = {EVS_GRID_TWO_WAY_SORTING_ORDER}.ascending_order then
				Result := not l_res
			else
				Result := l_res
			end
		end

	compare_rows (a_row, a_other_row: EV_GRID_ROW; a_column: INTEGER): BOOLEAN
			-- Compares two rows from the local grid and returns an index based on their comparative result.
			--
			-- Note: Basic implementation handles both string and integer string checking. Items with special
			--       rendering should have redefined implementation in `row_item_text' to retrieve a sortable
			--       text string.
			--
			-- `a_row': The primary row to check.
			-- `a_other_row': The secondary row to check.
			-- `a_column': The column index requested to be sorted.
			-- `Result': True to indicate `a_row' is less than `a_other_row', False otherwise.
		require
			row_a_valid: a_row /= Void
			row_b_valid: a_other_row /= Void
			a_column_is_valid_index: a_column > 0 and a_column <= grid_events.column_count
		local
			l_item: EV_GRID_ITEM
				-- Should to STRING_GENERAL, but it requires a change in elks
			l_text: STRING_32
			l_other_text: STRING_32
		do
			l_item := a_row.item (a_column)
			if l_item /= Void then
				l_text := row_item_text (l_item)
			end
			l_item := a_other_row.item (a_column)
			if l_item /= Void then
				l_other_text := row_item_text (l_item)
			end
			if l_text /= Void and l_other_text /= Void then
				if l_text.is_integer_64 and l_other_text.is_integer_64 then
					Result := l_text.to_integer_64 < l_other_text.to_integer_64
				else
					Result := l_text < l_other_text
				end
			elseif l_text = Void then
				Result := True
			end
		ensure
			asymmetric: Result implies not compare_rows (a_other_row, a_row, a_column)
		end

	frozen sort_handler (a_column_list: LIST [INTEGER]; a_comparator: AGENT_LIST_COMPARATOR [EV_GRID_ROW])
			-- Action to be performed when sort `a_column_list' using `a_comparator'.
		require
			a_column_list_attached: a_column_list /= Void
			not_a_column_list_is_empty: not a_column_list.is_empty
			a_comparator_attached: a_comparator /= Void
		local
			l_grid: like grid_events
			l_sorter: QUICK_SORTER [EV_GRID_ROW]
			l_rows: ARRAYED_LIST [EV_GRID_ROW]
			l_row: EV_GRID_ROW
			l_count, i: INTEGER
			l_event_items: ARRAYED_LIST [TUPLE [event_item: EVENT_LIST_ITEM_I; expand: BOOLEAN]]
			l_event_item: EVENT_LIST_ITEM_I
		do
			create l_sorter.make (a_comparator)

			l_grid := grid_events
			l_count := l_grid.row_count

				-- Retrieve top level grid items
			create l_rows.make ((l_count / 2).truncated_to_integer)

			from i := 1 until i > l_count loop
				l_row := l_grid.row (i)
				l_rows.force (l_row)
				i := i + l_row.subrow_count_recursive + 1
			end

				-- Perform sort
			l_sorter.sort (l_rows)

				-- Extract all event item data for repopulation
			create l_event_items.make (l_rows.count)
			from l_rows.start until l_rows.after loop
				l_row := l_rows.item_for_iteration
				l_event_item ?= l_row.data
				check l_event_item_attached: l_event_item /= Void end
				l_event_items.force ([l_event_item, l_row.is_expanded])
				l_rows.forth
			end

				-- Repopulate grid
			l_grid.lock_update
			l_grid.remove_and_clear_all_rows

			from i := 1; l_event_items.start until l_event_items.after loop
				l_grid.set_row_count_to (i)
				l_row := l_grid.row (i)
				l_event_item := l_event_items.item_for_iteration.event_item

				l_row.set_data (l_event_item)
				populate_event_grid_row_items (l_event_item, l_row)
				l_grid.grid_row_fill_empty_cells (l_row)
				if l_event_items.item_for_iteration.expand then
					l_row.expand
				end

				if l_row.parent /= Void then
						-- Increase `i' by recursive subrow count so that they get included.
					i := i + l_row.subrow_count_recursive
				end
					-- Move `i' to next row
				i := i + 1
				l_event_items.forth
			end

			l_grid.unlock_update
		end

feature {LOCKABLE_I} -- Event handlers

	on_locked (a_sender: attached LOCKABLE_I)
			-- <Precursor>
		do
			Precursor (a_sender)

			if not is_initialized then
				initialize
			end
			grid_events.lock_update
		end

	on_unlocked (a_sender: attached LOCKABLE_I)
			-- <Precursor>
		do
			Precursor (a_sender)

			if is_initialized then
				grid_events.unlock_update
			end
		end

feature {EVENT_LIST_OBSERVER} -- Events handlers

	on_event_item_added (a_sender: EVENT_LIST_S; a_event_item: EVENT_LIST_ITEM_I)
			-- <Precursor>
		local
			l_add: BOOLEAN
			l_event_item: EVENT_LIST_ITEM_I
			l_grid: like grid_events
			l_row: EV_GRID_ROW
			l_count: INTEGER
		do
			Precursor (a_sender, a_event_item)

			if is_initialized and then is_appliable_event (a_event_item) then
				l_grid := grid_events
				l_count := l_grid.row_count

				l_add := maximum_item_count = 0 or else item_count < maximum_item_count
				if not l_add and then has_maximum_list_length and then l_count > 0 then
						-- Remove top grid item
					l_event_item ?= l_grid.row (1).data
					check
						l_event_attached: l_event_item /= Void
					end
					on_event_item_removed (a_sender, l_event_item)
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
				if not l_grid.is_content_partially_dynamic then
					populate_event_grid_row_items (a_event_item, l_row)
					l_grid.grid_row_fill_empty_cells (l_row)
				end

				item_count := item_count + 1

				if is_event_list_scrolled_automatically then
					l_row.ensure_visible
				end

				if item_count = 1 then
						-- First item to be added
					update_content_applicable_widgets (True)
						-- Set leap to be that of the height of the first row added.
					l_grid.vertical_scroll_bar.set_step (l_row.height)
				end
			end
		ensure then
			a_event_find_event_row: is_initialized and then is_appliable_event (a_event_item) implies find_event_row (a_event_item) /= Void
			item_count_increased: (is_initialized and then is_appliable_event (a_event_item) and not has_maximum_list_length) implies item_count = old item_count + 1
			item_count_small_enought: has_maximum_list_length implies item_count <= maximum_item_count
		end

	on_event_item_removed (a_sender: EVENT_LIST_S; a_event_item: EVENT_LIST_ITEM_I)
			-- <Precursor>
		local
			l_grid: like grid_events
			l_row: EV_GRID_ROW
			l_row_count: INTEGER
			l_row_item_count: INTEGER
			l_item: EV_GRID_ITEM
			l_index: INTEGER
			l_selected: BOOLEAN
		do
			Precursor (a_sender, a_event_item)

			if is_initialized and then is_appliable_event (a_event_item) then
				l_row := find_event_row (a_event_item)
				if l_row /= Void then
					check
						item_count_big_enough: item_count >= 1
					end

					l_selected := l_row.is_selected

					l_grid := grid_events
					l_index := l_row.index

					from l_row_item_count := l_row.count until l_row_item_count = 0 loop
						l_item := l_row.item (l_row_item_count)
						if not l_item.is_destroyed then
								-- Force call of pointer leave actions
							l_item.pointer_leave_actions.call (Void)
						end
						l_row_item_count := l_row_item_count - 1
					end
					l_grid.remove_row (l_index)

					item_count := item_count - 1

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

					if item_count = 0 then
							-- Last item to be removed
						update_content_applicable_widgets (False)
					end
				end
			end
		ensure then
			not_a_event_find_event_row: is_initialized and then is_appliable_event (a_event_item) implies find_event_row (a_event_item) = Void
			item_count_increased: is_initialized and then is_appliable_event (a_event_item) implies item_count = old item_count - 1
		end

	on_event_item_changed (a_sender: EVENT_LIST_S; a_event_item: EVENT_LIST_ITEM_I)
			-- <Precursor>
		local
			l_grid: like grid_events
			l_row: EV_GRID_ROW
			l_row_selections: ARRAYED_LIST [EV_GRID_ROW]
			l_item_selections: ARRAYED_LIST [EV_GRID_ITEM]
		do
			Precursor (a_sender, a_event_item)

			if is_initialized and then is_appliable_event (a_event_item) then
				l_row := find_event_row (a_event_item)
				if l_row /= Void then
						-- Query selection for later reselection
					l_grid := grid_events
					if l_grid.is_single_row_selection_enabled or l_grid.is_multiple_row_selection_enabled then
						l_row_selections := l_grid.selected_rows
					else
						l_item_selections := l_grid.selected_items
					end

						-- Re-creates event row
					populate_event_grid_row_items (a_event_item, l_row)
					grid_events.grid_row_fill_empty_cells (l_row)

						-- Perform reselection
					if l_row_selections /= Void and l_row_selections.has (l_row) then
						l_row.enable_select
					elseif l_item_selections /= Void then
						from l_item_selections.start until l_item_selections.after loop
							if attached l_item_selections.item as l_item then
								l_item.enable_select
							end
						end
					end
				end
			end
		ensure then
			a_event_find_event_row: is_initialized and then is_appliable_event (a_event_item) implies find_event_row (a_event_item) /= Void
		end

	on_event_item_adopted (a_sender: EVENT_LIST_S; a_event_item: EVENT_LIST_ITEM_I; a_new_cookie: UUID; a_old_cookie: UUID)
			-- <Precursor>
		do
			Precursor (a_sender, a_event_item, a_new_cookie, a_old_cookie)

			on_event_item_changed (a_sender, a_event_item)
		ensure then
			a_event_find_event_row: is_initialized and then is_appliable_event (a_event_item) implies find_event_row (a_event_item) /= Void
		end

feature {NONE} -- Action handlers

	on_grid_events_item_pointer_double_press (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_item: EV_GRID_ITEM)
			-- Called when the user double clicks the grid
		do
			if a_item /= Void and then a_item.row /= Void then
					-- Row can be void because the header raises the double press events.
				do_default_action (a_item.row)
			end
		end

feature {NONE} -- Factory

	create_widget: ES_GRID
			-- Create a new container widget upon request
		do
			create {ES_EDITOR_TOKEN_GRID}Result
			Result.enable_single_row_selection
			Result.enable_column_separators
			Result.enable_row_separators
			Result.set_separator_color (colors.grid_line_color)
			Result.enable_default_tree_navigation_behavior (True, True, True, True)
			Result.enable_row_height_fixed
			Result.disable_vertical_scrolling_per_item
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

feature {NONE} -- Implementation: Internal cache

	internal_grid_wrapper: like grid_wrapper
			-- Cached version of `grid_wrapper'
			-- Note: Do not use directly!

feature {NONE} -- Internationalization

	l_synchronizing_errors: STRING = "Retrieving last compilation's error and warning information..."

invariant
	grid_events_attached: (is_initialized and is_interface_usable) implies attached grid_events

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
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
