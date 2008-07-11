indexing
	description: "Widget to open an existing project."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_OPEN_PROJECT_WIDGET

inherit
	ANY

	EB_CONSTANTS
		export
			{NONE} all
		end

	EB_SHARED_MANAGERS
		export
			{NONE} all
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	EB_FILE_DIALOG_CONSTANTS
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	KL_SHARED_FILE_SYSTEM
		export
			{NONE} all
		end

	EB_SHARED_PIXMAPS
		export
			{NONE} all
		end

	SYSTEM_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_window: like parent_window) is
			-- Initialize current using `a_window' as top most parent.
		require
			a_window_not_void: a_window /= Void
			a_window_not_destroyed: not a_window.is_destroyed
		do
			parent_window := a_window
			create {EV_CELL} widget
			create last_state
			build_interface
		ensure
			parent_window_set: parent_window = a_window
		end

feature -- Access

	widget: EV_CONTAINER
			-- Parent for current widget.

	parent_window: EV_WINDOW
			-- Top level window containing `widget'.

	select_actions: EV_GRID_ROW_ACTION_SEQUENCE is
			-- Actions being triggered when an item is selected.
		do
			Result := projects_list.row_select_actions
		ensure
			select_actions_not_void: Result /= Void
		end

	deselect_actions: EV_GRID_ROW_ACTION_SEQUENCE is
			-- Actions being triggered when an item is deselected.
		do
			Result := projects_list.row_deselect_actions
		ensure
			deselect_actions_not_void: Result /= Void
		end

feature -- Status report

	has_selected_item: BOOLEAN is
			-- Does current has a selected item?
		do
			Result := not projects_list.selected_rows.is_empty
		end

	is_empty: BOOLEAN is
			-- Does current contain some existing project?
		do
			Result := projects_list.row_count = 0
		end

	has_error: BOOLEAN is
			-- Did we encounter an error while trying to parse a config file?
		do
			Result := last_state.has_system_error or last_state.has_missing_target_error
		end

feature -- Status Setting

	enable_sensitive is
			-- Make object sensitive to user input.
		do
			sensitive_container.enable_sensitive
			edit_project_button.enable_sensitive
			remove_project_button.enable_sensitive
		end

	disable_sensitive is
			-- Make object non-sensitive to user input.
		do
			sensitive_container.disable_sensitive
			edit_project_button.disable_sensitive
			remove_project_button.disable_sensitive
			last_selected_row := Void
		end

	remove_selection is
			-- Unselect currently selected item if any.
		do
			projects_list.remove_selection
			location_combo.wipe_out
			clean_button.disable_select
			remove_user_file.disable_select
			disable_sensitive
		end

	set_focus is
			-- Set focus to `projects_list'.
		do
			if not is_empty then
				projects_list.set_focus
			end
		end

feature -- Actions

	open_project is
			-- Open selected project and perform action selected in `action_combo'.
		require
			not_has_error: not has_error
			not_is_empty: not is_empty
			has_selected_item: has_selected_item
		local
			l_loader: EB_GRAPHICAL_PROJECT_LOADER
			l_item: EV_GRID_LABEL_ITEM
			l_factory: USER_OPTIONS_FACTORY
			l_project_initialized: BOOLEAN
		do
				-- Remove data associated to user file for selected project/target if any.
			if remove_user_file.is_sensitive and then remove_user_file.is_selected then
				if last_state.options /= Void then
					create l_factory
					l_factory.remove (last_state.options, selected_target)
				end
			end
				-- Find which project was selected.
			create l_loader.make (parent_window)
			l_loader.set_is_project_location_requested (False)
			l_project_initialized := eiffel_project.initialized
			if l_project_initialized then
				l_loader.enable_project_creation_or_opening_not_requested
			end
			l_item ?= projects_list.selected_rows.first.item (path_column_index)
			check l_item_not_void: l_item /= Void end

				-- Open selected project.
			l_loader.open_project_file (l_item.text,
				selected_target,
				location_combo.text,
				clean_button.is_selected)

			if not l_loader.has_error then
					-- No error occurred, we can now perform action selected in `action_combo'.
					-- Note that if `l_project_initialized' is set a new EiffelStudio instance
					-- will be launched.
				if action_combo.selected_item = compile_action_item then
					l_loader.set_is_compilation_requested (True)
					l_loader.melt_project (l_project_initialized)
				elseif action_combo.selected_item = freeze_action_item then
					l_loader.set_is_compilation_requested (True)
					l_loader.freeze_project (l_project_initialized)
				elseif action_combo.selected_item = finalize_action_item then
					l_loader.set_is_compilation_requested (True)
					l_loader.finalize_project (l_project_initialized)
				elseif action_combo.selected_item = precompile_action_item then
					l_loader.set_is_compilation_requested (True)
					l_loader.precompile_project (l_project_initialized)
				elseif action_combo.selected_item = open_action_item then
					if l_project_initialized and l_loader.is_project_ok then
							-- Open a new EiffelStudio session for sure since current
							-- system is already initialized.
						l_loader.open_project (True)
					end
				end
				parent_window.destroy
			end
		end

