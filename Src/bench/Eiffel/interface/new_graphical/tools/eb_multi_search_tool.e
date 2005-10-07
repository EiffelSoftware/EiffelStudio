indexing
	description	: "Tool to search and replace a string in clusters, classes or editor in the whole system."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_MULTI_SEARCH_TOOL

inherit

	EB_SEARCH_TOOL
		rename
			replace as replace_current
		redefine
			make,
			build_interface,
			build_options_box,
			build_buttons_box,
			search,
			replace_current,
			switch_mode,
			search_is_possible,
			force_new_search,
			go_to_next_found,
			go_to_previous_found,
			key_pressed,
			default_search,
			enable_disable_search_button,
			on_text_edited,
			on_text_reset
		end
	
	MSR_FORMATTER
	
	EB_SHARED_MANAGERS
		undefine
			default_create
		end

	EB_CLASS_TEXT_MANAGER
		export
			{NONE} all
		undefine
			default_create
		end

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
		undefine
			default_create, copy, is_equal
		end
		
	EV_GRID_HELPER
		
create
	make

feature {NONE} -- Initialization

	make (a_manager: EB_DEVELOPMENT_WINDOW) is
			-- Initialization
		do
			Precursor (a_manager)
			create multi_search_performer.make
			new_search_set := true
		end

	build_interface is
			-- Build all the tool's widgets.
		local
			vbox: EV_VERTICAL_BOX
			search_box: EV_VERTICAL_BOX
			replace_box: EV_VERTICAL_BOX
			label: EV_LABEL
			size: INTEGER
			buttons_box: EV_BOX
			options_box: EV_BOX
			report_box: EV_BOX
			frame: EV_FRAME
		do
			create label.make_with_text (Interface_names.l_Search_for)
			label.align_text_left
			size := label.minimum_width

			create keyword_field
			keyword_field.change_actions.extend (agent enable_disable_search_button)
			keyword_field.key_press_actions.extend (agent key_pressed (?, True))
			keyword_field.set_minimum_width (Layout_constants.Dialog_unit_to_pixels (100))
			keyword_field.drop_actions.extend (agent display_stone_signature (keyword_field, ?))

			create search_box
			search_box.set_padding (3)
			search_box.extend (label)
			search_box.extend (keyword_field)
			
			create replace_combo_box
			replace_combo_box.key_press_actions.extend (agent key_pressed (?, False))
			replace_combo_box.set_minimum_width (Layout_constants.Dialog_unit_to_pixels (100))
			replace_combo_box.drop_actions.extend (agent display_stone_signature (replace_combo_box, ?))

			create replace_check_button.make_with_text (Interface_names.l_Replace_with)
			replace_check_button.select_actions.extend (agent switch_mode)
			replace_check_button.key_press_actions.extend (agent key_pressed (?, True ))
			size := size.max (replace_check_button.minimum_width)

			create replace_text.make (0)

			create replace_box
			replace_box.extend (replace_check_button)
			replace_box.disable_item_expand (replace_check_button)
			replace_box.extend (replace_combo_box)

			options_box := build_options_box
			buttons_box := build_buttons_box
			report_box := build_report_box
			
			if not preferences.development_window_data.show_search_options then
				toggle_options
			end
			
			create vbox
			vbox.set_border_width (Layout_constants.Small_border_size)
			vbox.set_padding (Layout_constants.Small_border_size)
			vbox.extend (search_box)
			vbox.disable_item_expand (search_box)
			vbox.extend (replace_box)
			vbox.disable_item_expand (replace_box)
			vbox.extend (buttons_box)
			vbox.disable_item_expand (buttons_box)
			vbox.extend (options_box)
			vbox.disable_item_expand (options_box)
			vbox.extend (report_box)
			
			create frame
			frame.set_style ((create {EV_FRAME_CONSTANTS}).Ev_frame_raised)
			frame.extend (vbox)

			switch_mode
			widget := frame
		end

feature -- Access

	grid_head_class: STRING is				"Class"	
	grid_head_found: STRING is				"Found"
	grid_head_context: STRING is			"Context"
	grid_head_file_location: STRING is		"File location"
	
	surrounding_text_number: INTEGER is 	20
			-- Maximal number of characters on one side of found text in the report.
	
	column_border_space: INTEGER is 8
			-- Padding space for column content	

	resized_columns_list: ARRAY [BOOLEAN] is
			-- List of boolean s for each column indicating if it has been user resizedat all.
		once
			Result := <<False, False, False, False>>
		end

	multi_search_performer: MSR
			-- Tool that actually performs the search
			
	replace_all_click_button: EV_BUTTON
			-- Replace all button
			
	add_button: EV_BUTTON
			-- Add button
	
	remove_button: EV_BUTTON
			-- Remove button
			
	remove_all_button: EV_BUTTON
			-- Remove all button

	use_regular_expression_button: EV_CHECK_BUTTON
			-- Button to tell if pattern contains wild card.
			
	current_editor_button: EV_RADIO_BUTTON
			-- Button to search in editor
			
	whole_project_button: EV_RADIO_BUTTON
			-- Button to search in whole project
			
	scope_button: EV_RADIO_BUTTON
			-- Button to search in a specific scope
			
	search_subcluster_button: EV_CHECK_BUTTON
			-- Button to indicate if subcluster of the specific scope will be searched.
			
	scope_list: EV_LIST
			-- List of the specific scope
			
	search_report_grid: ES_GRID
			-- Grid to contain search report

	replace_combo_box: EV_COMBO_BOX
			-- Replacment combo box

feature -- Status report

	reverse : BOOLEAN is
			-- Search upwards?
		do
			Result := search_backward_button.is_selected or temp_reverse
		end
		
	is_whole_project_searched : BOOLEAN is
			-- Is the whole project searched?
		do
			Result := whole_project_button.is_selected	
		end
		
	is_scoped : BOOLEAN is
			-- Is search scoped?
		do
			Result := scope_button.is_selected
		end

	is_case_sensitive: BOOLEAN is
			-- Is search case sensitive?
		do
			Result := case_sensitive_button.is_selected
		end
	
	is_whole_word_matched: BOOLEAN is	
			-- Is search whole word matched?
		do
			Result := whole_word_button.is_selected
		end
		
	is_regular_expression_used: BOOLEAN is
			-- Is regular expression used in search?
		do
			Result := use_regular_expression_button.is_selected
		end
		
	is_sub_cluster_searched: BOOLEAN is
			-- Are subclusters searched?
		do
			Result := search_subcluster_button.is_selected	
		end

feature -- Status setting

	force_new_search is
			-- Force new search.
		do
			new_search_set := true
		end

