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
		redefine
			create_interface_objects, initialize, show
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

	make (l_field: EV_ABSTRACT_SUGGESTION_FIELD)
		do
			field := l_field
			default_create
		end

	create_interface_objects
			-- <Precursor>
		do
			Precursor
			create grid
			create buffered_input.make (10)
			create suggestion_timeout
		end

	initialize
			-- <Precursor>
		local
			vbox: EV_VERTICAL_BOX
			l_scrolling: ES_GRID_SCROLLING_BEHAVIOR
		do
			Precursor
			create l_scrolling.make (grid)

				-- Update mousewheel scrollign settings from `settings'.
			l_scrolling.set_scrolling_common_line_count (settings.scrolling_common_line_count)
			l_scrolling.set_mouse_wheel_scroll_size (settings.mouse_wheel_scroll_size)
			l_scrolling.set_mouse_wheel_scroll_full_page (settings.is_mouse_wheel_in_full_page_mode)

			grid.default_key_processing_handler := agent (a_key: EV_KEY): BOOLEAN
				do
					Result := not a_key.is_arrow and not (a_key.code = {EV_KEY_CONSTANTS}.key_tab)
				end
			grid.enable_single_row_selection
			grid.key_press_string_actions.extend (agent on_char)
			grid.key_press_actions.extend (agent on_key_down)
			grid.pointer_double_press_actions.extend (agent mouse_selection)
			grid.hide_header
			grid.disable_selection_key_handling
			grid.enable_partial_dynamic_content
			grid.set_dynamic_content_function (agent associated_grid_item)
			grid.virtual_position_changed_actions.extend (agent on_scroll)
			grid.enable_selection_key_handling

			create vbox
			vbox.extend (grid)
			extend (vbox)

			grid.focus_out_actions.extend (agent on_lose_focus)
			focus_out_actions.extend (agent on_lose_focus)
			resize_actions.force_extend (agent resize_column_to_window_width)
		end

feature -- Access

	grid: EV_GRID
			-- Grid displaying result of search.

	full_list: detachable ARRAYED_LIST [like row_data_type]
			-- List of current suggestion.

feature -- Status Setting

	show
			-- Show
		do
				-- Initialize the current suggest list with what has been entered in `field'.
			build_suggestion_list (field.text, True)

				-- Select the entry that match `buffered_input' by default.
			select_closest_match

			position_suggestion_choice_window
			Precursor
			ev_application.do_once_on_idle (agent resize_column_to_window_width)
			ev_application.do_once_on_idle (agent grid.set_focus)
		end

feature -- Query

	default_font: EV_FONT
			-- Default font
		once
			create Result
		end

feature {NONE} -- Events handling

	mouse_selection (x_pos, y_pos, button: INTEGER; unused1,unused2,unused3: DOUBLE; unused4,unused5:INTEGER)
			-- process mouse click in the list
		do
			if button = 1 and not grid.selected_items.is_empty then
				suggest_and_close
			end
		end

	on_key_down (ev_key: EV_KEY)
			-- process user input in `grid'	
		local
			l_rows: ARRAYED_LIST [EV_GRID_ROW]
			l_indexes: ARRAYED_LIST [INTEGER_32]
		do
			inspect
				ev_key.code
			when {EV_KEY_CONSTANTS}.key_left, {EV_KEY_CONSTANTS}.key_right then
				if settings.has_arrows_key_text_navigation then
					l_rows := grid.selected_rows
					if l_rows.is_empty or else not l_rows.first.is_expanded then
						if ev_key.code = {EV_KEY_CONSTANTS}.key_left then
							if field.caret_position = 0 then
									-- We are at the beginning, so going to the left one more
									-- time is a user intent to say he does not want to be
									-- provided with a suggestion.
								close
							else
								field.move_caret_to (field.caret_position - 1)
							end
						else
							if field.caret_position >= field.text.count + 1 then
									-- We are at the end, so going to the right one more
									-- time is a user intent to say he does not want to
									-- be provided with a suggestion.
								close
							else
								field.move_caret_to (field.caret_position + 1)
							end
						end
					end
				end
			when {EV_KEY_CONSTANTS}.Key_up then
				go_to_next_item (False, False)
			when {EV_KEY_CONSTANTS}.Key_down then
				go_to_next_item (True, False)
