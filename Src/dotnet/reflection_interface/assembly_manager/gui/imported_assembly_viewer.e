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

	non_editable_assemblies: LINKED_LIST [STRING] is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [STRING]
		indexing
			description: "Non editable assemblies"
			external_name: "NonEditableAssemblies"
		once
			create Result.make
			Result.extend (dictionary.Mscorlib_assembly_name)
		ensure
			list_created: Result /= Void
			valid_list: Result.count = 1
		end
		
	dictionary: IMPORTED_ASSEMBLY_VIEWER_DICTIONARY is
		indexing
			description: "Dictionary"
			external_name: "Dictionary"
		once
			create Result
		end

	path_menu_item: WINFORMS_MENU_ITEM
		indexing
			description: "Eiffel path menu item"
			external_name: "PathMenuItem"
		end

	show_name_and_path_menu_item: WINFORMS_MENU_ITEM
		indexing
			description: "`Show name and path' menu item"
			external_name: "ShowNameAndPathMenuItem"
		end
		
	edit_menu_item: WINFORMS_MENU_ITEM
		indexing
			description: "Edit menu item"
			external_name: "EditMenuItem"
		end
		
	remove_menu_item: WINFORMS_MENU_ITEM
		indexing
			description: "Remove menu item"
			external_name: "RemoveMenuItem"
		end	

	eiffel_generation_menu_item: WINFORMS_MENU_ITEM
		indexing
			description: "Eiffel generation menu item"
			external_name: "EiffelGenerationMenuItem"
		end
		
	path_toolbar_button: WINFORMS_TOOL_BAR_BUTTON
		indexing
			description: "Eiffel path toolbar button"
			external_name: "PathToolbarButton"
		end

	edit_toolbar_button: WINFORMS_TOOL_BAR_BUTTON
		indexing
			description: "Edit toolbar button"
			external_name: "EditToolbarButton"
		end
		
	remove_toolbar_button: WINFORMS_TOOL_BAR_BUTTON
		indexing
			description: "Remove toolbar button"
			external_name: "RemoveToolbarButton"
		end	

	eiffel_generation_toolbar_button: WINFORMS_TOOL_BAR_BUTTON
		indexing
			description: "Eiffel generation toolbar button"
			external_name: "EiffelGenerationToolbarButton"
		end

	eiffel_path_column_style: WINFORMS_DATA_GRID_TEXT_BOX_COLUMN	
		indexing
			description: "Eiffel path column style"
			external_name: "EiffelPathColumnStyle"
		end

	eiffel_path_column: DATA_DATA_COLUMN
		indexing
			description: "Column with path to Eiffel sources for imported assemblies"
			external_name: "EiffelPathColumn"
		end

feature -- Status Report
	
	is_non_editable_assembly (a_descriptor: ASSEMBLY_DESCRIPTOR): BOOLEAN is
		indexing
			description: "Is assembly corresponding to `a_descriptor' a non-editable assembly?"
			external_name: "IsNonRemovableAssembly"
		require
			non_void_descriptor: a_descriptor /= Void
		local
			name: STRING
		do
			name := a_descriptor.name.clone (a_descriptor.name)
			name.to_lower
			Result := non_editable_assemblies.has (name)		
		end
		
