note
	description: "Window showing and handling the list of matching entries obtained via a {SUGGESTION_PROVIDER} query."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SUGGESTION_WINDOW

inherit
	EV_POPUP_WINDOW
		rename
			show as show_window
		redefine
			create_interface_objects, initialize
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_field: EV_ABSTRACT_SUGGESTION_FIELD)
			-- Initialize `Current' with `a_field' as `field'.
		do
			field := a_field
			default_create
			disconnect_from_window_manager
		ensure
			field_set: field = a_field
		end

	create_interface_objects
			-- <Precursor>
		do
			Precursor
			create grid
			create suggestion_timeout
		end

	initialize
			-- <Precursor>
		local
			vbox: EV_VERTICAL_BOX
		do
			Precursor

				-- Prevent grid from grabbing focus.
			grid.disable_focus_on_press

				-- Since grid won't have the focus, we want to have the unfocused
				-- color for selected items be the same as the focused color.
			grid.set_non_focused_selection_color (grid.focused_selection_color)
			grid.set_non_focused_selection_text_color (grid.focused_selection_text_color)

				-- Only one entire row can be selected.
			grid.enable_single_row_selection

				-- Handling of keybord/mouse events.
			grid.pointer_double_press_actions.extend (agent mouse_selection)

				-- Handling of mousewheel
			grid.mouse_wheel_actions.extend (agent on_mouse_wheel)

				-- Ensures that items are drawn dynamically to speed up rendering.
			grid.enable_partial_dynamic_content
			grid.set_dynamic_content_function (agent associated_grid_item)

				-- No need for headers
			grid.hide_header

				-- Black border around the grid so that it stands out.
			create vbox
			vbox.set_background_color (create {EV_COLOR}.make_with_rgb (0, 0, 0))
			vbox.set_border_width (border_width)
			vbox.extend (grid)
			extend (vbox)

				-- Each time the window holding the grid is resized, we want to make
				-- sure that the width of the last column is as big as the window at the
				-- minimum.
			resize_actions.force_extend (agent resize_column_to_window_width)
		end

feature -- Access

	full_list: ARRAYED_LIST [SUGGESTION_ITEM]
		obsolete
			"Do not use"
		do
			create Result.make (0)
		end

feature -- Status Setting

	set_is_list_recomputation_required (v: like is_list_recomputation_required)
			-- Set `is_list_recomputation_required' with `v'.
		do
			is_list_recomputation_required := v
		ensure
			is_list_recomputation_required_set: is_list_recomputation_required = v
		end

feature -- Update

	show
			-- Show
		do
				-- Initialize the current suggest list with what has been entered in `field'.
			build_suggestion_list (field.searched_text, True)
		end

	show_content
		do
				-- Select the entry that match what has been entered in `field'.
			select_closest_match
			position_suggestion_choice_window
			resize_column_to_window_width
			show_window
		end

feature -- Query

	default_font: EV_FONT
			-- Default font
		once
			create Result
		end

feature {EV_ABSTRACT_SUGGESTION_FIELD} -- Events handling

	on_mouse_wheel (a_offset: INTEGER)
			-- Scroll selected items by `a_offset_position' until we either
			-- reached the top of the bottom of `grid'.
		local
			l_row: detachable EV_GRID_ROW
			l_offset: INTEGER
		do
			if not is_destroyed and then is_displayed then
					-- Calculate the expected offset that we will use to scroll the grid.
					-- Note that the selection remains unchanged.
				if settings.is_mouse_wheel_in_full_page_mode then
					l_offset := ((viewable_row_count - settings.scrolling_common_line_count) * grid.row_height).max (0) * a_offset
				else
					l_offset := grid.row_height * settings.mouse_wheel_scroll_size * a_offset
				end
				if l_offset < 0 then
						-- We are going down, the last visible item should be properly aligned at the bottom.
					l_row := grid.last_visible_row
					if l_row /= Void then
							-- We align the last visible row to the bottom.
						l_row.ensure_visible
					end
						-- Then we scroll
					l_row := grid.first_visible_row
					if l_row /= Void then
						grid.set_virtual_position (grid.virtual_x_position, grid.maximum_virtual_y_position.min (grid.virtual_y_position - l_offset))
					end
				elseif l_offset > 0 then
						-- We are going up, the first visible item should be properly aligned at the bottom.
					l_row := grid.first_visible_row
					if l_row /= Void then
							-- We align the first visible row to the top.
						l_row.ensure_visible
					end
						-- Then we scroll
					l_row := grid.last_visible_row
					if l_row /= Void then
						grid.set_virtual_position (grid.virtual_x_position, (grid.virtual_y_position - l_offset).max (0))
					end
				end
			end
		end

	mouse_selection (x_pos, y_pos, button: INTEGER; unused1,unused2,unused3: DOUBLE; unused4,unused5:INTEGER)
			-- process mouse click in the list
		do
			if button = 1 and not grid.selected_items.is_empty then
				suggest_and_close
			end
		end

	on_row_expand (a_row: EV_GRID_ROW)
			-- On row expand.
			--| For the time being it is commented until we use this facility.
		require
			a_row_not_void: a_row /= Void
		local
