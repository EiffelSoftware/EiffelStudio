indexing
	description: "Assembly viewer"
	external_name: "ISE.AssemblyManager.AssemblyViewer"

class
	ASSEMBLY_VIEWER

inherit
	SYSTEM_WINDOWS_FORMS_FORM

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize GUI.
		indexing
			external_name: "Make"
		local
			return_value: INTEGER
			retried: BOOLEAN
		do
			make_form
			create dictionary
			create assemblies.make
			create reflection_interface.make_reflectioninterface
			reflection_interface.MakeReflectionInterface
			if not retried then
				register_to_subject
				initialize_gui
			else
				display_error
			end
			return_value := showdialog
		ensure
			non_void_assemblies: assemblies /= Void
		rescue
			retried := True
			retry
		end

feature -- Access

	dictionary: ASSEMBLY_VIEWER_DICTIONARY
			-- Dictionary
		indexing
			external_name: "Dictionary"
		end
		
	imported_assemblies_button: SYSTEM_WINDOWS_FORMS_CHECKBOX
			-- Button to show either all shared assemblies or only imported assemblies
		indexing
			external_name: "ImportedAssembliesButton"
		end
	
	hide_dependancies_button: SYSTEM_WINDOWS_FORMS_CHECKBOX
			-- Button to hide dependancies column
		indexing
			external_name: "HideDependanciesButton"
		end
		
	data_table: SYSTEM_DATA_DATATABLE
			-- Data table
		indexing
			external_name: "DataTable"
		end
	
	assembly_name_column: SYSTEM_DATA_DATACOLUMN
			-- Assembly name column
		indexing
			external_name: "AssemblyNameColumn"
		end

	assembly_version_column: SYSTEM_DATA_DATACOLUMN
			-- Assembly version column
		indexing
			external_name: "AssemblyVersionColumn"
		end

	assembly_culture_column: SYSTEM_DATA_DATACOLUMN
			-- Assembly culture column
		indexing
			external_name: "AssemblyCultureColumn"
		end

	assembly_public_key_column: SYSTEM_DATA_DATACOLUMN
			-- Assembly public_key column
		indexing
			external_name: "AssemblyPublicKeyColumn"
		end
		
	dependancies_column: SYSTEM_DATA_DATACOLUMN
			-- Dependancies column
		indexing
			external_name: "DependanciesColumn"
		end

	eiffel_path_column: SYSTEM_DATA_DATACOLUMN
			-- Column with path to Eiffel sources for imported assemblies 
			-- or a message if the assembly has not been imported yet
		indexing
			external_name: "EiffelPathColumn"
		end

	import_button: SYSTEM_WINDOWS_FORMS_BUTTON
			-- Button to import a .NET assembly
		indexing
			external_name: "ImportButton"
		end

	edit_button: SYSTEM_WINDOWS_FORMS_BUTTON
			-- Button to edit a .NET assembly (view types...)
		indexing
			external_name: "EditButton"
		end
		
	remove_button: SYSTEM_WINDOWS_FORMS_BUTTON
			-- Button to remove a .NET assembly from the Eiffel/.NET assembly cache
		indexing
			external_name: "RemoveButton"
		end
	
feature -- Constants
	
	Border_style: INTEGER is 3
			-- Window border style: a fixed, single line border
		indexing
			external_name: "BorderStyle"
		end
	
	Window_width: INTEGER is 800
			-- Window width
		indexing
			external_name: "WindowWidth"
		end
		
	Window_height: INTEGER is 600
			-- Window width
		indexing
			external_name: "WindowHeight"
		end	
	
	Large_button_width: INTEGER is 150
			-- Width of large buttons
		indexing
			external_name: "LargeButtonWidth"
		end

	Button_width: INTEGER is 75
			-- Width of current buttons
		indexing
			external_name: "ButtonWidth"
		end
		
	Button_height: INTEGER is 25
			-- Button height
		indexing
			external_name: "ButtonHeight"
		end

	Label_height: INTEGER is 20
			-- Label height
		indexing
			external_name: "LabelHeight"
		end
		
	Margin: INTEGER is 10
			-- Margin
		indexing
			external_name: "Margin"
		end
	
	Table_height: INTEGER is 480
			-- Table height
		indexing
			external_name: "TableHeight"
		end

	Regular_style: INTEGER is 0
			-- Regular style
		indexing
			external_name: "RegularStyle"
		end

	Label_font_size: REAL is 10.0
			-- Label font size
		indexing
			external_name: "LabelFontSize"
		end

	Button_appearance: INTEGER is 1
			-- Appearance enum value for Button.
		indexing
			exernal_name: "ButtonAppearance"
		end
		
	Middle_center_alignment: INTEGER is 32
			-- ContentAlignment enum value for MiddleCenter.
		indexing
			external_name: "MiddleCenterAlignment"
		end
		
