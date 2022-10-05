note
	description: "Dialog to allow the user to choose a cluster or create one."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CREATE_CLUSTER_DIALOG

inherit
	EB_DIALOG

	COMPILER_EXPORTER
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

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EB_VISION2_FACILITIES
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EB_CLUSTER_MANAGER_OBSERVER
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EV_KEY_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		undefine
			default_create, copy
		end

	CONF_ACCESS
		undefine
			default_create, copy
		end

	SHARED_LOCALE
		undefine
			default_create, copy
		end

create
	make_default

feature {NONE} -- Initialization

	make_default (a_target: EB_DEVELOPMENT_WINDOW; a_is_test_cluster_forced: like is_test_cluster_forced)
			-- Create the dialog and link it to a given development window (for modality).
		require
			a_target_not_void: a_target /= Void
		local
			vb: EV_VERTICAL_BOX
			buttons_box: EV_HORIZONTAL_BOX
			cancel_b: EV_BUTTON
			name_frame: EV_FRAME
			cluster_frame: EV_FRAME
			name_label: EV_LABEL
			path_label: EV_LABEL
			wid: INTEGER
			hb: EV_HORIZONTAL_BOX
		do
			target := a_target

			make_with_title (Interface_names.t_New_cluster)
			set_icon_pixmap (pixmaps.icon_pixmaps.new_cluster_icon)
			set_height (Layout_constants.dialog_unit_to_pixels (400))

				-- Build the widgets
			create cluster_entry
			create folder_entry
			create cluster_list.make_without_targets (a_target.menus.context_menu_factory)
			create recursive_box.make_with_text (Interface_names.l_All)
			create tests_cluster_box.make_with_text (Interface_names.l_tests_cluster)
			create name_label.make_with_text (Interface_names.L_cluster_name)
			create path_label.make_with_text (Interface_names.l_Path)

				-- Build the buttons
			create browse_button.make_with_text (Interface_names.B_browse)
			browse_button.set_pixmap (pixmaps.icon_pixmaps.general_open_icon)
			create create_button.make_with_text_and_action (Interface_names.b_Create, agent create_new_cluster)
			Layout_constants.set_default_width_for_button (create_button)
			create cancel_b.make_with_text_and_action (Interface_names.b_Cancel, agent destroy)
			Layout_constants.set_default_width_for_button (cancel_b)

				-- Build the frames
			create name_frame.make_with_text (Interface_names.l_Cluster_options)
			create cluster_frame.make_with_text (Interface_names.l_Parent_cluster)

				-- Setup the agents
			browse_button.select_actions.extend (agent start_browsing)

				-- Organize the options
			wid := name_label.minimum_width.max (path_label.minimum_width)
			create vb
			vb.set_padding (Layout_constants.Small_border_size)
			vb.set_border_width (Layout_constants.Small_border_size)
			name_label.set_minimum_width (wid)
			--path_label.set_minimum_width (wid)
			create hb
			hb.set_padding (Layout_constants.Small_border_size)
			extend_no_expand (hb, name_label)
			hb.extend (cluster_entry)
			vb.extend (hb)
			create hb
			hb.set_padding (Layout_constants.Small_border_size)
			extend_no_expand (hb, path_label)
			hb.extend (folder_entry)
			extend_no_expand (hb, browse_button)
			vb.extend (hb)
			create hb
			hb.extend (recursive_box)
			vb.extend (hb)
			create hb
			hb.extend (tests_cluster_box)
			vb.extend (hb)
			name_frame.extend (vb)

				-- Build the list
			create vb
			vb.set_padding (Layout_constants.Small_border_size)
			vb.set_border_width (Layout_constants.Small_border_size)
			cluster_list.set_minimum_size (Cluster_list_minimum_width, Cluster_list_minimum_height)
			cluster_list.select_actions.extend (agent check_for_tests_cluster)
			cluster_list.refresh
			vb.extend (cluster_list)
			cluster_frame.extend (vb)

				-- Build the button box
			create buttons_box
			buttons_box.set_padding (Layout_constants.Small_border_size)
			buttons_box.extend (create {EV_CELL}) -- Expandable item
			extend_no_expand (buttons_box, create_button)
			extend_no_expand (buttons_box, cancel_b)

				-- Build the vertical layout (Class name, File name, cluster, buttons)
			create vb
			vb.set_padding (Layout_constants.Small_border_size)
			vb.set_border_width (Layout_constants.Small_border_size)
			extend_no_expand (vb, name_frame)
			vb.extend (cluster_frame) -- Expandable item
			extend_no_expand (vb, buttons_box)

				-- Add the main container to the dialog.
			extend (vb)

				-- Setup the default buttons and show actions.
			set_default_cancel_button (cancel_b)
			set_default_push_button (create_button)

			is_test_cluster_forced := a_is_test_cluster_forced
			if is_test_cluster_forced then
				tests_cluster_box.enable_select
				tests_cluster_box.disable_sensitive
			end
		ensure
			target_set: target = a_target
		end