--			l_children: ARRAY [like row_data_type]
--			i, upper: INTEGER
		do
			if a_row.subrow_count = 0 and then attached {like row_data_type} a_row.data as l_data then
				check
--					matches_not_void: matches /= Void
				end
--				l_children := l_data.children
--				from
--					i := l_children.lower
--					upper := l_children.upper
--				until
--					i > upper
--				loop
--					if matches.has (l_children.item (i)) then
--						a_row.insert_subrow (a_row.subrow_count + 1)
--						a_row.subrow (a_row.subrow_count).set_data (l_children.item (i))
--					end
--					i := i + 1
--				end
			end
			ev_application.do_once_on_idle (agent resize_column_to_window_width)
		end

	on_row_collapse (a_row: EV_GRID_ROW)
			-- On row collapse
			--| For the time being it is commented until we use this facility.
		require
			a_row_not_void: a_row /= Void
		do
			ev_application.do_once_on_idle (agent resize_column_to_window_width)
		end

feature {EV_ABSTRACT_SUGGESTION_FIELD} -- Navigation

	is_navigable: BOOLEAN
			-- Can current being traversed using left and right arrow keys?
			--| This happens when you have tree items in the list.
		local
			l_rows: detachable ARRAYED_LIST [EV_GRID_ROW]
		do
			l_rows := grid.selected_rows
			Result := not l_rows.is_empty and l_rows.first.is_expanded
		end

	go_first
			-- Scroll grid to the first item.
		local
			l_indexes: ARRAYED_LIST [INTEGER]
		do
			if grid.row_count > 0 then
				l_indexes := grid.viewable_row_indexes
				if l_indexes.is_empty then
					select_row (1)
				else
					select_row (l_indexes.first)
				end
			end
		end

	go_last
			-- Scroll grid to the last item.
		local
			l_indexes: ARRAYED_LIST [INTEGER]
		do
			if grid.row_count > 0 then
				l_indexes := grid.viewable_row_indexes
				if l_indexes.is_empty then
					select_row (grid.row_count)
				else
					select_row (l_indexes.last)
				end
			end
		end

	go_to_next_item (a_is_forward: BOOLEAN)
			-- Iterate grid to find the next item for keyboard naviation
			-- `a_is_forward' control if the search should be forward or backward.
		local
			i, ix: INTEGER
			l_row : EV_GRID_ROW
			l_loop_end: BOOLEAN
			l_grid: like grid
			l_rows: ARRAYED_LIST [EV_GRID_ROW]
			l_offset: INTEGER
		do
			l_grid := grid
			l_rows := l_grid.selected_rows
			if not l_rows.is_empty then
				ix := l_rows.first.index
				l_grid.remove_selection
				if a_is_forward then
					l_offset := 1
				else
					l_offset := -1
				end
				i := ix + l_offset
				from
				until
					l_loop_end
				loop
						-- Rotate the search if we are on the last or first item.					
					if i <= 0 then
						i := l_grid.row_count
					elseif i > l_grid.row_count then
						i := 1
					end
					l_row := l_grid.row (i)
					if l_row.is_displayed then
						l_row.enable_select
						l_row.ensure_visible
						l_loop_end := True
					end
					i := i + l_offset
				end
			end
		end

	go_to_next_page (a_is_forward: BOOLEAN)
			-- Iterate grid to find the next item for keyboard naviation
			-- `a_is_forward' control if the search should be forward or backward.
		local
			l_grid: like grid
			l_rows: ARRAYED_LIST [EV_GRID_ROW]
			l_row, l_target_row: detachable EV_GRID_ROW
			l_scroll_height, l_new_virtual_y: INTEGER
		do
			l_grid := grid
			if a_is_forward then
				l_target_row := last_visible_row (l_grid)
			else
				l_target_row := first_visible_row (l_grid)
			end
			l_rows := l_grid.selected_rows
			if not l_rows.is_empty then
				l_grid.remove_selection
				l_row := l_rows.first
				if l_row = l_target_row then
						-- This is the number of rows we want to scroll per `settings' with a minimum of `1'.
					l_scroll_height := ((viewable_row_count - settings.scrolling_common_line_count).max (1)) * l_grid.row_height
					if a_is_forward then
							-- The bottom row is the last selected row, we can scroll down.
						l_new_virtual_y := l_row.virtual_y_position + l_row.height - l_grid.viewable_height + l_scroll_height
						l_grid.set_virtual_position (l_grid.virtual_x_position, l_new_virtual_y.min (l_grid.maximum_virtual_y_position))
						l_target_row := last_visible_row (l_grid)
					else
							-- The top row is the first selected row, we can scroll up.
						l_grid.set_virtual_position (l_grid.virtual_x_position, (l_row.virtual_y_position - l_scroll_height).max (0))
						l_target_row := first_visible_row (l_grid)
					end
				end
			end

			if l_target_row /= Void then
				l_target_row.enable_select
			end
		end