feature -- Status Setting

	is_imported (assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): BOOLEAN is
			-- Is assembly corresponding to `assembly_descriptor' already in the Eiffe/.NET assembly cache?
		indexing
			external_name: "IsImported"
		require
			non_void_descriptor: assembly_descriptor /= Void 
		local
			enumerator: SYSTEM_COLLECTIONS_IENUMERATOR
			a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			moved: BOOLEAN
		do
			enumerator := assemblies.values.getenumerator
			from
			until
				not enumerator.movenext or Result
			loop
				a_descriptor ?= enumerator.current_
				if a_descriptor /= Void then
					Result := assembly_descriptor.name.equals_string (a_descriptor.name) 
							and assembly_descriptor.version.equals_string (a_descriptor.version)
							and assembly_descriptor.culture.equals_string (a_descriptor.culture)
							and assembly_descriptor.publickey.equals_string (a_descriptor.publickey)
				end
			moved := enumerator.movenext
			end
		end
	
feature -- Basic Operations

	register_to_subject is
	
		indexing
			external_name: "RegisterToSubject"
		local
			type: SYSTEM_TYPE
			notifier: ISE_REFLECTION_NOTIFIER
			on_update_add_delegate: SYSTEM_EVENTHANDLER
			on_update_remove_delegate: SYSTEM_EVENTHANDLER
		do
			create notifier.make1
			notifier.make
			type := type_factory.gettype_string (dictionary.System_event_handler_type)
			on_update_add_delegate ?= delegate_factory.createdelegate_type_object (type, Current, "UpdateAdd")
			notifier.addadditionobserver (on_update_add_delegate)
			on_update_remove_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "UpdateRemove")
			notifier.addremoveobserver (on_update_remove_delegate)
		end
		
	initialize_gui is
			-- Initialize assembly viewer window.
		indexing
			external_name: "InitializeGui"
		local
			a_size: SYSTEM_DRAWING_SIZE
			type: SYSTEM_TYPE
			a_color: SYSTEM_DRAWING_COLOR
			a_point: SYSTEM_DRAWING_POINT
			on_imported_assemblies_event_handler_delegate: SYSTEM_EVENTHANDLER
			on_hide_dependancies_event_handler_delegate: SYSTEM_EVENTHANDLER
		do
			set_Enabled (True)
			set_text (dictionary.Title)
			--set_borderstyle (dictionary.Border_style)
			--a_size.set_Width (dictionary.Window_width)
			--a_size.set_Height (dictionary.Window_height)
			set_borderstyle (Border_style)
			a_size.set_Width (Window_width)
			a_size.set_Height (Window_height)
			set_size (a_size)
			
				-- Create `imported_assemblies_button'.				
			create imported_assemblies_button.make_checkbox
			--imported_assemblies_button.set_appearance (dictionary.Button_appearance)
			--imported_assemblies_button.set_textalign (dictionary.Middle_center_alignment)
			imported_assemblies_button.set_appearance (Button_appearance)
			imported_assemblies_button.set_textalign (Middle_center_alignment)
			--a_point.set_X (dictionary.Margin)
			--a_point.set_Y (dictionary.Margin)
			a_point.set_X (Margin)
			a_point.set_Y (Margin)
			imported_assemblies_button.set_location (a_point)
			--a_size.set_Width (dictionary.Large_button_width)
			--a_size.set_Height (dictionary.Button_height)
			a_size.set_Width (Large_button_width)
			a_size.set_Height (Button_height)
			imported_assemblies_button.set_size (a_size)
			imported_assemblies_button.set_text (dictionary.Imported_assemblies_button_label)
			type := type_factory.GetType_String (dictionary.System_event_handler_type)
			on_imported_assemblies_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnImportedAssembliesEventHandler")
			imported_assemblies_button.add_Click (on_imported_assemblies_event_handler_delegate)
			
				-- Create `hide_dependancies_button'.
			create hide_dependancies_button.make_checkbox
			--hide_dependancies_button.set_appearance (dictionary.Button_appearance)
			--hide_dependancies_button.set_textalign (dictionary.Middle_center_alignment)
			hide_dependancies_button.set_appearance (Button_appearance)
			hide_dependancies_button.set_textalign (Middle_center_alignment)
			--a_point.set_X (dictionary.Large_button_width + 2 * dictionary.Margin)
			--a_point.set_Y (dictionary.Margin)
			a_point.set_X (Large_button_width + 2 * Margin)
			a_point.set_Y (Margin)
			hide_dependancies_button.set_location (a_point)
			--a_size.set_Width (dictionary.Large_button_width)
			--a_size.set_Height (dictionary.Button_height)
			a_size.set_Width (Large_button_width)
			a_size.set_Height (Button_height)
			hide_dependancies_button.set_size (a_size)
			hide_dependancies_button.set_text (dictionary.Hide_dependancies_button_label)
			on_hide_dependancies_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnHideDependanciesEventHandler")
			hide_dependancies_button.add_Click (on_hide_dependancies_event_handler_delegate)
			
				-- Build and fill assemblies table.
			build_and_fill_assemblies_table
			
			if imported_assemblies /= Void and then imported_assemblies.count > 0 then
				create_edit_button
				create_remove_button
			else
				create_import_button
			end			
				-- Add controls
			controls.Add (imported_assemblies_button)
			controls.Add (hide_dependancies_button)
			controls.Add (data_grid)
		end

feature -- Event handling

	on_imported_assemblies_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
			-- Process `imported_assemblies_button' activation.
		indexing
			external_name: "OnImportedAssembliesEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		do
			if imported_assemblies_button.checked then
				imported_assemblies_button.set_text (dictionary.Imported_assemblies_button_label)
			else
				imported_assemblies_button.set_text (dictionary.All_assemblies_button_label)
			end
		end

	on_double_click_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
			-- Process `imported_assemblies_button' activation.
			-- | FIXME: Should use hitinfo to retrieve selected cell.
		indexing
			external_name: "OnDoubleClickEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			selected_row: INTEGER
			an_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			assembly_dependancies: ARRAY [SYSTEM_REFLECTION_ASSEMBLYNAME]
			dependancy_viewer: DEPENDANCY_VIEWER
			row_descriptor: ROW_DESCRIPTOR
			enum: SYSTEM_COLLECTIONS_IENUMERATOR
			found: BOOLEAN
		do
			selected_row := data_grid.CurrentRowIndex
--##FIXME##################################################
			enum := assemblies.keys.getenumerator
			from
			until
				not enum.movenext or found
			loop
				row_descriptor ?= enum.Current_
				if row_descriptor /= Void then
					found := (row_descriptor.row_number = selected_row)
				end
			end
			if found then
				an_assembly_descriptor ?= assemblies.Item (row_descriptor)
--##################################################
				if an_assembly_descriptor /= Void then
					assembly_dependancies := dependancies_from_info (an_assembly_descriptor)
					if assembly_dependancies /= Void then
						create dependancy_viewer.make (an_assembly_descriptor, assembly_dependancies)
					end
				end
			end			
		end
		
	on_hide_dependancies_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
			-- Process `hide_dependancies_button' activation.
		indexing
			external_name: "OnHideDependanciesEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		do
			if hide_dependancies_button.checked then
				hide_dependancies_button.set_text (dictionary.Show_dependancies_button_label)
			else
				hide_dependancies_button.set_text (dictionary.Hide_dependancies_button_label)
			end
		end

	on_edit_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
			-- Process `edit_button' activation.
		indexing
			external_name: "OnEditEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			selected_row: INTEGER
			an_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			an_assembly: ISE_REFLECTION_EIFFELASSEMBLY
			a_type_list: SYSTEM_COLLECTIONS_ARRAYLIST
			assembly_view: ASSEMBLY_VIEW
			row_descriptor: ROW_DESCRIPTOR
			enum: SYSTEM_COLLECTIONS_IENUMERATOR
			found: BOOLEAN
		do
			selected_row := data_grid.CurrentRowIndex
--##FIXME##################################################
			enum := assemblies.keys.getenumerator
			from
			until
				not enum.movenext or found
			loop
				row_descriptor ?= enum.Current_
				if row_descriptor /= Void then
					found := (row_descriptor.row_number = selected_row)
				end
			end
			if found then
				an_assembly_descriptor ?= assemblies.Item (row_descriptor)
--##################################################
				if an_assembly_descriptor /= Void then
					an_assembly := reflection_interface.assembly (an_assembly_descriptor)
					if an_assembly /= Void then
						a_type_list := an_assembly.types
						if a_type_list /= Void then
							create assembly_view.make (an_assembly_descriptor, a_type_list)
						end
					end
				end
			end
		end

	on_import_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
			-- Process `import_button' activation.
		indexing
			external_name: "OnImportEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			selected_row: INTEGER
			an_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			assembly_dependancies: ARRAY [SYSTEM_REFLECTION_ASSEMBLYNAME]
			import_dialog: IMPORT_DIALOG
			row_descriptor: ROW_DESCRIPTOR
			enum: SYSTEM_COLLECTIONS_IENUMERATOR
			found: BOOLEAN
		do
			selected_row := data_grid.CurrentRowIndex