feature -- Action

	go_to_next_found is
			-- Highlight next found item if possible, possibly go back.
			-- If search is not launched, launch it.
		local
			new_search: BOOLEAN
		do
			new_search := false
			if old_editor /= editor and not is_scoped and not is_whole_project_searched then
				force_new_search
			end
			if shown then
				if search_button.is_sensitive then
					if new_search_set or not multi_search_performer.is_search_launched then
						search
						new_search := true
					end
					if not editor.has_focus then
						editor.set_focus
					end
				end
			else
				if new_search_set or not multi_search_performer.is_search_launched then
					default_search
					new_search := true
				end
			end
			if multi_search_performer.is_search_launched and then not multi_search_performer.item_matched.is_empty then
				if reverse then
					if not new_search then
						multi_search_performer.go_to_next_text_item (true)
						check_class_file
						new_search_set := false
					end
				else
					if not new_search then
						multi_search_performer.go_to_next_text_item (false)
						check_class_file
						new_search_set := false
					end
				end
			end
			select_and_show
		end

	go_to_previous_found is
			-- Highlight previous found item if possible.
			-- If search is not launched, launch it.
		do
			temp_reverse := true
			go_to_next_found
			temp_reverse := false
		end

	replace_current is
			-- Replace current match.
		local
			editor_replace_strategy: MSR_REPLACE_IN_ESTUDIO_STRATEGY
			l_item: MSR_TEXT_ITEM
			l_start: INTEGER
			l_end: INTEGER
			l_class_i : CLASS_I
		do
			manager.window.set_pointer_style (default_pixmaps.wait_cursor)
			
			l_start := 0
			l_end := 1			
			if multi_search_performer.is_search_launched and then not multi_search_performer.off then
				l_item ?= multi_search_performer.item
				if l_item /= Void then
					l_start := l_item.start_index_in_unix_text
					l_end := l_item.end_index_in_unix_text + 1
				end				
			end

			if new_search_set or else
				not multi_search_performer.is_search_launched or else
				(not multi_search_performer.off and then
				(editor.text_displayed.cursor /= Void and then 
				(editor.text_displayed.cursor.pos_in_text > l_end or
				editor.text_displayed.cursor.pos_in_text < l_start)))
			then
				search_button_clicked
			end
			if multi_search_performer.is_search_launched and then not multi_search_performer.off then
				 l_class_i ?= multi_search_performer.item.data
				 if l_class_i /= Void then
				 	 if not is_class_i_editing (l_class_i) then
				 	 	check_class_file
				 	 end
				 end
			end
			if editor.number_of_lines /= 0 then	
				if editor.is_editable then	
					if not multi_search_performer.off and not multi_search_performer.is_empty then
						if not is_item_source_changed (l_item) then
							create editor_replace_strategy.make (editor)
							currently_replacing := replace_combo_box.text
							multi_search_performer.set_replace_strategy (editor_replace_strategy)
							multi_search_performer.set_replace_string (currently_replacing)
							multi_search_performer.replace
							update_combo_box_specific (replace_combo_box, currently_replacing)
							new_search_set := false
							select_and_show
							go_to_next_found
							redraw_grid
							select_current_row
							new_search_set := false
						end
					end
				else
					editor.display_not_editable_warning_message
				end
			end
			manager.window.set_pointer_style (default_pixmaps.standard_cursor)
		end
		
	confirm_and_replace_all is
			-- Ask for confirmation, then replace all.
		local
			cd: STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
		do
			create cd.make_initialized (3, preferences.dialog_data.confirm_replace_all_string, warning_messages.w_replace_all, interface_names.l_Discard_replace_all_warning_dialog, preferences.preferences)
			cd.set_ok_action (agent replace_all)
			cd.show_modal_to_window (window_manager.last_focused_development_window.window)
		end

