indexing
	description: "Dialog to allow the user to choose a cluster or create one."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CREATE_CLUSTER_DIALOG

inherit
	EV_DIALOG

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

	EIFFEL_ENV
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

create
	make_default

feature {NONE} -- Initialization

	make_default (a_target: EB_DEVELOPMENT_WINDOW) is
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
			set_height (Layout_constants.dialog_unit_to_pixels (400).min ((create {EV_SCREEN}).height))
			set_icon_pixmap (Pixmaps.Icon_dialog_window)

				-- Build the widgets
			create cluster_entry
			create folder_entry
			create cluster_list
			create library_box.make_with_text (Interface_names.l_Library)
			create all_box.make_with_text (Interface_names.l_All)
			create top_radio.make_with_text (Interface_names.l_Top_level)
			create sub_radio.make_with_text (Interface_names.l_Sub_cluster)
			create name_label.make_with_text (Interface_names.L_cluster_name)
			create path_label.make_with_text (Interface_names.l_Path)

				-- Build the buttons
			create browse_button.make_with_text (Interface_names.B_browse)
			create create_button.make_with_text_and_action (Interface_names.b_Create, agent create_new_cluster)
			Layout_constants.set_default_size_for_button (create_button)
			create cancel_b.make_with_text_and_action (Interface_names.b_Cancel, agent destroy)
			Layout_constants.set_default_size_for_button (cancel_b)

				-- Build the frames
			create name_frame.make_with_text (Interface_names.l_Cluster_options)
			create cluster_frame.make_with_text (Interface_names.l_Parent_cluster)

				-- Setup the agents
			browse_button.select_actions.extend (agent start_browsing)
			top_radio.select_actions.extend (agent top_cluster_selected)
			sub_radio.select_actions.extend (agent sub_cluster_selected)
			library_box.select_actions.extend (agent library_selected)

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
			hb.extend (create {EV_CELL})
			hb.extend (all_box)
			hb.extend (create {EV_CELL})
			hb.extend (library_box)
			hb.extend (create {EV_CELL})
			vb.extend (hb)
			name_frame.extend (vb)

				-- Build the list
			create vb
			vb.set_padding (Layout_constants.Small_border_size)
			vb.set_border_width (Layout_constants.Small_border_size)
			extend_no_expand (vb, top_radio)
			extend_no_expand (vb, sub_radio)
			cluster_list.set_minimum_size (Cluster_list_minimum_width, Cluster_list_minimum_height)
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
			sub_radio.enable_select

				-- Add the main container to the dialog.
			extend (vb)

				-- Setup the default buttons and show actions.
			set_default_cancel_button (cancel_b)
			set_default_push_button (create_button)
			show_actions.extend (agent on_show_actions)
		ensure
			target_set: target = a_target
		end

feature -- Basic operations

	call_default is
			-- Display dialog and create a random cluster name.
		do
			default_cluster_name := "new_cluster_" + new_cluster_counter.item.out
			is_default_cluster_name_set := True
			new_cluster_counter.put (new_cluster_counter.item + 1)
			internal_call (default_cluster_name)
		end

	call (cluster_n: STRING) is
			-- Display the dialog.
			-- Give `cluster_n' as the default cluster name in it.
		require
			valid_args: cluster_n /= Void
		do
			is_default_cluster_name_set := False
			default_cluster_name := Void
			call (cluster_n)
		end

feature {NONE} -- Implementation

	internal_call (cluster_n: STRING) is
			-- Display the dialog.
			-- Give `cluster_n' as the default cluster name in it.
		require
			valid_args: cluster_n /= Void
		local
			str: STRING
			clus_list: ARRAYED_LIST [CLUSTER_I]
			clus: CLUSTER_I
			i: EV_LIST_ITEM
			was_sensitive: BOOLEAN
		do
			cluster := target.cluster
			str := cluster_n.as_lower
			cluster_entry.set_text (str)
			conf_todo