feature -- Basic operations

	call_default
			-- Display dialog and create a random cluster name.
		do
			if is_test_cluster_forced then
				default_cluster_name := "tests"
			else
				default_cluster_name := "new_cluster_" + new_cluster_counter.item.out
				new_cluster_counter.put (new_cluster_counter.item + 1)
			end
			is_default_cluster_name_set := True
			internal_call (default_cluster_name)
		end

	call_stone (a_stone: CLUSTER_STONE)
			-- Display dialog give `a_stone' as default place.
		require
			a_stone_not_void: a_stone /= Void
		do
			if is_test_cluster_forced then
				default_cluster_name := "tests"
			else
				default_cluster_name := "new_cluster_" + new_cluster_counter.item.out
				new_cluster_counter.put (new_cluster_counter.item + 1)
			end
			is_default_cluster_name_set := True
			cluster_list.show_stone (a_stone)
			cluster_entry.set_text (default_cluster_name)
			show_modal_to_window (target.window)
		end

	call (cluster_n: STRING)
			-- Display the dialog.
			-- Give `cluster_n' as the default cluster name in it.
		require
			valid_args: cluster_n /= Void
		do
			is_default_cluster_name_set := False
			default_cluster_name := Void
			call (cluster_n)
		end

feature {NONE} -- Status report

	is_test_cluster_forced: BOOLEAN
			-- Is user forced to create a test cluster?

