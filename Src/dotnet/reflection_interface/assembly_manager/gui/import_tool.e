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

	open_menu_item: SYSTEM_WINDOWS_FORMS_MENUITEM
		indexing
			description: "Open menu item"
			external_name: "OpenMenuItem"
		end
		
	open_toolbar_button: SYSTEM_WINDOWS_FORMS_TOOLBARBUTTON
		indexing
			description: "Open toolbar button"
			external_name: "OpenToolbarButton"
		end
		
	show_name_menu_item: SYSTEM_WINDOWS_FORMS_MENUITEM
		indexing
			description: "Show name menu item"
			external_name: "ShowNameMenuItem"
		end
			
	shared_assemblies: SYSTEM_COLLECTIONS_ARRAYLIST
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_ASSEMBLYDESCRIPTOR]
		indexing
			description: "Assemblies in the global assembly cache"
			external_name: "SharedAssemblies"
		end

feature -- Status Setting

	is_imported (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): BOOLEAN is
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
			separator: SYSTEM_WINDOWS_FORMS_MENUITEM
		do				
			build_menu_assembly_viewer
				-- Build File menu item.
			create open_menu_item.make_menuitem_1 (dictionary.Open_menu_item)
			open_menu_item.set_shortcut (dictionary.Ctrl_O_shortcut)
			added := file_menu_item.menuitems.add (open_menu_item)
			separator := file_menu_item.menuitems.add_string ("-")
			added := file_menu_item.menuitems.add (exit_menu_item)
			
				-- Build View menu item.
			create show_name_menu_item.make_menuitem_1 (dictionary.Show_name_menu_item)
			show_all_menu_item.set_shortcut (dictionary.Ctrl_A_shortcut)
			show_name_menu_item.set_shortcut (dictionary.Ctrl_S_shortcut)
			separator := view_menu_item.menuitems.add_string ("-")
			added := view_menu_item.menuitems.add (show_all_menu_item)	
			added := view_menu_item.menuitems.add (show_name_menu_item)	
			
				-- Build Tools menu item.
			create import_menu_item.make_menuitem_1 (dictionary.Import_menu_item)
			import_menu_item.set_shortcut (dictionary.Ctrl_I_shortcut)
			added := tools_menu_item.menuitems.add (import_menu_item)
		end
	
	set_menu_actions is
		indexing
			description: "Set actions to `main_menu'."
			external_name: "SetMenuActions"
		local
			open_delegate: SYSTEM_EVENTHANDLER
			show_name_delegate: SYSTEM_EVENTHANDLER
			import_delegate: SYSTEM_EVENTHANDLER
		do
			set_menu_actions_assembly_viewer
				-- File menu
			create open_delegate.make_eventhandler (Current, $open_assembly)
			open_menu_item.add_click (open_delegate)		
			
				-- View menu	
			create show_name_delegate.make_eventhandler (Current, $show_name)
			show_name_menu_item.add_click (show_name_delegate)
			
				-- Tools menu
			create import_delegate.make_eventhandler (Current, $import)
			import_menu_item.add_click (import_delegate)
		end

	build_toolbar is
		indexing
			description: "Build ISE assembly manager toolbar."
			external_name: "BuildToolbar"
		local
			added: INTEGER
			separator: SYSTEM_WINDOWS_FORMS_TOOLBARBUTTON
		do			
			build_toolbar_assembly_viewer
			
			create import_toolbar_button.make_toolbarbutton
			create separator.make_toolbarbutton
			import_toolbar_button.set_imageindex (7)
			import_toolbar_button.set_tooltiptext (dictionary.Import_menu_item)
			import_toolbar_button.set_style (dictionary.Push_button)
			separator.set_style (dictionary.Separator)
				
				-- Add buttons to `toolbar'.
			added := toolbar.buttons.add_toolbarbutton (separator)
			added := toolbar.buttons.add_toolbarbutton (dependancy_viewer_toolbar_button)
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
			import_image: SYSTEM_DRAWING_IMAGE
			image_list: SYSTEM_WINDOWS_FORMS_IMAGELIST
			images: IMAGECOLLECTION_IN_SYSTEM_WINDOWS_FORMS_IMAGELIST 
		do
			build_image_list_assembly_viewer
			set_icon (dictionary.Import_tool_icon)		
			import_image := image_factory.fromfile (dictionary.Import_icon_filename)
			image_list := toolbar.imagelist
			images := image_list.images
			images.add (import_image)
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
			data_grid.set_captiontext (dictionary.Caption_text)
				-- Set `width'.
			assembly_name_column_style.set_width (dictionary.Window_width)
			set_read_only
		end
		
