indexing
	description: "Assembly viewer (imported assemblies only)"
	external_name: "ISE.AssemblyManager.ImportedAssemblyViewer"

class
	IMPORTED_ASSEMBLY_VIEWER

inherit
	ASSEMBLY_VIEWER
		redefine
			dictionary--,
			--build_menu
		end

create
	make

feature -- Access

	non_editable_assemblies: SYSTEM_COLLECTIONS_ARRAYLIST is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_ASSEMBLYDESCRIPTOR]
		indexing
			description: "List of assemblies that cannot be edited"
			external_name: "NonEditableAssemblies"
		local
			special_assemblies: SPECIAL_ASSEMBLIES
		once
			create special_assemblies
			Result := special_assemblies.non_editable_assemblies
		ensure
			non_editable_assemblies_created: Result /= Void
		end
		
	dictionary: IMPORTED_ASSEMBLY_VIEWER_DICTIONARY is
		indexing
			description: "Dictionary"
			external_name: "Dictionary"
		once
			create Result
		end

	path_menu_item: SYSTEM_WINDOWS_FORMS_MENUITEM
		indexing
			description: "Eiffel path menu item"
			external_name: "PathMenuItem"
		end

	show_name_and_path_menu_item: SYSTEM_WINDOWS_FORMS_MENUITEM
		indexing
			description: "`Show name and path' menu item"
			external_name: "ShowNameAndPathMenuItem"
		end
		
	edit_menu_item: SYSTEM_WINDOWS_FORMS_MENUITEM
		indexing
			description: "Edit menu item"
			external_name: "EditMenuItem"
		end
		
	remove_menu_item: SYSTEM_WINDOWS_FORMS_MENUITEM
		indexing
			description: "Remove menu item"
			external_name: "RemoveMenuItem"
		end	

	eiffel_generation_menu_item: SYSTEM_WINDOWS_FORMS_MENUITEM
		indexing
			description: "Eiffel generation menu item"
			external_name: "EiffelGenerationMenuItem"
		end
		
	path_toolbar_button: SYSTEM_WINDOWS_FORMS_TOOLBARBUTTON
		indexing
			description: "Eiffel path toolbar button"
			external_name: "PathToolbarButton"
		end

	edit_toolbar_button: SYSTEM_WINDOWS_FORMS_TOOLBARBUTTON
		indexing
			description: "Edit toolbar button"
			external_name: "EditToolbarButton"
		end
		
	remove_toolbar_button: SYSTEM_WINDOWS_FORMS_TOOLBARBUTTON
		indexing
			description: "Remove toolbar button"
			external_name: "RemoveToolbarButton"
		end	

	eiffel_generation_toolbar_button: SYSTEM_WINDOWS_FORMS_TOOLBARBUTTON
		indexing
			description: "Eiffel generation toolbar button"
			external_name: "EiffelGenerationToolbarButton"
		end

	eiffel_path_column_style: SYSTEM_WINDOWS_FORMS_DATAGRIDTEXTBOXCOLUMN	
		indexing
			description: "Eiffel path column style"
			external_name: "EiffelPathColumnStyle"
		end

	eiffel_path_column: SYSTEM_DATA_DATACOLUMN
		indexing
			description: "Column with path to Eiffel sources for imported assemblies"
			external_name: "EiffelPathColumn"
		end

feature -- Status Report
	
	is_non_editable_assembly (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): BOOLEAN is
		indexing
			description: "Is assembly corresponding to `a_descriptor' a non-editable assembly?"
			external_name: "IsNonRemovableAssembly"
		require
			non_void_descriptor: a_descriptor /= Void
		local
			i: INTEGER
			an_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
		do
			from
			until
				i = non_editable_assemblies.count or Result
			loop
				an_assembly_descriptor ?= non_editable_assemblies.item (i)
				if an_assembly_descriptor /= Void then
					Result := an_assembly_descriptor.name.tolower.equals_string (a_descriptor.name.tolower) and
							an_assembly_descriptor.version.tolower.equals_string (a_descriptor.version.tolower) and
							an_assembly_descriptor.culture.tolower.equals_string (a_descriptor.culture.tolower) and
							an_assembly_descriptor.publickey.tolower.equals_string (a_descriptor.publickey.tolower) 
				end
				i := i + 1
			end
		end
		