feature {NONE} -- Implementation

	internal_call (cluster_n: STRING)
			-- Display the dialog.
			-- Give `cluster_n' as the default cluster name in it.
		require
			valid_args: cluster_n /= Void
		do
			if attached target.stone as st then
				cluster_list.show_stone (st)
			end
			cluster_entry.set_text (cluster_n.as_lower)
			show_modal_to_window (target.window)
		end

	new_cluster_counter: CELL [INTEGER]
			-- Counter for how many clusters have been created in current session.
		once
			create Result.put (1)
		ensure
			new_cluster_counter_not_void: Result /= Void
		end

	default_cluster_name: STRING
			-- Initial value for cluster name

	is_default_cluster_name_set: BOOLEAN
			-- Is default_cluster_name set?

	group: CONF_GROUP
			-- Group where to put newly created cluster.

	path: STRING_32
			-- Selected subfolder path to put newly created cluster.

	is_top_level: BOOLEAN
			-- Create a new top level cluster.

	chosen_dir: PATH
			-- The path to the created cluster.

	original_path: PATH
			-- The path with environment variables.

	cluster_name: STRING_32
			-- Name of the cluster entered by the user, in lower case.
		do
			Result := cluster_entry.text.as_lower
		ensure
			cluster_name_not_void: Result /= Void
		end

	aok: BOOLEAN
			-- Is the current state valid?

	tests_cluster_was_selected: BOOLEAN
			-- Was `tests_cluster_box' before selecting a test cluster been selected?

	change_parent_group
			-- Set `group' to selected cluster/library from tree.
		local
			l_folder: EB_CLASSES_TREE_FOLDER_ITEM
			clu: EB_SORTED_CLUSTER
		do
			is_top_level := False
			if cluster_list.selected_item /= Void then
				if attached {EB_CLASSES_TREE_HEADER_ITEM} cluster_list.selected_item as l_hdr then
					aok := True
					is_top_level := True
				else
					l_folder := {EB_CLASSES_TREE_FOLDER_ITEM} / cluster_list.selected_item
					if l_folder = Void then
						l_folder := {EB_CLASSES_TREE_FOLDER_ITEM} / cluster_list.selected_item.parent
					end
					if l_folder /= Void then
						clu := l_folder.data
					end
					if clu = Void or else not (clu.is_cluster or clu.is_library) then
						aok := False
						prompts.show_error_prompt (Warning_messages.w_unknown_cluster_name, Current, Void)
					elseif clu.actual_group.is_readonly then
						aok := False
						prompts.show_error_prompt (Warning_messages.w_Cannot_add_to_library_cluster (clu.actual_group.name), Current, Void)
					else
						aok := True
						group := clu.actual_group
						path := l_folder.path
					end
				end
			else
				aok := True
				is_top_level := True
			end
		ensure
			ok_implies_set: aok implies is_top_level or (group /= Void and then (group.is_cluster or group.is_library))
		end

	create_new_cluster
			-- Create new cluster
		local
			dir: DIRECTORY
			test_file: RAW_FILE
			base_name: READABLE_STRING_GENERAL
			in_recursive: BOOLEAN
		do
			aok := True
			if aok then
				check_valid_cluster_name
			end
			if aok then
				check
					not cluster_entry.text.is_empty
					-- The name wouldn't be valid otherwise.
				end
				base_name := cluster_name
				aok := Eiffel_universe.group_of_name (base_name) = Void
				if not aok then
					prompts.show_error_prompt (Warning_messages.w_cluster_name_already_exists (base_name), target.window, Void)
				end
			end
			if aok then
				change_parent_group
			end
			if aok then
				check_valid_cluster_path
			end
			if aok then
				if not is_top_level then
					check group_not_void: group /= Void end
					if group.is_cluster then
						in_recursive := attached {CONF_CLUSTER} group as l_clu and then l_clu.is_recursive
						if group.is_test_cluster and not tests_cluster_box.is_selected then
							prompts.show_error_prompt (warning_messages.w_cannot_create_cluster_in_tests_cluster, Current, Void)
							aok := False
						end
					end
				end
				if aok and not in_recursive then
					if is_top_level then
						aok := not eiffel_universe.target.system.date_has_changed
					else
						aok := not group.target.system.date_has_changed
					end
					if not aok then
						prompts.show_error_prompt (warning_messages.w_configuration_not_up_to_date_need_recompile, Current, Void)
					end
				end
				if aok then
					create dir.make_with_path (chosen_dir)
					create test_file.make_with_path (chosen_dir)
					if test_file.exists and then not dir.exists then
						prompts.show_error_prompt (Warning_messages.w_Not_a_directory (chosen_dir.name), Current, Void)
					elseif not dir.exists then
						create_directory (dir)
						if aok then
								-- if we are in a recursive cluster we don't need to do anything except refreshing
							if in_recursive then
								manager.refresh
							else
								real_create_cluster (base_name)
							end
						else
							prompts.show_error_prompt (Warning_messages.w_Cannot_create_directory (chosen_dir.name), Current, Void)
						end
					else
							-- if we are in a recursive cluster we don't need to do anything except refreshing
						if in_recursive then
							manager.refresh
						else
							real_create_cluster (base_name)
						end
					end
					destroy
				end
			end
		end

	real_create_cluster (name: READABLE_STRING_GENERAL)
			-- Really create the cluster.
			-- `name': name of the new cluster.
		require
			valid_params: name /= Void and then not name.is_empty and name.as_lower.is_equal (name)
		local
			l_is_tests_cluster: BOOLEAN
		do
			l_is_tests_cluster := tests_cluster_box.is_selected
			if is_top_level then
				manager.add_cluster (name, Void, original_path, l_is_tests_cluster)
			else
				manager.add_cluster (name, group, original_path, l_is_tests_cluster)
			end
			manager.last_added_cluster.set_recursive (recursive_box.is_selected)
		end

	create_directory (dir: DIRECTORY)
			-- Physically create the directory `dir'.
		require
			valid_state: aok
		local
			retried: BOOLEAN
		do
			if not retried then
				dir.create_dir
			end
			aok := not retried
		rescue
			retried := True
			retry
		end

	check_valid_cluster_name
			-- Check that name `cluster_name' is a valid cluster name.
			-- Only alphanumeric characters and underscores are allowed.
		require
			current_state_is_valid: aok
		local
			cn: READABLE_STRING_GENERAL
		do
			cn := cluster_name
			aok := not cn.is_empty and then (create {EIFFEL_SYNTAX_CHECKER}).is_valid_group_name (cn)
			if not aok then
				prompts.show_error_prompt (Warning_messages.w_invalid_cluster_name (cn), Current, Void)
			end
		end

	check_valid_cluster_path
			-- Check, via `aok', that the path entered is a valid one, and is not already used.
			-- Set `chosen_dir' and `ace_path' accordingly.
		require
			valid_state: aok
		local
			cp: PATH
			icp: PATH
			l_loc: CONF_DIRECTORY_LOCATION