--			when {EV_KEY_CONSTANTS}.Key_page_up then
--				go_to_next_page (False, True)
--			when {EV_KEY_CONSTANTS}.Key_page_down then
--				go_to_next_page (True, True)
--			when {EV_KEY_CONSTANTS}.key_home then
--				if grid.row_count > 0 then
--					l_indexes := grid.viewable_row_indexes
--					if l_indexes.is_empty then
--						select_row (1)
--					else
--						select_row (l_indexes.first)
--					end
--				end
--			when {EV_KEY_CONSTANTS}.key_end then
--				if grid.row_count > 0 then
--					l_indexes := grid.viewable_row_indexes
--					if l_indexes.is_empty then
--						select_row (grid.row_count)
--					else
--						select_row (l_indexes.last)
--					end
--				end
			when {EV_KEY_CONSTANTS}.Key_enter then
				suggest_and_close
			when {EV_KEY_CONSTANTS}.Key_escape then
				close

			when {EV_KEY_CONSTANTS}.key_back_space, {EV_KEY_CONSTANTS}.key_delete then
				if ev_application.ctrl_pressed then
					field.handle_extended_ctrled_key (ev_key)
				else
					field.handle_extended_key (ev_key)
				end
				if not buffered_input.is_empty then
					if ev_key.code = {EV_KEY_CONSTANTS}.key_back_space then
						if ev_application.ctrl_pressed then
							buffered_input.wipe_out
						else
							buffered_input := buffered_input.substring (1, buffered_input.count - 1)
						end
					end
				else
						-- List is discarded if all the characters inserted have been
						-- removed and that the user press one more time the backspace key
						-- showing his intent of stopping the suggestion.
					close
				end
				build_suggestion_list (buffered_input, False)
				select_closest_match

			when {EV_KEY_CONSTANTS}.key_v then
				if ev_application.ctrl_pressed then
					field.handle_extended_ctrled_key (ev_key)
					buffered_input.append (ev_application.clipboard.text)
				else
					field.handle_extended_key (ev_key)
				end
				build_suggestion_list (buffered_input, False)
				select_closest_match

			else
				-- Do nothing
			end
		end

	on_char (character_string: STRING_32)
   			-- Process displayable character key press event.
   		local
   			c: CHARACTER_32
   		do
			if character_string.count = 1 then
				c := character_string.item (1)
				if attached settings.suggestion_deactivator_characters as l_table and then l_table.has (c) then
					suggest_and_close
					field.handle_character (c)
				else
					buffered_input.append_character (c)
					field.handle_character (c)
					build_suggestion_list (buffered_input, False)
					select_closest_match
				end
			end
		end

	on_lose_focus
			-- close window
		do
			if (not (is_destroyed or else has_focus or else grid.has_focus)) and is_displayed then
				close
			end
		end

	on_row_expand (a_row: EV_GRID_ROW)
			-- On row expand
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
		require
			a_row_not_void: a_row /= Void
		do
			ev_application.do_once_on_idle (agent resize_column_to_window_width)
		end

