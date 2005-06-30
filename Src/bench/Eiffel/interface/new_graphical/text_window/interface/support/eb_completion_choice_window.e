indexing
	description: "Window that displays a text area and a list of possible features for automatic completion"
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_COMPLETION_CHOICE_WINDOW

inherit
	EV_WINDOW
		redefine
			show
		end

	EV_KEY_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end
	
	EB_CONSTANTS
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
		
	EB_SHARED_PREFERENCES
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

			make_with_title (Interface_names.t_Autocomplete_window)
			create vbox
			vbox.extend (choice_list)
			extend (vbox)
			enable_user_resize
			choice_list.focus_out_actions.extend (agent on_lose_focus)
			choice_list.mouse_wheel_actions.extend (agent on_mouse_wheel)
			focus_out_actions.extend (agent on_lose_focus)			
			resize_actions.force_extend (agent resize_column_to_window_width)
		end		

feature -- Initialization

	initialize_for_features (an_editor: EB_SMART_EDITOR; feature_name: STRING; a_remainder: INTEGER; completion_possibilities: SORTABLE_ARRAY [EB_NAME_FOR_COMPLETION]) is
			-- Initialize to to complete for `feature_name' in `an_editor'.
		do
			feature_mode := True
			editor := an_editor
			before_complete := feature_name
			before_complete.prune_all_leading (' ')
			before_complete.prune_all_leading ('	')
			sorted_names := completion_possibilities
			remainder := a_remainder
			common_initialization
		end

	initialize_for_classes (an_editor: EB_SMART_EDITOR; class_name: STRING; a_remainder: INTEGER; completion_possibilities: SORTABLE_ARRAY [EB_NAME_FOR_COMPLETION]) is
			-- Initialize to to complete for `class_name' in `an_editor'.
		do
			feature_mode := False
			editor := an_editor
			before_complete := class_name
			sorted_names := completion_possibilities
			remainder := a_remainder
			common_initialization
		end

	common_initialization is
			-- Initialize fields common to class and feature choice window.		
		do
			if before_complete /= Void then
				buffered_input := before_complete.twin	
			else
				create buffered_input.make_empty
			end			
			sorted_names.compare_objects
			index_offset := 0
			is_closing := False
			
			build_displayed_list (before_complete)
			is_first_show := True

			if not choice_list.is_empty then
					-- If there is only one possibility, we insert it without displaying the window
				show_needed := choice_list.row_count > 1
				if not show_needed then
					if choice_list.row_count > 0 then							
						choice_list.select_row (1)	
					end
					close_and_complete					
				end
			end
		end

feature -- Access

	editor: EB_SMART_EDITOR
			-- associated window

	choice_list: EV_GRID
			-- list displaying possible feature signatures

	sorted_names: SORTABLE_ARRAY [EB_NAME_FOR_COMPLETION]
			-- list of possible feature names sorted alphabetically

	before_complete: STRING
			-- Insertion string

	remainder: INTEGER
			-- Number chars to remove on completeion

feature -- Status report

	show_needed: BOOLEAN
			-- Should the window be displayed ?

	feature_mode: BOOLEAN
			-- Is `Current' used to select feature names ?

feature -- Status Setting

	show is
			-- Show
		do
			check
				should_show: should_show
			end
			Precursor {EV_WINDOW}
			choice_list.set_focus
			select_closest_match
			resize_column_to_window_width
		end		

feature -- Query

	has_match: BOOLEAN is
			-- Number of matches based on `a_name' using `buffered_input' value.
		do
			Result := not matches_based_on_name (buffered_input).is_empty
		end			
		
	default_font: EV_FONT is
			-- Default font
		once
			create Result	
		end		

	should_show: BOOLEAN is
			-- Should show in current state?
		do
			Result := not choice_list.is_empty
		end

