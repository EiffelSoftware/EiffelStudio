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
			choice_list.enable_single_row_selection
			choice_list.key_press_string_actions.extend (agent on_char)
			choice_list.key_press_actions.extend (agent on_key_down)
			choice_list.key_release_actions.extend (agent on_key_released)
			choice_list.pointer_double_press_actions.extend (agent mouse_selection)
			choice_list.hide_header
			choice_list.disable_selection_key_handling

			default_create
			create vbox
			vbox.extend (choice_list)
			extend (vbox)
			choice_list.focus_out_actions.extend (agent on_lose_focus)
			choice_list.mouse_wheel_actions.extend (agent on_mouse_wheel)
			focus_out_actions.extend (agent on_lose_focus)
			resize_actions.force_extend (agent resize_column_to_window_width)
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
			sorted_names.compare_objects
			is_closing := False

			build_displayed_list (before_complete)
			is_first_show := True

			if not sorted_names.is_empty then
					-- If there is only one possibility, we insert it without displaying the window
				determine_show_needed
				if not show_needed then
					if choice_list.row_count > 0 then
						select_closest_match
					end
					close_and_complete
				end
			end
		end

feature -- Access

	code_completable: CODE_COMPLETABLE
			-- associated code completable

	choice_list: EV_GRID
			-- list displaying possible feature signatures

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

feature -- Status Setting

	show is
			-- Show
		do
			check
				show_needed: show_needed
			end
			enable_user_resize
			Precursor {EV_POPUP_WINDOW}
			choice_list.set_focus
			resize_column_to_window_width
			select_closest_match
		end

feature -- Query

	has_match: BOOLEAN is
			-- Number of matches based on `a_name' using `buffered_input' value.
		do
			if rebuild_list_during_matching then
				Result := not matches_based_on_name (buffered_input).is_empty
			else
				Result := not sorted_names.is_empty
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
		local
			ix: INTEGER
		do
			if ev_key /= Void then
				inspect
					ev_key.code
				when Key_page_up then
						-- Go up `nb_items_to_scroll' items
					if choice_list.row_count > 0 then
						if not choice_list.selected_items.is_empty then
							ix:= choice_list.selected_rows.first.index
							if ix <= nb_items_to_scroll then
								if ix = 1 then
									choice_list.remove_selection
									choice_list.row (choice_list.row_count).enable_select
								else
									choice_list.remove_selection
									choice_list.row (1).enable_select
								end
							else
								choice_list.remove_selection
								choice_list.row (ix - nb_items_to_scroll).enable_select
							end
						end

						if not choice_list.selected_rows.is_empty then
							choice_list.selected_rows.first.ensure_visible
						end
					end
				when Key_page_down then
						-- Go down `nb_items_to_scroll' items
					if choice_list.row_count > 0 then
						if not choice_list.selected_items.is_empty then
							ix:= choice_list.selected_rows.first.index
							if ix > choice_list.row_count - nb_items_to_scroll then
								if ix = choice_list.row_count then
									choice_list.remove_selection
									choice_list.row (1).enable_select
								else
									choice_list.remove_selection
									choice_list.row (choice_list.row_count).enable_select
									choice_list.row (choice_list.row_count).ensure_visible
								end
							else
								choice_list.remove_selection
								choice_list.row (ix + nb_items_to_scroll).enable_select
								choice_list.row (ix + nb_items_to_scroll).ensure_visible
							end
						end
						if not choice_list.selected_rows.is_empty then
							choice_list.selected_rows.first.ensure_visible
						end
					end
				when Key_up then
					if choice_list.row_count > 0 then
						if not choice_list.selected_items.is_empty then
							ix := choice_list.selected_rows.first.index
							choice_list.remove_selection
							if ix = 1 then
								choice_list.row (choice_list.row_count).enable_select
							else
								choice_list.row (ix - 1).enable_select
							end
						end
						if not choice_list.selected_rows.is_empty then
							choice_list.selected_rows.first.ensure_visible
						end
					end
				when Key_down then
					if choice_list.row_count > 0 then
						if not choice_list.selected_items.is_empty then
							ix := choice_list.selected_rows.first.index
							choice_list.remove_selection
							if ix = choice_list.row_count then
								choice_list.row (1).enable_select
							else
								choice_list.row (ix + 1).enable_select
							end
						end
						if not choice_list.selected_rows.is_empty then
							choice_list.selected_rows.first.ensure_visible
						end
					end
				when key_home then
					if ev_application.ctrl_pressed and then choice_list.row_count > 0 then
							-- Go to top
						choice_list.remove_selection
						choice_list.select_row (1)
						if not choice_list.selected_rows.is_empty then
							choice_list.selected_rows.first.ensure_visible
						end
					end
				when key_end then
					if ev_application.ctrl_pressed and then choice_list.row_count > 0 then
							-- Go to bottom
						choice_list.remove_selection
						choice_list.select_row (choice_list.row_count)
						if not choice_list.selected_rows.is_empty then
							choice_list.selected_rows.first.ensure_visible
						end
					end
				else
					-- Do nothing
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
				if c.is_alpha or c.is_digit or c = '_' then
					buffered_input.append_character (c)
					code_completable.handle_character (c)
					create c_name.make (buffered_input)
					select_closest_match
				elseif c = ' ' and ev_application.ctrl_pressed then
						-- Do nothing, we don't want to close the completion window when CTRL+SPACE is pressed
				elseif not code_completable.unwanted_characters.item (c.code) then
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
					l_row := choice_list.row ((choice_list.first_visible_row.index - a * nb_items_to_scroll).max (1).min (choice_list.row_count))
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

