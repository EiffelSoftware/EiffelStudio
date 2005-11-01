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
			on_text_reset,
			on_text_fully_loaded
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
		
create
	make

feature {NONE} -- Initialization

	make (a_manager: EB_DEVELOPMENT_WINDOW) is
			-- Initialization
		do
			Precursor (a_manager)
			create multi_search_performer.make
			new_search_set := true
			is_text_new_loaded := true
			create changed_classes.make (0)
			create loaded_actions
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
			-- Grid header texts
	
	header_width: ARRAYED_LIST [INTEGER] is
			-- List of header width.
		once		
			create Result.make (4)
			Result.extend (label_font.string_width (grid_head_class) + column_border_space)
			Result.extend (label_font.string_width (grid_head_found) + column_border_space)
			Result.extend (label_font.string_width (grid_head_context) + column_border_space)
			Result.extend (label_font.string_width (grid_head_file_location) + column_border_space)
		end
	
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
			
	search_compiled_class_button: EV_CHECK_BUTTON
			-- Button to indicate if compiled classes will be searched.
			
	incremental_search_button: EV_CHECK_BUTTON
			-- Button to control incremental search.
			
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
		
	is_incremental_search: BOOLEAN is
			-- Is incremental search enabled?
		do
			Result := incremental_search_button.is_selected
		end
		
	is_sub_cluster_searched: BOOLEAN is
			-- Are subclusters searched?
		do
			Result := search_subcluster_button.is_selected	
		end
		
	is_current_editor_searched: BOOLEAN is
			-- Is current editor searched?
		do
			Result := current_editor_button.is_selected	
		end		
	
	only_compiled_class_searched: BOOLEAN is
			-- Only compiled classes are searched?
		do
			Result := search_compiled_class_button.is_selected
		end
		
	item_selected (a_editor: EB_EDITOR): BOOLEAN is
			-- If item in report is selected in a_editor.
		local
			l_text_item: MSR_TEXT_ITEM
		do
			if multi_search_performer.is_search_launched and not multi_search_performer.off then
				l_text_item ?= multi_search_performer.item
				if 	
					l_text_item /= Void and then
					is_current_editor_searched implies old_editor = editor and 
					a_editor.text_displayed.selection_start.pos_in_text = l_text_item.start_index_in_unix_text and
					a_editor.text_displayed.selection_end.pos_in_text = l_text_item.end_index_in_unix_text + 1
				then
					Result := true
				end
			end
		end

feature -- Status setting

	force_new_search is
			-- Force new search.
		do
			new_search_set := true
		end
		
	enable_incremental_search is
			-- Enable incremental search.
		do
			incremental_search_button.enable_select
		end
			
	disable_incremental_search is
			-- Disable increamental search	
		do
			incremental_search_button.disable_select
		end

feature -- Action

	go_to_next_found is
			-- Highlight next found item if possible, possibly go back.
			-- If search is not launched, launch it.
		do
			if new_search_set or (old_editor /= editor and is_current_editor_searched) then
				force_new_search
				dispatch_search
			else
				extend_and_run_loaded_action (agent go_to_next_found_perform (reverse))
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
			l_item: MSR_TEXT_ITEM
			l_start: INTEGER
			l_end: INTEGER
			l_class_i : CLASS_I
			l_check: BOOLEAN
		do			
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
				 	 	l_check := true
				 	 end
				 end
			end
			if editor.number_of_lines /= 0 then
				if editor.is_editable then	
					if not multi_search_performer.off and not multi_search_performer.is_empty then
						l_item ?= multi_search_performer.item
						if l_item /= Void and then not is_item_source_changed (l_item) then
							if l_check then
								check_class_file_and_do (agent replace_current_perform)
							else
								extend_and_run_loaded_action (agent replace_current_perform)
							end
							extend_and_run_loaded_action (agent go_to_next_found)
							extend_and_run_loaded_action (agent redraw_grid)
							extend_and_run_loaded_action (agent select_current_row)
							extend_and_run_loaded_action (agent force_not_changed)
						end
					end
				else
					editor.display_not_editable_warning_message
				end
			end
		end
		
	confirm_and_replace_all is
			-- Ask for confirmation, then replace all.
		local
			cd: STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
			hindered: BOOLEAN
		do
			if is_current_editor_searched then
				if not editor.is_editable then
					hindered := true
					editor.display_not_editable_warning_message
				end				
			end
			if not hindered then
				create cd.make_initialized (3, preferences.dialog_data.confirm_replace_all_string, warning_messages.w_replace_all, interface_names.l_Discard_replace_all_warning_dialog, preferences.preferences)
				cd.set_ok_action (agent replace_all)
				cd.show_modal_to_window (window_manager.last_focused_development_window.window)	
			end
		end

