indexing
	description: "Graphical representation of .NET assembly information tab in EB_SYSTEM_WINDOW"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SYSTEM_MSIL_ASSEMBLY_TAB

inherit
	EV_VERTICAL_BOX

	EB_SYSTEM_TAB
		rename
			make as tab_make
		undefine
			default_create, is_equal, copy
		redefine
			reset
		end

	EB_CONSTANTS
		undefine
			default_create, is_equal, copy
		end

create
	make

feature -- Access

	name: STRING is ".NET Assemblies"
			-- Name of tab in System Window.

	gac_assembly_list: EV_MULTI_COLUMN_LIST
			-- List of GAC assemblies used in Current project.

	local_assembly_list: EV_MULTI_COLUMN_LIST
			-- List of assembly used in Current project.
			
	name_edition_window: EV_DIALOG
			-- Currently displayed edition window for cluster name
	
	prefix_edition_window: EV_DIALOG
			-- Currently displayed edition window for cluster prefix		
			
	name_change_item_widget: EV_TEXT_FIELD
	
	prefix_change_item_widget: EV_TEXT_FIELD

feature -- Parent access

	system_window: EB_SYSTEM_WINDOW
			-- Graphical parent of Current.
			
feature -- Store/Retrieve

	store (root_ast: ACE_SD) is
			--
		local
			al: LACE_LIST [ASSEMBLY_SD]
			l_assembly_sd: ASSEMBLY_SD
			l_row: EV_MULTI_COLUMN_LIST_ROW
			pref_string: ID_SD
		do
			al := root_ast.assemblies
			check
				correctly_retrieved: al = Void or else al.is_empty
			end
			if al = Void then
				create al.make (gac_assembly_list.count + local_assembly_list.count)
			end
				-- Store local references
			from
				local_assembly_list.start
			until
				local_assembly_list.after
			loop
				l_row := local_assembly_list.item
				if not (l_row @ 2).is_empty then
					pref_string := new_id_sd (l_row @ 2, True)
				else
					pref_string := Void
				end
				create l_assembly_sd.initialize (new_id_sd (l_row @ 1, False),
					new_id_sd (l_row @ 3, True),
					pref_string,
					new_id_sd (l_row @ 4, True),
					new_id_sd (l_row @ 5, True),
					new_id_sd (l_row @ 6, True))
				al.extend (l_assembly_sd)
				local_assembly_list.forth
			end
				-- Store GAC references
			from
				gac_assembly_list.start
			until
				gac_assembly_list.after
			loop
				l_row := gac_assembly_list.item
				if not (l_row @ 2).is_empty then
					create pref_string.initialize (l_row @ 2)
				else
					pref_string := Void
				end
				create l_assembly_sd.initialize (new_id_sd (l_row @ 1, False),
					new_id_sd (l_row @ 3, True),
					pref_string,
					new_id_sd (l_row @ 4, True),
					new_id_sd (l_row @ 5, True),
					new_id_sd (l_row @ 6, True))
				al.extend (l_assembly_sd)
				gac_assembly_list.forth
			end
			root_ast.set_assemblies (al)
		end
		

	retrieve (root_ast: ACE_SD) is
			-- Retrieve content of `root_ast' and update content of widget.
		do
			initialize_from_ast (root_ast)
		end

feature {NONE} -- Filling

	initialize_from_ast (root_ast: ACE_SD) is
			-- Initialize window with all data taken from `root_ast'.
		require
			root_ast_not_void: root_ast /= Void
		local
			al: LACE_LIST [ASSEMBLY_SD]
			assembly: ASSEMBLY_SD
			list_row: EV_MULTI_COLUMN_LIST_ROW
		do
			al ?= root_ast.assemblies
			if al /= Void then
				from
					al.start
				until
					al.after
				loop
					assembly := al.item
					if assembly_type (assembly).is_equal ("local") then
							-- Add local reference row
						create list_row
						list_row.extend (assembly.cluster_name)
						if (assembly.prefix_name /= Void and not assembly.prefix_name.is_empty) then
							list_row.extend (assembly.prefix_name)
						else
							list_row.extend ("")
						end
						list_row.extend (assembly.assembly_name)
						if assembly.public_key_token /= Void then
							list_row.extend (assembly.version)
							list_row.extend (assembly.culture)
							list_row.extend (assembly.public_key_token)
						end
						local_assembly_list.extend (list_row)
						--list_row.pointer_double_press_actions.force_extend (agent on_list_item_selected)
					else
							-- Add GAC reference row
						create list_row
						list_row.extend (assembly.cluster_name)
						if (assembly.prefix_name /= Void and not assembly.prefix_name.is_empty) then
							list_row.extend (assembly.prefix_name)
						else
							list_row.extend ("")
						end
						list_row.extend (assembly.assembly_name)
						list_row.extend (assembly.version)
						list_row.extend (assembly.culture)
						list_row.extend (assembly.public_key_token)
						gac_assembly_list.extend (list_row)
					end
					al.forth
				end
				al.wipe_out
			end
		end

