indexing
	description: "Dialog to allow the user to choose a cluster or create one."
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

create
	make_default

feature {NONE} -- Initialization

	make_default (a_target: EB_DEVELOPMENT_WINDOW) is
		local
			vb: EV_VERTICAL_BOX
			buttons_box: EV_HORIZONTAL_BOX
			cancel_b: EV_BUTTON
			name_frame: EV_FRAME
			cluster_frame: EV_FRAME
		do
			target := a_target

			make_with_title (Interface_names.t_New_cluster)
			set_icon_pixmap (Pixmaps.Icon_dialog_window)

				-- Build the widgets
			create cluster_entry
			create cluster_list

				-- Build the frames
			create name_frame.make_with_text (Interface_names.l_Cluster_name)
			create cluster_frame.make_with_text (Interface_names.l_Cluster)
			name_frame.extend (cluster_entry)
			cluster_list.set_minimum_size (Cluster_list_minimum_width, Cluster_list_minimum_height)
			cluster_frame.extend (cluster_list)

				-- Build the buttons
			create create_button.make_with_text_and_action (Interface_names.b_Create, agent create_new_cluster)
			Layout_constants.set_default_size_for_button (create_button)
			create cancel_b.make_with_text_and_action (Interface_names.b_Cancel, agent destroy)
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
			vb.extend (cluster_frame) -- Expandable item
			extend_no_expand (vb, buttons_box)

				-- Add the main container to the dialog.
			extend (vb)

				-- Setup the default buttons and show actions.
			set_default_cancel_button (cancel_b)
			set_default_push_button (create_button)
			show_actions.extend (agent on_show_actions)
		end
		
feature -- Basic operations

	call (cluster_n: STRING) is
		require
			valid_args: cluster_n /= Void 
		local
			str: STRING
			clus_list: LINKED_LIST [CLUSTER_I]
			clus: CLUSTER_I
			i: EV_LIST_ITEM
		do
			cluster := target.cluster
			str := clone (cluster_n)
			str.to_upper
			cluster_entry.set_text (str)	
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
					end
					if i = Void then
						i := cluster_list.first
					end
					i.enable_select
				end
			else
				create_button.disable_sensitive
			end
			show_modal_to_window (target.window)
		end

feature {NONE} -- Implementation

	cluster: CLUSTER_I

	cluster_i: CLUSTER_I

	stone: CLUSTER_STONE

	cluster_name: STRING is
			-- Name of the cluster entered by the user.
		do
			Result := clone (cluster_entry.text)
			if Result = Void then
				Result := ""
			end
			Result.to_lower
		end

	file_name: FILE_NAME is
			-- File name of the cluster chosen by the user.
		local
			str: STRING
		do
			str := clone (cluster_entry.text)
			if str = Void then
				str := ""
			end
			str.to_lower
			create Result.make_from_string (str)
		end

	aok: BOOLEAN
			-- Is the current state valid?

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

	create_new_cluster is
			-- Create new cluster
		local
			f_name: FILE_NAME
			file: DIRECTORY
			test_file: RAW_FILE
			base_name: STRING
			wd: EV_WARNING_DIALOG
		do
			aok := False
			change_cluster
			if aok then
				check_valid_cluster_name
			end
			if aok then
				create f_name.make_from_string (cluster.path)
				f_name.set_file_name (file_name)
				base_name := cluster_name
				create file.make (f_name)
				create test_file.make (f_name)
				if
						-- FIXME XR: If the cluster is `all' in the Ace, but it has no child,
						-- WE HAVE NO WAY OF KNOWING IT IS RECURSIVE except parsing the Ace again!!!!! (gr)
						-- As a consequence, this will bug.
					cluster.is_recursive or
					not cluster.sub_clusters.is_empty and then
					cluster.sub_clusters.first.belongs_to_all or
					cluster.belongs_to_all
				then
					base_name := cluster.cluster_name + "." + base_name
				end
					--| FIXME XR: Add a test to check the name is a valid cluster name.
				if file.exists or test_file.exists then
					create wd.make_with_text (Warning_messages.w_Directory_already_in_cluster (f_name))
					wd.show_modal_to_window (Current)
				elseif Eiffel_universe.has_cluster_of_name (base_name) then
					create wd.make_with_text (Warning_messages.w_Cluster_already_exists (base_name))
					wd.show_modal_to_window (Current)
				else
					file.create_dir
					create cluster_i.make_with_parent (f_name, cluster)
					cluster_i.set_cluster_name (base_name)
					cluster_i.set_belongs_to_all (cluster.is_recursive or cluster.belongs_to_all)
					manager.add_cluster_i (cluster_i, cluster)
					destroy
				end
			end
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
			cchar: CHARACTER
			i: INTEGER
		do
			cn := cluster_name
			if cn = Void or else cn.is_empty then
				aok := False
			else
				from
					i := 1
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
				create wd.make_with_text (Warning_messages.w_Invalid_cluster_name (cn))
				wd.show_modal_to_window (Current)
			end
		end

	target: EB_DEVELOPMENT_WINDOW
			-- Associated target.

feature {NONE} -- Vision2 widgets

	cluster_entry: EV_TEXT_FIELD
			-- Text field in which the user will type the name of the new cluster

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
			Result := Layout_constants.Dialog_unit_to_pixels (300)
		end

end -- class EB_CREATE_CLUSTER_DIALOG
