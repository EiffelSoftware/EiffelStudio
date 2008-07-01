indexing
	description	: "Tool to search and replace a string in groups, classes or editor"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	ES_MULTI_SEARCH_TOOL_PANEL

inherit

	ES_MULTI_SEARCH_TOOL_PANEL_IMP
		redefine
			make,
			reverse,
			internal_recycle,
			build_docking_content,
			attach_to_docking_manager
		end

	EB_SHARED_MANAGERS
		export
			{NONE} all
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
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end

	EIFFEL_PROJECT_FACILITIES
		export
			{NONE} all
		end

	EB_SEARCH_OPTION_OBSERVER_MANAGER
		export
			{NONE} all
		end

	EB_SEARCH_OPTION_OBSERVER
		export
			{NONE} all
		end

	EV_KEY_CONSTANTS
		export
			{NONE} all
		end

	TEXT_OBSERVER
		rename
			set_manager as set_text_observer_manager
		redefine
			on_text_edited,
			on_text_reset,
			on_text_fully_loaded
		end

create
	make

feature {NONE} -- Initialization

	make (a_manager: EB_DEVELOPMENT_WINDOW; a_tool: like tool_descriptor) is
			-- Initialization
		do
			Precursor (a_manager, a_tool)
			create multi_search_performer.make
			new_search_set := True
			is_text_new_loaded := True
			check_class_succeed := True
			create changed_classes.make (0)
			build_actions
			prepare_interface
			switch_mode
			incremental_search_start_pos := 1
			add_observer (Current)
		end

	build_actions is
			-- Build actions
		do
			search_button.select_actions.extend (agent new_search)
			search_button.key_press_actions.extend (agent handle_enter_on_button (?, agent new_search))

			keyword_field.change_actions.extend (agent enable_disable_search_button)
			keyword_field.key_press_actions.extend (agent key_pressed (?, True))
			keyword_field.drop_actions.extend (agent display_stone_signature (keyword_field, ?))
			keyword_field.focus_in_actions.extend (agent focusing_keyword_field)

			replace_combo_box.key_press_actions.extend (agent key_pressed (?, False))
			replace_combo_box.drop_actions.extend (agent display_stone_signature (replace_combo_box, ?))

			replace_button.select_actions.extend (agent replace_current)
			replace_button.key_press_actions.extend (agent handle_enter_on_button (?, agent replace_current))

			case_sensitive_button.key_press_actions.extend (agent key_pressed (?, True))
			case_sensitive_button.select_actions.extend (agent force_new_search)
			case_sensitive_button.select_actions.extend (agent check_button_changed (case_sensitive_button))

			whole_word_button.key_press_actions.extend (agent key_pressed (?, True))
			whole_word_button.select_actions.extend (agent force_new_search)
			whole_word_button.select_actions.extend (agent check_button_changed (whole_word_button))

			use_regular_expression_button.key_press_actions.extend (agent key_pressed (?, True))
			use_regular_expression_button.select_actions.extend (agent force_new_search)
			use_regular_expression_button.select_actions.extend (agent check_button_changed (use_regular_expression_button))

			search_backward_button.key_press_actions.extend (agent key_pressed (?, True))
			search_backward_button.select_actions.extend (agent check_button_changed (search_backward_button))

			replace_all_click_button.select_actions.extend (agent confirm_and_replace_all)
			replace_all_click_button.key_press_actions.extend (agent handle_enter_on_button (?, agent confirm_and_replace_all))

			notebook.drop_actions.set_veto_pebble_function (agent notebook_veto_pebble)
			notebook.drop_actions.extend (agent on_drop_notebook)
			notebook.selection_actions.extend (agent on_notebook_selected)

			current_editor_button.key_press_actions.extend (agent key_pressed (?, True))
			current_editor_button.select_actions.extend (agent toggle_scope_detail (current_editor_button))
			current_editor_button.select_actions.extend (agent force_new_search)

			whole_project_button.key_press_actions.extend (agent key_pressed (?, True))
			whole_project_button.select_actions.extend (agent toggle_scope_detail (whole_project_button))
			whole_project_button.select_actions.extend (agent force_new_search)

			custom_button.key_press_actions.extend (agent key_pressed (?, True))
			custom_button.select_actions.extend (agent toggle_scope_detail (custom_button))
			custom_button.select_actions.extend (agent force_new_search)
			custom_button.drop_actions.extend (agent on_drop_custom_button (?))
			custom_button.drop_actions.set_veto_pebble_function (agent veto_pebble_function)

			search_subcluster_button.key_press_actions.extend (agent key_pressed (?, True))
			search_subcluster_button.select_actions.extend (agent force_new_search)

			search_compiled_class_button.key_press_actions.extend (agent key_pressed (?, True))
			search_compiled_class_button.select_actions.extend (agent force_new_search)

			scope_list.key_press_actions.extend (agent key_pressed (?, True))
			scope_list.drop_actions.extend (agent on_drop_add (?))
			scope_list.drop_actions.set_veto_pebble_function (agent veto_pebble_function)

			add_button.select_actions.extend (agent add_scope)
			add_button.drop_actions.extend (agent on_drop_add (?))
			add_button.drop_actions.set_veto_pebble_function (agent veto_pebble_function)

			remove_button.select_actions.extend (agent remove_scope)
			remove_button.drop_actions.extend (agent on_drop_remove (?))

			remove_all_button.select_actions.extend (agent remove_all)

					-- Report box
			report_tool.new_search_button.select_actions.extend (agent new_search)
			report_tool.expand_all_button.select_actions.extend (agent expand_all)
			report_tool.collapse_all_button.select_actions.extend (agent collapse_all)

			create loaded_actions
			create show_actions
			create bottom_reached_actions
			create first_result_reached_actions
		end

	build_report_box: EV_VERTICAL_BOX is
			-- Build a report.
		do
		end