feature {EV_ABSTRACT_SUGGESTION_FIELD} -- Completion

	build_suggestion_list (a_name: READABLE_STRING_GENERAL; a_is_first: BOOLEAN)
			-- Build the list based on matches with `name'. If `a_is_first' it is
			-- the first time that the list will be shown and a new query to the
			-- suggestion provider is issued. If `is_list_recomputation_required'
			-- a new query to the suggestion provider will be issued even if not
			-- otherwise required.
		require
			not_destroyed: not is_destroyed
		local
			l_grid: like grid
			l_post_action: detachable PROCEDURE [ANY, TUPLE]
			l_is_displayed: like is_displayed
		do
				-- To prevent flickering due to the potential
				-- hidding/showing of scrollbars we lock ourselve
				-- while rebuilding the list.
			l_is_displayed := is_displayed
			if l_is_displayed then
				lock_update
			end

			l_grid := grid

			if a_is_first then
					-- The first time we need to show the list of suggestions
					-- when it has fully been computed.
				l_post_action := agent show_content
			end
				-- If this is the first time we are showing the list or if
				-- settings dictate that it has to be recomputed, we get the
				-- results from the associated suggestion provider of `field'.
			if a_is_first or else is_list_recomputation_required then
				l_grid.wipe_out
					-- Set the minimum number of column.
				l_grid.set_column_count_to (1)
				field.suggestion_provider.query_with_callback_and_cancellation (a_name, l_post_action,
					agent (a_item: SUGGESTION_ITEM)
						local
							l_row: EV_GRID_ROW
						do
							grid.insert_new_row (grid.row_count + 1)
							l_row := grid.row (grid.row_count)
							l_row.set_data (a_item)
						end, settings.query_cancel_request)
			end
				-- We need to unset `is_list_recomputation_required'
			is_list_recomputation_required := False

				-- Let's unlock the window to refresh its content with the newly
				-- build content.
			if l_is_displayed then
				unlock_update
			end
		ensure
			is_list_recomputation_required_unset: not is_list_recomputation_required
		end

	select_closest_match
			-- Find the closes match to text in `field' in the list we have.
		local
			l_reg: SUGGESTION_MATCHER
			i, nb: INTEGER
			l_row_selected: BOOLEAN
			l_row: EV_GRID_ROW
		do
			l_reg := settings.matcher
			l_reg.prepare (field.searched_text)
				-- If regular expression can be computed
				-- we go ahead otherwise we leave things unchanged.
			if l_reg.is_ready then
				from
					i := 1
					nb := grid.row_count
					if nb > 0 and settings.is_list_filtered_when_typing then
							-- It does not matter if the row is hidden or show, the
							-- code below will ensure that the rows are properly shown/hidden
							-- depending on the match.
						grid.row (1).hide
						grid.row (1).show
					end
				until
					i > nb
				loop
					l_row := grid.row (i)
					if attached {like row_data_type} l_row.data as l_data then
							-- Because regular expression don't support Unicode,
							-- we convert the input text
						if l_reg.is_matching (l_data.text) then
							l_row.show
							if not l_row_selected then
								l_row_selected := True
								grid.select_row (i)
							end
						else
							if settings.is_list_filtered_when_typing then
								l_row.hide
							end
						end
					end
					i := i + 1
				end
				resize_column_to_window_width
			end
		end

	suggest_and_close
			-- Perform suggestion with selected item and close window.
		local
			l_grid: like grid
			l_rows: ARRAYED_LIST [EV_GRID_ROW]
		do
			l_grid := grid
			l_rows := l_grid.selected_rows
			if not l_rows.is_empty and then attached {like row_data_type} l_rows.first.data as l_data then
				field.insert_suggestion (l_data)
			end
			close
		end

	close
			-- Close window without performing the suggestion.
		do
			if not is_destroyed and not is_closing then
				is_closing := True
				if has_capture then
					disable_capture
				end
				save_window_position
				hide
				field.terminate_suggestion
				is_closing := False
			end
		end

	save_window_position
			-- Save current window position.
		do
			if attached settings.save_list_position_action as l_save_action and is_displayed then
				l_save_action.call ([screen_x, screen_y, width, height])
			end
		end

	is_closing: BOOLEAN
			-- Is the window being closed?

	resize_column_to_window_width
			-- Resize the column width to the width of the grid.
		local
			l_grid: like grid
			l_column: EV_GRID_COLUMN
			l_min_width: INTEGER
			i, l_column_count: INTEGER
		do
			l_grid := grid
			l_column_count := l_grid.column_count
			if l_column_count > 0 and then l_grid.row_count > 0 then
					-- Compute the minimum width that the column might have,
					-- it is bounded to the width of Current.
				if l_grid.vertical_scroll_bar.is_show_requested then
						-- Vertical scrollbar is visible
					l_min_width := l_grid.width - l_grid.vertical_scroll_bar.width
				else
					l_min_width := l_grid.width
				end

					-- Let's compute the expected width of current items. For the first
					-- `l_column_count - 1' columns we use their expected width. And for the
					-- last column we made it as big as the remaining width. We update
					-- `l_min_width' to take into account the previously computed width.
				from
					i := 1
				until
					i > l_column_count - 1
				loop
					l_column := l_grid.column (l_column_count)
					l_column.set_width (l_column.required_width_of_item_span (1, l_grid.row_count))
						-- Update the remaining width
					l_min_width := l_min_width - l_column.width
					i := i + 1
				end
					-- Last column, we made it as big as the width of the grid if smaller
					-- otherwise it will be bigger.
				l_column := l_grid.column (l_column_count)
				l_column.set_width (l_min_width.max (
					l_column.required_width_of_item_span (1, l_grid.row_count)))
			end
		end

	is_list_recomputation_required: BOOLEAN
			-- If True, next call to `build_suggestion_list' would query
			-- the associated suggestion provider to gather some new results.

	row_data_type: SUGGESTION_ITEM
			-- Type of `data' associated to each row of the grid.
		require
			not_callable: False
		do
			create {LABEL_SUGGESTION_ITEM} Result.make ("")
		ensure
			not_called: False
		end

	field: EV_ABSTRACT_SUGGESTION_FIELD

	settings: EV_SUGGESTION_SETTINGS
			-- Settings associated with current `field'.
		do
			Result := field.settings
		end

	mouse_wheel_scroll_full_page_internal: BOOLEAN = False

	mouse_wheel_scroll_size_internal: INTEGER = 3

	scrolling_common_line_count_internal: INTEGER = 1

	suggestion_timeout: EV_TIMEOUT
			-- Timeout for showing suggestion list if not already shown, and if shown, timeout
			-- to refresh the suggestion list with new input if any.

	reset_suggestion_timeout
			-- When a key is press, we reset `suggestion_timeout'
		do
			suggestion_timeout.set_interval (settings.timeout)
		end

	disable_suggestion_timeout
			-- Stop `suggestion_timeout'.
		do
			suggestion_timeout.set_interval (0)
		end

	enable_suggestion_timeout
			-- Restart `suggestion_timeout'.
		do
			suggestion_timeout.set_interval (settings.timeout)
		end

	associated_grid_item (a_column, a_row: INTEGER): EV_GRID_ITEM
			-- Item associated to `grid' at position (`a_column', `a_row').
		local
			l_row: EV_GRID_ROW
			l_item: detachable EV_GRID_ITEM
		do
			l_row := grid.row (a_row)
			if attached {like row_data_type} l_row.data as l_data then
				settings.update_row (l_row, l_data)
				l_item := l_row.item (a_column)
			end
			if l_item /= Void then
				Result := l_item
			else
				create {EV_GRID_LABEL_ITEM} Result.make_with_text ("")
				Result.set_background_color (create {EV_COLOR}.make_with_rgb (1.0, 0.0, 0.0))
			end
		end