feature -- Basic Operations

	register_to_subject is
		indexing
			description: "Register assembly viewer to `ISE.ReflectionInterface.Notifier'."
			external_name: "RegisterToSubject"
		local
			type: SYSTEM_TYPE
			notifier_handle: ISE_REFLECTION_NOTIFIERHANDLE
			notifier: ISE_REFLECTION_NOTIFIER
			on_update_add_delegate: SYSTEM_EVENTHANDLER
			on_update_remove_delegate: SYSTEM_EVENTHANDLER
			on_update_replace_delegate: SYSTEM_EVENTHANDLER
		do
			create notifier_handle.make1
			notifier := notifier_handle.currentnotifier
			create on_update_add_delegate.make_eventhandler (Current, $update_add)		
			notifier.addadditionobserver (on_update_add_delegate)
			create on_update_remove_delegate.make_eventhandler (Current, $update_remove)		
			notifier.addremoveobserver (on_update_remove_delegate)
			create on_update_replace_delegate.make_eventhandler (Current, $update_replace)
			notifier.addreplaceobserver (on_update_replace_delegate)
		end
		
	build_menu is
		indexing
			description: "Build ISE assembly manager menu."
			external_name: "BuildMenu"
		local
			added: INTEGER
			separator: SYSTEM_WINDOWS_FORMS_MENUITEM
		do					
			--Precursor {ASSEMBLY_VIEWER}
			build_menu_assembly_viewer
			added := file_menu_item.menuitems.add (exit_menu_item)
			
				-- Build View menu item.
			create path_menu_item.make_menuitem_1 (dictionary.Path_menu_item)			
			create show_name_and_path_menu_item.make_menuitem_1 (dictionary.Show_name_and_path_menu_item)
			path_menu_item.set_shortcut (dictionary.Ctrl_P_shortcut)
			show_name_and_path_menu_item.set_shortcut (dictionary.Ctrl_W_shortcut)			
			path_menu_item.set_checked (True)
			added := view_menu_item.menuitems.add (path_menu_item)	
			separator := view_menu_item.menuitems.add_string ("-")
			added := view_menu_item.menuitems.add (show_all_menu_item)	
			added := view_menu_item.menuitems.add (show_name_and_path_menu_item)	
			
				-- Build Tools menu item.
			create edit_menu_item.make_menuitem_1 (dictionary.Edit_menu_item)
			create remove_menu_item.make_menuitem_1 (dictionary.Remove_menu_item)
			create import_menu_item.make_menuitem_1 (dictionary.Import_menu_item)
			create eiffel_generation_menu_item.make_menuitem_1 (dictionary.Eiffel_generation_menu_item)
			edit_menu_item.set_shortcut (dictionary.Ctrl_E_shortcut)
			remove_menu_item.set_shortcut (dictionary.Ctrl_M_shortcut)
			import_menu_item.set_shortcut (dictionary.Ctrl_I_shortcut)
			eiffel_generation_menu_item.set_shortcut (dictionary.Ctrl_G_shortcut)
			added := tools_menu_item.menuitems.add (edit_menu_item)
			added := tools_menu_item.menuitems.add (remove_menu_item)
			separator := tools_menu_item.menuitems.add_string ("-")
			added := tools_menu_item.menuitems.add (eiffel_generation_menu_item)
			separator := tools_menu_item.menuitems.add_string ("-")
			added := tools_menu_item.menuitems.add (import_menu_item)
		end
	
	set_menu_actions is
		indexing
			description: "Set actions to `main_menu'."
			external_name: "SetMenuActions"
		local
			path_delegate: SYSTEM_EVENTHANDLER
			show_name_and_path_delegate: SYSTEM_EVENTHANDLER
			edit_delegate: SYSTEM_EVENTHANDLER
			remove_delegate: SYSTEM_EVENTHANDLER
			eiffel_generation_delegate: SYSTEM_EVENTHANDLER
			import_delegate: SYSTEM_EVENTHANDLER		
		do
			--Precursor {ASSEMBLY_VIEWER}
			set_menu_actions_assembly_viewer
				-- View menu	
			create path_delegate.make_eventhandler (Current, $display_path)
			create show_name_and_path_delegate.make_eventhandler (Current, $show_name_and_path)
			path_menu_item.add_click (path_delegate)
			show_name_and_path_menu_item.add_click (show_name_and_path_delegate)
			
				-- Tools menu
			create edit_delegate.make_eventhandler (Current, $edit)
			create remove_delegate.make_eventhandler (Current, $remove)
			create import_delegate.make_eventhandler (Current, $import)
			create eiffel_generation_delegate.make_eventhandler (Current, $eiffel_generation)
			edit_menu_item.add_click (edit_delegate)
			remove_menu_item.add_click (remove_delegate)			
			import_menu_item.add_click (import_delegate)
			eiffel_generation_menu_item.add_click (eiffel_generation_delegate)	
		end

	build_toolbar is
		indexing
			description: "Build ISE assembly manager toolbar."
			external_name: "BuildToolbar"
		local
			added: INTEGER
			separator: SYSTEM_WINDOWS_FORMS_TOOLBARBUTTON
			toolbar_button_click_delegate: SYSTEM_WINDOWS_FORMS_TOOLBARBUTTONCLICKEVENTHANDLER
		do
			--Precursor {ASSEMBLY_VIEWER}
			build_toolbar_assembly_viewer
			create path_toolbar_button.make_toolbarbutton
			create edit_toolbar_button.make_toolbarbutton
			create remove_toolbar_button.make_toolbarbutton
			create import_toolbar_button.make_toolbarbutton
			create eiffel_generation_toolbar_button.make_toolbarbutton
			create separator.make_toolbarbutton
			
				-- Set icons to toolbar buttons.
			path_toolbar_button.set_imageindex (7)
			edit_toolbar_button.set_imageindex (8)
			remove_toolbar_button.set_imageindex (9)
			eiffel_generation_toolbar_button.set_imageindex (10)
			import_toolbar_button.set_imageindex (11)
			
				-- Set tooltips.
			path_toolbar_button.set_tooltiptext (dictionary.Path_menu_item)
			edit_toolbar_button.set_tooltiptext (dictionary.Edit_menu_item)
			remove_toolbar_button.set_tooltiptext (dictionary.Remove_menu_item)
			eiffel_generation_toolbar_button.set_tooltiptext (dictionary.Eiffel_generation_menu_item)
			import_toolbar_button.set_tooltiptext (dictionary.Import_menu_item)
			
				-- Set button style.
			path_toolbar_button.set_style (dictionary.Toggle_button)
			edit_toolbar_button.set_style (dictionary.Push_button)
			remove_toolbar_button.set_style (dictionary.Push_button)
			eiffel_generation_toolbar_button.set_style (dictionary.Push_button)
			import_toolbar_button.set_style (dictionary.Push_button)
			separator.set_style (dictionary.Separator)
			
				-- Set visible
			path_toolbar_button.set_pushed (True)
			
				-- Add buttons to `toolbar'.
			added := toolbar.buttons.add_toolbarbutton (path_toolbar_button)
			added := toolbar.buttons.add_toolbarbutton (separator)
			added := toolbar.buttons.add_toolbarbutton (dependancy_viewer_toolbar_button)
			added := toolbar.buttons.add_toolbarbutton (separator)
			added := toolbar.buttons.add_toolbarbutton (edit_toolbar_button)
			added := toolbar.buttons.add_toolbarbutton (remove_toolbar_button)
			added := toolbar.buttons.add_toolbarbutton (separator)
			added := toolbar.buttons.add_toolbarbutton (eiffel_generation_toolbar_button)
			added := toolbar.buttons.add_toolbarbutton (separator)
			added := toolbar.buttons.add_toolbarbutton (import_toolbar_button)
			added := toolbar.buttons.add_toolbarbutton (separator)
			added := toolbar.buttons.add_toolbarbutton (help_toolbar_button)
			controls.add (toolbar)
		end

	build_image_list is
		indexing
			description: "Build toolbar image list."
			external_name: "BuildImageList"
		local
			path_image: SYSTEM_DRAWING_IMAGE
			edit_image: SYSTEM_DRAWING_IMAGE
			remove_image: SYSTEM_DRAWING_IMAGE
			eiffel_generation_image: SYSTEM_DRAWING_IMAGE
			import_image: SYSTEM_DRAWING_IMAGE
			image_list: SYSTEM_WINDOWS_FORMS_IMAGELIST
			images: IMAGECOLLECTION_IN_SYSTEM_WINDOWS_FORMS_IMAGELIST 
		do
			--Precursor {ASSEMBLY_VIEWER}
			build_image_list_assembly_viewer
				-- Create icons
			path_image := image_factory.fromfile (dictionary.Path_icon_filename)
			edit_image := image_factory.fromfile (dictionary.Edit_icon_filename)
			remove_image := image_factory.fromfile (dictionary.Remove_icon_filename)
			eiffel_generation_image := image_factory.fromfile (dictionary.Eiffel_generation_icon_filename)
			import_image := image_factory.fromfile (dictionary.Import_icon_filename)
			
				-- Add icons to `imagelist'.
			image_list := toolbar.imagelist
			images := image_list.images
			images.add (path_image)
			images.add (edit_image)
			images.add (remove_image)
			images.add (eiffel_generation_image)
			images.add (import_image)
		end

	build_data_table is
		indexing
			description: "Build `data_table'."
			external_name: "BuildDataTable"
		local
			type: SYSTEM_TYPE
		do
			--Precursor {ASSEMBLY_VIEWER}
			build_data_table_assembly_viewer
			type := type_factory.GetType_String (dictionary.System_string_type);		
			create eiffel_path_column.make_datacolumn_2 (dictionary.Eiffel_path_column_title, type)			
			data_table.Columns.Add_DataColumn (eiffel_path_column)
		end

	build_data_grid is
		indexing
			description: "Build `data_grid' and associate actions."
			external_name: "BuildDataGrid"
		local
			added: INTEGER
			on_row_delegate: SYSTEM_EVENTHANDLER
		do
			--Precursor {ASSEMBLY_VIEWER}
			build_data_grid_assembly_viewer
			data_grid.set_captiontext (dictionary.Caption_text)
			create eiffel_path_column_style.make_datagridtextboxcolumn
			eiffel_path_column_style.set_mappingname (dictionary.Eiffel_path_column_title)
			eiffel_path_column_style.set_headertext (dictionary.Eiffel_path_column_title)
			added := data_grid_table_style.gridcolumnstyles.add (eiffel_path_column_style)	
			set_read_only
			resize_columns
			--create on_row_delegate.make_eventhandler (Current, $on_row)
			--data_grid.add_enter (on_row_delegate)
		end
		
