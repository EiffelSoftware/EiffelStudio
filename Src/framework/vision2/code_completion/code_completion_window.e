indexing
	description: "Window that displays a text area and a list of possible features for automatic completion"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_COMPLETION_WINDOW

inherit
	EV_POPUP_WINDOW
		redefine
			show
		end

	EV_KEY_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
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

	make is
			-- Create
		local
			vbox: EV_VERTICAL_BOX
		do
			create choice_list
			choice_list.default_key_processing_handler := agent (a_key: EV_KEY): BOOLEAN
				do
					Result := not a_key.is_arrow and not (a_key.code = {EV_KEY_CONSTANTS}.key_tab)
				end
			choice_list.enable_single_row_selection
			choice_list.key_press_string_actions.extend (agent on_char)
			choice_list.key_press_actions.extend (agent on_key_down)
			choice_list.key_release_actions.extend (agent on_key_released)
			choice_list.pointer_double_press_actions.extend (agent mouse_selection)
			choice_list.hide_header
			choice_list.disable_selection_key_handling
			choice_list.enable_partial_dynamic_content
			choice_list.set_dynamic_content_function (agent on_item_display)
			choice_list.virtual_position_changed_actions.extend (agent on_scroll)
			choice_list.mouse_wheel_actions.extend (agent on_mouse_wheel)

			make_with_shadow
			enable_user_resize
			option_bar_box := build_option_bar
			create vbox
			vbox.extend (choice_list)
			vbox.extend (option_bar_box)
			vbox.disable_item_expand (option_bar_box)
			extend (vbox)
			choice_list.focus_out_actions.extend (agent on_lose_focus)
			focus_out_actions.extend (agent on_lose_focus)
			resize_actions.force_extend (agent resize_column_to_window_width)
		end

	build_option_bar: EV_VERTICAL_BOX is
			-- Build option bar.
		do
			create Result
		end

feature -- Initialization

	common_initialization (an_editor: like code_completable;
						a_name: STRING; a_remainder: INTEGER;
						a_completion_possibilities: like sorted_names;
						a_complete_word: BOOLEAN) is
			-- Initialize fields common to class and feature choice window.		
		do
			code_completable := an_editor
			before_complete := a_name
			remainder := a_remainder
			sorted_names := a_completion_possibilities
			user_completion := a_complete_word
			if before_complete /= Void then
				buffered_input := before_complete.twin
			else
				create buffered_input.make_empty
			end
			build_full_list
			is_closing := False
			build_displayed_list (before_complete)
			is_first_show := True

			if not full_list.is_empty then

					--| FIXME IEK This code shouldn't be needed as `select_closest_match'
					--| is called in show and result in a rebuilding of the list.
--				if choice_list.row_count > 0 then
--					select_closest_match
--				end
					-- If there is only one possibility, we insert it without displaying the window
				determine_show_needed
				if not show_needed then
					close_and_complete
				end
			end
		end

feature -- Access

	code_completable: CODE_COMPLETABLE
			-- associated code completable

	choice_list: EV_GRID
			-- list displaying possible feature signatures

	option_bar_box: EV_VERTICAL_BOX
			-- Option bar box

	option_bar: EV_TOOL_BAR
			-- Option tool bar

	filter_button: EV_TOOL_BAR_TOGGLE_BUTTON
			-- Filter option button.

	sorted_names: SORTABLE_ARRAY [like name_type]
			-- list of possible names sorted alphabetically

	before_complete: STRING
			-- Insertion string

	remainder: INTEGER
			-- Number chars to remove on completion

feature -- Status report

	show_needed: BOOLEAN
			-- Should the window be displayed ?

	user_completion: BOOLEAN
			-- Should single items in completion list be completed automatically?

	mouse_wheel_scroll_full_page: BOOLEAN is
		do
			Result := mouse_wheel_scroll_full_page_internal
		end

	mouse_wheel_scroll_size: INTEGER is
		do
			Result := mouse_wheel_scroll_size_internal
		end

	scrolling_common_line_count: INTEGER is
		do
			Result := scrolling_common_line_count_internal
		end

	continue_completion: BOOLEAN
			-- Indicates if completion will be reactived automatically when the completion list is closed.
			-- This is the result of a '.' being entered when completion is active.

feature -- Status Setting

	show is
			-- Show
		do
			check
				show_needed: show_needed
			end
			Precursor {EV_POPUP_WINDOW}
			choice_list.set_focus
			select_closest_match
			ev_application.do_once_on_idle (agent resize_column_to_window_width)
		end