--##FIXME##################################################
			enum := assemblies.keys.getenumerator
			from
			until
				not enum.movenext or found
			loop
				row_descriptor ?= enum.Current_
				if row_descriptor /= Void then
					found := (row_descriptor.row_number = selected_row)
				end
			end
			if found then
				an_assembly_descriptor ?= assemblies.Item (row_descriptor)
--##################################################
				if an_assembly_descriptor /= Void then
					assembly_dependancies := dependancies_from_info (an_assembly_descriptor)
					if assembly_dependancies /= Void then
						create import_dialog.make (an_assembly_descriptor, assembly_dependancies)
					end
				end
			end
		end

	on_remove_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
			-- Process `remove_button' activation.
		indexing
			external_name: "OnRemoveEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			selected_row: INTEGER
			an_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			assembly_dependancies: ARRAY [SYSTEM_REFLECTION_ASSEMBLYNAME]
			remove_dialog: REMOVE_DIALOG
			row_descriptor: ROW_DESCRIPTOR
			enum: SYSTEM_COLLECTIONS_IENUMERATOR
			found: BOOLEAN
		do
			selected_row := data_grid.CurrentRowIndex
--##FIXME##################################################
			enum := assemblies.keys.getenumerator
			from
			until
				not enum.movenext or found
			loop
				row_descriptor ?= enum.Current_
				if row_descriptor /= Void then
					found := (row_descriptor.row_number = selected_row)
				end
			end
			if found then
				an_assembly_descriptor ?= assemblies.Item (row_descriptor)
--##################################################
				if an_assembly_descriptor /= Void then
					assembly_dependancies := dependancies_from_info (an_assembly_descriptor)
					if assembly_dependancies /= Void then
						create remove_dialog.make (an_assembly_descriptor, assembly_dependancies)
					end
				end
			end
		end
	
	on_select_table_event_handler (sender: ANY; arguments: SYSTEM_WINDOWS_FORMS_MOUSEEVENTARGS) is
			-- Process `data_table' row selection.
		indexing
			external_name: "OnSelectTableEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
