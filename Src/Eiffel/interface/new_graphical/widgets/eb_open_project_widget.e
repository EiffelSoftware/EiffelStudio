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
			build_interface
		ensure
			parent_window_set: parent_window = a_window
		end

feature -- Access

	widget: EV_CONTAINER
			-- Parent for current widget.

	parent_window: EV_WINDOW
			-- Top level window containing `widget'.

	select_actions: EV_GRID_ITEM_ACTION_SEQUENCE is
			-- Actions being triggered when item is selected.
		do
			Result := compiled_projects_list.item_select_actions
		ensure
			select_actions_not_void: Result /= Void
		end

feature -- Status report

	has_selected_item: BOOLEAN is
			-- Does current has a selected item?
		do
			Result := not compiled_projects_list.selected_items.is_empty
		end

	is_empty: BOOLEAN is
			-- Does current contain some existing project?
		do
			Result := compiled_projects_list.row_count = 0
		end

	has_error: BOOLEAN
			-- Did we encounter an error while trying to parse a config file?

feature -- Status Setting

	enable_sensitive is
			-- Make object sensitive to user input.
		do
			has_error := False
			sensitive_container.enable_sensitive
			status_label.enable_sensitive
			status_label.hide
		end

	disable_sensitive is
			-- Make object non-sensitive to user input.
		do
			has_error := False
			sensitive_container.disable_sensitive
			status_label.disable_sensitive
			status_label.hide
		end

	remove_selection is
			-- Unselect currently selected item if any.
		do
			if not compiled_projects_list.selected_items.is_empty then
				compiled_projects_list.remove_selection
				target_combo.wipe_out
				location_combo.wipe_out
				status_label.remove_text
				status_label.hide
				recompile_button.disable_select
				remove_user_file.disable_select
				disable_sensitive
			end
		end

feature -- Actions

	open_project is
			-- Open selected project.
		require
			not_has_error: not has_error
			not_is_empty: not is_empty
			has_selected_item: has_selected_item
		local
			l_loader: EB_GRAPHICAL_PROJECT_LOADER
			l_item: EV_GRID_LABEL_ITEM
			l_factory: USER_OPTIONS_FACTORY
		do
			if remove_user_file.is_sensitive and then remove_user_file.is_selected then
				if user_options /= Void then
					create l_factory
					l_factory.remove (user_options, target_combo.text)
				end
			end
			create l_loader.make (parent_window)
			l_loader.set_is_project_location_requested (False)
			l_item ?= compiled_projects_list.selected_items.first
			l_loader.open_project_file (l_item.text,
				target_combo.text,
				location_combo.text,
				recompile_button.is_sensitive and then recompile_button.is_selected)
			if not l_loader.has_error then
				if recompile_button.is_sensitive and then recompile_button.is_selected then
					l_loader.set_is_compilation_requested (True)
					l_loader.compile_project
				end
				parent_window.destroy
			end
		end

feature {NONE} -- Implementation: Access

	red_color, default_color: EV_COLOR
			-- Color used for `location_combo' when not valid/valid.

	target_combo, location_combo: EV_COMBO_BOX
			-- To choose a target and a location.

	status_label: EV_LABEL
			-- Placeholder were error messages will appear.

	compiled_projects_list: ES_GRID
			-- List containing the last opened projects.

	recompile_button: EV_CHECK_BUTTON
			-- Check button to recompile a project from scratch.

	remove_user_file: EV_CHECK_BUTTON
			-- Check button to remove user file.

	user_options: USER_OPTIONS
			-- Last read user options after a call to `read_user_options'.
			-- Might be Void if no user options created for a given project.

	sensitive_container: EV_VERTICAL_BOX
			-- Container which contains all widgets that needs to be made sensitive or not.

feature {NONE} -- Implementation

	record_error (a_msg: STRING) is
			-- Record error message `a_msg'.
		require
			a_msg_not_void: a_msg /= Void
		do
			sensitive_container.disable_sensitive
			status_label.set_text (a_msg)
			status_label.show
			has_error := True
		ensure
			has_error_set: has_error
		end

	build_interface is
			--
		local
			open_project_vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
			l_label: EV_LABEL
			l_button: EV_BUTTON
			l_label_size: INTEGER
		do
			create open_project_vb
			open_project_vb.set_border_width (Layout_constants.Small_border_size)
			open_project_vb.set_padding (Layout_constants.Default_border_size)

				-- Sensitive container
			create sensitive_container
			sensitive_container.set_padding (Layout_constants.Default_border_size)

			create compiled_projects_list
			compiled_projects_list.hide_header
			compiled_projects_list.enable_single_row_selection
			compiled_projects_list.set_minimum_height (Layout_constants.Dialog_unit_to_pixels(80))
			create vb
			vb.set_border_width (1)
			vb.set_background_color ((create {EV_STOCK_COLORS}).black)
			vb.extend (compiled_projects_list)
			open_project_vb.extend (vb)

			create hb
			hb.set_padding (Layout_constants.Small_padding_size)
			create l_button.make_with_text_and_action (Interface_names.l_add_project_config_file, agent open_existing_project_not_listed)
			hb.extend (l_button)
			hb.disable_item_expand (l_button)
			create l_button.make_with_text_and_action (Interface_names.l_remove_project, agent remove_project_from_list)
			compiled_projects_list.item_deselect_actions.force_extend (agent l_button.disable_sensitive)
			compiled_projects_list.item_select_actions.force_extend (agent l_button.enable_sensitive)
			hb.extend (l_button)
			hb.disable_item_expand (l_button)
			hb.extend (create {EV_CELL})
			open_project_vb.extend (hb)
			open_project_vb.disable_item_expand (hb)

				-- Computing minimum size for labels so that combos are left aligned.
			l_label_size := 5 + (create {EV_FONT}).string_width (interface_names.l_target).max (
				(create {EV_FONT}).string_width (interface_names.l_location))

				-- Target combobox
			create hb
			create l_label.make_with_text (interface_names.l_target)
			l_label.align_text_left
			l_label.set_minimum_width (l_label_size)
			hb.extend (l_label)
			hb.disable_item_expand (l_label)
			create target_combo
			target_combo.disable_edit
			hb.extend (target_combo)
			sensitive_container.extend (hb)
			sensitive_container.disable_item_expand (hb)

				-- Location combobox
			create hb
			create l_label.make_with_text (interface_names.l_location)
			l_label.align_text_left
			l_label.set_minimum_width (l_label_size)
			hb.extend (l_label)
			hb.disable_item_expand (l_label)
			create location_combo
			default_color := location_combo.foreground_color
			red_color := (create {EV_STOCK_COLORS}).red
			location_combo.change_actions.extend (agent on_location_changed)
			hb.extend (location_combo)
			sensitive_container.extend (hb)
			sensitive_container.disable_item_expand (hb)

				-- Recompile from scratch check box
				-- Remove user configuration file check box
			create vb
			create recompile_button.make_with_text (Interface_names.l_fresh_compilation)
			vb.extend (recompile_button)
			vb.disable_item_expand (recompile_button)
			create remove_user_file.make_with_text (Interface_names.l_clean_user_file)
			vb.extend (remove_user_file)
			vb.disable_item_expand (remove_user_file)
			sensitive_container.extend (vb)
			sensitive_container.disable_item_expand (vb)

			open_project_vb.extend (sensitive_container)
			open_project_vb.disable_item_expand (sensitive_container)

				-- Error label.
			create status_label
			status_label.set_foreground_color ((create {EV_STOCK_COLORS}).red)
			status_label.align_text_left
			status_label.hide
			open_project_vb.extend (status_label)
			open_project_vb.disable_item_expand (status_label)

			widget.extend (open_project_vb)

			fill_compiled_projects_list
		end

	fill_compiled_projects_list is
			-- Create and fill `compiled_projects_list'
		require
			is_empty: is_empty
		local
			lop: ARRAYED_LIST [STRING]
			li: EV_GRID_LABEL_ITEM
			retried: BOOLEAN
			project_exist: BOOLEAN
			i: INTEGER
		do
			if not retried then
				lop := recent_projects_manager.recent_projects
				if not lop.is_empty then
					from
						lop.start
						i := 1
					until
						lop.after
					loop
						if exists_project (lop.item) then
							project_exist := True
							create li.make_with_text (lop.item)
							compiled_projects_list.insert_new_row (i)
							compiled_projects_list.row (i).set_item (1, li)
							compiled_projects_list.row (i).select_actions.extend (agent on_project_selected (lop.item))
							i := i + 1
						end
						lop.forth
					end
					if project_exist then
						compiled_projects_list.row (1).enable_select
					end
				end
			end
				-- Connect the list with `on_ok' via the wrapper `on_double_click'
			compiled_projects_list.pointer_double_press_actions.force_extend (agent on_double_click)
			compiled_projects_list.item_deselect_actions.force_extend (agent sensitive_container.disable_sensitive)
		ensure
			compiled_projects_list_created: compiled_projects_list /= Void
		rescue
			retried := True
			retry
		end

	fill_targets (a_config: CONF_SYSTEM) is
			-- Fill `target_combo' with targets of `a_config'.
		require
			a_config_not_void: a_config /= Void
			not_has_error: not has_error
			target_combo_empty: target_combo.is_empty
		local
			l_item: EV_LIST_ITEM
			l_targets: HASH_TABLE [CONF_TARGET, STRING]
			l_list: DS_ARRAYED_LIST [STRING]
			l_is_target_specified: BOOLEAN
		do
				-- Order targets in alphabetical order.
			from
				l_targets := a_config.compilable_targets
				create l_list.make (l_targets.count)
				l_targets.start
			until
				l_targets.after
			loop
				l_is_target_specified := l_is_target_specified or (
					user_options /= Void and then
					l_targets.key_for_iteration.is_case_insensitive_equal (user_options.target_name))
				l_list.put_last (l_targets.key_for_iteration)
				l_targets.forth
			end
			l_list.sort (create {DS_QUICK_SORTER [STRING]}.make (create {KL_COMPARABLE_COMPARATOR [STRING]}.make))

			from
				l_list.start
			until
				l_list.after
			loop
				create l_item.make_with_text (l_list.item_for_iteration)
				l_item.select_actions.extend (agent fill_locations (a_config))
				l_item.select_actions.extend (agent on_target_location_selected)
				target_combo.extend (l_item)
				if l_is_target_specified then
					if l_list.item_for_iteration.is_case_insensitive_equal (user_options.target_name) then
						l_item.enable_select
					end
				elseif target_combo.count = 1 then
					l_item.enable_select
				end
				l_list.forth
			end
		end

	fill_locations (a_config: CONF_SYSTEM) is
			-- Fill `target_combo' with `a_targets'.
		require
			a_config_not_void: a_config /= Void
			not_has_error: not has_error
			target_combo_not_empty: not target_combo.is_empty
		local
			l_item: EV_LIST_ITEM
			l_eifgens: ARRAYED_LIST [STRING]
			l_target_options: TARGET_USER_OPTIONS
		do
			location_combo.wipe_out
			if user_options /= Void then
				l_target_options := user_options.target_of_name (target_combo.text)
			end
			if l_target_options = Void or else l_target_options.locations = Void then
					-- Some error occurred, we do the same as if there were no
					-- user options yet.
				create l_item.make_with_text (file_system.dirname (a_config.file_name))
				l_item.select_actions.extend (agent on_target_location_selected)
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
					l_item.select_actions.extend (agent on_target_location_selected)
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
		end

	exists_project (a_project_path: STRING): BOOLEAN is
			-- Does the project `a_project_path' exists?
		local
			a_project_filename: FILE_NAME
			a_project_file: RAW_FILE
		do
			if a_project_path /= Void and then not a_project_path.is_empty then
				create a_project_filename.make_from_string (a_project_path)
				create a_project_file.make (a_project_filename)
				Result := a_project_file.exists and then a_project_file.is_readable
			end
		end

	read_user_options (a_uuid: UUID) is
			-- Read user data for project of UUID `a_uuid'.
		require
			a_uuid_not_void: a_uuid /= Void
		local
			l_factory: USER_OPTIONS_FACTORY
		do
			create l_factory
			l_factory.load (a_uuid)
			if l_factory.successful then
				user_options := l_factory.last_options
			else
				has_error := True
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
				nb := compiled_projects_list.row_count
				create l_projects.make (nb)
			until
				i > nb
			loop
				l_item ?= compiled_projects_list.row (i).item (1)
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
			last_directory_opened := environment_variable.get (Studio_Directory_List)
			if last_directory_opened /= Void then
				fod.set_start_directory (last_directory_opened.substring (1,last_directory_opened.index_of(';',1) -1 ))
			end
			fod.set_title (Interface_names.t_Select_a_file)
			set_dialog_filters_and_add_all (fod, <<config_files_filter, ace_files_filter, eiffel_project_files_filter>>)
			fod.open_actions.extend (agent file_choice_callback (fod))
			fod.show_modal_to_window (parent_window)
		end

	remove_project_from_list is
			-- Remove selected project from `compiled_project_lists'.
		require
			not_is_empty: not is_empty
			selected_item: not compiled_projects_list.selected_items.is_empty
		local
			i: INTEGER
		do
			i := compiled_projects_list.selected_items.first.row.index
			compiled_projects_list.remove_row (i)
			i := i - 1
			if i > 0 and i <= compiled_projects_list.row_count then
					-- Select previous row.
				compiled_projects_list.row (i).ensure_visible
				compiled_projects_list.row (i).enable_select
			elseif i <= 0 and then compiled_projects_list.row_count > 0 then
					-- Select first row.
				compiled_projects_list.row (1).ensure_visible
				compiled_projects_list.row (1).enable_select
			end
			save_projects_list
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
			l_has_file: BOOLEAN
			i, nb: INTEGER
			l_conf: CONF_LOAD
			l_factory: CONF_COMP_FACTORY
			l_loader: EB_GRAPHICAL_PROJECT_LOADER
		do
			compiled_projects_list.remove_selection

			l_filename := a_dlg.file_name

				-- Try to see if we can load the project.
				-- If not, it is either an incorrect configuration file
			create l_factory
			create l_conf.make (l_factory)
			l_conf.retrieve_configuration (l_filename)
			if l_conf.is_error then
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
					nb := compiled_projects_list.row_count
				until
					i > nb or l_has_file
				loop
					l_item ?= compiled_projects_list.row (i).item (1)
					check l_item_not_void: l_item /= Void end
					l_has_file := l_item.text.is_equal (l_filename)
					if l_has_file then
						compiled_projects_list.row (i).ensure_visible
						compiled_projects_list.row (i).enable_select
					end
					i := i + 1
				end

				if not l_has_file then
						-- It is not in the list, we insert it at the top of the list
						-- and show it.
					create l_item.make_with_text (l_filename)
					compiled_projects_list.insert_new_row (1)
					compiled_projects_list.row (1).set_item (1, l_item)
					compiled_projects_list.row (1).select_actions.extend (agent on_project_selected (l_filename))
					compiled_projects_list.row (1).ensure_visible
					compiled_projects_list.row (1).enable_select
					save_projects_list
				end
			end
		end

	on_project_selected (a_project_path: STRING) is
			-- Update content with selected project `a_project_path'.
		require
			a_project_path_not_void: a_project_path /= Void
		local
			l_conf: CONF_LOAD
			l_factory: CONF_COMP_FACTORY
			l_filepath: STRING
		do
			enable_sensitive
			l_filepath := a_project_path
			if not is_file_readable (l_filepath) then
				status_label.set_text (warning_messages.w_cannot_read_file (l_filepath))
				status_label.show
			else
				create l_factory
				create l_conf.make (l_factory)
				l_conf.retrieve_configuration (l_filepath)
				if l_conf.is_error then
					status_label.set_text (l_conf.last_error.out)
					status_label.show
				else
					read_user_options (l_conf.last_system.uuid)
					target_combo.wipe_out
					location_combo.wipe_out
					fill_targets (l_conf.last_system)
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
			on_target_location_selected
		end

	on_target_location_selected is
			-- Update interface with `a_target' to show if project was compiled or not.
		local
			l_project_location: PROJECT_DIRECTORY
			l_project_file: PROJECT_EIFFEL_FILE
		do
			if not location_combo.text.is_empty and then not target_combo.text.is_empty then
				create l_project_location.make (location_combo.text, target_combo.text)
				if l_project_location.is_compiled then
					l_project_file := l_project_location.project_file
					l_project_file.check_version_number (0)
					if l_project_file.has_error then
						recompile_button.set_text (interface_names.l_compile_project)
						recompile_button.enable_select
					else
						recompile_button.set_text (interface_names.l_fresh_compilation)
						recompile_button.disable_select
					end
				else
					recompile_button.set_text (interface_names.l_compile_project)
					recompile_button.enable_select
				end
			else
				remove_user_file.disable_select
				recompile_button.disable_select
			end
		end

	on_double_click is
			-- Open currently selected project if valid.
		local
			l_item: EV_GRID_LABEL_ITEM
		do
			if not is_empty and then has_selected_item then
				l_item ?= compiled_projects_list.selected_items.first
				check l_item_not_void: l_item /= Void end
				on_project_selected (l_item.text)
				if not has_error then
					open_project
				end
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

invariant
	parent_window_not_void: parent_window /= Void
	widget_not_void: widget /= Void
	compiled_projects_list_not_void: compiled_projects_list /= Void
	target_combo_not_void: target_combo /= Void
	location_combo_not_void: location_combo /= Void
	status_label_not_void: status_label /= Void
	remove_user_file_not_void: remove_user_file /= Void
	recompile_from_scratch_button_not_void: recompile_button /= Void
	red_color_not_void: red_color /= Void
	default_color_not_void: default_color /= Void

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