feature -- Checking

	perform_check is
			-- Perform check on content of current pane.
		do
			set_is_valid (True)
		end

feature -- Actions

	add_gac_assembly_reference (assembly_list: EV_MULTI_COLUMN_LIST) is
			-- Add item selected in 'assembly_list' to the 'gac_assembly_list' references
		require
			list_not_void: assembly_list /= Void
		local
			--selected_items: DYNAMIC_LIST [EV_MULTI_COLUMN_LIST_ROW]
			list_row, selected_item: EV_MULTI_COLUMN_LIST_ROW
			assembly_interface: IL_ASSEMBLY_FACADE
		do			
			create assembly_interface.make
			selected_item := assembly_list.selected_item
			if selected_item /= Void then
				assembly_interface.go_i_th (assembly_list.index_of (selected_item, 1) - 1)
				create list_row
				list_row.extend (unique_assembly_cluster_name ("GAC",
									selected_item @ 1,
									selected_item @ 2,
									selected_item @ 3,
									selected_item @ 4))
				list_row.extend ("")
				list_row.extend (selected_item @ 1)
				list_row.extend (selected_item @ 2)
				list_row.extend (selected_item @ 3)
				list_row.extend (selected_item @ 4)
				gac_assembly_list.extend (list_row)
				populate_gac_assembly_dialog (assembly_list)
			end	
		end

	remove_gac_assembly_reference is
			-- Remove GAC assembly reference(s) from project
		do
			from
				gac_assembly_list.start
			until
				gac_assembly_list.after
			loop
				if gac_assembly_list.item.is_selected then
					gac_assembly_list.remove
				end
				gac_assembly_list.forth
			end
		end
	
	show_gac_assembly_dialog is
			-- Show the GAC assembly dialog to allow for adding of
			-- GAC assemblies
		local
			gac_dialog: EV_DIALOG
			vbox, item_box: EV_VERTICAL_BOX
			hbox: EV_HORIZONTAL_BOX
			cell: EV_CELL
			label: EV_LABEL
			assembly_list: EV_MULTI_COLUMN_LIST
			assembly_add_button, assembly_cancel_button: EV_BUTTON
		do			
			create gac_dialog
			gac_dialog.set_title ("GAC Assembly Dialog")	
			
			create vbox
			vbox.set_border_width (Layout_constants.Small_border_size)
			vbox.set_padding (Layout_constants.Small_padding_size)

			create item_box
			item_box.set_padding (Layout_constants.Tiny_padding_size)
			create label.make_with_text ("Global Assembly Cache")
			label.align_text_left
			create assembly_list
			assembly_list.disable_multiple_selection
			assembly_list.set_column_titles (<<"Assembly Name", "Version", "Culture", "Public Key">>)
			item_box.extend (label)
			item_box.disable_item_expand (label)
			item_box.extend (assembly_list)
			vbox.extend (item_box)

			create hbox
			hbox.set_padding (Layout_constants.Tiny_padding_size)
			create cell
			hbox.extend (cell)
			create assembly_add_button.make_with_text_and_action 
				("Add", agent add_gac_assembly_reference (assembly_list))
			assembly_add_button.set_minimum_width (80)
			create assembly_cancel_button.make_with_text_and_action 
				("Close", agent gac_dialog.destroy)
			assembly_cancel_button.set_minimum_width (80)
			hbox.extend (assembly_add_button)
			hbox.extend (assembly_cancel_button)
			hbox.disable_item_expand (assembly_add_button)
			hbox.disable_item_expand (assembly_cancel_button)
			vbox.extend (hbox)
			vbox.disable_item_expand (hbox)

			gac_dialog.extend (vbox)
			gac_dialog.set_size (400, 400)	
			populate_gac_assembly_dialog (assembly_list)			
			gac_dialog.show_modal_to_window (system_window.window)
		end

	add_local_assembly_reference is
			-- Open the browse dialog for adding of local assembly reference
		local
			fd: EV_FILE_OPEN_DIALOG
			list_row: EV_MULTI_COLUMN_LIST_ROW
			assembly_interface: IL_ASSEMBLY_FACADE
		do
			create fd
			fd.set_filter ("*.*")
			fd.set_title ("Select an Assembly")
			fd.show_modal_to_window (system_window.window)
			if fd.file_name /= Void and then not fd.file_name.is_empty then
				if (fd.file_name.substring_index (".dll", fd.file_name.count - 4) > 0)
					or (fd.file_name.substring_index (".exe", fd.file_name.count - 4) > 0) then
						create assembly_interface.make
						if assembly_interface.signed 
								(create {STRING}.make_from_string (fd.file_name)) then
							assembly_interface.get_assembly_info_from_assembly 
								(create {STRING}.make_from_string (fd.file_name))
							create list_row
							list_row.extend (unique_assembly_cluster_name ("local",
												assembly_interface.assembly_name,
												assembly_interface.assembly_version,
												assembly_interface.assembly_culture,
												assembly_interface.assembly_public_key_token))
							list_row.extend ("")
							list_row.extend (fd.file_name)
							list_row.extend (assembly_interface.assembly_version)
							list_row.extend (assembly_interface.assembly_culture)
							list_row.extend (assembly_interface.assembly_public_key_token)
							local_assembly_list.extend (list_row)
						end
				end
			end
		end

	remove_local_assembly_reference is
			-- Remove local assembly reference(s) from project
		do
			from
				local_assembly_list.start
			until
				local_assembly_list.after
			loop
				if local_assembly_list.item.is_selected then
					local_assembly_list.remove
				end
				local_assembly_list.forth
			end
		end
		
	on_list_item_selected is
			-- User has double clicked list row so set up dialogs for in-place editing
		local
			name_column_width,
			prefix_column_width,
			name_x, name_y,
			prefix_x, prefix_y: INTEGER
			change_dialog: EV_UNTITLED_DIALOG
			a_list: EV_MULTI_COLUMN_LIST
		do
			if gac_assembly_list.has_focus then
				a_list := gac_assembly_list
			else
				a_list := local_assembly_list
			end

			name_column_width := gac_assembly_list.column_width (1)
			prefix_column_width := gac_assembly_list.column_width (2)
			
			create change_dialog
			change_dialog.disable_user_resize
			create name_change_item_widget
			name_change_item_widget.focus_out_actions.extend (agent on_assembly_item_deselected)
			name_change_item_widget.change_actions.extend (agent update_actions)
			change_dialog.extend (name_change_item_widget)
			name_edition_window := change_dialog				
			name_x := a_list.screen_x + 1
			name_y := a_list.screen_y + 
						a_list.index_of (a_list.selected_item, 1) * 
						a_list.row_height
			name_edition_window.set_position (name_x, name_y)
			name_edition_window.set_size (name_column_width - 2, a_list.row_height - 5)
			name_edition_window.show_relative_to_window (system_window.window)
			
			create change_dialog
			change_dialog.disable_user_resize
			create prefix_change_item_widget
			prefix_change_item_widget.focus_out_actions.extend (agent on_assembly_item_deselected)
			prefix_change_item_widget.change_actions.extend (agent update_actions)
			change_dialog.extend (prefix_change_item_widget)
			prefix_edition_window := change_dialog			
			prefix_x := a_list.screen_x + name_column_width + 1
			prefix_y := a_list.screen_y + 
						a_list.index_of (a_list.selected_item, 1) * 
						a_list.row_height
			prefix_edition_window.set_position (prefix_x, prefix_y)
			prefix_edition_window.set_size (prefix_column_width - 2, a_list.row_height - 10)
			prefix_edition_window.show_relative_to_window (system_window.window)
		end
		
	on_assembly_item_deselected is
			-- Clear any in-place editing dialogs since row has lost focus and also
			-- set row data to reflect newly entered text
		do
			if prefix_edition_window /= Void and name_edition_window /= Void and then not
				(name_edition_window.has_focus or prefix_edition_window.has_focus) and then
					prefix_edition_window.is_displayed and name_edition_window.is_displayed then
						name_edition_window.hide
						name_edition_window := Void
						prefix_edition_window.hide
						prefix_edition_window := Void
			end
		end
		
	update_actions is
			--  
		do
			if gac_assembly_list.selected_item /= Void then
				if not name_change_item_widget.text.is_empty then
					gac_assembly_list.selected_item.put_i_th (name_change_item_widget.text, 1)
				end
				if not prefix_change_item_widget.text.is_empty then
					gac_assembly_list.selected_item.put_i_th (prefix_change_item_widget.text, 2)
				end
			elseif local_assembly_list.selected_item /= Void then		
				if not name_change_item_widget.text.is_empty then
					local_assembly_list.selected_item.put_i_th (name_change_item_widget.text, 1)
				end
				if not prefix_change_item_widget.text.is_empty then
					local_assembly_list.selected_item.put_i_th (prefix_change_item_widget.text, 2)
				end
			end
		end