--			info: HITTESTINFO_IN_SYSTEM_WINDOWS_FORMS_DATAGRID
		do
--			info := data_grid.HitTest_Int32 (arguments.X, arguments.Y)
--			if info.Type = 6 then
--				console.writeline_string ("row selected")
--				if info.Row <= imported_assemblies.Count then
--						-- Currently selected assembly has already been imported. Thus, it can be edited or removed.
--					if import_button /= Void and then controls.contains (import_button) then
--						controls.remove (import_button)
--					end
--					if edit_button = Void then
--						create_edit_button
--					end
--					if remove_button = Void then
--						create_remove_button					
--					end
--					refresh
--				else
--						-- Currently selected assembly has not been imported yet.
--					if edit_button /= Void and then controls.contains (edit_button) then
--						controls.remove (edit_button)
--					end
--					if remove_button /= Void and then controls.contains (remove_button) then
--						controls.remove (edit_button)
--					end
--					if import_button = Void then
--						create_import_button
--					end
--					refresh
--				end
--			end
		end
	
	update_add (sender: ANY; arguments: SYSTEM_EVENTARGS) is
			-- Update `assemblies_table'.
		indexing
			external_name: "UpdateAdd"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		do
			console.writeline_string ("update add")
		end

	update_remove (sender: ANY; arguments: SYSTEM_EVENTARGS) is
			-- Update `assemblies_table'.
		indexing
			external_name: "UpdateRemove"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		do
			console.writeline_string ("update remove")
		end

		