feature {NONE} -- Implementation: Graphical Access

	red_color, default_color: EV_COLOR
			-- Color used for `location_combo' when not valid/valid.

	location_combo, action_combo: EV_COMBO_BOX
			-- To choose an action and a location.

	open_action_item,
	compile_action_item,
	freeze_action_item,
	finalize_action_item,
	precompile_action_item: EV_LIST_ITEM
			-- Various possible actions available in `action_combo'.

	projects_list: ES_GRID
			-- List containing the last opened projects.

	add_project_button, edit_project_button, remove_project_button: EV_BUTTON
			-- Buttons for adding, editing, removing a project entry from list.

	clean_button: EV_CHECK_BUTTON
			-- Check button to recompile a project from scratch.

	remove_user_file: EV_CHECK_BUTTON
			-- Check button to remove user file.

	sensitive_container: EV_VERTICAL_BOX
			-- Container which contains all widgets that needs to be made sensitive or not.

feature {NONE} -- State information

	last_clean_state: BOOLEAN
			-- Selection status of `clean_button'. Needed to restore the proper status
			-- when changing action between `precompiled_action_item' and other actions.

	last_state: TUPLE [system: CONF_SYSTEM; options: USER_OPTIONS; target_name: STRING
		has_system_error: BOOLEAN; has_missing_target_error: BOOLEAN;
		last_error_message: STRING]
			-- Information about last project we have selected.

	last_selected_row: EV_GRID_ROW
			-- Last selected row of control.

	selected_target: STRING_32 is
			-- Selected target if any, empty string otherwise.
		local
			l_item: EV_GRID_CHOICE_ITEM
		do
			if has_selected_item then
				l_item ?= projects_list.selected_rows.first.item (target_column_index)
				if l_item /= Void then
					Result := l_item.text
				end
			end
			if Result = Void then
				create Result.make_empty
			end
		ensure
			selected_target_not_void: Result /= Void
		end

	selected_path: STRING_32 is
			-- Path of selected configuration if any, empty string otherwise.
		local
			l_item: EV_GRID_LABEL_ITEM
		do
			if has_selected_item then
				l_item ?= projects_list.selected_rows.first.item (path_column_index)
				if l_item /= Void then
					Result := l_item.text
				end
			end
			if Result = Void then
				create Result.make_empty
			end
		ensure
			selected_target_not_void: Result /= Void
		end