feature {NONE} -- Positionning

	position_suggestion_choice_window
			-- Reposition the suggestion choice window
		local
			l_helpers: EVS_HELPERS
			l_origin: TUPLE [x, y: INTEGER]
			l_pos: like suggestion_list_coordinates
		do
			l_pos := suggestion_list_coordinates
			if attached field.parent_window as l_parent_window and then not l_parent_window.is_destroyed and then l_parent_window.is_show_requested then
					-- Reposition based on screen coords
				create l_helpers
				l_origin := l_helpers.suggest_pop_up_widget_location_with_size (l_parent_window, l_pos.x, l_pos.y, l_pos.width, l_pos.height)
				if l_pos.y >= l_origin.y then
						-- Adjust height to prevent the suggestion list from shift up and over the text.
						-- This is ok to do because `calculate_suggestion_list_y_position' determines if the
						-- list should be shown above or below the editor caret. If it's displayed below then
						-- we adjust the size of the list to remain on-screen.
					l_pos.height := l_pos.height - (l_pos.y - l_origin.y)
				end
			end

			set_size (l_pos.width, l_pos.height)
			set_position (l_pos.x, l_pos.y)
		end

	suggestion_list_coordinates: TUPLE [x, y, width, height: INTEGER]
			-- Position of suggestion list
		local
			l_right_space: INTEGER
			l_grid: EV_GRID
			l_font: EV_FONT
			l_text_before_cursor: STRING_32
			l_monitor: EV_RECTANGLE
			l_upper_space, l_lower_space: INTEGER
			l_is_show_below: BOOLEAN
		do
				-- We get the monitor on which the underlying field is positioned. We will do our best to
				-- have the suggestion list appearing on that monitor only.
			l_monitor := (create {EV_SCREEN}).implementation.working_area_from_position (
				field.screen_x, field.screen_y)

			l_grid := grid
			Result := [0, 0, 0, 0]

				-- Compute the X coordinate of the suggestion list.
			Result.x := field.screen_x
			if settings.is_initial_position_at_caret then
					-- Ensures that our completion list starts where the caret position is
					-- when requested in `settings'.
				if field.caret_position > 1 then
					l_font := field.font
					l_text_before_cursor := field.displayed_text.substring (1, field.caret_position - 1)
					Result.x := Result.x + l_font.string_width (l_text_before_cursor) + 5
				end
			end

				-- Compute the Y coordinate of the suggestion list which can be either below the
				-- field if there is enough space below, or above otherwise. We will use the estimate
				-- of the height of the grid for that.
			Result.y := field.screen_y
				-- If cursor is in upper two thirds of screen we show below.
			l_is_show_below := Result.y < ((l_monitor.height / 3) * 2)

				-- `l_upper_space' is the space above the text field.
				-- `l_lower_space' is the space under the text field.
			l_upper_space := Result.y
			l_lower_space := l_monitor.bottom - Result.y - field.height

				-- Estimated height of the suggestion list is the number of rows
				-- visible present multiplied by the row_height.
			Result.height := grid.visible_row_count * grid.row_height

			if l_is_show_below and then Result.height > l_lower_space and then Result.height <= l_upper_space then
					-- Not enough room to show below, but is enough room to show above, so we will show above
				l_is_show_below := False
			elseif not l_is_show_below and then Result.height <= l_lower_space then
					-- Even though we are in the bottom 3rd of the screen we can actually show below because
					-- the saved size fits
				l_is_show_below := True
			end

			if l_is_show_below and then Result.height > l_lower_space then
					-- Not enough room to show below so we must resize
				Result.height := l_lower_space
			elseif not l_is_show_below and then Result.height >= l_upper_space then
					-- Not enough room to show above so we must resize
				Result.height := l_upper_space
			end

				-- Update the Y coordinate of the list.
			if l_is_show_below then
				Result.y := Result.y + field.height
			else
				Result.y := Result.y - Result.height
			end

				-- Ensure it is at least as big as the underlying field.
			Result.width := Result.width.max (field.width)
				-- Ensure it is no wider than the current monitor.
			Result.width := l_monitor.width.min (Result.width)

				-- Determine how much room there is free on the right of the screen from the cursor position
			l_right_space := l_monitor.right - Result.x
			if l_right_space < Result.width then
					-- Shift x pos back so it fits on the screen
				Result.x := Result.x - (Result.width - l_right_space)
			end
			Result.x := Result.x.max (l_monitor.x)
		end