feature -- Docking management

	attach_to_docking_manager (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Attach to docking manager
		do
			build_docking_content (a_docking_manager)

			check not_already_has: not a_docking_manager.has_content (content) end
			a_docking_manager.contents.extend (content)
		end

feature -- Access

	surrounding_text_number: INTEGER is 	20
			-- Maximal number of characters on one side of found text in the report.

	resized_columns_list: ARRAY [BOOLEAN] is
			-- List of boolean s for each column indicating if it has been user resizedat all.
		once
			Result := <<False, False, False, False>>
		end

	multi_search_performer: MSR
			-- Tool that actually performs the search

	editor: EB_EDITOR is
			-- current_editor
			-- Result is not only class text editors used by end user, but also maybe is the EB_SMART_EDITOR in Feature Relation Tool or Class Tool...
		do
			Result := develop_window.ui.current_editor
		end

	bottom_reached_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Get called when result reaches the bottom of a class.

	first_result_reached_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Get called when result reaches the one started.

	currently_searched: STRING_32
			-- String to be search

feature {EB_CUSTOM_WIDGETTED_EDITOR} -- Access

	currently_replacing: STRING_32
			-- String to be search

feature -- Status report

	item_selected (a_editor: EB_EDITOR): BOOLEAN is
			-- If item in report is selected in a_editor.
		local
			l_text_item: MSR_TEXT_ITEM
		do
			if multi_search_performer.is_search_launched and not multi_search_performer.off then
				l_text_item ?= multi_search_performer.item
				if
					l_text_item /= Void and then
					(is_current_editor_searched implies old_editor = editor) and
					(a_editor.text_displayed.selection_start.pos_in_text = l_text_item.start_index_in_unix_text) and
					(a_editor.text_displayed.selection_end.pos_in_text = l_text_item.end_index_in_unix_text + 1)
				then
					Result := True
				end
				if l_text_item = Void then
					Result := True
				end
			end
		end

	last_replaced_item: INTEGER
			-- Numbers of items replaced last time.

	last_replaced_class: INTEGER
			-- Numbers of classes replaced last time.

	reverse : BOOLEAN is
			-- Search upwards?
		do
			Result := Precursor {ES_MULTI_SEARCH_TOOL_PANEL_IMP} or temp_reverse
		end

feature -- Status setting

	set_current_searched (word: STRING_32) is
			-- Assign `word' to `currently_searched'
		do
			currently_searched := word
			if keyword_field /= Void then
				if keyword_field.text /= Void and then not keyword_field.text.is_empty then
					update_combo_box (keyword_field.text)
				end
				if word = Void or else word.is_empty then
					keyword_field.remove_text
				else
					keyword_field.set_text (word)
				end
			end
		end

	force_new_search is
			-- Force new search.
		do
			new_search_set := True
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

	set_focus is
			-- Give the focus to the pattern field
		do
			if notebook.selected_item_index /= 1 then
				notebook.select_item (notebook.i_th (1))
			end
			set_focus_if_possible (keyword_field)
		end

	show_and_set_focus_replace is
			-- Give the focus to replace field.
		do
			show
			if notebook.selected_item_index /= 1 then
				notebook.select_item (notebook.i_th (1))
			end
			set_focus_if_possible (replace_combo_box)
		end

	search_current_editor_only is
			-- Ensure that only current editor is searched.
		do
			current_editor_button.select_actions.block
			current_editor_button.enable_select
			toggle_scope_detail (current_editor_button)
			current_editor_button.select_actions.resume
		end

feature -- Action

	go_to_next_found is
			-- Highlight next found item if possible, possibly go back.
			-- If search is not launched, launch it.
		do
			if new_search_set or (old_editor /= editor and is_current_editor_searched) or (is_current_editor_searched and is_text_changed_in_editor) then
				force_new_search
				dispatch_search
				select_and_show
			else
				extend_and_run_loaded_action (agent go_to_next_found_perform (reverse))
				extend_and_run_loaded_action (agent go_to_next_found_select_and_show)
			end
		end

	go_to_previous_found is
			-- Highlight previous found item if possible.
			-- If search is not launched, launch it.
		do
			temp_reverse := True
			go_to_next_found
			temp_reverse := False
		end

	replace_current is
			-- Replace current match.
		local
			l_item: MSR_TEXT_ITEM
			l_start: INTEGER
			l_end: INTEGER
			l_class_i : CLASS_I
			l_check: BOOLEAN
			l_replaced: BOOLEAN
		do
			l_start := 0
			l_end := 1
			check_class_succeed := True
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
				(is_editor_ready and then editor.text_displayed.cursor /= Void and then
				(editor.text_displayed.cursor.pos_in_text > l_end or
				editor.text_displayed.cursor.pos_in_text < l_start)))
			then
				new_search_or_go_next
			end
			if multi_search_performer.is_search_launched and then not multi_search_performer.off then
				 l_class_i ?= multi_search_performer.item.data
				 if l_class_i /= Void then
				 	 if not is_class_i_editing (l_class_i) then
				 	 	l_check := True
				 	 end
				 end
			end
			if is_editor_ready and then editor.number_of_lines /= 0 then
				if editor.is_editable then
					if not multi_search_performer.off and not multi_search_performer.is_empty then
						l_item ?= multi_search_performer.item
						if l_item /= Void and then not is_item_source_changed (l_item) then
							if l_check then
								check_class_file_and_do (agent replace_current_perform)
							else
								extend_and_run_loaded_action (agent replace_current_perform)
							end
							l_replaced := True
							extend_and_run_loaded_action (agent go_to_next_found)
							extend_and_run_loaded_action (agent search_report_grid.redraw_grid)
							extend_and_run_loaded_action (agent select_current_row)
							extend_and_run_loaded_action (agent force_not_changed)
							extend_and_run_loaded_action (agent put_replace_report (False))
						end
					end
				else
					editor.display_not_editable_warning_message
				end
			end
			if not l_replaced then
				extend_and_run_loaded_action (agent put_replace_report (True))
			end
		end

	confirm_and_replace_all is
			-- Ask for confirmation, then replace all.
		local
			l_warning: ES_DISCARDABLE_WARNING_PROMPT
			hindered: BOOLEAN
		do
			if is_current_editor_searched then
				if is_editor_ready and then not editor.is_editable then
					hindered := True
					editor.display_not_editable_warning_message
				end
			end
			if not hindered then
				if not is_current_editor_searched then
					create l_warning.make_standard_with_cancel (warning_messages.w_replace_all, interface_names.l_discard_replace_all_warning_dialog, preferences.dialog_data.confirm_replace_all_string)
					l_warning.set_button_action (l_warning.dialog_buttons.ok_button, agent extend_and_run_loaded_action (agent replace_all))
					l_warning.set_button_text (l_warning.dialog_buttons.ok_button, interface_names.b_yes)
					l_warning.set_button_text (l_warning.dialog_buttons.cancel_button, interface_names.b_no)
					l_warning.show_on_active_window
				else
					extend_and_run_loaded_action (agent replace_all)
				end
			end
		end

	prepare_search is
			-- Show the search tool and set focus to the search text field and fill the search field with selection.
		local
			l_clickable_editor: EB_CLICKABLE_EDITOR
		do
			l_clickable_editor ?= editor
			if l_clickable_editor /= Void then
				l_clickable_editor.search
			else
				show_and_set_focus
			end
		end

	rebuild_scope_list is
			-- Rebuild scope list, validate existing items in it.
		local
			l_item: EV_LIST_ITEM
			l_class: CLASS_I
			l_group: CONF_GROUP
			l_items_tbr: ARRAYED_LIST [EV_LIST_ITEM]
		do
			create l_items_tbr.make (3)
			from
				scope_list.start
			until
				scope_list.after
			loop
				l_item := scope_list.item
				l_class ?= l_item.data
				l_group ?= l_item.data
				if l_class /= Void then
					if not l_class.is_valid then
						l_items_tbr.extend (l_item)
					else
						l_item.set_text (l_class.name)
						l_item.set_tooltip (group_name_presentation (".", "", l_class.group))
					end
				elseif l_group /= Void then
					if not l_group.is_valid then
						l_items_tbr.extend (l_item)
					else
						l_item.set_text (group_name_presentation (".", "", l_group))
					end
				else
					l_items_tbr.extend (l_item)
				end
				scope_list.forth
			end
			from
				l_items_tbr.start
			until
				l_items_tbr.after
			loop
				scope_list.prune (l_items_tbr.item)
				l_items_tbr.forth
			end
		end

feature {MSR_REPLACE_IN_ESTUDIO_STRATEGY, EB_CUSTOM_WIDGETTED_EDITOR, EB_SEARCH_REPORT_GRID} -- Implementation

	check_class_succeed: BOOLEAN assign set_check_class_succeed
			-- `check_class_file' makes file changed if needed?

	set_check_class_succeed (a_succeed: BOOLEAN) is
			-- Set check class succeed with `a_succeed'.
		do
			check_class_succeed := a_succeed
		ensure
			check_class_succeed_set: check_class_succeed = a_succeed
		end

	is_item_source_changed (a_item: MSR_ITEM): BOOLEAN is
			-- Source in a_item changed?
		require
			a_item_attached: a_item /= Void
		local
			l_class_i: CLASS_I
		do
			l_class_i ?= a_item.data
			if old_editor = Void or else old_editor.is_recycled or else old_editor = editor then
				if l_class_i /= Void then
					if is_current_editor_searched then
						Result := is_text_changed_in_editor
					else
						if is_editor_ready and then editor.changed then
							Result := not changed_by_replace or changed_classes.has (l_class_i) or a_item.date /= l_class_i.date
						else
							Result := is_text_changed_in_editor or changed_classes.has (l_class_i) or a_item.date /= l_class_i.date
						end
					end
				end
			end
		end

	changed_by_replace: BOOLEAN
			-- Changed by replace?

	set_changed_by_replace (a_changed: BOOLEAN) is
			-- Set `changed_by_replace'
		do
			changed_by_replace:= a_changed
		end

	force_not_changed is
			-- Set `new_search' and `is_text_changed_in_editor' to False.
		do
			new_search_set := False
			is_text_changed_in_editor := False
		end

