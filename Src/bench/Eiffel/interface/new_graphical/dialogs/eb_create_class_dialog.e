indexing
	description	: "Dialog for choosing where to put a new class"
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

create
	make_default

feature {NONE} -- Initialization

	make_default (a_target: EB_HISTORY_OWNER) is
		local
			vb: EV_VERTICAL_BOX
			buttons_box: EV_HORIZONTAL_BOX
			name_frame, cluster_frame, file_frame: EV_FRAME
			cancel_b: EV_BUTTON	-- Button to discard the class 
		do
			target := a_target

			make_with_title (Interface_names.t_New_class)
			set_icon_pixmap (Pixmaps.Icon_dialog_window)

				-- Build the widgets
			create class_entry
			class_entry.change_actions.extend (agent update_file_entry)
			create file_entry
			create cluster_list

				-- Build the frames
			create name_frame.make_with_text (Interface_names.l_Class_name)
			create cluster_frame.make_with_text (Interface_names.l_Cluster)
			create file_frame.make_with_text (Interface_names.l_File_name)
			name_frame.extend (class_entry)
			file_frame.extend (file_entry)

			cluster_list.set_minimum_size (Cluster_list_minimum_width, Cluster_list_minimum_height)
			cluster_frame.extend (cluster_list)

				-- Build the buttons
			create create_button.make_with_text_and_action (Interface_names.b_Create, agent create_new_class)
			Layout_constants.set_default_size_for_button (create_button)
			create cancel_b.make_with_text_and_action (Interface_names.b_Cancel, agent cancel)
			Layout_constants.set_default_size_for_button (cancel_b)

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
			extend_no_expand (vb, file_frame)
			vb.extend (cluster_frame) -- Expandable item
			extend_no_expand (vb, buttons_box)

				-- Add the main container to the dialog.
			extend (vb)

				-- Setup the default buttons and show actions.
			set_default_cancel_button (cancel_b)
			set_default_push_button (create_button)
			show_actions.extend (agent on_show_actions)

			cancelled := False
			cluster_preset := False
		end

feature -- Status Report

	cancelled: BOOLEAN
			-- Was `Current' closed by discarding the dialog 
			-- (by clicking the Cancel button for example)?

	class_i: CLASS_I
			-- Created class

	cluster: CLUSTER_I
			-- Selected cluster

feature -- Status Settings

	set_stone_when_finished is
			-- `Current' will send a stone when its execution is over.
		do
			set_stone := True
		end

	preset_cluster (a_cluster: CLUSTER_I) is
			-- Assign `a_cluster' to `cluster'.
		require
			a_cluster_not_void: a_cluster /= Void
		do
			cluster := a_cluster
			cluster_preset := True
		ensure
			a_cluster_assigned: a_cluster = cluster
			cluster_preset_enabled: cluster_preset
		end