feature -- Query

	has_match: BOOLEAN is
			-- Number of matches based on `a_name' using `buffered_input' value.
		do
			if rebuild_list_during_matching then
				Result := not matches_based_on_name (buffered_input).is_empty
			else
				Result := not full_list.is_empty
			end
		end

	default_font: EV_FONT is
			-- Default font
		once
			create Result
		end

	should_show: BOOLEAN is
			-- Should show in current state?
		do
			Result := choice_list.row_count > 0
		end

	is_applicable_item (a_item: like name_type): BOOLEAN
			-- Determines if `a_item' is an applicable item to show in the completion list
		do
			Result := a_item /= Void
		end

feature {NONE} -- Events handling

	mouse_selection (x_pos, y_pos, button: INTEGER; unused1,unused2,unused3: DOUBLE; unused4,unused5:INTEGER) is
			-- process mouse click in the list
		do
			if button = 1 and not choice_list.selected_items.is_empty then
				close_and_complete
			end
		end

	on_key_released (ev_key: EV_KEY) is
			-- process user input in `choice_list'
		do
			if ev_key /= Void then
				inspect
					ev_key.code
				when Key_enter then
					close_and_complete
				when Key_escape then
					exit
					code_completable.set_focus
				when key_back_space, key_delete then
					if ev_application.ctrl_pressed then
						code_completable.handle_extended_ctrled_key (ev_key)
					else
						code_completable.handle_extended_key (ev_key)
					end
					if not buffered_input.is_empty then
						if ev_key.code = key_back_space then
							if ev_application.ctrl_pressed then
								buffered_input.wipe_out
							else
								buffered_input := buffered_input.substring (1, buffered_input.count - 1)
							end
						end
					else
						exit
					end
					select_closest_match
				when key_v then
					if ev_application.ctrl_pressed then
						code_completable.handle_extended_ctrled_key (ev_key)
						buffered_input.append (ev_application.clipboard.text)
					else
						code_completable.handle_extended_key (ev_key)
					end
					select_closest_match
				else
					-- Do nothing
				end

			end
		end

	on_key_down (ev_key: EV_KEY) is
			-- process user input in `choice_list'	
		do
			if ev_key /= Void then
				inspect
					ev_key.code
				when key_left then
					collapse_current_item
				when key_right then
					expand_current_item
				when Key_up then
					go_to_last_visible_item
				when Key_down then
					go_to_next_visible_item
				when Key_page_up then
					page_up
				when Key_page_down then
					page_down
				when key_home then
					if choice_list.row_count > 0 then
						select_row (1)
					end
				when key_end then
					if choice_list.row_count > 0 then
						select_row (choice_list.row_count)
					end
				else
					if code_completable.is_completing then
						if code_completable.completion_activator_characters.has (ev_key.out.item (1)) then
								-- Continue completing
							continue_completion := True
							close_and_complete
							code_completable.handle_extended_key (ev_key)
							exit
						end
					end
				end
			end
		end

	on_char (character_string: STRING_32) is
   			-- Process displayable character key press event.
   		local
   			c: CHARACTER
			c_name: like name_type
   		do
			if character_string.count = 1 then
				c := character_string.item (1).to_character_8
				if not code_completable.unwanted_characters.item (c.code) then
					buffered_input.append_character (c)
					code_completable.handle_character (c)
					create c_name.make (buffered_input)
					select_closest_match
				else
					close_and_complete
					code_completable.handle_character (c)
					exit
				end
			end
		end

	on_lose_focus is
			-- close window
		do
			if (not (is_destroyed or else has_focus or else choice_list.has_focus)) and is_displayed then
				exit
			end
		end

	on_mouse_wheel (a: INTEGER) is
			-- Mouse wheel scrolled up or down
		local
			l_row: EV_GRID_ROW
		do
			if choice_list.virtual_height > choice_list.viewable_height then
				if mouse_wheel_scroll_full_page then
					l_row := choice_list.row ((choice_list.first_visible_row.index - a * viewable_row_count).max (1).min (choice_list.row_count))
					choice_list.set_virtual_position (choice_list.virtual_x_position,
						l_row.virtual_y_position.min (choice_list.maximum_virtual_y_position))
				else
					choice_list.set_virtual_position (
						choice_list.virtual_x_position,
						((choice_list.virtual_y_position + (choice_list.row_height * -a *
						mouse_wheel_scroll_size)).max (0)).min (choice_list.maximum_virtual_y_position))
				end
			end
		end

	on_row_expand (a_row: EV_GRID_ROW) is
			-- On row expand
		require
			a_row_not_void: a_row /= Void
		local
			l_name: NAME_FOR_COMPLETION
			l_children: SORTABLE_ARRAY [NAME_FOR_COMPLETION]
			i, upper: INTEGER
		do
			if a_row.subrow_count = 0 then
				l_name ?= a_row.data
				check
					l_name_not_void: l_name /= Void
					matches_not_void: matches /= Void
				end
				l_children := l_name.children
				from
					i := l_children.lower
					upper := l_children.upper
				until
					i > upper
				loop
					if matches.has (l_children.item (i)) then
						a_row.insert_subrow (a_row.subrow_count + 1)
						a_row.subrow (a_row.subrow_count).set_data (l_children.item (i))
					end
					i := i + 1
				end
			end
			ev_application.do_once_on_idle (agent resize_column_to_window_width)
		end

	on_row_collapse (a_row: EV_GRID_ROW) is
			-- On row collapse
		require
			a_row_not_void: a_row /= Void
		do
			ev_application.do_once_on_idle (agent resize_column_to_window_width)
		end

feature {NONE} -- Cursor movement

	page_up is
			-- Page up
		local
			l_selected_row: INTEGER
			i: INTEGER
			l_viewable_row_count: INTEGER
			l_count: INTEGER
			end_loop: BOOLEAN
			l_last_selectable: INTEGER
		do
			if choice_list.row_count > 0 then
				if not choice_list.selected_items.is_empty then
					lock_update
					l_selected_row := choice_list.selected_rows.first.index
					if not choice_list.visible_row_indexes.has (l_selected_row) then
						l_selected_row := choice_list.visible_row_indexes.first
					end
					l_viewable_row_count := viewable_row_count - scrolling_common_line_count
					l_last_selectable := l_selected_row
					from
						i := l_selected_row
					until
						i < 1 or end_loop
					loop
						if choice_list.row (i).parent_row /= Void implies choice_list.row (i).parent_row.is_expanded then
							l_count := l_count + 1
							l_last_selectable := i
						end
						if l_count > l_viewable_row_count then
							end_loop := True
						end
						i := i - 1
					end
					choice_list.remove_selection
					choice_list.row (l_last_selectable).enable_select
					choice_list.row (l_last_selectable).ensure_visible
					unlock_update
				end
			end
		end

	page_down is
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
			if choice_list.row_count > 0 then
				l_rows := choice_list.selected_rows
				if not l_rows.is_empty then
					lock_update
					l_selected_row := l_rows.first.index
					if not choice_list.visible_row_indexes.has (l_selected_row) then
						l_selected_row := choice_list.visible_row_indexes.last
					end
					l_viewable_row_count := viewable_row_count - scrolling_common_line_count
					l_last_selectable := l_selected_row
					from
						i := l_selected_row
					until
						i > choice_list.row_count or end_loop
					loop
						if choice_list.row (i).parent_row /= Void implies choice_list.row (i).parent_row.is_expanded then
							l_count := l_count + 1
							l_last_selectable := i
						end
						if l_count > l_viewable_row_count then
							end_loop := True
						end
						i := i + 1
					end
					choice_list.remove_selection
					choice_list.row (l_last_selectable).enable_select
					choice_list.row (l_last_selectable).ensure_visible
					unlock_update
				end
			end
		end

	go_to_last_visible_item is
			-- Go to last visible item.
		local
			i, ix: INTEGER
			l_row : EV_GRID_ROW
			l_loop_end: BOOLEAN
			l_list: like choice_list
			l_rows: ARRAYED_LIST [EV_GRID_ROW]
		do
			l_list := choice_list
			if l_list.row_count > 0 then
				l_rows := l_list.selected_rows
				if not l_rows.is_empty then
					ix := l_rows.first.index
					l_list.remove_selection
					from
						if ix = 1 then
							i := l_list.row_count
						else
							i := ix - 1
						end
					until
						l_loop_end
					loop
						l_row := l_list.row (i).parent_row
						if l_row = Void or else
							l_row.is_expanded
						then
							l_list.row (i).enable_select
							l_loop_end := True
						end
						i := i - 1
						if i < 1 then
							i := l_list.row_count
						end
					end
					l_rows := l_list.selected_rows
					if not l_rows.is_empty then
						l_rows.first.ensure_visible
					end
				end
			end
		end

	go_to_next_visible_item is
			-- Go to last visible item.
		local
			i, ix: INTEGER
			l_row : EV_GRID_ROW
			l_loop_end: BOOLEAN
			l_list: like choice_list
			l_rows: ARRAYED_LIST [EV_GRID_ROW]
		do
			l_list := choice_list
			if l_list.row_count > 0 then
				l_rows := l_list.selected_rows
				if not l_rows.is_empty then
					ix := l_rows.first.index
					l_list.remove_selection
					from
						if ix = l_list.row_count then
							i := 1
						else
							i := ix + 1
						end
					until
						l_loop_end
					loop
						l_row := l_list.row (i).parent_row
						if l_row = Void or else
							l_row.is_expanded
						then
							l_list.row (i).enable_select
							l_loop_end := True
						end
						i := i + 1
						if i > l_list.row_count then
							i := 1
						end
					end
					l_rows := l_list.selected_rows
					if not l_rows.is_empty then
						l_rows.first.ensure_visible
					end
				end
			end
		end

	expand_current_item is
			-- Expand current item.
		local
			ix: INTEGER
			l_row: EV_GRID_ROW
			l_list: like choice_list
			l_rows: ARRAYED_LIST [EV_GRID_ROW]
		do
			l_list := choice_list
			if l_list.row_count > 0 then
				l_rows := l_list.selected_rows
				if not l_rows.is_empty then
					ix := l_rows.first.index
					l_row := l_list.row (ix)
					if l_row.is_expandable then
						if not l_row.is_expanded then
							l_row.expand
						else
							if l_row.subrow_count > 0 then
								l_list.remove_selection
								l_row.subrow (1).enable_select
							end
						end
					end
					l_rows := l_list.selected_rows
					if not l_rows.is_empty then
						l_rows.first.ensure_visible
					end
				end
			end
		end

	collapse_current_item is
			-- Collapse current item.
			-- If parented, collapse parent.
		local
			ix: INTEGER
			l_row: EV_GRID_ROW
			l_list: like choice_list
			l_rows: ARRAYED_LIST [EV_GRID_ROW]
		do
			l_list := choice_list
			if l_list.row_count > 0 then
				l_rows := l_list.selected_rows
				if not l_rows.is_empty then
					ix := l_rows.first.index
					l_row := l_list.row (ix)
					if l_row.is_expandable and then l_row.is_expanded then
						l_row.collapse
					else
						l_row := l_row.parent_row
						if l_row /= Void and then l_row.is_expandable and then l_row.is_expanded then
							l_list.remove_selection
							l_row.enable_select
						end
					end
					l_rows := l_list.selected_rows
					if not l_rows.is_empty then
						l_rows.first.ensure_visible
					end
				end
			end
		end

	select_row (a_row: INTEGER) is
			-- Select row `i'
			-- If invisible, select its parent
		require
			a_row_is_valid: a_row > 0 and a_row <= choice_list.row_count
		local
			i: INTEGER
			l_row: EV_GRID_ROW
			l_list: like choice_list
			l_rows: ARRAYED_LIST [EV_GRID_ROW]
		do
			l_list := choice_list
			if l_list.row_count > 0 then
					-- Go to bottom
				l_list.remove_selection
				i := a_row
				l_row := l_list.row (i).parent_row
				if l_row = Void then
					l_list.row (i).enable_select
				else
					if not l_row.is_expanded then
						l_row.enable_select
					else
						l_list.row (i).enable_select
					end
				end
				l_rows := l_list.selected_rows
				if not l_rows.is_empty then
					l_rows.first.ensure_visible
				end
			end
		end