feature {NONE} -- Grid helpers

	first_visible_row (a_grid: EV_GRID): detachable EV_GRID_ROW
			-- Gives the first fully visible row of the grid. Unlike `{EV_GRID}.first_visible_row'
			-- which returns the first partially visible row of the grid.
			-- If a row cannot be fully visible (e.g. taller than the grid's viewable_height) it
			-- returns `{EV_GRID}.first_visible_row'.
		require
			a_grid_not_destroyed: not a_grid.is_destroyed
		local
			l_indexes: ARRAYED_LIST [INTEGER]
			l_count: INTEGER
		do
			l_indexes := a_grid.visible_row_indexes
			l_count := l_indexes.count
			if l_count > 0 then
				Result := a_grid.row (l_indexes.i_th (1))
				if
					l_count > 1 and then
					Result /= Void and then
					Result.virtual_y_position < a_grid.virtual_y_position
				then
						-- First visible rows is not fully visible, we go for the fully visible one if it exists.
					if
						attached a_grid.row (l_indexes.i_th (2)) as l_next_row and then
						l_next_row.virtual_y_position + l_next_row.height <= a_grid.virtual_y_position + a_grid.viewable_height
					 then
							-- Next item is fully visible, we use it as target.
						Result := l_next_row
					end
				end
			end
		end

	last_visible_row (a_grid: EV_GRID): detachable EV_GRID_ROW
			-- Gives the last fully visible row of the grid. Unlike `{EV_GRID}.last_visible_row'
			-- which returns the last partially visible row of the grid.
			-- If a row cannot be fully visible (e.g. taller than the grid's viewable_height) it
			-- returns `{EV_GRID}.last_visible_row'.
		require
			a_grid_not_destroyed: not a_grid.is_destroyed
		local
			l_indexes: ARRAYED_LIST [INTEGER]
			l_count: INTEGER
		do
			l_indexes := a_grid.visible_row_indexes
			l_count := l_indexes.count
			if l_count > 0 then
				Result := a_grid.row (l_indexes.i_th (l_count))
				if
					l_count > 1 and then
					Result /= Void and then
					Result.virtual_y_position + Result.height > a_grid.virtual_y_position + a_grid.viewable_height
				then
						-- Last visible rows is not fully visible, we go for the fully visible one if it exists.
					if
						attached a_grid.row (l_indexes.i_th (l_count - 1)) as l_prev_row and then
						l_prev_row.virtual_y_position >= a_grid.virtual_y_position
					 then
							-- Previous item is fully visible, we use it as target.
						Result := l_prev_row
					end
				end
			end
		end

	viewable_row_count: INTEGER
			-- Number of items that will be scrolled when doing a page up or down operation.
		local
			l_grid: like grid
		do
			l_grid := grid
			Result := l_grid.viewable_height // l_grid.row_height
		end

	select_row (a_row: INTEGER)
			-- Select row `i'.
			-- If invisible, select its parent
		require
			a_row_is_valid: a_row > 0 and a_row <= grid.row_count
		local
			i: INTEGER
			l_row: detachable EV_GRID_ROW
			l_grid: like grid
			l_rows: ARRAYED_LIST [EV_GRID_ROW]
		do
			l_grid := grid
			if l_grid.row_count > 0 then
					-- Go to bottom
				l_grid.remove_selection

				i := a_row
				l_row := l_grid.row (i).parent_row
				if l_row = Void then
					l_grid.row (i).enable_select
				else
					if not l_row.is_expanded then
						l_row.enable_select
					else
						l_grid.row (i).enable_select
					end
				end
				l_rows := l_grid.selected_rows
				if not l_rows.is_empty and then l_rows.first.is_displayed then
					l_rows.first.ensure_visible
				end
			end
		end

feature {NONE} -- Implementation

	grid: EV_GRID
			-- Grid displaying result of search.

	border_width: INTEGER = 1
			-- Number of pixels for the border surrounding the suggestion window.

invariant

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