feature {NONE} -- Initialization

	build_interface is
			-- Build interface for choosing a project.
		local
			open_project_vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
			l_label: EV_LABEL
			l_minimum_size: INTEGER
			l_font: EV_FONT
		do
				-- For proper size computation
			create l_font

			create open_project_vb
			open_project_vb.set_border_width (Layout_constants.Small_border_size)
			open_project_vb.set_padding (Layout_constants.Default_border_size)

				-- Sensitive container
			create sensitive_container
			sensitive_container.set_padding (Layout_constants.Default_border_size)

			create projects_list
			create vb
			vb.set_border_width (1)
			vb.set_background_color ((create {EV_STOCK_COLORS}).black)
			vb.extend (projects_list)
			open_project_vb.extend (vb)

				-- Computing minimum size for buttons so that they have the same size
			l_minimum_size := 2 * layout_constants.large_border_size + l_font.string_width (interface_names.l_remove_project).max (
				l_font.string_width (interface_names.l_add_project_config_file)) + 24

			create hb
			hb.set_padding (Layout_constants.Small_padding_size)
			create add_project_button.make_with_text_and_action (Interface_names.l_add_project_config_file, agent open_existing_project_not_listed)
			add_project_button.set_minimum_width (l_minimum_size)
			add_project_button.align_text_left
			add_project_button.set_pixmap (pixmaps.icon_pixmaps.general_add_icon)
			hb.extend (add_project_button)
			hb.disable_item_expand (add_project_button)
			create edit_project_button.make_with_text_and_action (Interface_names.l_edit_project, agent edit_selected_project)
			edit_project_button.set_minimum_width (l_minimum_size)
			edit_project_button.set_pixmap (pixmaps.icon_pixmaps.tool_config_icon)
			edit_project_button.align_text_left
			projects_list.row_deselect_actions.force_extend (agent edit_project_button.disable_sensitive)
			projects_list.row_select_actions.force_extend (agent edit_project_button.enable_sensitive)
			hb.extend (edit_project_button)
			hb.disable_item_expand (edit_project_button)
			create remove_project_button.make_with_text_and_action (Interface_names.l_remove_project, agent remove_project_from_list)
			remove_project_button.set_minimum_width (l_minimum_size)
			remove_project_button.set_pixmap (pixmaps.icon_pixmaps.general_remove_icon)
			remove_project_button.align_text_left
			projects_list.row_deselect_actions.force_extend (agent remove_project_button.disable_sensitive)
			projects_list.row_select_actions.force_extend (agent remove_project_button.enable_sensitive)
			hb.extend (remove_project_button)
			hb.disable_item_expand (remove_project_button)
			hb.extend (create {EV_CELL})
			open_project_vb.extend (hb)
			open_project_vb.disable_item_expand (hb)

				-- Computing minimum size for labels so that combos are left aligned.
			l_minimum_size := 5 + l_font.string_width (interface_names.l_action_colon).max (
				l_font.string_width (interface_names.l_location_colon))

				-- Location combobox
			create hb
			hb.set_padding (layout_constants.small_padding_size)
			create l_label.make_with_text (interface_names.l_location_colon)
			l_label.align_text_left
			l_label.set_minimum_width (l_minimum_size)
			hb.extend (l_label)
			hb.disable_item_expand (l_label)
			create location_combo
			default_color := location_combo.foreground_color
			red_color := (create {EV_STOCK_COLORS}).red
			location_combo.change_actions.extend (agent on_location_changed)
			hb.extend (location_combo)
			sensitive_container.extend (hb)
			sensitive_container.disable_item_expand (hb)

				-- Action combobox
			create hb
			hb.set_padding (layout_constants.small_padding_size)
			create l_label.make_with_text (interface_names.l_action_colon)
			l_label.align_text_left
			l_label.set_minimum_width (l_minimum_size)
			hb.extend (l_label)
			hb.disable_item_expand (l_label)
			create action_combo
			action_combo.disable_edit
			l_font := action_combo.font
				-- Create items
			l_minimum_size := l_font.string_width (interface_names.l_open)
			create open_action_item.make_with_text (interface_names.l_open)
			open_action_item.set_pixmap (icon_pixmaps.general_open_icon)
			action_combo.extend (open_action_item)

			l_minimum_size := l_minimum_size.max (l_font.string_width (interface_names.l_compile))
			create compile_action_item.make_with_text (interface_names.l_compile)
			compile_action_item.set_pixmap (icon_pixmaps.project_melt_icon)
			action_combo.extend (compile_action_item)

			l_minimum_size := l_minimum_size.max (l_font.string_width (interface_names.l_freeze))
			create freeze_action_item.make_with_text (interface_names.l_freeze)
			freeze_action_item.set_pixmap (icon_pixmaps.project_freeze_icon)
			action_combo.extend (freeze_action_item)

			l_minimum_size := l_minimum_size.max (l_font.string_width (interface_names.l_finalize))
			create finalize_action_item.make_with_text (interface_names.l_finalize)
			finalize_action_item.set_pixmap (icon_pixmaps.project_finalize_icon)
			action_combo.extend (finalize_action_item)

			l_minimum_size := l_minimum_size.max (l_font.string_width (interface_names.l_precompile))
			create precompile_action_item.make_with_text (interface_names.l_precompile)
			precompile_action_item.set_pixmap (icon_pixmaps.project_melt_icon)
			action_combo.extend (precompile_action_item)

			action_combo.select_actions.extend (agent on_action_selected)

			action_combo.set_minimum_width (l_minimum_size + action_combo.pixmaps_width + extra_space_in_combo)
			hb.extend (action_combo)
			hb.disable_item_expand (action_combo)
			create clean_button.make_with_text (interface_names.l_clean)
			clean_button.select_actions.extend (agent on_clean_button_selected)
			hb.extend (clean_button)
			hb.disable_item_expand (clean_button)
			hb.extend (create {EV_CELL})
			sensitive_container.extend (hb)
			sensitive_container.disable_item_expand (hb)

				-- Recompile from scratch check box
				-- Remove user configuration file check box
			create remove_user_file.make_with_text (Interface_names.l_clean_user_file)
			sensitive_container.extend (remove_user_file)
			sensitive_container.disable_item_expand (remove_user_file)

			open_project_vb.extend (sensitive_container)
			open_project_vb.disable_item_expand (sensitive_container)

			widget.extend (open_project_vb)

			fill_projects_list
		end

	fill_projects_list is
			-- Fill `projects_list' with recently open projects.
		require
			is_empty: is_empty
		local
			lop: ARRAYED_LIST [STRING]
			project_exist: BOOLEAN
			i, n: INTEGER
			l_header: EV_GRID_HEADER
		do
				-- Now initialize grid behavior.
			projects_list.enable_single_row_selection
			projects_list.enable_last_column_use_all_width
			projects_list.enable_row_height_fixed
			projects_list.set_minimum_height (8 * projects_list.row_height)
			projects_list.pointer_double_press_actions.force_extend (agent on_double_click)
			projects_list.row_deselect_actions.force_extend (agent disable_sensitive)
			projects_list.key_press_actions.extend (agent on_key_pressed)

			lop := recent_projects_manager.recent_projects
			if not lop.is_empty then
				from
					lop.start
					i := 1
					n := 1
				until
					lop.after
				loop
					if
						lop.item /= Void and then not lop.item.is_empty and then
						is_file_readable (lop.item)
					then
						project_exist := True
						insert_new_project (lop.item, n)
						update_project (projects_list.row (n), True, True, False)
						n := n + 1
						i := i + 1
					end
					lop.forth
				end
			end
			if project_exist then
				projects_list.row (1).enable_select
			else
				projects_list.insert_new_column (name_column_index)
				projects_list.insert_new_column (target_column_index)
				projects_list.insert_new_column (path_column_index)
			end

			l_header := projects_list.header
			l_header.i_th (name_column_index).set_text (interface_names.l_name)
			l_header.i_th (target_column_index).set_text (interface_names.l_target)
			l_header.i_th (path_column_index).set_text (interface_names.l_path)

			if not is_empty then
				projects_list.column (name_column_index).set_width (5 +
					projects_list.column (name_column_index).required_width_of_item_span (1, i - 1))
				projects_list.column (target_column_index).set_width (5 +
					projects_list.column (target_column_index).required_width_of_item_span (1, i - 1))
				projects_list.column (path_column_index).set_width (5 +
					projects_list.column (path_column_index).required_width_of_item_span (1, i - 1))
			end
		ensure
			projects_list_created: projects_list /= Void
		end

	insert_new_project (a_project_file: STRING; a_row_index: INTEGER) is
			-- Create an empty new row for `a_project_file' in `projects_list'.
		require
			a_project_file_not_void: a_project_file /= Void
			a_project_file_not_empty: not a_project_file.is_empty
			a_project_file_exists: is_file_readable (a_project_file)
			a_row_index_valid: a_row_index > 0 and a_row_index <= projects_list.row_count + 1
		local
			li: EV_GRID_LABEL_ITEM
			lc: EV_GRID_CHOICE_ITEM
			l_row: EV_GRID_ROW
		do
			projects_list.insert_new_row (a_row_index)
			l_row := projects_list.row (a_row_index)

			create li
			l_row.set_item (name_column_index, li)
			create lc
			lc.pointer_button_press_actions.force_extend (agent on_choose_target (lc))
			l_row.set_item (target_column_index, lc)
			create li.make_with_text (a_project_file)
			l_row.set_item (path_column_index, li)

			l_row.select_actions.extend (agent on_project_selected (l_row))
		ensure
			new_row: projects_list.row_count = old projects_list.row_count + 1
			valid_column_count: projects_list.column_count = 3
			name_item_not_void: projects_list.item (name_column_index, projects_list.row_count) /= Void
			target_item_not_void: projects_list.item (target_column_index, projects_list.row_count) /= Void
			path_item_not_void: projects_list.item (path_column_index, projects_list.row_count) /= Void
		end