feature {NONE} -- Implementation

	buffered_input: STRING
			-- Buffered user input

	character_to_append: CHARACTER
			-- Character that should be appended after the completed feature in the editor.
			-- '%U' if none.

	index_offset: INTEGER
			-- Index in `full_list' of the first element in `choice_list'

	matches: SORTABLE_ARRAY [like name_type]
			-- Last matches

	rebuild_list_during_matching: BOOLEAN is
			-- Should the list be rebuilt according to current match?
		do
			Result := True
		end

	automatically_complete_words: BOOLEAN is
			-- Should completion list automatically complete words.
		do
			Result := True
		end

	build_displayed_list (name: STRING) is
			-- Build the list based on matches with `name'
		require
			full_list_not_void: full_list /= Void
			choice_list_attached: choice_list /= Void
		local
			l_count: INTEGER
			match_item, parent_item: like name_type
			row_index: INTEGER
			l_upper: INTEGER
			l_tree_view: BOOLEAN
			l_row: EV_GRID_ROW
			l_parents_inserted: HASH_TABLE [NAME_FOR_COMPLETION, NAME_FOR_COMPLETION]
			l_matches: like matches
			l_list: like choice_list
		do
			l_list := choice_list

			l_list.wipe_out
			if rebuild_list_during_matching then
				matches := matches_based_on_name (name)
			else
				matches := full_list.twin
			end
			l_matches := matches

			l_list.set_column_count_to (1)
			l_list.set_row_count_to (top_node_count_of (l_matches))
			create l_parents_inserted.make (l_matches.count)

			if l_matches.is_empty then
				current_index := 0
			else
				current_index := 1
			end
			from
				l_count := l_matches.lower
				l_upper := l_matches.upper
				row_index := 1
			until
				l_count > l_upper
			loop
				match_item := l_matches.item (l_count)
				if is_applicable_item (match_item) then
					parent_item := Void
					if match_item.has_parent then
						parent_item := match_item.parent
					else
						if not match_item.has_child then
							l_row := l_list.row (row_index)
							l_row.set_data (match_item)
							row_index := row_index + 1
						else
							parent_item := match_item
						end
					end
					if parent_item /= Void and then not l_parents_inserted.has (parent_item) then
						l_row := l_list.row (row_index)
						l_row.set_data (parent_item)
						row_index := row_index + 1
						if parent_item.has_child then
							if not l_tree_view then
								l_tree_view := True
								if not l_list.is_tree_enabled then
									l_list.enable_tree
								end
							end
							l_row.ensure_expandable
							l_row.expand_actions.extend (agent parent_item.set_is_expanded (True))
							l_row.expand_actions.extend (agent on_row_expand (l_row))
							l_row.collapse_actions.extend (agent parent_item.set_is_expanded (False))
							l_row.collapse_actions.extend (agent on_row_collapse (l_row))
							if parent_item.is_expanded and then l_row.is_expandable then
								l_row.expand
								row_index := row_index + l_row.subrow_count
							end
						end
						l_parents_inserted.force (parent_item, parent_item)
					end
				end
				l_count := l_count + 1
			end

				-- Shrink list in case not all items were applicable.
			l_list.set_row_count_to (row_index - 1)

				-- Enable/Disable tree view.
			if not l_tree_view then
				if l_list.is_tree_enabled then
					l_list.disable_tree
				end
			end
		end

	top_node_count_of (a_names: SORTABLE_ARRAY [like name_type]): INTEGER is
			-- Count of node with no parent
		require
			a_names_not_void: a_names /= Void
		local
			i, l_upper: INTEGER
			l_name: NAME_FOR_COMPLETION
			l_parents_inserted: ARRAYED_LIST [NAME_FOR_COMPLETION]
		do
			create l_parents_inserted.make (a_names.count)
			from
				i := a_names.lower
				l_upper := a_names.upper
			until
				i > l_upper
			loop
				l_name := a_names.item (i)
				if l_name.has_parent then
					l_name := l_name.parent
				end
				if not l_parents_inserted.has (l_name) then
					Result := Result + 1
					l_parents_inserted.extend (l_name)
				end
				i := i + 1
			end
		end

	build_full_list is
			-- Build full list including children nodes.
		local
			i: INTEGER
			l_upper: INTEGER
			start_pos: INTEGER
			l_name: like name_type
			l_names: like sorted_names
			l_list: like full_list
		do
			l_list := full_list
			l_names := sorted_names
			if not has_child_node then
				full_list := l_names
			else
				create l_list.make (1, calculate_full_count)
				start_pos := 1
				from
					i := l_names.lower
					l_upper := l_names.upper
				until
					i > l_upper
				loop
					l_name := l_names.item (i)
					start_pos := collect_names (l_name, l_list, start_pos)
					i := i + 1
				end
				l_list.sort
				full_list := l_list
			end
		ensure
			full_list_not_void: full_list /= Void
		end

	full_list: like sorted_names
			-- Sorted full list of name.

	has_child_node: BOOLEAN is
			-- Any child node?
		local
			i: INTEGER
			l_upper: INTEGER
			l_name: like name_type
		do
			from
				i := sorted_names.lower
				l_upper := sorted_names.upper
			until
				i > l_upper or Result
			loop
				l_name := sorted_names.item (i)
				Result := l_name.has_child
				i := i + 1
			end
		end

	calculate_full_count: INTEGER is
			-- Calculate total number of names including children.
		local
			i: INTEGER
			l_upper: INTEGER
			l_name: like name_type
		do
			from
				i := sorted_names.lower
				l_upper := sorted_names.upper
			until
				i > l_upper
			loop
				l_name := sorted_names.item (i)
				Result := Result + flat_count_of_name (l_name)
				i := i + 1
			end
		end

	flat_count_of_name (a_name: like name_type): INTEGER is
			-- Number of flat count of `a_name', including itself and its children.
		require
			a_name_not_void: a_name /= Void
		local
			i: INTEGER
			l_upper: INTEGER
		do
			Result := 1
			if a_name.has_child then
				from
					i := a_name.children.lower
					l_upper := a_name.children.upper
				until
					i > l_upper
				loop
					Result := Result + flat_count_of_name (a_name.children.item (i))
					i := i + 1
				end
			end
		end

	collect_names (a_name: like name_type; a_list: like full_list; a_start_pos: INTEGER): INTEGER is
			-- Collect all nodes of `a_name', including itself and its children.
		require
			a_name_not_void: a_name /= Void
			a_list_not_void: a_list /= Void
			a_start_pos_valid: a_start_pos <= a_list.upper and then a_start_pos >= a_list.lower
		local
			l_count: INTEGER
			i: INTEGER
			l_upper: INTEGER
		do
			l_count := a_start_pos
			a_list.put (a_name, l_count)
			l_count := l_count + 1
			if a_name.has_child then
				from
					i := a_name.children.lower
					l_upper := a_name.children.upper
				until
					i > l_upper
				loop
					l_count := collect_names (a_name.children.item (i), a_list, l_count)
					i := i + 1
				end
			end
			Result := l_count
		end

	close_and_complete is
			-- close the window and perform completion with selected item
		do
			if not choice_list.selected_rows.is_empty then
					-- Delete current token so it is later replaced by the completion text
				if not buffered_input.is_empty then
					remove_characters_entered_since_display
				end
				complete
			end
			exit
		end

	complete is
			-- Complete current name
		local
			l_name: STRING_GENERAL
			l_name_item: like name_type
			l_list: like choice_list
			l_rows: ARRAYED_LIST [EV_GRID_ROW]
		do
			continue_completion := False
			l_list := choice_list
			l_rows := l_list.selected_rows
			if not l_rows.is_empty then
				if character_to_append = '(' then
					character_to_append := '%U'
				end
				l_name_item ?= l_rows.first.data
				check
					l_name_item_not_void: l_name_item /= Void
				end
				if ev_application.alt_pressed then
					l_name := l_name_item.full_insert_name
				else
					l_name := l_name_item.insert_name
				end
				code_completable.complete_from_window (l_name, character_to_append, remainder)
			end
		end

	exit is
			-- Cancel autocomplete
		do
			if not is_closing then
				is_closing := True
				show_needed := False
				if has_capture then
					disable_capture
				end
				save_window_position
				hide
				code_completable.resume_focus_out_actions
			end
			exit_complete_mode
			code_completable.block_focus_in_actions
			if code_completable.is_focus_back_needed then
				code_completable.set_focus
			end
			code_completable.resume_focus_in_actions
		end

	exit_complete_mode is
			-- Exit editor complete mode.
		do
			code_completable.exit_complete_mode
			continue_completion := False
		end

	save_window_position is
			-- Save current window position.
		do
			if code_completable.save_list_position_action /= Void and is_displayed then
				code_completable.save_list_position_action.call ([screen_x, screen_y, width, height])
			end
		end

	is_closing: BOOLEAN
			-- Is the window being closed?

	current_meta_keys: ARRAY [BOOLEAN] is
		do
			Result := <<ev_application.ctrl_pressed, ev_application.alt_pressed, ev_application.shift_pressed>>
		end

	activate_tooltip is
			-- Activate selected item tooltip in list
		do
--			choice_list.selected_items.first. selected_item.pointer_motion_actions.call ([1,1,1.0,1.0,1.0,1,1])
		end

	remove_characters_entered_since_display is
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
				code_completable.back_delete_char
				l_index := l_index + 1
			end
		end

	resize_column_to_window_width is
			-- Resize the column width to the width of the window
		local
			i: INTEGER
			l_select_row_visible: BOOLEAN
			l_list: like choice_list
			l_rows: ARRAYED_LIST [EV_GRID_ROW]
		do
			l_list := choice_list
			if l_list.column_count > 0 and then l_list.row_count > 0 then
				l_rows := l_list.selected_rows
				if l_list.is_displayed and then not l_rows.is_empty then
					l_select_row_visible := l_list.visible_row_indexes.has (l_rows.first.index)
				end
				i := l_list.column (1).required_width_of_item_span (1, l_list.row_count) + 3
				i := i.max (l_list.width)
				if l_list.vertical_scroll_bar.is_displayed then
					if i < l_list.width - l_list.vertical_scroll_bar.width then
						l_list.column (1).set_width (l_list.width - l_list.vertical_scroll_bar.width)
					else
						l_list.column (1).set_width (i)
					end
				else
					if i < l_list.width then
						l_list.column (1).set_width (l_list.width)
					else
						l_list.column (1).set_width (i)
					end
				end
				if l_select_row_visible then
					l_rows.first.ensure_visible
				end
			end
		end

	on_scroll (x, y: INTEGER) is
			-- On vertical bar scroll
		do
			ev_application.do_once_on_idle (agent resize_column_to_window_width)
		end

	is_first_show: BOOLEAN

	determine_show_needed is
			-- Determins if completion window needs to be show to user.
			-- `show_needed' is set as a result of calling this routine.
		require
			before_complete_not_void: before_complete /= Void
		local
			l_matches: INTEGER
			l_list: like choice_list
		do
				-- Show if completion is performed on no text (completing after the period '.')
			if rebuild_list_during_matching then
				l_list := choice_list

					-- Show if there are mulitple items left to show
				if l_list.row_count = 0 then
						-- There are no items to choose from
					if before_complete.is_empty then
							-- There are no possible items given that there is no completion term.
						show_needed := False
					else
							-- There are no choices visible, but there are some available. The user
							-- can delete a character or two to view refiltered list.
						show_needed := not full_list.is_empty
					end
				else
					if user_completion then
							-- User completed without a completion term so only show completion
							-- list if there are mulitple items available
						if automatically_complete_words then
							if l_list.row_count = 1 then
								if l_list.row (1).is_expandable and then l_list.row (1).subrow_count > 1 then
									show_needed := True
								else
									show_needed := False
								end
							elseif l_list.row_count = 2 then
								if l_list.row (1).is_expandable and then l_list.row (2).is_selected then
									show_needed := False
								else
									show_needed := True
								end
							else
								show_needed := True
							end
						else
							show_needed := True
						end
					else
							-- Completion list is being shown automatically