feature {NONE} -- Implementation

	type_factory: SYSTEM_TYPE
			-- Statics needed to create a type
		indexing
			external_name: "TypeFactory"
		end
		
	delegate_factory: SYSTEM_DELEGATE
			-- Statics needed to create a delegate
		indexing
			external_name: "DelegateFactory"
		end
	
	data_grid: SYSTEM_WINDOWS_FORMS_DATAGRID
			-- Data grid for `data_table'
		indexing
			external_name: "DataGrid"
		end
	
	imported_assemblies: SYSTEM_COLLECTIONS_ARRAYLIST
			-- Assemblies in Eiffel/.NET assembly cache
		indexing
			external_name: "ImportedAssemblies"
		end
		
	shared_assemblies: SYSTEM_COLLECTIONS_ARRAYLIST
			-- Assemblies in GAC
		indexing
			external_name: "SharedAssemblies"
		end

	assemblies: SYSTEM_COLLECTIONS_HASHTABLE
			-- Key: Row number
			-- Value: Assembly descriptor
		indexing
			external_name: "Assemblies"
		end
	
	reflection_interface: ISE_REFLECTION_REFLECTIONINTERFACE
			-- Reflection interface
		indexing
			external_name: "ReflectionInterface"
		end
		
	build_and_fill_assemblies_table is
			-- Build and fill `data_table'.
		indexing
			external_name: "BuildAndFillAssembliesTable"
		local
			row: SYSTEM_DATA_DATAROW
			type: SYSTEM_TYPE
			data_grid_table_style: SYSTEM_WINDOWS_FORMS_DATAGRIDTABLESTYLE		
			a_size: SYSTEM_DRAWING_SIZE
			a_point: SYSTEM_DRAWING_POINT
			added: INTEGER
			assembly: SYSTEM_REFLECTION_ASSEMBLY
			on_select_table_event_handler_delegate: SYSTEM_WINDOWS_FORMS_MOUSEEVENTHANDLER
		do
			create data_table.make_datatable_1 (dictionary.Data_table_title)
			
				-- Create table columns
			type := type_factory.GetType_String (dictionary.System_string_type);
			create assembly_name_column.make_datacolumn_2 (dictionary.Assembly_name_column_title, type)
			create assembly_version_column.make_datacolumn_2 (dictionary.Assembly_version_column_title, type)
			create assembly_culture_column.make_datacolumn_2 (dictionary.Assembly_culture_column_title, type)
			create assembly_public_key_column.make_datacolumn_2 (dictionary.Assembly_public_key_column_title, type)
			create dependancies_column.make_datacolumn_2 (dictionary.Dependancies_column_title, type)			
			create eiffel_path_column.make_datacolumn_2 (dictionary.Eiffel_path_column_title, type)			

				-- Add columns to data table
			data_table.Columns.Add_DataColumn (assembly_name_column)
			data_table.Columns.Add_DataColumn (assembly_version_column)
			data_table.Columns.Add_DataColumn (assembly_culture_column)
			data_table.Columns.Add_DataColumn (assembly_public_key_column)
			data_table.Columns.Add_DataColumn (dependancies_column)
			data_table.Columns.Add_DataColumn (eiffel_path_column)

				-- Fill table
			fill_assemblies_table_with_imported_assemblies
			--fill_assemblies_table_with_other_shared_assemblies
			
				-- Build data grid				
			create data_grid.make_datagrid
			data_grid.BeginInit
			data_grid.set_Visible (True)
			
			--a_size.set_Width (dictionary.Window_width - 2 * dictionary.Margin)
			--a_size.set_Height (dictionary.Table_height)
			a_size.set_Width (Window_width - 2 * Margin)
			a_size.set_Height (Table_height)
			data_grid.set_Size (a_size)
			--a_point.set_X (dictionary.Margin)
			--a_point.set_Y (2 * dictionary.Margin + dictionary.Button_height)
			a_point.set_X (Margin)
			a_point.set_Y (2 * Margin + Button_height)
			data_grid.set_location (a_point)
			data_grid.set_DataSource (data_table)
			data_grid.set_TabIndex (0)
						
				-- Set styles.
			create data_grid_table_style.make_datagridtablestyle_1 
			data_grid_table_style.set_GridLineStyle (1)
			data_grid_table_style.set_AllowSorting (False)
			--data_grid_table_style.set_PreferredColumnWidth (dictionary.Window_width // 6)
			data_grid_table_style.set_PreferredColumnWidth (Window_width // 6)
			
			if not data_grid.TableStyles.contains_datagridtablestyle (data_grid_table_style) then
				added := data_grid.TableStyles.Add (data_grid_table_style)
			end	
			data_grid.EndInit 
			
		--	create on_select_table_event_handler_delegate.make_mouseeventhandler (Current, "OnSelectTableEventHandler")
		--	data_grid.add_select (on_select_table_event_handler_delegate)	
		end
		
	console: SYSTEM_CONSOLE
	
	fill_assemblies_table_with_imported_assemblies is
			-- Fill `data_table' with information from reflection_interface'.
		indexing
			external_name: "FillAssembliesTableWithImportedAssemblies"
		local
			i: INTEGER
			an_assembly: ISE_REFLECTION_EIFFELASSEMBLY
			row: SYSTEM_DATA_DATAROW
			a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			row_count: INTEGER
			retried: BOOLEAN
		do
			if not retried then
				imported_assemblies := reflection_interface.assemblies
				from
					row_count := 0
					i := 0
				until
					i = imported_assemblies.Count
				loop
					an_assembly ?= imported_assemblies.Item (i)
					if an_assembly /= Void then
						create a_descriptor.make1
						a_descriptor.Make (an_assembly.AssemblyName, an_assembly.AssemblyVersion, an_assembly.AssemblyCulture, an_assembly.AssemblyPublicKey)
						build_row (a_descriptor, row_count, an_assembly.EiffelClusterPath)
						row_count := row_count + 1
					end
					i := i + 1
				end	
			end
		rescue
			retried := True
			retry
		end

	build_row (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR; row_count: INTEGER; eiffel_path: STRING) is 
			-- Build row and add row descriptor (built from `row_count') in `assemblies' table.
		indexing
			external_name: "BuildRow"
		require
			non_void_assembly_descriptor: a_descriptor /= Void
			positive_row_count: row_count >= 0
			non_void_eiffel_path: eiffel_path /= Void
		local
			row: SYSTEM_DATA_DATAROW
			dependancies: ARRAY [SYSTEM_REFLECTION_ASSEMBLYNAME]
			row_descriptor: ROW_DESCRIPTOR		
		do
			row := data_table.NewRow
			data_table.Rows.Add (row)
			row.Table.DefaultView.set_AllowEdit (False)
			row.Table.DefaultView.set_AllowNew (False)
			row.Table.DefaultView.set_AllowDelete (False)
			row.set_Item_String (dictionary.Assembly_name_column_title, a_descriptor.name)
			row.set_Item_String (dictionary.Assembly_version_column_title, a_descriptor.version)
			row.set_Item_String (dictionary.Assembly_culture_column_title, a_descriptor.culture)
			row.set_Item_String (dictionary.Assembly_public_key_column_title, a_descriptor.publickey)

			dependancies := dependancies_from_info (a_descriptor)
			if dependancies.count > 0 then
				row.set_Item_String (dictionary.Dependancies_column_title, dependancies_string (dependancies))
			else
				row.set_Item_String (dictionary.Dependancies_column_title, dictionary.No_dependancy)
			end
			row.set_Item_String (dictionary.Eiffel_path_column_title, eiffel_path)
--##FIXME##################################################
			create row_descriptor.make (row_count)
			assemblies.Add (row_descriptor, a_descriptor)
--##################################################
		end
		
	dependancies_string (dependancies: ARRAY [SYSTEM_REFLECTION_ASSEMBLYNAME]): STRING is
			-- String from `dependancies'
		indexing
			external_name: "DependanciesString"
		require
			non_void_dependancies: dependancies /= Void
			not_empty_dependancies: dependancies.count > 0
		local
			i: INTEGER
			a_dependancy: SYSTEM_REFLECTION_ASSEMBLYNAME		
		do
			create Result.make_2 ('%U', 0)
			from
				i := 0
			until
				i = dependancies.Count
			loop
				a_dependancy := dependancies.item (i)
				Result := Result.Concat_String_String_String_String (Result, a_dependancy.Name, " ", a_dependancy.Version.ToString)
				if i < dependancies.Count - 1 then
					Result := Result.Concat_String_String (Result, ", ")
				end
				i := i + 1
			end		
		ensure
			string_created: Result /= Void
		end
		
	fill_assemblies_table_with_other_shared_assemblies is
			-- Fill `data_table' with assemblies from GAC, which have not been imported yet.
		indexing
			external_name: "FillAssembliesTableWithOtherSharedAssemblies"
		local
			gac_browser: GAC_BROWSER
			i: INTEGER
			a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			row_count: INTEGER
			retried: BOOLEAN
		do
			if not retried then
				create gac_browser
				shared_assemblies := gac_browser.shared_assemblies
				from
					row_count := 0
					i := 0
				until
					i = shared_assemblies.Count
				loop
					a_descriptor ?= shared_assemblies.Item (i)
					if a_descriptor /= Void and then not is_imported (a_descriptor) then
						build_row (a_descriptor, row_count, dictionary.Not_imported_yet)
						row_count := row_count + 1
					end
					i := i + 1
				end	
			end
		rescue
			retried := True
			retry
		end
		
	create_edit_button is
			-- Create `edit_button'.
		indexing
			external_name: "CreateEditButton"
		local
			a_point: SYSTEM_DRAWING_POINT
			a_size: SYSTEM_DRAWING_SIZE
			type: SYSTEM_TYPE
			on_edit_event_handler_delegate: SYSTEM_EVENTHANDLER		
		do
			create edit_button.make_button
			--a_point.set_X (dictionary.Margin)
			a_point.set_X (Margin)
			--a_point.set_Y (3 * dictionary.Margin + dictionary.Button_height + dictionary.Table_height)
			a_point.set_Y (3 * Margin + Button_height + Table_height)
			edit_button.set_location (a_point)
			edit_button.set_text (dictionary.Edit_button_label)
			type := type_factory.GetType_String (dictionary.System_event_handler_type)
			on_edit_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnEditEventHandler")
			edit_button.add_Click (on_edit_event_handler_delegate)
			controls.add (edit_button)
		end
		
	create_remove_button is
			-- Create `remove_button'.
		indexing
			external_name: "CreateRemoveButton"
		local
			a_point: SYSTEM_DRAWING_POINT
			a_size: SYSTEM_DRAWING_SIZE
			type: SYSTEM_TYPE
			on_remove_event_handler_delegate: SYSTEM_EVENTHANDLER		
		do
			create remove_button.make_button
			--a_point.set_X (2 * dictionary.Margin + dictionary.Button_width)
			a_point.set_X (2 * Margin + Button_width)
			--a_point.set_Y (3 * dictionary.Margin + dictionary.Button_height + dictionary.Table_height)
			a_point.set_Y (3 * Margin + Button_height + Table_height)
			remove_button.set_location (a_point)
			remove_button.set_text (dictionary.Remove_button_label)
			type := type_factory.GetType_String (dictionary.System_event_handler_type)
			on_remove_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnRemoveEventHandler")
			remove_button.add_Click (on_remove_event_handler_delegate)	
			controls.add (remove_button)
		end

	create_import_button is
			-- Create `import_button'.
		indexing
			external_name: "CreateImportButton"
		local
			a_point: SYSTEM_DRAWING_POINT
			a_size: SYSTEM_DRAWING_SIZE
			type: SYSTEM_TYPE
			on_import_event_handler_delegate: SYSTEM_EVENTHANDLER		
		do
			create import_button.make_button
			--a_point.set_X (dictionary.Margin)
			--a_point.set_Y (3 * dictionary.Margin + dictionary.Button_height + dictionary.Table_height)
			a_point.set_X (Margin)
			a_point.set_Y (3 * Margin + Button_height + Table_height)
			import_button.set_location (a_point)
			import_button.set_text (dictionary.Import_button_label)
			type := type_factory.GetType_String (dictionary.System_event_handler_type)
			on_import_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnImportEventHandler")
			import_button.add_Click (on_import_event_handler_delegate)
			controls.add (import_button)
		end
	
	dependancies_from_info (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): ARRAY [SYSTEM_REFLECTION_ASSEMBLYNAME] is
			-- Dependancies of an assembly having `a_descriptor' as assembly descriptor
		indexing
			external_name: "DependanciesFromInfo"
		require
			non_void_assembly_descriptor: a_descriptor /= Void
		local
			assembly_name: SYSTEM_REFLECTION_ASSEMBLYNAME
			an_assembly: SYSTEM_REFLECTION_ASSEMBLY
			convert: ISE_REFLECTION_CONVERSIONSUPPORT
			retried: BOOLEAN
		do
			if not retried then
				create convert.make_conversionsupport
				assembly_name := convert.assemblynamefromdescriptor (a_descriptor)
				an_assembly := an_assembly.load (assembly_name)
				Result := an_assembly.GetReferencedAssemblies
			else
				create Result.make (1)
			end
		rescue
			retried := True
			retry
		end

	display_error is
			-- Display `dictionary.error_message'.
		indexing
			external_name: "DisplayError"
		require
			non_void_dictionary: dictionary /= Void
			non_void_message: dictionary.error_message /= Void
			not_empty_message: dictionary.error_message.length > 0
		do
			--set_width (dictionary.Window_width // 2)
			--set_height (dictionary.Window_height // 6)
			set_width (Window_width // 2)
			set_height (Window_height // 6)
			set_backcolor (dictionary.White_color)
			set_text (dictionary.Assembly_manager_title)
			--create_error_label (dictionary.Error_message, dictionary.Margin)
			--create_error_label (dictionary.Invitation_message, dictionary.Margin + dictionary.Label_height)
			create_error_label (dictionary.Error_message, Margin)
			create_error_label (dictionary.Invitation_message, Margin + Label_height)
		end
	
	create_error_label (a_message: STRING; y_position: INTEGER) is
			-- Create a label displaying `a_message'.
		indexing
			external_name: "CreateErrorLabel"
		require
			non_void_message: a_message /= Void
			not_empty_message: a_message.length > 0
			valid_y_position: y_position >= 0
		local
			a_size: SYSTEM_DRAWING_SIZE
			a_point: SYSTEM_DRAWING_POINT
			error_label: SYSTEM_WINDOWS_FORMS_LABEL
			a_font: SYSTEM_DRAWING_FONT
		do
			create error_label.make_label
			error_label.set_forecolor (dictionary.Red_color)
			--create a_font.make_font_10 (dictionary.Font_family_name, dictionary.Label_font_size, dictionary.Bold_style)
			create a_font.make_font_10 (dictionary.Font_family_name, Label_font_size, Regular_style)
			error_label.set_font (a_font)
			error_label.set_text (a_message)
			error_label.set_autosize (True)
			--a_point.set_x (dictionary.Margin)
			a_point.set_x (Margin)
			a_point.set_y (y_position) 
			error_label.set_location (a_point)
			controls.add (error_label)		
		end
		
end -- class ASSEMBLY_VIEWER
			
			