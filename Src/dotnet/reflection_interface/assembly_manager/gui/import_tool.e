indexing
	description: "Assembly viewer (shared assemblies only)"
	external_name: "ISE.AssemblyManager.ImportTool"

class
	IMPORT_TOOL

inherit
	ASSEMBLY_VIEWER
		redefine
			dictionary
		end

create
	make

feature -- Access

	dictionary: IMPORT_TOOL_DICTIONARY is
		indexing
			description: "Dictionary"
			external_name: "Dictionary"
		once
			create Result
		end

	open_menu_item: WINFORMS_MENU_ITEM
		indexing
			description: "Open menu item"
			external_name: "OpenMenuItem"
		end
		
	open_toolbar_button: WINFORMS_TOOL_BAR_BUTTON
		indexing
			description: "Open toolbar button"
			external_name: "OpenToolbarButton"
		end
		
	show_name_menu_item: WINFORMS_MENU_ITEM
		indexing
			description: "Show name menu item"
			external_name: "ShowNameMenuItem"
		end
			
	shared_assemblies: LINKED_LIST [ASSEMBLY_DESCRIPTOR]
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ASSEMBLYDESCRIPTOR]
		indexing
			description: "Assemblies in the global assembly cache"
			external_name: "SharedAssemblies"
		end

feature -- Status Setting

	is_imported (a_descriptor: ASSEMBLY_DESCRIPTOR): BOOLEAN is
		indexing
			description: "Is assembly corresponding to `a_descriptor' already in the Eiffel assembly cache?"
			external_name: "IsImported"
		require
			non_void_descriptor: a_descriptor /= Void 
			non_void_reflection_interface: reflection_interface /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				reflection_interface.search (a_descriptor)
				Result := reflection_interface.found
			else
				Result := False
			end
		rescue
			retried := True
			retry
		end
		