feature -- Basic Operations

	register_to_subject is
		indexing
			description: "Register assembly viewer to `ISE.ReflectionInterface.Notifier'."
			external_name: "RegisterToSubject"
		local
			type: TYPE
			notifier_handle: NOTIFIER_HANDLE
			notifier: NOTIFIER
			--on_update_add_delegate: EVENT_HANDLER
			--on_update_remove_delegate: EVENT_HANDLER
			--on_update_replace_delegate: EVENT_HANDLER
		do
			notifier_handle := create {NOTIFIER_HANDLE}.make
			notifier := notifier_handle.current_notifier
			--create on_update_add_delegate.make_eventhandler (Current, $update_add)		
			--notifier.add_addition_observer (on_update_add_delegate)
			--create on_update_remove_delegate.make_eventhandler (Current, $update_remove)		
			--notifier.add_remove_observer (on_update_remove_delegate)
			--create on_update_replace_delegate.make_eventhandler (Current, $update_replace)
			--notifier.add_replace_observer (on_update_replace_delegate)
			notifier.add_replace_observer (agent update_add)
			notifier.add_replace_observer (agent update_remove)
			notifier.add_replace_observer (agent update_replace)
		end
		
	build_menu is
		indexing
			description: "Build ISE assembly manager menu."
			external_name: "BuildMenu"
		local
			added: INTEGER
			separator: WINFORMS_MENU_ITEM
			shortcut: WINFORMS_SHORTCUT
		do					
			--Precursor {ASSEMBLY_VIEWER}
			build_menu_assembly_viewer
			added := file_menu_item.get_menu_items.add_menu_item (exit_menu_item)
			
				-- Build View menu item.
			create path_menu_item.make_winforms_menu_item_1 (dictionary.Path_menu_item.to_cil)			
			create show_name_and_path_menu_item.make_winforms_menu_item_1 (dictionary.Show_name_and_path_menu_item.to_cil)
			path_menu_item.set_shortcut (shortcut.Ctrl_P)
			show_name_and_path_menu_item.set_shortcut (shortcut.Ctrl_W)			
			path_menu_item.set_checked (True)
			added := view_menu_item.get_menu_items.add_menu_item (path_menu_item)	
			separator := view_menu_item.get_menu_items.add (("-").to_cil)
			added := view_menu_item.get_menu_items.add_menu_item (show_all_menu_item)	
			added := view_menu_item.get_menu_items.add_menu_item (show_name_and_path_menu_item)	
			
				-- Build Tools menu item.
			create edit_menu_item.make_winforms_menu_item_1 (dictionary.Edit_menu_item.to_cil)
			create remove_menu_item.make_winforms_menu_item_1 (dictionary.Remove_menu_item.to_cil)
			create import_menu_item.make_winforms_menu_item_1 (dictionary.Import_menu_item.to_cil)
			create eiffel_generation_menu_item.make_winforms_menu_item_1 (dictionary.Eiffel_generation_menu_item.to_cil)
			edit_menu_item.set_shortcut (shortcut.Ctrl_E)
			remove_menu_item.set_shortcut (shortcut.Ctrl_M)
			import_menu_item.set_shortcut (shortcut.Ctrl_I)
			eiffel_generation_menu_item.set_shortcut (shortcut.Ctrl_G)
			added := tools_menu_item.get_menu_items.add_menu_item (edit_menu_item)
			added := tools_menu_item.get_menu_items.add_menu_item (remove_menu_item)
			separator := tools_menu_item.get_menu_items.add (("-").to_cil)
			added := tools_menu_item.get_menu_items.add_menu_item (eiffel_generation_menu_item)
			separator := tools_menu_item.get_menu_items.add (("-").to_cil)
			added := tools_menu_item.get_menu_items.add_menu_item (import_menu_item)
		end
	
	set_menu_actions is
		indexing
			description: "Set actions to `main_menu'."
			external_name: "SetMenuActions"
		local
			path_delegate: EVENT_HANDLER
			show_name_and_path_delegate: EVENT_HANDLER
			edit_delegate: EVENT_HANDLER
			remove_delegate: EVENT_HANDLER
			eiffel_generation_delegate: EVENT_HANDLER
			import_delegate: EVENT_HANDLER		
		do
			--Precursor {ASSEMBLY_VIEWER}
			set_menu_actions_assembly_viewer
				-- View menu	
			create path_delegate.make_event_handler (Current, $display_path)
			create show_name_and_path_delegate.make_event_handler (Current, $show_name_and_path)
			path_menu_item.add_click (path_delegate)
			show_name_and_path_menu_item.add_click (show_name_and_path_delegate)
			
				-- Tools menu
			create edit_delegate.make_event_handler (Current, $edit)
			create remove_delegate.make_event_handler (Current, $remove)
			create import_delegate.make_event_handler (Current, $import)
			create eiffel_generation_delegate.make_event_handler (Current, $eiffel_generation)
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
			separator:WINFORMS_TOOL_BAR_BUTTON
			toolbar_button_click_delegate: WINFORMS_TOOL_BAR_BUTTON_CLICK_EVENT_HANDLER
			appearance: WINFORMS_TOOL_BAR_BUTTON_STYLE
			retried: BOOLEAN
		do
			--Precursor {ASSEMBLY_VIEWER}
			build_toolbar_assembly_viewer
			create path_toolbar_button.make_winforms_tool_bar_button
			create edit_toolbar_button.make_winforms_tool_bar_button
			create remove_toolbar_button.make_winforms_tool_bar_button
			create import_toolbar_button.make_winforms_tool_bar_button
			create eiffel_generation_toolbar_button.make_winforms_tool_bar_button
			create separator.make_winforms_tool_bar_button
			
				-- Set icons to toolbar buttons.
			if not retried then
				path_toolbar_button.set_image_index (7)
				edit_toolbar_button.set_image_index (8)
				remove_toolbar_button.set_image_index (9)
				eiffel_generation_toolbar_button.set_image_index (10)
				import_toolbar_button.set_image_index (11)
			end
			
				-- Set tooltips.
			path_toolbar_button.set_tool_tip_text (dictionary.Path_menu_item.to_cil)
			edit_toolbar_button.set_tool_tip_text (dictionary.Edit_menu_item.to_cil)
			remove_toolbar_button.set_tool_tip_text (dictionary.Remove_menu_item.to_cil)
			eiffel_generation_toolbar_button.set_tool_tip_text (dictionary.Eiffel_generation_menu_item.to_cil)
			import_toolbar_button.set_tool_tip_text (dictionary.Import_menu_item.to_cil)
			
				-- Set button style.
			path_toolbar_button.set_style (appearance.Toggle_button)
			edit_toolbar_button.set_style (appearance.Push_button)
			remove_toolbar_button.set_style (appearance.Push_button)
			eiffel_generation_toolbar_button.set_style (appearance.Push_button)
			import_toolbar_button.set_style (appearance.Push_button)
			separator.set_style (appearance.Separator)
			
				-- Set visible
			path_toolbar_button.set_pushed (True)
			
				-- Add buttons to `toolbar'.
			added := toolbar.get_buttons.add_tool_bar_button (path_toolbar_button)
			added := toolbar.get_buttons.add_tool_bar_button (separator)
			added := toolbar.get_buttons.add_tool_bar_button (dependancy_viewer_toolbar_button)
			added := toolbar.get_buttons.add_tool_bar_button (separator)
			added := toolbar.get_buttons.add_tool_bar_button (edit_toolbar_button)
			added := toolbar.get_buttons.add_tool_bar_button (remove_toolbar_button)
			added := toolbar.get_buttons.add_tool_bar_button (separator)
			added := toolbar.get_buttons.add_tool_bar_button (eiffel_generation_toolbar_button)
			added := toolbar.get_buttons.add_tool_bar_button (separator)
			added := toolbar.get_buttons.add_tool_bar_button (import_toolbar_button)
			added := toolbar.get_buttons.add_tool_bar_button (separator)
			added := toolbar.get_buttons.add_tool_bar_button (help_toolbar_button)
			main_win.get_controls.add (toolbar)
		rescue
			retried := True
			retry
		end

	build_image_list is
		indexing
			description: "Build toolbar image list."
			external_name: "Buildimage_list"
		local
			path_image: DRAWING_IMAGE
			edit_image: DRAWING_IMAGE
			remove_image: DRAWING_IMAGE
			eiffel_generation_image: DRAWING_IMAGE
			import_image: DRAWING_IMAGE
			image_list: WINFORMS_IMAGE_LIST
			images: WINFORMS_IMAGE_COLLECTION_IN_WINFORMS_IMAGE_LIST
			retried: BOOLEAN
			returned_value: WINFORMS_DIALOG_RESULT
			message_box_buttons: WINFORMS_MESSAGE_BOX_BUTTONS
			message_box_icon: WINFORMS_MESSAGE_BOX_ICON 
			windows_message_box:WINFORMS_MESSAGE_BOX	
			file: PLAIN_TEXT_FILE
		do
			if not retried then
				--Precursor {ASSEMBLY_VIEWER}
				build_image_list_assembly_viewer
					-- Create icons
				
				create file.make (dictionary.Path_icon_filename) 
				if file.exists then
					path_image := image_factory.from_file (dictionary.Path_icon_filename.to_cil)
				else
					returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Path_icon_not_found_error.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)		
				end
				file.reset (dictionary.Edit_icon_filename) 
				if file.exists  then
					edit_image := image_factory.from_file (dictionary.Edit_icon_filename.to_cil)
				else
					returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Edit_icon_not_found_error.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
				end
				file.reset (dictionary.Remove_icon_filename) 
				if file.exists then
					remove_image := image_factory.from_file (dictionary.Remove_icon_filename.to_cil)
				else
					returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Remove_icon_not_found_error.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
				end
				file.reset (dictionary.Path_icon_filename) 
				if file.exists then
					eiffel_generation_image := image_factory.from_file (dictionary.Eiffel_generation_icon_filename.to_cil)
				else
					returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Eiffel_generation_icon_not_found_error.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
				end
				file.reset (dictionary.Import_icon_filename) 
				if file.exists  then
					import_image := image_factory.from_file (dictionary.Import_icon_filename.to_cil)
				else
					returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Import_icon_not_found_error.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
				end

					-- Add icons to `image_list'.
				image_list := toolbar.get_image_list
				images := image_list.get_images
				images.add (path_image)
				images.add (edit_image)
				images.add (remove_image)
				images.add (eiffel_generation_image)
				images.add (import_image)
			else
				returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Toolbar_icon_not_found_error.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
			end
		rescue
			retried := True
			retry
		end

	build_data_table is
		indexing
			description: "Build `data_table'."
			external_name: "BuildDataTable"
		local
			type: TYPE
		do
			--Precursor {ASSEMBLY_VIEWER}
			build_data_table_assembly_viewer
			type := type_factory.Get_Type_String (dictionary.System_string_type.to_cil)		
			create eiffel_path_column.make_data_data_column_2 (dictionary.Eiffel_path_column_title.to_cil, type)			
			data_table.get_Columns.Add_Data_Column (eiffel_path_column)
		end

	build_data_grid is
		indexing
			description: "Build `data_grid' and associate actions."
			external_name: "BuildDataGrid"
		local
			added: INTEGER
			on_row_delegate:EVENT_HANDLER
		do
			--Precursor {ASSEMBLY_VIEWER}
			build_data_grid_assembly_viewer
			data_grid.set_caption_text (dictionary.Caption_text.to_cil)
			create eiffel_path_column_style.make_winforms_data_grid_text_box_column
			eiffel_path_column_style.set_mapping_name (dictionary.Eiffel_path_column_title.to_cil)
			eiffel_path_column_style.set_header_text (dictionary.Eiffel_path_column_title.to_cil)
			added := data_grid_table_style.get_grid_column_styles.add (eiffel_path_column_style)	
			set_read_only
			if imported_assemblies /= Void and then imported_assemblies.count > 0 then
				resize_columns
			end
			--create on_row_delegate.make_eventhandler (Current, $on_row)
			--data_grid.add_enter (on_row_delegate)
		end
		
		refresh_assemblies_list is
				-- 
			do
				main_win.get_controls.remove (data_grid)
				build_assemblies
				display_assemblies
			end
			
		