feature {NONE} -- Navigation

	page_up
			-- Page up
		local
			l_selected_row: INTEGER
			i: INTEGER
			l_viewable_row_count: INTEGER
			l_count: INTEGER
			end_loop: BOOLEAN
			l_last_selectable: INTEGER
		do
			if grid.row_count > 0 then
				if not grid.selected_items.is_empty then
					lock_update
					l_selected_row := grid.selected_rows.first.index
					if not grid.visible_row_indexes.has (l_selected_row) then
						l_selected_row := grid.visible_row_indexes.first
					end
					l_viewable_row_count := viewable_row_count - settings.scrolling_common_line_count
					l_last_selectable := l_selected_row
					from
						i := l_selected_row
					until
						i < 1 or end_loop
					loop
						if attached grid.row (i).parent_row as l_parent_row implies l_parent_row.is_expanded then
							l_count := l_count + 1
							l_last_selectable := i
						end
						if l_count > l_viewable_row_count then
							end_loop := True
						end
						i := i - 1
					end
					grid.remove_selection
					grid.row (l_last_selectable).enable_select
					grid.row (l_last_selectable).ensure_visible
					unlock_update
				end
			end
		end

	page_down
			-- Page down
		local
			l_selected_row: INTEGER
			i: INTEGER
			l_viewable_row_count: INTEGER
			l_count: INTEGER
			end_loop: BOOLEAN
			l_last_selectable: INTEGER
			l_rows: ARRAYED_LIST [EV_GRID_ROW]
		do
			if grid.row_count > 0 then
				l_rows := grid.selected_rows
				if not l_rows.is_empty then
					lock_update
					l_selected_row := l_rows.first.index
					if not grid.visible_row_indexes.has (l_selected_row) then
						l_selected_row := grid.visible_row_indexes.last
					end
					l_viewable_row_count := viewable_row_count - settings.scrolling_common_line_count
					l_last_selectable := l_selected_row
					from
						i := l_selected_row
					until
						i > grid.row_count or end_loop
					loop
						if attached grid.row (i).parent_row as l_parent_row implies l_parent_row.is_expanded then
							l_count := l_count + 1
							l_last_selectable := i
						end
						if l_count > l_viewable_row_count then
							end_loop := True
						end
						i := i + 1
					end
					grid.remove_selection
					grid.row (l_last_selectable).enable_select
					grid.row (l_last_selectable).ensure_visible
					unlock_update
				end
			end
		end

	go_to_next_item (a_is_forward, a_is_by_page: BOOLEAN)
			-- Iterate grid to find the next item for keyboard naviation
			-- `a_is_forward' control if the search should be forward or backward.
			-- `a_is_by_page' control is the search should be done on a page by page basis
			-- or on an item by item basis.
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

	go_to_next_page (a_is_forward, a_is_by_page: BOOLEAN)
			-- Iterate grid to find the next item for keyboard naviation
			-- `a_is_forward' control if the search should be forward or backward.
			-- `a_is_by_page' control is the search should be done on a page by page basis
			-- or on an item by item basis.
		local
			i, ix: INTEGER
			l_loop_end: BOOLEAN
			l_grid: like grid
			l_indexes: ARRAYED_LIST [INTEGER]
			l_rows: ARRAYED_LIST [EV_GRID_ROW]
			l_offset: INTEGER
			l_row, l_target_row: detachable EV_GRID_ROW
		do
			l_grid := grid
			l_rows := l_grid.selected_rows
			l_grid.remove_selection
			if not l_rows.is_empty then
				l_target_row := l_rows.first
				l_target_row.ensure_visible

				l_row := l_grid.last_visible_row
				if l_row /= Void then
					if l_target_row = l_row then
							-- The bottom row is the last selected rows, we can scroll down.
						l_grid.set_virtual_position (l_grid.virtual_x_position, l_row.virtual_y_position)
					end
					l_row.enable_select
					l_row.ensure_visible
				end
			else
				l_target_row := l_grid.first_visible_row
				if l_target_row /= Void then
					l_target_row.enable_select
					l_target_row.ensure_visible
				end
			end

			l_indexes := l_grid.visible_row_indexes
			if not l_indexes.is_empty then
				l_target_row := l_grid.row (l_indexes.last)
				l_target_row.ensure_visible
			end

--			l_rows := l_grid.selected_rows
--			if not l_rows.is_empty then
--				ix := l_rows.first.index
--				l_grid.remove_selection
--				if a_is_forward then
--					l_offset := 1
--				else
--					l_offset := -1
--				end
--				i := ix + l_offset
--				from
--				until
--					l_loop_end
--				loop
--						-- Rotate the search if we are on the last or first item.					
--					if i <= 0 then
--						i := l_grid.row_count
--					elseif i >= l_grid.row_count then
--						i := 1
--					end
--					l_row := l_grid.row (i)
--					if l_row.is_displayed then
--						l_row.enable_select
--						l_row.ensure_visible
--						l_loop_end := True
--					end
--					i := i + l_offset
--				end
--			end
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