--			l_cp_name: STRING_32
		do
			create cp.make_from_string (folder_entry.text)
				-- top level clusters need a path
			if is_top_level and cp.is_empty then
				aok := False
				prompts.show_error_prompt (warning_messages.w_cluster_path_not_valid, target.window, Void)
			elseif cp.is_empty or cp.name.same_string (cluster_name) then
					-- Either no path were set, or same as the cluster_name, so let's consider it is subfolder.
				chosen_dir := group.location.build_path (path, "").extended (cluster_name)
				original_path := chosen_dir
			else
--				l_cp_name := cp.name
				create l_loc.make (cp.name, Eiffel_universe.target)
				if not is_top_level and then group.is_cluster then
					if not path.is_empty then
							-- Case: add new folder into sub folder or recursive cluster
						l_loc.set_parent (create {CONF_DIRECTORY_LOCATION}.make ({STRING_32} "$|" + group.location.build_path (path, "").name, Eiffel_universe.target))
					else
						l_loc.set_parent (group.location)
					end
				end
				icp := l_loc.evaluated_directory
				aok := Eiffel_universe.cluster_of_location (icp).is_empty
				if not aok then
					prompts.show_error_prompt (Warning_messages.w_cluster_path_already_exists (icp.name), target.window, Void)
				else
					chosen_dir := icp
					original_path := cp
				end
			end
		ensure
			aok implies (chosen_dir /= Void and original_path /= Void)
		end

	check_for_tests_cluster
			-- Check if selected cluster in `cluster_list' is a test cluster. If so, disable sensitivity of
			-- `tests_cluster_box' and make it selected by default. If no test cluster is selected and
			-- sensitivity is still disabled, restore state of box before disabling it.
		local
			l_sensitive: BOOLEAN
		do
			if not is_test_cluster_forced then
				change_parent_group
				l_sensitive := True
				if aok and not is_top_level then
					l_sensitive := not group.is_test_cluster
				end
				if l_sensitive then
					if not tests_cluster_box.is_sensitive then
						tests_cluster_box.enable_sensitive
						if not tests_cluster_was_selected then
							tests_cluster_box.disable_select
						end
					end
				else
					if tests_cluster_box.is_sensitive then
						tests_cluster_was_selected := tests_cluster_box.is_selected
						tests_cluster_box.enable_select
						tests_cluster_box.disable_sensitive
					end
				end
			end
		end

	last_browsed_directory: PATH
			-- What was the last browsed directory when searching for a folder?
		do
			Result := preferences.development_window_data.last_browsed_cluster_directory
		end

	target: EB_DEVELOPMENT_WINDOW
			-- Associated target.