--						check
--							non_completion_term: before_complete.is_empty
--						end
						show_needed := True
					end
				end
			else
				l_matches := matches_based_on_name (before_complete).count

				if l_matches = 0 then
						-- Only show if the completion term is empty
					show_needed := not before_complete.is_empty
				elseif l_matches = 1 and automatically_complete_words then
						-- If there is only one item in completion list and user completed
						-- then there is no need to show list.
					show_needed := not user_completion
				else
						-- Mulitple items are avialable so show completion list
					show_needed := True
				end
			end
		end

	set_expanded_row_icon (a_item: EV_GRID_ITEM; a_name: like name_type) is
			-- Set pixmap of `a_item'.
		require
			a_item_not_void: a_item /= Void
			a_name_not_void: a_name /= Void
		local
			l_item: EV_GRID_LABEL_ITEM
		do
			l_item ?= a_item
			check
				l_item_not_void: l_item /= Void
			end
			l_item.set_pixmap (a_name.icon)
		end

	name_type: NAME_FOR_COMPLETION

	mouse_wheel_scroll_full_page_internal: BOOLEAN is False

	mouse_wheel_scroll_size_internal: INTEGER is 3

	scrolling_common_line_count_internal: INTEGER is 1

feature {NONE} -- String matching

	pos_of_first (table: like full_list): INTEGER is
		require
			table_not_void: table /= Void
		local
			i, upper: INTEGER
			end_loop: BOOLEAN
		do
			from
				i := table.lower
				upper := table.upper
			until
				i > upper or end_loop
			loop
				if table.item (i).begins_with (buffered_input) then
					end_loop := True
					Result := i
				end
				i := i + 1
			end
		end

	pos_of_first_greater (table: like full_list; a_name: like name_type): INTEGER is
		local
			low, up, mid: INTEGER
		do
			if table.item (table.lower) >= a_name then
				Result := table.lower
			elseif table.item (table.upper) <= a_name then
				Result := table.upper
			else
				from
					low := table.lower
					up := table.upper
					mid := low
				until
					up - low <= 1
				loop
					mid := (up + low) // 2
					if table.item (mid) >= a_name then
						up := mid
					else
						low := mid
					end
				end
				Result := up
			end
		ensure
			table.item (table.lower) >= a_name
				or else
			table.item (table.upper) <= a_name
				or else
			(table.item (Result - 1) < a_name and
				table.item (Result) >= a_name)
		end

	current_index: INTEGER
			-- Index of selected item in `choice_list' (if any)

	select_closest_match is
			-- Select the closest match in the list
		do
			if not is_first_show then
				if rebuild_list_during_matching then
					build_displayed_list (buffered_input)
					resize_column_to_window_width
				end
			end
			ensure_item_selection
			is_first_show := False
		end

	ensure_item_selection is
			-- Ensure item seletion in the list.
		local
			l_row: EV_GRID_ROW
			l_name, l_name_for_comparison: like name_type
			l_index: INTEGER
			l_list: like choice_list
			l_full_list: like full_list
			l_rows: ARRAYED_LIST [EV_GRID_ROW]
		do
			l_list := choice_list
			if rebuild_list_during_matching then
				current_index := 1
				if l_list.row_count > 0 then
					l_row := l_list.row (1)
					l_name ?= l_row.data
					check
						--l_name_not_void: l_name /= Void
					end
					if l_name /= Void and then l_name.has_child then
						on_row_expand (l_row)
						if not l_name.begins_with (buffered_input) then
							l_row.expand
							current_index := 2
						end
					end
				end
			else
				if not buffered_input.is_empty then
					l_full_list := full_list
					create l_name_for_comparison.make (buffered_input)
					if l_name_for_comparison.is_binary_searchable then
							-- Faster way getting to the position if binary search is appliable.
						current_index := pos_of_first_greater (l_full_list, l_name_for_comparison)
					else
						current_index := pos_of_first (l_full_list)
							-- If we don't find the first match, we do binary search to find the closest one.
							-- Wild card is discarded in this case.
						if current_index = 0 then
							current_index := pos_of_first_greater (l_full_list, l_name_for_comparison)
						end
					end
					if current_index >= l_full_list.lower and current_index <= l_full_list.upper then
						l_name := l_full_list.item (current_index)
						if l_name.has_parent then
							l_index := grid_row_by_data (l_name.parent)
							check
								l_index_valid: l_index > 0
							end
							l_row := l_list.row (l_index)
							l_row.expand
						end
						current_index := grid_row_by_data (l_name)
					end
				end
				if current_index <= 0 then
					current_index := 1
				end
			end

			if l_list.row_count > 0 then
				l_list.remove_selection
					-- It is possible that there are some rows have been filtered (i.e. oboselete features)
					-- The row count of the list is actually greater than the number of rows we created.
				l_name ?= l_list.row (current_index).data
				if l_name /= Void then
					l_list.row (current_index).enable_select
				end
				if is_displayed then
					l_rows := l_list.selected_rows
					if not l_rows.is_empty then
						l_row := l_rows.first
						l_row.ensure_visible
					end
				end
			end
		end

	matches_based_on_name (a_name: STRING): SORTABLE_ARRAY [like name_type] is
			-- Array of matches based on `a_name'.
			-- Always use this function before building lists to get correct matches.
		require
			full_list_not_void: full_list /= Void
		local
			cnt: INTEGER
			l_upper: INTEGER
			i: INTEGER
			l_full_list: like full_list
			l_item: NAME_FOR_COMPLETION
			for_search: like name_type
			l_index_offset: INTEGER
		do
			create for_search.make (a_name)
			l_full_list := full_list
			if a_name /= Void and then not a_name.is_empty then
				if for_search.is_binary_searchable then
					create Result.make (2, 1)
					from
						create for_search.make (a_name)
						l_index_offset := pos_of_first_greater (l_full_list, for_search) - 1
					until
						l_full_list.upper < (l_index_offset + cnt + 1) or else not l_full_list.item (l_index_offset + cnt + 1).begins_with (a_name)
					loop
						cnt := cnt + 1
					end
					if cnt > 0 then
						Result := l_full_list.subarray (l_index_offset + 1, l_index_offset + cnt)
					end
					index_offset := l_index_offset
				else
					create Result.make (1, 20)
					from
						i := l_full_list.lower
						l_upper := l_full_list.upper
					until
						i > l_upper
					loop
						l_item := l_full_list[i]
						if l_item.begins_with (a_name) then
							cnt := cnt + 1
							if cnt = 1 then
								index_offset := i
							end
							if cnt > Result.upper then
								Result.conservative_resize (1, Result.upper * 2)
							end
							Result.put (l_item, cnt)
						end
						i := i + 1
					end
					if cnt = 0 then
						create Result.make (2, 1)
					else
						Result := Result.subarray (1, cnt)
					end
				end
			else
					-- Matches are just all matches
				Result := l_full_list.twin
				index_offset := 0
			end
		ensure
			has_result: Result /= Void
		end

	viewable_row_count: INTEGER is
			-- Number of items that will be scrolled when doing a page up or down operation.
		local
			l_list: like choice_list
		do
			l_list := choice_list
			Result := l_list.viewable_height // l_list.row_height
		end

	grid_row_by_data (a_data: ANY) : INTEGER is
			-- Find a row in a_grid that include a_data
		local
			i: INTEGER
			l_row: EV_GRID_ROW
			loop_end: BOOLEAN
			l_list: like choice_list
		do
			l_list := choice_list
			loop_end := false
			from
				i := 1
			until
				i > l_list.row_count or loop_end
			loop
				l_row := l_list.row (i)
				if l_row.data /= Void and then l_row.data = a_data then
					Result := i
					loop_end := true
				end
				i := i + 1
			end
		end

	on_item_display (a_column, a_row: INTEGER): EV_GRID_ITEM is
			-- On item expose.
		local
			l_row: EV_GRID_ROW
			l_name: NAME_FOR_COMPLETION
		do
			l_row := choice_list.row (a_row)
			l_name ?= l_row.data
			if l_name /= Void then
				Result := l_name.grid_item
			end
		end

invariant
	choice_list_attached: choice_list /= Void

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