--			clus_list := Eiffel_universe.clusters_sorted_by_tag
			if not clus_list.is_empty then
				from
					clus_list.start
				until
					clus_list.after
				loop
					clus := clus_list.item
					if
						not clus.is_readonly
					 then
						create i.make_with_text (clus.cluster_name)
						cluster_list.extend (i)
						i.set_data (clus)
					end
					clus_list.forth
				end
				if cluster_list.count = 0 then
					create_button.disable_sensitive
				else
					i := Void
					was_sensitive := cluster_list.is_sensitive
					if not was_sensitive then
						cluster_list.enable_sensitive
					end
					if cluster /= Void then
						i := cluster_list.retrieve_item_by_data (cluster, True)
					end
					if i = Void then
						i := cluster_list.first
					end
					i.enable_select
					if not was_sensitive then
						cluster_list.disable_sensitive
					end
				end
			else
				create_button.disable_sensitive
			end
			show_modal_to_window (target.window)
		end

	new_cluster_counter: CELL [INTEGER] is
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

	cluster: CLUSTER_I
			-- The optional parent to the cluster that is about to be created.

	chosen_dir: FILE_NAME
			-- The path to the created cluster.

	dollar_path: STRING
			-- The path with environment variables.

	ace_path: FILE_NAME
			-- The path written in the Ace file.

	cluster_name: STRING is
			-- Name of the cluster entered by the user, in lower case.
		do
			Result := cluster_entry.text.as_lower
		ensure
			cluster_name_not_void: Result /= Void
		end

	file_name: FILE_NAME is
			-- File name of the cluster chosen by the user.
		do
			create Result.make_from_string (folder_entry.text)
		end

	aok: BOOLEAN
			-- Is the current state valid?

	change_parent_cluster is
			-- Set `cluster' to the selected cluster in the list.
		local
			clu: CLUSTER_I
			wd: EV_WARNING_DIALOG
		do
			if cluster_list.selected_item /= Void then
				clu ?= cluster_list.selected_item.data
				if clu = Void then
					aok := False
					create wd.make_with_text (Warning_messages.w_Unknown_cluster_name)
					wd.show_modal_to_window (Current)
				else
					aok := True
					cluster := clu
				end
			else
				aok := False
				create wd.make_with_text (Warning_messages.w_Select_parent_cluster)
				wd.show_modal_to_window (Current)
			end
		end

	sub_cluster: BOOLEAN is
			-- Should the dialog create a sub-cluster?
		do
			Result := sub_radio.is_selected
		end

	create_new_cluster is
			-- Create new cluster
		local
			dir: DIRECTORY
			test_file: RAW_FILE
			base_name: STRING
			wd: EV_WARNING_DIALOG
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
				aok := Eiffel_universe.cluster_of_name (base_name) = Void
				if not aok then
					create wd.make_with_text (Warning_messages.w_cluster_name_already_exists (base_name))
					wd.show_modal_to_window (target.window)
				end
			end
			if aok and sub_cluster then
				change_parent_cluster
			end
			if aok then
				check_valid_cluster_path
			end
			if aok then
				if sub_cluster then
					check
						cluster /= Void
						-- Otherwise `change_parent_cluster' didn't do its job.
					end
					conf_todo