feature {NONE} -- Events handling

	mouse_selection (x_pos, y_pos, button: INTEGER; unused1,unused2,unused3: DOUBLE; unused4,unused5:INTEGER) is
			-- process mouse click in the list
		do
			if button = 1 and not choice_list.selected_items.is_empty then
				close_and_complete				
			end
		end

	prev_item_index: INTEGER
		-- Index of last selected item before current one.

	on_key_released (ev_key: EV_KEY) is
			-- process user input in `choice_list'	
		local
			ix: INTEGER
		do			
			if ev_key /= Void then
				inspect
					ev_key.code
				when Key_enter then
					close_and_complete
				when Key_escape then
					exit
					editor.set_focus	
				when Key_up then
					if not choice_list.is_empty then
						if not choice_list.selected_items.is_empty then
							ix := choice_list.selected_rows.first.index
							if ix <= 1 and prev_item_index = 1 then
								choice_list.remove_selection
								choice_list.row (choice_list.row_count).enable_select
							end
						end			
						choice_list.selected_rows.first.ensure_visible	
					end
				when Key_down then
					if not choice_list.is_empty then
						if not choice_list.selected_items.is_empty then
							ix := choice_list.selected_rows.first.index
							if ix >= choice_list.row_count and prev_item_index = choice_list.row_count then
								choice_list.remove_selection
								choice_list.row (1).enable_select
							end
						end
						choice_list.selected_rows.first.ensure_visible	
					end
				when key_back_space then
					editor.handle_extended_key (ev_key)					
					if not buffered_input.is_empty then				
						buffered_input := buffered_input.substring (1, buffered_input.count - 1)											
					else
						exit
					end
					select_closest_match					
				else
					-- Do nothing
				end
				
				if not choice_list.selected_rows.is_empty then
					prev_item_index := choice_list.selected_rows.first.index
				else	
					prev_item_index := 0			
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
						-- Go up 10 items
					if not choice_list.is_empty then
						if not choice_list.selected_items.is_empty then
							ix:= choice_list.selected_rows.first.index
							if ix <= 10 then
								if prev_item_index = 1 then
									choice_list.remove_selection
									choice_list.row (choice_list.row_count).enable_select
								else
									choice_list.remove_selection
									choice_list.row (1).enable_select
								end								
							else
								choice_list.remove_selection
								choice_list.row (ix - 10).enable_select
							end
						end
						choice_list.selected_rows.first.ensure_visible	
					end
				when Key_page_down then
						-- Go down 10 items
					if not choice_list.is_empty then
						if not choice_list.selected_items.is_empty then
							ix:= choice_list.selected_rows.first.index
							if ix > choice_list.row_count - 10 then
								if prev_item_index = choice_list.row_count then
									choice_list.remove_selection
									choice_list.row (1).enable_select
								else
									choice_list.remove_selection
									choice_list.row (choice_list.row_count).enable_select
								end								
							else
								choice_list.remove_selection
								choice_list.row (ix + 10).enable_select
							end
						end
						choice_list.selected_rows.first.ensure_visible	
					end								
				when key_home then
					if ev_application.ctrl_pressed and then not choice_list.is_empty then
							-- Go to top
						choice_list.remove_selection
						choice_list.select_row (1)
					end
				when key_end then
					if ev_application.ctrl_pressed and then not choice_list.is_empty then
							-- Go to bottom
						choice_list.remove_selection
						choice_list.select_row (choice_list.row_count)
					end
				else
					-- Do nothing
				end
				
				if not choice_list.selected_rows.is_empty then
					prev_item_index := choice_list.selected_rows.first.index
				else	
					prev_item_index := 0			
				end				
			end			
		end
		
	on_char (character_string: STRING) is
   			-- Process displayable character key press event.
   		local
   			c: CHARACTER
			c_name: EB_NAME_FOR_COMPLETION
   		do
			if character_string.count = 1 then
				c := character_string.item (1)											
				if c.is_alpha or c.is_digit or c = '_' then
					buffered_input.append_character (c)					
					editor.handle_character (c)					
					create c_name.make_with_name (buffered_input)
					select_closest_match					
				elseif not editor.unwanted_characters.has (c) then					
					close_and_complete
					if not editor.has_selection then
							-- Don't want to add character over first argument
						editor.handle_character (c)						
					end
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
		do		
			if choice_list.virtual_height > choice_list.viewable_height then
				choice_list.set_virtual_position (choice_list.virtual_x_position, ((choice_list.virtual_y_position + (choice_list.row_height * -a)).max (0)).min (choice_list.virtual_height - choice_list.viewable_height))
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
		    Result := preferences.editor_data.filter_completion_list
		end
	
	build_displayed_list (name: STRING) is
			-- Build the list based on matches with `name'
		local
			l_count: INTEGER
			matches: ARRAY [EB_NAME_FOR_COMPLETION]
			list_row: EV_GRID_LABEL_ITEM
			match_item: EB_NAME_FOR_COMPLETION
			l_minimum_width,
			row_index: INTEGER		
			l_upper: INTEGER	
		do			
			choice_list.wipe_out
			matches := matches_based_on_name (name)
			l_minimum_width := 60
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
					if not match_item.show_signature or not match_item.show_type then
						list_row.set_tooltip (match_item.tooltip_text)
								-- TODO: neilc.  auto activating the tooltip works but only based on mouse x/y, 
								-- whereas we need selected_item x/y.
							--list_row.select_actions.extend (agent activate_tooltip)								
					end
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
				if feature_mode then
					complete_feature
				else
					complete_class
				end
			end
			exit
			editor.editor_drawing_area.focus_in_actions.block
			editor.set_focus
			editor.editor_drawing_area.focus_in_actions.resume
		end

	complete_feature is
			-- Complete feature name
		local
			ix: INTEGER
			l_feature: EB_FEATURE_FOR_COMPLETION
		do
			if not choice_list.selected_rows.is_empty then
				if character_to_append = '(' then
					character_to_append := '%U'
				end
				ix := choice_list.selected_rows.first.index + index_offset
				if sorted_names.item (ix).has_dot then
					editor.complete_feature_from_window (sorted_names.item (ix).full_insert_name, True, character_to_append, remainder)
				else
					editor.complete_feature_from_window (" " + sorted_names.item (ix).full_insert_name, True, character_to_append, remainder)
				end
				l_feature ?= sorted_names.item (ix)
				if l_feature /= Void then
					last_completed_feature_had_arguments := l_feature.has_arguments
				else	
					last_completed_feature_had_arguments := False
				end
				
			end
		end

	complete_class is
			-- Complete class name
		local
			ix: INTEGER
		do
			if not choice_list.selected_rows.is_empty then
				ix:= choice_list.selected_rows.first.index + index_offset
				editor.complete_class_from_window (sorted_names.item (ix), '%U', remainder)
			else
				if not buffered_input.is_empty then
					editor.complete_class_from_window (buffered_input, character_to_append, remainder)
				end
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
				if preferences.development_window_data.remember_completion_list_size then
					preferences.development_window_data.save_completion_list_size (width, height)
				end
				hide
				if not last_completed_feature_had_arguments then
					editor.exit_complete_mode
				end
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
				editor.text_displayed.back_delete_char
				l_index := l_index + 1
			end
		end		

	last_completed_feature_had_arguments: BOOLEAN
			-- Did the last inserted completed feature name contain arguments?

	resize_column_to_window_width is
			-- Resize the column width to the width of the window
		do
			if choice_list.column_count > 0 then				
				choice_list.column (1).set_width (choice_list.viewable_width.max (choice_list.width))	
			end
		end		

	is_first_show: BOOLEAN

