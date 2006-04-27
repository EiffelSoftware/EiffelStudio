indexing
	description	: "Dialog for choosing where to put a new class"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CREATE_CLASS_DIALOG

inherit
	EV_DIALOG

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

	EV_DIALOG_CONSTANTS
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

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end

	CONF_REFACTORING
		undefine
			default_create, copy
		end

create
	make_default

feature {NONE} -- Initialization

	make_default (a_target: EB_HISTORY_OWNER) is
		require
			a_target_not_void: a_target /= Void
		local
			vb: EV_VERTICAL_BOX
			buttons_box: EV_HORIZONTAL_BOX
			identification_frame, properties_frame, parents_frame: EV_FRAME
			cluster_label, name_label, file_label, creation_label: EV_LABEL
			cancel_b: EV_BUTTON	-- Button to discard the class
			bbox: EV_HORIZONTAL_BOX
			l_cell: EV_CELL
			sz: INTEGER
		do
			target := a_target

			make_with_title (Interface_names.t_new_class)
			set_height (Layout_constants.dialog_unit_to_pixels (400).min ((create {EV_SCREEN}).height))
			set_width (Layout_constants.dialog_unit_to_pixels (300).min ((create {EV_SCREEN}).width))
			set_icon_pixmap (Pixmaps.Icon_dialog_window)

				-- Build the widgets
			create class_entry
			class_entry.change_actions.extend (agent update_file_entry)
			create file_entry
			create creation_entry
			create cluster_list.make
			cluster_list.set_minimum_size (Cluster_list_minimum_width, Cluster_list_minimum_height)
			cluster_list.refresh
			create deferred_check.make_with_text (Interface_names.L_deferred)
			deferred_check.select_actions.extend (agent on_deferred)
			create expanded_check.make_with_text (Interface_names.L_expanded)
			expanded_check.select_actions.extend (agent on_expanded)
			create empty_check.make_with_text (Interface_names.L_not_empty)
			empty_check.enable_select
			create creation_check.make_with_text (Interface_names.l_generate_creation)
			creation_check.select_actions.extend (agent on_creation_check)
			create parents_list.make
			parents_list.text_field.focus_in_actions.extend (agent on_focus_in)
			parents_list.text_field.focus_out_actions.extend (agent on_focus_out)

				-- Build the frames
			create properties_frame.make_with_text (Interface_names.l_general)
			create identification_frame.make_with_text (Interface_names.l_identification)
			create name_label.make_with_text (Interface_names.l_class_name)
			name_label.align_text_left
			create cluster_label.make_with_text (Interface_names.l_cluster)
			cluster_label.align_text_left
			create file_label.make_with_text (Interface_names.l_file_name)
			file_label.align_text_left
			create vb
			sz := name_label.width.max (file_label.width)
			name_label.set_minimum_width (sz)
			file_label.set_minimum_width (sz)
			create bbox
			extend_no_expand (bbox, name_label)
			bbox.extend (class_entry)
			extend_no_expand (vb, bbox)
			create bbox
			extend_no_expand (bbox, file_label)
			bbox.extend (file_entry)
			extend_no_expand (vb, bbox)
			extend_no_expand (vb, cluster_label)
			vb.extend (cluster_list)
			vb.set_border_width (Layout_constants.Small_border_size)
			identification_frame.extend (vb)

			create vb
			create bbox
			bbox.enable_homogeneous
			bbox.extend (deferred_check)
			bbox.extend (expanded_check)
			extend_no_expand (vb, bbox)
			create creation_label.make_with_text (Interface_names.l_creation)
			creation_label.align_text_left
			extend_no_expand (vb, creation_check)
			create bbox
			create l_cell
			l_cell.set_minimum_width (22)
			extend_no_expand (bbox, l_cell)
			extend_no_expand (bbox, creation_label)
			bbox.extend (creation_entry)
			bbox.disable_sensitive
			extend_no_expand (vb, bbox)
			extend_no_expand (vb, empty_check)
			vb.set_border_width (Layout_constants.Small_border_size)
			properties_frame.extend (vb)

			create parents_frame.make_with_text (Interface_names.l_parents)
			create vb
			vb.extend (parents_list)
			vb.set_border_width (Layout_constants.Small_border_size)
			parents_frame.extend (vb)

				-- Build the buttons
			create create_button.make_with_text_and_action (Interface_names.b_create, agent create_new_class)
			Layout_constants.set_default_size_for_button (create_button)
			create cancel_b.make_with_text_and_action (Interface_names.b_cancel, agent cancel)
			Layout_constants.set_default_size_for_button (cancel_b)

				-- Build the button box
			create buttons_box
			buttons_box.set_padding (Layout_constants.Small_border_size)
			buttons_box.extend (create {EV_CELL}) -- Expandable item
			extend_no_expand (buttons_box, create_button)
			extend_no_expand (buttons_box, cancel_b)

				-- Build the vertical layout
			create vb
			vb.set_padding (Layout_constants.Small_border_size)
			vb.set_border_width (Layout_constants.Small_border_size)
			vb.extend (identification_frame)
			vb.extend (properties_frame)
			vb.extend (parents_frame)
			extend_no_expand (vb, buttons_box)

				-- Add the main container to the dialog.
			extend (vb)

				-- Setup the default buttons and show actions.
			set_default_cancel_button (cancel_b)
			set_default_push_button (create_button)
			show_actions.extend (agent on_show_actions)

			cancelled := False
			cluster_preset := False
		ensure
			target_set: target = a_target
		end

