indexing
	description: "Assembly viewer"
	external_name: "AssemblyManager.AssemblyViewer"

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
		do
			make_form
			create assemblies.make
			create reflection_interface.make_reflectioninterface
			reflection_interface.Make
			initialize_gui
			return_value := showdialog
		ensure
			non_void_assemblies: assemblies /= Void
		end

feature -- Access

	imported_assemblies_button: SYSTEM_WINDOWS_FORMS_BUTTON
			-- Button to show either all shared assemblies or only imported assemblies
		indexing
			external_name: "ImportedAssembliesButton"
		end
	
	hide_dependancies_button: SYSTEM_WINDOWS_FORMS_BUTTON
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

	Title: STRING is "Assembly viewer"
			-- Window title
		indexing
			external_name: "Title"
		end
	
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
		
	Window_height: INTEGER is 400
			-- Window width
		indexing
			external_name: "WindowHeight"
		end	
	
	Imported_assemblies_button_label: STRING is "Imported assemblies"
			-- Imported assemblies button label
		indexing
			external_name: "ImportedAssembliesButtonLabel"
		end

	All_assemblies_button_label: STRING is "All assemblies"
			-- All assemblies button label
		indexing
			external_name: "AllAssembliesButtonLabel"
		end

	Hide_dependancies_button_label: STRING is "Hide dependancies"
			-- Hide dependancies button label
		indexing
			external_name: "HideDependanciesButtonLabel"
		end
		
	Data_table_title: STRING is "Assembly viewer table"
			-- Data table title
		indexing
			external_name: "DataTableTitle"
		end
	
	Assembly_name_column_title: STRING is "Name"
			-- Assembly name column title
		indexing
			external_name: "AssemblyNameColumnTitle"
		end

	Assembly_version_column_title: STRING is "Version"
			-- Assembly version column title
		indexing
			external_name: "AssemblyVersionColumnTitle"
		end

	Assembly_culture_column_title: STRING is "Culture"
			-- Assembly culture column title
		indexing
			external_name: "AssemblyCultureColumnTitle"
		end

	Assembly_public_key_column_title: STRING is "Public Key"
			-- Assembly public key column title
		indexing
			external_name: "AssemblyPublicKeyColumnTitle"
		end
		
	Dependancies_column_title: STRING is "Dependancies"
			-- Dependancies column title
		indexing
			external_name: "DependanciesColumnTitle"
		end	
			
	Eiffel_path_column_title: STRING is "Path to Eiffel sources"
			-- Eiffel path column title
		indexing
			external_name: "EiffelPathColumnTitle"
		end

	Import_button_label: STRING is "Import"
			-- Import button label
		indexing
			external_name: "ImportButtonLabel"
		end

	Edit_button_label: STRING is "Edit"
			-- Edit button label
		indexing
			external_name: "EditButtonLabel"
		end
		
	Remove_button_label: STRING is "Remove"
			-- Remove button label
		indexing
			external_name: "RemoveButtonLabel"
		end

	System_string_type: STRING is "System.String"
			-- System.String type
		indexing
			external_name: "SystemStringType"
		end

	System_event_handler_type: STRING is "System.EventHandler"
			-- System.EventHandler type
		indexing
			external_name: "SystemEventHandlerType"
		end

	System_windows_forms_mouse_event_handler_type: STRING is "System.Windows.Forms.MouseEventHandler"
			-- System.Windows.Forms.MouseEventHandler type
		indexing
			external_name: "SystemWindowsFormsMouseEventHandlerType"
		end
	
	System_Windows_Forms_assembly_path: STRING is "C:\WINNT\Microsoft.NET\Framework\v1.0.2728\SYSTEM.WINDOWS.FORMS.DLL"
			-- Path to `System.Windows.Forms.dll'
		indexing
			external_name: "SystemWindowsFormsAssemblyPath"
		end
		
	Not_imported_yet: STRING is "Not imported yet"
			-- Message telling the user assembly has not been imported yet
		indexing
			external_name: "NotImportedYet"
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
	
	Margin: INTEGER is 10
			-- Margin
		indexing
			external_name: "Margin"
		end
	
	No_dependancy: STRING is "No dependancy"
			-- No dependancy message
		indexing
			external_name: "NoDependancy"
		end

	Empty_string: STRING is ""
			-- Empty string
		indexing
			external_name: "EmptyString"
		end
		
	Neutral_culture: STRING is "neutral"
			-- Neutral culture
		indexing
			external_name: "NeutralCulture"
		end
		
feature -- Basic Operations

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
			set_text (Title)
			set_borderstyle (Border_style)
			a_size.set_Width (Window_width)
			a_size.set_Height (Window_height)
			set_size (a_size)
			
				-- Create `imported_assemblies_button'.
			create imported_assemblies_button.make_button
			a_point.set_X (Margin)
			a_point.set_Y (Margin)
			imported_assemblies_button.set_location (a_point)
			a_size.set_Width (Large_button_width)
			a_size.set_Height (Button_height)
			imported_assemblies_button.set_size (a_size)
			imported_assemblies_button.set_text (Imported_assemblies_button_label)
			type := type_factory.GetType_String (System_event_handler_type)
			on_imported_assemblies_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnImportedAssembliesEventHandler")
			imported_assemblies_button.add_Click (on_imported_assemblies_event_handler_delegate)
			
				-- Create `hide_dependancies_button'.
			create hide_dependancies_button.make_button
			a_point.set_X (Large_button_width + 2 * Margin)
			a_point.set_Y (Margin)
			hide_dependancies_button.set_location (a_point)
			a_size.set_Width (Large_button_width)
			a_size.set_Height (Button_height)
			hide_dependancies_button.set_size (a_size)
			hide_dependancies_button.set_text (Hide_dependancies_button_label)
			on_hide_dependancies_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnHideDependanciesEventHandler")
			hide_dependancies_button.add_Click (on_hide_dependancies_event_handler_delegate)
			
				-- Build and fill assemblies table.
			build_and_fill_assemblies_table
			
			if imported_assemblies /= Void then
				if imported_assemblies.count > 0 then
					create_edit_button
					create_remove_button
				else
					create_import_button
				end
			else
				create_import_button
			end
			
				-- Add controls
			controls.Add (imported_assemblies_button)
			controls.Add (hide_dependancies_button)
			controls.Add (data_grid)

			if imported_assemblies /= Void then
				if imported_assemblies.count > 0 then
					controls.Add (edit_button)
					controls.Add (remove_button)
				else
					controls.Add (import_button)
				end
			else
				controls.Add (import_button)
			end
		end

feature -- Event handling

	on_imported_assemblies_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
			-- Process `imported_assemblies_button' activation.
			-- | FIXME: Code should be in import routine
		indexing
			external_name: "OnImportedAssembliesEventHandler"
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

	on_hide_dependancies_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
			-- Process `hide_dependancies_button' activation.
			-- FIXME: Code should be in routine handling double click on a data grid cell
		indexing
			external_name: "OnHideDependanciesEventHandler"
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
					an_assembly := reflection_interface.assemblyfrominfo (an_assembly_descriptor)
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
		do
			console.writeline_string ("import")
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
			a_point: SYSTEM_DRAWING_POINT
			a_size: SYSTEM_DRAWING_SIZE
			type: SYSTEM_TYPE
			on_edit_event_handler_delegate: SYSTEM_DELEGATE
			return_value: INTEGER
			info: HITTESTINFO_IN_SYSTEM_WINDOWS_FORMS_DATAGRID
		do
			--info := data_grid.HitTest_Int32 (arguments.X, arguments.Y)
			--if info.Type = 6 then
				console.writeline_string ("row selected")
			--	if info.Row <= imported_assemblies.Count then
						-- Currently selected assembly has already been imported. Thus, it can be edited or removed.
					if edit_button /= Void then
						edit_button.set_visible (False)
					end
					if remove_button /= Void then
						remove_button.set_visible (False)					
					end
					create_edit_button
					create_remove_button				

						-- Update controls.
					if controls.contains (import_button) then
						controls.remove (import_button)
					end
					controls.add (edit_button)
					controls.add (remove_button)
				--else
						-- Currently selected assembly has not been imported yet.
				--	if import_button /= Void then
				--		import_button.set_visible (False)
				--	end
				--	create_import_button

						-- Update controls.
				-- controls.add (import_button)
				--	if controls.contains (edit_button) then
				--		controls.remove (edit_button)
				--	end
				--	if controls.contains (remove_button) then
				--		controls.remove (remove_button)
				--	end
				--end
			--end
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
			--assembly_name_column_style: SYSTEM_WINDOWS_FORMS_DATAGRIDBOOLCOLUMN
			--assembly_version_column_style: SYSTEM_WINDOWS_FORMS_DATAGRIDBOOLCOLUMN
			--assembly_culture_column_style: SYSTEM_WINDOWS_FORMS_DATAGRIDBOOLCOLUMN
			--assembly_public_key_column_style: SYSTEM_WINDOWS_FORMS_DATAGRIDBOOLCOLUMN
			--dependancies_column_style: SYSTEM_WINDOWS_FORMS_DATAGRIDBOOLCOLUMN
			--eiffel_path_column_style: SYSTEM_WINDOWS_FORMS_DATAGRIDBOOLCOLUMN
			added: INTEGER
			assembly: SYSTEM_REFLECTION_ASSEMBLY
			on_select_table_event_handler_delegate: SYSTEM_WINDOWS_FORMS_MOUSEEVENTHANDLER
		do
			create data_table.make_datatable_1 (Data_table_title)
			
				-- Create table columns
			type := type_factory.GetType_String (System_string_type);
			create assembly_name_column.make_datacolumn_2 (Assembly_name_column_title, type)
			create assembly_version_column.make_datacolumn_2 (Assembly_version_column_title, type)
			create assembly_culture_column.make_datacolumn_2 (Assembly_culture_column_title, type)
			create assembly_public_key_column.make_datacolumn_2 (Assembly_public_key_column_title, type)
			create dependancies_column.make_datacolumn_2 (Dependancies_column_title, type)			
			create eiffel_path_column.make_datacolumn_2 (Eiffel_path_column_title, type)			

				-- Add columns to data table
			data_table.Columns.Add_DataColumn (assembly_name_column)
			data_table.Columns.Add_DataColumn (assembly_version_column)
			data_table.Columns.Add_DataColumn (assembly_culture_column)
			data_table.Columns.Add_DataColumn (assembly_public_key_column)
			data_table.Columns.Add_DataColumn (dependancies_column)
			data_table.Columns.Add_DataColumn (eiffel_path_column)

				-- Fill table
			fill_assemblies_table_with_imported_assemblies
			-- fill_assemblies_table_with_other_shared_assemblies
			
				-- Build data grid				
			create data_grid.make_datagrid
			data_grid.BeginInit
			data_grid.set_BorderStyle (1)
			data_grid.set_GridLineStyle (1)
			data_grid.set_Visible (True)
			
			a_size.set_Width (Window_width - 2 * Margin)
			a_size.set_Height (imported_assemblies.count * 20 + 26 * 2)
			data_grid.set_Size (a_size)
			a_point.set_X (Margin)
			a_point.set_Y (2 * Margin + Button_height)
			data_grid.set_location (a_point)
			data_grid.set_DataSource (data_table)
			data_grid.set_TabIndex (0)
						
			--assembly := assembly.LoadFrom (System_Windows_Forms_assembly_path)
			--type := assembly.GetType_String_Boolean (System_windows_forms_mouse_event_handler_type, True)
			--on_select_table_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "on_select_table_event_handler")
			--data_grid.Add_MouseDown (on_select_table_event_handler_delegate)

				-- Set styles.
			create data_grid_table_style.make_datagridtablestyle_1 
			data_grid_table_style.set_GridLineStyle (1)
			data_grid_table_style.set_AllowSorting (False)
			--data_grid_table_style.set_PreferredRowHeight (20)
			--data_grid_table_style.set_PreferredColumnWidth ((Window_width - 2 * Margin) // 6)
			
			if data_grid.TableStyles.System_Collections_ICollection_get_Count = 0 then
				added := data_grid.TableStyles.Add (data_grid_table_style)
			end	
	

--			bindings := data_grid.DataBindings
--			if bindings /= Void then
--				console.writeline_string (bindings.count.tostring_string2)
--				binding := bindings.Item (1)
--				if binding /= Void then
--					base := binding.BindingManagerBase
--					if base /= Void then
--						properties := base.GetItemProperties 
--						if properties /= Void then
--							property_descriptor := properties.Item_String (Assembly_name_column_title)
--							if property_descriptor /= Void then			
--								create assembly_name_column_style.make_datagridboolcolumn_1 (property_descriptor)
--								assembly_name_column_style.set_width (Assembly_name_column_title.Length)
--								added := data_grid_table_style.GridColumnStyles.Add (assembly_name_column_style)
--							else
--								console.writeline_string ("property descriptor is void")
--							end
--						else
--							console.writeline_string ("properties are void")
--						end
--					else
--						console.writeline_string ("base is void")
--					end
--				else
--					console.writeline_string ("binding is void")
--				end
--			else
--				console.writeline_string ("bindings void")
--			end
			
	--   System.Windows.Forms.GridColumnsCollection myGridColumnCol;
	--   myGridColumnCol = dataGrid1.GridColumns;
	--   //Get the CurrencyManager for the table you want to add a column to.
	--   CurrencyManager myCurrencyManager = this.BindingContext[ds.Tables["Products"]];
	--   /* Get the PropertyDescriptor for the DataColumn of the new column. 
	--
	--       The column should contain a boolean value. */
	--   PropertyDescriptor pd = myCurrencyManager.GetItemProperties()["Discontinued"];
	--   DataGridColumnStyle myColumn = new System.Windows.Forms.DataGridBoolColumn( pd );
	--   dgc.Add( myColumn );

--dataGrid1.CurrentGridTable.GridColumns["OrderID"].Width = 100;
-- console.writeline_String (data_grid.DataSource.GridColumns.Item (assembly_name_columns_title).Width)
	
	
			--if data_grid_table_style.GridColumnStyles.System_Collections_ICollection_get_Count = 0 then


			--	create assembly_version_column_style.make_datagridboolcolumn
			--	assembly_version_column_style.set_width (Assembly_version_column_title.Length)
			--	added := data_grid_table_style.GridColumnStyles.Add (assembly_version_column_style)

			--	create assembly_culture_column_style.make_datagridboolcolumn
			--	assembly_culture_column_style.set_width (Assembly_culture_column_title.Length)
			--	added := data_grid_table_style.GridColumnStyles.Add (assembly_culture_column_style)

			--	create assembly_public_key_column_style.make_datagridboolcolumn
			--	assembly_public_key_column_style.set_width (Assembly_public_key_column_title.Length)
			--	added := data_grid_table_style.GridColumnStyles.Add (assembly_public_key_column_style)
--
			--	create dependancies_column_style.make_datagridboolcolumn
			--	dependancies_column_style.set_width (Dependancies_column_title.Length)
			--	added := data_grid_table_style.GridColumnStyles.Add (dependancies_column_style)
--
			--	create eiffel_path_column_style.make_datagridboolcolumn
			--	eiffel_path_column_style.set_width (Eiffel_path_column_title.Length)
			--	added := data_grid_table_style.GridColumnStyles.Add (eiffel_path_column_style)
		--	end
			data_grid.EndInit 		
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
			type: SYSTEM_TYPE
			a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			row_count: INTEGER
			dependancies: ARRAY [SYSTEM_REFLECTION_ASSEMBLYNAME]
			dependancies_string: STRING
			j: INTEGER
			a_dependancy: SYSTEM_REFLECTION_ASSEMBLYNAME
			row_descriptor: ROW_DESCRIPTOR
		do
			imported_assemblies := reflection_interface.assemblies
			from
				row_count := 0
				i := 0
			until
				i = imported_assemblies.Count
			loop
				an_assembly ?= imported_assemblies.Item (i)
				if an_assembly /= Void then
					row := data_table.NewRow
					data_table.Rows.Add_datarow (row)
					row.Table.DefaultView.set_AllowEdit (False)
					row.Table.DefaultView.set_AllowNew (False)
					row.Table.DefaultView.set_AllowDelete (False)
					row.set_Item_String (Assembly_name_column_title, an_assembly.AssemblyName)
					row.set_Item_String (Assembly_version_column_title, an_assembly.AssemblyVersion)
					row.set_Item_String (Assembly_culture_column_title, an_assembly.AssemblyCulture)
					row.set_Item_String (Assembly_public_key_column_title, an_assembly.AssemblyPublicKey)

					create a_descriptor.make1
					a_descriptor.Make (an_assembly.AssemblyName, an_assembly.AssemblyVersion, an_assembly.AssemblyCulture, an_assembly.AssemblyPublicKey)
					dependancies := dependancies_from_info (a_descriptor)
					if dependancies.count > 0 then
						create dependancies_string.make_2 ('%U', 0)
						from
							j := 0
						until
							j = dependancies.Count
						loop
							a_dependancy := dependancies.item (j)
							dependancies_string := dependancies_string.Concat_String_String_String_String (dependancies_string, a_dependancy.Name, " ", a_dependancy.Version.ToString)
							if j < dependancies.Count - 1 then
								dependancies_string := dependancies_string.Concat_String_String (dependancies_string, ", ")
							end
							j := j + 1
						end
						row.set_Item_String (Dependancies_column_title, dependancies_string)
					else
						row.set_Item_String (Dependancies_column_title, No_dependancy)
					end
					row.set_Item_String (Eiffel_path_column_title, an_assembly.EiffelClusterPath)
--##FIXME##################################################
					create row_descriptor.make (row_count)
					assemblies.Add (row_descriptor, a_descriptor)
--##################################################
					row_count := row_count + 1
				end
				i := i + 1
			end	
		end

--	fill_assemblies_table_with_other_shared_assemblies is
--			-- Fill `data_table' with assemblies from GAC, which have not been imported yet.
--		indexing
--			external_name: "FillAssembliesTableWithOtherSharedAssemblies"
--		local
--			--gac_browser: GAC_BROWSER
--			i: INTEGER
--			a_shared_assembly: ISE_REFLECTION_EIFFELASSEMBLY
--			row: SYSTEM_DATA_DATAROW
--			--dependancies: SYSTEM_COLLECTION_ARRAYLIST
--			--dependancies_string: STRING
--			--j: INTEGER
--			--a_dependancy: STRING
--		do
--			--create gac_browser.make
--			--shared_assemblies := gac_browser.shared_assemblies
--			from
--			until
--				i = shared_assemblies.count
--			loop
--				a_shared_assembly ?= shared_assemblies.item (i)
--				if a_shared_assembly /= Void then
--					if not is_imported (a_shared_assembly) then
--						row := data_table.NewRow
--						data_table.Rows.Add_datarow (row)
--						row.Table.DefaultView.set_AllowEdit (False)
--						row.set_Item_String (Assembly_name_column_title, a_shared_assembly.AssemblyName)
--						row.set_Item_String (Assembly_version_column_title, a_shared_assembly.AssemblyVersion)
--						row.set_Item_String (Assembly_culture_column_title, a_shared_assembly.AssemblyCulture)
--						row.set_Item_String (Assembly_name_public_key_title, a_shared_assembly.AssemblyPublicKey)
--						--dependancies := a_shared_assembly.Dependancies
--						--create dependancies_string.make_2 ('%U', 0)
--						--from
--						--	j := 0
--						--until
--						--	j = dependancies.Count
--						--loop
--						--	a_dependancy ?= dependancies.item (j)
--						--	if a_dependancy /= Void then
--						--		dependancies_string.Concat_String_String (dependancies_string, a_dependancy)
--						--		if j /= dependancies.Count - 2 then
--						--			dependancies_string.Concat_String_String (dependancies_string, ", ")
--						--		end
--						--	end
--						--	j := j + 1
--						--end
--						--row.set_Item_String (Dependancies_column_title, dependancies_string)
--						row.set_Item_String (Eiffel_path_column_title, Not_imported_yet)			
--					end
--				end
--				i := i + 1
--			end
--		end
		
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
			a_point.set_X (Margin)
			a_point.set_Y (3 * Margin + Button_height + imported_assemblies.count * 20 + 26 * 2)
			edit_button.set_location (a_point)
			--a_size.set_Width (Button_width)
			--a_size.set_Height (Button_height)
			--edit_button.set_size (a_size)
			edit_button.set_text (Edit_button_label)
			type := type_factory.GetType_String (System_event_handler_type)
			on_edit_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnEditEventHandler")
			edit_button.add_Click (on_edit_event_handler_delegate)		
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
			a_point.set_X (2 * Margin + Button_width)
			
			a_point.set_Y (3 * Margin + Button_height + imported_assemblies.count * 20 + 26 * 2)
			remove_button.set_location (a_point)
			--a_size.set_Width (Button_width)
			--a_size.set_Height (Button_height)
			--remove_button.set_size (a_size)
			remove_button.set_text (Remove_button_label)
			type := type_factory.GetType_String (System_event_handler_type)
			on_remove_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnRemoveEventHandler")
			remove_button.add_Click (on_remove_event_handler_delegate)	
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
			a_point.set_X (Margin)
			a_point.set_Y (3 * Margin + Button_height + imported_assemblies.count * 20 + 26 * 2)
			import_button.set_location (a_point)
			--a_size.set_Width (Button_width)
			--a_size.set_Height (Button_height)
			--import_button.set_size (a_size)
			import_button.set_text (Import_button_label)
			type := type_factory.GetType_String (System_event_handler_type)
			on_import_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnImportEventHandler")
			import_button.add_Click (on_import_event_handler_delegate)
		end
	
	assembly_name_from_info (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): SYSTEM_REFLECTION_ASSEMBLYNAME is
			-- Assembly name corresponding to `a_descriptor'.
		require
			non_void_descriptor: a_descriptor /= Void
		local
			version: SYSTEM_VERSION
			culture: SYSTEM_GLOBALIZATION_CULTUREINFO
			encoding: SYSTEM_TEXT_ASCIIENCODING
			public_key: ARRAY [INTEGER_8]
		do
			create Result.make
			Result.set_Name (a_descriptor.Name)
			create version.make_3 (a_descriptor.Version)
			Result.set_Version (version)
			if not a_descriptor.Culture.Equals_String (Neutral_culture) then
				create culture.make (a_descriptor.Culture)
			else
				create culture.make (Empty_string)
			end
			Result.set_CultureInfo (culture)
			create encoding.make_asciiencoding 
			public_key := encoding.GetBytes (a_descriptor.PublicKey)
			Result.SetPublicKeyToken (public_key)
		ensure
			non_void_assembly_name: Result /= Void
		end
	
--	dependancies_from_filename (an_assembly_filename: STRING): ARRAY [SYSTEM_REFLECTION_ASSEMBLYNAME]
--			-- Dependancies of an assembly having `an_assembly_filename' as filename
--		require
--			non_void_filename: an_assembly_filename /= Void
--			not_empty_filename: an_assembly_filename.Length > 0
--		local
--			assembly_name: SYSTEM_REFLECTION_ASSEMBLYNAME
--			assembly: SYSTEM_REFLECTION_ASSEMBLY
--		do
--			create assembly_name.make
--			assembly_name := assembly_name.GetAssemblyName (an_assembly_filename)
--			assembly := assembly.LoadFrom_String (an_assembly_filename)
--			Result := dependancies_from_assembly (assembly)
--		end	
--
	dependancies_from_info (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): ARRAY [SYSTEM_REFLECTION_ASSEMBLYNAME] is
			-- Dependancies of an assembly having `a_descriptor' as assembly descriptor
		require
			non_void_assembly_descriptor: a_descriptor /= Void
		local
			assembly_name: SYSTEM_REFLECTION_ASSEMBLYNAME
			an_assembly: SYSTEM_REFLECTION_ASSEMBLY
		do
			assembly_name := assembly_name_from_info (a_descriptor)
			an_assembly := an_assembly.load (assembly_name)
			Result := an_assembly.GetReferencedAssemblies
		end
			
end -- class ASSEMBLY_VIEWER
			