feature -- Basic operations

	call (class_n: STRING) is
		require
			valid_args: class_n /= Void 
		local
			str: STRING
			clus_list: LINKED_LIST [CLUSTER_I]
			clus: CLUSTER_I
			i: EV_LIST_ITEM
		do
			if not cluster_preset then
				cluster := target_cluster
			end
			str := clone (class_n)
			str.to_upper
			class_entry.set_text (str)	
			clus_list := Eiffel_universe.clusters_sorted_by_tag
			if not clus_list.is_empty then
				from
					clus_list.start
				until
					clus_list.after
				loop
					clus := clus_list.item
					if
						not clus.is_precompiled and then
						not clus.is_library
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
					if cluster /= Void then
						i := cluster_list.item_by_data (cluster)
						cluster_list.start
						cluster_list.search (i)
					end
					if i = Void then
						i := cluster_list.first
						check
							i_not_void: i /= Void --| Since `cluster_list' is not empty, there must be a first item.
						end
					end
					i.enable_select
				end
			else
				create_button.disable_sensitive
			end
			show_modal_to_window (target.window)
		end

feature {NONE} -- Access

	change_cluster is
			-- Howdy Howdy
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
			end
		end

feature {NONE} -- Implementation

	class_name: STRING is
			-- Name of the class entered by the user.
		do
			Result := clone (class_entry.text)
			if Result /= Void then
				Result.to_lower
			end
		end

	file_name: FILE_NAME is
			-- File name of the class chosen by the user.
		local
			str, str2: STRING
			dotpos: INTEGER
		do
			str2 := file_entry.text
			if str2 /= Void then
				str2.right_adjust
				str2.left_adjust
			end
			if str2 = Void or else str2.count < 3 then
				update_file_entry
				str := file_entry.text
				if str /= Void then
					create Result.make_from_string (file_entry.text)
				else
					create Result.make_from_string ("")
				end
			else
				if
					str2 @ (str2.count) /= 'e' or else
					str2 @ (str2.count - 1) /= '.'
				then
					dotpos := str2.index_of ('.', 1) - 1
					str2.head (dotpos.max (0))
					create Result.make_from_string (str2)
					Result.add_extension ("e")
				else
					create Result.make_from_string (str2)
				end
			end
		end

	stone: CLASSI_STONE

	aok: BOOLEAN

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
			cd: EV_CONFIRMATION_DIALOG
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
				if aok then
					create f_name.make_from_string (cluster.path)
					f_name.set_file_name (file_name)
					base_name := file_name
					create file.make (f_name)
					if cluster.has_base_name (base_name) then
						if file.exists then
							create wd.make_with_text (Warning_messages.w_Class_already_in_cluster (base_name))
						else
							create wd.make_with_text (Warning_messages.w_Class_still_in_cluster (base_name))
						end
						wd.show_modal_to_window (Current)
						class_entry.set_focus
					elseif
						(not file.exists and then not file.is_creatable)
					then
						create wd.make_with_text (Warning_messages.w_Cannot_create_file (f_name))
						wd.show_modal_to_window (target.window)
					else
						if not file.exists then
							destroy
							load_default_class_text (file)
							manager.add_class_to_cluster_i (base_name, cluster)
							class_i := cluster.class_with_base_name (base_name)
							if set_stone and class_i /= Void then
								create stone.make (class_i)
								target.advanced_set_stone (stone)
							end
						elseif
							not (file.is_readable and then file.is_plain)
						then
							create wd.make_with_text (Warning_messages.w_Cannot_create_file (f_name))
							wd.show_modal_to_window (target.window)
							file_entry.set_focus
						else
								--| Reading in existing file (created outside
								--| ebench). Ask for confirmation
							create cd.make_with_text (Warning_messages.w_File_exists_edit_it (f_name))
							cd.button (ev_ok).select_actions.extend (agent edit_class)
							cd.show_modal_to_window (target.window)
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

	edit_class is
			-- The file name of the new class already exists.
			-- The user wants to keep it.
		local
			retried: BOOLEAN
		do
			if not retried then
				manager.add_class_to_cluster_i (file_name, cluster)
				class_i := cluster.class_with_base_name (file_name)
				destroy
				if set_stone and then class_i /= Void then
					create stone.make (class_i)
					target.set_stone (stone)
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
			cn: STRING
			wd: EV_WARNING_DIALOG
			retried: BOOLEAN
			writing: BOOLEAN
		do
			if not retried then
				create input.make (Default_class_file)
				if input.exists and then input.is_readable then
					input.open_read
					input.read_stream (input.count)
					in_buf := input.last_string
					cn := class_name
					cn.to_upper
					in_buf.replace_substring_all ("$classname", cn)
					writing := True
					output.open_write
					output.putstring (in_buf)
					output.close
				else
					create wd.make_with_text (Warning_messages.w_cannot_read_file (Default_class_file))
					wd.show_modal_to_window (target.window)
				end
			else
				if not writing then
					create wd.make_with_text (Warning_messages.w_cannot_read_file (Default_class_file))
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
			curr_selected_item: EV_LIST_ITEM
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
			cn: STRING
			wd: EV_WARNING_DIALOG
		do
			cn := class_name
			if not Eiffel_universe.classes_with_name (cn).is_empty then
				aok := False
				create wd.make_with_text (Warning_messages.w_Class_already_exists (cn))
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
			cchar: CHARACTER
			i: INTEGER
		do
			cn := class_name
			if cn = Void or else cn.is_empty or else not (cn @ 1).is_alpha then
				aok := False
			else
				from
					i := 2
				until
					i > cn.count or not aok
				loop
					cchar := (cn @ i)
					aok := cchar.is_alpha or cchar.is_digit or cchar = '_'
					i := i + 1
				end
			end
			if not aok then
				if cn = Void then
					cn := ""
				end
				create wd.make_with_text (Warning_messages.w_Invalid_class_name (cn))
				wd.show_modal_to_window (Current)
			end
		end

	update_file_entry is
			-- Update the file name according to the class name.
		local
			str: STRING
		do
			str := class_entry.text
			if str /= Void then
				str.right_adjust
				str.left_adjust
			end
			if str = Void or else str.is_empty then
				file_entry.remove_text
			else
				str.to_lower
				str.append (".e")
				file_entry.set_text (str)
			end
		end

	target_cluster: CLUSTER_I is
			-- Cluster of the target. Void if none.
		local
			classi_stone: CLASSI_STONE
			cluster_stone: CLUSTER_STONE
		do
			classi_stone ?= target.stone
			if classi_stone /= Void then
				Result := classi_stone.cluster
			end
			cluster_stone ?= target.stone
			if cluster_stone /= Void then
				Result := cluster_stone.cluster_i
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

feature {NONE} -- Vision2 widgets

	create_button: EV_BUTTON
			-- Button to create the class
			
	cluster_list: EV_LIST
			-- List of all available clusters.

	class_entry: EV_TEXT_FIELD
			-- Text field in which the user will type the name of the class
			
	file_entry: EV_TEXT_FIELD
			-- Text field in which the user may type the file name of the class.

feature {NONE} -- Constants

	Cluster_list_minimum_width: INTEGER is
			-- Minimum width for the cluster list.
		do
			Result := Layout_constants.Dialog_unit_to_pixels (250)
		end
		
	Cluster_list_minimum_height: INTEGER is
			-- Minimum height for the cluster list.
		do
			Result := Layout_constants.Dialog_unit_to_pixels (300)
		end

end -- class EB_CREATE_CLASS_DIALOG
