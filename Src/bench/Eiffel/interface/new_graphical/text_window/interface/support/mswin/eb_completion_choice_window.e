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
			choice_list.disable_default_key_processing
			make_with_title (Interface_names.t_Autocomplete_window)
			create vbox
			vbox.extend (choice_list)
			extend (vbox)
			choice_list.key_press_string_actions.extend (agent on_char)	
			choice_list.key_release_actions.extend (agent on_key_released)
			enable_user_resize
			focus_out_actions.extend (agent on_lose_focus)
			choice_list.focus_out_actions.extend (agent on_lose_focus)
			choice_list.pointer_double_press_actions.extend (agent mouse_selection)	
		end		

feature -- Initialization

	initialize_for_features (an_editor: EB_SMART_EDITOR; feature_name: STRING; completion_possibilities: SORTABLE_ARRAY [EB_NAME_FOR_COMPLETION]) is
			-- Initialize to to complete for `feature_name' in `an_editor'.
		do
			feature_mode := True
			editor := an_editor
			before_complete := feature_name
			sorted_names := completion_possibilities
			common_initialization
		end

	initialize_for_classes (an_editor: EB_SMART_EDITOR; class_name: STRING; completion_possibilities: SORTABLE_ARRAY [EB_NAME_FOR_COMPLETION]) is
			-- Initialize to to complete for `class_name' in `an_editor'.
		do
			feature_mode := False
			editor := an_editor
			before_complete := class_name
			sorted_names := completion_possibilities
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

			if not choice_list.is_empty then
					-- If there is only one possibility, we insert it without displaying the window
				show_needed := choice_list.count > 1
				if not show_needed then
					choice_list.first.enable_select
					close_and_complete
				end
			end
		end

feature -- Access

	editor: EB_SMART_EDITOR
			-- associated window

	choice_list: EB_COMPLETION_CHOICE_LIST
			-- list displaying possible feature signatures

	sorted_names: SORTABLE_ARRAY [EB_NAME_FOR_COMPLETION]
			-- list of possible feature names sorted alphabetically

	before_complete: STRING