--					if cluster.is_library or cluster.is_precompiled then
--						create wd.make_with_text (Warning_messages.w_Cannot_add_to_library_cluster (cluster.cluster_name))
--						wd.show_modal_to_window (Current)
--						aok := False
--					elseif
--							-- FIXME XR: If the cluster is `all' in the Ace, but it has no child,
--							-- WE HAVE NO WAY OF KNOWING IT IS RECURSIVE except parsing the Ace again!!!!! (gr)
--							-- As a consequence, this will bug.
--						cluster.is_recursive or
--						not cluster.sub_clusters.is_empty and then
--						cluster.sub_clusters.first.belongs_to_all or
--						cluster.belongs_to_all
--					then
--						in_recursive := True
--						base_name := cluster.cluster_name + "." + base_name
--					end
				end
				if aok then
					create dir.make (chosen_dir)
					create test_file.make (chosen_dir)
					if test_file.exists and then not dir.exists then
						create wd.make_with_text (Warning_messages.w_Not_a_directory (chosen_dir))
						wd.show_modal_to_window (Current)
					elseif not dir.exists then
						create_directory (dir)
						if aok then
							real_create_cluster (in_recursive, base_name, dollar_path, ace_path)
						else
							create wd.make_with_text (Warning_messages.w_Cannot_create_directory (chosen_dir))
							wd.show_modal_to_window (Current)
						end
					else
						real_create_cluster (in_recursive, base_name, dollar_path, ace_path)
					end
				end
			end
		end

	real_create_cluster (rec: BOOLEAN; name: STRING; path: STRING; ace_pth: STRING) is
			-- Really create the cluster.
			-- `rec': is in recursive cluster?
			-- `name': name of the new cluster.
			-- `path': path of the new cluster.
			-- `ace_path': path of the new cluster in the Ace file.
		require
			valid_params: path /= Void and name /= Void and ace_pth /= Void
		local
			cluster_i: CLUSTER_I
		do
			conf_todo
--			if sub_cluster then
--				create cluster_i.make_with_parent (path, cluster)
--				cluster_i.set_cluster_name (name)
--				cluster_i.set_belongs_to_all (rec)
--				manager.add_cluster_i (cluster_i, cluster, ace_path, all_box.is_sensitive and all_box.is_selected, library_box.is_selected)
--			else
--				create cluster_i.make_with_parent (path, Void)
--				cluster_i.set_cluster_name (name)
--				manager.add_top_cluster_i (cluster_i, ace_path, all_box.is_sensitive and all_box.is_selected, library_box.is_selected)
--			end
--			destroy
		end

	create_directory (dir: DIRECTORY) is
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

	on_show_actions is
			-- The dialog has just been shown, set it up.
		local
			curr_selected_item: EV_LIST_ITEM
		do
				--| Make sure the currently selected item is visible
			curr_selected_item := cluster_list.selected_item
			if curr_selected_item /= Void then
				cluster_list.ensure_item_visible (curr_selected_item)
			end

				--| Make sure the text in the cluster entry is entirely visible
				--| and is selected.
			cluster_entry.set_focus
			cluster_entry.set_caret_position (1)
			cluster_entry.select_all
		end

	check_valid_cluster_name is
			-- Check that name `cluster_name' is a valid cluster name.
			-- Only alphanumeric characters and underscores are allowed.
		require
			current_state_is_valid: aok
		local
			cn: STRING
			wd: EV_WARNING_DIALOG
		do
			cn := cluster_name
			aok := not cn.is_empty and then (create {IDENTIFIER_CHECKER}).is_valid (cn)
			if not aok then
				create wd.make_with_text (Warning_messages.w_invalid_cluster_name (cn))
				wd.show_modal_to_window (Current)
			end
		end

	check_valid_cluster_path is
			-- Check, via `aok', that the path entered is a valid one, and is not already used.
			-- Set `chosen_dir' and `ace_path' accordingly.
		require
			valid_state: aok and (sub_cluster implies cluster /= Void)
		local
			cp: STRING
			icp: STRING
			wd: EV_WARNING_DIALOG
		do
			cp := folder_entry.text
			if cp.is_empty then
				if top_radio.is_selected then
					aok := False
					create wd.make_with_text (Warning_messages.w_Enter_path)
					wd.show_modal_to_window (target.window)
				else
					create chosen_dir.make_from_string (cluster.path)
					chosen_dir.set_file_name (cluster_name)
					create ace_path.make_from_string ("$")
					ace_path.set_file_name (cluster_name)
					dollar_path := chosen_dir
				end
			else
				icp := (create {ENV_INTERP}).interpreted_string (cp)
				conf_todo
--				aok := Eiffel_universe.cluster_of_path (icp) = Void
				if not aok then
					create wd.make_with_text (Warning_messages.w_cluster_path_already_exists (icp))
					wd.show_modal_to_window (target.window)
				else
					create ace_path.make_from_string (cp)
					create chosen_dir.make_from_string (icp)
					dollar_path := cp
				end
			end
		ensure
			aok implies (chosen_dir /= Void and ace_path /= Void)
		end

	last_browsed_directory: STRING is
			-- What was the last browsed directory when searching for a folder?
		do
			Result := preferences.development_window_data.last_browsed_cluster_directory
		end

	target: EB_DEVELOPMENT_WINDOW
			-- Associated target.