feature -- Status Report

	cancelled: BOOLEAN
			-- Was `Current' closed by discarding the dialog
			-- (by clicking the Cancel button for example)?

	class_i: CLASS_I
			-- Created class

	cluster: CONF_CLUSTER
			-- Selected cluster

	path: STRING
			-- Selected subfolder path

	is_deferred: BOOLEAN
			-- Is new class deferred?

feature -- Status Settings

	set_stone_when_finished is
			-- `Current' will send a stone when its execution is over.
		do
			set_stone := True
		end

	preset_cluster (a_cluster: CONF_CLUSTER) is
			-- Assign `a_cluster' to `cluster'.
		require
			a_cluster_not_void: a_cluster /= Void
		do
			cluster := a_cluster
			path := ""
			cluster_preset := True
		ensure
			cluster_set: cluster = a_cluster
			cluster_preset_enabled: cluster_preset
		end

feature -- Basic operations

	call_default is
			-- Create a new dialog with a pre-computed class name.
		do
			call ("NEW_CLASS_" + new_class_counter.item.out)
			new_class_counter.put (new_class_counter.item + 1)
		end

	call (class_n: STRING) is
			-- Create a new dialog with `class_n' as preset class name.
		require
			valid_args: class_n /= Void
		local
			str: STRING
		do
			if not cluster_preset then
				if target.stone /= Void then
					cluster_list.show_stone (target.stone)
				end
			else
				cluster_list.show_subfolder (cluster, path)
			end
			str := class_n.as_upper
			class_entry.set_text (str)
			if cluster /= Void then
				cluster_list.show_subfolder (cluster, path)
			end
			show_modal_to_window (target.window)
		end

feature {NONE} -- Access

	change_cluster is
			-- Set `cluster' to selected cluster from tree.
		local
			l_folder: EB_CLASSES_TREE_FOLDER_ITEM
			clu: EB_SORTED_CLUSTER
			wd: EV_WARNING_DIALOG
		do
			if cluster_list.selected_item /= Void then
				l_folder ?= cluster_list.selected_item
				if l_folder /= Void then
					clu := l_folder.data
				else
					l_folder ?= cluster_list.selected_item.parent
					if l_folder /= Void then
						clu := l_folder.data
					end
				end
				if clu = Void or else not clu.is_cluster then
					aok := False
					create wd.make_with_text (Warning_messages.w_unknown_cluster_name)
					wd.show_modal_to_window (Current)
				else
					aok := True
					cluster := clu.actual_cluster
					path := l_folder.path
				end
			end
		end