feature {NONE} -- Initialization

	make (top: like system_window) is
			-- Create widget corresponding to `General' tab in notebook.
		require
			top_not_void: top /= Void
		do
			system_window := top
			tab_make
			default_create
			
			extend (msil_assembly_info ("GAC", agent show_gac_assembly_dialog, agent remove_gac_assembly_reference))
			extend (msil_assembly_info ("local", agent add_local_assembly_reference, agent remove_local_assembly_reference))

			msil_specific_widgets.extend (Current)
		end

	reset is
			-- Set graphical elements to their default value.
		do
			Precursor {EB_SYSTEM_TAB}
			gac_assembly_list.wipe_out
			local_assembly_list.wipe_out
		ensure then
			gac_assembly_list_empty: gac_assembly_list.is_empty
			local_assembly_list_empty: local_assembly_list.is_empty
		end

	msil_assembly_info (a_assembly_type: STRING; add_proc, remove_proc: PROCEDURE [ANY, TUPLE []]): EV_FRAME is
			-- MSIL information about assembly references
		require
			type_not_void: a_assembly_type /= Void
			type_not_empty: not a_assembly_type.is_empty
		local
			vbox, item_box: EV_VERTICAL_BOX
			hbox: EV_HORIZONTAL_BOX
			cell: EV_CELL
			add_button, remove_button: EV_BUTTON
		do
			create vbox
			vbox.set_border_width (Layout_constants.Small_border_size)
			vbox.set_padding (Layout_constants.Small_padding_size)
			create item_box
			item_box.set_padding (Layout_constants.Tiny_padding_size)
			
			if a_assembly_type.is_equal ("GAC") then
				create Result.make_with_text ("GAC Assembly References")
				create gac_assembly_list
				gac_assembly_list.set_column_titles 
					(<<"Cluster Name", "Prefix", "Name", "Version", "Culture", "Public Key">>)
				gac_assembly_list.disable_multiple_selection
				gac_assembly_list.pointer_double_press_actions.force_extend (agent on_list_item_selected)
				gac_assembly_list.focus_out_actions.force_extend (agent on_assembly_item_deselected)
				item_box.extend (gac_assembly_list)
			elseif a_assembly_type.is_equal ("local") then
				create Result.make_with_text ("Local Assembly References")
				create local_assembly_list
				local_assembly_list.set_column_titles 
					(<<"Cluster Name", "Prefix", "Path", "Version", "Culture", "Public Key">>)
				local_assembly_list.disable_multiple_selection
				local_assembly_list.set_column_width (0, 4)
				local_assembly_list.set_column_width (0, 5)
				local_assembly_list.set_column_width (0, 6)
				local_assembly_list.pointer_double_press_actions.force_extend (agent on_list_item_selected)
				local_assembly_list.focus_out_actions.force_extend (agent on_assembly_item_deselected)
				item_box.extend (local_assembly_list)
			end
			
			create add_button.make_with_text_and_action ("Add", add_proc)
			create remove_button.make_with_text_and_action ("Remove", remove_proc)
			vbox.extend (item_box)
			create hbox
			hbox.set_padding (Layout_constants.Tiny_padding_size)
			create cell
			add_button.set_minimum_width (80)
			remove_button.set_minimum_width (80)
			hbox.extend (cell)
			hbox.extend (add_button)
			hbox.extend (remove_button)
			hbox.disable_item_expand (add_button)
			hbox.disable_item_expand (remove_button)
			vbox.extend (hbox)
			vbox.disable_item_expand (hbox)
			Result.extend (vbox)
		end
		
feature -- Implementation

	assembly_type (a_assembly: ASSEMBLY_SD): STRING is
			-- String representation of assembly type, "local" or "GAC"
		require
			a_assembly_not_void: a_assembly /= Void
		local
			a_file: RAW_FILE
		do
			if (a_assembly.public_key_token /= Void and not a_assembly.public_key_token.is_empty) then
				create a_file.make (a_assembly.assembly_name)
				if a_file.exists then
					if a_assembly.assembly_name.count >= 4 then
						if a_assembly.assembly_name.substring_index (".dll", a_assembly.assembly_name.count - 4) > 0 then
							Result := "local"
						elseif a_assembly.assembly_name.substring_index (".exe", a_assembly.assembly_name.count - 4) > 0 then
							Result := "local"
						end
					end
				else
					Result := "GAC"
				end
			else
				Result := "local"
			end	
		end
		
	populate_gac_assembly_dialog (assembly_list: EV_MULTI_COLUMN_LIST) is
			-- Populate the 'assembly_list' with the list of assemblies in the GAC
		require
			list_not_void: assembly_list /= Void
		local
			assembly_interface: IL_ASSEMBLY_FACADE
			list_row: EV_MULTI_COLUMN_LIST_ROW
			add_to_gac_dialog: BOOLEAN
		do
			create assembly_interface.make
			from
				assembly_list.wipe_out
				assembly_interface.start
			until
				assembly_interface.after
			loop
				from
					gac_assembly_list.start
					add_to_gac_dialog := True
				until
					gac_assembly_list.after or not add_to_gac_dialog
				loop
					list_row := gac_assembly_list.item
						if list_row.i_th (3).is_equal (assembly_interface.assembly_name) then
							if list_row.i_th (4).is_equal (assembly_interface.assembly_version) then
								if list_row.i_th (5).is_equal (assembly_interface.assembly_culture) then 
									if list_row.i_th (6).is_equal (assembly_interface.assembly_public_key_token) then
										add_to_gac_dialog := False
									end
								end
							end
						end
					gac_assembly_list.forth
				end
				if add_to_gac_dialog then
					create list_row
					list_row.extend (assembly_interface.assembly_name)
					list_row.extend (assembly_interface.assembly_version)
					list_row.extend (assembly_interface.assembly_culture)
					list_row.extend (assembly_interface.assembly_public_key_token)
					assembly_list.extend (list_row)
				end
				assembly_interface.forth
			end
		end
		
	add_prefix (a_prefix: EV_TEXT_FIELD; a_list: EV_MULTI_COLUMN_LIST) is
			-- Add 'a_prefix' to the c
		require
			list_not_void: a_list /= Void
		do	
			a_list.selected_item.go_i_th (2)
			a_list.selected_item.replace (a_prefix.text)
			a_prefix.parent.parent.parent.destroy
		end
	
	unique_assembly_cluster_name (ass_type, a_name, a_culture, a_version, a_public_key: STRING): STRING is
			-- Produce a unique cluster name from assembly details relative to 'a_list'
		local
			i: INTEGER
			finished: BOOLEAN
			current_cluster_names: ARRAYED_LIST [STRING]
			temp_id_string: STRING
		do
			from
				i := 1
				current_cluster_names := cluster_names (ass_type)
			until	
				i = 5 or finished
			loop
				inspect i
				when 1 then
					if a_name.is_empty then 
						create temp_id_string.make_from_string ("Assembly")
					else
						create temp_id_string.make_from_string (a_name)
					end
				when 2 then
					if not a_version.is_empty then
						temp_id_string.append (a_version)
					end
				when 3 then
					if not a_culture.is_empty then
						temp_id_string.append (a_culture)
					end	
				when 4 then		
					if not a_public_key.is_empty then
						temp_id_string.append (a_public_key)
					end		
				end
				if current_cluster_names.has (temp_id_string) then
					i := i + 1
				else
					finished := True
				end			
			end
			from
				i := 1
				temp_id_string.replace_substring_all (".", "_")
			until
				i = temp_id_string.count
			loop
				if not (temp_id_string.item (i).is_alpha or 
						temp_id_string.item (i).is_digit or
						temp_id_string.item (i).is_equal ('_')) then
					temp_id_string.replace_substring ("%%", i, i)
				end
				i := i + 1
			end
			temp_id_string.replace_substring_all ("%%", "")
			Result := temp_id_string
		end
		
	cluster_names (ass_type: STRING): ARRAYED_LIST [STRING] is
			-- Get the cluster names for referenced assemblies of type 'ass_type'
		local
			a_list: EV_MULTI_COLUMN_LIST
		do
			if ass_type.is_equal ("local") then
				a_list := local_assembly_list
			elseif ass_type.is_equal ("GAC") then
				a_list := gac_assembly_list
			end
			
			from
				create Result.make (a_list.count)
				a_list.start
			until
				a_list.after
			loop
				Result.extend (a_list.item @ (1))
				a_list.forth
			end
		end
	
invariant
	widgets_not_void:
		gac_assembly_list /= Void and
		local_assembly_list /= Void
	
end -- class EB_SYSTEM_MSIL_ASSEMBLY_TAB