feature {NONE} -- Graphic interface

	start_browsing
			-- The user wants to browse to find a folder.
			-- Pop up a browse dialog.
		local
			bd: EV_DIRECTORY_DIALOG
			l_dir_text: STRING_32
			l_path: PATH
		do
			create bd
			bd.ok_actions.extend (agent set_path (bd))
			l_dir_text := folder_entry.text
			if not l_dir_text.is_empty then
				l_dir_text := (create {ENV_INTERP}).interpreted_string_32 (l_dir_text)
				create l_path.make_from_string (l_dir_text)
				if not (create {DIRECTORY}.make_with_path (l_path)).exists then
					l_path := Void
				end
			end
			if l_path = Void or else l_path.is_empty then
				l_path := last_browsed_directory
			end
			if
				l_path /= Void and then not l_path.is_empty and then
				(create {DIRECTORY}.make_with_path (l_path)).exists
			then
				bd.set_start_path (l_path)
			end
			bd.show_modal_to_window (Current)
		end

	set_path (bd: EV_DIRECTORY_DIALOG)
			-- Initialize the cluster path with the directory selected in `bd'.
		local
			dir: PATH
		do
			dir := bd.path
			folder_entry.set_text (dir.name)
			preferences.development_window_data.last_browsed_cluster_directory_preference.set_value (dir)
			if
				(attached dir.entry as l_dir_entry and is_default_cluster_name_set) and then
				(cluster_name.is_equal (default_cluster_name) or cluster_name.is_empty)
			then
				cluster_entry.change_actions.block
				cluster_entry.set_text (l_dir_entry.name)
				cluster_entry.change_actions.resume
			end
		end

feature {NONE} -- Vision2 widgets

	cluster_entry: EV_TEXT_FIELD
			-- Text field in which the user will type the name of the new cluster

	folder_entry: EV_TEXT_FIELD
			-- Text field in which the user will type the folder name of the new cluster

	browse_button: EV_BUTTON
			-- Button that lets the user browse to give a directory.

	recursive_box: EV_CHECK_BUTTON
			-- Check box that sets whether the cluster is recursive or not.

	tests_cluster_box: EV_CHECK_BUTTON
			-- Check box that determines whether the cluster should be a test cluster or not

	create_button: EV_BUTTON
			-- Button to create the class

	cluster_list: EB_CLASSES_TREE
			-- List of all available clusters.

feature {NONE} -- Constants

	Cluster_list_minimum_width: INTEGER
			-- Minimum width for the cluster list.
		do
			Result := Layout_constants.Dialog_unit_to_pixels (250)
		end

	Cluster_list_minimum_height: INTEGER
			-- Minimum height for the cluster list.
		do
			Result := Layout_constants.Dialog_unit_to_pixels (100)
		end

invariant
	recursive_box_valid: recursive_box /= Void and then not recursive_box.is_destroyed
	browse_button_valid: browse_button /= Void and then not browse_button.is_destroyed
	cluster_entry_valid: cluster_entry /= Void and then not cluster_entry.is_destroyed
	cluster_list_valid: cluster_list /= Void and then not cluster_list.is_destroyed
	create_button_valid: create_button /= Void and then not create_button.is_destroyed
	folder_entry_valid: folder_entry /= Void and then not folder_entry.is_destroyed
	default_cluster_name_not_void: is_default_cluster_name_set implies default_cluster_name /= Void
	target_not_void: target /= Void
	group_implies_path: group /= Void implies path /= Void

note
	copyright:	"Copyright (c) 1984-2022, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