feature {NONE} -- Implementation

	buffered_input: STRING
			-- Buffered user input

	character_to_append: CHARACTER
			-- Character that should be appended after the completed feature in the editor.
			-- '%U' if none.

	index_offset: INTEGER
			-- Index in `sorted_names' of the first element in `choice_list'

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

	index_to_complete: INTEGER is
			-- Index in `sorted_names'
		require
			select_rows_in_choice_list_not_empty: not choice_list.selected_rows.is_empty
		do
			if rebuild_list_during_matching then
				if not choice_list.selected_rows.is_empty then
					Result := choice_list.selected_rows.first.index + index_offset
				else
					Result := index_offset
				end
			else
				if not choice_list.selected_rows.is_empty then
					Result := choice_list.selected_rows.first.index
				else
					Result := index_offset
				end
			end
		end

	build_displayed_list (name: STRING) is
			-- Build the list based on matches with `name'
		require
			sorted_names_not_void: sorted_names /= Void
		local
			l_count: INTEGER
			matches: ARRAY [like name_type]
			list_row: EV_GRID_LABEL_ITEM
			match_item: like name_type
			row_index: INTEGER
			l_upper: INTEGER
		do
			choice_list.wipe_out

			if rebuild_list_during_matching then
				matches := matches_based_on_name (name)
			else
				matches := sorted_names.subarray (1, sorted_names.count)
			end


			if matches.is_empty then
				current_index := 0
			else
				current_index := 1
			end
			from
				l_count := matches.lower
				l_upper := matches.upper
				row_index := 1
			until
				l_count > l_upper
			loop
				match_item := matches.item (l_count)
				if match_item /= Void then
					create list_row.make_with_text (match_item.out)
					list_row.set_pixmap (match_item.icon)
					list_row.set_tooltip (match_item.tooltip_text)
							-- TODO: neilc.  auto activating the tooltip works but only based on mouse x/y,
							-- whereas we need selected_item x/y.
						--list_row.select_actions.extend (agent activate_tooltip)								
					choice_list.set_item (1, row_index, list_row)
				end
				l_count := l_count + 1
				row_index := row_index + 1
			end
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
			code_completable.block_focus_in_actions
			code_completable.set_focus
			code_completable.resume_focus_in_actions
		end

	complete is
			-- Complete current name
		local
			ix: INTEGER
		do
			if not choice_list.selected_rows.is_empty then
				if character_to_append = '(' then
					character_to_append := '%U'
				end
				ix := index_to_complete
				code_completable.complete_from_window (sorted_names.item (ix).full_insert_name, character_to_append, remainder)
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
		end

	exit_complete_mode is
			-- Exit editor complete mode.
		do
			code_completable.exit_complete_mode
		end

	save_window_position is
			-- Save current window position.
		do
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
			l_sb_wid: INTEGER
			i: INTEGER
		do
			if choice_list.column_count > 0 then
				l_sb_wid := choice_list.width - choice_list.viewable_width
				i := choice_list.column (1).required_width_of_item_span (1, choice_list.row_count) + 3
				i := i.max (choice_list.viewable_width.max (choice_list.width - l_sb_wid))
				choice_list.column (1).set_width (i)
			end
		end

	is_first_show: BOOLEAN

	determine_show_needed is
			-- Determins if completion window needs to be show to user.
			-- `show_needed' is set as a result of calling this routine.
		require
			before_complete_not_void: before_complete /= Void
			choice_list_not_void: choice_list /= Void
		local
			l_matches: INTEGER
		do
				-- Show if completion is performed on no text (completing after the period '.')
			if rebuild_list_during_matching then
					-- Show if there are mulitple items left to show
				if choice_list.row_count = 0 then
						-- There are no items to choose from
					if before_complete.is_empty then
							-- There are no possible items given that there is no completion term.
						show_needed := False
					else
							-- There are no choices visible, but there are some available. The user
							-- can delete a character or two to view refiltered list.
						show_needed := not sorted_names.is_empty
					end
				else
					if user_completion then
							-- User completed without a completion term so only show completion
							-- list if there are mulitple items available
						if automatically_complete_words then
							show_needed := choice_list.row_count > 1
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

	name_type: NAME_FOR_COMPLETION

	mouse_wheel_scroll_full_page_internal: BOOLEAN is False

	mouse_wheel_scroll_size_internal: INTEGER is 3

	scrolling_common_line_count_internal: INTEGER is 1

feature {NONE} -- String matching

	pos_of_first_greater (table: like sorted_names; a_name: like name_type): INTEGER is
			--
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
			(	table.item (Result - 1) < a_name and
				table.item (Result) >= a_name)
		end

	current_index: INTEGER
			-- Index of selected item in `choice_list' (if any)

	index_of_closest_match: INTEGER is
			-- The index of the closest name match to `buffered_input' in `sorted_names'.  If there is no part or full
			-- match return -1.
		local
			l_input: like buffered_input
			l_input_count: INTEGER
			l_names: like sorted_names
			l_names_count: INTEGER
			l_item: STRING
			l_match_index: INTEGER
			l_last_match: INTEGER
			l_stop: BOOLEAN
			c: CHARACTER
			i: INTEGER
		do
			if not buffered_input.is_empty then
				l_input := buffered_input.as_lower
				l_input_count := l_input.count
				l_names := sorted_names
				l_names_count := l_names.count
				c := l_input.item (1)
				from
					i := 1
				until
					i > l_names_count or l_stop
				loop
					l_item := (l_names.item (i)).name

					l_match_index := match_names_until_done (l_item, l_input)
					if l_match_index = l_input_count then
							-- Exact match
						Result := i
						l_stop := True
					elseif l_match_index > l_last_match then
							-- Better match than last
						l_last_match := l_match_index
						Result := i
					elseif Result = 0 then
							-- There have been no matches yet.
						if l_item.item (1) > c then
								-- The first character of the current item is greater that the requested match
								-- so we can stop here.
							Result := i
							l_stop := True
						elseif i = l_names_count then
								-- No match found and we are at the end
							Result := i
						end
					elseif i > 1 and l_match_index = l_last_match and l_match_index < l_input_count then
							-- This match was the same as the last
						if l_item.item (l_match_index + 1) > l_input.item (l_match_index + 1) then
							l_item := (l_names.item (i - 1)).name
							if l_item.item (l_match_index + 1) < l_input.item (l_match_index + 1) then
									-- Ensures `deep_twin' is chosen over `deep_equals' if l_input is `deep_f'
									-- and ensures `deep_copy' is *NOT* chosen over `deep_clone' when l_input is `deef'
								l_last_match := l_last_match + 1
								Result := i
							end
						end
					end

					i := i + 1
				end
			else
				Result := 0
			end
			if Result > l_names_count then
				Result := l_names_count
			end
		ensure
			result_greater_than_zero: Result >= 0
			result_too_big: Result <= sorted_names.count
		end

	select_closest_match is
			-- Select the closest match in the list
		do
			if not is_first_show then
				if rebuild_list_during_matching then
					build_displayed_list (buffered_input)
					resize_column_to_window_width
				end
			end

			if rebuild_list_during_matching then
				current_index := 1
			else
				current_index := index_of_closest_match
				if current_index <= 0 then
					current_index := 1
				end
			end

			if choice_list.row_count > 0 then
				choice_list.remove_selection
				choice_list.row (current_index).enable_select
				if is_displayed then
					choice_list.selected_rows.first.ensure_visible
				end
			end
			is_first_show := False
		end

	match_names_until_done (a_name, a_name2: STRING): INTEGER is
			-- Match the characters of `a_name2' against `a_name' from the start of `a_name2' until no match is
			-- found or all characters match.  Return the index where the match failed.
		require
			a_name_not_void: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			a_name2_not_void: a_name2 /= Void
			not_a_name2_is_empty: not a_name2.is_empty
			a_name2_formatted: a_name2.as_lower.is_equal (a_name2)
		local
			i: INTEGER
			cnt: INTEGER
			done: BOOLEAN
			c: CHARACTER
			l_count: INTEGER
		do
			from
				i := 0
				cnt := a_name.count
				l_count := a_name2.count
			until
				i = cnt or done
			loop
				c := a_name.item (i + 1).as_lower
				if (i + 1) > l_count or c /= a_name2.item (i + 1) then
					done := True
				else
					i := i + 1
				end
			end
			Result := i
		ensure
			index_returned_makes_sense: Result >= 0
		end

	matches_based_on_name (a_name: STRING): ARRAY [like name_type] is
			-- Array of matches based on `a_name'.  Always use this function before building lists to get correct matches.
		require
			sorted_names_not_void: sorted_names /= Void
		local
			cnt: INTEGER
			for_search: like name_type
			l_index_offset: INTEGER
		do
			create Result.make (2, 1)
			if a_name /= Void and then not a_name.is_empty then
					-- Matches are filtered according to `buffered_input'
				from
					create for_search.make (a_name)
					l_index_offset := pos_of_first_greater (sorted_names, for_search) - 1
				until
					sorted_names.upper < (l_index_offset + cnt + 1) or else not sorted_names.item (l_index_offset + cnt + 1).begins_with (a_name)
				loop
					cnt := cnt + 1
				end
				if cnt > 0 then
					Result := sorted_names.subarray (l_index_offset + 1, l_index_offset + cnt)
				end
				index_offset := l_index_offset
			else
					-- Matches are just all matches
				Result := sorted_names.subarray (1, sorted_names.count)
				index_offset := 0
			end
		ensure
			has_result: Result /= Void
		end

	nb_items_to_scroll: INTEGER is
			-- Number of items that will be scrolled when doing a page up or down operation.
		require
			choice_list_not_void: choice_list /= Void
		do
			if choice_list.viewable_height > choice_list.row_count * choice_list.row_height then
					-- In this situation, all of the rows are displayed in the grid so we wish to scroll
					-- by the number of rows (less one as one is already be selected).
				Result := choice_list.row_count - 1
			else
					-- Calculate the number of rows to scroll based on `scrolling_common_line_count' preference.
				Result := choice_list.last_visible_row.index - choice_list.first_visible_row.index - scrolling_common_line_count
			end
		end

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