feature -- Event handling
	
	update_replace (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Display assembly name column if checked."
			external_name: "UpdateReplaceName"
		require
			non_void_sender: sender /= Void
		do
			current_history.types_table.clear_all
		ensure
			empty_types_table: current_history.types_table.count = 0
		end
			
	display_name (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Display assembly name column if checked."
			external_name: "DisplayName"
		local
			checked: BOOLEAN
			columns: DATA_DATA_COLUMN_COLLECTION
		do
			columns := data_table.get_columns
			checked := name_menu_item.get_checked
			if columns.get_count > 1 or not checked then	
				if checked and then columns.contains (dictionary.Assembly_name_column_title.to_cil) then
					columns.remove_data_column (assembly_name_column)
					name_menu_item.set_checked (not checked)
					name_toolbar_button.set_pushed (not checked)
					resize_columns
					main_win.refresh
				elseif not checked then
					main_win.get_controls.remove (data_grid)
					build_assemblies_table
					columns := data_table.get_columns
					columns.clear
					columns.add_data_column (assembly_name_column)
					if version_menu_item.get_checked then
						columns.add_data_column (assembly_version_column)
					end
					if culture_menu_item.get_checked then
						columns.add_data_column (assembly_culture_column)
					end
					if public_key_menu_item.get_checked then
						columns.add_data_column (assembly_public_key_column)
					end
					if dependancies_menu_item.get_checked then
						columns.add_data_column (dependancies_column)
					end
					if path_menu_item.get_checked then
						columns.add_data_column (eiffel_path_column)
					end	
					display_assemblies
					name_menu_item.set_checked (not checked)
					name_toolbar_button.set_pushed (not checked)
					resize_columns
					fill_data_grid
					main_win.get_controls.add (data_grid)
					main_win.refresh
				end
			end
		end

	display_version (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Display assembly version column if checked."
			external_name: "DisplayVersion"
		local
			checked: BOOLEAN
			columns: DATA_DATA_COLUMN_COLLECTION
		do
			columns := data_table.get_columns
			checked := version_menu_item.get_checked
			if columns.get_count > 1 or not checked then		
				if checked and then columns.contains (dictionary.Assembly_version_column_title.to_cil) then
					columns.remove_data_column (assembly_version_column)
					version_menu_item.set_checked (not checked)
					version_toolbar_button.set_pushed (not checked)
					resize_columns
					main_win.refresh
				elseif not checked then
					main_win.get_controls.remove (data_grid)
					build_assemblies_table
					columns := data_table.get_columns
					columns.clear
					if name_menu_item.get_checked then
						columns.add_data_column (assembly_name_column)
					end
					columns.add_data_column (assembly_version_column)
					if culture_menu_item.get_checked then
						columns.add_data_column (assembly_culture_column)
					end
					if public_key_menu_item.get_checked then
						columns.add_data_column (assembly_public_key_column)
					end
					if dependancies_menu_item.get_checked then
						columns.add_data_column (dependancies_column)
					end
					if path_menu_item.get_checked then
						columns.add_data_column (eiffel_path_column)
					end	
					display_assemblies
					version_menu_item.set_checked (not checked)
					version_toolbar_button.set_pushed (not checked)
					resize_columns
					fill_data_grid
					main_win.get_controls.add (data_grid)
					main_win.refresh		
				end
			end
		end

	display_culture (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Display assembly culture column if checked."
			external_name: "DisplayCulture"
		local
			checked: BOOLEAN
			columns: DATA_DATA_COLUMN_COLLECTION
		do
			columns := data_table.get_columns
			checked := culture_menu_item.get_checked
			if columns.get_count > 1 or not checked then				
				if checked and then columns.contains (dictionary.Assembly_culture_column_title.to_cil) then
					columns.remove_data_column (assembly_culture_column)
					culture_menu_item.set_checked (not checked)
					culture_toolbar_button.set_pushed (not checked)
					resize_columns
					main_win.refresh
				elseif not checked then
					main_win.get_controls.remove (data_grid)
					build_assemblies_table
					columns := data_table.get_columns
					columns.clear
					if name_menu_item.get_checked then
						columns.add_data_column (assembly_name_column)
					end
					if version_menu_item.get_checked then
						columns.add_data_column (assembly_version_column)
					end
					columns.add_data_column (assembly_culture_column)
					if public_key_menu_item.get_checked then
						columns.add_data_column (assembly_public_key_column)
					end
					if dependancies_menu_item.get_checked then
						columns.add_data_column (dependancies_column)
					end
					if path_menu_item.get_checked then
						columns.add_data_column (eiffel_path_column)
					end		
					display_assemblies
					culture_menu_item.set_checked (not checked)
					culture_toolbar_button.set_pushed (not checked)
					resize_columns
					fill_data_grid
					main_win.get_controls.add (data_grid)
					main_win.refresh		
				end
			end
		end

	display_public_key (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Display assembly public key column if checked."
			external_name: "DisplayPublicKey"
		local
			checked: BOOLEAN
			columns: DATA_DATA_COLUMN_COLLECTION
		do
			columns := data_table.get_columns
			checked := public_key_menu_item.get_checked
			if columns.get_count > 1 or not checked then						
				if checked and then columns.contains (dictionary.Assembly_public_key_column_title.to_cil) then
					columns.remove_data_column (assembly_public_key_column)
					public_key_menu_item.set_checked (not checked)
					public_key_toolbar_button.set_pushed (not checked)	
					resize_columns
					main_win.refresh
				elseif not checked then
					main_win.get_controls.remove (data_grid)
					build_assemblies_table
					columns := data_table.get_columns
					columns.clear
					if name_menu_item.get_checked then
						columns.add_data_column (assembly_name_column)
					end
					if version_menu_item.get_checked then
						columns.add_data_column (assembly_version_column)
					end
					if culture_menu_item.get_checked then
						columns.add_data_column (assembly_culture_column)
					end
					columns.add_data_column (assembly_public_key_column)
					if dependancies_menu_item.get_checked then
						columns.add_data_column (dependancies_column)
					end
					if path_menu_item.get_checked then
						columns.add_data_column (eiffel_path_column)
					end	
					display_assemblies
					public_key_menu_item.set_checked (not checked)
					public_key_toolbar_button.set_pushed (not checked)	
					resize_columns
					fill_data_grid
					main_win.get_controls.add (data_grid)
					main_win.refresh		
				end
			end
		end

	display_dependancies (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Display dependancies column if checked."
			external_name: "DisplayDependancies"
		local
			checked: BOOLEAN
			columns: DATA_DATA_COLUMN_COLLECTION
		do
			columns := data_table.get_columns
			checked := dependancies_menu_item.get_checked
			if columns.get_count > 1 or not checked then						
				if checked and then columns.contains (dictionary.Dependancies_column_title.to_cil) then
					columns.remove_data_column (dependancies_column)
					dependancies_menu_item.set_checked (not checked)
					dependancies_toolbar_button.set_pushed (not checked)	
					resize_columns
					main_win.refresh
				elseif not checked then
					main_win.get_controls.remove (data_grid)
					build_assemblies_table
					columns := data_table.get_columns
					columns.clear
					if name_menu_item.get_checked then
						columns.add_data_column (assembly_name_column)
					end
					if version_menu_item.get_checked then
						columns.add_data_column (assembly_version_column)
					end
					if culture_menu_item.get_checked then
						columns.add_data_column (assembly_culture_column)
					end
					if public_key_menu_item.get_checked then
						columns.add_data_column (assembly_public_key_column)
					end				
					columns.add_data_column (dependancies_column)
					if path_menu_item.get_checked then
						columns.add_data_column (eiffel_path_column)
					end					
					dependancies_menu_item.set_checked (not checked)
					dependancies_toolbar_button.set_pushed (not checked)
					display_assemblies
					resize_columns
					fill_data_grid
					main_win.get_controls.add (data_grid)
					main_win.refresh		
				end
			end
		end

	display_path (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Display path to Eiffel sources if checked."
			external_name: "DisplayPath"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			checked: BOOLEAN
			columns: DATA_DATA_COLUMN_COLLECTION
		do
			columns := data_table.get_columns
			checked := path_menu_item.get_checked
			if columns.get_count > 1 or not checked then						
				if checked and then columns.contains (dictionary.Eiffel_path_column_title.to_cil) then
					columns.remove_data_column (eiffel_path_column)
					path_menu_item.set_checked (not checked)
					path_toolbar_button.set_pushed (not checked)	
					resize_columns
					main_win.refresh
				elseif not checked then
					main_win.get_controls.remove (data_grid)
					build_assemblies_table
					columns := data_table.get_columns
					columns.clear
					if name_menu_item.get_checked then
						columns.add_data_column (assembly_name_column)
					end
					if version_menu_item.get_checked then
						columns.add_data_column (assembly_version_column)
					end
					if culture_menu_item.get_checked then
						columns.add_data_column (assembly_culture_column)
					end
					if public_key_menu_item.get_checked then
						columns.add_data_column (assembly_public_key_column)
					end		
					if dependancies_menu_item.get_checked then
						columns.add_data_column (dependancies_column)
					end					
					columns.add_data_column (eiffel_path_column)
					display_assemblies
					path_menu_item.set_checked (not checked)
					path_toolbar_button.set_pushed (not checked)	
					resize_columns
					fill_data_grid
					main_win.get_controls.add (data_grid)
					main_win.refresh	
				end
			end
		end

	show_all (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Show all columns."
			external_name: "ShowAll"
		local
			columns: DATA_DATA_COLUMN_COLLECTION
		do
			show_all_assembly_viewer (sender, arguments)
			path_menu_item.set_checked (True)
			path_toolbar_button.set_pushed (True)
			columns := data_table.get_columns
			columns.add_data_column (eiffel_path_column)
			display_assemblies
			set_default_column_width
			fill_data_grid
			main_win.get_controls.add (data_grid)
			main_win.refresh
		ensure then
			all_columns_displayed: data_table.get_columns.get_count = 6
		end

	show_name_and_path (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Show assembly name column and eiffel path column only."
			external_name: "ShowNameAndPath"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			columns: DATA_DATA_COLUMN_COLLECTION
		do
			show_name_assembly_viewer (sender, arguments)
			path_menu_item.set_checked (True)
			path_toolbar_button.set_pushed (True)
			columns := data_table.get_columns
			columns.add_data_column (eiffel_path_column)	
			display_assemblies
			resize_columns
			fill_data_grid
			main_win.get_controls.add (data_grid)
			main_win.refresh
		ensure
			name_and_path_columns_displayed: data_table.get_columns.get_count = 2
		end
		
	edit (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Edit currently selected assembly (available only if assembly has been imported)."
			external_name: "Edit"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			selected_row: INTEGER
			an_assembly: EIFFEL_ASSEMBLY
			assembly_view: ASSEMBLY_VIEW
			current_descriptor: ASSEMBLY_DESCRIPTOR
			windows_message_box: WINFORMS_MESSAGE_BOX
			returned_value: WINFORMS_DIALOG_RESULT
			message_box_icon: WINFORMS_MESSAGE_BOX_ICON
			message_box_buttons: WINFORMS_MESSAGE_BOX_BUTTONS
			retried: BOOLEAN
			cursors: WINFORMS_CURSORS
			wait_cursor: WINFORMS_CURSOR
			normal_cursor: WINFORMS_CURSOR
			error_code: INTEGER
		do
			if not retried then
				intern_edit (False)
			else
				normal_cursor := cursors.get_Arrow
				main_win.set_cursor (normal_cursor)
				if not reflection_interface.last_read_successful then 
					error_code := reflection_interface.last_error.code
					if error_code = reflection_interface.Has_write_lock_code or error_code = reflection_interface.Has_read_lock_code then
						returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Access_violation_error.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Abort_retry_ignore, message_box_icon.Error)
						if returned_value = returned_value.Retry_ then
							intern_edit (False)
						elseif returned_value = returned_value.Ignore then
							intern_edit (True)
						end
					end
				else
					if reflection_interface.last_error /= Void and then reflection_interface.last_error.description /= Void and then reflection_interface.last_error.description.count > 0 then
						returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (reflection_interface.last_error.description.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
					end
				end
			end
		rescue
			retried := True
			retry
		end
		
	remove (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Remove currently selected assembly (available only if assembly has been imported)."
			external_name: "Remove"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			selected_row: INTEGER
			a_descriptor: ASSEMBLY_DESCRIPTOR
			assembly_dependancies: ARRAY [CLI_CELL [ASSEMBLY_NAME]]
			remove_dialog: REMOVE_DIALOG
			support: ASSEMBLY_SUPPORT
			retried: BOOLEAN
		do
			if not retried then
				create support.make
				selected_row := data_grid.get_Current_Row_Index			
				a_descriptor := current_assembly (selected_row)
				if a_descriptor /= Void then
					assembly_dependancies := support.dependancies_from_info (a_descriptor)
					if assembly_dependancies = Void then
						create assembly_dependancies.make (0, 0)
					end
					create remove_dialog.make (a_descriptor, assembly_dependancies)
				end
				update_gui
			end
		rescue 
			retried := True
			retry
		end

	import (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Display import tool."
			external_name: "Import"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			import_tool: IMPORT_TOOL
			cursors: WINFORMS_CURSORS
			wait_cursor: WINFORMS_CURSOR
			normal_cursor: WINFORMS_CURSOR
		do
			wait_cursor := cursors.get_Wait_Cursor
			main_win.set_cursor (wait_cursor)
			create import_tool.make
			normal_cursor := cursors.get_Arrow
			main_win.set_cursor (normal_cursor)
			update_gui
		end

	eiffel_generation (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Display Eiffel generation dialog."
			external_name: "EiffelGeneration"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			selected_row: INTEGER
			a_descriptor: ASSEMBLY_DESCRIPTOR
			eiffel_generation_dialog: EIFFEL_GENERATION_DIALOG
			retried: BOOLEAN
			windows_message_box: WINFORMS_MESSAGE_BOX
			returned_value: WINFORMS_DIALOG_RESULT
			message_box_buttons: WINFORMS_MESSAGE_BOX_BUTTONS
			message_box_icon: WINFORMS_MESSAGE_BOX_ICON
		do
			if not retried then
				selected_row := data_grid.get_Current_Row_Index
				a_descriptor := current_assembly (selected_row)
				if a_descriptor /= Void and eiffel_path /= Void then
					if is_non_editable_assembly (a_descriptor) then
						returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Non_editable_assembly.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
					else
						create eiffel_generation_dialog.make (a_descriptor, eiffel_path)
					end
				end
			end
		rescue
			retried := True
			retry
		end
		
	on_toolbar_button_clicked (sender: SYSTEM_OBJECT; arguments: WINFORMS_TOOL_BAR_BUTTON_CLICK_EVENT_ARGS) is
		indexing
			description: "Identify toolbar button and perform appropriate action."
			external_name: "OnToolBarButtonClicked"
		local
			index: INTEGER
			args: EVENT_ARGS
		do
			index := toolbar.get_buttons.index_of (arguments.get_button) 
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
--			a_descriptor: ASSEMBLYDESCRIPTOR
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
--					non_editable := special_assemblies.non_editable_assemblies.has (a_descriptor)
--					edit_menu_item.set_enabled (not non_editable)
--					edit_toolbar_button.set_enabled (not non_editable)	
--
--					non_removable := special_assemblies.non_removable_assemblies.has (a_descriptor)							
--					remove_menu_item.set_enabled (not non_removable)
--					remove_toolbar_button.set_enabled (not non_removable)
--				end
--			end
--		end
		
	update_remove (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
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
			a_type_list: LINKED_LIST [EIFFEL_CLASS]
			an_assembly: EIFFEL_ASSEMBLY
			assembly_view: ASSEMBLY_VIEW
			current_descriptor: ASSEMBLY_DESCRIPTOR
			windows_message_box: WINFORMS_MESSAGE_BOX
			returned_value: WINFORMS_DIALOG_RESULT
			message_box_buttons: WINFORMS_MESSAGE_BOX_BUTTONS
			message_box_icon: WINFORMS_MESSAGE_BOX_ICON
			retried: BOOLEAN
			cursors: WINFORMS_CURSORS
			wait_cursor: WINFORMS_CURSOR
			normal_cursor: WINFORMS_CURSOR	
			reflection_support: REFLECTION_SUPPORT
		do
			wait_cursor := cursors.get_Wait_Cursor
			main_win.set_cursor (wait_cursor)
			selected_row := data_grid.get_Current_Row_Index
			current_descriptor := current_assembly (selected_row)
			if current_descriptor /= Void then
				if is_non_editable_assembly (current_descriptor) then
					normal_cursor := cursors.get_Arrow
					main_win.set_cursor (normal_cursor)
					returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Non_editable_assembly.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
				else	
					if remove_locks then
						--reflection_support := create {REFLECTION_SUPPORT}.make
						create reflection_support.make
						reflection_support.clean_assembly (current_descriptor)
					end
					an_assembly := reflection_interface.assembly (current_descriptor)
					if an_assembly /= Void then
						a_type_list := an_assembly.types
						if a_type_list /= Void then								
							create assembly_view.make (an_assembly)
							normal_cursor := cursors.get_Arrow
							main_win.set_cursor (normal_cursor)
						end
					else
						normal_cursor := cursors.get_Arrow
						main_win.set_cursor (normal_cursor)
						if reflection_interface.last_error /= Void and then reflection_interface.last_error.description /= Void and then reflection_interface.last_error.description.count > 0 then
							returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (reflection_interface.last_error.description.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
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
			returned_value: WINFORMS_DIALOG_RESULT
			message_box_icon: WINFORMS_MESSAGE_BOX_ICON
			message_box_buttons: WINFORMS_MESSAGE_BOX_BUTTONS
			message_box: WINFORMS_MESSAGE_BOX
			error_code: INTEGER
			reflection_support: REFLECTION_SUPPORT
			diagnostics: PROCESS
			process: PROCESS
			error_name: STRING
			reflection_interface_errors: REFLECTION_INTERFACE_ERROR_MESSAGES
			conversion_support: ASSMEBLY_MANAGER_SUPPORT [EIFFEL_ASSEMBLY]
		do
			if not retried then
				create conversion_support
				imported_assemblies := conversion_support.from_linked_list_any (reflection_interface.assemblies)
				if reflection_interface.last_error /= Void then 
					error_code := reflection_interface.last_error.code
					if error_code = reflection_interface.Has_write_lock_code or error_code = reflection_interface.Has_read_lock_code then
						returned_value := message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Access_violation_error.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Abort_retry_ignore, message_box_icon.Error)
						if returned_value = returned_value.Retry_ then
							imported_assemblies := conversion_support.from_linked_list_any (reflection_interface.assemblies)
							sort_assemblies
						elseif returned_value = returned_value.Ignore then
							--reflection_support := create {REFLECTION_SUPPORT}.make
							create reflection_support.make
							reflection_support.clean_assemblies
							imported_assemblies := conversion_support.from_linked_list_any (reflection_interface.assemblies)
							sort_assemblies
						else
							main_win.close
							process := diagnostics.get_current_process
							if process /= Void then
								process.kill
							end
						end
					else
						error_name := from_reflection_string (reflection_interface.last_error.name)
						--reflection_interface_errors := create {REFLECTION_INTERFACE_ERROR_MESSAGES}.make
						create reflection_interface_errors 
						if error_name /= Void and then error_name.is_equal (from_reflection_string (reflection_interface_errors.Registry_key_not_registered)) then
							returned_value := message_box.show_string_string_message_box_buttons_message_box_icon (reflection_interface_errors.Registry_key_not_registered_message.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
							if returned_value = returned_value.ok then
								process := diagnostics.get_current_process
								if process /= Void then
									process.kill
								end							
							end
						else
							if imported_assemblies = Void or else imported_assemblies.count = 0 then
								returned_value := message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.No_assembly_in_the_EAC.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.OK, message_box_icon.Error)
								if returned_value = returned_value.ok then
									process := diagnostics.get_current_process
									if process /= Void then
										process.kill
									end							
								end
							else
								sort_assemblies
							end
						end
					end
				else
					sort_assemblies
				end
			else					
				if reflection_interface.last_error /= Void then 
					error_code := reflection_interface.last_error.code
					if error_code = reflection_interface.Has_write_lock_code or error_code = reflection_interface.Has_read_lock_code then
						returned_value := message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Access_violation_error.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Abort_retry_ignore, message_box_icon.Error)
						if returned_value = returned_value.Retry_ then
							imported_assemblies := conversion_support.from_linked_list_any (reflection_interface.assemblies)
							sort_assemblies
						elseif returned_value = returned_value.Ignore then
							--reflection_support := create {REFLECTION_SUPPORT}.make
							create reflection_support.make
							reflection_support.clean_assemblies
							reflection_interface.set_last_error (Void)
							imported_assemblies := conversion_support.from_linked_list_any (reflection_interface.assemblies)
							sort_assemblies
						else
							main_win.close
							process := diagnostics.get_current_process
							if process /= Void then
								process.kill
							end
						end
					else
						error_name := from_reflection_string (reflection_interface.last_error.name)
						--reflection_interface_errors := create {REFLECTION_INTERFACE_ERROR_MESSAGES}.make
						create reflection_interface_errors
						if error_name /= Void and then error_name.is_equal (reflection_interface_errors.Registry_key_not_registered) then
							returned_value := message_box.show_string_string_message_box_buttons_message_box_icon (reflection_interface_errors.Registry_key_not_registered_message.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
						else
							if imported_assemblies /= Void and then imported_assemblies.count > 0 then
								sort_assemblies
							else
								main_win.close
								process := diagnostics.get_current_process
								if process /= Void then
									process.kill
								end							
							end
						end
					end
				end
			end
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
			imported_assemblies ?= sort_support.sorted_list
		end
		
	display_assemblies is
		indexing
			description: "Display assemblies."
			external_name: "DisplayAssemblies"
		local
			row_count: INTEGER
			an_assembly: EIFFEL_ASSEMBLY
		do
			if imported_assemblies /= Void and then imported_assemblies.count > 0 then
				from
					row_count := 0
					imported_assemblies.start
				until
					imported_assemblies.after
				loop
					an_assembly ?= imported_assemblies.item
					if an_assembly /= Void then
						build_row (an_assembly.assembly_descriptor, row_count, from_reflection_string(an_assembly.Eiffel_Cluster_Path))
						row_count := row_count + 1
					end
					imported_assemblies.forth
				end
			end
		end

	build_row (a_descriptor: ASSEMBLY_DESCRIPTOR; row_count: INTEGER; an_eiffel_path: STRING) is 
		indexing
			description: "Build a row at index `row_count' and fill row with information from `a_descriptor' and `an_eiffel_path'."
			external_name: "BuildRow"
		require
			non_void_assembly_descriptor: a_descriptor /= Void
			positive_row_count: row_count >= 0
			non_void_eiffel_path: an_eiffel_path /= Void
		local
			row: DATA_DATA_ROW
			columns: DATA_DATA_COLUMN_COLLECTION
		do
			row := new_row (a_descriptor, row_count)
			columns := data_table.get_columns			
			if columns.contains (dictionary.Eiffel_path_column_title.to_cil) then
				row.set_Item_String (dictionary.Eiffel_path_column_title.to_cil, an_eiffel_path.to_cil)
			end
		end

	build_empty_row (row_count: INTEGER) is 
		indexing
			description: "Build an empty row at index `row_count'."
			external_name: "BuildEmptyRow"
		local
			row: DATA_DATA_ROW
			columns: DATA_DATA_COLUMN_COLLECTION
		do
			row := empty_row (row_count)
			columns := data_table.get_columns
			if columns.contains (dictionary.Eiffel_path_column_title.to_cil) then
				row.set_Item_String (dictionary.Eiffel_path_column_title.to_cil, dictionary.Empty_string.to_cil)
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
			eiffel_path_column_style.set_read_only (True)	
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
			if name_menu_item.get_checked then
				total_width := assembly_name_column_style.get_width
			end
			if version_menu_item.get_checked then
				total_width := total_width + assembly_version_column_style.get_width
			end	
			if culture_menu_item.get_checked then
				total_width := total_width + assembly_culture_column_style.get_width
			end	
			if public_key_menu_item.get_checked then
				total_width := total_width + assembly_public_key_column_style.get_width
			end
			if dependancies_menu_item.get_checked then
				total_width := total_width + dependancies_column_style.get_width
			end	
			if path_menu_item.get_checked then
				total_width := total_width + eiffel_path_column_style.get_width
			end
			if (main_win.get_width > dictionary.Window_width and total_width < main_win.get_width) or (main_win.get_width <= dictionary.Window_width and total_width < main_win.get_width - dictionary.Scrollbar_width) then
				if path_menu_item.get_checked then
					current_width := eiffel_path_column_style.get_width
					eiffel_path_column_style.set_width (current_width + main_win.get_width - total_width - dictionary.Scrollbar_width)
				elseif	dependancies_menu_item.get_checked then
					current_width := dependancies_column_style.get_width
					dependancies_column_style.set_width (current_width + main_win.get_width - total_width - dictionary.Scrollbar_width)		
				elseif	public_key_menu_item.get_checked then
					current_width := assembly_public_key_column_style.get_width
					assembly_public_key_column_style.set_width (current_width + main_win.get_width - total_width - dictionary.Scrollbar_width)		
				elseif	culture_menu_item.get_checked then
					current_width := assembly_culture_column_style.get_width
					assembly_culture_column_style.set_width (current_width + main_win.get_width - total_width - dictionary.Scrollbar_width)		
				elseif	version_menu_item.get_checked then
					current_width := assembly_version_column_style.get_width
					assembly_version_column_style.set_width (current_width + main_win.get_width - total_width - dictionary.Scrollbar_width)		
				elseif	name_menu_item.get_checked then
					assembly_name_column_style.set_width (main_win.get_width - dictionary.Scrollbar_width)		
				end
			end
		end

	current_assembly (row_number: INTEGER): ASSEMBLY_DESCRIPTOR is
		indexing
			description: "Assembly descriptor corresponding to row at index `row_number'. Set `eiffel_path' with information at `row_number'."
			external_name: "CurrentAssembly"
		local
			columns: DATA_DATA_COLUMN_COLLECTION
			rows: DATA_DATA_ROW_COLLECTION
			a_row: DATA_DATA_ROW
			a_name: STRING
			a_version: STRING
			a_culture: STRING
			a_public_key: STRING
			name: SYSTEM_STRING
			version: SYSTEM_STRING
			culture: SYSTEM_STRING
			public_key: SYSTEM_STRING
			eiffel_cluster_path: SYSTEM_STRING
			retried: BOOLEAN		
		do
			if not retried then
				data_table ?= data_grid.get_data_source
				if data_table /= Void then
					main_win.get_controls.remove (data_grid)
					build_assemblies_table
					columns := data_table.get_columns
					columns.clear
					data_table.get_columns.add_data_column (assembly_name_column)
					data_table.get_columns.add_data_column (assembly_version_column)
					data_table.get_columns.add_data_column (assembly_culture_column)
					data_table.get_columns.add_data_column (assembly_public_key_column)
					data_table.get_columns.add_data_column (dependancies_column)
					data_table.get_columns.add_data_column (eiffel_path_column)
					display_assemblies
					main_win.get_controls.add (data_grid)
					rows := data_table.get_rows
					
					main_win.get_controls.remove (data_grid)
					a_row ?= rows.get_item (row_number)
					name ?= a_row.get_item (assembly_name_column)
					a_name ?= from_system_string (name)
					version ?= a_row.get_item (assembly_version_column)
					a_version ?= from_system_string (version)
					culture ?= a_row.get_item (assembly_culture_column)
					a_culture ?= from_system_string (culture)
					public_key ?= a_row.get_item (assembly_public_key_column)
					a_public_key ?= from_system_string(public_key)
					if a_name /= Void and a_version /= Void and a_culture /= Void and a_public_key /= Void then
						--Result := create {ASSEMBLY_DESCRIPTOR}.make1
						create Result.make (to_reflection_string (a_name), to_reflection_string (a_version), to_reflection_string (a_culture), to_reflection_string (a_public_key))
					end
					eiffel_cluster_path ?= a_row.get_item (eiffel_path_column)
					if eiffel_cluster_path /= Void then
						create eiffel_path.make_from_cil (eiffel_cluster_path)	
					end
					
					
					build_assemblies_table
					columns := data_table.get_columns
					columns.clear
					if name_menu_item.get_checked then
						data_table.get_columns.add_data_column (assembly_name_column)
					end
					if version_menu_item.get_checked then
						data_table.get_columns.add_data_column (assembly_version_column)
					end
					if culture_menu_item.get_checked then
						data_table.get_columns.add_data_column (assembly_culture_column)
					end
					if public_key_menu_item.get_checked then
						data_table.get_columns.add_data_column (assembly_public_key_column)
					end
					if dependancies_menu_item.get_checked then
						data_table.get_columns.add_data_column (dependancies_column)
					end
					if path_menu_item.get_checked then
						data_table.get_columns.add_data_column (eiffel_path_column)
					end
					display_assemblies
					resize_columns
					fill_data_grid
					main_win.get_controls.add (data_grid)
					main_win.refresh
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
			columns: DATA_DATA_COLUMN_COLLECTION
		do
			update_gui_assembly_viewer
			columns := data_table.get_columns
			if path_menu_item.get_checked then
				columns.add_data_column (eiffel_path_column)	
			end
			display_assemblies
			resize_columns
			fill_data_grid
			main_win.get_controls.add (data_grid)
			main_win.refresh		
		end

	current_history: HISTORY is
		indexing
			description: "Current history"
			external_name: "CurrentHistory"
		once
			Result := create {HISTORY}.make
		end
	
end -- class IMPORTED_ASSEMBLY_VIEWER
