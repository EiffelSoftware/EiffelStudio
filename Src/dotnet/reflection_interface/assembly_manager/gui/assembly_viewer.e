indexing
	description: "Assembly viewer (imported assemblies only)"
	external_name: "ISE.AssemblyManager.AssemblyViewer"

deferred class
	ASSEMBLY_VIEWER

inherit
	SYSTEM_WINDOWS_FORMS_FORM

feature {NONE} -- Initialization

	make is
		indexing
			description: "Initialize attributes, register to subject and initialize GUI."
			external_name: "Make"
		local
			return_value: INTEGER
			message_box: SYSTEM_WINDOWS_FORMS_MESSAGEBOX
			retried: BOOLEAN
		do
			make_form
			if not retried then
				prepare_gui
				initialize_gui
				return_value := showdialog
			else
				return_value := message_box.show (dictionary.Error_message)
			end
		ensure
			non_void_reflection_interface: reflection_interface /= Void
		rescue
			retried := True
			retry
		end
		
feature -- Access
	
	console: SYSTEM_CONSOLE
	
	dictionary: ASSEMBLY_VIEWER_DICTIONARY is
		indexing
			description: "Dictionary"
			external_name: "Dictionary"
		once
			create Result
		ensure
			dictionary_created: Result /= Void
		end
		
	main_menu: SYSTEM_WINDOWS_FORMS_MAINMENU	
		indexing
			description: "Menu"
			external_name: "MainMenu"
		end

	file_menu_item: SYSTEM_WINDOWS_FORMS_MENUITEM
		indexing
			description: "File menu item"
			external_name: "FileMenuItem"
		end
		
	exit_menu_item: SYSTEM_WINDOWS_FORMS_MENUITEM
		indexing
			description: "Exit menu item"
			external_name: "ExitMenuItem"
		end
		
	view_menu_item: SYSTEM_WINDOWS_FORMS_MENUITEM
		indexing
			description: "View menu item"
			external_name: "ViewMenuItem"
		end
		
	name_menu_item: SYSTEM_WINDOWS_FORMS_MENUITEM
		indexing
			description: "Assembly name menu item"
			external_name: "NameMenuItem"
		end
		
	version_menu_item: SYSTEM_WINDOWS_FORMS_MENUITEM
		indexing
			description: "Assembly version menu item"
			external_name: "VersionMenuItem"
		end
		
	culture_menu_item: SYSTEM_WINDOWS_FORMS_MENUITEM
		indexing
			description: "Assembly culture menu item"
			external_name: "CultureMenuItem"
		end
		
	public_key_menu_item: SYSTEM_WINDOWS_FORMS_MENUITEM
		indexing
			description: "Assembly public key menu item"
			external_name: "PublicKeyMenuItem"
		end
		
	show_all_menu_item: SYSTEM_WINDOWS_FORMS_MENUITEM
		indexing
			description: "`Show all' menu item"
			external_name: "ShowAllMenuItem"
		end
		
	dependancies_menu_item: SYSTEM_WINDOWS_FORMS_MENUITEM	
		indexing
			description: "Dependancies menu item"
			external_name: "DependanciesMenuItem"
		end
	
	tools_menu_item: SYSTEM_WINDOWS_FORMS_MENUITEM
		indexing
			description: "Tools menu item"
			external_name: "ToolsMenuItem"
		end

	import_menu_item: SYSTEM_WINDOWS_FORMS_MENUITEM
		indexing
			description: "Import menu item"
			external_name: "ImportMenuItem"
		end
		
	help_menu_item: SYSTEM_WINDOWS_FORMS_MENUITEM
		indexing
			description: "Help menu item"
			external_name: "HelpMenuItem"
		end
		
	help_topics_menu_item: SYSTEM_WINDOWS_FORMS_MENUITEM
		indexing
			description: "Help topics menu item"
			external_name: "HelpTopicsMenuItem"
		end
		
	about_menu_item: SYSTEM_WINDOWS_FORMS_MENUITEM
		indexing
			description: "About ISE assembly manager menu item"
			external_name: "AboutMenuItem"
		end
		
	toolbar: SYSTEM_WINDOWS_FORMS_TOOLBAR
		indexing
			description: "Toolbar"
			external_name: "Toolbar"
		end	
		
	name_toolbar_button: SYSTEM_WINDOWS_FORMS_TOOLBARBUTTON
		indexing
			description: "Assembly name toolbar button"
			external_name: "NameToolbarButton"
		end
		
	version_toolbar_button: SYSTEM_WINDOWS_FORMS_TOOLBARBUTTON
		indexing
			description: "Assembly version toolbar button"
			external_name: "VersionToolbarButton"
		end
		
	culture_toolbar_button: SYSTEM_WINDOWS_FORMS_TOOLBARBUTTON
		indexing
			description: "Assembly culture toolbar button"
			external_name: "CultureToolbarButton"
		end
		
	public_key_toolbar_button: SYSTEM_WINDOWS_FORMS_TOOLBARBUTTON
		indexing
			description: "Assembly public key toolbar button"
			external_name: "PublicKeyToolbarButton"
		end
		
	show_all_toolbar_button: SYSTEM_WINDOWS_FORMS_TOOLBARBUTTON
		indexing
			description: "`Show all' toolbar button"
			external_name: "ShowAllToolbarButton"
		end
		
	dependancies_toolbar_button: SYSTEM_WINDOWS_FORMS_TOOLBARBUTTON
		indexing
			description: "Dependancies toolbar button"
			external_name: "DependanciesToolbarButton"
		end

	import_toolbar_button: SYSTEM_WINDOWS_FORMS_TOOLBARBUTTON
		indexing
			description: "Import toolbar button"
			external_name: "ImportToolbarButton"
		end
		
	help_toolbar_button: SYSTEM_WINDOWS_FORMS_TOOLBARBUTTON
		indexing
			description: "Help toolbar button"
			external_name: "HelpToolbarButton"
		end
		
	assembly_name_column_style: SYSTEM_WINDOWS_FORMS_DATAGRIDTEXTBOXCOLUMN
		indexing
			description: "Assembly name column style"
			external_name: "AssemblyNameColumnStyle"
		end
		
	assembly_version_column_style: SYSTEM_WINDOWS_FORMS_DATAGRIDTEXTBOXCOLUMN
		indexing
			description: "Assembly versopm column style"
			external_name: "AssemblyVersionColumnStyle"
		end
		
	assembly_culture_column_style: SYSTEM_WINDOWS_FORMS_DATAGRIDTEXTBOXCOLUMN
		indexing
			description: "Assembly culture column style"
			external_name: "AssemblyCultureColumnStyle"
		end
		
	assembly_public_key_column_style: SYSTEM_WINDOWS_FORMS_DATAGRIDTEXTBOXCOLUMN
		indexing
			description: "Assembly public key column style"
			external_name: "AssemblyPublicKeyColumnStyle"
		end
		
	dependancies_column_style: SYSTEM_WINDOWS_FORMS_DATAGRIDTEXTBOXCOLUMN
		indexing
			description: "Dependancies column style"
			external_name: "DependanciesColumnStyle"
		end
		
	reflection_interface: ISE_REFLECTION_REFLECTIONINTERFACE	
		indexing
			description: "Reflection interface"
			external_name: "ReflectionInterface"
		end
		
	data_grid: SYSTEM_WINDOWS_FORMS_DATAGRID
		indexing
			description: "Data grid associated with `data_table'"
			external_name: "DataGrid"
		end
				
	data_table: SYSTEM_DATA_DATATABLE
		indexing
			description: "Data table"
			external_name: "DataTable"
		end
	
	assembly_name_column: SYSTEM_DATA_DATACOLUMN
		indexing
			description: "Assembly name column"
			external_name: "AssemblyNameColumn"
		end

	assembly_version_column: SYSTEM_DATA_DATACOLUMN
		indexing
			description: "Assembly version column"
			external_name: "AssemblyVersionColumn"
		end

	assembly_culture_column: SYSTEM_DATA_DATACOLUMN
		indexing
			description: "Assembly culture column"
			external_name: "AssemblyCultureColumn"
		end

	assembly_public_key_column: SYSTEM_DATA_DATACOLUMN
		indexing
			description: "Assembly public_key column"
			external_name: "AssemblyPublicKeyColumn"
		end
		
	dependancies_column: SYSTEM_DATA_DATACOLUMN
		indexing
			description: "Dependancies column"
			external_name: "DependanciesColumn"
		end
	
	data_grid_font: SYSTEM_DRAWING_FONT
		indexing
			description: "Data grid font"
			external_name: "DataGridFont"
		end
		