feature {NONE} -- Implementation

	class_name: STRING is
			-- Name of the class entered by the user.
		do
			Result := class_entry.text.as_upper
		ensure
			class_name_not_void: class_name /= Void
		end

	file_name: FILE_NAME is
			-- File name of the class chosen by the user.
		local
			str: STRING
			dotpos: INTEGER
		do
			str := file_entry.text
			str.right_adjust
			str.left_adjust
				-- str.count < 3 means there no extension to the file name.
			if str.is_empty or else str.count < 3 then
				update_file_entry
				create Result.make_from_string (file_entry.text)
			else
				if
					str @ (str.count) /= 'e' or else
					str @ (str.count - 1) /= '.'
				then
					dotpos := str.index_of ('.', 1) - 1
					str.keep_head (dotpos.max (0))
					create Result.make_from_string (str)
					Result.add_extension ("e")
				else
					create Result.make_from_string (str)
				end
			end
		end

	aok: BOOLEAN

	could_not_load_file: BOOLEAN
			-- Was there an error when attempting to create the class file?

	cluster_preset: BOOLEAN
			-- Was a target cluster set by `preset_cluster'?

	set_stone: BOOLEAN
			-- Should `Current' send a stone when its execution is over?

	target: EB_HISTORY_OWNER
			-- Associated target.

	create_new_class is
			-- Create a new class
		local
			f_name: FILE_NAME
			file: RAW_FILE -- Windows specific
			base_name: STRING
			wd: EV_WARNING_DIALOG
			retried: BOOLEAN
		do
			if not retried then
				aok := False
				change_cluster
				if aok then
					check_valid_class_name
				end
				if aok then
					check_class_not_exists
				end
				if aok and then creation_check.is_selected then
					check_valid_creation_procedure
				end
				if aok then
					create f_name.make_from_string (cluster.location.build_path (path, ""))
					f_name.set_file_name (file_name)
					base_name := file_name
					create file.make (f_name)
					if file.exists then
						create wd.make_with_text (Warning_messages.w_class_already_in_cluster (base_name))
						wd.show_modal_to_window (Current)
						class_entry.set_focus
					elseif not file.is_creatable then
						create wd.make_with_text (Warning_messages.w_cannot_create_file (f_name))
						wd.show_modal_to_window (target.window)
					else
						destroy
						load_default_class_text (file)
						if not could_not_load_file then
							manager.add_class_to_cluster (base_name, cluster, path)
							class_i := manager.last_added_class
							if set_stone and class_i /= Void then
								target.advanced_set_stone (create {CLASSI_STONE}.make (class_i))
							end
						end
					end
				end
			else
					-- We were rescued.
				class_entry.remove_text
				file_entry.remove_text
				class_entry.set_focus
			end
		rescue
			retried := True
			retry
		end

	load_default_class_text (output: RAW_FILE) is
			-- Loads the default class text.
		local
			input: RAW_FILE
			in_buf: STRING
			cr: STRING
			wd: EV_WARNING_DIALOG
			retried: BOOLEAN
			writing: BOOLEAN
			clf: FILE_NAME
			inheritance: STRING
			par: STRING
			pcnt: INTEGER
			last: BOOLEAN
			tmp: STRING
		do
			if not retried then
				clf := Templates_path.twin
				if not empty_check.is_selected then
					clf.set_file_name ("empty")
				else
					clf.set_file_name ("full")
				end
				clf.add_extension ("cls")
				create input.make (clf)
				if input.exists and then input.is_readable then
					input.open_read
					input.read_stream (input.count)
					in_buf := input.last_string
					in_buf.replace_substring_all ("$classname", class_name)
					if deferred_check.is_selected then
						in_buf.replace_substring_all ("$class_type", "deferred ")
					elseif expanded_check.is_selected then
						in_buf.replace_substring_all ("$class_type", "expanded ")
					else
						in_buf.replace_substring_all ("$class_type", "")
					end
					pcnt := parents_list.count
					if pcnt > 0 then
							--| Ten characters for "inherit%N",
							--| 15 for each line for each parent.
						create inheritance.make (10 + 15 * pcnt)
						from
							inheritance.append ("inherit%N")
							parents_list.list.start
							last := parents_list.list.after
						until
							parents_list.list.after
						loop
							par := parents_list.list.item.text
							par.to_upper
							inheritance.append_character ('%T')
							inheritance.append (par)
							inheritance.append_character ('%N')
							inheritance.append_character ('%N')
							parents_list.list.forth
						end
						in_buf.replace_substring_all ("$inheritance_clause", inheritance)
					else
						in_buf.replace_substring_all ("$inheritance_clause", "")
					end
					cr := creation_entry.text
					if not deferred_check.is_selected and then not cr.is_empty then
						in_buf.replace_substring_all ("$creation_clause", "create%N%T" + cr + "%N%N")
					else
						in_buf.replace_substring_all ("$creation_clause", "")
					end
					if not deferred_check.is_selected and then creation_check.is_selected then
						tmp := "feature {NONE} -- Initialization%N%N%T$cr_name is%N%T%T%T-- Initialize `Current'.%N%
								%%T%Tdo%N%T%T%T%N%T%Tend%N%N"
						if cr.is_empty then
							tmp.replace_substring_all ("$cr_name", "default_create")
						else
							tmp.replace_substring_all ("$cr_name", cr)
						end
						in_buf.replace_substring_all ("$initialization_clause", tmp)
					else
						in_buf.replace_substring_all ("$initialization_clause", "")
					end
						--| In case we crash later, to know where we were.
					writing := True
					output.open_write
					if not in_buf.is_empty then
						in_buf.prune_all ('%R')
						if preferences.misc_data.text_mode_is_windows then
							in_buf.replace_substring_all ("%N", "%R%N")
							output.put_string (in_buf)
						else
							output.put_string (in_buf)
							if in_buf.item (in_buf.count) /= '%N' then
									-- Add a carriage return like `vi' if there's none at the end
								output.put_new_line
							end
						end
					end
					output.close
					could_not_load_file := False
				else
					create wd.make_with_text (Warning_messages.w_cannot_read_file (input.name))
					wd.show_modal_to_window (target.window)
					could_not_load_file := True
				end
			else
				if not writing then
					create wd.make_with_text (Warning_messages.w_cannot_read_file (input.name))
				else
					create wd.make_with_text (Warning_messages.w_cannot_create_file (output.name))
				end
				wd.show_modal_to_window (target.window)
			end
		rescue
			retried := True
			retry
		end

	on_show_actions is
			-- The dialog has just been shown, set it up.
		local
			curr_selected_item: EV_TREE_NODE
		do
				--| Make sure the currently selected item is visible
			curr_selected_item := cluster_list.selected_item
			if curr_selected_item /= Void then
				cluster_list.ensure_item_visible (curr_selected_item)
			end

				--| Make sure the text in the class entry is entirely visible
				--| and is selected.
			class_entry.set_focus
			class_entry.set_caret_position (1)
			class_entry.select_all
		end

	check_class_not_exists is
			-- Check that class with name `class_name' does not exist in the universe.
		require
			current_state_is_valid: aok
		local
			wd: EV_WARNING_DIALOG
		do
			if cluster.classes.has (class_name) then
				aok := False
				create wd.make_with_text (Warning_messages.w_class_already_exists (class_name))
				wd.show_modal_to_window (Current)
			end
		end

	check_valid_class_name is
			-- Check that name `class_name' is a valid class name.
		require
			current_state_is_valid: aok
		local
			cn: STRING
			wd: EV_WARNING_DIALOG
		do
			cn := class_name
			aok := (create {IDENTIFIER_CHECKER}).is_valid (cn)
			if not aok then
				create wd.make_with_text (Warning_messages.w_invalid_class_name (cn))
				wd.show_modal_to_window (Current)
			end
		end

	check_valid_creation_procedure is
			-- Check that creation procedure name is valid
		require
			current_state_is_valid: aok
			creation_check_selected: creation_check.is_selected
		local
			fn: STRING
			wd: EV_WARNING_DIALOG
		do
			fn := creation_entry.text
			aok := (create {IDENTIFIER_CHECKER}).is_valid (fn)
			if not aok then
				create wd.make_with_text (Warning_messages.w_invalid_feature_name (fn))
				wd.show_modal_to_window (Current)
			end
		end

	update_file_entry is
			-- Update the file name according to the class name.
		local
			str: STRING
		do
			str := class_entry.text
			str.right_adjust
			str.left_adjust
			if str.is_empty then
				file_entry.remove_text
			else
				str.to_lower
				str.append (".e")
				file_entry.set_text (str)
			end
		end

	cancel is
			-- User pressed `cancel_b'.
		do
			cancelled := True
			destroy
		ensure
			cancelled_set: cancelled
		end

	on_deferred is
			-- User selected deferred => uncheck expanded.
		do
			if deferred_check.is_selected then
				expanded_check.disable_select
				creation_check.disable_sensitive
				if creation_check.is_selected then
					creation_entry.parent.disable_sensitive
				end
				is_deferred := True
			else
				creation_check.enable_sensitive
				if creation_check.is_selected then
					creation_entry.parent.enable_sensitive
				end
				is_deferred := False
			end
		end

	on_creation_check is
			-- User selected or unselected the `creation procedure' check box.
		do
			if creation_check.is_selected then
				creation_entry.parent.enable_sensitive
			else
				creation_entry.parent.disable_sensitive
			end
		end

	on_expanded is
			-- User selected expanded => uncheck deferred.
		do
			if expanded_check.is_selected then
				deferred_check.disable_select
			end
		end

	on_focus_in is
			-- When the parents list has the focus, we disable the default push button.
		do
			if default_push_button /= Void then
				remove_default_push_button
			end
		end

	on_focus_out is
			-- When the parents list loses the focus, we enable the default push button.
		do
				-- Need to check that the dialog is not destroyed as sometimes
				-- we get called while destroying the dialog.
			if not is_destroyed then
				set_default_push_button (create_button)
			end
		end

feature {NONE} -- Vision2 widgets

	create_button: EV_BUTTON
			-- Button to create the class

	cluster_list: EB_CLASSES_TREE
			-- List of all available clusters.

	class_entry: EV_TEXT_FIELD
			-- Text field in which the user will type the name of the class

	file_entry: EV_TEXT_FIELD
			-- Text field in which the user may type the file name of the class.

	creation_entry: EV_TEXT_FIELD
			-- Text field in which the user may type the (main) creation procedure of the class.

	parents_list: EB_ADD_REMOVE_CLASS_LIST
			-- List in which the user enters the class parents.

	deferred_check: EV_CHECK_BUTTON
			-- Check box which defines whether the class is deferred.

	expanded_check: EV_CHECK_BUTTON
			-- Check box which defines whether the class is expanded.

	empty_check: EV_CHECK_BUTTON
			-- Check box which defines whether the class is a dummy class (few features).

	creation_check: EV_CHECK_BUTTON
			-- Check box which defines whether we should define a creation feature.

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

	new_class_counter: CELL [INTEGER] is
			-- Number of classes being created so far
		once
			create Result.put (1)
		ensure
			new_class_counter_not_void: new_class_counter /= Void
		end

invariant
	create_button_valid: create_button /= Void and then not create_button.is_destroyed
	cluster_list_valid: cluster_list /= Void and then not cluster_list.is_destroyed
	class_entry_valid: class_entry /= Void and then not class_entry.is_destroyed
	file_entry_valid: file_entry /= Void and then not file_entry.is_destroyed
	parents_list_valid: parents_list /= Void and then not parents_list.is_destroyed
	expanded_check_valid: expanded_check /= Void and then not expanded_check.is_destroyed
	empty_check_valid: empty_check /= Void and then not empty_check.is_destroyed
	deferred_check_valid: deferred_check /= Void and then not deferred_check.is_destroyed
	creation_check_valid: creation_check /= Void and then not creation_check.is_destroyed
	creation_entry_valid: creation_entry /= Void and then not creation_entry.is_destroyed
	creation_entry_parented: creation_entry.parent /= Void
	target_not_void: target /= Void
	cluster_implies_path: cluster /= Void implies path /= Void

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