feature {NONE} -- Implementation

	update_project (a_row: EV_GRID_ROW; is_initializing, is_new_selection, is_new_action: BOOLEAN) is
			-- Update project associated to `a_row'.
			-- If `is_initializing', read the last saved options and display them,
			--   otherwise use the last settings made by user.
			-- If `is_new_selection', it will force a reread of the configuration and user options.
			-- If `is_new_action', it will simply update `clean_button'.
		require
			a_row_not_void: a_row /= Void
			name_item_not_void: a_row.item (name_column_index) /= Void
			target_item_not_void: a_row.item (target_column_index) /= Void
			path_item_not_void: a_row.item (path_column_index) /= Void
		local
			ln, lp: EV_GRID_LABEL_ITEM
			lt: EV_GRID_CHOICE_ITEM
			l_filepath: STRING
			l_conf: CONF_LOAD
			l_project_location: PROJECT_DIRECTORY
			l_project_file: PROJECT_EIFFEL_FILE
			l_options: USER_OPTIONS
			l_pixmap: EV_PIXMAP
			l_tooltip: STRING_GENERAL
			l_last_location, l_last_target: STRING
			l_targets: DS_ARRAYED_LIST [STRING]
			l_force_clean: BOOLEAN
		do
			ln ?= a_row.item (name_column_index)
			lt ?= a_row.item (target_column_index)
			lp ?= a_row.item (path_column_index)
			check
				ln_not_void: ln /= Void
				lt_not_void: lt /= Void
				lp_not_void: lp /= Void
			end
			l_filepath := lp.text

			if is_new_selection then
				create l_conf.make (create {CONF_COMP_FACTORY})
				l_conf.retrieve_configuration (l_filepath)
				if not l_conf.is_error then
					last_state.has_system_error := False
					last_state.system := l_conf.last_system
					read_user_options (l_conf.last_system.file_name)
					if not has_error then
						l_options := last_state.options
					end
				else
					last_state.last_error_message := l_conf.last_error.text
					last_state.has_system_error := True
				end
					-- Reset last chosen target.
				last_state.target_name := Void
			else
				l_options := last_state.options
			end

			if last_state.has_system_error then
				l_pixmap := icon_pixmaps.general_error_icon
				l_tooltip := last_state.last_error_message
			else
				if is_new_selection or is_initializing then
					if l_options /= Void and then l_options.target.last_location /= Void then
						l_last_location := l_options.target.last_location
					else
						l_last_location := file_system.dirname (last_state.system.file_name)
					end
					l_targets := available_targets (last_state.system)
					if l_targets.is_empty then
						last_state.has_missing_target_error := True
					else
						last_state.has_missing_target_error := False
						if l_options /= Void then
							l_last_target := l_options.target_name
							if not l_targets.has (l_last_target) then
								l_last_target := l_targets.first
							end
						else
							l_last_target := l_targets.first
						end
					end
				else
					l_last_location := location_combo.text
					l_last_target := selected_target
				end
				last_state.target_name := l_last_target
				if last_state.has_missing_target_error then
						-- No compilable targets specified. It is an error and we cannot
						-- compile project.
					l_pixmap := icon_pixmaps.general_error_icon
					l_tooltip := warning_messages.w_no_compilable_target
				else
					create l_project_location.make (l_last_location, l_last_target)
					if l_project_location.is_compiled then
						l_project_file := l_project_location.project_file
						l_project_file.check_version_number (0)
						if l_project_file.has_error then
							l_pixmap := pixmaps.icon_pixmaps.general_warning_icon
							l_force_clean := True
							if not is_initializing and not is_new_action then
								action_combo.select_actions.block
								compile_action_item.enable_select
								action_combo.select_actions.resume
							end
							if l_project_file.is_corrupted then
								l_tooltip := warning_messages.w_project_corrupted (l_project_location.location)
							elseif l_project_file.is_incompatible then
								l_tooltip := warning_messages.w_project_incompatible (
									l_project_location.location, version_number,
									l_project_file.project_version_number)
							else
									-- We don't really know the cause, we assume it is somewhat corrupted.
								l_tooltip := warning_messages.w_project_corrupted (l_project_location.location)
							end
						else
							if not is_initializing and not is_new_action then
								action_combo.select_actions.block
								open_action_item.enable_select
								action_combo.select_actions.resume
							end
							l_pixmap := icon_pixmaps.document_eiffel_project_compiled_icon
						end
					else
						l_force_clean := True
						if not is_initializing and not is_new_action then
							action_combo.select_actions.block
							compile_action_item.enable_select
							action_combo.select_actions.resume
						end
						l_pixmap := icon_pixmaps.document_eiffel_project_icon
					end
					if not is_initializing then
						if
							l_force_clean or else
							is_new_action and then action_combo.selected_item = precompile_action_item
						then
							last_clean_state := clean_button.is_selected
							clean_button.select_actions.block
							clean_button.enable_select
							clean_button.select_actions.resume
							clean_button.disable_sensitive
						else
							if is_new_selection or not last_clean_state then
								clean_button.disable_select
							else
								clean_button.enable_select
							end
							clean_button.enable_sensitive
						end
					end
				end
			end

			ln.set_pixmap (l_pixmap)
			ln.set_tooltip (l_tooltip)
			lt.set_tooltip (l_tooltip)
			lp.set_tooltip (l_tooltip)

			if not last_state.has_system_error then
				if is_new_selection or is_initializing then
					ln.set_text (last_state.system.name)
					if not last_state.has_missing_target_error then
						lt.pointer_button_press_actions.wipe_out
						lt.pointer_button_press_actions.force_extend (agent on_choose_target (lt))
						lt.deactivate_actions.wipe_out
						lt.deactivate_actions.extend (agent on_target_selected (lt.row))
						update_targets (lt)
						a_row.set_foreground_color (default_color)
					else
						a_row.set_foreground_color (red_color)
					end
				end
			else
				ln.set_text (interface_names.l_error)
				lt.remove_text

				a_row.set_foreground_color (red_color)
			end

			if has_error and not is_initializing then
				sensitive_container.disable_sensitive
			end
		end

	update_targets (a_item: EV_GRID_CHOICE_ITEM) is
			-- Fill `a_item' with targets of `a_config'.
		require
			a_item_not_void: a_item /= Void
			not_has_error: not has_error
		local
			l_list: DS_ARRAYED_LIST [STRING]
			l_array: ARRAYED_LIST [STRING]
			l_has_target: BOOLEAN
		do
				-- Targets in alphabetical order.
			l_list := available_targets (last_state.system)

			from
				create l_array.make (l_list.count)
				l_list.start
			until
				l_list.after
			loop
				l_array.extend (l_list.item_for_iteration)
				if
					not l_has_target and then
					last_state.options /= Void and then
					l_list.item_for_iteration.is_case_insensitive_equal (last_state.options.target_name)
				then
					l_has_target := True
					a_item.set_text (last_state.options.target_name)
				end
				l_list.forth
			end

			a_item.set_item_strings (l_array)
			if not l_has_target and not l_list.is_empty then
				a_item.set_text (l_array.first)
			end
		end

	available_targets (a_config: CONF_SYSTEM): DS_ARRAYED_LIST [STRING] is
			-- List of targets of `a_config'.
		require
			a_config_not_void: a_config /= Void
		local
			l_targets: HASH_TABLE [CONF_TARGET, STRING]
		do
				-- Order targets in alphabetical order.
			from
				l_targets := a_config.compilable_targets
				create Result.make_equal (l_targets.count)
				l_targets.start
			until
				l_targets.after
			loop
				Result.put_last (l_targets.key_for_iteration)
				l_targets.forth
			end
			Result.sort (
				create {DS_QUICK_SORTER [STRING]}.make (create {KL_COMPARABLE_COMPARATOR [STRING]}.make))
		ensure
			available_targets_not_void: Result /= Void
		end

	fill_locations is
			-- Fill `location_combo' with last locations for currently selected target for `last_state.system'.
		require
			not_has_error: not has_error
		local
			l_item: EV_LIST_ITEM
			l_eifgens: ARRAYED_LIST [STRING]
			l_target_options: TARGET_USER_OPTIONS
		do
			location_combo.change_actions.block
			location_combo.set_foreground_color (default_color)
			location_combo.wipe_out
			if last_state.options /= Void then
					-- Let's get the target options if any.
				l_target_options := last_state.options.target_of_name (selected_target)
			end
			if l_target_options = Void or else l_target_options.locations = Void then
					-- No target options found, we do as if there were no options yet.
				create l_item.make_with_text (file_system.dirname (last_state.system.file_name))
				l_item.select_actions.extend (agent on_location_selected)
				location_combo.extend (l_item)
				l_item.enable_select
			else
					-- Fill combo box.
					-- Note that the last used location will be selected because
					-- in USER_OPTIONS, `eifgen = eifgens.first'.
				from
					l_eifgens := l_target_options.locations
					l_eifgens.start
				until
					l_eifgens.after
				loop
					create l_item.make_with_text (l_eifgens.item)
					l_item.select_actions.extend (agent on_location_selected)
					location_combo.extend (l_item)
					if location_combo.count = 1 then
						l_item.enable_select
					end
					l_eifgens.forth
				end
			end

				-- Add Browse for new location.
			create l_item.make_with_text (interface_names.b_browse)
			l_item.select_actions.extend (agent add_location)
			location_combo.extend (l_item)

			location_combo.change_actions.resume
		end

	read_user_options (a_file_path: STRING) is
			-- Read user data for project of path `a_file_path'.
		require
			a_file_path_not_void: a_file_path /= Void
		local
			l_factory: USER_OPTIONS_FACTORY
		do
			create l_factory
			l_factory.load (a_file_path)
			if l_factory.successful then
				last_state.options := l_factory.last_options
			else
				last_state.options := Void
			end
		end

	save_projects_list is
			-- Save current list of projects directly to preferences.
		local
			l_item: EV_GRID_LABEL_ITEM
			i, nb: INTEGER
			l_projects: ARRAYED_LIST [STRING]
		do
				-- Search first if it is a file which is already in the list.
				-- If in the list, we simply ensure it is visible and selected.
			from
				i := 1
				nb := projects_list.row_count
				create l_projects.make (nb)
				l_projects.compare_objects
			until
				i > nb
			loop
				l_item ?= projects_list.row (i).item (path_column_index)
				check l_item_not_void: l_item /= Void end
				l_projects.extend (l_item.text)
				i := i + 1
			end

			recent_projects_manager.save_projects (l_projects)
		end