feature -- Basic Operations
	
	prepare_gui is
		indexing
			description: "Create `reflection_interface, register assembly viewer to subject, retrieve assemblies (imported or not) and build `imported_table'."
			external_name: "PrepareGui"
		do
			register_to_subject
			create reflection_interface.make_reflectioninterface
			reflection_interface.MakeReflectionInterface
			build_assemblies	
		ensure
			non_void_reflection_interface: reflection_interface /= Void
		end
		
	initialize_gui is
		indexing
			description: "Initialize ISE assembly viewer window."
			external_name: "InitializeGui"
		local
			a_size: SYSTEM_DRAWING_SIZE
		do
			set_enabled (True)
			set_text (dictionary.Title)
			a_size.set_width (dictionary.Window_width)
			a_size.set_height (dictionary.Window_height)
			set_size (a_size)
			set_borderstyle (dictionary.Border_style)

			build_menu
			set_menu_actions
			build_toolbar
			build_assemblies_table
			display_assemblies
			controls.Add (data_grid)
		ensure
			non_void_menu: main_menu /= Void
			non_void_toolbar: toolbar /= Void
			non_void_data_table: data_table /= Void
			non_void_data_grid: data_grid /= Void
		end
		
	build_menu is
		indexing
			description: "Build ISE assembly manager menu."
			external_name: "BuildMenu"
		deferred
		ensure
			non_void_menu: main_menu /= Void
		end
	
	set_menu_actions is
		indexing
			description: "Set actions to `main_menu'."
			external_name: "SetMenuActions"
		require
			non_void_menu: main_menu /= Void
		deferred
		end

	build_toolbar is
		indexing
			description: "Build ISE assembly manager toolbar."
			external_name: "BuildToolbar"
		deferred
		ensure
			non_void_toolbar: toolbar /= Void
		end

	build_image_list is
		indexing
			description: "Build toolbar image list."
			external_name: "BuildImageList"
		require
			non_void_toolbar: toolbar /= Void
		deferred
		ensure
			non_void_image_list: toolbar.imagelist /= Void
		end

	build_assemblies_table is
		indexing
			description: "Create`data_table' and `data_grid' and fill table with imported assemblies."
			external_name: "BuildAssembliesTable"
		do
			build_data_table
			build_data_grid
		ensure
			non_void_data_table: data_table /= Void
			non_void_data_grid: data_grid /= Void
		end
	
	build_data_table is
		indexing
			description: "Build `data_table'."
			external_name: "BuildDataTable"
		deferred
		ensure
			non_void_data_table: data_table /= Void
		end
		
	build_data_grid is
		indexing
			description: "Build `data_grid' and associate actions."
			external_name: "BuildDataGrid"
		require
			non_void_toolbar: toolbar /= Void
		deferred
		ensure
			non_void_data_grid: data_grid /= Void
		end
	