feature -- Basic Operations
		
	build_menu is
		indexing
			description: "Build ISE assembly manager menu."
			external_name: "BuildMenu"
		local
			added: INTEGER
			separator: WINFORMS_MENU_ITEM
			shortcut: WINFORMS_SHORTCUT
		do				
			build_menu_assembly_viewer
				-- Build File menu item.
			create open_menu_item.make_winforms_menu_item_1 (dictionary.Open_menu_item.to_cil)
			open_menu_item.set_shortcut (shortcut.Ctrl_O)
			added := file_menu_item.get_menu_items.add_menu_item (open_menu_item)
			separator := file_menu_item.get_menu_items.add (("-").to_cil)
			added := file_menu_item.get_menu_items.add_menu_item (exit_menu_item)
			
				-- Build View menu item.
			create show_name_menu_item.make_winforms_menu_item_1 (dictionary.Show_name_menu_item.to_cil)
			show_all_menu_item.set_shortcut (shortcut.Ctrl_A)
			show_name_menu_item.set_shortcut (shortcut.Ctrl_W)
			separator := view_menu_item.get_menu_items.add  (("-").to_cil)
			added := view_menu_item.get_menu_items.add_menu_item (show_all_menu_item)	
			added := view_menu_item.get_menu_items.add_menu_item (show_name_menu_item)	
			
				-- Build Tools menu item.
			create import_menu_item.make_winforms_menu_item_1 (dictionary.Import_menu_item.to_cil)
			import_menu_item.set_shortcut (shortcut.Ctrl_I)
			added := tools_menu_item.get_menu_items.add_menu_item (import_menu_item)
		end
	
	set_menu_actions is
		indexing
			description: "Set actions to `main_menu'."
			external_name: "SetMenuActions"
		local
			open_delegate: EVENT_HANDLER
			show_name_delegate: EVENT_HANDLER
			import_delegate: EVENT_HANDLER
		do
			set_menu_actions_assembly_viewer
				-- File menu
			create open_delegate.make_event_handler (Current, $open_assembly)
			open_menu_item.add_click (open_delegate)		
			
				-- View menu	
			create show_name_delegate.make_event_handler (Current, $show_name)
			show_name_menu_item.add_click (show_name_delegate)
			
				-- Tools menu
			create import_delegate.make_event_handler (Current, $import)
			import_menu_item.add_click (import_delegate)
		end

	build_toolbar is
		indexing
			description: "Build ISE assembly manager toolbar."
			external_name: "BuildToolbar"
		local
			added: INTEGER
			separator: WINFORMS_TOOL_BAR_BUTTON
			appearance: WINFORMS_TOOL_BAR_BUTTON_STYLE
			retried: BOOLEAN
		do			
			build_toolbar_assembly_viewer
			
			create open_toolbar_button.make_winforms_tool_bar_button
			create import_toolbar_button.make_winforms_tool_bar_button
			create separator.make_winforms_tool_bar_button
			
			if not retried then
				open_toolbar_button.set_image_index (7)
			end
			open_toolbar_button.set_tool_tip_text (dictionary.Open_menu_item.to_cil)
			open_toolbar_button.set_style (appearance.Push_button)
			
			if not retried then
				import_toolbar_button.set_image_index (8)
			end
			import_toolbar_button.set_tool_tip_text (dictionary.Import_menu_item.to_cil)
			import_toolbar_button.set_style (appearance.Push_button)
			separator.set_style (appearance.Separator)
				
				-- Add buttons to `toolbar'.
			toolbar.get_buttons.clear
			added := toolbar.get_buttons.add_tool_bar_button (open_toolbar_button)
			added := toolbar.get_buttons.add_tool_bar_button (separator)
			added := toolbar.get_buttons.add_tool_bar_button (name_toolbar_button)
			added := toolbar.get_buttons.add_tool_bar_button (version_toolbar_button)
			added := toolbar.get_buttons.add_tool_bar_button (culture_toolbar_button)
			added := toolbar.get_buttons.add_tool_bar_button (public_key_toolbar_button)
			added := toolbar.get_buttons.add_tool_bar_button (dependancies_toolbar_button)
			added := toolbar.get_buttons.add_tool_bar_button (separator)
			added := toolbar.get_buttons.add_tool_bar_button (dependancy_viewer_toolbar_button)
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
			import_image: DRAWING_IMAGE
			open_image: DRAWING_IMAGE
			image_list: WINFORMS_IMAGE_LIST
			images: WINFORMS_IMAGE_COLLECTION_IN_WINFORMS_IMAGE_LIST
			retried: BOOLEAN
			returned_value: WINFORMS_DIALOG_RESULT
			message_box_buttons: WINFORMS_MESSAGE_BOX_BUTTONS
			message_box_icon: WINFORMS_MESSAGE_BOX_ICON 
			windows_message_box: WINFORMS_MESSAGE_BOX
			file: PLAIN_TEXT_FILE
		do
			if not retried then
				build_image_list_assembly_viewer
				main_win.set_icon (dictionary.Import_tool_icon)		

				create file.make (dictionary.Open_icon_filename)
				if file.exists then
					open_image := image_factory.from_file (dictionary.Open_icon_filename.to_cil)
				else
					returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Open_icon_not_found_error.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
				end
				file.reset (dictionary.Import_icon_filename)
				if file.exists then
					import_image := image_factory.from_file (dictionary.Import_icon_filename.to_cil)
				else
					returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Import_icon_not_found_error.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
				end

				image_list := toolbar.get_image_list
				images := image_list.get_images
				images.add (open_image)
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
		do
			build_data_table_assembly_viewer	
		end

	build_data_grid is
		indexing
			description: "Build `data_grid' and associate actions."
			external_name: "BuildDataGrid"
		do
			build_data_grid_assembly_viewer
			data_grid.set_caption_text (dictionary.Caption_text.to_cil)
				-- Set `width'.
			assembly_name_column_style.set_width (dictionary.Window_width)
			set_read_only
		end
		
feature -- Event handling
		
	open_assembly (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Open an open file dialog to import a signed assembly, which is not in the GAC."
			external_name: "OpenAssembly"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			open_file_dialog: WINFORMS_OPEN_FILE_DIALOG
			returned_value: WINFORMS_DIALOG_RESULT
		do
			create open_file_dialog.make_winforms_open_file_dialog
			open_file_dialog.set_add_extension (True)
			open_file_dialog.set_check_file_exists (True)
			open_file_dialog.set_title (dictionary.Open_file_dialog_title.to_cil)
			open_file_dialog.set_validate_names (true)
			open_file_dialog.set_filter (dictionary.Open_file_dialog_filter.to_cil)
			returned_value := open_file_dialog.show_dialog
			if returned_value = returned_value.Ok and then open_file_dialog.get_file_name /= Void and then open_file_dialog.get_file_name.get_length > 0 then
				import_signed_assembly ( from_system_string (open_file_dialog.get_file_name) )
			end
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
					data_table.get_rows.clear
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
					data_table.get_rows.clear
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
					data_table.get_rows.clear
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
					data_table.get_rows.clear
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
					data_table.get_rows.clear
					display_assemblies
					dependancies_menu_item.set_checked (not checked)
					dependancies_toolbar_button.set_pushed (not checked)
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
		do
			show_all_assembly_viewer (sender, arguments)
			display_assemblies
			set_default_column_width
			fill_data_grid
			main_win.get_controls.add (data_grid)
			main_win.refresh
		ensure then
			all_columns_displayed: data_table.get_columns.get_count = 5
		end

	show_name (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Show assembly name column only."
			external_name: "ShowName"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		do
			show_name_assembly_viewer (sender, arguments)
			display_assemblies
			assembly_name_column_style.set_width (dictionary.Window_width - dictionary.Scrollbar_width)
			fill_data_grid
			main_win.get_controls.add (data_grid)
			main_win.refresh
		ensure
			name_columns_displayed: data_table.get_columns.get_count = 1
		end
		
	import (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Display import tool."
			external_name: "Import"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			selected_row: INTEGER
			a_descriptor: ASSEMBLY_DESCRIPTOR
			assembly_dependancies: ARRAY [CLI_CELL [ASSEMBLY_NAME]]
			import_dialog: IMPORT_DIALOG
			support: ASSEMBLY_SUPPORT
			retried: BOOLEAN
		do
			if not retried then
				selected_row := data_grid.get_current_Row_Index
				a_descriptor := current_assembly (selected_row)
				if a_descriptor /= Void then
					create support.make
					assembly_dependancies := support.dependancies_from_info (a_descriptor)
					if assembly_dependancies = Void then
						create assembly_dependancies.make (0,0)				
					end
					create import_dialog.make (a_descriptor, assembly_dependancies)
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
				open_assembly (sender, args)
			when 2 then
				display_name (sender, args)
			when 3 then
				display_version (sender, args)
			when 4 then
				display_culture (sender, args)
			when 5 then
				display_public_key (sender, args)
			when 6 then
				display_dependancies (sender, args)
			when 8 then
				show_dependancy_viewer (sender, args)
			when 10 then
				import (sender, args)
			when 12 then
				display_help (sender, args)
			end
		end		
		
feature {NONE} -- Implementation
		
	register_to_subject is
		indexing
			description: "Register assembly viewer to `ISE.ReflectionInterface.Notifier'."
			external_name: "RegisterToSubject"
		local
			type: TYPE
			notifier_handle: NOTIFIER_HANDLE
			notifier: NOTIFIER
			--on_update_add_delegate: SYSTEM_EVENT_HANDLER
		do
			notifier_handle := create {NOTIFIER_HANDLE}.make
			notifier := notifier_handle.current_notifier
			--create on_update_add_delegate.make_event_handler (Current, $update_add)		
			--notifier.add_addition_observer (on_update_add_delegate)
			notifier.add_addition_observer (agent update_add)
		end
		
	sort_assemblies is
		indexing
			description: "Sort assemblies by assembly name."
			external_name: "SortAssemblies"
		local
			sort_support: SORTING_SUPPORT
		do
			check
				non_void_shared_assemblies: shared_assemblies /= Void
			end
			create sort_support
			sort_support.sort_assembly_descriptors (shared_assemblies)
			shared_assemblies ?= sort_support.sorted_list
		end
		
	display_assemblies is
		indexing
			description: "Display assemblies."
			external_name: "DisplayAssemblies"
		local
			row_count: INTEGER
			a_descriptor: ASSEMBLY_DESCRIPTOR
			imported: BOOLEAN
		do
			if shared_assemblies /= Void and then shared_assemblies.count > 0 then
				check
					non_void_imported_table: imported_table /= Void
				end
				from
					shared_assemblies.start
					row_count := 0
				until
					shared_assemblies.after
				loop
					a_descriptor ?= shared_assemblies.item
					if a_descriptor /= Void then
						imported ?= imported_table.item (a_descriptor)
						if not imported then
							build_row (a_descriptor, row_count)
							row_count := row_count + 1
						end
					end
					shared_assemblies.forth
				end
			end
		end

	build_row (a_descriptor: ASSEMBLY_DESCRIPTOR; row_count: INTEGER) is 
		indexing
			description: "Build a row at index `row_count' and fill row with information from `a_descriptor'."
			external_name: "BuildRow"
		require
			non_void_assembly_descriptor: a_descriptor /= Void
			positive_row_count: row_count >= 0
		local
			a_row: DATA_DATA_ROW
		do
			a_row := new_row (a_descriptor, row_count)
		end

	build_empty_row (row_count: INTEGER) is 
		indexing
			description: "Build an empty row at index `row_count'."
			external_name: "BuildEmptyRow"
		local
			a_row: DATA_DATA_ROW
		do
			a_row := empty_row (row_count)
		end	
		
	set_default_column_width is
		indexing
			description: "Set default column width according to the content."
			external_name: "SetDefaultColumnWidth"
		local
			resizing_support: RESIZING_SUPPORT
		do
			create resizing_support.make (data_grid_font, dictionary.Window_width)
			assembly_name_column_style.set_width (resizing_support.assembly_name_column_width_from_info (shared_assemblies))
			assembly_version_column_style.set_width (resizing_support.assembly_version_column_width_from_info (shared_assemblies))
			assembly_culture_column_style.set_width (resizing_support.assembly_culture_column_width_from_info (shared_assemblies))
			assembly_public_key_column_style.set_width (resizing_support.assembly_public_key_column_width_from_info (shared_assemblies))
			dependancies_column_style.set_width (resizing_support.dependancies_column_width_from_info (shared_assemblies))
		end

	set_read_only is
		indexing
			description: "Set read-only property to each column of the data grid."
			external_name: "SetReadOnly"
		do
			set_read_only_assembly_viewer
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
			if (main_win.get_width > dictionary.Window_width and total_width < main_win.get_width) or (main_win.get_width <= dictionary.Window_width and total_width < dictionary.Window_width - dictionary.Scrollbar_width) then
				if dependancies_menu_item.get_checked then
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

	build_imported_table is
		indexing
			description: "Build and fill `imported_table'."
			external_name: "BuildImportedTable"
		require
			non_void_shared_assemblies: shared_assemblies /= Void
		local
			a_descriptor: ASSEMBLY_DESCRIPTOR
		do
			create imported_table.make (0)
			from
				shared_assemblies.start
			until
				shared_assemblies.after
			loop
				a_descriptor ?= shared_assemblies.item
				if a_descriptor /= Void and then not imported_table.has (a_descriptor) then
					imported_table.extend (is_imported (a_descriptor), a_descriptor)
				end
				shared_assemblies.forth
			end
		end
		
	assembly_factory: ASSEMBLY 
		indexing
			description: "Static needed to load .NET assemblies"
			external_name: "AssemblyFactory"
		end

	imported_table: HASH_TABLE [BOOLEAN, ASSEMBLY_DESCRIPTOR]
		indexing
			description: "Key: Assembly descriptor; Value: Boolean indicating if assembly is imported."
			external_name: "ImportedTable"
		end
		
	import_signed_assembly (a_filename: STRING)  is
		indexing
			description: "Import a signed assembly."
			external_name: "ImportSignedAssembly"
		require
			non_void_filename: a_filename /= Void
			not_empty_filename: a_filename.count > 0
		local
			an_assembly: ASSEMBLY
			an_assembly_name: ASSEMBLY_NAME
			a_key: NATIVE_ARRAY [INTEGER_8]
			conversion_support: CONVERSION_SUPPORT
			a_descriptor: ASSEMBLY_DESCRIPTOR
			dependancies: ARRAY [CLI_CELL [ASSEMBLY_NAME]]
			import_dialog: IMPORT_DIALOG
			retried: BOOLEAN
			message_box: WINFORMS_MESSAGE_BOX
			returned_value: WINFORMS_DIALOG_RESULT
			message_box_buttons: WINFORMS_MESSAGE_BOX_BUTTONS
			message_box_icon: WINFORMS_MESSAGE_BOX_ICON
			support: ASSEMBLY_SUPPORT
		do
			if not retried then
				an_assembly := assembly_factory.load_from (a_filename.to_cil)
				an_assembly_name := an_assembly.get_name
					-- Check assembly is signed.
				a_key := an_assembly_name.get_public_key
				if a_key /= Void and then a_key.count > 0 then
					create support.make
					--conversion_support := create {CONVERSION_SUPPORT}.make
					create conversion_support
					a_descriptor := conversion_support.assembly_descriptor_from_name (an_assembly_name)
					dependancies := support.dependancies_from_info (a_descriptor)
					if dependancies = Void then
						create dependancies.make (0, 0)
					end
					create import_dialog.make (a_descriptor, dependancies)
				else
					returned_value := message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Non_signed_assembly.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
				end
			end
		rescue
			retried := True
			retry
		end

	build_assemblies is
		indexing
			description: "Build `shared_assemblies', sort assemblies by assembly name and build `imported_table'."
			external_name: "BuildAssemblies"
		local
			gac_browser: GAC_BROWSER
			retried: BOOLEAN
			returned_value: WINFORMS_DIALOG_RESULT
			message_box: WINFORMS_MESSAGE_BOX
			message_box_buttons: WINFORMS_MESSAGE_BOX_BUTTONS
			message_box_icon: WINFORMS_MESSAGE_BOX_ICON
			conversion_support: ASSMEBLY_MANAGER_SUPPORT [ASSEMBLY_DESCRIPTOR]
		do
			if not retried then
				create gac_browser
				shared_assemblies := gac_browser.shared_assemblies
				sort_assemblies
				build_imported_table
			else
				returned_value := message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Error_browsing_GAC.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
			end
		ensure then
			non_void_shared_assemblies: shared_assemblies /= Void
			non_void_imported_table: imported_table /= Void
		rescue
			retried := True
			retry
		end

	current_assembly (row_number: INTEGER): ASSEMBLY_DESCRIPTOR is
		indexing
			description: "Assembly descriptor corresponding to row at index `row_number'"
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
					display_assemblies
					main_win.get_controls.add (data_grid)
					rows := data_table.get_rows
					
					main_win.get_controls.remove (data_grid)
					a_row := rows.get_item (row_number)
					name ?= a_row.get_item (assembly_name_column)
					a_name ?= from_system_string (name)
					version ?= a_row.get_item (assembly_version_column)
					a_version ?= from_system_string (version)
					culture ?= a_row.get_item (assembly_culture_column)
					a_culture ?= from_system_string (culture)
					public_key ?= a_row.get_item (assembly_public_key_column)
					a_public_key ?= from_system_string (public_key)
					if a_name /= Void and a_version /= Void and a_culture /= Void and a_public_key /= Void then
						--Result := create {ASSEMBLY_DESCRIPTOR}.make1
						create Result.make (to_reflection_string (a_name), to_reflection_string (a_version), to_reflection_string(a_culture), to_reflection_string(a_public_key))
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
					display_assemblies
					resize_columns
					main_win.get_controls.add (data_grid)
					main_win.refresh
				end
			else
				Result := Void
			end
		end
		
	update_gui is
		indexing
			description: "Update GUI."
			external_name: "UpdateGui"
		do
			update_gui_assembly_viewer	
			display_assemblies
			resize_columns
			main_win.get_controls.add (data_grid)
			main_win.refresh		
		end
		
end -- class IMPORT_TOOL