feature {NONE} -- Graphic interface

	start_browsing is
			-- The user wants to browse to find a folder.
			-- Pop up a browse dialog.
		local
			bd: EV_DIRECTORY_DIALOG
			lastdir: STRING
		do
			create bd
			bd.ok_actions.extend (agent set_path (bd))
			lastdir := folder_entry.text
			if not lastdir.is_empty then
				lastdir := (create {ENV_INTERP}).interpreted_string (lastdir)
				if not (create {DIRECTORY}.make (lastdir)).exists then
					lastdir := Void
				end
			end
			if lastdir = Void or else lastdir.is_empty then
				lastdir := last_browsed_directory
			end
			if
				lastdir /= Void and then not lastdir.is_empty and then
				(create {DIRECTORY}.make (lastdir)).exists
			then
				bd.set_start_directory (lastdir)
			end
			bd.show_modal_to_window (target.window)
		end

	set_path (bd: EV_DIRECTORY_DIALOG) is
			-- Initialize the cluster path with the directory selected in `bd'.
		local
			sep_index: INTEGER
			dir: STRING
		do
			dir := bd.directory
			folder_entry.set_text (dir)
			preferences.development_window_data.last_browsed_cluster_directory_preference.set_value (dir)
			if
				(not dir.is_empty and is_default_cluster_name_set) and then
				(cluster_name.is_equal (default_cluster_name) or cluster_name.is_empty)
			then
				sep_index := dir.last_index_of (platform_constants.directory_separator,
					dir.count)
				dir := dir.as_lower
				dir.remove_head (sep_index)
				cluster_entry.change_actions.block
				cluster_entry.set_text (dir)
				cluster_entry.change_actions.resume
			end
		end

	top_cluster_selected is
			-- The user wants to create a top-cluster.
			-- Disable the cluster list.
		do
			cluster_list.disable_sensitive
		end

	sub_cluster_selected is
			-- The user wants to create a sub-cluster.
			-- Enable the cluster list.
		do
			cluster_list.enable_sensitive
		end

	library_selected is
			-- The user wants to create a library cluster.
			-- Disable the `all_box' check box.
		do
			if library_box.is_selected then
				all_box.disable_sensitive
			else
				all_box.enable_sensitive
			end
		end

feature {NONE} -- Vision2 widgets

	cluster_entry: EV_TEXT_FIELD
			-- Text field in which the user will type the name of the new cluster

	folder_entry: EV_TEXT_FIELD
			-- Text field in which the user will type the folder name of the new cluster

	browse_button: EV_BUTTON
			-- Button that lets the user browse to give a directory.

	all_box: EV_CHECK_BUTTON
			-- Check box that sets whether the cluster is recursive or not.

	library_box: EV_CHECK_BUTTON
			-- Check box that sets whether the cluster is a library or not.

	top_radio: EV_RADIO_BUTTON
			-- Radio button that creates a top-level cluster.

	sub_radio: EV_RADIO_BUTTON
			-- Radio button that creates a sub-cluster.

	create_button: EV_BUTTON
			-- Button to create the class

	cluster_list: EV_LIST
			-- List of all available clusters.

feature {NONE} -- Constants

	Cluster_list_minimum_width: INTEGER is
			-- Minimum width for the cluster list.
		do
			Result := Layout_constants.Dialog_unit_to_pixels (250)
		end

	Cluster_list_minimum_height: INTEGER is
			-- Minimum height for the cluster list.
		do
			Result := Layout_constants.Dialog_unit_to_pixels (100)
		end

invariant
	all_box_valid: all_box /= Void and then not all_box.is_destroyed
	browse_button_valid: browse_button /= Void and then not browse_button.is_destroyed
	cluster_entry_valid: cluster_entry /= Void and then not cluster_entry.is_destroyed
	cluster_list_valid: cluster_list /= Void and then not cluster_list.is_destroyed
	create_button_valid: create_button /= Void and then not create_button.is_destroyed
	folder_entry_valid: folder_entry /= Void and then not folder_entry.is_destroyed
	library_box_valid: library_box /= Void and then not library_box.is_destroyed
	sub_radio_valid: sub_radio /= Void and then not sub_radio.is_destroyed
	top_radio_valid: top_radio /= Void and then not top_radio.is_destroyed
	default_cluster_name_not_void: is_default_cluster_name_set implies default_cluster_name /= Void
	target_not_void: target /= Void

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

end -- class EB_CREATE_CLUSTER_DIALOG