feature -- Event handling

	display_name (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Display assembly name column if checked."
			external_name: "DisplayName"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		deferred
		end

	display_version (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Display assembly version column if checked."
			external_name: "DisplayVersion"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		deferred
		end

	display_culture (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Display assembly culture column if checked."
			external_name: "DisplayCulture"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		deferred
		end

	display_public_key (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Display assembly public key column if checked."
			external_name: "DisplayPublicKey"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		deferred
		end

	display_dependancies (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Display dependancies column if checked."
			external_name: "DisplayDependancies"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		deferred
		end

	show_all (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Show all columns."
			external_name: "ShowAll"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		deferred
		end
		
	exit (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Close ISE assembly manager."
			external_name: "Exit"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		do
			close
		end
	
	display_help (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Display help for ISE assembly manager."
			external_name: "DisplayHelp"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			support: ISE_REFLECTION_REFLECTIONSUPPORT
			help_filename: STRING
			help: SYSTEM_WINDOWS_FORMS_HELP
		do
			create support.make_reflectionsupport
			support.make
			help_filename := support.Eiffeldeliverypath
			help_filename := help_filename.concat_string_string (help_filename, dictionary.Relative_help_filename)
			help.showhelpindex (Current, help_filename)
		end
		
	about_assembly_manager (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Display general information about ISE assembly manager."
			external_name: "AboutAssemblyManager"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		do
			console.writeline_string ("about")
		end
	
	on_toolbar_button_clicked (sender: ANY; arguments: SYSTEM_WINDOWS_FORMS_TOOLBARBUTTONCLICKEVENTARGS) is
		indexing
			description: "Identify toolbar button and perform appropriate action."
			external_name: "OnToolBarButtonClicked"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		deferred
		end

	on_cell (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "If selected cell is in the dependancies column then display dependancies"
			external_name: "OnCell"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			selected_row: INTEGER
			selected_column: INTEGER
			a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			assembly_dependancies: ARRAY [SYSTEM_REFLECTION_ASSEMBLYNAME]
			dependancy_viewer: DEPENDANCY_VIEWER
			on_close_delegate: SYSTEM_EVENTHANDLER
			support: SUPPORT
		do
			if dependancies_menu_item.checked then
				create support
				selected_row := data_grid.CurrentRowIndex
				if selected_row /= -1 then
					if data_grid.CurrentCell /= Void and then data_grid.currentcell.columnnumber /= Void then
						selected_column := data_grid.currentcell.columnnumber
						a_descriptor := current_assembly (selected_row)	
						if a_descriptor /= Void then
							if selected_column = dictionary.Dependancies_column_number then
								assembly_dependancies := support.dependancies_from_info (a_descriptor)
								if assembly_dependancies /= Void and then assembly_dependancies.count > 0 then
									create dependancy_viewer.make (a_descriptor, assembly_dependancies)
								end
							end
						end
					end
				end
			end
		end

	update_add (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Update `assemblies_table'."
			external_name: "UpdateAdd"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		do
			update_gui
		end
		
feature {NONE} -- Implementation

	sort_assemblies is
		indexing
			description: "Sort assemblies by assembly name."
			external_name: "SortAssemblies"
		deferred
		end
				
	type_factory: SYSTEM_TYPE
			-- Statics needed to create a type
		indexing
			external_name: "TypeFactory"
		end
		
	display_assemblies is
		indexing
			description: "Display assemblies."
			external_name: "DisplayAssemblies"
		deferred
		end

	build_empty_row (row_count: INTEGER) is 
		indexing
			description: "Build an empty row at index `row_count'."
			external_name: "BuildEmptyRow"
		require
			positive_row_count: row_count >= 0
		deferred
		end
		
	current_assembly (row_number: INTEGER): ISE_REFLECTION_ASSEMBLYDESCRIPTOR is
		indexing
			description: "Assembly descriptor corresponding to row at index `row_number'"
			external_name: "CurrentAssembly"
		require
			valid_row_number: row_number > -1 and row_number < data_table.rows.count
		local
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
					if not name_menu_item.checked then
						data_table.columns.add_datacolumn (assembly_name_column)
					end
					if not version_menu_item.checked then
						data_table.columns.add_datacolumn (assembly_version_column)
					end
					if not culture_menu_item.checked then
						data_table.columns.add_datacolumn (assembly_culture_column)
					end
					if not public_key_menu_item.checked then
						data_table.columns.add_datacolumn (assembly_public_key_column)
					end
					rows := data_table.rows
					rows.clear
					display_assemblies
					a_row := rows.item (row_number)
					a_name ?= a_row.item (assembly_name_column)
					a_version ?= a_row.item (assembly_version_column)
					a_culture ?= a_row.item (assembly_culture_column)
					a_public_key ?= a_row.item (assembly_public_key_column)
					if a_name /= Void and a_version /= Void and a_culture /= Void and a_public_key /= Void then
						create Result.make1
						Result.make (a_name, a_version, a_culture, a_public_key)
					end
					if not name_menu_item.checked then
						data_table.columns.remove_datacolumn (assembly_name_column)
					end
					if not version_menu_item.checked then
						data_table.columns.remove_datacolumn (assembly_version_column)
					end
					if not culture_menu_item.checked then
						data_table.columns.remove_datacolumn (assembly_culture_column)
					end
					if not public_key_menu_item.checked then
						data_table.columns.remove_datacolumn (assembly_public_key_column)
					end
					rows.clear
					display_assemblies
				end
			else
				Result := Void
			end
		end

	fill_data_grid is
		indexing
			description: "Fill data grid with empty rows if not enough imported assemblies to fill the grid."
			external_name: "FillDataGrid"
		require
			non_void_data_grid: data_grid /= Void
			non_void_toolbar: toolbar /= Void
		local
			i: INTEGER
			difference: INTEGER
			rows: SYSTEM_DATA_DATAROWCOLLECTION
		do
			rows := data_table.rows
			if (rows.count + 3) * dictionary.Row_height < dictionary.Window_height - 4 * dictionary.Row_height then
				difference := dictionary.Window_height - 4 * dictionary.Row_height - (rows.count + 3) * dictionary.Row_height
				empty_row_count := difference // dictionary.Row_height + 1
				from
				until
					i = empty_row_count
				loop
					build_empty_row (rows.count)
					i := i + 1
				end
			end
		end
	
	empty_row_count: INTEGER
		indexing
			description: "Number of empty rows added to the data grid"
			external_name: "EmptyRowCount"
		end
	
	set_default_column_width is
		indexing
			description: "Set default column width according to the content."
			external_name: "SetDefaultColumnWidth"
		deferred
		end
		
	resize_columns is
		indexing
			description: "Resize columns."
			external_name: "ResizeColumns"
		deferred
		end

	update_gui is
		indexing
			description: "Update GUI."
			external_name: "UpdateGui"
		deferred		
		end

	register_to_subject is
		indexing
			description: "Register assembly viewer to `ISE.ReflectionInterface.Notifier'."
			external_name: "RegisterToSubject"
		deferred
		end

	build_assemblies is
		indexing
			description: "Build `imported_assemblies' and sort assemblies by assembly name."
			external_name: "BuildAssemblies"
		deferred
		end

end -- class ASSEMBLY_VIEWER