feature {EB_SEARCH_REPORT_GRID, EB_CUSTOM_WIDGETTED_EDITOR} -- Build interface

	build_docking_content (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Build the associated explorer bar item and
			-- Add it to `explorer_bar'
		do
			-- Search tool have to delay building mini tool bar.
			-- So we can't call precursor here.
			create content.make_with_widget (widget, title)
			content.set_long_title (title)
			content.set_short_title (title)
			if pixmap /= Void then
				content.set_pixmap (pixmap)
			end
			if pixel_buffer /= Void then
				content.set_pixel_buffer (pixel_buffer)
			end
			content.set_floating_width (527)
			content.set_floating_height (189)
			content.close_request_actions.extend (agent close)
			content.drop_actions.extend (agent on_drop_notebook)
			content.focus_in_actions.extend (agent show)
		end

	prepare_interface is
			-- Initialize options' status.
		local
			l_pre : EB_SEARCH_TOOL_DATA
			l_scope: STRING
		do
			l_pre := preferences.search_tool_data
			if l_pre.init_incremental then
				incremental_search_button.enable_select
			else
				incremental_search_button.disable_select
			end
			if l_pre.init_match_case then
				case_sensitive_button.enable_select
			else
				case_sensitive_button.disable_select
			end
			if l_pre.init_only_compiled_classes then
				search_compiled_class_button.enable_select
			else
				search_compiled_class_button.disable_select
			end
			if l_pre.init_search_backwards then
				search_backward_button.enable_select
			else
				search_backward_button.disable_select
			end
			if l_pre.init_subclusters then
				search_subcluster_button.enable_select
			else
				search_subcluster_button.disable_select
			end
			if l_pre.init_use_regular_expression then
				use_regular_expression_button.enable_select
			else
				use_regular_expression_button.disable_select
			end
			if l_pre.init_whole_word then
				whole_word_button.enable_select
			else
				whole_word_button.disable_select
			end
			l_scope := l_pre.init_scope
			if l_scope.is_equal ("Current Editor") then
				current_editor_button.enable_select
			elseif l_scope.is_equal ("Whole Project") then
				whole_project_button.enable_select
			elseif l_scope.is_equal ("Custom") then
				custom_button.enable_select
			else
				check
					default_xml_not_correctly_done: False
				end
			end
		end

feature {NONE} -- Shortcut button actions

	new_search is
			-- New search
		do
			force_new_search
			changed_by_replace := False
			new_search_or_go_next
		end

	expand_all is
			-- Expand all
		local
			i: INTEGER
			l_row: EV_GRID_ROW
		do
			from
				i := 1
			until
				i > search_report_grid.row_count
			loop
				l_row := search_report_grid.row (i)
				if l_row.is_expandable then
					l_row.expand
				end
				i := i + 1
			end
		end

	collapse_all is
			-- Collapse all
		local
			i: INTEGER
			l_row: EV_GRID_ROW
		do
			from
				i := 1
			until
				i > search_report_grid.row_count
			loop
				l_row := search_report_grid.row (i)
				l_row.collapse
				i := i + 1
			end
		end

feature {EB_CUSTOM_WIDGETTED_EDITOR, EB_CONTEXT_MENU_FACTORY} -- Actions handler

	new_search_or_go_next is
			-- If new search is not necessary, go to next found.
		do
			check_class_succeed := True
			if new_search_set or not multi_search_performer.is_search_launched then
				dispatch_search
				select_and_show
			else
				go_to_next_found
			end
		end

	on_text_fully_loaded is
			-- Text observer, runs when text is fully loaded.
		do
			Precursor {TEXT_OBSERVER}
			if not loaded_actions.is_empty then
				loaded_actions.call (Void)
				loaded_actions.wipe_out
			end
			if is_current_editor_searched then
				force_new_search
			end
		end

	key_pressed (k: EV_KEY; search_only: BOOLEAN) is
			-- Key `k' was pressed in the interface.
			-- If k is Enter then launch the search, if it is Esc then hide the search interface.
		local
			l_alt, l_ctrl, l_shift: BOOLEAN
			l_incremental_search: BOOLEAN
		do
			l_alt := ev_application.alt_pressed
			l_ctrl := ev_application.ctrl_pressed
			l_shift := ev_application.shift_pressed
			if k /= Void then
				if k.code = Key_enter then
					if not keyword_field.text.is_empty and then search_is_possible then
						if search_only then
							new_search_or_go_next
						else
							replace_current
						end
					end
				elseif k.code = Key_escape then
					develop_window.set_focus_to_main_editor
				else
					if is_editor_ready then
						if search_forward_shortcut.matches (k, l_alt, l_ctrl, l_shift) then
							if not keyword_field.text.is_empty and then search_only then
								new_search_or_go_next
								ev_application.do_once_on_idle (agent editor.set_focus)
							end
						elseif search_backward_shortcut.matches (k, l_alt, l_ctrl, l_shift) then
							if not keyword_field.text.is_empty and then search_only then
								temp_reverse := True
								new_search_or_go_next
								ev_application.do_once_on_idle (agent editor.set_focus)
								temp_reverse := False
							end
						elseif search_previous_selection_shortcut.matches (k, l_alt, l_ctrl, l_shift) then
							if editor.has_selection then
								force_new_search
								l_incremental_search := is_incremental_search
								disable_incremental_search
								set_current_searched (editor.text_displayed.selected_wide_string)
								if l_incremental_search then
									enable_incremental_search
								end
							end
							if not keyword_field.text.is_empty and then search_only then
								temp_reverse := True
								new_search_or_go_next
								ev_application.do_once_on_idle (agent editor.set_focus)
								temp_reverse := False
							end
						elseif search_next_selection_shortcut.matches (k, l_alt, l_ctrl, l_shift) then
							if editor.has_selection then
								force_new_search
								l_incremental_search := is_incremental_search
								disable_incremental_search
								set_current_searched (editor.text_displayed.selected_wide_string)
								if l_incremental_search then
									enable_incremental_search
								end
							end
							if not keyword_field.text.is_empty and then search_only then
								new_search_or_go_next
								ev_application.do_once_on_idle (agent editor.set_focus)
							end
						end
					end
				end
			end
		end

	handle_enter_on_button (a_key: EV_KEY; a_pro: PROCEDURE [ANY, TUPLE]) is
			-- Handle enter on buttons.
		do
			if a_key.code = {EV_KEY_CONSTANTS}.key_enter then
				a_pro.apply
			end
		end

	toggle_scope_detail (a_button: EV_RADIO_BUTTON) is
			-- Show and hide the scope detail according to the scope box's selection.
		local
			l_str: STRING_GENERAL
		do
			if is_customized then
				scope.enable_sensitive
			else
				scope.disable_sensitive
			end
			if is_whole_project_searched or is_customized then
				search_compiled_class_button.enable_sensitive
			else
				search_compiled_class_button.disable_sensitive
			end
			if notebook /= Void then
				if a_button = current_editor_button then
					if widget /= Void and then is_visible then
						set_focus
					end
				end
				l_str := interface_names.l_scope.twin
				l_str.append (": ")
				l_str.append (a_button.text)
				notebook.item_tab (notebook.i_th (2)).set_text (l_str)
			end
		end

	add_scope is
			-- Add a new scope from a choose dialog to the list.
		do
			if choose_dialog = Void or else choose_dialog.is_destroyed then
				create choose_dialog.make (develop_window.menus.context_menu_factory)
				choose_dialog.set_class_add_action (agent add_class_item)
				choose_dialog.set_cluster_add_action (agent add_cluster_item)
				choose_dialog.set_folder_add_action (agent add_folder_item)
				choose_dialog.show_relative_to_window (develop_window.window)
				choose_dialog.default_push_button.select_actions.extend (agent force_new_search)
			else
				choose_dialog.show
			end
			set_focus_if_possible (choose_dialog)
			set_focus_if_possible (choose_dialog.classes_tree)
		end

	on_drop_custom_button (a_any: ANY) is
			-- Invoke hen dropping on the scope check button.
		do
			custom_button.enable_select
			on_drop_add (a_any)
		end

	on_drop_add (a_any: ANY) is
			-- Invoke when dropping a pebble to add an item to the scope.
		require
			a_any_not_void: a_any /= Void
		local
			l_classi_stone: CLASSI_STONE
			l_cluster_stone: CLUSTER_STONE
			l_folder: EB_FOLDER
			l_cluster: CONF_CLUSTER
			l_data: DATA_STONE
			l_groups: LIST [CONF_GROUP]
			l_cursor: CURSOR
		do
			l_classi_stone ?= a_any
			l_cluster_stone ?= a_any
			l_data ?= a_any
			if l_classi_stone /= Void then
				add_class_item (l_classi_stone.class_i)
			elseif l_cluster_stone /= Void then
				if not l_cluster_stone.path.is_empty and l_cluster_stone.folder_name /= Void then
					l_cluster ?= l_cluster_stone.group
					check
						l_cluster_not_void: l_cluster /= Void
					end
					create l_folder.make_with_name (l_cluster, l_cluster_stone.path, l_cluster_stone.folder_name)
					add_folder_item (l_folder)
				else
					add_cluster_item (l_cluster_stone.group)
				end
			elseif l_data /= Void then
				l_groups ?= l_data.data
				if l_groups /= Void then
					l_cursor := l_groups.cursor
					from
						l_groups.start
					until
						l_groups.after
					loop
						if l_groups.item /= Void then
							add_cluster_item (l_groups.item)
						end
						l_groups.forth
					end
					l_groups.go_to (l_cursor)
				end
			end
		end

	veto_pebble_function (a_any: ANY): BOOLEAN is
			-- Veto pebble function
		local
			l_classi_stone: CLASSI_STONE
			l_cluster_stone: CLUSTER_STONE
			l_feature_stone: FEATURE_STONE
			l_data: DATA_STONE
		do
				-- We reject FEATURE_STONE.
			l_feature_stone ?= a_any
			if l_feature_stone = Void then
					-- Check validity of the stone.
				l_classi_stone ?= a_any
				l_cluster_stone ?= a_any
				l_data ?= a_any
				Result := l_cluster_stone /= Void or l_classi_stone /= Void or l_data /= Void
			end
		end

	on_drop_remove (a_any: ANY) is
			-- Invoke when dropping a pebble on remove button.
		require
			a_any_not_void: a_any /= Void
		local
			l_classi_stone: CLASSI_STONE
			l_cluster_stone: CLUSTER_STONE
			l_folder: EB_FOLDER
			l_cluster: CONF_CLUSTER
		do
			l_classi_stone ?= a_any
			l_cluster_stone ?= a_any
			if l_classi_stone /= Void then
				remove_class_item (l_classi_stone.class_i)
			elseif l_cluster_stone /= Void then
				if not l_cluster_stone.path.is_empty and l_cluster_stone.folder_name /= Void then
					l_cluster ?= l_cluster_stone.group
					check
						l_cluster_not_void: l_cluster /= Void
					end
					create l_folder.make_with_name (l_cluster, l_cluster_stone.path, l_cluster_stone.folder_name)
					remove_folder_item (l_folder)
				else
					remove_cluster_item (l_cluster_stone.group)
				end
			end
		end

	remove_all is
			-- Remove all from scope
		do
			scope_list.wipe_out
		end

	on_text_edited (directly_edited: BOOLEAN) is
			-- Notify observers that some text has been modified.
			-- If `directly_edited', the user has modified the text in the editor,
			-- not via another tool or wizard.
		local
			l_class_stone: CLASSI_STONE
		do
			force_new_search
			is_text_changed_in_editor := True
			if is_text_new_loaded and then multi_search_performer.is_search_launched and then not multi_search_performer.is_empty then
				l_class_stone ?= develop_window.stone
				if l_class_stone /= Void and not changed_by_replace then
					class_changed (l_class_stone.class_i)
				end
				is_text_new_loaded := False
			end
			set_changed_by_replace (False)
		end

	on_text_reset is
			-- Obsever reset action.
		do
			is_text_changed_in_editor := False
			is_text_new_loaded := True
		end

	enable_disable_search_button is
			-- Disable the search buton if the search field is empty, incremental search if it is possible.
		local
			l_editor: like old_editor
		do
			if search_is_possible then
				search_button.enable_sensitive
				replace_button.enable_sensitive
				replace_all_click_button.enable_sensitive
				if is_editor_ready and then not editor.is_empty and then is_incremental_search then
					l_editor := old_editor
					old_editor := editor
					incremental_search (keyword_field.text, incremental_search_start_pos, is_whole_word_matched)
					if has_result then
						select_in_current_editor
					else
						retrieve_cursor
					end
					old_editor := l_editor
				end
			else
				retrieve_cursor
				search_button.disable_sensitive
				replace_button.disable_sensitive
				replace_all_click_button.disable_sensitive
			end
			trigger_keyword_field_color (keyword_field)
			if old_search_key_value /= Void and then not old_search_key_value.is_equal (keyword_field.text) then
				force_new_search
			end
		end

	retrieve_cursor is
			-- Retrieve cursor position.
		do
			if is_editor_ready and then editor.text_displayed.cursor /= Void then
				editor.disable_selection
				editor.text_displayed.cursor.go_to_position (incremental_search_start_pos)
				editor.check_cursor_position
				editor.refresh_now
			end
		end

	on_drop_notebook (a_stone: STONE) is
			-- When dropping on tabs of notebook.
		local
			l_filed_stone: FILED_STONE
		do
			inspect notebook.pointed_tab_index
			when 1 then
				notebook.select_item (notebook.i_th (1))
				l_filed_stone ?= a_stone
				if l_filed_stone /= Void then
					display_stone_signature (keyword_field, l_filed_stone)
				end
			else
				notebook.select_item (notebook.i_th (2))
				on_drop_custom_button (a_stone)
				content.set_focus
			end
		end

	notebook_veto_pebble (a_stone: ANY) : BOOLEAN is
			-- Notebook veto pebble
		local
			l_classi_stone: CLASSI_STONE
			l_cluster_stone: CLUSTER_STONE
		do
			if notebook /= Void and then not notebook.is_destroyed then
				inspect notebook.pointed_tab_index
				when 1 then
					Result := True
				when 2 then
					l_classi_stone ?= a_stone
					l_cluster_stone ?= a_stone
					if l_classi_stone /= Void or else l_cluster_stone /= Void then
						Result := True
					end
				else
				end
			end
		end

	on_notebook_selected is
			-- On notebook selected.
		do
			if notebook.pointed_tab_index = 1 then
				if widget /= Void and is_visible then
					set_focus
				end
			end
		end

	focusing_keyword_field is
			-- Focusing keyword field.
			-- We record cursor position in the editor for incremental search.
		do
			if is_editor_ready and then editor.text_displayed.cursor /= Void then
				incremental_search_start_pos := editor.text_displayed.cursor.pos_in_text
			end
		end

	trigger_keyword_field_color (a_keyword_field: EV_COMBO_BOX) is
			-- Trigger keyword field color after incremental search.
			-- Highlight background if no result.
		do
			extend_and_run_loaded_action (agent trigger_keyword_field_color_perform (a_keyword_field))
		end

	trigger_keyword_field_color_perform (a_keyword_field: EV_COMBO_BOX) is
			-- Trigger keyword field color after incremental search.
			-- Highlight background if no result.
		do
			if is_incremental_search then
				if a_keyword_field.text_length > 0 and (not multi_search_performer.is_search_launched or multi_search_performer.is_empty) then
					a_keyword_field.set_background_color (no_result_bgcolor)
				else
					a_keyword_field.set_background_color (normal_bgcolor)
				end
			end
		end

feature {EB_DEVELOPMENT_WINDOW} -- Notification

	class_changed (a_class: CLASS_I) is
			-- Remenber `a_class' as a user changed class since last search.
		do
			if a_class /= Void and then not changed_classes.has (a_class) then
				changed_classes.extend (a_class)
			end
		end

feature {EB_CUSTOM_WIDGETTED_EDITOR} -- Search perform

	dispatch_search is
			-- Dispatch search.
		do
			if shown then
				if is_whole_project_searched then
					search_whole_project
				elseif is_customized then
					search_in_scope
				elseif search_button.is_sensitive then
					if new_search_set or not multi_search_performer.is_search_launched then
						search
					end
					if is_editor_ready and then not editor.has_focus then
						editor.set_focus
					end
				end
			else
				if new_search_set or not multi_search_performer.is_search_launched then
					default_search
				end
			end
		end

	incremental_search (a_word: STRING_32; a_start_pos: INTEGER; a_whole_word: BOOLEAN) is
			-- Incremental search in the editor displayed text
		local
			incremental_search_strategy: MSR_SEARCH_INCREMENTAL_STRATEGY
			class_i: CLASS_I
			file_name: FILE_NAME
			class_name: STRING
			class_stone: CLASSI_STONE
			l_text: STRING_32
		do
			develop_window.window.set_pointer_style (default_pixmaps.wait_cursor)
			if is_editor_ready then
				if editor.text_displayed.reading_text_finished then
					l_text := editor.text_displayed.wide_text
				end
					-- "not editor.is_empty" doesn't imply l_text is not empty string.
				if l_text /= Void and then not l_text.is_empty then
					currently_searched := a_word
					class_stone ?= editor.stone
					if class_stone /= Void then
						class_i := class_stone.class_i
						file_name:= class_i.file_name
						class_name := class_i.name
					else
						class_name := ""
						create file_name.make
					end

					create incremental_search_strategy.make_with_start (currently_searched,
																		surrounding_text_number,
																		class_name,
																		file_name,
																		l_text,
																		a_start_pos.min (l_text.count).max (1))
					if case_sensitive_button.is_selected then
						incremental_search_strategy.set_case_sensitive
					else
						incremental_search_strategy.set_case_insensitive
					end
					incremental_search_strategy.set_regular_expression_used (use_regular_expression_button.is_selected)
					incremental_search_strategy.set_whole_word_matched (a_whole_word)
					if class_i /= Void then
						incremental_search_strategy.set_data (class_i)
						incremental_search_strategy.set_date (class_i.date)
					end
					if develop_window.class_name /= Void then
						incremental_search_strategy.set_class_name (develop_window.class_name)
					end
					multi_search_performer.set_search_strategy (incremental_search_strategy)
					multi_search_performer.do_search
					multi_search_performer.start
					force_new_search
					saved_cursor := 0
				end
			end
			develop_window.window.set_pointer_style (default_pixmaps.standard_cursor)
		end

	incremental_search_start_pos: INTEGER
			-- Incremental search start from.

	set_incremental_search_start_pos (a_start: INTEGER) is
			-- Set `incremental_search_start_pos' with `a_start'.
		require
			a_start_larger_than_zero: a_start > 0
		do
			incremental_search_start_pos := a_start
		end

	search is
			-- Search in editor.
		local
			text_strategy: MSR_SEARCH_TEXT_STRATEGY
			class_i: CLASS_I
			file_name: FILE_NAME
			class_name: STRING
			class_stone: CLASSI_STONE
		do
			develop_window.window.set_pointer_style (default_pixmaps.wait_cursor)
			currently_searched := keyword_field.text
			if is_editor_ready then
				class_stone ?= editor.stone
			end
			if class_stone /= Void then
				class_i := class_stone.class_i
				file_name := class_i.file_name
				if not is_main_editor then
					create file_name.make_from_string ("-")
				end
				class_name := class_i.name
			else
				class_name := "Not a class"
				create file_name.make
			end
			if is_editor_ready and then not editor.is_empty then
				create text_strategy.make (currently_searched, surrounding_text_number, class_name, file_name, editor.text_displayed.wide_text)
				multi_search_performer.set_search_strategy (text_strategy)
				if case_sensitive_button.is_selected then
					text_strategy.set_case_sensitive
				else
					text_strategy.set_case_insensitive
				end
				text_strategy.set_regular_expression_used (is_regular_expression_used)
				text_strategy.set_whole_word_matched (is_whole_word_matched)
				if class_i /= Void then
					text_strategy.set_data (class_i)
					text_strategy.set_date (class_i.date)
				end
				saved_cursor := 0
				report_cursor_recorded := False
				multi_search_performer.do_search
				update_combo_box_specific (keyword_field, currently_searched)
				after_search
				extend_and_run_loaded_action (agent go_to_next_found_perform (reverse))
				update_combo_box_specific (keyword_field, currently_searched)
			end
			develop_window.window.set_pointer_style (default_pixmaps.standard_cursor)
		end

	default_search is
			-- Search with default options.
		local
			text_strategy: MSR_SEARCH_TEXT_STRATEGY
			class_i: CLASS_I
			file_name: FILE_NAME
			class_name: STRING
			class_stone: CLASSI_STONE
		do
			develop_window.window.set_pointer_style (default_pixmaps.wait_cursor)
			if currently_searched /= Void and then not currently_searched.is_empty then
					-- search is possible but the search box is not shown
					-- default options
				currently_searched := keyword_field.text
				if is_editor_ready then
					class_stone ?= editor.stone
				end
				if class_stone /= Void then
					class_i := class_stone.class_i
					file_name := class_i.file_name
					class_name := class_i.name
				else
					class_name := "Not a class"
					create file_name.make
					create class_name.make_empty
				end
				if is_editor_ready and then not editor.is_empty then
					create text_strategy.make (currently_searched, surrounding_text_number, class_name, file_name, editor.text_displayed.wide_text)
					multi_search_performer.set_search_strategy (text_strategy)
					if is_case_sensitive then
						text_strategy.set_case_sensitive
					else
						text_strategy.set_case_insensitive
					end
					text_strategy.set_regular_expression_used (is_regular_expression_used)
					text_strategy.set_whole_word_matched (False)
					if class_i /= Void then
						text_strategy.set_data (class_i)
						text_strategy.set_date (class_i.date)
					end
					saved_cursor := 0
					report_cursor_recorded := False
					multi_search_performer.do_search
					update_combo_box_specific (keyword_field, currently_searched)
					after_search
					extend_and_run_loaded_action (agent go_to_next_found_perform (reverse))
				end
			end
			develop_window.window.set_pointer_style (default_pixmaps.standard_cursor)
		end

	search_whole_project is
			-- Search the whole project.
		local
			l_project_strategy: MSR_SEARCH_WHOLE_PROJECT_STRATEGY
		do
			develop_window.window.set_pointer_style (default_pixmaps.wait_cursor)
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
			saved_cursor := 0
			report_cursor_recorded := False
			multi_search_performer.do_search
			update_combo_box_specific (keyword_field, currently_searched)
			after_search
			old_editor := Void
			extend_and_run_loaded_action (agent go_to_next_found_perform (reverse))
			develop_window.window.set_pointer_style (default_pixmaps.standard_cursor)
		end

	search_in_scope is
			-- Search in scope.
		local
			l_scope_strategy: MSR_SEARCH_IN_SCOPE_STRATEGY
		do
			develop_window.window.set_pointer_style (default_pixmaps.wait_cursor)
			currently_searched := keyword_field.text
			create l_scope_strategy.make (currently_searched, surrounding_text_number, scope_list, only_compiled_class_searched)
			if is_case_sensitive then
				l_scope_strategy.set_case_sensitive
			else
				l_scope_strategy.set_case_insensitive
			end
			l_scope_strategy.set_regular_expression_used (is_regular_expression_used)
			l_scope_strategy.set_subcluster_searched (is_sub_cluster_searched)
			l_scope_strategy.set_whole_word_matched (is_whole_word_matched)
			multi_search_performer.set_search_strategy (l_scope_strategy)
			saved_cursor := 0
			report_cursor_recorded := False
			multi_search_performer.do_search
			update_combo_box_specific (keyword_field, currently_searched)
			after_search
			old_editor := Void
			develop_window.window.set_pointer_style (default_pixmaps.standard_cursor)
		end

	after_search is
			-- When a search done, go here. Incremental search excluded.
		do
			if multi_search_performer.is_search_launched then
				old_search_key_value := currently_searched
				old_editor := editor
				search_report_grid.redraw_grid
				if
					not is_current_editor_searched and then
					not multi_search_performer.is_empty and then
					not report_tool.shown
				then
					report_tool.show
				end
				trigger_keyword_field_color (keyword_field)
				changed_classes.wipe_out
				extend_and_run_loaded_action (agent force_not_changed)
			end
		end

feature {EB_CUSTOM_WIDGETTED_EDITOR} -- Search report

	changed_classes: ARRAYED_LIST [CLASS_I]
			-- Keep a record of modified class by editor.

	select_current_row is
			-- Select current row in the report.
		do
			search_report_grid.select_current_row
		end

	has_result: BOOLEAN is
			-- Search has result?
		do
			Result := not multi_search_performer.is_empty
		end

feature {NONE} -- Option observer

	on_case_sensitivity_changed (a_case_sensitive: BOOLEAN) is
			-- Case sensitivity option changed
		do
			if case_sensitive_button.is_selected /= a_case_sensitive then
				case_sensitive_button.select_actions.block
				if a_case_sensitive then
					case_sensitive_button.enable_select
				else
					case_sensitive_button.disable_select
				end
				case_sensitive_button.select_actions.resume
				force_new_search
			end
		end

	on_match_regex_changed (a_match_regex: BOOLEAN) is
			-- Match regex option changed
		do
			if use_regular_expression_button.is_selected /= a_match_regex then
				use_regular_expression_button.select_actions.block
				if a_match_regex then
					use_regular_expression_button.enable_select
				else
					use_regular_expression_button.disable_select
				end
				use_regular_expression_button.select_actions.resume
				force_new_search
			end
		end

	on_whole_word_changed (a_whole_word: BOOLEAN) is
			-- Whole word option changed
		do
			if whole_word_button.is_selected /= a_whole_word then
				whole_word_button.select_actions.block
				if a_whole_word then
					whole_word_button.enable_select
				else
					whole_word_button.disable_select
				end
				whole_word_button.select_actions.resume
				force_new_search
			end
		end

	on_backwards_changed (a_bachwards: BOOLEAN) is
			-- Backwards option changed
		do
			if search_backward_button.is_selected /= a_bachwards then
				search_backward_button.select_actions.block
				if a_bachwards then
					search_backward_button.enable_select
				else
					search_backward_button.disable_select
				end
				search_backward_button.select_actions.resume
			end
		end

	check_button_changed (a_button: EV_CHECK_BUTTON) is
			-- Option check button changed.
		do
			if a_button = case_sensitive_button then
				case_sensitivity_changed (a_button.is_selected)
			elseif a_button = use_regular_expression_button then
				match_regex_changed (a_button.is_selected)
			elseif a_button = whole_word_button then
				whole_word_changed (a_button.is_selected)
			elseif a_button = search_backward_button then
				backwards_changed (a_button.is_selected)
			end
		end

feature {NONE} -- Replacement Implementation

	replace_current_perform is
			-- Do actual `replace_current'.
		local
			editor_replace_strategy: MSR_REPLACE_IN_ESTUDIO_STRATEGY
		do
			create editor_replace_strategy.make (current)
			currently_replacing := replace_combo_box.text
			multi_search_performer.set_replace_strategy (editor_replace_strategy)
			multi_search_performer.set_replace_string (currently_replacing)
			multi_search_performer.replace
			update_combo_box_specific (replace_combo_box, currently_replacing)
			force_not_changed
		end

	replace_all is
			-- Replace all matches in specified scale.
		local
			editor_replace_strategy: MSR_REPLACE_IN_ESTUDIO_STRATEGY
		do
			check_class_succeed := True
			develop_window.window.set_pointer_style (default_pixmaps.wait_cursor)
			currently_replacing := replace_combo_box.text
			if is_current_editor_searched then
				new_search_or_go_next
			else
				if
					new_search_set or else
					not multi_search_performer.is_search_launched
				then
					new_search_or_go_next
				end
			end
			if multi_search_performer.is_search_launched then
				create editor_replace_strategy.make (Current)
				multi_search_performer.set_replace_strategy (editor_replace_strategy)
				multi_search_performer.set_replace_string (currently_replacing)
				multi_search_performer.replace_all
				update_combo_box_specific (replace_combo_box, currently_replacing)
				search_report_grid.redraw_grid
				put_replace_report (False)
			else
				put_replace_report (True)
			end
			develop_window.window.set_pointer_style (default_pixmaps.standard_cursor)

		end

	put_replace_report (a_did_nothing: BOOLEAN) is
			-- Put replace report.
		require
			valid_replace_report: not a_did_nothing implies multi_search_performer.replace_report /= Void
		local
			l_classes: INTEGER
		do
			if not a_did_nothing then
				l_classes := multi_search_performer.replace_report.class_replaced
				report_tool.set_summary (interface_names.l_replace_report (multi_search_performer.replace_report.text_replaced, l_classes))
			else
				report_tool.set_summary (interface_names.l_replace_report (0, 0))
			end
		end

feature {NONE} -- Shortcuts

	search_next_selection_shortcut: SHORTCUT_PREFERENCE is
		once
			Result := preferences.editor_data.shortcuts.item ("search_selection_forward")
		end

	search_previous_selection_shortcut: SHORTCUT_PREFERENCE is
		once
			Result := preferences.editor_data.shortcuts.item ("search_selection_backward")
		end

	search_forward_shortcut: SHORTCUT_PREFERENCE is
		once
			Result := preferences.editor_data.shortcuts.item ("search_forward")
		end

	search_backward_shortcut: SHORTCUT_PREFERENCE is
		once
			Result := preferences.editor_data.shortcuts.item ("search_backward")
		end

feature -- Custom search scope

	add_class_item (a_class: CLASS_I) is
			-- Add a class item to the tree.
		require
			a_class_not_void: a_class /= Void
		local
			l_item: EV_LIST_ITEM
		do
			l_item := scope_list.retrieve_item_by_data (a_class, False)
			if l_item = Void then
				create l_item.make_with_text (a_class.name)
				l_item.set_tooltip (group_name_presentation (".", "", a_class.group) + "." + a_class.name)
				l_item.set_pixmap (pixmap_from_class_i (a_class))
				scope_list.extend (l_item)
				l_item.set_data (a_class)
				l_item.set_pebble_function (agent scope_pebble_function (a_class))
				l_item.set_accept_cursor (Cursors.cur_class)
				l_item.set_deny_cursor (Cursors.cur_x_class)
				l_item.set_configurable_target_menu_mode
				l_item.set_configurable_target_menu_handler (agent (develop_window.menus.context_menu_factory).search_scope_menu)
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
			l_item := scope_list.retrieve_item_by_data (a_class, False)
			scope_list.prune (l_item)
			force_new_search
		end

	add_cluster_item (a_group: CONF_GROUP) is
			-- Add a group item to the list.
		require
			a_group_not_void: a_group /= Void
		local
			l_item: EV_LIST_ITEM
		do
			if not a_group.is_assembly and not a_group.is_physical_assembly then
				l_item := scope_list.retrieve_item_by_data (a_group, False)
				if l_item = Void then
					create l_item.make_with_text (a_group.name)
					l_item.set_tooltip (group_name_presentation (".", "", a_group))
					l_item.set_pixmap (pixmap_from_group (a_group))
					scope_list.extend (l_item)
					l_item.set_data (a_group)
					l_item.set_pebble_function (agent scope_pebble_function (a_group))
					l_item.set_accept_cursor (Cursors.cur_cluster)
					l_item.set_deny_cursor (Cursors.cur_x_cluster)
					l_item.set_configurable_target_menu_mode
					l_item.set_configurable_target_menu_handler (agent (develop_window.menus.context_menu_factory).search_scope_menu)
					force_new_search
				end
			end
		end

	remove_cluster_item (a_group: CONF_GROUP) is
			-- Remove a class item from the list.
		require
			a_group_not_void: a_group /= Void
		local
			l_item: EV_LIST_ITEM
		do
			l_item := scope_list.retrieve_item_by_data (a_group, False)
			scope_list.prune (l_item)
			force_new_search
		end

	add_folder_item (a_folder: EB_FOLDER) is
			-- Add a folder item to the list.
		require
			a_folder_not_void: a_folder /= Void
		local
			l_item: EV_LIST_ITEM
		do
			l_item := scope_list.retrieve_item_by_data (a_folder, True)
			if l_item = Void then
				create l_item.make_with_text (a_folder.name)
				l_item.set_tooltip (group_name_presentation (".", "", a_folder.cluster) + " (" + a_folder.path + ")")
				l_item.set_pixmap (pixmap_from_group_path (a_folder.cluster, a_folder.path))
				scope_list.extend (l_item)
				l_item.set_data (a_folder)
				l_item.set_pebble_function (agent scope_pebble_function (a_folder))
				l_item.set_accept_cursor (Cursors.cur_cluster)
				l_item.set_deny_cursor (Cursors.cur_x_cluster)
				l_item.set_configurable_target_menu_mode
				l_item.set_configurable_target_menu_handler (agent (develop_window.menus.context_menu_factory).search_scope_menu)
				force_new_search
			end
		end

	remove_folder_item (a_folder: EB_FOLDER) is
			-- Remove a folder item from the list.
		require
			a_folder_not_void: a_folder /= Void
		local
			l_item: EV_LIST_ITEM
		do
			l_item := scope_list.retrieve_item_by_data (a_folder, True)
			scope_list.prune (l_item)
			force_new_search
		end

	scope_pebble_function (a_data: ANY) : STONE is
			-- Scope pebble function
		local
			l_class_i: CLASS_I
			l_cluster_i: CONF_GROUP
			l_folder: EB_FOLDER
		do
			l_class_i ?= a_data
			l_cluster_i ?= a_data
			l_folder ?= a_data
			if l_class_i /= Void then
				Result := stone_from_class_i (l_class_i)
			elseif l_folder /= Void then
				create {CLUSTER_STONE}Result.make_subfolder (l_folder.cluster, l_folder.path, l_folder.name)
			elseif l_cluster_i /= Void then
				create {CLUSTER_STONE}Result.make (l_cluster_i)
			end
		end

feature {NONE} -- Recycle

	internal_recycle is
			-- Recycle
		do
			bottom_reached_actions.wipe_out
			first_result_reached_actions.wipe_out
			loaded_actions.wipe_out
			remove_observer (Current)
			Precursor {ES_MULTI_SEARCH_TOOL_PANEL_IMP}
		end

feature {EB_SEARCH_REPORT_GRID, EB_CUSTOM_WIDGETTED_EDITOR} -- Implementation

	search_history_size: INTEGER is 10

	is_editor_ready: BOOLEAN is
			-- Is editor ready to be searched?
		do
			Result := editor /= Void and then
					editor.text_displayed /= Void
		end

	go_to_next_found_perform (b: BOOLEAN) is
			-- Do actual `go_to_next_found'.
		local
			l_class_i: CLASS_I
			l_pos: INTEGER
			l_text: EDITABLE_TEXT
			l_text_item: MSR_TEXT_ITEM
			l_selected: BOOLEAN
			l_class_stone: CLASSI_STONE
		do
			if multi_search_performer.is_search_launched and then not multi_search_performer.item_matched.is_empty then
				l_class_stone ?= develop_window.stone
				if l_class_stone /= Void then
					l_class_i := l_class_stone.class_i
				end
				if is_editor_ready then
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
				end

				if not multi_search_performer.off then
					l_text_item ?= multi_search_performer.item
					if l_text_item /= Void and then ((old_editor = Void or old_editor = editor) implies is_item_source_changed (l_text_item)) then
						multi_search_performer.go_to_next_text_item (b)
						select_current_row
						l_selected := True
					end
				end
				if not l_selected then
					multi_search_performer.go_to_closest_item (l_pos, b, l_class_i, (is_main_editor and develop_window.class_name /= Void) or not is_current_editor_searched)
					go_to_next_need_select_and_show := True
					if (not multi_search_performer.off) and then is_item_source_changed (multi_search_performer.item) then
						multi_search_performer.start
						if l_text_item /= Void then
							multi_search_performer.search (l_text_item)
						end
						multi_search_performer.go_to_next_text_item (b)
						go_to_next_need_select_and_show := False
						select_current_row
					end
				end
			end
		end

	go_to_next_found_select_and_show is
			-- Go to next found.
		do
			if go_to_next_need_select_and_show then
				select_and_show
				go_to_next_need_select_and_show := False
			end
		end

	go_to_next_need_select_and_show :BOOLEAN
			-- Flag for need select and show for next select.

	check_class_file is
			-- Check if class of current selected item is loaded. If not, load it.
			-- After check run `a_pro'.
		local
			l_item: MSR_ITEM
			l_stone, l_new_stone: STONE
			l_class_i: CLASS_I
		do
			check_class_succeed := True
			if not multi_search_performer.off then
				l_stone := develop_window.stone
				l_item := multi_search_performer.item
				l_class_i ?= l_item.data
				if l_class_i /= Void then
					l_new_stone := stone_from_class_i (l_class_i)
					if develop_window.class_name /= Void and then not develop_window.class_name.is_equal (l_item.class_name) then
						if l_class_i /= Void then
							develop_window.set_stone (l_new_stone)
							if l_stone /= develop_window.stone then
								is_text_changed_in_editor := False
							else
								loaded_actions.wipe_out
								check_class_succeed := False
							end
						end
					elseif not is_current_editor_searched then
						develop_window.set_stone (l_new_stone)
						if l_stone = develop_window.stone then
							loaded_actions.wipe_out
							check_class_succeed := False
						end
					end
				end
				if not is_current_editor_searched and then
					l_stone /= develop_window.stone and then
					is_editor_ready
				then
					editor.set_focus
				end
			end
		end

	update_combo_box (word: STRING_32) is
			-- Add word to combo box list
		local
			l: LIST [STRING_32]
		do
			l := keyword_field.strings
			if l /= Void then
				l.compare_objects
			end
			if l = Void or else not l.has (word) then
				if keyword_field.count = search_history_size then
					keyword_field.start
					keyword_field.remove
				end
				keyword_field.extend (create {EV_LIST_ITEM}.make_with_text (word))
			end
			if keyword_field.text.is_empty or else not word.is_equal (keyword_field.text) then
				keyword_field.set_text (word)
			end
		end

	extend_and_run_loaded_action (a_pro: PROCEDURE [ANY, TUPLE]) is
			-- Insert `a_pro' to loaded_actions and run all actions in it.
		local
			l_pro: PROCEDURE [ANY, TUPLE]
			loop_end : BOOLEAN
		do
			if check_class_succeed then
				loaded_actions.extend (a_pro)
				block_actions
				blocking_actions_times := blocking_actions_times + 1
				from
					loaded_actions.start
				until
					loaded_actions.count = 0 or loop_end
				loop
					if is_editor_ready and then (editor.text_is_fully_loaded or editor.is_empty) then
						l_pro := loaded_actions.item
						loaded_actions.remove
						l_pro.call (Void)
					else
						loop_end := True
					end
				end
				if blocking_actions_times <= 1 then
					resume_actions
					blocking_actions_times := 0
				else
					blocking_actions_times := blocking_actions_times - 1
				end
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

	stone_from_class_i (a_class_i: CLASS_I): STONE is
			-- Make a stone from a_class_i.
			-- If a_class_i compiled returns CLASSC_STONE , or a CLASSI_STONE.
		require
			a_class_i_not_void: a_class_i /= Void
		local
			l_class_c: CLASS_C
		do
			l_class_c := a_class_i.compiled_representation
			if l_class_c /= Void then
				create {CLASSC_STONE}Result.make (l_class_c)
			else
				create {CLASSI_STONE}Result.make (a_class_i)
			end
			Result.set_pos_container (develop_window.managed_main_formatters.first)
		end

	is_text_changed_in_editor: BOOLEAN
			-- Text changed in the editor?

	is_text_new_loaded: BOOLEAN
			-- Text loaded in the editor?

	clusters_in_the_project: EB_CLUSTERS is
			-- Clusters in the project
		do
			Result:= develop_window.cluster_manager.manager
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

	switch_mode is
			-- Switch from the normal mode to the replace mode
			-- or the opposite
		do
		end

	search_is_possible: BOOLEAN is
			-- Is it possible to look for the current content of the "search for:" field?
		local
			for_test: STRING_32
		do
			for_test := keyword_field.text
			Result := not for_test.is_empty
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
			l_editor: EB_EDITOR
			l_start, l_end: INTEGER
		do
			if old_editor /= Void then
				l_editor := old_editor
			else
				l_editor := editor
			end
			if l_editor /= Void and then multi_search_performer.is_search_launched and then not multi_search_performer.off then
				l_text_item ?= multi_search_performer.item
				if l_text_item /= Void then
					l_start := l_text_item.start_index_in_unix_text
					l_end := l_text_item.end_index_in_unix_text + 1
					if l_end > l_start then
						if l_editor.text_is_fully_loaded then
							l_editor.select_region (l_start, l_end)
						end
					elseif l_end = l_start then
						if l_editor.text_displayed.cursor /= Void then
							l_editor.text_displayed.cursor.go_to_position (l_end)
						end
						l_editor.deselect_all
					end
					if l_editor.has_selection then
						l_editor.show_selection (False)
					end
					l_editor.refresh_now
				end
				bottom_reached_actions.call ([False])
				first_result_reached_actions.call ([False])
			end
		end

	new_search_set: BOOLEAN assign set_new_search_set
			-- Will a new search be launched? (Incremental search excluded)

	set_new_search_set (a_new: BOOLEAN) is
			-- Set `new_search_set'.
		do
			new_search_set := a_new
		ensure
			new_search_set_set: new_search_set = a_new
		end

	old_search_key_value: STRING_32
			-- Internal last search keyword.

	old_editor: EB_EDITOR
			-- In which last search did.

	set_old_editor (a_editor: like old_editor) is
			-- Set `old_editor' with `a_editor'.
		do
			old_editor := a_editor
		end

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
			l := window_manager.development_windows_with_class (a_class.file_name)
			if not l.is_empty then
				from
					l.start
				until
					l.after
				loop
					l_editor := l.item.editors_manager.current_editor
					if l_editor /= Void and then l_editor.is_editable and l.item /= Void then
						Result := True
					end
					l.forth
				end
			end
		end

	update_combo_box_specific (box: EV_COMBO_BOX; word: STRING_32) is
			-- Add word to combo box list.
		local
			l: LIST [STRING_32]
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

	is_main_editor: BOOLEAN is
			-- Is `editor' main editor?
		do
			Result := (editor = develop_window.editors_manager.current_editor)
		end

	display_stone_signature (textable: EV_TEXTABLE; a_stone: FILED_STONE) is
			-- Display signature name of `a_stone' in `textable'.
		require
			textable_not_void: textable /= Void
			a_stone_not_void: a_stone /= Void
		local
			stone_signature: STRING
		do
			if a_stone.stone_signature /= Void then
					-- FIXME Protected against Void, as there is no postcondition
					-- on `stone_signature', although it appears it should never be Void,
					-- it must be protected for now. Julian 07/22/03

				stone_signature := a_stone.stone_signature
				if stone_signature.has (' ') then
						-- Generic classes, and features with arguments have their arguments
						-- included, so we strip everything except the name.
					stone_signature := stone_signature.substring (1, stone_signature.index_of (' ', 1) - 1)
				end
				textable.set_text (stone_signature)
			end
		ensure
			text_set: a_stone /= Void implies textable.text.is_equal (a_stone.stone_signature)
		end

	block_actions is
			-- Block actions.
		do
			keyword_field.change_actions.block
			replace_combo_box.key_press_actions.block
			case_sensitive_button.key_press_actions.block
			whole_word_button.key_press_actions.block
			use_regular_expression_button.key_press_actions.block
			search_backward_button.key_press_actions.block
			current_editor_button.key_press_actions.block
			whole_project_button.key_press_actions.block
			custom_button.key_press_actions.block
			search_subcluster_button.key_press_actions.block
			search_compiled_class_button.key_press_actions.block
			scope_list.key_press_actions.block
			search_button.select_actions.block
			replace_button.select_actions.block
			replace_all_click_button.select_actions.block
			search_button.key_press_actions.block
			replace_button.key_press_actions.block
			replace_all_click_button.key_press_actions.block
		end

	resume_actions is
			-- Resume actions.
		do
			keyword_field.change_actions.resume
			replace_combo_box.key_press_actions.resume
			case_sensitive_button.key_press_actions.resume
			whole_word_button.key_press_actions.resume
			use_regular_expression_button.key_press_actions.resume
			search_backward_button.key_press_actions.resume
			current_editor_button.key_press_actions.resume
			whole_project_button.key_press_actions.resume
			custom_button.key_press_actions.resume
			search_subcluster_button.key_press_actions.resume
			search_compiled_class_button.key_press_actions.resume
			scope_list.key_press_actions.resume
			search_button.select_actions.resume
			replace_button.select_actions.resume
			replace_all_click_button.select_actions.resume
			search_button.key_press_actions.resume
			replace_button.key_press_actions.resume
			replace_all_click_button.key_press_actions.resume
		end

	blocking_actions_times: INTEGER;
			-- Blocking actions?

	no_result_bgcolor: EV_COLOR is
			-- Background color when no result for incremental search.
		do
			Result := preferences.search_tool_data.none_result_keyword_field_background_color
		end

	normal_bgcolor: EV_COLOR is
			-- Normal background color.
		local
			l_comb: EV_COMBO_BOX
		once
			create l_comb
			Result := l_comb.background_color
		end

	set_report_cursor_recorded (a_recorded: BOOLEAN) is
			-- Set `report_cursor_recorded' with `a_recorded'
		do
			report_cursor_recorded := a_recorded
		end

	report_cursor_recorded: BOOLEAN
			-- If report cursor recorded?

	saved_cursor: INTEGER
			-- Saved cursor in report

	save_current_cursor is
			-- Save current cursor position in report
		do
			saved_cursor := multi_search_performer.index
		end

invariant
	multi_search_performer_not_void: multi_search_performer /= Void

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

end -- class EB_MULTI_SEARCH_TOOL