feature {NONE} -- Completion

	build_suggestion_list (a_name: READABLE_STRING_GENERAL; a_is_first: BOOLEAN)
			-- Build the list based on matches with `name'. If `a_is_first' it is
			-- the first time that the list will be shown and a new query to the
			-- suggestion provider is issued. If `is_list_recomputation_required'
			-- a new query to the suggestion provider will be issued even if not
			-- otherwise required.
		require
			choice_list_attached: grid /= Void
		local
			l_grid: like grid
		do
				-- To prevent flickering due to the potential
				-- hidding/showing of scrollbars we lock ourselve
				-- while rebuilding the list.
			lock_update

			l_grid := grid
			buffered_input := a_name.to_string_32

				-- If this is the first time we are showing the list or if
				-- settings dictate that it has to be recomputed, we get the
				-- results from the associated suggestion provider of `field'.
			if a_is_first or else is_list_recomputation_required then
				l_grid.wipe_out
				l_grid.set_column_count_to (1)
				create full_list.make (1)
				field.suggestion_provider.query_with_callback_and_cancellation (a_name, agent (a_item: SUGGESTION_ITEM)
					do
						grid.insert_new_row (grid.row_count + 1)
						grid.row (grid.row_count).set_data (a_item)
						if attached full_list as l_list then
							l_list.extend (a_item)
						end
					end, settings.query_cancel_request)
			else
					-- We are going to remove from the list all items that don't
					-- match `buffered_input'.

			end

				-- Let's resize the column width to match the new content.
			resize_column_to_window_width

				-- Let's unlock the window to refresh its content with the newly
				-- build content.
			unlock_update
		ensure
			buffered_input_set: buffered_input.same_string_general (a_name)
		end

	select_closest_match
			-- Find the closes match to `buffered_input' in the list we have.
		local
			l_reg: SUGGESTION_MATCHER
			i, nb: INTEGER
			l_row_selected: BOOLEAN
			l_row: EV_GRID_ROW
		do
			l_reg := settings.matcher
			l_reg.prepare (buffered_input)
				-- If regular expression can be computed
				-- we go ahead otherwise we leave things unchanged.
			if l_reg.is_ready then
				from
					i := 1
					nb := grid.row_count
				until
					i > nb
				loop
					l_row := grid.row (i)
					if attached {like row_data_type} l_row.data as l_data then
							-- Because regular expression don't support unicode,
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
			if not l_rows.is_empty then
					-- Delete characters inserted during suggestion so it is later
					-- replaced by the suggestion text
				if not buffered_input.is_empty then
					remove_characters_entered_since_display
				end
				if attached {like row_data_type} l_rows.first.data as l_data then
					field.insert_suggestion (l_data.suggestion_text, l_data)
				end
			end
			close
		end

	close
			-- Close window without performing the suggestion.
		do
			if not is_closing then
				is_closing := True
				if has_capture then
					disable_capture
				end
				save_window_position
		--		hide
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

	current_meta_keys: ARRAY [BOOLEAN]
		do
			Result := <<ev_application.ctrl_pressed, ev_application.alt_pressed, ev_application.shift_pressed>>
		end

	activate_tooltip
			-- Activate selected item tooltip in list
		do