feature {NONE} -- Implementation
	
	check_class_file is
			-- Check if class of current selected item is loaded, if not load it.
		local
			l_item: MSR_ITEM
			l_list: LIST [CLASS_I]
			class_name: STRING
		do
			if not multi_search_performer.off then
				l_item := multi_search_performer.item
				if editor.dev_window.class_name /= l_item.class_name then
					create class_name.make_from_string (l_item.class_name)
					class_name.to_upper
					l_list := editor.dev_window.eiffel_universe.classes_with_name (class_name)
					if not l_list.is_empty then
						editor.dev_window.set_stone (stone_from_class_i (l_list.first))
						from
							process_events_and_idle
						until
							editor.text_is_fully_loaded
						loop
							ev_application.idle_actions.call ([])
						end
					end
				end
			end
		end
		
	stone_from_class_i (a_class_i: CLASS_I): STONE is
			-- Make a stone from a_class_i. 
			-- If a_class_i compiled returns CLASSC_STONE , or a CLASSI_STONE.
		require
			a_class_i_not_void: a_class_i /= Void
		local
			l_class_c: CLASS_C
		do
			l_class_c := a_class_i.compiled_class
			if l_class_c /= Void then
				create {CLASSC_STONE}Result.make (l_class_c )
			else
				create {CLASSI_STONE}Result.make (a_class_i)
			end
		end		
	
	search_button_clicked is
			-- Invokes when search button is clicked.
		do
			if new_search_set or not multi_search_performer.is_search_launched then
				if is_whole_project_searched then
					search_whole_project
				elseif is_scoped then
					search_in_scope
				else
					go_to_next_found
				end
			else
				go_to_next_found
			end
		end

	key_pressed (k: EV_KEY; search_only: BOOLEAN) is
			-- Key `k' was pressed in the interface.
			-- If k is Enter then launch the search, if it is Esc then hide the search interface.
		local
			meta_keys: ARRAY [BOOLEAN]
		do
			if k /= Void then
				if k.code = Key_enter then
					if not keyword_field.text.is_empty and then search_is_possible then
						if search_only then
							search_button_clicked
						else
							replace_current
						end
					end
				elseif k.code = Key_escape then
					close
					ev_application.do_once_on_idle (agent editor.set_focus)
				else
					meta_keys := <<ev_application.ctrl_pressed, ev_application.alt_pressed, ev_application.shift_pressed>>
					if 
						(preferences.editor_data.key_codes_for_actions @ 5) = k.code and then
						meta_keys.is_equal (preferences.editor_data.ctrl_alt_shift_for_actions @ 5)
					then
						if not keyword_field.text.is_empty and then search_only then
							search_button_clicked
						end
					elseif
						(preferences.editor_data.key_codes_for_actions @ 6) = k.code and then
						meta_keys.is_equal (preferences.editor_data.ctrl_alt_shift_for_actions @ 6)
					then
						if not keyword_field.text.is_empty and then search_only then
							temp_reverse := true
							search_button_clicked
							temp_reverse := false
						end
					end
				end
			end
		end
		
	toggle_search_report is
			-- Hide report if it is shown, show it if it is hidden.
		do
			if report.is_show_requested then
				report.hide
				report_button.set_text (Interface_names.l_Search_report_show)
			else
				report.show
				report_button.set_text (Interface_names.l_Search_report_hide)
			end
		end
		
	toggle_scope_detail is
			-- Show and hide the scope detail according to the scope box's selection.
		do
			if scope_button.is_selected then
				scope.enable_sensitive
			else
				scope.disable_sensitive
			end
		end
		
	toggle_scope is
			-- sensible or disable sensitive scope check button and scope detail according to the whole project selection.
		do
			if scope /= Void then
				if is_whole_project_searched then
					scope.disable_sensitive
				elseif is_scoped then			
					scope.enable_sensitive
				else
					scope.disable_sensitive
				end
			end
		end		

	build_options_box: EV_VERTICAL_BOX is
			-- Create and return a box containing the search options
		local
			vbox: EV_VERTICAL_BOX
			frm: EV_FRAME
			options_toolbar: EV_TOOL_BAR
			cell: EV_CELL
			hbox: EV_HORIZONTAL_BOX
		do
				-- Option "Match case"
			create case_sensitive_button.make_with_text (Interface_names.l_Match_case)
			case_sensitive_button.key_press_actions.extend (agent key_pressed (?, True))
			case_sensitive_button.select_actions.extend (agent force_new_search)

				-- Option "Whole word"
			create whole_word_button.make_with_text (Interface_names.l_Whole_word)
			whole_word_button.key_press_actions.extend (agent key_pressed (?, True))
			whole_word_button.select_actions.extend (agent force_new_search)

				-- Option "Use regular expression"
			create use_regular_expression_button.make_with_text (Interface_names.l_Use_regular_expression)
			use_regular_expression_button.key_press_actions.extend (agent key_pressed (?, True))
			use_regular_expression_button.select_actions.extend (agent force_new_search)
			use_regular_expression_button.enable_select

				-- Option "Search backward"
			create search_backward_button.make_with_text (Interface_names.l_Search_backward)
			search_backward_button.key_press_actions.extend (agent key_pressed (?, True))
			
				-- Option "Current Editor"		
			create current_editor_button.make_with_text (Interface_names.l_Current_editor)
			current_editor_button.key_press_actions.extend (agent key_pressed (?, True))
			current_editor_button.select_actions.extend (agent toggle_scope)
			current_editor_button.select_actions.extend (agent force_new_search)

				-- Option "Whole Project"
			create whole_project_button.make_with_text (Interface_names.l_Whole_project)
			whole_project_button.key_press_actions.extend (agent key_pressed (?, True))
			whole_project_button.select_actions.extend (agent toggle_scope)
			whole_project_button.select_actions.extend (agent force_new_search)
				
				-- Option "Scope"
			create scope_button.make_with_text (Interface_names.l_Scope)
			scope_button.key_press_actions.extend (agent key_pressed (?, True))
			scope_button.select_actions.extend (agent toggle_scope_detail)
			scope_button.select_actions.extend (agent force_new_search)
			scope_button.drop_actions.extend (agent on_drop_scope_button (?))
			
				-- Option "Search Subcluster"
			create search_subcluster_button.make_with_text (Interface_names.l_Search_subcluster)
			search_subcluster_button.key_press_actions.extend (agent key_pressed (?, True))
			search_subcluster_button.enable_select
			search_subcluster_button.select_actions.extend (agent force_new_search)
			
				-- Option list scope
			create scope_list.default_create
			scope_list.key_press_actions.extend (agent key_pressed (?, True))
			scope_list.enable_multiple_selection
			scope_list.set_pick_and_drop_mode
			scope_list.drop_actions.extend (agent on_drop_add (?))
				
				-- Add button
			create add_button.make_with_text (interface_names.b_Add)
			add_button.select_actions.extend (agent add_scope)
			add_button.drop_actions.extend (agent on_drop_add (?))
			
				-- Remove button
			create remove_button.make_with_text (interface_names.b_Remove)	
			remove_button.select_actions.extend (agent remove_scope)
			remove_button.drop_actions.extend (agent on_drop_remove (?))
			
				-- Remove all button
			create remove_all_button.make_with_text (interface_names.b_Remove_all)	
			remove_all_button.select_actions.extend (agent remove_all)				
			
			create vbox
			vbox.set_border_width (5)
			vbox.extend (case_sensitive_button)
			vbox.extend (whole_word_button)
			vbox.extend (use_regular_expression_button)
			vbox.extend (search_backward_button)

			create options_button.make_with_text (Interface_names.l_Search_options_hide)
			options_button.select_actions.extend (agent toggle_options)
			create options_toolbar
			options_toolbar.extend (options_button)
			create frm
				-- This is a small workaround for a bug on Windows, where a toolbar
				-- directly inserted within an EV_FRAME, overlaps the bottom of the frame.
				-- There is currently no easy fix for this so this code has been added temporarily
				-- as a work around. Julian.
			create cell
			frm.extend (cell)
			cell.extend (options_toolbar)
			create Result
			Result.extend (frm)
			Result.disable_item_expand (frm)
			
			create hbox

			hbox.extend (vbox)
			hbox.disable_item_expand (vbox)
			
			create vbox
			vbox.set_border_width (5)
			vbox.extend (current_editor_button)
			vbox.extend (whole_project_button)
			vbox.extend (scope_button)
			vbox.disable_item_expand (current_editor_button)
			vbox.disable_item_expand (whole_project_button)
			vbox.disable_item_expand (scope_button)			
			hbox.extend (vbox)
			hbox.disable_item_expand (vbox)
			current_editor_button.enable_select
			
			create vbox
			vbox.set_border_width (5)
			vbox.extend (scope_list)
			scope_list.set_minimum_width (150)
			
			create scope
			scope.extend (vbox)
			scope.disable_item_expand (vbox)
			
			create vbox
			vbox.set_border_width (5)
			vbox.set_padding_width (2)

			vbox.extend (add_button)
			vbox.disable_item_expand (add_button)
			vbox.extend (remove_button)			
			vbox.extend (remove_all_button)
			vbox.disable_item_expand (remove_button)
			vbox.extend (search_subcluster_button)
			vbox.disable_item_expand (search_subcluster_button)
			scope.extend (vbox)
			scope.disable_item_expand (vbox)
			
			hbox.extend (scope)		
			
			create options
			options.extend (hbox)
			Result.extend (options)
			
			toggle_scope
			toggle_scope_detail
		end

	build_buttons_box: EV_HORIZONTAL_BOX is
			-- Create and return a box containing the search buttons
		local
			cell: EV_CELL
		do
			create search_button.make_with_text_and_action (Interface_names.b_Search,agent search_button_clicked)
			search_button.disable_sensitive
			create replace_button.make_with_text_and_action (Interface_names.b_Replace,agent replace_current)
			create replace_all_click_button.make_with_text_and_action (Interface_names.b_Replace_all, agent confirm_and_replace_all)

			create Result
			Result.set_padding (Layout_constants.Small_padding_size)
		
			create cell
			Result.extend (cell)

			Result.extend (search_button)
			Result.disable_item_expand (search_button)
			search_button.set_minimum_width (replace_all_click_button.width)
			Result.extend (replace_button)
			Result.disable_item_expand (replace_button)
			replace_button.set_minimum_width (replace_all_click_button.width)
			
			Result.extend (replace_all_click_button)
			Result.disable_item_expand (replace_all_click_button)
			
			create cell
			Result.extend (cell)
		end
	
	report : EV_FRAME
			-- Report container
		
	report_button : EV_TOOL_BAR_BUTTON
			-- Button to hide or show report.
	
	sumary_label : EV_LABEL
			-- Label to show search sumary.
		
	build_report_box : EV_VERTICAL_BOX is
			-- Create and return a box containing result grid.
		local
			frm: EV_FRAME
			report_toolbar: EV_TOOL_BAR
			hbox: EV_HORIZONTAL_BOX
		do
			create report_button.make_with_text (Interface_names.l_Search_report_hide)
			report_button.select_actions.extend (agent toggle_search_report)
			create report_toolbar
			report_toolbar.extend (report_button)
			create frm
				-- This is a small workaround for a bug on Windows, where a toolbar
				-- directly inserted within an EV_FRAME, overlaps the bottom of the frame.
				-- There is currently no easy fix for this so this code has been added temporarily
				-- as a work around. Julian.
			create hbox
			frm.extend (hbox)
			hbox.extend (report_toolbar)
			create sumary_label.default_create
			hbox.extend (sumary_label)
			hbox.disable_item_expand (sumary_label)
			hbox.disable_item_expand (report_toolbar)
			
			create search_report_grid
			search_report_grid.enable_row_height_fixed
			search_report_grid.enable_single_row_selection
			search_report_grid.disable_always_selected
			search_report_grid.enable_tree
			search_report_grid.set_item (4, 1, Void)
			search_report_grid.column (1).set_title (grid_head_class)
			search_report_grid.column (2).set_title (grid_head_found)
			search_report_grid.column (3).set_title (grid_head_context)
			search_report_grid.column (4).set_title (grid_head_file_location)
			search_report_grid.header.pointer_double_press_actions.force_extend (agent on_header_double_clicked)
			search_report_grid.header.item_resize_actions.force_extend (agent on_header_resize)
			search_report_grid.row_select_actions.extend (agent grid_row_selected (?))
			search_report_grid.set_item_pebble_function (agent grid_pebble_function (?))
			search_report_grid.set_accept_cursor (Cursors.cur_class)
			search_report_grid.set_deny_cursor (Cursors.cur_x_class)
			search_report_grid.set_minimum_width (100)
			
			create Result
			Result.extend (frm)
			Result.disable_item_expand (frm)

			create report
			
			report.extend (search_report_grid)
			Result.extend (report)
			
		end
		
	incremental_search (a_word: STRING) is
			-- Incremental search in the editor displayed text
		local
			incremental_search_strategy: MSR_SEARCH_INCREMENTAL_STRATEGY
			class_i: CLASS_I
			file_name: FILE_NAME
			class_name: STRING
		do
			manager.window.set_pointer_style (default_pixmaps.wait_cursor)
			if not editor.is_empty then
				currently_searched := a_word
				class_name := ""
				if manager.class_name /= Void then
					class_i := manager.eiffel_universe.class_named (manager.class_name, manager.cluster)
					file_name:= class_i.file_name
					class_name := manager.class_name
				else
					create file_name.make
				end				
				create incremental_search_strategy.make (currently_searched, surrounding_text_number, class_name, file_name, editor.text_displayed.text)
				if case_sensitive_button.is_selected then
					incremental_search_strategy.set_case_sensitive
				else
					incremental_search_strategy.set_case_insensitive
				end
				incremental_search_strategy.set_regular_expression_used (use_regular_expression_button.is_selected)
				incremental_search_strategy.set_whole_word_matched (whole_word_button.is_selected)
				if class_i /= Void then
					incremental_search_strategy.set_data (class_i)	
				end
				if editor.dev_window.class_name /= Void then
					incremental_search_strategy.set_class_name (editor.dev_window.class_name)
				end				
				multi_search_performer.set_search_strategy (incremental_search_strategy)
				multi_search_performer.do_search
				multi_search_performer.start
				force_new_search
			end
			manager.window.set_pointer_style (default_pixmaps.standard_cursor)
		end		
		
	search is
			-- Search in editor.
		local
			text_strategy: MSR_SEARCH_TEXT_STRATEGY
			class_i: CLASS_I
			file_name: FILE_NAME
			class_name: STRING
		do
			manager.window.set_pointer_style (default_pixmaps.wait_cursor)
			currently_searched := keyword_field.text
			class_name := "Not a class"
			if manager.class_name /= Void then
				class_i := manager.eiffel_universe.class_named (manager.class_name, manager.cluster)
				file_name := class_i.file_name
				class_name := manager.class_name
			else
				create file_name.make
			end
			if not editor.is_empty then
				create text_strategy.make (currently_searched, surrounding_text_number, class_name, file_name, editor.text_displayed.text)
				multi_search_performer.set_search_strategy (text_strategy)
				if case_sensitive_button.is_selected then
					text_strategy.set_case_sensitive
				else
					text_strategy.set_case_insensitive
				end
				text_strategy.set_regular_expression_used (use_regular_expression_button.is_selected)
				text_strategy.set_whole_word_matched (whole_word_button.is_selected)
				if class_i /= Void then
					text_strategy.set_data (class_i)	
				end
				multi_search_performer.do_search
				update_combo_box_specific (keyword_field, currently_searched)
				after_search
				check_class_file
				update_combo_box_specific (keyword_field, currently_searched)
			end
			manager.window.set_pointer_style (default_pixmaps.standard_cursor)
		end

	default_search is
			-- Search with default options.
		local
			text_strategy: MSR_SEARCH_TEXT_STRATEGY
			class_i: CLASS_I
			file_name: FILE_NAME
			class_name: STRING
		do
			manager.window.set_pointer_style (default_pixmaps.wait_cursor)
			if currently_searched /= Void and then not currently_searched.is_empty then
					-- search is possible but the search box is not shown
					-- default options
				currently_searched := keyword_field.text
				if manager.class_name /= Void then
					class_i := manager.eiffel_universe.class_named (manager.class_name, manager.cluster)
					file_name := class_i.file_name
					class_name := manager.class_name
				else
					create file_name.make
				end
				if not editor.is_empty then
					create text_strategy.make (currently_searched, surrounding_text_number, class_name, file_name, editor.text_displayed.text)
					multi_search_performer.set_search_strategy (text_strategy)
					if case_sensitive_button.is_selected then
						text_strategy.set_case_sensitive
					else
						text_strategy.set_case_insensitive
					end
					text_strategy.set_regular_expression_used (true)
					text_strategy.set_whole_word_matched (false)
					if class_i /= Void then
						text_strategy.set_data (class_i)	
					end
					multi_search_performer.do_search
					update_combo_box_specific (keyword_field, currently_searched)
					after_search
					check_class_file
				end
			end
			manager.window.set_pointer_style (default_pixmaps.standard_cursor)
		end
		
	search_whole_project is	
			-- Search the whole project.
		local
			l_project_strategy: MSR_SEARCH_WHOLE_PROJECT_STRATEGY
		do
			manager.window.set_pointer_style (default_pixmaps.wait_cursor)
			create l_project_strategy.make (currently_searched, surrounding_text_number, clusters_in_the_project)
			if is_case_sensitive then
				l_project_strategy.set_case_sensitive
			else
				l_project_strategy.set_case_insensitive
			end 
			currently_searched := keyword_field.text
			l_project_strategy.set_regular_expression_used (is_regular_expression_used)
			l_project_strategy.set_whole_word_matched (is_whole_word_matched)
			multi_search_performer.set_search_strategy (l_project_strategy)
			multi_search_performer.do_search
			update_combo_box_specific (keyword_field, currently_searched)
			after_search
			old_editor := Void
			manager.window.set_pointer_style (default_pixmaps.standard_cursor)
		end
	
	search_in_scope is
			-- Search in scope.
		local
			l_scope_strategy: MSR_SEARCH_IN_SCOPE_STRATEGY
		do
			manager.window.set_pointer_style (default_pixmaps.wait_cursor)
			currently_searched := keyword_field.text
			create l_scope_strategy.make (currently_searched, surrounding_text_number, scope_list)
			if is_case_sensitive then
				l_scope_strategy.set_case_sensitive
			else
				l_scope_strategy.set_case_insensitive
			end
			l_scope_strategy.set_regular_expression_used (is_regular_expression_used)
			l_scope_strategy.set_subcluster_searched (is_sub_cluster_searched)
			l_scope_strategy.set_whole_word_matched (is_whole_project_searched)
			multi_search_performer.set_search_strategy (l_scope_strategy)
			multi_search_performer.do_search
			update_combo_box_specific (keyword_field, currently_searched)
			after_search
			old_editor := Void
			manager.window.set_pointer_style (default_pixmaps.standard_cursor)
		end		
		
	after_search is
			-- When a search done, go here. Incremental search excluded.
		do
			if multi_search_performer.is_search_launched then
				multi_search_performer.start
				old_search_key_value := currently_searched				
				old_editor := editor
				redraw_grid
				new_search_set := false		
			end
		end
		
	scope : EV_HORIZONTAL_BOX
			-- Scope widget container.
	
	choose_dialog: EB_CHOOSE_MULTI_CLUSTER_N_CLASS_DIALOG
			-- Dialog used to add classes or clusters to scope
	
	add_scope is
			-- Add a new scope from a choose dialog to the list.
		do
			if choose_dialog = Void or else choose_dialog.is_destroyed then
				create choose_dialog.make
				choose_dialog.set_class_add_action (agent add_class_item (?))
				choose_dialog.set_cluster_add_action (agent add_cluster_item (?))
				choose_dialog.show_relative_to_window (manager.window)
				choose_dialog.default_push_button.select_actions.extend (agent force_new_search)
			end
			choose_dialog.set_focus
		end
		
	on_drop_scope_button (a_any: ANY) is
			-- Invoke hen dropping on the scope check button.
		do
			scope_button.enable_select
			on_drop_add (a_any)
		end		
	
	on_drop_add (a_any: ANY) is
			-- Invoke when dropping a pebble to add an item to the scope.
		require
			a_any_not_void: a_any /= Void
		local
			l_classi_stone: CLASSI_STONE
			l_cluster_stone: CLUSTER_STONE
		do
			l_classi_stone ?= a_any
			l_cluster_stone ?= a_any
			if l_classi_stone /= Void then
				add_class_item (l_classi_stone.class_i)
			end
			if l_cluster_stone /= Void then
				add_cluster_item (l_cluster_stone.cluster_i)
			end
		end
	
	on_drop_remove (a_any: ANY) is
			-- Invoke when dropping a pebble on remove button.
		require
			a_any_not_void: a_any /= Void
		local
			l_classi_stone: CLASSI_STONE
			l_cluster_stone: CLUSTER_STONE
		do
			l_classi_stone ?= a_any
			l_cluster_stone ?= a_any
			if l_classi_stone /= Void then
				remove_class_item (l_classi_stone.class_i)
			end
			if l_cluster_stone /= Void then
				remove_cluster_item (l_cluster_stone.cluster_i)
			end	
		end
		
	one_replaced_in_all (a_item: MSR_ITEM) is
			-- Invoke when replacing all, one matched item replaced.
		do
			new_search_set := false
		end
		
	on_text_edited (directly_edited: BOOLEAN) is
			-- Notify observers that some text has been modified.
			-- If `directly_edited', the user has modified the text in the editor,
			-- not via another tool or wizard.
		do
			force_new_search
			is_text_changed_in_editor := true
		end

	on_text_reset is
			-- make the command insensitive
		do
			is_text_changed_in_editor := false
		end
		
	is_text_changed_in_editor: BOOLEAN
			-- Text changed in the editor?
	
	add_class_item (a_class: CLASS_I) is
			-- Add a class item to the tree.
		require
			a_class_not_void: a_class /= Void
		local
			l_item: EV_LIST_ITEM
		do
			l_item := scope_list.retrieve_item_by_data (a_class, false)
			if l_item = Void then
				create l_item.make_with_text (a_class.name)
				l_item.set_pixmap (pixmap_from_class_i (a_class))
				scope_list.extend (l_item)
				l_item.set_data (a_class)
				l_item.set_pebble_function (agent scope_pebble_function (a_class))
				l_item.set_accept_cursor (Cursors.cur_class)
				l_item.set_deny_cursor (Cursors.cur_x_class)
				force_new_search
			end
		end
		
	remove_class_item (a_class: CLASS_I) is
			-- Remove a class item from the list.
		require
			a_class_not_void: a_class /= Void
		local
			l_item: EV_LIST_ITEM
		do
			l_item := scope_list.retrieve_item_by_data (a_class, false)
			scope_list.prune_all (l_item)
			force_new_search
		end
		
	remove_cluster_item (a_cluster: CLUSTER_I) is
			-- Remove a class item from the list.
		require
			a_cluster_not_void: a_cluster /= Void
		local
			l_item: EV_LIST_ITEM
		do
			l_item := scope_list.retrieve_item_by_data (a_cluster, false)
			scope_list.prune_all (l_item)
			force_new_search
		end
		
	add_cluster_item (a_cluster: CLUSTER_I) is
			-- Add a cluster item to the list.
		require
			a_cluster_not_void: a_cluster /= Void
		local
			l_item: EV_LIST_ITEM
		do
			l_item := scope_list.retrieve_item_by_data (a_cluster, false)
			if l_item = Void then
				create l_item.make_with_text (a_cluster.display_name)
				l_item.set_pixmap (pixmap_from_cluster_i (a_cluster))
				scope_list.extend (l_item)
				l_item.set_data (a_cluster)
				l_item.set_pebble_function (agent scope_pebble_function (a_cluster))
				l_item.set_accept_cursor (Cursors.cur_cluster)
				l_item.set_deny_cursor (Cursors.cur_x_class)
				force_new_search
			end
		end
	
	scope_pebble_function (a_data: ANY) : STONE is
			-- Scope pebble function
		local
			l_class_i: CLASS_I
			l_cluster_i: CLUSTER_I
		do
			l_class_i ?= a_data
			l_cluster_i ?= a_data
			if l_class_i /= Void then
				Result := stone_from_class_i (l_class_i)
			end
			if l_cluster_i /= Void then
				create {CLUSTER_STONE}Result.make (l_cluster_i)
			end
		end	
		
	grid_pebble_function (a_item: EV_GRID_ITEM) : STONE is
			-- Grid pebble function
		local
			l_row: EV_GRID_ROW
			l_item: MSR_ITEM
			l_class_name: STRING
			l_list: LIST [CLASS_I]
		do
			if a_item /= Void then			
				l_row := a_item.row
				l_item ?= l_row.data
				if l_item /= Void then
					create l_class_name.make_from_string (l_item.class_name)
					l_class_name.to_upper
					l_list := editor.dev_window.eiffel_universe.classes_with_name (l_class_name)
					if l_list /= Void and then not l_list.is_empty then
						Result := stone_from_class_i (l_list.first)
					end
				end
			end
		end
	
	clusters_in_the_project: EB_CLUSTERS is
			-- Clusters in the project
		do
			Result:= manager.cluster_manager.manager	
		end		
		
	remove_scope is
			-- Remove a scope from the list
		local
			test: DYNAMIC_LIST [EV_LIST_ITEM]
		do
			test := scope_list.selected_items
			from
				test.start
			until
				test.after
			loop
				scope_list.prune (test.item)
				test.forth
			end
			if scope_list.selected_items.count /= 0 then
				force_new_search
			end			
		end
		
	remove_all is
			-- Remove all from scope
		do
			scope_list.wipe_out
		end
		
	switch_mode is
			-- Switch from the normal mode to the replace mode
			-- or the opposite
		do
			if not replace_check_button.is_selected then
				replace_text := replace_combo_box.text
				replace_combo_box.remove_text
				replace_combo_box.hide
				replace_check_button.set_text (Interface_names.l_Replace_with_ellipsis)
				replace_button.disable_sensitive
				replace_all_click_button.disable_sensitive
			else
				replace_combo_box.set_text (replace_text)
				replace_combo_box.show
				replace_check_button.set_text (Interface_names.l_Replace_with)
				if search_is_possible then
					replace_button.enable_sensitive
					replace_all_click_button.enable_sensitive
				end
			end
		end

	enable_disable_search_button is
			-- disable the search buton if the search field is empty, incremental search if it is possible.
		do
			if search_is_possible then
				search_button.enable_sensitive
				if replace_check_button.is_selected then
					replace_button.enable_sensitive
					replace_all_click_button.enable_sensitive
				end
				if not editor.is_empty then
					incremental_search (keyword_field.text)
					if not multi_search_performer.off then
						select_in_current_editor
					else
						editor.deselect_all
					end
				end
			else
				editor.deselect_all
				search_button.disable_sensitive
				replace_button.disable_sensitive
				replace_all_click_button.disable_sensitive
			end
			if old_search_key_value /= Void and then not old_search_key_value.is_equal (keyword_field.text) then
				force_new_search
			end
		end

	search_is_possible: BOOLEAN is
			-- Is it possible to look for the current content of the "search for:" field?
		local
			for_test: STRING
		do
			for_test := keyword_field.text
			Result := not for_test.is_empty
		end
		
	on_header_double_clicked is
			-- Header was double-clicked.
		local
			div_index: INTEGER
			col: EV_GRID_COLUMN
		do
			div_index := search_report_grid.header.pointed_divider_index
			if div_index > 0 then
				col := search_report_grid.column (div_index)
				col.set_width (col.required_width_of_item_span (1, col.parent.row_count) + column_border_space)			
			end		
		end		
		
	on_header_resize is
			-- Header was double-clicked.
		local
			div_index: INTEGER
			col: EV_GRID_COLUMN
		do
			div_index := search_report_grid.header.pointed_divider_index
			if div_index > 0 then
				col := search_report_grid.column (div_index)
				resized_columns_list.put (True, col.index)
			end		
		end
		
	compute_adjust_vertical (a_font: EV_FONT; a_label_item: EV_GRID_ITEM) is
			-- Compute `adjust_vertical'
		require
			font_attached: a_font /= Void
			label_item_attached: a_label_item /= Void
		local
			vertical_text_offset_into_available_space: INTEGER
			label_item: EV_GRID_LABEL_ITEM
			client_height: INTEGER
		do
			if adjust_vertical = 0 then
				label_item ?= a_label_item
				if label_item /= Void then
					if text_height = 0 then
						text_height := a_font.string_size ("a").integer_item (2)
					end
					client_height := label_item.height - label_item.top_border - label_item.bottom_border
					if label_item.is_top_aligned then
						vertical_text_offset_into_available_space := 0
					elseif label_item.is_bottom_aligned then
						vertical_text_offset_into_available_space := client_height - text_height - 1
					else
						vertical_text_offset_into_available_space := vertical_text_offset_into_available_space // 2
					end
					vertical_text_offset_into_available_space := vertical_text_offset_into_available_space.max (0)
					adjust_vertical := vertical_text_offset_into_available_space - label_item.top_border
				end					
			end			
		end
		
	new_label_item (a_string: STRING): EV_GRID_LABEL_ITEM is
			-- Create uniformed label item
		require
			string_attached: a_string /= Void
		do
			create Result.make_with_text (a_string)
		ensure
			new_item_not_void: Result /= Void
		end		
		
	adjust_vertical: INTEGER
			-- Offset between top of a row and top of charactors in it, buffer for effiency enhancement
			
	text_height: INTEGER
			-- Height of the text in the `search_report_grid', buffer for effiency enhancement
		
	expose_drawable_action (drawable: EV_DRAWABLE; a_item: MSR_ITEM; query_grid_row: EV_GRID_ROW) is
			-- Draw grid item, to make the text colorfull.
			-- return width of current drawable item.
		local
			offset: INTEGER
			row_selected, focused: BOOLEAN
			l_color: EV_COLOR
			font: EV_FONT
			l_item: MSR_TEXT_ITEM
		do
			font := drawable.font
			if adjust_vertical = 0 then
				compute_adjust_vertical (font, query_grid_row.item (1))
			end
			drawable.clear			
			row_selected := query_grid_row.is_selected
			focused := search_report_grid.has_focus
			if row_selected then
				if focused then
					drawable.set_foreground_color(search_report_grid.focused_selection_color)
					create l_color.make_with_rgb (1, 1, 1)
				else
					drawable.set_foreground_color(search_report_grid.non_focused_selection_color)
					create l_color.make_with_rgb (0, 0, 0)
				end
			else
				drawable.set_foreground_color ((create {EV_STOCK_COLORS}).white)
				create l_color.make_with_rgb (0, 0, 0)
			end
			
			drawable.fill_rectangle (0, 0, drawable.width,drawable.height)
			l_item ?= a_item
			if l_item /= Void then
				drawable.set_foreground_color (l_color)
				drawable.draw_text_top_left (0, adjust_vertical, 
											l_item.context_text.substring (1, l_item.start_index_in_context_text - 1))
				drawable.set_foreground_color (preferences.editor_data.operator_text_color)
				offset := font.string_width (l_item.context_text.substring (1, l_item.start_index_in_context_text - 1))
				
				drawable.draw_text_top_left (offset, adjust_vertical, replace_rnt_to_space (l_item.text))
				drawable.set_foreground_color (l_color)
				offset := font.string_width (l_item.context_text.substring (1, l_item.start_index_in_context_text + l_item.text.count - 1))
				
				drawable.draw_text_top_left (offset, 
											adjust_vertical,
											l_item.context_text.substring (l_item.start_index_in_context_text + l_item.text.count,
																			l_item.context_text.count))	
			else
				drawable.draw_text (0, adjust_vertical, "-")
			end		
		end
		
	redraw_grid is
			-- Redraw grid according to search result and refresh sumary label.
		local
			x: INTEGER
			i, j, k: INTEGER
			row_count: INTEGER
			submatch_parent: INTEGER
			arrayed_list: ARRAYED_LIST[MSR_ITEM]
			l_item: MSR_ITEM
			l_class_item: MSR_CLASS_ITEM
			l_text_item: MSR_TEXT_ITEM
			l_grid_drawable_item: EV_GRID_DRAWABLE_ITEM
			l_grid_label_item: EV_GRID_LABEL_ITEM
			l_class_i: CLASS_I
			l_label: EV_LABEL
			font: EV_FONT
		do
			if multi_search_performer.is_search_launched then
				grid_remove_and_clear_all_rows (search_report_grid)
				sumary_label.set_text ("   " +
										multi_search_performer.text_found_count.out + 
										" found(s) in " + 
										multi_search_performer.class_count.out + 
										" class(es)"
										)
				
				x := multi_search_performer.index
				create l_label
				font := l_label.font
				from 
					arrayed_list := multi_search_performer.item_matched
					arrayed_list.start
					row_count := search_report_grid.row_count + 1
					i := 0
					j := 0
					k := 0
				until
					arrayed_list.after
				loop
					l_item := arrayed_list.item
	
					l_class_item ?= arrayed_list.item
					if l_class_item /= Void then
						j := j + 1
						search_report_grid.insert_new_row (row_count)
						search_report_grid.row (row_count).set_data (l_class_item)
						if i /= 0 then
							search_report_grid.set_item (2, i, new_label_item (k.out))
							search_report_grid.item (2, i).set_foreground_color (preferences.editor_data.number_text_color_preference.value)
						end
						i := row_count
						create l_grid_label_item.make_with_text (l_item.class_name)
						l_class_i ?= l_class_item.data
						if l_class_i /= Void then
							l_grid_label_item.set_pixmap (pixmap_from_class_i (l_class_i))
						end
						search_report_grid.set_item (1, row_count, l_grid_label_item)
						search_report_grid.set_item (3, 
													row_count, 
													new_label_item (once "-")
													)
						search_report_grid.set_item (4, 
													row_count, 
													new_label_item (l_item.path)
													)
						k := 0
					else
						l_text_item ?= l_item
						if l_text_item /= Void then
							k := k + 1
							if i /= 0 then
								search_report_grid.insert_new_row_parented (row_count, search_report_grid.row (i))
								search_report_grid.row (row_count).set_data (l_text_item)
							end
							if row_count > search_report_grid.row_count then
								search_report_grid.insert_new_row (row_count)
								search_report_grid.row (row_count).set_data (l_text_item)
							end
							search_report_grid.set_item (1, 
														row_count, 
														new_label_item ("Line " + l_text_item.line_number.out + ":")
														)
							search_report_grid.set_item (2,
														row_count, 
														new_label_item (replace_rnt_to_space (l_text_item.text))
														)
							search_report_grid.item (2, row_count).set_foreground_color (preferences.editor_data.operator_text_color)
							create l_grid_drawable_item
							l_grid_drawable_item.expose_actions.extend (agent expose_drawable_action (?, l_item, search_report_grid.row (row_count)))
							l_grid_drawable_item.set_required_width (font.string_width (l_text_item.context_text))
							search_report_grid.set_item (3, row_count, l_grid_drawable_item)
							search_report_grid.set_item (4, row_count, new_label_item (l_item.path))
							if not l_text_item.captured_submatches.is_empty then
								submatch_parent := row_count
								search_report_grid.row (row_count).ensure_expandable
								from
									l_text_item.captured_submatches.start
								until
									l_text_item.captured_submatches.after
								loop
									row_count := row_count + 1
									search_report_grid.insert_new_row_parented (row_count, search_report_grid.row (submatch_parent))
									search_report_grid.set_item (1, 
																row_count, 
																new_label_item ("Capture " + 
																				l_text_item.captured_submatches.index.out + 
																				": " + 
																				l_text_item.captured_submatches.item))
									l_text_item.captured_submatches.forth								
								end
							end
						end
					end
					row_count := row_count + 1
					arrayed_list.forth
				end
				if i /= 0 then
					search_report_grid.set_item (2, i, new_label_item (k.out))
					search_report_grid.item (2, i).set_foreground_color (preferences.editor_data.number_text_color)
				end
				multi_search_performer.go_i_th (x)
			end
			adjust_grid_column_width
		end
		
	adjust_grid_column_width is
			-- Adjust grid column width to best fit visible area.
		local
			i: INTEGER
			l_grid_width: INTEGER
			col : EV_GRID_COLUMN
			full_width: INTEGER
			temp_width: INTEGER
			l_width: INTEGER
		do
			if search_report_grid.row_count /= 0 then
				from
					i := 1
				until
					i > search_report_grid.column_count
				loop
					col := search_report_grid.column (i)
					full_width := full_width + col.required_width_of_item_span (1, col.parent.row_count)
					i := i + 1
				end			
				l_grid_width := search_report_grid.width
				from
					i := 1
				until
					i > search_report_grid.column_count
				loop
					col := search_report_grid.column (i)
					temp_width := col.required_width_of_item_span (1, col.parent.row_count)
					l_width := (((temp_width) / full_width) * l_grid_width).floor
					if l_width > temp_width then
						l_width := temp_width
					end
					l_width := l_width + column_border_space
					col.set_width (l_width)
					i := i + 1
				end				
			end
		end
	
	grid_row_selected (a_row: EV_GRID_ROW) is
			-- Invoke when a row of the report grid selected
		require
			a_row_not_void: a_row /= Void
		local
			l_item: MSR_ITEM
			l_text_item: MSR_TEXT_ITEM
			l_editor: EB_EDITOR
		do
			if a_row.parent /= Void and then a_row.parent_row /= Void and then a_row.parent_row.is_expandable and then not a_row.parent_row.is_expanded then
				a_row.parent_row.expand
			end
			l_item ?= a_row.data
			if l_item /= Void then
				multi_search_performer.start
				multi_search_performer.search (l_item)
				if multi_search_performer.is_search_launched and then not multi_search_performer.off then
					check_class_file
					new_search_set := false
					l_text_item ?= multi_search_performer.item
					if l_text_item /= Void then
						if not is_item_source_changed (l_text_item) then
							if old_editor /= Void then
								l_editor := old_editor
							else
								l_editor := editor
							end
							if l_text_item.end_index_in_unix_text + 1 > l_text_item.start_index_in_unix_text then
								if l_editor.text_is_fully_loaded then
									l_editor.select_region (l_text_item.start_index_in_unix_text, l_text_item.end_index_in_unix_text + 1)
								end
							elseif l_text_item.end_index_in_unix_text + 1 = l_text_item.start_index_in_unix_text then
								l_editor.text_displayed.cursor.go_to_position (l_text_item.end_index_in_unix_text + 1)
								l_editor.deselect_all
							end
							if l_editor.has_selection then
								l_editor.show_selection (False)
							end
							l_editor.refresh_now
						end
					end
				end
			end
		end
	
	is_item_source_changed (a_item: MSR_TEXT_ITEM): BOOLEAN is
			-- Source in a_item changed?
		require
			a_item_attached: a_item /= Void
		local
			l_class_i: CLASS_I
		do
			l_class_i ?= a_item.data
			if l_class_i /= Void then
				Result := is_text_changed_in_editor or a_item.date /= l_class_i.date
			else
				Result := true
			end
		end		
	
	select_current_row is
			-- Select current row in the grid
		require
			search_launched: multi_search_performer.is_search_launched
		local
			l_row: EV_GRID_ROW
			l_row_index: INTEGER
			l_selected_rows: ARRAYED_LIST [EV_GRID_ROW]
		do
			if not multi_search_performer.off then
				l_row := grid_row_by_data (search_report_grid, multi_search_performer.item)	
			end
			if l_row /= Void then
				l_row_index := l_row.index
			elseif search_report_grid.row_count > 0 then
				l_row_index := 1
			end
			l_selected_rows := search_report_grid.selected_rows
			if not l_selected_rows.is_empty then
				(l_selected_rows @ 1).disable_select
			end
			search_report_grid.select_row (l_row_index)
		end
		
	select_and_show is
			-- Select and show in the editor
		do
			if multi_search_performer.is_search_launched and then not multi_search_performer.off then
				check_class_file
				if multi_search_performer.is_search_launched and then not multi_search_performer.off then	
					select_in_current_editor
					select_current_row
				end
			end
		end
		
	select_in_current_editor is
			-- Select in the editor
		local
			l_text_item: MSR_TEXT_ITEM
		do
			if multi_search_performer.is_search_launched and then not multi_search_performer.off then
				check_class_file
				if multi_search_performer.is_search_launched and then not multi_search_performer.off then	
					l_text_item ?= multi_search_performer.item
					if l_text_item /= Void then
						if l_text_item.end_index_in_unix_text + 1 > l_text_item.start_index_in_unix_text then
							if editor.text_is_fully_loaded then
								editor.select_region (l_text_item.start_index_in_unix_text, l_text_item.end_index_in_unix_text + 1)
							end
						elseif l_text_item.end_index_in_unix_text + 1 = l_text_item.start_index_in_unix_text then
							editor.text_displayed.cursor.go_to_position (l_text_item.end_index_in_unix_text + 1)
							editor.deselect_all
						end
						if editor.has_selection then
							editor.show_selection (False)
						end					
						editor.refresh_now
					end
				end
			end
		end
	
	grid_row_by_data (a_grid: ES_GRID; a_data: ANY) : EV_GRID_ROW is
			-- Find a row in a_grid that include a_data
		local
			i: INTEGER
			l_row: EV_GRID_ROW
			loop_end: BOOLEAN
		do
			loop_end := false
			from
				i := 1
			until
				i > a_grid.row_count or loop_end
			loop
				l_row := a_grid.row (i)
				if l_row.data /= Void and then l_row.data = a_data then
					Result := l_row
					loop_end := true
				end
				i := i + 1
			end
		end
		
		
	new_search_set: BOOLEAN
			-- Will a new search be launched? (Incremental search excluded)
	
	old_search_key_value: STRING
			-- Last search keyword.
	
	old_editor: EB_EDITOR
			-- In which last search did.
	
	temp_reverse: BOOLEAN
			-- Go upwards or forwards to next match in report?
		
	is_class_i_editing (a_class : CLASS_I): BOOLEAN is
			-- If class_i is being edited in the editor.
		require
			a_class_not_void: a_class /= Void
		local
			l: LIST [EB_DEVELOPMENT_WINDOW]
			unchanged_editor, changed_editor: EB_DEVELOPMENT_WINDOW
			l_editor: EB_SMART_EDITOR
		do
			l := window_manager.development_windows_with_class (a_class.name) 
			if not l.is_empty then
				from
					l.start
				until
					l.after
				loop
					l_editor := l.item.editor_tool.text_area
					l.item.window.set_pointer_style (default_pixmaps.wait_cursor)
					from
						process_events_and_idle
					until
						editor.text_is_fully_loaded
					loop
						ev_application.idle_actions.call ([])
					end
					l.item.window.set_pointer_style (default_pixmaps.standard_cursor)
					if l_editor.is_editable then
						if l.item.changed then
							changed_editor := l.item
						else
							unchanged_editor := l.item
						end
					end
					l.forth
				end
				if changed_editor /= Void then
					Result := true
				elseif unchanged_editor /= Void then
					Result := true
				else
					Result := false
				end
			else
				Result := false
			end
		end
		
	update_combo_box_specific (box: EV_COMBO_BOX; word: STRING) is
			-- Add word to combo box list.
		local
			l: LIST[STRING]
		do
			l := box.strings
			if l /= Void then
				l.compare_objects
			end
			if l = Void or else not l.has (word) then
				if box.count = search_history_size then
					box.start
					box.remove
				end
				box.extend (create {EV_LIST_ITEM}.make_with_text (word))
			end
			if box.text.is_empty or else not word.is_equal (box.text) then
				box.set_text (word)
			end
		end
		
	replace_all is
			-- Replace all matches in specified scale.
		local
			editor_replace_strategy: MSR_REPLACE_IN_ESTUDIO_STRATEGY
		do
			manager.window.set_pointer_style (default_pixmaps.wait_cursor)	
			currently_replacing := replace_combo_box.text					
			if 
				new_search_set or else
				not multi_search_performer.is_search_launched
			then
				search_button_clicked
			end
			if multi_search_performer.is_search_launched then
				create editor_replace_strategy.make (editor.dev_window.editor_tool.text_area)
				multi_search_performer.set_replace_strategy (editor_replace_strategy)
				multi_search_performer.set_replace_string (currently_replacing)
				multi_search_performer.replace_all
				update_combo_box_specific (replace_combo_box, currently_replacing)
				redraw_grid
				new_search_set := false
			end
			manager.window.set_pointer_style (default_pixmaps.standard_cursor)
		end

end
