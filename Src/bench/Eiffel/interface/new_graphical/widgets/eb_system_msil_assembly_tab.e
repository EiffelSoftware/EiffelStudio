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

	gac_assembly_list: EV_EDITABLE_LIST
			-- List of GAC assemblies used in Current project.

	local_assembly_list: EV_EDITABLE_LIST
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
			pref_string, pk_string: ID_SD
		do
			if msil_widgets_enabled then
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
					if not (l_row @ 6).is_empty then
						pk_string := new_id_sd (l_row @ 6, True)
					else
						pk_string := Void
					end
					create l_assembly_sd.initialize (new_id_sd (l_row @ 1, False),
						new_id_sd (l_row @ 3, True),
						pref_string,
						new_id_sd (l_row @ 4, True),
						new_id_sd (l_row @ 5, True),
						pk_string)
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
		end
		

	retrieve (root_ast: ACE_SD) is
			-- Retrieve content of `root_ast' and update content of widget.
		do
			if msil_widgets_enabled then
				initialize_from_ast (root_ast)
			end
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
						local_assembly_list.resize_column_to_content (3)
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
						gac_assembly_list.resize_column_to_content (1)
						gac_assembly_list.resize_column_to_content (3)
						gac_assembly_list.resize_column_to_content (4)
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
			list_row, selected_item: EV_MULTI_COLUMN_LIST_ROW
		do			
			selected_item := assembly_list.selected_item
			if selected_item /= Void then
				assembly_interface.go_i_th (assembly_list.index_of (selected_item, 1) - 1)
				create list_row
				list_row.extend (unique_assembly_cluster_name ("GAC",
									clone (selected_item @ 1),
									clone (selected_item @ 2),
									clone (selected_item @ 3),
									clone (selected_item @ 4)))
				list_row.extend ("")
				list_row.extend (selected_item @ 1)
				list_row.extend (selected_item @ 2)
				list_row.extend (selected_item @ 3)
				list_row.extend (selected_item @ 4)
				gac_assembly_list.extend (list_row)
				assembly_list.go_i_th (assembly_list.index_of (assembly_list.selected_item, 1))
				assembly_list.remove
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
			assembly_list.pointer_double_press_actions.force_extend (agent add_gac_assembly_reference (assembly_list))
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
			l_ass_name: STRING
		do
			create fd
			fd.set_filter ("*.*")
			fd.set_title ("Select an Assembly")
			fd.show_modal_to_window (system_window.window)
			if fd.file_name /= Void and then not fd.file_name.is_empty then
				l_ass_name := fd.file_name
				if (l_ass_name.substring_index (".dll", l_ass_name.count - 4) > 0)
					or (l_ass_name.substring_index (".exe", l_ass_name.count - 4) > 0) then
						create assembly_interface.make
						assembly_interface.get_assembly_info_from_assembly (l_ass_name)
						create list_row
						if assembly_interface.signed (l_ass_name) then
								-- Assembly is signed.
							list_row.extend (unique_assembly_cluster_name ("local",
												assembly_interface.assembly_name,
												assembly_interface.assembly_version,
												assembly_interface.assembly_culture,
												assembly_interface.assembly_public_key_token))
						else
								-- Assembly is not signed.
							list_row.extend (unique_assembly_cluster_name ("local",
												assembly_interface.assembly_name,
												assembly_interface.assembly_version,
												assembly_interface.assembly_culture,
												""))
						end
							list_row.extend ("")
							list_row.extend (l_ass_name)
							local_assembly_list.extend (list_row)							
				end
			end
		end
		
	remove_reference (ass_type: STRING) is
			-- Remove selected reference from list
		do
			if ass_type.is_equal ("GAC") then
				gac_assembly_list.remove_selected_item
			elseif ass_type.is_equal ("Local") then
				local_assembly_list.remove_selected_item
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
			
			extend (msil_assembly_info ("GAC", agent show_gac_assembly_dialog, agent remove_reference ("GAC")))
			extend (msil_assembly_info ("local", agent add_local_assembly_reference, agent remove_reference ("Local")))
			
			initialize_assembly_interface
			msil_specific_widgets.extend (Current)
		end

	initialize_assembly_interface is
			-- Initialize the FusionSupport component for assembly access functions
		local
			error: EV_INFORMATION_DIALOG
		once
			create assembly_interface.make
			if not assembly_interface.exists then
				create error.make_with_text ("Unable to load FusionSupport.dll")
				error.show_modal_to_window (system_window.window)
			end
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
				create gac_assembly_list.make (system_window.window)
				gac_assembly_list.set_column_titles 
					(<<"Cluster Name", "Prefix", "Name", "Version", "Culture", "Public Key">>)
				gac_assembly_list.disable_multiple_selection
				gac_assembly_list.set_column_editable (True, 1)
				gac_assembly_list.set_column_editable (True, 2)
				gac_assembly_list.set_unique_column_values (True)
				gac_assembly_list.deselect_actions.force_extend (agent check_cluster_names_valid)
				item_box.extend (gac_assembly_list)
			elseif a_assembly_type.is_equal ("local") then
				create Result.make_with_text ("Local Assembly References")
				create local_assembly_list.make (system_window.window)
				local_assembly_list.set_column_titles
					(<<"Cluster Name", "Prefix", "Path">>)
				local_assembly_list.disable_multiple_selection
				local_assembly_list.set_column_editable (True, 1)
				local_assembly_list.set_column_editable (True, 2)
				local_assembly_list.set_unique_column_values (True)
				local_assembly_list.deselect_actions.force_extend (agent check_cluster_names_valid)
--				local_assembly_list.new_item_actions.extend
--					(local_assembly_list.set_column_width (local_assembly_list.resize_column_to_content (1)))
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

	assembly_interface: IL_ASSEMBLY_FACADE
			-- Interface to the FusionSupport component
		
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
				current_cluster_names := cluster_names
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
		
	check_cluster_names_valid is
			-- Are the assembly cluster names valid?
		local
			names: ARRAYED_LIST [STRING]
			valid: BOOLEAN
			error_dialog: EV_INFORMATION_DIALOG
			name_error_message: STRING
		do
			names := cluster_names
			names.compare_objects
			name_error_message := " is an invalid assembly cluster name.%NPlease enter a new cluster name."
			from
				names.start
				valid := True
			until
				names.after or not valid
			loop
				if not valid_cluster_name (names.item) then
					valid := False
				elseif names.occurrences (names.item) > 1 then
					valid := False
				else
					names.forth
				end
			end
			if not valid then
				create error_dialog.make_with_text (names.item + name_error_message)
					error_dialog.show_modal_to_window (system_window.window)
				if gac_assembly_list.has_focus then
					gac_assembly_list.set_field
				elseif local_assembly_list.has_focus then
					local_assembly_list.set_field
				end
			end
		end
		
	valid_cluster_name (a_name: STRING): BOOLEAN is
			-- Is 'a_name' valid?
		local
			valid: BOOLEAN
			i: INTEGER
		do
			from
				i := 1
				valid := True
				if (not a_name.item (i).is_alpha) or reserved_words.has (a_name) then
					valid := False
				end
			until
				i = a_name.count + 1 or not valid
			loop
				if not (a_name.item (i).is_alpha or 
						a_name.item (i).is_digit or
						a_name.item (i).is_equal ('_') or
						a_name.is_empty) then
					valid := False
				end
				i := i + 1
			end
			Result := valid
		end	
		
	cluster_names: ARRAYED_LIST [STRING] is
			-- Get the cluster names for referenced assemblies
		do
			create Result.make (gac_assembly_list.count + local_assembly_list.count)
			from
				gac_assembly_list.start
			until
				gac_assembly_list.after
			loop
				Result.extend (gac_assembly_list.item @ (1))
				gac_assembly_list.forth
			end
			from
				local_assembly_list.start
			until
				local_assembly_list.after
			loop
				Result.extend (local_assembly_list.item @ (1))
				local_assembly_list.forth
			end
		end
	
	reserved_words: ARRAYED_LIST [STRING] is
			-- List of Lace reserved words which cannot be used for cluster names
		once
			create Result.make (37)
			Result.compare_objects
			Result.extend ("adapt")
			Result.extend ("all")
			Result.extend ("as")
			Result.extend ("assembly")
			Result.extend ("assertion")
			Result.extend ("check")
			Result.extend ("cluster")
			Result.extend ("create")
			Result.extend ("creation")
			Result.extend ("debug")
			Result.extend ("disable_debug")
			Result.extend ("default")
			Result.extend ("end")
			Result.extend ("ensure")
			Result.extend ("exclude")
			Result.extend ("depend")
			Result.extend ("export")
			Result.extend ("external")
			Result.extend ("generate")
			Result.extend ("ignore")
			Result.extend ("include")
			Result.extend ("invariant")
			Result.extend ("library")
			Result.extend ("loop")
			Result.extend ("no")
			Result.extend ("optimize")
			Result.extend ("option")
			Result.extend ("precompiled")
			Result.extend ("prefix")
			Result.extend ("rename")
			Result.extend ("require")
			Result.extend ("root")
			Result.extend ("system")
			Result.extend ("trace")
			Result.extend ("use")
			Result.extend ("visible")
			Result.extend ("yes")
		end	
	
invariant
	widgets_not_void:
		gac_assembly_list /= Void and
		local_assembly_list /= Void
	
end -- class EB_SYSTEM_MSIL_ASSEMBLY_TAB