feature -- Status report

	show_needed: BOOLEAN
			-- Should the window be displayed ?

	feature_mode: BOOLEAN
			-- Is `Current' used to select feature names ?

feature -- Status Setting

	show is
			-- Show
		do
			if should_show then				
				Precursor {EV_WINDOW}
				choice_list.set_focus
				select_closest_match	
			end
		end		

feature -- Query

	has_match: BOOLEAN is
			-- Number of matches based on `a_name' using `buffered_input' value.
		do
			Result := not matches_based_on_name (buffered_input).is_empty
		end		

	longest_text_width_in_pixels: INTEGER is
			-- Width in pixels of `longest_text_value'
		local
			a_font: EV_FONT
		do			
			a_font := (create {EV_LABEL}).font
			if longest_text_value /= Void then		
				Result := a_font.string_width (longest_text_value)
			end
		end		

feature {NONE} -- Events handling

	mouse_selection (x_pos, y_pos, button: INTEGER; unused1,unused2,unused3: DOUBLE; unused4,unused5:INTEGER) is
			-- process mouse click in the list
		do
			if button = 1 and choice_list.selected_item /= Void	then
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
						if choice_list.selected_item /= Void then
							ix := choice_list.index_of (choice_list.selected_item, 1)
							if ix <= 1 and prev_item_index = 1 then
								choice_list.last.enable_select
							end
						end						
						choice_list.ensure_item_visible (choice_list.i_th (choice_list.index_of (choice_list.selected_item, 1)))
					end
				when Key_down then
					if not choice_list.is_empty then
						if choice_list.selected_item /= Void then
							ix := choice_list.index_of (choice_list.selected_item, 1)
							if ix >= choice_list.count and prev_item_index = choice_list.count then
								choice_list.first.enable_select
							end
						end
						choice_list.ensure_item_visible (choice_list.i_th (choice_list.index_of (choice_list.selected_item, 1)))
					end
				when Key_page_up then
						-- Go up 10 items
					if not choice_list.is_empty then
						if choice_list.selected_item /= Void then
							ix:= choice_list.index_of (choice_list.selected_item, 1)
							if ix <= 10 then
								if prev_item_index = 1 then
									choice_list.last.enable_select
								else
									choice_list.first.enable_select
								end								
							else
								choice_list.i_th (ix - 10).enable_select
							end
						end
						choice_list.ensure_item_visible (choice_list.i_th (choice_list.index_of (choice_list.selected_item, 1)))
					end
				when Key_page_down then
						-- Go down 10 items
					if not choice_list.is_empty then
						if choice_list.selected_item /= Void then
							ix:= choice_list.index_of (choice_list.selected_item,1)
							if ix > choice_list.count - 10 then
								if prev_item_index = choice_list.count then
									choice_list.first.enable_select
								else
									choice_list.last.enable_select
								end								
							else
								choice_list.i_th (ix + 10).enable_select
							end
						end
						choice_list.ensure_item_visible (choice_list.i_th (choice_list.index_of (choice_list.selected_item, 1)))
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
				prev_item_index := choice_list.index_of (choice_list.selected_item, 1)
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
					if not preferences.editor_data.show_completion_signature then
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
			if not (is_destroyed or else has_focus or else choice_list.has_focus) then
				exit				
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
			list_row: EV_LIST_ITEM
			match_item: EB_NAME_FOR_COMPLETION
			l_minimum_width: INTEGER			
		do			
			choice_list.wipe_out
			longest_text_value := ""
			matches := matches_based_on_name (name)
			l_minimum_width := 60
			if matches.is_empty then
				current_index := 0	
			else
				current_index := 1
			end
			from
				l_count := matches.lower
			until
				l_count > matches.upper
			loop
				match_item := matches.item (l_count)
				if match_item /= Void then
					create list_row.make_with_text (match_item.out)
					if match_item.has_data then
						list_row.set_pixmap (match_item.icon)						
						if not match_item.show_signature or not match_item.show_type then
							list_row.set_tooltip (match_item.tooltip_text)
									-- TODO: neilc.  auto activating the tooltip works but only based on mouse x/y, 
									-- whereas we need selected_item x/y.
								--list_row.select_actions.extend (agent activate_tooltip)
						end
					end
					choice_list.extend (list_row)					
					if match_item.count > longest_text_value.count then
						longest_text_value := match_item
					end
				end
				l_count := l_count + 1
			end
		end

	longest_text_value: STRING
			-- Longest string in completion list

	close_and_complete is
			-- close the window and perform completion with selected item
		do
			if choice_list.selected_item /= Void then
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
			editor.set_focus
		end

	complete_feature is
			-- Complete feature name
		local
			ix: INTEGER
		do
			if choice_list.selected_item /= Void then
				if character_to_append = '(' then
					character_to_append := '%U'
				end
				ix := choice_list.index_of (choice_list.selected_item,1) + index_offset
				if sorted_names.item (ix).has_dot then
					editor.complete_feature_from_window (sorted_names.item (ix).full_insert_name, True, character_to_append)
				else
					editor.complete_feature_from_window (" " + sorted_names.item (ix).full_insert_name, True, character_to_append)
				end
			end
		end

	complete_class is
			-- Complete class name
		local
			ix: INTEGER
		do
			if choice_list.selected_item /= Void then
				ix:= choice_list.index_of (choice_list.selected_item, 1) + index_offset
				editor.complete_class_from_window (sorted_names.item (ix), '%U')
			else
				if not buffered_input.is_empty then
					editor.complete_class_from_window (buffered_input, character_to_append)
				end
			end
		end

	exit is
			-- Cancel autocomplete
		do
			if not is_closing then
				is_closing := True				
				if has_capture then
					disable_capture
				end
				if preferences.development_window_data.remember_completion_list_size then
					preferences.development_window_data.save_completion_list_size (width, height)
				end
				hide
				if not feature_mode then
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
			choice_list.selected_item.pointer_motion_actions.call ([1,1,1.0,1.0,1.0,1,1])
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

	should_show: BOOLEAN is
			-- Should show in current state?
		do
			if choice_list /= Void then
				from
					choice_list.start
				until
					choice_list.after or Result
				loop
					Result := choice_list.item /= Void
					choice_list.forth
				end
			end			
		end

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
		ensure
			valid_result: Result > 0
		end		

	select_closest_match is
			-- Select the closest match in the list
		do
			if rebuild_list_during_matching then
				build_displayed_list (buffered_input)
			else				
				current_index := index_of_closest_match
			end
			if is_displayed then
				if current_index > 0 and then not choice_list.is_empty then
					choice_list.i_th (current_index).enable_select
					choice_list.ensure_item_visible (choice_list.selected_item)
				else
					if choice_list.selected_item /= Void then
						choice_list.selected_item.disable_select
					end
				end
			end
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