feature {NONE} -- Actions

	open_existing_project_not_listed is
			-- Open a non listed existing project
		local
			fod: EB_FILE_OPEN_DIALOG
			environment_variable: EXECUTION_ENVIRONMENT
			last_directory_opened: STRING
		do
				-- User just asked for an open file dialog,
				-- and we set it on the last opened directory.
			create environment_variable
			create fod.make_with_preference (preferences.dialog_data.last_opened_project_directory_preference)
			last_directory_opened := environment_variable.get (studio_directory_list)
			if last_directory_opened /= Void then
				fod.set_start_directory (last_directory_opened.substring (1,
					last_directory_opened.index_of(';',1) -1 ))
			end
			fod.set_title (Interface_names.t_select_a_file)
			set_dialog_filters_and_add_all (fod,
				<<config_files_filter, ace_files_filter, eiffel_project_files_filter>>)
			fod.open_actions.extend (agent file_choice_callback (fod))
			fod.show_modal_to_window (parent_window)
		end

	edit_selected_project is
			-- Edit selected project.
		require
			not_is_empty: not is_empty
			has_selected_item: has_selected_item
		local
			l_fact: CONF_COMP_FACTORY
			l_load: CONF_LOAD
			l_system: CONF_SYSTEM
			l_window: CONFIGURATION_WINDOW
			l_row: like last_selected_row
		do
			create l_fact
			create l_load.make (l_fact)
			l_load.retrieve_configuration (selected_path)
			if l_load.is_error then
				(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (l_load.last_error.out, parent_window, Void)
			else
					-- display warnings
				if l_load.is_warning then
					(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_warning_prompt (l_load.last_warning_messages, parent_window, Void)
				end

				l_system := l_load.last_system
				create l_window.make (l_system, l_fact, Void, pixmaps.configuration_pixmaps, agent (preferences.misc_data).external_editor_cli)

				l_window.set_size (preferences.dialog_data.project_settings_width, preferences.dialog_data.project_settings_height)
				l_window.set_position (preferences.dialog_data.project_settings_position_x, preferences.dialog_data.project_settings_position_y)
				l_window.set_split_position (preferences.dialog_data.project_settings_split_position)

				l_window.show_modal_to_window (parent_window)

				preferences.dialog_data.project_settings_width_preference.set_value (l_window.width)
				preferences.dialog_data.project_settings_height_preference.set_value (l_window.height)
				preferences.dialog_data.project_settings_position_x_preference.set_value (l_window.x_position)
				preferences.dialog_data.project_settings_position_y_preference.set_value (l_window.y_position)
				preferences.dialog_data.project_settings_split_position_preference.set_value (l_window.split_position)

				l_row := last_selected_row
				last_selected_row := Void
				on_project_selected (l_row)
			end
		end

	remove_project_from_list is
			-- Remove selected project from `project_lists'.
		require
			not_is_empty: not is_empty
			has_selected_item: has_selected_item
		local
			i: INTEGER
		do
			i := projects_list.selected_rows.first.index
			projects_list.remove_row (i)
			i := i - 1
			if i > 0 and i <= projects_list.row_count then
					-- Select previous row.
				projects_list.row (i).ensure_visible
				projects_list.row (i).enable_select
			elseif i <= 0 and then projects_list.row_count > 0 then
					-- Select first row.
				projects_list.row (1).ensure_visible
				projects_list.row (1).enable_select
			end
			save_projects_list
			if remove_project_button.is_sensitive then
				remove_project_button.set_focus
			else
				add_project_button.set_focus
			end
		end

	file_choice_callback (a_dlg: EB_FILE_OPEN_DIALOG) is
			-- This is a callback from the name chooser.
			-- We get the project name and then insert it to the list of projects.
		require
			a_dlg_not_void: a_dlg /= Void
			a_dlg_not_destroyed: not a_dlg.is_destroyed
		local
			l_filename: STRING
			l_item: EV_GRID_LABEL_ITEM
			l_has_file, l_is_ecf: BOOLEAN
			i, nb: INTEGER
			l_conf: CONF_LOAD
			l_factory: CONF_COMP_FACTORY
			l_loader: EB_GRAPHICAL_PROJECT_LOADER
		do
			projects_list.remove_selection

			l_filename := a_dlg.file_name
				-- Check if we have a .ecf extension.
			l_is_ecf := l_filename.count >= 4 and then
				l_filename.substring_index (config_extension, 1) = l_filename.count - 2 and then
				l_filename.item (l_filename.count - 3) = '.'

				-- Try to see if we can load the project.
				-- If not, it is either an incorrect configuration file
			create l_factory
			create l_conf.make (l_factory)
			l_conf.retrieve_configuration (l_filename)
			if l_conf.is_error and (not l_is_ecf and l_conf.is_invalid_xml) then
				create l_loader.make (parent_window)
				l_loader.convert_project (l_filename)
				if l_loader.has_error then
					l_filename := Void
				else
					l_filename := l_loader.converted_file_name
				end
			end

			if l_filename /= Void then
					-- Search first if it is a file which is already in the list.
					-- If in the list, we simply ensure it is visible and selected.
				from
					i := 1
					nb := projects_list.row_count
				until
					i > nb or l_has_file
				loop
					l_item ?= projects_list.row (i).item (path_column_index)
					check l_item_not_void: l_item /= Void end
					l_has_file := l_item.text.is_equal (l_filename)
					if l_has_file then
						projects_list.row (i).ensure_visible
						projects_list.row (i).enable_select
					end
					i := i + 1
				end

				if not l_has_file then
						-- It is not in the list, we insert it at the top of the list
						-- and show it.
					insert_new_project (l_filename, 1)
					update_project (projects_list.row (1), True, True, False)
					projects_list.row (1).ensure_visible
					projects_list.row (1).enable_select
					if not has_error then
						fill_locations
					end

					save_projects_list
				end
			end
		end

	on_project_selected (a_row: EV_GRID_ROW) is
			-- Update content with selected project `a_project_path'.
		require
			a_row_not_void: a_row /= Void
			name_item_not_void: a_row.item (name_column_index) /= Void
			target_item_not_void: a_row.item (target_column_index) /= Void
			path_item_not_void: a_row.item (path_column_index) /= Void
		do
			enable_sensitive
				-- Only update content if selection is the same.
			if last_selected_row /= a_row then
				last_selected_row := a_row
				update_project (a_row, False, True, False)
				if not has_error then
					fill_locations
				end
			end
		end

	on_location_changed is
			-- Perform location validation.
		local
			l_location: STRING
			l_dir: DIRECTORY
		do
			l_location := location_combo.text
			create l_dir.make (l_location)
			if not l_dir.exists then
				location_combo.set_foreground_color (red_color)
			else
				location_combo.set_foreground_color (default_color)
			end
			on_location_selected
		end

	on_location_selected is
			-- Update interface when location changed.
		require
			has_selected_item: has_selected_item
		do
			if not location_combo.text.is_empty and then not selected_target.is_empty then
					-- Location has changed, we need to clear `clean_button'.
				clean_button.disable_select
					-- Then update interface
				update_project (projects_list.selected_rows.first, False, False, False)
			end
		end

	on_action_selected is
			-- Update interface when action changed.
		do
			if not is_empty and has_selected_item then
				update_project (projects_list.selected_rows.first, False, False, True)
			end
		end

	on_target_selected (a_row: EV_GRID_ROW) is
			-- Update interface when new target has been selected.
		require
			a_row_not_void: a_row /= Void
			name_item_not_void: a_row.item (name_column_index) /= Void
			target_item_not_void: a_row.item (target_column_index) /= Void
			path_item_not_void: a_row.item (path_column_index) /= Void
		do
			if
				last_state.target_name = Void or else
				not last_state.target_name.is_equal (selected_target)
			then
					-- Target has changed, we need to clear `clean_button'.
				clean_button.disable_select
					-- Then update interface
				update_project (a_row, False, False, False)
			end
		end

	on_clean_button_selected is
			-- Remember last state chosen by user. It is necessary to restore the state in case he chose
			-- `precompile_action_item' and decide to choose something else after.
		do
			last_clean_state := clean_button.is_selected
		end

	on_choose_target (a_item: EV_GRID_CHOICE_ITEM) is
			-- Activate the combo enabling user to choose project's target
		require
			a_item_not_void: a_item /= Void
			a_item_not_destroyed: not a_item.is_destroyed
		do
			if a_item.item_strings /= Void and then a_item.item_strings.index_set.count > 1 then
				a_item.activate
			end
		end

	on_double_click (x, y: INTEGER) is
			-- Open currently selected project if valid.
		local
			l_row: EV_GRID_ROW
		do
			if y > projects_list.viewable_y_offset then
				l_row := projects_list.row_at_virtual_position (y + projects_list.virtual_y_position - projects_list.viewable_y_offset, True)
				if l_row /= Void and not is_empty and has_selected_item then
					on_project_selected (projects_list.selected_rows.first)
					if not has_error then
						open_project
					end
				end
			end
		end

	on_key_pressed (a_key: EV_KEY) is
			-- Action when user press a key in `projects_list'.
			-- At the moment only handle F4 to enable user to chose a target if more than one is available
			-- for currently selected project.
		local
			l_item: EV_GRID_CHOICE_ITEM
		do
			if a_key /= Void and then a_key.code = {EV_KEY_CONSTANTS}.key_f4 and then has_selected_item then
				l_item ?= projects_list.selected_rows.first.item (target_column_index)
				check l_item /= Void end
				l_item.activate
			end
		end

	add_location is
			-- Add new location to combobox.
			-- Select a new location.
		local
			l_dlg: EV_DIRECTORY_DIALOG
			l_item: EV_LIST_ITEM
			l_dir: STRING
			l_has_dir: BOOLEAN
		do
			create l_dlg
			l_dlg.show_modal_to_window (parent_window)
			if l_dlg.directory /= Void and then not l_dlg.directory.is_empty then
				l_dir := l_dlg.directory
				from
					location_combo.start
				until
					location_combo.after
				loop
					if location_combo.item.text.is_equal (l_dir) then
						l_has_dir := True
						location_combo.item.enable_select
					end
					location_combo.forth
				end
				if not l_has_dir then
					create l_item.make_with_text (l_dlg.directory)
					location_combo.put_front (l_item)
					l_item.enable_select
				end
			else
					-- Select first item when browse action was cancelled.
				location_combo.first.enable_select
			end
		end

feature {NONE} -- Convenience

	is_file_readable (a_file_name: STRING): BOOLEAN is
			-- Does file of path `a_file_name' exist and is readable?
		require
			a_file_name_not_void: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
		local
			l_file: RAW_FILE
		do
			create l_file.make (a_file_name)
			Result := l_file.exists and then l_file.is_readable
		end

	name_column_index: INTEGER is 1
	target_column_index: INTEGER is 2
	path_column_index: INTEGER is 3
			-- Index in grid for each column.

	extra_space_in_combo: INTEGER = 32
			-- Extra width in a combo box including dropdown button and space between pixmap and text.

invariant
	last_state_not_void: last_state /= Void
	parent_window_not_void: parent_window /= Void
	widget_not_void: widget /= Void
	projects_list_not_void: projects_list /= Void
	location_combo_not_void: location_combo /= Void
	action_combo_not_void: action_combo /= Void
	remove_user_file_not_void: remove_user_file /= Void
	clean_button_not_void: clean_button /= Void
	red_color_not_void: red_color /= Void
	default_color_not_void: default_color /= Void
	open_action_item_not_void: open_action_item /= Void
	compile_action_item_not_void: compile_action_item /= Void
	freeze_action_item_not_void: freeze_action_item /= Void
	finalize_action_item_not_void: finalize_action_item /= Void
	precompile_action_item_not_void: precompile_action_item /= Void
	add_project_button_not_void: add_project_button /= Void
	edit_project_button_not_void: edit_project_button /= Void
	remove_project_button_not_void: remove_project_button /= Void

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