feature -- Event handling

	on_close (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Action performed when user closes the window"
			external_name: "OnClose"
		do
			--reflection_interface.cleanassemblies
			close
		end
	
	update_replace (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Display assembly name column if checked."
			external_name: "DisplayName"
		require
			non_void_sender: sender /= Void
		do
			current_history.typestable.clear
		ensure
			empty_types_table: current_history.typestable.count = 0
		end
			
	display_name (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Display assembly name column if checked."
			external_name: "DisplayName"
		local
			checked: BOOLEAN
			columns: SYSTEM_DATA_DATACOLUMNCOLLECTION
		do
			columns := data_table.columns
			checked := name_menu_item.checked
			if columns.count > 1 or not checked then	
				if checked and then columns.contains (dictionary.Assembly_name_column_title) then
					columns.remove_datacolumn (assembly_name_column)
					name_menu_item.set_checked (not checked)
					name_toolbar_button.set_pushed (not checked)
					resize_columns
					refresh
				elseif not checked then
					controls.remove (data_grid)
					build_assemblies_table
					columns := data_table.columns
					columns.clear
					columns.add_datacolumn (assembly_name_column)
					if version_menu_item.checked then
						columns.add_datacolumn (assembly_version_column)
					end
					if culture_menu_item.checked then
						columns.add_datacolumn (assembly_culture_column)
					end
					if public_key_menu_item.checked then
						columns.add_datacolumn (assembly_public_key_column)
					end
					if dependancies_menu_item.checked then
						columns.add_datacolumn (dependancies_column)
					end
					if path_menu_item.checked then
						columns.add_datacolumn (eiffel_path_column)
					end	
					display_assemblies
					name_menu_item.set_checked (not checked)
					name_toolbar_button.set_pushed (not checked)
					resize_columns
					fill_data_grid
					controls.add (data_grid)
					refresh
				end
			end
		end

	display_version (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Display assembly version column if checked."
			external_name: "DisplayVersion"
		local
			checked: BOOLEAN
			columns: SYSTEM_DATA_DATACOLUMNCOLLECTION
		do
			columns := data_table.columns
			checked := version_menu_item.checked
			if columns.count > 1 or not checked then		
				if checked and then columns.contains (dictionary.Assembly_version_column_title) then
					columns.remove_datacolumn (assembly_version_column)
					version_menu_item.set_checked (not checked)
					version_toolbar_button.set_pushed (not checked)
					resize_columns
					refresh
				elseif not checked then
					controls.remove (data_grid)
					build_assemblies_table
					columns := data_table.columns
					columns.clear
					if name_menu_item.checked then
						columns.add_datacolumn (assembly_name_column)
					end
					columns.add_datacolumn (assembly_version_column)
					if culture_menu_item.checked then
						columns.add_datacolumn (assembly_culture_column)
					end
					if public_key_menu_item.checked then
						columns.add_datacolumn (assembly_public_key_column)
					end
					if dependancies_menu_item.checked then
						columns.add_datacolumn (dependancies_column)
					end
					if path_menu_item.checked then
						columns.add_datacolumn (eiffel_path_column)
					end	
					display_assemblies
					version_menu_item.set_checked (not checked)
					version_toolbar_button.set_pushed (not checked)
					resize_columns
					fill_data_grid
					controls.add (data_grid)
					refresh		
				end
			end
		end

	display_culture (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Display assembly culture column if checked."
			external_name: "DisplayCulture"
		local
			checked: BOOLEAN
			columns: SYSTEM_DATA_DATACOLUMNCOLLECTION
		do
			columns := data_table.columns
			checked := culture_menu_item.checked
			if columns.count > 1 or not checked then				
				if checked and then columns.contains (dictionary.Assembly_culture_column_title) then
					columns.remove_datacolumn (assembly_culture_column)
					culture_menu_item.set_checked (not checked)
					culture_toolbar_button.set_pushed (not checked)
					resize_columns
					refresh
				elseif not checked then
					controls.remove (data_grid)
					build_assemblies_table
					columns := data_table.columns
					columns.clear
					if name_menu_item.checked then
						columns.add_datacolumn (assembly_name_column)
					end
					if version_menu_item.checked then
						columns.add_datacolumn (assembly_version_column)
					end
					columns.add_datacolumn (assembly_culture_column)
					if public_key_menu_item.checked then
						columns.add_datacolumn (assembly_public_key_column)
					end
					if dependancies_menu_item.checked then
						columns.add_datacolumn (dependancies_column)
					end
					if path_menu_item.checked then
						columns.add_datacolumn (eiffel_path_column)
					end		
					display_assemblies
					culture_menu_item.set_checked (not checked)
					culture_toolbar_button.set_pushed (not checked)
					resize_columns
					fill_data_grid
					controls.add (data_grid)
					refresh		
				end
			end
		end

	display_public_key (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Display assembly public key column if checked."
			external_name: "DisplayPublicKey"
		local
			checked: BOOLEAN
			columns: SYSTEM_DATA_DATACOLUMNCOLLECTION
		do
			columns := data_table.columns
			checked := public_key_menu_item.checked
			if columns.count > 1 or not checked then						
				if checked and then columns.contains (dictionary.Assembly_public_key_column_title) then
					columns.remove_datacolumn (assembly_public_key_column)
					public_key_menu_item.set_checked (not checked)
					public_key_toolbar_button.set_pushed (not checked)	
					resize_columns
					refresh
				elseif not checked then
					controls.remove (data_grid)
					build_assemblies_table
					columns := data_table.columns
					columns.clear
					if name_menu_item.checked then
						columns.add_datacolumn (assembly_name_column)
					end
					if version_menu_item.checked then
						columns.add_datacolumn (assembly_version_column)
					end
					if culture_menu_item.checked then
						columns.add_datacolumn (assembly_culture_column)
					end
					columns.add_datacolumn (assembly_public_key_column)
					if dependancies_menu_item.checked then
						columns.add_datacolumn (dependancies_column)
					end
					if path_menu_item.checked then
						columns.add_datacolumn (eiffel_path_column)
					end	
					display_assemblies
					public_key_menu_item.set_checked (not checked)
					public_key_toolbar_button.set_pushed (not checked)	
					resize_columns
					fill_data_grid
					controls.add (data_grid)
					refresh		
				end
			end
		end

	display_dependancies (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Display dependancies column if checked."
			external_name: "DisplayDependancies"
		local
			checked: BOOLEAN
			columns: SYSTEM_DATA_DATACOLUMNCOLLECTION
		do
			columns := data_table.columns
			checked := dependancies_menu_item.checked
			if columns.count > 1 or not checked then						
				if checked and then columns.contains (dictionary.Dependancies_column_title) then
					columns.remove_datacolumn (dependancies_column)
					dependancies_menu_item.set_checked (not checked)
					dependancies_toolbar_button.set_pushed (not checked)	
					resize_columns
					refresh
				elseif not checked then
					controls.remove (data_grid)
					build_assemblies_table
					columns := data_table.columns
					columns.clear
					if name_menu_item.checked then
						columns.add_datacolumn (assembly_name_column)
					end
					if version_menu_item.checked then
						columns.add_datacolumn (assembly_version_column)
					end
					if culture_menu_item.checked then
						columns.add_datacolumn (assembly_culture_column)
					end
					if public_key_menu_item.checked then
						columns.add_datacolumn (assembly_public_key_column)
					end				
					columns.add_datacolumn (dependancies_column)
					if path_menu_item.checked then
						columns.add_datacolumn (eiffel_path_column)
					end					
					dependancies_menu_item.set_checked (not checked)
					dependancies_toolbar_button.set_pushed (not checked)
					display_assemblies
					resize_columns
					fill_data_grid
					controls.add (data_grid)
					refresh		
				end
			end
		end

	display_path (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Display path to Eiffel sources if checked."
			external_name: "DisplayPath"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			checked: BOOLEAN
			columns: SYSTEM_DATA_DATACOLUMNCOLLECTION
		do
			columns := data_table.columns
			checked := path_menu_item.checked
			if columns.count > 1 or not checked then						
				if checked and then columns.contains (dictionary.Eiffel_path_column_title) then
					columns.remove_datacolumn (eiffel_path_column)
					path_menu_item.set_checked (not checked)
					path_toolbar_button.set_pushed (not checked)	
					resize_columns
					refresh
				elseif not checked then
					controls.remove (data_grid)
					build_assemblies_table
					columns := data_table.columns
					columns.clear
					if name_menu_item.checked then
						columns.add_datacolumn (assembly_name_column)
					end
					if version_menu_item.checked then
						columns.add_datacolumn (assembly_version_column)
					end
					if culture_menu_item.checked then
						columns.add_datacolumn (assembly_culture_column)
					end
					if public_key_menu_item.checked then
						columns.add_datacolumn (assembly_public_key_column)
					end		
					if dependancies_menu_item.checked then
						columns.add_datacolumn (dependancies_column)
					end					
					columns.add_datacolumn (eiffel_path_column)
					display_assemblies
					path_menu_item.set_checked (not checked)
					path_toolbar_button.set_pushed (not checked)	
					resize_columns
					fill_data_grid
					controls.add (data_grid)
					refresh	
				end
			end
		end

	show_all (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Show all columns."
			external_name: "ShowAll"
		local
			columns: SYSTEM_DATA_DATACOLUMNCOLLECTION
		do
			show_all_assembly_viewer (sender, arguments)
			path_menu_item.set_checked (True)
			path_toolbar_button.set_pushed (True)
			columns := data_table.columns
			columns.add_datacolumn (eiffel_path_column)
			display_assemblies
			set_default_column_width
			fill_data_grid
			controls.add (data_grid)
			refresh
		ensure then
			all_columns_displayed: data_table.columns.count = 6
		end

	show_name_and_path (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Show assembly name column and eiffel path column only."
			external_name: "ShowNameAndPath"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			columns: SYSTEM_DATA_DATACOLUMNCOLLECTION
		do
			show_name_assembly_viewer (sender, arguments)
			path_menu_item.set_checked (True)
			path_toolbar_button.set_pushed (True)
			columns := data_table.columns
			columns.add_datacolumn (eiffel_path_column)	
			display_assemblies
			resize_columns
			fill_data_grid
			controls.add (data_grid)
			refresh
		ensure
			name_and_path_columns_displayed: data_table.columns.count = 2
		end
		
	edit (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Edit currently selected assembly (available only if assembly has been imported)."
			external_name: "Edit"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			selected_row: INTEGER
			a_type_list: SYSTEM_COLLECTIONS_ARRAYLIST
			an_assembly: ISE_REFLECTION_EIFFELASSEMBLY
			assembly_view: ASSEMBLY_VIEW
			current_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			windows_message_box: SYSTEM_WINDOWS_FORMS_MESSAGEBOX
			returned_value: INTEGER
			retried: BOOLEAN
			cursors: SYSTEM_WINDOWS_FORMS_CURSORS
			wait_cursor: SYSTEM_WINDOWS_FORMS_CURSOR
			normal_cursor: SYSTEM_WINDOWS_FORMS_CURSOR
			error_code: INTEGER
		do
			if not retried then
				intern_edit (False)
			else
				normal_cursor := cursors.Arrow
				set_cursor (normal_cursor)
				if not reflection_interface.lastreadsuccessful then 
					error_code := reflection_interface.lasterror.code
					if error_code = reflection_interface.Haswritelockcode or error_code = reflection_interface.Hasreadlockcode then
						returned_value := windows_message_box.show_string_string_messageboxbuttons_messageboxicon (dictionary.Access_violation_error, dictionary.Error_caption, dictionary.Abort_retry_ignore_message_box_buttons, dictionary.Error_icon)
						if returned_value = dictionary.Retry_result then
							intern_edit (False)
						elseif returned_value = dictionary.Ignore_result then
							intern_edit (True)
						end
					end
				else
					if reflection_interface.lasterror /= Void and then reflection_interface.lasterror.description /= Void and then reflection_interface.lasterror.description.length > 0 then
						returned_value := windows_message_box.show_string_string_messageboxbuttons_messageboxicon (reflection_interface.lasterror.description, dictionary.Error_caption, dictionary.Ok_message_box_button, dictionary.Error_icon)
					end
				end
			end
		rescue
			retried := True
			retry
		end
		
	remove (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Remove currently selected assembly (available only if assembly has been imported)."
			external_name: "Remove"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			selected_row: INTEGER
			a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			assembly_dependancies: ARRAY [SYSTEM_REFLECTION_ASSEMBLYNAME]
			remove_dialog: REMOVE_DIALOG
			support: SUPPORT
			retried: BOOLEAN
		do
			if not retried then
				create support
				selected_row := data_grid.CurrentRowIndex			
				a_descriptor := current_assembly (selected_row)
				if a_descriptor /= Void then
					assembly_dependancies := support.dependancies_from_info (a_descriptor)
					if assembly_dependancies = Void then
						create assembly_dependancies.make (0)
					end
					create remove_dialog.make (a_descriptor, assembly_dependancies)
				end
			end
		rescue 
			retried := True
			retry
		end

	import (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Display import tool."
			external_name: "Import"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			import_tool: IMPORT_TOOL
			cursors: SYSTEM_WINDOWS_FORMS_CURSORS
			wait_cursor: SYSTEM_WINDOWS_FORMS_CURSOR
			normal_cursor: SYSTEM_WINDOWS_FORMS_CURSOR
		do
			wait_cursor := cursors.WaitCursor
			set_cursor (wait_cursor)
			create import_tool.make
			normal_cursor := cursors.Arrow
			set_cursor (normal_cursor)
		end

	eiffel_generation (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Display Eiffel generation dialog."
			external_name: "EiffelGeneration"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			selected_row: INTEGER
			a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			eiffel_generation_dialog: EIFFEL_GENERATION_DIALOG
			retried: BOOLEAN
		do
			if not retried then
				selected_row := data_grid.CurrentRowIndex
				a_descriptor := current_assembly (selected_row)
				if a_descriptor /= Void and eiffel_path /= Void then
					create eiffel_generation_dialog.make (a_descriptor, eiffel_path)
				end
			end
		rescue
			retried := True
			retry
		end
		
	on_toolbar_button_clicked (sender: ANY; arguments: SYSTEM_WINDOWS_FORMS_TOOLBARBUTTONCLICKEVENTARGS) is
		indexing
			description: "Identify toolbar button and perform appropriate action."
			external_name: "OnToolBarButtonClicked"
		local
			index: INTEGER
			args: SYSTEM_EVENTARGS
		do
			index := toolbar.buttons.indexof (arguments.button) 
			create args.make
			inspect
				index
			when 0 then
				display_name (sender, args)
			when 1 then
				display_version (sender, args)
			when 2 then
				display_culture (sender, args)
			when 3 then
				display_public_key (sender, args)
			when 4 then
				display_dependancies (sender, args)
			when 5 then	
				display_path (sender, args)
			when 7 then
				show_dependancy_viewer (sender, args)
			when 9 then
				edit (sender, args)
			when 10 then
				remove (sender, args)
			when 12 then
				eiffel_generation (sender, args)
			when 14 then
				import (sender, args)
			when 16 then
				display_help (sender, args)
			end
		end		

--	on_row (sender: ANY; arguments: SYSTEM_EVENTARGS) is
--		indexing
--			description: "If selected cell is in the dependancies column then display dependancies"
--			external_name: "OnRow"
--		local
--			selected_row: INTEGER
--			a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
--			assembly_dependancies: ARRAY [SYSTEM_REFLECTION_ASSEMBLYNAME]
--			special_assemblies: SPECIAL_ASSEMBLIES
--			non_editable: BOOLEAN
--			non_removable: BOOLEAN
--		do
--			selected_row := data_grid.CurrentCell.RowNumber
--			if selected_row /= -1 then
--				a_descriptor := current_assembly (selected_row)	
--				if a_descriptor /= Void then
--					create special_assemblies
--					non_editable := special_assemblies.non_editable_assemblies.contains (a_descriptor)
--					edit_menu_item.set_enabled (not non_editable)
--					edit_toolbar_button.set_enabled (not non_editable)	
--
--					non_removable := special_assemblies.non_removable_assemblies.contains (a_descriptor)							
--					remove_menu_item.set_enabled (not non_removable)
--					remove_toolbar_button.set_enabled (not non_removable)
--				end
--			end
--		end
		
	update_remove (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Update `assemblies_table'."
			external_name: "UpdateRemove"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		do
			update_gui
		end
		
feature {NONE} -- Implementation

	intern_edit (remove_locks: BOOLEAN) is
		indexing
			description: "Internal code of the `edit' feature"
			external_name: "InternEdit"
		local
			selected_row: INTEGER
			a_type_list: SYSTEM_COLLECTIONS_ARRAYLIST
			an_assembly: ISE_REFLECTION_EIFFELASSEMBLY
			assembly_view: ASSEMBLY_VIEW
			current_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			windows_message_box: SYSTEM_WINDOWS_FORMS_MESSAGEBOX
			returned_value: INTEGER
			retried: BOOLEAN
			cursors: SYSTEM_WINDOWS_FORMS_CURSORS
			wait_cursor: SYSTEM_WINDOWS_FORMS_CURSOR
			normal_cursor: SYSTEM_WINDOWS_FORMS_CURSOR		
		do
			wait_cursor := cursors.WaitCursor
			set_cursor (wait_cursor)
			selected_row := data_grid.CurrentRowIndex
			current_descriptor := current_assembly (selected_row)
			if current_descriptor /= Void then
				if is_non_editable_assembly (current_descriptor) then
					normal_cursor := cursors.Arrow
					set_cursor (normal_cursor)
					returned_value := windows_message_box.show_string_string_messageboxbuttons_messageboxicon (dictionary.Non_editable_assembly, dictionary.Error_caption, dictionary.Ok_message_box_button, dictionary.Error_icon)
				else	
					if remove_locks then
						reflection_interface.cleanassembly (current_descriptor)
					end
					an_assembly := reflection_interface.assembly (current_descriptor)
					if an_assembly /= Void then
						a_type_list := an_assembly.types
						if a_type_list /= Void then								
							create assembly_view.make (an_assembly)
							normal_cursor := cursors.Arrow
							set_cursor (normal_cursor)
						end
					else
						normal_cursor := cursors.Arrow
						set_cursor (normal_cursor)
						if reflection_interface.lasterror /= Void and then reflection_interface.lasterror.description /= Void and then reflection_interface.lasterror.description.length > 0 then
							returned_value := windows_message_box.show_string_string_messageboxbuttons_messageboxicon (reflection_interface.lasterror.description, dictionary.Error_caption, dictionary.Ok_message_box_button, dictionary.Error_icon)
						end
					end
				end
			end
		end
		
	build_assemblies is
		indexing
			description: "Build `imported_assemblies' and sort assemblies by assembly name."
			external_name: "BuildAssemblies"
		local
			retried: BOOLEAN
			returned_value: INTEGER
			message_box: SYSTEM_WINDOWS_FORMS_MESSAGEBOX
			error_code: INTEGER
		do
			if not retried then
				imported_assemblies := reflection_interface.assemblies
				sort_assemblies
			else
				if not reflection_interface.lastreadsuccessful then 
					error_code := reflection_interface.lasterror.code
					if error_code = reflection_interface.Haswritelockcode or error_code = reflection_interface.Hasreadlockcode then
						returned_value := message_box.show_string_string_messageboxbuttons_messageboxicon (dictionary.Access_violation_error, dictionary.Error_caption, dictionary.Abort_retry_ignore_message_box_buttons, dictionary.Error_icon)
						if returned_value = dictionary.Retry_result then
							imported_assemblies := reflection_interface.assemblies
							sort_assemblies
						elseif returned_value = dictionary.Ignore_result then
							reflection_interface.cleanassemblies
							imported_assemblies := reflection_interface.assemblies
							sort_assemblies
						else
							close
						end
					end
				else					
					if reflection_interface.lasterror /= Void and then reflection_interface.lasterror.description /= Void and then reflection_interface.lasterror.description.length > 0 then
						returned_value := message_box.show_string_string_messageboxbuttons_messageboxicon (reflection_interface.lasterror.description, dictionary.Error_caption, dictionary.Ok_message_box_button, dictionary.Error_icon)
					end
				end
			end
		ensure then
			non_void_imported_assemblies: imported_assemblies /= Void
		rescue
			retried := True
			retry
		end
		
	sort_assemblies is
		indexing
			description: "Sort assemblies by assembly name."
			external_name: "SortAssemblies"
		local
			sort_support: SORTING_SUPPORT
		do
			check
				non_void_imported_assemblies: imported_assemblies /= Void
			end
			create sort_support
			sort_support.sort_eiffel_assemblies (imported_assemblies)
			imported_assemblies := sort_support.sorted_list
		end
		
	display_assemblies is
		indexing
			description: "Display assemblies."
			external_name: "DisplayAssemblies"
		local
			row_count: INTEGER
			i: INTEGER
			an_assembly: ISE_REFLECTION_EIFFELASSEMBLY
		do
			check
				non_void_imported_assemblies: imported_assemblies /= Void
			end
			from
				row_count := 0
				i := 0
			until
				i = imported_assemblies.Count
			loop
				an_assembly ?= imported_assemblies.Item (i)
				if an_assembly /= Void then
					build_row (an_assembly.assemblydescriptor, row_count, an_assembly.EiffelClusterPath)
					row_count := row_count + 1
				end
				i := i + 1
			end
			--fill_data_grid
		end

	build_row (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR; row_count: INTEGER; an_eiffel_path: STRING) is 
		indexing
			description: "Build a row at index `row_count' and fill row with information from `a_descriptor' and `an_eiffel_path'."
			external_name: "BuildRow"
		require
			non_void_assembly_descriptor: a_descriptor /= Void
			positive_row_count: row_count >= 0
			non_void_eiffel_path: an_eiffel_path /= Void
		local
			row: SYSTEM_DATA_DATAROW
			columns: SYSTEM_DATA_DATACOLUMNCOLLECTION
		do
			row := new_row (a_descriptor, row_count)
			columns := data_table.columns			
			if columns.contains (dictionary.Eiffel_path_column_title) then
				row.set_Item_String (dictionary.Eiffel_path_column_title, an_eiffel_path)
			end
		end

	build_empty_row (row_count: INTEGER) is 
		indexing
			description: "Build an empty row at index `row_count'."
			external_name: "BuildEmptyRow"
		local
			row: SYSTEM_DATA_DATAROW
			columns: SYSTEM_DATA_DATACOLUMNCOLLECTION
		do
			row := empty_row (row_count)
			columns := data_table.columns
			if columns.contains (dictionary.Eiffel_path_column_title) then
				row.set_Item_String (dictionary.Eiffel_path_column_title, dictionary.Empty_string)
			end
		end	

	set_default_column_width is
		indexing
			description: "Set default column width according to the content."
			external_name: "SetDefaultColumnWidth"
		local
			resizing_support: RESIZING_SUPPORT
		do
			create resizing_support.make (data_grid_font, dictionary.Window_width)
			assembly_name_column_style.set_width (resizing_support.assembly_name_column_width_from_assemblies (imported_assemblies))
			assembly_version_column_style.set_width (resizing_support.assembly_version_column_width_from_assemblies (imported_assemblies))
			assembly_culture_column_style.set_width (resizing_support.assembly_culture_column_width_from_assemblies (imported_assemblies))
			assembly_public_key_column_style.set_width (resizing_support.assembly_public_key_column_width_from_assemblies (imported_assemblies))
			dependancies_column_style.set_width (resizing_support.dependancies_column_width_from_assemblies (imported_assemblies))
			eiffel_path_column_style.set_width (resizing_support.eiffel_path_column_width (imported_assemblies))	
		end
		
	set_read_only is
		indexing
			description: "Set read-only property to each column of the data grid."
			external_name: "SetReadOnly"
		do
			set_read_only_assembly_viewer
			eiffel_path_column_style.set_readonly (True)	
		end
		
	resize_columns is
		indexing
			description: "Resize columns."
			external_name: "ResizeColumns"
		local
			total_width: INTEGER
			current_width: INTEGER
		do
			set_default_column_width
			if name_menu_item.checked then
				total_width := assembly_name_column_style.width
			end
			if version_menu_item.checked then
				total_width := total_width + assembly_version_column_style.width
			end	
			if culture_menu_item.checked then
				total_width := total_width + assembly_culture_column_style.width
			end	
			if public_key_menu_item.checked then
				total_width := total_width + assembly_public_key_column_style.width
			end
			if dependancies_menu_item.checked then
				total_width := total_width + dependancies_column_style.width
			end	
			if path_menu_item.checked then
				total_width := total_width + eiffel_path_column_style.width
			end
			if (width > dictionary.Window_width and total_width < width) or (width <= dictionary.Window_width and total_width < width - dictionary.Scrollbar_width) then
				if path_menu_item.checked then
					current_width := eiffel_path_column_style.width
					eiffel_path_column_style.set_width (current_width + width - total_width - dictionary.Scrollbar_width)
				elseif	dependancies_menu_item.checked then
					current_width := dependancies_column_style.width
					dependancies_column_style.set_width (current_width + width - total_width - dictionary.Scrollbar_width)		
				elseif	public_key_menu_item.checked then
					current_width := assembly_public_key_column_style.width
					assembly_public_key_column_style.set_width (current_width + width - total_width - dictionary.Scrollbar_width)		
				elseif	culture_menu_item.checked then
					current_width := assembly_culture_column_style.width
					assembly_culture_column_style.set_width (current_width + width - total_width - dictionary.Scrollbar_width)		
				elseif	version_menu_item.checked then
					current_width := assembly_version_column_style.width
					assembly_version_column_style.set_width (current_width + width - total_width - dictionary.Scrollbar_width)		
				elseif	name_menu_item.checked then
					assembly_name_column_style.set_width (width - dictionary.Scrollbar_width)		
				end
			end
		end

	current_assembly (row_number: INTEGER): ISE_REFLECTION_ASSEMBLYDESCRIPTOR is
		indexing
			description: "Assembly descriptor corresponding to row at index `row_number'. Set `eiffel_path' with information at `row_number'."
			external_name: "CurrentAssembly"
		local
			columns: SYSTEM_DATA_DATACOLUMNCOLLECTION
			rows: SYSTEM_DATA_DATAROWCOLLECTION
			a_row: SYSTEM_DATA_DATAROW
			a_name: STRING
			a_version: STRING
			a_culture: STRING
			a_public_key: STRING
			retried: BOOLEAN		
		do
			if not retried then
				data_table ?= data_grid.datasource
				if data_table /= Void then
					controls.remove (data_grid)
					build_assemblies_table
					columns := data_table.columns
					columns.clear
					data_table.columns.add_datacolumn (assembly_name_column)
					data_table.columns.add_datacolumn (assembly_version_column)
					data_table.columns.add_datacolumn (assembly_culture_column)
					data_table.columns.add_datacolumn (assembly_public_key_column)
					data_table.columns.add_datacolumn (dependancies_column)
					data_table.columns.add_datacolumn (eiffel_path_column)
					display_assemblies
					controls.add (data_grid)
					rows := data_table.rows
					
					controls.remove (data_grid)
					a_row := rows.item (row_number)
					a_name ?= a_row.item (assembly_name_column)
					a_version ?= a_row.item (assembly_version_column)
					a_culture ?= a_row.item (assembly_culture_column)
					a_public_key ?= a_row.item (assembly_public_key_column)
					if a_name /= Void and a_version /= Void and a_culture /= Void and a_public_key /= Void then
						create Result.make1
						Result.make (a_name, a_version, a_culture, a_public_key)
					end
					eiffel_path ?= a_row.item (eiffel_path_column)
					
					build_assemblies_table
					columns := data_table.columns
					columns.clear
					if name_menu_item.checked then
						data_table.columns.add_datacolumn (assembly_name_column)
					end
					if version_menu_item.checked then
						data_table.columns.add_datacolumn (assembly_version_column)
					end
					if culture_menu_item.checked then
						data_table.columns.add_datacolumn (assembly_culture_column)
					end
					if public_key_menu_item.checked then
						data_table.columns.add_datacolumn (assembly_public_key_column)
					end
					if dependancies_menu_item.checked then
						data_table.columns.add_datacolumn (dependancies_column)
					end
					if path_menu_item.checked then
						data_table.columns.add_datacolumn (eiffel_path_column)
					end
					display_assemblies
					resize_columns
					fill_data_grid
					controls.add (data_grid)
					refresh
				end
			else
				Result := Void
			end
		end
	
	eiffel_path: STRING 
		indexing
			description: "Path to Eiffel sources. Result of `current_assembly'."
			external_name: "EiffelPath"
		end
		
	update_gui is
		indexing
			description: "Update GUI."
			external_name: "UpdateGui"
		local
			columns: SYSTEM_DATA_DATACOLUMNCOLLECTION
		do
			update_gui_assembly_viewer
			columns := data_table.columns
			if path_menu_item.checked then
				columns.add_datacolumn (eiffel_path_column)	
			end
			display_assemblies
			resize_columns
			fill_data_grid
			controls.add (data_grid)
			refresh		
		end

	current_history: ISE_REFLECTION_HISTORY is
		indexing
			description: "Current history"
			external_name: "CurrentHistory"
		once
			create Result.make1
		end
		
end -- class IMPORTED_ASSEMBLY_VIEWER