--			grid.selected_items.first. selected_item.pointer_motion_actions.call ([1,1,1.0,1.0,1.0,1,1])
		end

	remove_characters_entered_since_display
			-- Remove characters entered so we may put them back
		require
			buffered_input_not_void: buffered_input /= Void
		local
			l_index: INTEGER
		do
			from
				l_index := 1
			until
				l_index > buffered_input.count
			loop
				field.delete_character_before
				l_index := l_index + 1
			end
		end

	resize_column_to_window_width
			-- Resize the column width to the width of the window
		local
			l_grid: like grid
			l_column: EV_GRID_COLUMN
			l_min_width: INTEGER
		do
			l_grid := grid
			if l_grid.column_count > 0 and then l_grid.row_count > 0 then
					-- Compute the minimum width that the column might have,
					-- it is bounded to the width of Current.
				if l_grid.vertical_scroll_bar.is_show_requested then
						-- Vertical scrollbar is visible
					l_min_width := l_grid.width - l_grid.vertical_scroll_bar.width
				else
					l_min_width := l_grid.width
				end

					-- Let's compute the expected width of current items, it will take
					-- into account the newly displayed items that were previously hidden.
				l_column := l_grid.column (1)
				l_column.set_width (l_min_width.max (
					l_column.required_width_of_item_span (1, l_grid.row_count)))
			end
		end

	on_scroll (x, y: INTEGER)
			-- Action performed during vertical scrolling of `grid'.
		do
				-- Because not all items are visible, we recompute the maximum with
				-- of the newly shown items and adjust the column width accordingly.
			ev_application.do_once_on_idle (agent resize_column_to_window_width)
		end

	buffered_input: STRING_32
			-- Buffered user input

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

	viewable_row_count: INTEGER
			-- Number of items that will be scrolled when doing a page up or down operation.
		local
			l_grid: like grid
		do
			l_grid := grid
			Result := l_grid.viewable_height // l_grid.row_height
		end

	grid_row_by_data (a_data: ANY) : INTEGER
			-- Find a row in a_grid that include a_data
		local
			i: INTEGER
			l_row: EV_GRID_ROW
			loop_end: BOOLEAN
			l_grid: like grid
		do
			l_grid := grid
			loop_end := False
			from
				i := 1
			until
				i > l_grid.row_count or loop_end
			loop
				l_row := l_grid.row (i)
				if l_row.data /= Void and then l_row.data = a_data then
					Result := i
					loop_end := True
				end
				i := i + 1
			end
		end

	associated_grid_item (a_column, a_row: INTEGER): EV_GRID_ITEM
			-- Item associated to `grid' at position (`a_column', `a_row').
		local
			l_row: EV_GRID_ROW
		do
			l_row := grid.row (a_row)
			if attached {like row_data_type} l_row.data as l_data then
				Result := settings.to_displayed_item (l_data)
			else
				create {EV_GRID_LABEL_ITEM} Result.make_with_text ("no data")
			end
		end

feature {NONE} -- Positionning

	position_suggestion_choice_window
			-- Reposition the suggestion choice window
		local
			l_x, l_y: INTEGER
			l_width, l_height: INTEGER
			l_helpers: EVS_HELPERS
			l_coords: TUPLE [x, y: INTEGER]
		do
			l_width := calculate_suggestion_list_width
			l_height := calculate_suggestion_list_height
			l_x := calculate_suggestion_list_x_position
			l_y := calculate_suggestion_list_y_position

			if attached field.parent_window as l_parent_window and then not l_parent_window.is_destroyed and then l_parent_window.is_show_requested then
					-- Reposition based on screen coords
				create l_helpers
				l_coords := l_helpers.suggest_pop_up_widget_location_with_size (l_parent_window, l_x, l_y, l_width, l_height)
				if l_y >= l_coords.y then
						-- Adjust height to prevent the suggestion list from shift up and over the text.
						-- This is ok to do because `calculate_suggestion_list_y_position' determines if the
						-- list should be shown above or below the editor caret. If it's displayed below then
						-- we adjust the size of the list to remain on-screen.
					l_height := l_height - (l_y - l_coords.y)
				end
			end

			set_size (l_width, l_height)
			set_position (l_x, l_y)
		end

	calculate_suggestion_list_x_position: INTEGER
			-- Determine the x position to display the suggestion list
		local
			screen: EV_SCREEN
			right_space,
			list_width: INTEGER
			l_font: EV_FONT
			l_text_before_cursor: STRING_32
			l_monitor: EV_RECTANGLE
		do
			if settings.is_list_x_position_set then
					-- Use the `x' coordinate specified by the settings.
				Result := settings.list_x_position
			else
				create screen
				l_monitor := screen.implementation.working_area_from_position (field.screen_x, field.screen_y)

					-- Get current x position of cursor
				Result := field.screen_x
				if settings.is_initial_position_at_caret then
					l_font := field.font
					if field.caret_position > 1 then
						l_text_before_cursor := field.text.substring (1, field.caret_position - 1)
						Result := Result + l_font.string_width (l_text_before_cursor) + 5
					end
				end

					-- Determine how much room there is free on the right of the screen from the cursor position
				right_space := l_monitor.right - Result
				list_width := calculate_suggestion_list_width

				if right_space < list_width then
						-- Shift x pos back so it fits on the screen
					Result := Result - (list_width - right_space)
				end
				Result := Result.max (l_monitor.x)
			end
		end

	calculate_suggestion_list_y_position: INTEGER
			-- Determine the y position to display the suggestion list
		local
			screen: EV_SCREEN
			preferred_height,
			upper_space,
			lower_space: INTEGER
			show_below: BOOLEAN
			l_monitor: EV_RECTANGLE
		do
			if settings.is_list_y_position_set then
					-- Use the `y' coordinate specified by the settings.
				Result := settings.list_y_position
			else
					-- Get y pos of cursor
				Result := field.screen_y

				create screen
				l_monitor := screen.implementation.working_area_from_position (field.screen_x, Result)
				show_below := True

				if Result < ((l_monitor.height / 3) * 2) then
						-- Cursor in upper two thirds of screen
					show_below := True
				else
						-- Cursor in lower third of screen
					show_below := False
				end

				upper_space := Result
				lower_space := l_monitor.bottom - Result

				preferred_height := calculate_suggestion_list_height

				if show_below and then preferred_height > lower_space and then preferred_height <= upper_space then
						-- Not enough room to show below, but is enough room to show above, so we will show above
					show_below := False
				elseif not show_below and then preferred_height <= lower_space then
						-- Even though we are in the bottom 3rd of the screen we can actually show below because
						-- the saved size fits
					show_below := True
				end

				if show_below and then preferred_height > lower_space then
						-- Not enough room to show below so we must resize
					preferred_height := lower_space
				elseif not show_below and then preferred_height >= upper_space then
						-- Not enough room to show above so we must resize
					preferred_height := upper_space
				end
				if show_below then
					Result := Result + field.height
				else
					Result := Result - preferred_height
				end
			end
		end

	calculate_suggestion_list_height: INTEGER
			-- Determine the height the suggestion should list should have
		local
			upper_space,
			lower_space,
			y_pos: INTEGER
			screen: EV_SCREEN
			show_below: BOOLEAN
			l_monitor: EV_RECTANGLE
		do
			if settings.is_list_height_set then
					-- Use the `height' specified by the settings.
				Result := settings.list_height
			else
					-- Get y pos of cursor
				create screen
				show_below := True
				y_pos := field.screen_y
				l_monitor := screen.implementation.working_area_from_position (field.screen_x, field.screen_y)

				if y_pos < ((l_monitor.height / 3) * 2) then
						-- Cursor in upper two thirds of screen
					show_below := True
				else
						-- Cursor in lower third of screen
					show_below := False
				end

				upper_space := y_pos
				lower_space := l_monitor.bottom - y_pos - field.height

					-- By default we use the maximum height available.
				Result := grid.virtual_height

				if show_below and then Result > lower_space and then Result <= upper_space then
						-- Not enough room to show below, but is enough room to show above, so we will show above
					show_below := False
				elseif not show_below and then Result <= lower_space then
						-- Even though we are in the bottom 3rd of the screen we can actually show below because
						-- the saved size fits
					show_below := True
				end

				if show_below and then Result > lower_space then
						-- Not enough room to show below so we must resize
					Result := lower_space
				elseif not show_below and then Result >= upper_space then
						-- Not enough room to show above so we must resize
					Result := upper_space
				end
			end
		end

	calculate_suggestion_list_width: INTEGER
			-- Determine the width the suggestion list should have
		local
			l_grid: EV_GRID
			l_screen: EV_SCREEN
			l_height: INTEGER
			l_count_to_calculate: INTEGER
			i: INTEGER
		do
			if settings.is_list_width_set then
					-- Use the `width' specified by the settings.			
				Result := settings.list_width
			else
				l_grid := grid
					-- Calculate correct size to fit
				if not l_grid.is_destroyed and then l_grid.column_count >= 1 and then l_grid.row_count > 0 then
					Result := l_grid.column (1).required_width_of_item_span (1, l_grid.row_count)
					if Result = 0 then
						l_height := calculate_suggestion_list_height
						l_count_to_calculate := l_height // l_grid.row_height + 1
						l_count_to_calculate := l_count_to_calculate.min (l_grid.row_count)
						from
							i := 1
						until
							i > l_count_to_calculate
						loop
							if attached l_grid.item (1, i) as l_grid_item then
								Result := Result.max (l_grid_item.required_width)
							end
							i := i + 1
						end

							-- Make sure border and any potential vertical scrollbar is taken in to account.
						Result := Result + l_grid.vertical_scroll_bar.width
					end
				end
			end

				-- Ensure it is has big as the underlying field.
			Result := Result.max (field.width)
				-- Ensure it is no wider than the current monitor.
			create l_screen
			Result := l_screen.width.min (Result)
		end

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