feature -- Event handling

	open_assembly (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Open an open file dialog to import a signed assembly, which is not in the GAC."
			external_name: "OpenAssembly"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			open_file_dialog: SYSTEM_WINDOWS_FORMS_OPENFILEDIALOG
			returned_value: INTEGER
		do
			create open_file_dialog.make_openfiledialog
			open_file_dialog.set_addextension (True)
			open_file_dialog.set_checkfileexists (True)
			open_file_dialog.set_title (dictionary.Open_file_dialog_title)
			open_file_dialog.set_validatenames (true)
			open_file_dialog.set_filter (dictionary.Open_file_dialog_filter)
			returned_value := open_file_dialog.showdialog
			if returned_value = dictionary.Ok_returned_value and then open_file_dialog.filename /= Void and then open_file_dialog.filename.length > 0 then
				import_signed_assembly (open_file_dialog.filename)
			end
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
					data_table.rows.clear
					display_assemblies
					name_menu_item.set_checked (not checked)
					name_toolbar_button.set_pushed (not checked)
					resize_columns
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
					data_table.rows.clear
					display_assemblies
					version_menu_item.set_checked (not checked)
					version_toolbar_button.set_pushed (not checked)
					resize_columns
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
					data_table.rows.clear
					display_assemblies
					culture_menu_item.set_checked (not checked)
					culture_toolbar_button.set_pushed (not checked)
					resize_columns
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
					data_table.rows.clear
					display_assemblies
					public_key_menu_item.set_checked (not checked)
					public_key_toolbar_button.set_pushed (not checked)	
					resize_columns
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
					data_table.rows.clear
					display_assemblies
					dependancies_menu_item.set_checked (not checked)
					dependancies_toolbar_button.set_pushed (not checked)
					resize_columns
					controls.add (data_grid)
					refresh		
				end
			end
		end

	show_all (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Show all columns."
			external_name: "ShowAll"
		do
			show_all_assembly_viewer (sender, arguments)
			display_assemblies
			set_default_column_width
			controls.add (data_grid)
			refresh
		ensure then
			all_columns_displayed: data_table.columns.count = 5
		end

	show_name (sender: ANY; arguments: SYSTEM_EVENTARGS) is
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
			controls.add (data_grid)
			refresh
		ensure
			name_columns_displayed: data_table.columns.count = 1
		end
		
	import (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Display import tool."
			external_name: "Import"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			selected_row: INTEGER
			a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			assembly_dependancies: ARRAY [SYSTEM_REFLECTION_ASSEMBLYNAME]
			import_dialog: IMPORT_DIALOG
			support: SUPPORT
			retried: BOOLEAN
		do
			if not retried then
				selected_row := data_grid.CurrentRowIndex
				a_descriptor := current_assembly (selected_row)
				if a_descriptor /= Void then
					create support
					assembly_dependancies := support.dependancies_from_info (a_descriptor)
					if assembly_dependancies = Void then
						create assembly_dependancies.make (0)				
					end
					create import_dialog.make (a_descriptor, assembly_dependancies)
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
			when 6 then
				show_dependancy_viewer (sender, args)
			when 8 then
				import (sender, args)
			when 10 then
				display_help (sender, args)
			end
		end		
		
feature {NONE} -- Implementation
		
	register_to_subject is
		indexing
			description: "Register assembly viewer to `ISE.ReflectionInterface.Notifier'."
			external_name: "RegisterToSubject"
		local
			type: SYSTEM_TYPE
			notifier_handle: ISE_REFLECTION_NOTIFIERHANDLE
			notifier: ISE_REFLECTION_NOTIFIER
			on_update_add_delegate: SYSTEM_EVENTHANDLER
		do
			create notifier_handle.make1
			notifier := notifier_handle.currentnotifier
			create on_update_add_delegate.make_eventhandler (Current, $update_add)		
			notifier.addadditionobserver (on_update_add_delegate)
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
			shared_assemblies := sort_support.sorted_list
		end
		
	display_assemblies is
		indexing
			description: "Display assemblies."
			external_name: "DisplayAssemblies"
		local
			row_count: INTEGER
			i: INTEGER
			a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			imported: BOOLEAN
		do
			check
				non_void_shared_assemblies: shared_assemblies /= Void
				non_void_imported_table: imported_table /= Void
			end
			from
				row_count := 0
				i := 0
			until
				i = shared_assemblies.Count
			loop
				a_descriptor ?= shared_assemblies.Item (i)
				if a_descriptor /= Void then
					imported ?= imported_table.item (a_descriptor)
					if not imported then
						build_row (a_descriptor, row_count)
						row_count := row_count + 1
					end
				end
				i := i + 1
			end
			fill_data_grid
		end

	build_row (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR; row_count: INTEGER) is 
		indexing
			description: "Build a row at index `row_count' and fill row with information from `a_descriptor'."
			external_name: "BuildRow"
		require
			non_void_assembly_descriptor: a_descriptor /= Void
			positive_row_count: row_count >= 0
		local
			a_row: SYSTEM_DATA_DATAROW
		do
			a_row := new_row (a_descriptor, row_count)
		end

	build_empty_row (row_count: INTEGER) is 
		indexing
			description: "Build an empty row at index `row_count'."
			external_name: "BuildEmptyRow"
		local
			a_row: SYSTEM_DATA_DATAROW
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
			if (width > dictionary.Window_width and total_width < width) or (width <= dictionary.Window_width and total_width < dictionary.Window_width - dictionary.Scrollbar_width) then
				if dependancies_menu_item.checked then
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

	build_imported_table is
		indexing
			description: "Build and fill `imported_table'."
			external_name: "BuildImportedTable"
		require
			non_void_shared_assemblies: shared_assemblies /= Void
		local
			i: INTEGER
			a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
		do
			create imported_table.make
			from
			until
				i = shared_assemblies.count
			loop
				a_descriptor ?= shared_assemblies.item (i)
				if a_descriptor /= Void and then not imported_table.containskey (a_descriptor) then
					imported_table.add (a_descriptor, is_imported (a_descriptor))
				end
				i := i + 1
			end
		end
		
	assembly_factory: SYSTEM_REFLECTION_ASSEMBLY 
		indexing
			description: "Static needed to load .NET assemblies"
			external_name: "AssemblyFactory"
		end

	imported_table: SYSTEM_COLLECTIONS_HASHTABLE
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
			not_empty_filename: a_filename.length > 0
		local
			an_assembly: SYSTEM_REFLECTION_ASSEMBLY
			an_assembly_name: SYSTEM_REFLECTION_ASSEMBLYNAME
			a_key: ARRAY [INTEGER_8]
			conversion_support: ISE_REFLECTION_CONVERSIONSUPPORT
			a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			dependancies: ARRAY [SYSTEM_REFLECTION_ASSEMBLYNAME]
			import_dialog: IMPORT_DIALOG
			retried: BOOLEAN
			message_box: SYSTEM_WINDOWS_FORMS_MESSAGEBOX
			returned_value: INTEGER
			support: SUPPORT
		do
			if not retried then
				an_assembly := assembly_factory.loadfrom (a_filename)
				an_assembly_name := an_assembly.getname
					-- Check assembly is signed.
				a_key := an_assembly_name.getpublickey
				if a_key /= Void and then a_key.count > 0 then
					create support
					create conversion_support.make_conversionsupport
					a_descriptor := conversion_support.assemblydescriptorfromname (an_assembly_name)
					dependancies := support.dependancies_from_info (a_descriptor)
					if dependancies = Void then
						create dependancies.make (0)
					end
					create import_dialog.make (a_descriptor, dependancies)
				else
					returned_value := message_box.show_string_string_messageboxbuttons_messageboxicon (dictionary.Non_signed_assembly, dictionary.Error_caption, dictionary.Ok_message_box_button, dictionary.Error_icon)
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
			returned_value: INTEGER
			message_box: SYSTEM_WINDOWS_FORMS_MESSAGEBOX
		do
			if not retried then
				create gac_browser
				shared_assemblies := gac_browser.shared_assemblies
				sort_assemblies
				build_imported_table
			else
				returned_value := message_box.show_string_string_messageboxbuttons_messageboxicon (dictionary.Error_browsing_GAC, dictionary.Error_caption, dictionary.Ok_message_box_button, dictionary.Error_icon)
			end
		ensure then
			non_void_shared_assemblies: shared_assemblies /= Void
			non_void_imported_table: imported_table /= Void
		rescue
			retried := True
			retry
		end

	current_assembly (row_number: INTEGER): ISE_REFLECTION_ASSEMBLYDESCRIPTOR is
		indexing
			description: "Assembly descriptor corresponding to row at index `row_number'"
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
					display_assemblies
					resize_columns
					controls.add (data_grid)
					refresh
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
			controls.add (data_grid)
			refresh		
		end
		
end -- class IMPORT_TOOL