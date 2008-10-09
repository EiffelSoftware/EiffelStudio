indexing
	description	: "Dialog for choosing where to put a new class"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CREATE_CLASS_DIALOG

inherit
	EB_DIALOG

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

	EIFFEL_LAYOUT
		export
			{NONE} all
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
			l_window: EB_DEVELOPMENT_WINDOW
			l_factory: EB_CONTEXT_MENU_FACTORY
		do
			target := a_target

			make_with_title (Interface_names.t_new_class)
			set_icon_pixmap (pixmaps.icon_pixmaps.new_class_icon)
			set_height (Layout_constants.dialog_unit_to_pixels (400))
			set_width (Layout_constants.dialog_unit_to_pixels (300))

				-- Build the widgets
			create class_entry
			class_entry.change_actions.extend (agent update_file_entry)
			create file_entry
			create creation_entry
			l_window := window_manager.last_focused_development_window
			if l_window /= Void then
				l_factory := l_window.menus.context_menu_factory
			end
			create cluster_list.make_without_targets (l_factory)
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
			create parents_list.make (agent compute_group)
			parents_list.text_field.focus_in_actions.extend (agent on_focus_in)
			parents_list.text_field.focus_out_actions.extend (agent on_focus_out)

				-- Build the frames
			create properties_frame.make_with_text (Interface_names.l_general)
			create identification_frame.make_with_text (Interface_names.l_identification)
			create name_label.make_with_text (Interface_names.l_class_name (""))
			name_label.align_text_left
			create cluster_label.make_with_text (Interface_names.l_cluster_colon)
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
			Layout_constants.set_default_width_for_button (create_button)
			create cancel_b.make_with_text_and_action (Interface_names.b_cancel, agent cancel)
			Layout_constants.set_default_width_for_button (cancel_b)

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
			vb.disable_item_expand (properties_frame)
			vb.extend (parents_frame)
			vb.disable_item_expand (parents_frame)
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

	call_stone (a_stone: CLUSTER_STONE) is
			-- Create a new dialog with `a_stone' as parent cluster.
		require
			a_stone_not_void: a_stone /= Void
		local
			class_n, str: STRING
		do
			class_n := "NEW_CLASS_" + new_class_counter.item.out
			new_class_counter.put (new_class_counter.item + 1)
			cluster_list.show_subfolder (a_stone.group, a_stone.path)
			str := class_n.as_upper
			class_entry.set_text (str)
			show_modal_to_window (target.window)
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

feature {NONE} -- Basic operations

	render_class_template (a_dest_file_name: !STRING)
			-- Renders a class name into a choose destination file
			--
			-- `a_dest_file_name': The destination file to render the default class template file into.
		local
			l_wizard: SERVICE_CONSUMER [WIZARD_ENGINE_S]
			l_source_file: !FILE_NAME
			l_user_file: ?FILE_NAME
			l_params: !DS_HASH_TABLE [!ANY, !STRING]
			l_buffer: !STRING_32
			l_parents: EV_LIST
			l_creation_routine: ?STRING_32
			l_class_name: ?STRING_32
			retried: BOOLEAN
		do
			if not retried then
				create l_wizard
				if l_wizard.is_service_available then
					create l_source_file.make_from_string (eiffel_layout.templates_path)
					l_source_file.extend ("defaults")
					if not empty_check.is_selected then
						l_source_file.set_file_name ("empty")
					else
						l_source_file.set_file_name ("full")
					end
					l_source_file.add_extension ("e")
					l_source_file.add_extension ("tpl")
						-- Check for user priority file.
					l_user_file := eiffel_layout.user_priority_file_name (l_source_file, True)
					if l_user_file /= Void then
							-- The user has their own template file, use it.
						l_source_file := l_user_file
					end

					create l_params.make_default
					l_class_name := class_name.as_string_32
					if l_class_name /= Void then
						l_params.put_last (l_class_name, class_name_symbol)
					end

					if cluster.options.syntax_level.item = {CONF_OPTION}.syntax_level_obsolete then
							-- Use old syntax
						l_params.put_last ({EIFFEL_KEYWORD_CONSTANTS}.indexing_keyword, note_keyword_symbol)
					else
							-- Use new syntax
						l_params.put_last ({EIFFEL_KEYWORD_CONSTANTS}.note_keyword, note_keyword_symbol)
					end
					if (create {RAW_FILE}.make (l_source_file)).exists then
							-- Only render if the file exists.
						create l_buffer.make (64)

							-- Class modifiers
						if deferred_check.is_selected then
							l_buffer.append ({EIFFEL_KEYWORD_CONSTANTS}.deferred_keyword)
							l_buffer.append_character (' ')
						elseif expanded_check.is_selected then
							l_buffer.append ({EIFFEL_KEYWORD_CONSTANTS}.expanded_keyword)
							l_buffer.append_character (' ')
						end
						l_params.put_last (l_buffer.twin, class_modifiers_symbol)

							-- Inheritance
						l_buffer.wipe_out
						l_parents := parents_list.list
						if not l_parents.is_empty then
							l_buffer.append ({EIFFEL_KEYWORD_CONSTANTS}.inherit_keyword)
							l_buffer.append_character ('%N')
							from l_parents.start until l_parents.after loop
								l_buffer.append_character ('%T')
								l_buffer.append (l_parents.item.text.as_upper)
								l_buffer.append ("%N%N")
								l_parents.forth
							end
						end
						l_params.put_last (l_buffer.twin, inherit_clause_symbol)

							-- Create
						l_buffer.wipe_out
						l_creation_routine := creation_entry.text
						if not deferred_check.is_selected and then creation_check.is_selected and then not l_creation_routine.is_empty then
							l_buffer.append ({EIFFEL_KEYWORD_CONSTANTS}.create_keyword)
							l_buffer.append ("%N%T")
							if expanded_check.is_selected and then not ("default_create").is_case_insensitive_equal (l_creation_routine) then
									-- Is expanded and the creation routine is not default_creation, so add it.
								l_buffer.append ("default_create,%N%T")
							end
							l_buffer.append (l_creation_routine)
							l_buffer.append ("%N%N")
						end
						l_params.put_last (l_buffer.twin, create_clause_symbol)

							-- Initialization
						l_buffer.wipe_out
						if
							not deferred_check.is_selected and then creation_check.is_selected and then
							not l_creation_routine.is_empty and then
							not ("default_create").is_case_insensitive_equal (l_creation_routine)
						then
								-- No need to add default_create for expanded classes.
							l_buffer.append ({EIFFEL_KEYWORD_CONSTANTS}.feature_keyword)
							l_buffer.append (" {NONE} -- Initialization%N%N%T")
							l_buffer.append (l_creation_routine)
							l_buffer.append (
									"%N%T%T%T-- Initialization for `Current'.%N%
									%%T%Tdo%N%T%T%T%N%
									%%T%Tend%N%N")
						end
						l_params.put_last (l_buffer.twin, init_clause_symbol)

							-- Render the template using the defined parameters
						l_wizard.service.render_template_from_file_to_file (l_source_file, l_params, a_dest_file_name)
					else
						prompts.show_error_prompt (Warning_messages.w_cannot_read_file (l_source_file), target.window, Void)
						l_wizard.service.render_template_to_file (default_class_template, l_params, a_dest_file_name)
					end
				end
			else
				prompts.show_error_prompt (Warning_messages.w_cannot_create_file (a_dest_file_name), target.window, Void)
					-- Not the best status name, refactor when converting to ESF.
				could_not_load_file := True
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Access

	change_cluster is
			-- Set `cluster' to selected cluster from tree.
		local
			l_folder: EB_CLASSES_TREE_FOLDER_ITEM
			clu: EB_SORTED_CLUSTER
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
					prompts.show_error_prompt (Warning_messages.w_unknown_cluster_name, Current, Void)
				elseif not clu.is_writable then
					aok := False
					prompts.show_error_prompt (Warning_messages.w_read_only_cluster, Current, Void)
				else
					aok := True
					cluster := clu.actual_cluster
					path := l_folder.path
				end
			else
				aok := False
				prompts.show_error_prompt (warning_messages.w_no_cluster_selected_for_class_creation, Current, Void)
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
					dotpos := str.last_index_of ('.', str.count) - 1
					if dotpos > 0 then
						str.keep_head (dotpos)
					end
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
			f_name: !FILE_NAME
			file: RAW_FILE -- Windows specific
			base_name: STRING
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
						prompts.show_error_prompt (Warning_messages.w_class_already_in_cluster (base_name), target.window, Void)
						class_entry.set_focus
					elseif not file.is_creatable then
						prompts.show_error_prompt (Warning_messages.w_cannot_create_file (f_name), target.window, Void)
					else
						destroy
						render_class_template (f_name)
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
			l_classes: HASH_TABLE [CONF_CLASS, STRING]
		do
			l_classes := cluster.classes
			if l_classes.has_key (class_name) and then l_classes.found_item.is_valid then
				aok := False
				prompts.show_error_prompt (Warning_messages.w_class_already_exists (class_name), Current, Void)
			end
		end

	check_valid_class_name is
			-- Check that name `class_name' is a valid class name.
		require
			current_state_is_valid: aok
		local
			cn: STRING
		do
			cn := class_name
			aok := (create {EIFFEL_SYNTAX_CHECKER}).is_valid_class_name (cn)
			if not aok then
				prompts.show_error_prompt (Warning_messages.w_invalid_class_name (cn), Current, Void)
			end
		end

	check_valid_creation_procedure is
			-- Check that creation procedure name is valid
		require
			current_state_is_valid: aok
			creation_check_selected: creation_check.is_selected
		local
			fn: STRING
		do
			fn := creation_entry.text
			aok := (create {EIFFEL_SYNTAX_CHECKER}).is_valid_feature_name (fn)
			if not aok then
				prompts.show_error_prompt (Warning_messages.w_invalid_feature_name (fn), Current, Void)
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
				creation_check.disable_select
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

	compute_group: CONF_GROUP is
			-- Compute group.
		do
			change_cluster
			Result := cluster
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

feature {NONE} -- Constants

	note_keyword_symbol: !STRING = "NOTE_KEYWORD"
	class_name_symbol: !STRING = "CLASS_NAME"
	class_modifiers_symbol: !STRING = "CLASS_MODIFIERS"
	inherit_clause_symbol: !STRING = "INHERIT_CLAUSE"
	create_clause_symbol: !STRING = "CREATE_CLAUSE"
	init_clause_symbol: !STRING = "INIT_CLAUSE"

	default_class_template: !STRING = "class%N%T$CLASS_NAME%N%N-- Class template file not found in the installation!%N%Nend"

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