feature {NONE} -- String matching

	pos_of_first_greater (table: SORTABLE_ARRAY [EB_NAME_FOR_COMPLETION]; a_name: EB_NAME_FOR_COMPLETION): INTEGER is
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
			index_count,
			iteration_count,
			max_iterations,
			buffered_input_count,
			match_index,
			last_best_match_index: INTEGER
			done: BOOLEAN
		do
			if not buffered_input.is_empty then
				buffered_input_count := buffered_input.count
				max_iterations := sorted_names.count										
				from
					iteration_count := 1					
					index_count := 1
				until
					iteration_count > max_iterations or done
				loop
					match_index := match_names_until_done (sorted_names.item (iteration_count), buffered_input)
					if match_index > 0 and match_index > last_best_match_index then
							-- At least one char matched so store match index
						last_best_match_index := match_index
						Result := iteration_count
					end
					if match_index = 1 and last_best_match_index > 1 then
							-- We have reached a worse case down the list so we can stop processing here and use the
							-- current best match index which is already stored in `Result'.  This obviously assumes we are
							-- sorting through an alphabetically ordered list.
						done := True
					end						
					iteration_count := iteration_count + 1
				end
			else
				Result := -1
			end
			if Result = 0 then
				Result := 1
			elseif buffered_input_count > last_best_match_index - 1 then
				Result := -1
			end		
		end		

	select_closest_match is
			-- Select the closest match in the list
		do
			if not is_first_show then
				if rebuild_list_during_matching then
					build_displayed_list (buffered_input)
					resize_column_to_window_width
				else									
					current_index := index_of_closest_match				
				end
			end
			
			if is_displayed then
				if current_index > 0 and then not choice_list.is_empty then
					choice_list.remove_selection
					choice_list.row (current_index).enable_select
					choice_list.selected_rows.first.ensure_visible	
				else
					if not choice_list.selected_rows.is_empty then
						choice_list.selected_rows.first.disable_select
					end
				end
			end
			is_first_show := False
		end	

	match_names_until_done (a_name, a_name2: STRING): INTEGER is
			-- Match the characters of `a_name2' against `a_name' from the start of `a_name2' until no match is
			-- found or all characters match.  Return the index where the match failed.
		local
			cnt,
			const_count: INTEGER
			done: BOOLEAN
			c: CHARACTER
			l_name2: STRING
		do
			l_name2 := a_name2.twin
			if not feature_mode then
				l_name2.to_upper
			end
			from
				cnt := 0
				const_count := a_name.count
			until
				cnt > const_count or done
			loop
				c := a_name.item (cnt + 1)
				if (cnt + 1) > l_name2.count or c /= l_name2.item (cnt + 1) then
					done := True
				end
				cnt := cnt + 1
			end
			Result := cnt
		ensure
			index_returned_makes_sense: Result > 0
		end

	matches_based_on_name (a_name: STRING): ARRAY [EB_NAME_FOR_COMPLETION] is
			-- Array of matches based on `a_name'.  Always use this function before building lists to get correct matches.
		local
			cnt: INTEGER
			for_search: EB_NAME_FOR_COMPLETION
		do
			create Result.make (2, 1)
			if rebuild_list_during_matching and a_name /= Void and not a_name.is_empty then
					-- Matches are filtered according to `buffered_input'
				from
					create for_search.make_with_name (a_name)
					index_offset := pos_of_first_greater (sorted_names, for_search) - 1
				until
					sorted_names.upper < (index_offset + cnt + 1) or else not sorted_names.item (index_offset + cnt + 1).begins_with (a_name)
				loop
					cnt := cnt + 1
				end
				if cnt > 0 then				   
					Result := sorted_names.subarray (index_offset + 1, index_offset + cnt) 
				end
			else
					-- Matches are just all matches
				Result := sorted_names.subarray (1, sorted_names.count)
			end
		ensure
			has_result: Result /= Void
		end		

end -- class EB_COMPLETION_CHOICE_WINDOW