feature {NONE} -- Implementation

	replace_current_perform is
			-- Do actual `replace_current'.
		local
			editor_replace_strategy: MSR_REPLACE_IN_ESTUDIO_STRATEGY
		do
			create editor_replace_strategy.make (editor)
			currently_replacing := replace_combo_box.text
			multi_search_performer.set_replace_strategy (editor_replace_strategy)
			multi_search_performer.set_replace_string (currently_replacing)
			multi_search_performer.replace
			update_combo_box_specific (replace_combo_box, currently_replacing)
			force_not_changed
		end
		
	go_to_next_found_perform (b: BOOLEAN) is
			-- Do actual `go_to_next_found'. 
		local
			l_list: LIST [CLASS_I]
			l_class_i: CLASS_I
			l_pos: INTEGER
			l_text: EDITABLE_TEXT
		do
			if multi_search_performer.is_search_launched and then not multi_search_performer.item_matched.is_empty then
				if manager.class_name /= Void then
					l_list := manager.eiffel_universe.classes_with_name (manager.class_name)
					if not l_list.is_empty then
						l_class_i := l_list.first
					end
				end
				l_text := editor.text_displayed
				if editor.text_displayed.has_selection then
					if b then
						l_pos := l_text.selection_start.pos_in_text
					else
						l_pos := l_text.selection_end.pos_in_text
					end					
				elseif l_text.cursor /= Void then
					l_pos := l_text.cursor.pos_in_characters
				end
				multi_search_performer.go_to_closest_item (l_pos, b, l_class_i, is_main_editor or not is_current_editor_searched)
			end
		end
	
	check_class_file is
			-- Check if class of current selected item is loaded. If not, load it.
			-- After check run `a_pro'.
		local
			l_item: MSR_ITEM
			l_list: LIST [CLASS_I]
			class_name: STRING
		do
			if not multi_search_performer.off then
				l_item := multi_search_performer.item
				create class_name.make_from_string (l_item.class_name)
				class_name.to_upper
				l_list := manager.eiffel_universe.classes_with_name (class_name)
				if manager.class_name /= Void and then not manager.class_name.is_equal (l_item.class_name) then
					if not l_list.is_empty then
						manager.set_stone (stone_from_class_i (l_list.first))
						is_text_changed_in_editor := false
					end
				elseif not is_current_editor_searched then
					manager.set_stone (stone_from_class_i (l_list.first))
--					is_text_changed_in_editor := false
				end
				if not is_current_editor_searched then
					manager.editor_tool.text_area.set_focus
				end
			end
		end
		
	extend_and_run_loaded_action (a_pro: PROCEDURE [ANY, TUPLE]) is
			-- Insert `a_pro' to loaded_actions and run all actions in it.
		local
			l_pro: PROCEDURE [ANY, TUPLE]
		do
			loaded_actions.extend (a_pro)
			if editor.text_is_fully_loaded then
				block_actions
				from
					loaded_actions.start
				until
					loaded_actions.count = 0
				loop
					l_pro := loaded_actions.item
					loaded_actions.remove
					l_pro.call ([])
				end
				resume_actions
			end
		end
		
	check_class_file_and_do (a_pro: PROCEDURE [ANY, TUPLE]) is
			-- Check class before insert `a_pro' to loaded_actions and run all actions in it.
		do
			extend_and_run_loaded_action (agent check_class_file)
			extend_and_run_loaded_action (a_pro)
		end		
		
	loaded_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions that are invoked sequently when text is fully loaded
	
	on_text_fully_loaded is
			-- Text observer, runs when text is fully loaded.
		do
			Precursor {EB_SEARCH_TOOL}
			if not loaded_actions.is_empty then
				loaded_actions.call ([])
				loaded_actions.wipe_out
			end
			if is_current_editor_searched then
				force_new_search
			end
--			is_text_changed_in_editor := true
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
			Result.set_pos_container (manager.managed_main_formatters.first)
		end		
	
	search_button_clicked is
			-- Invokes when search button is clicked.
		do
			if new_search_set or not multi_search_performer.is_search_launched then
				dispatch_search
				select_and_show
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
			if is_scoped then
				scope.enable_sensitive
			else
				scope.disable_sensitive
			end
			if is_whole_project_searched or is_scoped then
				search_compiled_class_button.enable_sensitive
			else
				search_compiled_class_button.disable_sensitive
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
				
				-- Option "Incremental search"
			create incremental_search_button.make_with_text ("Have not added to search panel")
			incremental_search_button.enable_select
			
				-- Option "Current Editor"		
			create current_editor_button.make_with_text (Interface_names.l_Current_editor)
			current_editor_button.key_press_actions.extend (agent key_pressed (?, True))
			current_editor_button.select_actions.extend (agent toggle_scope_detail)
			current_editor_button.select_actions.extend (agent force_new_search)

				-- Option "Whole Project"
			create whole_project_button.make_with_text (Interface_names.l_Whole_project)
			whole_project_button.key_press_actions.extend (agent key_pressed (?, True))
			whole_project_button.select_actions.extend (agent toggle_scope_detail)
			whole_project_button.select_actions.extend (agent force_new_search)
				
				-- Option "Scope"
			create scope_button.make_with_text (Interface_names.l_Scope)
			scope_button.key_press_actions.extend (agent key_pressed (?, True))
			scope_button.select_actions.extend (agent toggle_scope_detail)
			scope_button.select_actions.extend (agent force_new_search)
			scope_button.drop_actions.extend (agent on_drop_scope_button (?))		
			
				-- Option "Subcluster"
			create search_subcluster_button.make_with_text (Interface_names.l_Sub_clusters)
			search_subcluster_button.key_press_actions.extend (agent key_pressed (?, True))
			search_subcluster_button.enable_select
			search_subcluster_button.select_actions.extend (agent force_new_search)
			
				-- Option "Compiled class"
			create search_compiled_class_button.make_with_text (Interface_names.l_Compiled_class)
			search_compiled_class_button.key_press_actions.extend (agent key_pressed (?, True))
			search_compiled_class_button.select_actions.extend (agent force_new_search)
			
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
			vbox.set_padding_width (2)
			vbox.extend (case_sensitive_button)
			vbox.extend (whole_word_button)
			vbox.extend (use_regular_expression_button)
			vbox.extend (search_backward_button)
			vbox.disable_item_expand (case_sensitive_button)
			vbox.disable_item_expand (whole_word_button)
			vbox.disable_item_expand (use_regular_expression_button)
			vbox.disable_item_expand (search_backward_button)

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
			
			create scope
			create vbox
			vbox.set_border_width (5)
			vbox.set_padding_width (2)
			vbox.extend (current_editor_button)
			vbox.extend (whole_project_button)
			vbox.extend (scope_button)
			vbox.extend (search_compiled_class_button)
			vbox.disable_item_expand (current_editor_button)
			vbox.disable_item_expand (whole_project_button)
			vbox.disable_item_expand (scope_button)
			vbox.disable_item_expand (search_compiled_class_button)	
			hbox.extend (vbox)
			hbox.disable_item_expand (vbox)
			
			
			create vbox
			vbox.set_border_width (5)
			vbox.extend (scope_list)
			scope_list.set_minimum_width (150)

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
			
			current_editor_button.enable_select
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
	
	summary_label : EV_LABEL
			-- Label to show search summary.
		
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
			create summary_label.default_create
			hbox.extend (summary_label)
			hbox.disable_item_expand (summary_label)
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
			search_report_grid.row_select_actions.extend (agent on_grid_row_selected (?))
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
		
	dispatch_search is
			-- Dispatch search.
		do
			if is_whole_project_searched then
				search_whole_project
			elseif is_scoped then
				search_in_scope
			else
				if shown then
					if search_button.is_sensitive then
						if new_search_set or not multi_search_performer.is_search_launched then
							search
						end
						if not editor.has_focus then
							editor.set_focus
						end
					end
				else
					if new_search_set or not multi_search_performer.is_search_launched then
						default_search
					end
				end
			end
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
				if editor.text_displayed.reading_text_finished then
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
						incremental_search_strategy.set_date (class_i.date)	
					end
					if manager.class_name /= Void then
						incremental_search_strategy.set_class_name (manager.class_name)
					end				
					multi_search_performer.set_search_strategy (incremental_search_strategy)
					multi_search_performer.do_search
					multi_search_performer.start
					force_new_search
	--				changed_classes.wipe_out
				end
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
				if not is_main_editor then
					create file_name.make_from_string ("-")
				end
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
					text_strategy.set_date (class_i.date)	
				end
				multi_search_performer.do_search
				update_combo_box_specific (keyword_field, currently_searched)
				after_search
				extend_and_run_loaded_action (agent go_to_next_found_perform (reverse))
--				check_class_file_and_do
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
						text_strategy.set_date (class_i.date)	
					end
					multi_search_performer.do_search
					update_combo_box_specific (keyword_field, currently_searched)
					after_search
					extend_and_run_loaded_action (agent go_to_next_found_perform (reverse))
--					check_class_file_and_do
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
			currently_searched := keyword_field.text
			create l_project_strategy.make (currently_searched, surrounding_text_number, clusters_in_the_project, only_compiled_class_searched)
			if is_case_sensitive then
				l_project_strategy.set_case_sensitive
			else
				l_project_strategy.set_case_insensitive
			end 
			l_project_strategy.set_regular_expression_used (is_regular_expression_used)
			l_project_strategy.set_whole_word_matched (is_whole_word_matched)
			multi_search_performer.set_search_strategy (l_project_strategy)
			multi_search_performer.do_search
			update_combo_box_specific (keyword_field, currently_searched)
			after_search
			old_editor := Void
			extend_and_run_loaded_action (agent go_to_next_found_perform (reverse))
			manager.window.set_pointer_style (default_pixmaps.standard_cursor)
		end
	
	search_in_scope is
			-- Search in scope.
		local
			l_scope_strategy: MSR_SEARCH_IN_SCOPE_STRATEGY
		do
			manager.window.set_pointer_style (default_pixmaps.wait_cursor)
			currently_searched := keyword_field.text
			create l_scope_strategy.make (currently_searched, surrounding_text_number, scope_list, only_compiled_class_searched)
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
			extend_and_run_loaded_action (agent go_to_next_found_perform (reverse))
			manager.window.set_pointer_style (default_pixmaps.standard_cursor)
		end		
		
	after_search is
			-- When a search done, go here. Incremental search excluded.
		do
			if multi_search_performer.is_search_launched then
				old_search_key_value := currently_searched				
				old_editor := editor
				redraw_grid
				changed_classes.wipe_out
				extend_and_run_loaded_action (agent force_not_changed)
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
		local
			l_class_stone: CLASSI_STONE
		do
			force_new_search
			is_text_changed_in_editor := true
			if is_text_new_loaded and then multi_search_performer.is_search_launched and then not multi_search_performer.is_empty then
				l_class_stone ?= manager.stone
				if l_class_stone /= Void then
					changed_classes.extend (l_class_stone.actual_class_i)
				end
				is_text_new_loaded := false
			end
		end

	on_text_reset is
			-- Obsever reset action.
		do
			is_text_changed_in_editor := false
			is_text_new_loaded := true
		end
		
	is_text_changed_in_editor: BOOLEAN
			-- Text changed in the editor?
			
	is_text_new_loaded: BOOLEAN
			-- Text loaded in the editor?
	
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
					l_list := manager.eiffel_universe.classes_with_name (l_class_name)
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
				if not editor.is_empty and then is_incremental_search then
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
					vertical_text_offset_into_available_space := client_height - text_height - 1
					if label_item.is_top_aligned then
						vertical_text_offset_into_available_space := 0
					elseif label_item.is_bottom_aligned then
					else
						vertical_text_offset_into_available_space := vertical_text_offset_into_available_space // 2
					end
					vertical_text_offset_into_available_space := vertical_text_offset_into_available_space.max (0)
					adjust_vertical := vertical_text_offset_into_available_space + label_item.top_border
				end					
			end			
		end
		
	new_label_item (a_string: STRING): EV_GRID_LABEL_ITEM is
			-- Create uniformed label item
		require
			string_attached: a_string /= Void
		local
			l_color: EV_COLOR
		do
			create Result.make_with_text (a_string)
			l_color := search_report_grid.background_color
			Result.set_foreground_color (row_text_color (l_color))
		ensure
			new_item_not_void: Result /= Void
		end
		
	label_font: EV_FONT is
			-- Font of report text.
		local
			l_label: EV_LABEL
		once
			create l_label
			Result := l_label.font
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
			l_color, focused_sel_color, non_focused_sel_color: EV_COLOR
			font: EV_FONT
			l_item: MSR_TEXT_ITEM
		do
			font := label_font
			focused_sel_color := search_report_grid.focused_selection_color
			non_focused_sel_color := search_report_grid.non_focused_selection_color
			if adjust_vertical = 0 then
				compute_adjust_vertical (font, query_grid_row.item (1))
			end
			drawable.clear
			drawable.set_font (font)		
			row_selected := query_grid_row.is_selected
			focused := search_report_grid.has_focus
			if row_selected then
				if focused then
					drawable.set_foreground_color(focused_sel_color)
				else
					drawable.set_foreground_color(non_focused_sel_color)
				end
			else
				drawable.set_foreground_color (search_report_grid.background_color)
			end
			l_color := row_text_color (drawable.foreground_color)
			
			drawable.fill_rectangle (0, 0, drawable.width,drawable.height)
			l_item ?= a_item
			if l_item /= Void then
				drawable.set_foreground_color (l_color)
				drawable.draw_text_top_left (0, adjust_vertical, 
											l_item.context_text.substring (1, l_item.start_index_in_context_text - 1))
				if not row_selected then
					drawable.set_foreground_color (preferences.editor_data.operator_text_color)
				end
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
		
	row_text_color (a_bg_color: EV_COLOR): EV_COLOR is
			-- Text color according to its background color `a_bg_color'
		require
			bg_color_attached: a_bg_color  /= Void
		do
			if a_bg_color.lightness > 0.6 then
				create Result.make_with_rgb (0, 0, 0)
			else
				create Result.make_with_rgb (1, 1, 1)
			end
		end
		
	redraw_grid is
			-- Redraw grid according to search result and refresh summary label.
		local
			l_index: INTEGER
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
			font: EV_FONT
			l_new_row: EV_GRID_ROW
		do
			if multi_search_performer.is_search_launched then
				search_report_grid.remove_and_clear_all_rows
				summary_label.set_text ("   " +
										multi_search_performer.text_found_count.out + 
										" found(s) in " + 
										multi_search_performer.class_count.out + 
										" class(es)")
				
				l_index := multi_search_performer.index
				font := label_font
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
						l_new_row := search_report_grid.row (row_count)
						l_new_row.set_data (l_class_item)
						if i /= 0 then
							search_report_grid.set_item (2, i, new_label_item (k.out))
							search_report_grid.item (2, i).set_foreground_color (preferences.editor_data.number_text_color_preference.value)
							extend_pointer_actions (search_report_grid.row (i))
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
													new_label_item (once "-"))
						search_report_grid.set_item (4, 
													row_count, 
													new_label_item (l_item.path))
						k := 0
					else
						l_text_item ?= l_item
						if l_text_item /= Void then
							k := k + 1
							if i /= 0 then
								search_report_grid.insert_new_row_parented (row_count, search_report_grid.row (i))
								l_new_row := search_report_grid.row (row_count)
								l_new_row.set_data (l_text_item)
							end
							if row_count > search_report_grid.row_count then
								search_report_grid.insert_new_row (row_count)
								l_new_row := search_report_grid.row (row_count)
								l_new_row.set_data (l_text_item)
							end
							search_report_grid.set_item (1, 
														row_count, 
														new_label_item ("Line " + l_text_item.line_number.out + ":"))
							search_report_grid.set_item (2,
														row_count, 
														new_label_item (replace_rnt_to_space (l_text_item.text)))
							search_report_grid.item (2, row_count).set_foreground_color (preferences.editor_data.operator_text_color)
							create l_grid_drawable_item
							search_report_grid.set_item (3, row_count, l_grid_drawable_item)
							l_grid_drawable_item.expose_actions.extend (agent expose_drawable_action (?, l_item, search_report_grid.row (row_count)))
							l_grid_drawable_item.set_required_width (font.string_width (l_text_item.context_text))
							search_report_grid.set_item (4, row_count, new_label_item (l_item.path))
							extend_pointer_actions (l_new_row)
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
				multi_search_performer.go_i_th (l_index)
			end
			adjust_grid_column_width
		end

	extend_pointer_actions (a_row: EV_GRID_ROW) is
			-- Extend pointer actions to every row item.
		require
			a_row_attached: a_row /= Void
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > a_row.count
			loop
				a_row.item (i).pointer_button_press_actions.extend (agent on_grid_row_clicked (?, ?, ?, ?, ?, ?, ?, ?, a_row))
				i := i + 1
			end
		end
		
	on_grid_row_clicked (a, b, c : INTEGER; d, e, f: DOUBLE; g, h: INTEGER; a_row: EV_GRID_ROW) is
			-- A row is clicked by mouse pointer.
		do
			if not search_report_grid.selected_rows.is_empty then
				if search_report_grid.selected_rows.first = a_row then
					on_grid_row_selected (a_row)
				end
			end
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
			l_required_width: ARRAYED_LIST [INTEGER]
		do
			if search_report_grid.row_count /= 0 then
				create l_required_width.make (search_report_grid.column_count)
				from
					i := 1
				until
					i > search_report_grid.column_count
				loop
					col := search_report_grid.column (i)
					l_required_width.extend (col.required_width_of_item_span (1, col.parent.row_count))
					full_width := full_width + (header_width @ i).max (l_required_width @ i)
					i := i + 1
				end			
				l_grid_width := search_report_grid.width
				from
					i := 1
				until
					i > search_report_grid.column_count
				loop
					col := search_report_grid.column (i)
					temp_width := (header_width @ i).max (l_required_width @ i)
					l_width := ((temp_width / full_width) * l_grid_width).floor
					if l_width > temp_width then
						l_width := temp_width
					end
					l_width := l_width + column_border_space
					col.set_width (l_width)
					i := i + 1
				end				
			end
		end
	
	on_grid_row_selected (a_row: EV_GRID_ROW) is
			-- Invoke when a row of the report grid selected
		require
			a_row_not_void: a_row /= Void
		local
			l_item: MSR_ITEM
		do
			if a_row.parent /= Void and then a_row.parent_row /= Void and then a_row.parent_row.is_expandable and then not a_row.parent_row.is_expanded then
				a_row.parent_row.expand
				adjust_grid_column_width
			end
			l_item ?= a_row.data
			if l_item /= Void then
				multi_search_performer.start
				multi_search_performer.search (l_item)
				if multi_search_performer.is_search_launched and then not multi_search_performer.off then
					check_class_file_and_do (agent on_grid_row_selected_perform)
				end
			end
		end
		
	on_grid_row_selected_perform is
			-- Do actual `on_grid_row_selected'
		local
			l_text_item: MSR_TEXT_ITEM
			l_editor: EB_EDITOR
		do
			new_search_set := false
			l_text_item ?= multi_search_performer.item
			if l_text_item /= Void then
				if not is_main_editor or not is_item_source_changed (l_text_item) then
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
	
	is_item_source_changed (a_item: MSR_TEXT_ITEM): BOOLEAN is
			-- Source in a_item changed?
		require
			a_item_attached: a_item /= Void
		local
			l_class_i: CLASS_I
		do
			l_class_i ?= a_item.data
			if l_class_i /= Void then	
				Result := is_text_changed_in_editor or a_item.date /= l_class_i.date or changed_classes.has (l_class_i)
			else
				Result := true
			end
		end
		
	changed_classes: ARRAYED_LIST [CLASS_I]
			-- Keep a record of modified class by editor.
	
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
				check_class_file_and_do (agent select_and_show_perform)
			end
		end
	
	select_and_show_perform is 
			-- Do actual `select_and_show'.
		do
			if multi_search_performer.is_search_launched and then not multi_search_performer.off then	
				select_in_current_editor_perform
				select_current_row
			end
		end
		
	select_in_current_editor is
			-- Select in the editor
		do
			if multi_search_performer.is_search_launched and then not multi_search_performer.off then
				extend_and_run_loaded_action (agent select_in_current_editor_perform)
			end
		end
	
	select_in_current_editor_perform is
			-- Do actual `select_in_current_editor'.
		local
			l_text_item: MSR_TEXT_ITEM
		do
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
					if l_editor.is_editable and l.item /= Void then
						Result := true
					end
					l.forth
				end
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
				create editor_replace_strategy.make (manager.editor_tool.text_area)
				multi_search_performer.set_replace_strategy (editor_replace_strategy)
				multi_search_performer.set_replace_string (currently_replacing)
				multi_search_performer.replace_all
				update_combo_box_specific (replace_combo_box, currently_replacing)
				redraw_grid
				extend_and_run_loaded_action (agent force_not_changed)
			end
			manager.window.set_pointer_style (default_pixmaps.standard_cursor)
		end
		
	is_main_editor: BOOLEAN is
			-- Is `editor' main editor?
		do
			Result := (manager.editor_tool.text_area = editor)
		end

	force_not_changed is
			-- Set `new_search' and `is_text_changed_in_editor' to false.
		do
			new_search_set := false
			is_text_changed_in_editor := false
		end
		
	block_actions is
			-- Block actions.
		do
			keyword_field.change_actions.block
			replace_combo_box.key_press_actions.block
			replace_check_button.key_press_actions.block
			case_sensitive_button.key_press_actions.block
			whole_word_button.key_press_actions.block
			use_regular_expression_button.key_press_actions.block
			search_backward_button.key_press_actions.block
			current_editor_button.key_press_actions.block
			whole_project_button.key_press_actions.block
			scope_button.key_press_actions.block
			search_subcluster_button.key_press_actions.block
			search_compiled_class_button.key_press_actions.block
			scope_list.key_press_actions.block
			search_button.select_actions.block
			replace_button.select_actions.block
			replace_all_click_button.select_actions.block
		end
		
	resume_actions is
			-- Resume actions.
		do
			keyword_field.change_actions.resume
			replace_combo_box.key_press_actions.resume
			replace_check_button.key_press_actions.resume
			case_sensitive_button.key_press_actions.resume
			whole_word_button.key_press_actions.resume
			use_regular_expression_button.key_press_actions.resume
			search_backward_button.key_press_actions.resume
			current_editor_button.key_press_actions.resume
			whole_project_button.key_press_actions.resume
			scope_button.key_press_actions.resume
			search_subcluster_button.key_press_actions.resume
			search_compiled_class_button.key_press_actions.resume
			scope_list.key_press_actions.resume
			search_button.select_actions.resume
			replace_button.select_actions.resume
			replace_all_click_button.select_actions.resume
		end

end -- class EB_MULTI_SEARCH_TOOL
