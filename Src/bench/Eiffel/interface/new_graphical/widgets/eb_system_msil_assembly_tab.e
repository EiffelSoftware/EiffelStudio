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
			-- Add items selected in 'assembly_list' to the 'gac_assembly_list' references
		require
			list_not_void: assembly_list /= Void
		local
			selected_items: DYNAMIC_LIST [EV_MULTI_COLUMN_LIST_ROW]
			list_row: EV_MULTI_COLUMN_LIST_ROW
		do			
			from
				selected_items := assembly_list.selected_items
				selected_items.start
			until
				selected_items.after
			loop
				create list_row
				list_row.extend ("A_cluster_name")
				list_row.extend ("A_prefix")
				list_row.extend (selected_items.item @ 1)
				list_row.extend (selected_items.item @ 2)
				list_row.extend (selected_items.item @ 3)
				list_row.extend (selected_items.item @ 4)
				gac_assembly_list.extend (list_row)	
				selected_items.forth
			end
			populate_gac_assembly_dialog (assembly_list)
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
		
	show_prefix_dialog (a_list: EV_MULTI_COLUMN_LIST) is
			-- Display the dialog to add a prefix
		local
			prefix_dialog: EV_DIALOG
			vbox, item_box: EV_VERTICAL_BOX
			hbox: EV_HORIZONTAL_BOX
			label: EV_LABEL
			ok_button, cancel_button: EV_BUTTON
			prefix_text: EV_TEXT_FIELD
			error_dialog: EV_INFORMATION_DIALOG
		do			
			if a_list.selected_item = Void then
				create error_dialog.make_with_text ("No Assembly selected")
				error_dialog.show
			else
				create prefix_dialog
				prefix_dialog.set_title ("Add Prefix")	
				
				create vbox
				vbox.set_border_width (Layout_constants.Small_border_size)
				vbox.set_padding (Layout_constants.Small_padding_size)
	
				create item_box
				item_box.set_padding (Layout_constants.Tiny_padding_size)
				create label.make_with_text ("Prefix:")
				label.align_text_left
				create prefix_text
				item_box.extend (label)
				item_box.disable_item_expand (label)
				item_box.extend (prefix_text)
				vbox.extend (item_box)
	
				create hbox
				hbox.set_padding (Layout_constants.Tiny_padding_size)
				create ok_button.make_with_text_and_action 
					("Ok", agent add_prefix (prefix_text, a_list))
				ok_button.set_minimum_width (80)
				create cancel_button.make_with_text_and_action ("Cancel", agent prefix_dialog.destroy)
				cancel_button.set_minimum_width (80)
				hbox.extend (ok_button)
				hbox.extend (cancel_button)
				hbox.disable_item_expand (ok_button)
				hbox.disable_item_expand (cancel_button)
				vbox.extend (hbox)
				vbox.disable_item_expand (hbox)
	
				prefix_dialog.extend (vbox)
				prefix_dialog.set_size (150, 75)			
				prefix_dialog.show_modal_to_window (system_window.window)
			end			
		end	
	
	add_local_assembly_reference is
			-- Open the browse dialog for adding of local assembly reference
		local
			fd: EV_FILE_OPEN_DIALOG
			list_row: EV_MULTI_COLUMN_LIST_ROW
			fusion_support: FUSION_SUPPORT
			assembly_info: FUSION_SUPPORT_ASSEMBLY_INFO
		do
			create fd
			fd.set_filter ("*.*")
			fd.set_title ("Select an Assembly")
			fd.show_modal_to_window (system_window.window)
			if fd.file_name /= Void and then not fd.file_name.is_empty then
				if (fd.file_name.substring_index (".dll", fd.file_name.count - 4) > 0)
					or (fd.file_name.substring_index (".exe", fd.file_name.count - 4) > 0) then
							-- Initialize COM.
						(create {CLI_COM}).initialize_com
						create fusion_support.make
						if fusion_support.signed (create {UNI_STRING}.make (fd.file_name)) then
							assembly_info := fusion_support.get_assembly_info_from_assembly (create {UNI_STRING}.make (fd.file_name))	
							create list_row
							list_row.extend ("A_cluster_name")
							list_row.extend ("A_prefix")
							list_row.extend (fd.file_name)
							list_row.extend (assembly_info.version)
							list_row.extend (assembly_info.culture)
							list_row.extend (assembly_info.public_key_token)
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
			extend (msil_assembly_info ("Local", agent add_local_assembly_reference, agent remove_local_assembly_reference))

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
			add_button, remove_button, prefix_button: EV_BUTTON
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
				create prefix_button.make_with_text_and_action 
					("Set prefix...", agent show_prefix_dialog (gac_assembly_list))
				item_box.extend (gac_assembly_list)
			elseif a_assembly_type.is_equal ("Local") then
				create Result.make_with_text ("Local Assembly References")
				create local_assembly_list
				local_assembly_list.set_column_titles 
					(<<"Cluster Name", "Prefix", "Path", "Version", "Culture", "Public Key">>)
				local_assembly_list.disable_multiple_selection
				local_assembly_list.set_column_width (0, 4)
				local_assembly_list.set_column_width (0, 5)
				local_assembly_list.set_column_width (0, 6)
				create prefix_button.make_with_text_and_action 
					("Set prefix...", agent show_prefix_dialog (local_assembly_list))
				item_box.extend (local_assembly_list)
			end
			
			create add_button.make_with_text_and_action ("Add", add_proc)
			create remove_button.make_with_text_and_action ("Remove", remove_proc)
			vbox.extend (item_box)
			create hbox
			hbox.set_padding (Layout_constants.Tiny_padding_size)
			create cell
			prefix_button.set_minimum_width (80)
			add_button.set_minimum_width (80)
			remove_button.set_minimum_width (80)
			hbox.extend (prefix_button)
			hbox.extend (cell)
			hbox.extend (add_button)
			hbox.extend (remove_button)
			hbox.disable_item_expand (prefix_button)
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
			fusion_support: FUSION_SUPPORT
			assemblies: FUSION_SUPPORT_ASSEMBLIES
			curr_assembly: FUSION_SUPPORT_ASSEMBLY_INFO
			lower_bound, upper_bound: INTEGER
			list_row: EV_MULTI_COLUMN_LIST_ROW
			add_to_gac_dialog: BOOLEAN
		do
			(create {CLI_COM}).initialize_com

			create fusion_support.make
			assemblies := fusion_support.assemblies
			from
				assembly_list.wipe_out
				lower_bound := 0
				upper_bound := assemblies.count
			until
				lower_bound = upper_bound
			loop
				curr_assembly := assemblies.ith_assembly_info (lower_bound)
				from
					gac_assembly_list.start
					add_to_gac_dialog := True
				until
					gac_assembly_list.after or not add_to_gac_dialog
				loop
					list_row := gac_assembly_list.item
						if list_row.i_th (3).is_equal (curr_assembly.name) then
							if list_row.i_th (4).is_equal (curr_assembly.version) then
								if list_row.i_th (5).is_equal (curr_assembly.culture) then 
									if list_row.i_th (6).is_equal (curr_assembly.public_key_token) then
										add_to_gac_dialog := False
									end
								end
							end
						end
					gac_assembly_list.forth
				end
				if add_to_gac_dialog then
					create list_row
					list_row.extend (curr_assembly.name)
					list_row.extend (curr_assembly.version)
					list_row.extend (curr_assembly.culture)
					list_row.extend (curr_assembly.public_key_token)
					assembly_list.extend (list_row)
				end
				lower_bound := lower_bound + 1
			end
		end
		
	valid_cluster_name (a_cluster_name: STRING) is
			-- Is 'a_cluster_name' valid for the current project?
		do	
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
		
invariant
	widgets_not_void:
		gac_assembly_list /= Void and
		local_assembly_list /= Void
	
end -- class EB_SYSTEM_MSIL_ASSEMBLY_TAB
