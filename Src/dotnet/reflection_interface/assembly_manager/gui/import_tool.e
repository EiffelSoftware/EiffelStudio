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
		
	show_name_menu_item: SYSTEM_WINDOWS_FORMS_MENUITEM
		indexing
			description: "`Show name only' menu item"
			external_name: "ShowNameMenuItem"
		end

	open_toolbar_button: SYSTEM_WINDOWS_FORMS_TOOLBARBUTTON
		indexing
			description: "Open toolbar button"
			external_name: "OpenToolbarButton"
		end
		
	show_name_toolbar_button: SYSTEM_WINDOWS_FORMS_TOOLBARBUTTON
		indexing
			description: "Show name toolbar button"
			external_name: "ShowNameToolbarButton"
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
		do
			reflection_interface.search (a_descriptor)
			Result := reflection_interface.found
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
				-- Build menu.
			create main_menu.make_mainmenu
			create file_menu_item.make_menuitem_1 (dictionary.File_menu_item)
			create view_menu_item.make_menuitem_1 (dictionary.View_menu_item)
			create tools_menu_item.make_menuitem_1 (dictionary.Tools_menu_item)
			create help_menu_item.make_menuitem_1 (dictionary.Help_menu_item)
				
				-- Build File menu item.
			create open_menu_item.make_menuitem_1 (dictionary.Open_menu_item)
			create exit_menu_item.make_menuitem_1 (dictionary.Exit_menu_item)
			open_menu_item.set_shortcut (dictionary.Ctrl_O_shortcut)
			exit_menu_item.set_shortcut (dictionary.Ctrl_X_shortcut)
			added := file_menu_item.menuitems.add (open_menu_item)
			separator := file_menu_item.menuitems.add_string ("-")
			added := file_menu_item.menuitems.add (exit_menu_item)
			
				-- Build View menu item.
			create name_menu_item.make_menuitem_1 (dictionary.Name_menu_item)
			create version_menu_item.make_menuitem_1 (dictionary.Version_menu_item)
			create culture_menu_item.make_menuitem_1 (dictionary.Culture_menu_item)
			create public_key_menu_item.make_menuitem_1 (dictionary.Public_key_menu_item)			
			create dependancies_menu_item.make_menuitem_1 (dictionary.Dependancies_menu_item)
			create show_all_menu_item.make_menuitem_1 (dictionary.Show_all_menu_item)
			create show_name_menu_item.make_menuitem_1 (dictionary.Show_name_menu_item)
						
			name_menu_item.set_shortcut (dictionary.Ctrl_N_shortcut)
			version_menu_item.set_shortcut (dictionary.Ctrl_V_shortcut)
			culture_menu_item.set_shortcut (dictionary.Ctrl_C_shortcut)
			public_key_menu_item.set_shortcut (dictionary.Ctrl_K_shortcut)
			dependancies_menu_item.set_shortcut (dictionary.Ctrl_D_shortcut)
			show_all_menu_item.set_shortcut (dictionary.Ctrl_A_shortcut)
			show_name_menu_item.set_shortcut (dictionary.Ctrl_S_shortcut)
			
			name_menu_item.set_checked (True)
			version_menu_item.set_checked (False)
			culture_menu_item.set_checked (False)
			public_key_menu_item.set_checked (False)
			dependancies_menu_item.set_checked (False)

			added := view_menu_item.menuitems.add (name_menu_item)	
			added := view_menu_item.menuitems.add (version_menu_item)	
			added := view_menu_item.menuitems.add (culture_menu_item)	
			added := view_menu_item.menuitems.add (public_key_menu_item)		
			added := view_menu_item.menuitems.add (dependancies_menu_item)
			separator := view_menu_item.menuitems.add_string ("-")
			added := view_menu_item.menuitems.add (show_all_menu_item)	
			added := view_menu_item.menuitems.add (show_name_menu_item)	
			
				-- Build Tools menu item.
			create import_menu_item.make_menuitem_1 (dictionary.Import_menu_item)
			import_menu_item.set_shortcut (dictionary.Ctrl_I_shortcut)
			added := tools_menu_item.menuitems.add (import_menu_item)
			
				-- Build Help menu item.
			create help_topics_menu_item.make_menuitem_1 (dictionary.Help_topics_menu_item)
			create about_menu_item.make_menuitem_1 (dictionary.About_menu_item)
			help_topics_menu_item.set_shortcut (dictionary.Ctrl_H_shortcut)
			added := help_menu_item.menuitems.add (help_topics_menu_item)
			added := help_menu_item.menuitems.add (about_menu_item)			
				
			added := main_menu.menuitems.add (file_menu_item)
			added := main_menu.menuitems.add (view_menu_item)
			added := main_menu.menuitems.add (tools_menu_item)
			added := main_menu.menuitems.add (help_menu_item)
			set_menu (main_menu)
		end
	
	set_menu_actions is
		indexing
			description: "Set actions to `main_menu'."
			external_name: "SetMenuActions"
		local
			open_delegate: SYSTEM_EVENTHANDLER
			exit_delegate: SYSTEM_EVENTHANDLER
			name_delegate: SYSTEM_EVENTHANDLER
			version_delegate: SYSTEM_EVENTHANDLER
			culture_delegate: SYSTEM_EVENTHANDLER
			public_key_delegate: SYSTEM_EVENTHANDLER
			dependancies_delegate: SYSTEM_EVENTHANDLER
			show_all_delegate: SYSTEM_EVENTHANDLER
			show_name_delegate: SYSTEM_EVENTHANDLER
			import_delegate: SYSTEM_EVENTHANDLER
			help_topics_delegate: SYSTEM_EVENTHANDLER
			about_delegate: SYSTEM_EVENTHANDLER		
		do
				-- File menu
			create open_delegate.make_eventhandler (Current, $open_assembly)
			create exit_delegate.make_eventhandler (Current, $exit)
			open_menu_item.add_click (open_delegate)	
			exit_menu_item.add_click (exit_delegate)	
			
				-- View menu	
			create name_delegate.make_eventhandler (Current, $display_name)
			create version_delegate.make_eventhandler (Current, $display_version)
			create culture_delegate.make_eventhandler (Current, $display_culture)
			create public_key_delegate.make_eventhandler (Current, $display_public_key)
			create dependancies_delegate.make_eventhandler (Current, $display_dependancies)
			create show_all_delegate.make_eventhandler (Current, $show_all)
			create show_name_delegate.make_eventhandler (Current, $show_name)
			name_menu_item.add_click (name_delegate)	
			version_menu_item.add_click (version_delegate)			
			culture_menu_item.add_click (culture_delegate)			
			public_key_menu_item.add_click (public_key_delegate)			
			dependancies_menu_item.add_click (dependancies_delegate)	
			show_all_menu_item.add_click (show_all_delegate)
			show_name_menu_item.add_click (show_name_delegate)
			
				-- Tools menu
			create import_delegate.make_eventhandler (Current, $import)
			import_menu_item.add_click (import_delegate)
			
				-- Help menu
			create help_topics_delegate.make_eventhandler (Current, $display_help)
			create about_delegate.make_eventhandler (Current, $about_assembly_manager)
			help_topics_menu_item.add_click (help_topics_delegate)
			about_menu_item.add_click (about_delegate)	
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
			create toolbar.make_toolbar
			toolbar.set_appearance (dictionary.Flat_appearance)
			toolbar.set_autosize (True)
			
			build_image_list
			
				-- Create toolbar buttons.
			create name_toolbar_button.make_toolbarbutton
			create version_toolbar_button.make_toolbarbutton
			create culture_toolbar_button.make_toolbarbutton
			create public_key_toolbar_button.make_toolbarbutton
			create dependancies_toolbar_button.make_toolbarbutton
			create show_all_toolbar_button.make_toolbarbutton
			create show_name_toolbar_button.make_toolbarbutton
			create import_toolbar_button.make_toolbarbutton
			create help_toolbar_button.make_toolbarbutton
			create separator.make_toolbarbutton
			
				-- Set icons to toolbar buttons.
			name_toolbar_button.set_imageindex (0)
			version_toolbar_button.set_imageindex (1)
			culture_toolbar_button.set_imageindex (2)
			public_key_toolbar_button.set_imageindex (3)
			dependancies_toolbar_button.set_imageindex (4)
			show_all_toolbar_button.set_imageindex (5)
			show_name_toolbar_button.set_imageindex (6)
			import_toolbar_button.set_imageindex (7)
			help_toolbar_button.set_imageindex (8)
			
				-- Set tooltips.
			name_toolbar_button.set_tooltiptext (dictionary.Name_menu_item)
			version_toolbar_button.set_tooltiptext (dictionary.Version_menu_item)
			culture_toolbar_button.set_tooltiptext (dictionary.Culture_menu_item)
			public_key_toolbar_button.set_tooltiptext (dictionary.Public_key_menu_item)
			dependancies_toolbar_button.set_tooltiptext (dictionary.Dependancies_menu_item)
			show_all_toolbar_button.set_tooltiptext (dictionary.Show_all_menu_item)
			show_name_toolbar_button.set_tooltiptext (dictionary.Show_name_menu_item)
			import_toolbar_button.set_tooltiptext (dictionary.Import_menu_item)
			help_toolbar_button.set_tooltiptext (dictionary.Help_menu_item)
			
				-- Set button style.
			name_toolbar_button.set_style (dictionary.Toggle_button)
			version_toolbar_button.set_style (dictionary.Toggle_button)
			culture_toolbar_button.set_style (dictionary.Toggle_button)
			public_key_toolbar_button.set_style (dictionary.Toggle_button)
			dependancies_toolbar_button.set_style (dictionary.Toggle_button)
			show_all_toolbar_button.set_style (dictionary.Push_button)
			show_name_toolbar_button.set_style (dictionary.Push_button)
			import_toolbar_button.set_style (dictionary.Push_button)
			help_toolbar_button.set_style (dictionary.Push_button)
			separator.set_style (dictionary.Separator)
			
				-- Set visible
			version_toolbar_button.set_enabled (False)
			culture_toolbar_button.set_enabled (False)
			public_key_toolbar_button.set_enabled (False)
			dependancies_toolbar_button.set_enabled (False)
			
				-- Add buttons to `toolbar'.
			added := toolbar.buttons.add_toolbarbutton (name_toolbar_button)
			added := toolbar.buttons.add_toolbarbutton (version_toolbar_button)
			added := toolbar.buttons.add_toolbarbutton (culture_toolbar_button)
			added := toolbar.buttons.add_toolbarbutton (public_key_toolbar_button)
			added := toolbar.buttons.add_toolbarbutton (dependancies_toolbar_button)
			added := toolbar.buttons.add_toolbarbutton (separator)
			added := toolbar.buttons.add_toolbarbutton (show_all_toolbar_button)
			added := toolbar.buttons.add_toolbarbutton (show_name_toolbar_button)
			added := toolbar.buttons.add_toolbarbutton (separator)
			added := toolbar.buttons.add_toolbarbutton (import_toolbar_button)
			added := toolbar.buttons.add_toolbarbutton (separator)
			added := toolbar.buttons.add_toolbarbutton (help_toolbar_button)
			controls.add (toolbar)
			
				-- Set action.
  			create toolbar_button_click_delegate.make_toolbarbuttonclickeventhandler (Current, $on_toolbar_button_clicked)
  			toolbar.add_buttonclick (toolbar_button_click_delegate)
		end

	build_image_list is
		indexing
			description: "Build toolbar image list."
			external_name: "BuildImageList"
		local
			name_image: SYSTEM_DRAWING_BITMAP
			version_image: SYSTEM_DRAWING_BITMAP
			culture_image: SYSTEM_DRAWING_BITMAP
			public_key_image: SYSTEM_DRAWING_BITMAP
			dependancies_image: SYSTEM_DRAWING_BITMAP
			show_all_image: SYSTEM_DRAWING_BITMAP
			show_name_image: SYSTEM_DRAWING_BITMAP
			import_image: SYSTEM_DRAWING_BITMAP
			help_image: SYSTEM_DRAWING_BITMAP	
			image_list: SYSTEM_WINDOWS_FORMS_IMAGELIST
			images: IMAGECOLLECTION_IN_SYSTEM_WINDOWS_FORMS_IMAGELIST 
		do
				-- Create icons
			create name_image.make_bitmap (dictionary.Name_icon_filename)
			create version_image.make_bitmap (dictionary.Version_icon_filename)
			create culture_image.make_bitmap (dictionary.Culture_icon_filename)
			create public_key_image.make_bitmap (dictionary.Public_key_icon_filename)
			create dependancies_image.make_bitmap (dictionary.Dependancies_icon_filename)
			create show_all_image.make_bitmap (dictionary.Show_all_icon_filename)
			create show_name_image.make_bitmap (dictionary.Show_name_icon_filename)
			create import_image.make_bitmap (dictionary.Import_icon_filename)
			create help_image.make_bitmap (dictionary.Help_icon_filename)
			
				-- Add icons to `imagelist'.
			create image_list.make_imagelist
			toolbar.set_imagelist (image_list)
			images := image_list.images
			images.add (name_image)
			images.add (version_image)
			images.add (culture_image)
			images.add (public_key_image)
			images.add (dependancies_image)
			images.add (show_all_image)
			images.add (show_name_image)
			images.add (import_image)
			images.add (help_image)
		end

	build_data_table is
		indexing
			description: "Build `data_table'."
			external_name: "BuildDataTable"
		local
			type: SYSTEM_TYPE
		do
			create data_table.make_datatable_1 (dictionary.Data_table_title)
			
				-- Create table columns
			type := type_factory.GetType_String (dictionary.System_string_type);
			create assembly_name_column.make_datacolumn_2 (dictionary.Assembly_name_column_title, type)
			create assembly_version_column.make_datacolumn_2 (dictionary.Assembly_version_column_title, type)
			create assembly_culture_column.make_datacolumn_2 (dictionary.Assembly_culture_column_title, type)
			create assembly_public_key_column.make_datacolumn_2 (dictionary.Assembly_public_key_column_title, type)
			create dependancies_column.make_datacolumn_2 (dictionary.Dependancies_column_title, type)			

				-- Add columns to data table
			data_table.Columns.Add_DataColumn (assembly_name_column)
		end

	build_data_grid is
		indexing
			description: "Build `data_grid' and associate actions."
			external_name: "BuildDataGrid"
		local
			row: SYSTEM_DATA_DATAROW
			data_grid_table_style: SYSTEM_WINDOWS_FORMS_DATAGRIDTABLESTYLE		
			a_size: SYSTEM_DRAWING_SIZE
			a_point: SYSTEM_DRAWING_POINT
			added: INTEGER
			assembly: SYSTEM_REFLECTION_ASSEMBLY
			on_cell_delegate: SYSTEM_EVENTHANDLER
			a_color: SYSTEM_DRAWING_COLOR
		do
				-- Build data grid	
			create data_grid.make_datagrid
			data_grid.BeginInit
			data_grid.set_Visible (True)
			data_grid.set_captiontext (dictionary.Caption_text)
			create data_grid_font.make_font_10 (dictionary.Font_family_name, dictionary.Font_size, dictionary.Regular_style)
			data_grid.set_font (data_grid_font)
			
			a_size.set_width (dictionary.Window_width - dictionary.Margin // 2)
			a_size.set_height (dictionary.Window_height - 4 * dictionary.Row_height)
			data_grid.set_Size (a_size)
			set_height (dictionary.Window_height)
			
			a_point.set_x (0)
			a_point.set_y (toolbar.height)
			data_grid.set_location (a_point)
			data_grid.set_DataSource (data_table)
			data_grid.set_TabIndex (0)
			data_grid.EndInit 
			
				-- Table styles
			create assembly_name_column_style.make_datagridtextboxcolumn
			create assembly_version_column_style.make_datagridtextboxcolumn
			create assembly_culture_column_style.make_datagridtextboxcolumn
			create assembly_public_key_column_style.make_datagridtextboxcolumn
			create dependancies_column_style.make_datagridtextboxcolumn
			
				-- Set `MappingName'.
			assembly_name_column_style.set_mappingname (dictionary.Assembly_name_column_title)
			assembly_version_column_style.set_mappingname (dictionary.Assembly_version_column_title)
			assembly_culture_column_style.set_mappingname (dictionary.Assembly_culture_column_title)
			assembly_public_key_column_style.set_mappingname (dictionary.Assembly_public_key_column_title)
			dependancies_column_style.set_mappingname (dictionary.Dependancies_column_title)

				-- Set `HeaderText'.
			assembly_name_column_style.set_headertext (dictionary.Assembly_name_column_title)
			assembly_version_column_style.set_headertext (dictionary.Assembly_version_column_title)
			assembly_culture_column_style.set_headertext (dictionary.Assembly_culture_column_title)
			assembly_public_key_column_style.set_headertext (dictionary.Assembly_public_key_column_title)
			dependancies_column_style.set_headertext (dictionary.Dependancies_column_title)
			
				-- Set `width'.
			assembly_name_column_style.set_width (dictionary.Window_width)
			
				-- Set styles.
			create data_grid_table_style.make_datagridtablestyle_1 
			data_grid_table_style.set_backcolor (a_color.White)
			data_grid_table_style.set_PreferredColumnWidth (dictionary.Window_width // 6)
			data_grid_table_style.set_preferredrowheight (dictionary.Row_height)
			data_grid_table_style.set_readonly (True)
			data_grid_table_style.set_rowheadersvisible (False)
			data_grid_table_style.set_columnheadersvisible (True)
			data_grid_table_style.set_mappingname (dictionary.Data_table_title)
			data_grid_table_style.set_allowsorting (False)
			
			added := data_grid_table_style.gridcolumnstyles.add (assembly_name_column_style)
			added := data_grid_table_style.gridcolumnstyles.add (assembly_version_column_style)
			added := data_grid_table_style.gridcolumnstyles.add (assembly_culture_column_style)
			added := data_grid_table_style.gridcolumnstyles.add (assembly_public_key_column_style)
			added := data_grid_table_style.gridcolumnstyles.add (dependancies_column_style)
			
			if not data_grid.TableStyles.contains_datagridtablestyle (data_grid_table_style) then
				added := data_grid.TableStyles.Add (data_grid_table_style)
			end	

			create on_cell_delegate.make_eventhandler (Current, $on_cell)
			data_grid.add_currentcellchanged (on_cell_delegate)	
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
				name_menu_item.set_checked (not checked)
				name_toolbar_button.set_enabled (not checked)
				if checked and then columns.contains (dictionary.Assembly_name_column_title) then
					columns.remove_datacolumn (assembly_name_column)
					resize_columns
					refresh
				elseif not checked then
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
					resize_columns
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
				version_menu_item.set_checked (not checked)
				version_toolbar_button.set_enabled (not checked)
				if checked and then columns.contains (dictionary.Assembly_version_column_title) then
					columns.remove_datacolumn (assembly_version_column)
					resize_columns
					refresh
				elseif not checked then
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
					resize_columns
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
				culture_menu_item.set_checked (not checked)
				culture_toolbar_button.set_enabled (not checked)			
				if checked and then columns.contains (dictionary.Assembly_culture_column_title) then
					columns.remove_datacolumn (assembly_culture_column)
					resize_columns
					refresh
				elseif not checked then
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
					resize_columns
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
				public_key_menu_item.set_checked (not checked)
				public_key_toolbar_button.set_enabled (not checked)			
				if checked and then columns.contains (dictionary.Assembly_public_key_column_title) then
					columns.remove_datacolumn (assembly_public_key_column)
					resize_columns
					refresh
				elseif not checked then
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
					resize_columns
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
				dependancies_menu_item.set_checked (not checked)
				dependancies_toolbar_button.set_enabled (not checked)			
				if checked and then columns.contains (dictionary.Dependancies_column_title) then
					columns.remove_datacolumn (dependancies_column)
					resize_columns
					refresh
				elseif not checked then
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
					resize_columns
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
			name_menu_item.set_checked (True)
			version_menu_item.set_checked (True)
			culture_menu_item.set_checked (True)
			public_key_menu_item.set_checked (True)
			dependancies_menu_item.set_checked (True)
			
			name_toolbar_button.set_enabled (True)
			version_toolbar_button.set_enabled (True)
			culture_toolbar_button.set_enabled (True)
			public_key_toolbar_button.set_enabled (True)
			dependancies_toolbar_button.set_enabled (True)
			
			columns := data_table.columns
			columns.clear
			columns.add_datacolumn (assembly_name_column)
			columns.add_datacolumn (assembly_version_column)
			columns.add_datacolumn (assembly_culture_column)
			columns.add_datacolumn (assembly_public_key_column)
			columns.add_datacolumn (dependancies_column)		
			data_table.rows.clear
			display_assemblies
			set_default_column_width
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
		local
			columns: SYSTEM_DATA_DATACOLUMNCOLLECTION
		do
			name_menu_item.set_checked (True)
			version_menu_item.set_checked (False)
			culture_menu_item.set_checked (False)
			public_key_menu_item.set_checked (False)
			dependancies_menu_item.set_checked (False)
			
			name_toolbar_button.set_enabled (True)
			version_toolbar_button.set_enabled (False)
			culture_toolbar_button.set_enabled (False)
			public_key_toolbar_button.set_enabled (False)
			dependancies_toolbar_button.set_enabled (False)
			
			columns := data_table.columns
			columns.clear
			columns.add_datacolumn (assembly_name_column)	
			data_table.rows.clear
			display_assemblies
			assembly_name_column_style.set_width (dictionary.Window_width)
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
		do
			selected_row := data_grid.CurrentRowIndex
			a_descriptor := current_assembly (selected_row)
			if a_descriptor /= Void then
				create support
				assembly_dependancies := support.dependancies_from_info (a_descriptor)
				if assembly_dependancies /= Void then
					create import_dialog.make (a_descriptor, assembly_dependancies)
				end
			end
		end

	on_toolbar_button_clicked (sender: ANY; arguments: SYSTEM_WINDOWS_FORMS_TOOLBARBUTTONCLICKEVENTARGS) is
		indexing
			description: "Identify toolbar button and perform appropriate action."
			external_name: "OnToolBarButtonClicked"
		local
			index: INTEGER
		do
			index := toolbar.buttons.indexof (arguments.button) 
			inspect
				index
			when 0 then
				display_name (sender, create {SYSTEM_EVENTARGS}.make)
			when 1 then
				display_version (sender, create {SYSTEM_EVENTARGS}.make)
			when 2 then
				display_culture (sender, create {SYSTEM_EVENTARGS}.make)
			when 3 then
				display_public_key (sender, create {SYSTEM_EVENTARGS}.make)
			when 4 then
				display_dependancies (sender, create {SYSTEM_EVENTARGS}.make)
			when 6 then
				show_all (sender, create {SYSTEM_EVENTARGS}.make)
			when 7 then
				show_name (sender, create {SYSTEM_EVENTARGS}.make)
			when 9 then
				import (sender, create {SYSTEM_EVENTARGS}.make)
			when 11 then
				display_help (sender, create {SYSTEM_EVENTARGS}.make)
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
			sort_support.sort_assemblY_descriptors (shared_assemblies)
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
			row: SYSTEM_DATA_DATAROW
			columns: SYSTEM_DATA_DATACOLUMNCOLLECTION
			dependancies: ARRAY [SYSTEM_REFLECTION_ASSEMBLYNAME]
			support: SUPPORT
		do
			create support
			row := data_table.NewRow
			columns := data_table.columns
			data_table.rows.Add (row)
			row.Table.DefaultView.set_AllowEdit (False)
			row.Table.DefaultView.set_AllowNew (False)
			row.Table.DefaultView.set_AllowDelete (False)
			if columns.contains (dictionary.Assembly_name_column_title) then
				row.set_Item_String (dictionary.Assembly_name_column_title, a_descriptor.name)
			end
			if columns.contains (dictionary.Assembly_version_column_title) then
				row.set_Item_String (dictionary.Assembly_version_column_title, a_descriptor.version)
			end
			if columns.contains (dictionary.Assembly_culture_column_title) then
				row.set_Item_String (dictionary.Assembly_culture_column_title, a_descriptor.culture)
			end
			if columns.contains (dictionary.Assembly_public_key_column_title) then
				row.set_Item_String (dictionary.Assembly_public_key_column_title, a_descriptor.publickey)
			end			
			if dependancies_menu_item.checked then
				dependancies := support.dependancies_from_info (a_descriptor)
				if dependancies.count > 0 then
					row.set_Item_String (dictionary.Dependancies_column_title, support.dependancies_string (dependancies))
				else
					row.set_Item_String (dictionary.Dependancies_column_title, dictionary.No_dependancy)
				end
			end
		end

	build_empty_row (row_count: INTEGER) is 
		indexing
			description: "Build an empty row at index `row_count'."
			external_name: "BuildEmptyRow"
		local
			row: SYSTEM_DATA_DATAROW
		do
			row := data_table.NewRow
			data_table.Rows.Add (row)
			row.Table.DefaultView.set_AllowEdit (False)
			row.Table.DefaultView.set_AllowNew (False)
			row.Table.DefaultView.set_AllowDelete (False)
			if name_menu_item.checked then
				row.set_Item_String (dictionary.Assembly_name_column_title, dictionary.Empty_string)
			end
			if version_menu_item.checked then
				row.set_Item_String (dictionary.Assembly_version_column_title, dictionary.Empty_string)
			end
			if culture_menu_item.checked then
				row.set_Item_String (dictionary.Assembly_culture_column_title, dictionary.Empty_string)
			end
			if public_key_menu_item.checked then
				row.set_Item_String (dictionary.Assembly_public_key_column_title, dictionary.Empty_string)
			end			
			if dependancies_menu_item.checked then
				row.set_Item_String (dictionary.Dependancies_column_title, dictionary.Empty_string)
			end
		end	
		
	set_default_column_width is
		indexing
			description: "Set default column width according to the content."
			external_name: "SetDefaultColumnWidth"
		local
			resizing_support: RESIZING_SUPPORT
		do
			create resizing_support.make (data_grid_font)
			assembly_name_column_style.set_width (resizing_support.assembly_name_column_width_from_info (shared_assemblies))
			assembly_version_column_style.set_width (resizing_support.assembly_version_column_width_from_info (shared_assemblies))
			assembly_culture_column_style.set_width (resizing_support.assembly_culture_column_width_from_info (shared_assemblies))
			assembly_public_key_column_style.set_width (resizing_support.assembly_public_key_column_width_from_info (shared_assemblies))
			dependancies_column_style.set_width (resizing_support.dependancies_column_width_from_info (shared_assemblies))
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
			if total_width < dictionary.Window_width then
				if dependancies_menu_item.checked then
					current_width := dependancies_column_style.width
					dependancies_column_style.set_width (current_width + dictionary.Window_width - total_width)		
				elseif	public_key_menu_item.checked then
					current_width := assembly_public_key_column_style.width
					assembly_public_key_column_style.set_width (current_width + dictionary.Window_width - total_width)		
				elseif	culture_menu_item.checked then
					current_width := assembly_culture_column_style.width
					assembly_culture_column_style.set_width (current_width + dictionary.Window_width - total_width)		
				elseif	version_menu_item.checked then
					current_width := assembly_version_column_style.width
					assembly_version_column_style.set_width (current_width + dictionary.Window_width - total_width)		
				elseif	name_menu_item.checked then
					assembly_name_column_style.set_width (dictionary.Window_width)		
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
					returned_value := message_box.show (dictionary.Non_signed_assembly)
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
		do
			create gac_browser
			shared_assemblies := gac_browser.shared_assemblies
			sort_assemblies
			build_imported_table
		ensure then
			non_void_shared_assemblies: shared_assemblies /= Void
			non_void_imported_table: imported_table /= Void
		end
		
	update_gui is
		indexing
			description: "Update GUI."
			external_name: "UpdateGui"
		do
			build_assemblies
			data_table.rows.clear
			display_assemblies
			refresh
		end
		
end -- class IMPORT_TOOL