indexing
	description: "Assembly viewer (imported assemblies only)"
	external_name: "ISE.AssemblyManager.ImportedAssemblyViewer"

class
	IMPORTED_ASSEMBLY_VIEWER

inherit
	ASSEMBLY_VIEWER
		redefine
			dictionary
		end

create
	make

feature -- Access

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

	path_toolbar_button: SYSTEM_WINDOWS_FORMS_TOOLBARBUTTON
		indexing
			description: "Eiffel path toolbar button"
			external_name: "PathToolbarButton"
		end

	show_name_and_path_toolbar_button: SYSTEM_WINDOWS_FORMS_TOOLBARBUTTON
		indexing
			description: "Show name and path toolbar button"
			external_name: "ShowNameAndPathToolbarButton"
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
	
	imported_assemblies: SYSTEM_COLLECTIONS_ARRAYLIST
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_EIFFELASSEMBLY]
		indexing
			description: "Assemblies in Eiffel assembly cache"
			external_name: "ImportedAssemblies"
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
		do
			create notifier_handle.make1
			notifier := notifier_handle.currentnotifier
			create on_update_add_delegate.make_eventhandler (Current, $update_add)		
			notifier.addadditionobserver (on_update_add_delegate)
			create on_update_remove_delegate.make_eventhandler (Current, $update_remove)		
			notifier.addremoveobserver (on_update_remove_delegate)
		end
		
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
			create exit_menu_item.make_menuitem_1 (dictionary.Exit_menu_item)
			exit_menu_item.set_shortcut (dictionary.Ctrl_X_shortcut)
			added := file_menu_item.menuitems.add (exit_menu_item)
			
				-- Build View menu item.
			create name_menu_item.make_menuitem_1 (dictionary.Name_menu_item)
			create version_menu_item.make_menuitem_1 (dictionary.Version_menu_item)
			create culture_menu_item.make_menuitem_1 (dictionary.Culture_menu_item)
			create public_key_menu_item.make_menuitem_1 (dictionary.Public_key_menu_item)
			create path_menu_item.make_menuitem_1 (dictionary.Path_menu_item)			
			create dependancies_menu_item.make_menuitem_1 (dictionary.Dependancies_menu_item)
			create show_all_menu_item.make_menuitem_1 (dictionary.Show_all_menu_item)
			create show_name_and_path_menu_item.make_menuitem_1 (dictionary.Show_name_and_path_menu_item)
						
			name_menu_item.set_shortcut (dictionary.Ctrl_N_shortcut)
			version_menu_item.set_shortcut (dictionary.Ctrl_V_shortcut)
			culture_menu_item.set_shortcut (dictionary.Ctrl_C_shortcut)
			public_key_menu_item.set_shortcut (dictionary.Ctrl_K_shortcut)
			path_menu_item.set_shortcut (dictionary.Ctrl_P_shortcut)
			dependancies_menu_item.set_shortcut (dictionary.Ctrl_D_shortcut)
			show_all_menu_item.set_shortcut (dictionary.Ctrl_A_shortcut)
			show_name_and_path_menu_item.set_shortcut (dictionary.Ctrl_S_shortcut)
			
			name_menu_item.set_checked (True)
			version_menu_item.set_checked (False)
			culture_menu_item.set_checked (False)
			public_key_menu_item.set_checked (False)
			path_menu_item.set_checked (True)
			dependancies_menu_item.set_checked (False)

			added := view_menu_item.menuitems.add (name_menu_item)	
			added := view_menu_item.menuitems.add (version_menu_item)	
			added := view_menu_item.menuitems.add (culture_menu_item)	
			added := view_menu_item.menuitems.add (public_key_menu_item)	
			added := view_menu_item.menuitems.add (path_menu_item)	
			added := view_menu_item.menuitems.add (dependancies_menu_item)
			separator := view_menu_item.menuitems.add_string ("-")
			added := view_menu_item.menuitems.add (show_all_menu_item)	
			added := view_menu_item.menuitems.add (show_name_and_path_menu_item)	
			
				-- Build Tools menu item.
			create edit_menu_item.make_menuitem_1 (dictionary.Edit_menu_item)
			create remove_menu_item.make_menuitem_1 (dictionary.Remove_menu_item)
			create import_menu_item.make_menuitem_1 (dictionary.Import_menu_item)
			edit_menu_item.set_shortcut (dictionary.Ctrl_E_shortcut)
			remove_menu_item.set_shortcut (dictionary.Ctrl_R_shortcut)
			import_menu_item.set_shortcut (dictionary.Ctrl_I_shortcut)
			added := tools_menu_item.menuitems.add (edit_menu_item)
			added := tools_menu_item.menuitems.add (remove_menu_item)
			separator := tools_menu_item.menuitems.add_string ("-")
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
			exit_delegate: SYSTEM_EVENTHANDLER
			name_delegate: SYSTEM_EVENTHANDLER
			version_delegate: SYSTEM_EVENTHANDLER
			culture_delegate: SYSTEM_EVENTHANDLER
			public_key_delegate: SYSTEM_EVENTHANDLER
			path_delegate: SYSTEM_EVENTHANDLER
			dependancies_delegate: SYSTEM_EVENTHANDLER
			show_all_delegate: SYSTEM_EVENTHANDLER
			show_name_and_path_delegate: SYSTEM_EVENTHANDLER
			edit_delegate: SYSTEM_EVENTHANDLER
			remove_delegate: SYSTEM_EVENTHANDLER
			import_delegate: SYSTEM_EVENTHANDLER
			help_topics_delegate: SYSTEM_EVENTHANDLER
			about_delegate: SYSTEM_EVENTHANDLER		
		do
				-- File menu
			create exit_delegate.make_eventhandler (Current, $exit)
			exit_menu_item.add_click (exit_delegate)	
			
				-- View menu	
			create name_delegate.make_eventhandler (Current, $display_name)
			create version_delegate.make_eventhandler (Current, $display_version)
			create culture_delegate.make_eventhandler (Current, $display_culture)
			create public_key_delegate.make_eventhandler (Current, $display_public_key)
			create dependancies_delegate.make_eventhandler (Current, $display_dependancies)
			create path_delegate.make_eventhandler (Current, $display_path)
			create show_all_delegate.make_eventhandler (Current, $show_all)
			create show_name_and_path_delegate.make_eventhandler (Current, $show_name_and_path)
			name_menu_item.add_click (name_delegate)	
			version_menu_item.add_click (version_delegate)			
			culture_menu_item.add_click (culture_delegate)			
			public_key_menu_item.add_click (public_key_delegate)			
			dependancies_menu_item.add_click (dependancies_delegate)	
			path_menu_item.add_click (path_delegate)
			show_all_menu_item.add_click (show_all_delegate)
			show_name_and_path_menu_item.add_click (show_name_and_path_delegate)
			
				-- Tools menu
			create edit_delegate.make_eventhandler (Current, $edit)
			create remove_delegate.make_eventhandler (Current, $remove)
			create import_delegate.make_eventhandler (Current, $import)
			edit_menu_item.add_click (edit_delegate)
			remove_menu_item.add_click (remove_delegate)			
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
			create path_toolbar_button.make_toolbarbutton
			create dependancies_toolbar_button.make_toolbarbutton
			create show_all_toolbar_button.make_toolbarbutton
			create show_name_and_path_toolbar_button.make_toolbarbutton
			create edit_toolbar_button.make_toolbarbutton
			create remove_toolbar_button.make_toolbarbutton
			create import_toolbar_button.make_toolbarbutton
			create help_toolbar_button.make_toolbarbutton
			create separator.make_toolbarbutton
			
				-- Set icons to toolbar buttons.
			name_toolbar_button.set_imageindex (0)
			version_toolbar_button.set_imageindex (1)
			culture_toolbar_button.set_imageindex (2)
			public_key_toolbar_button.set_imageindex (3)
			path_toolbar_button.set_imageindex (4)
			dependancies_toolbar_button.set_imageindex (5)
			show_all_toolbar_button.set_imageindex (6)
			show_name_and_path_toolbar_button.set_imageindex (7)
			edit_toolbar_button.set_imageindex (8)
			remove_toolbar_button.set_imageindex (9)
			import_toolbar_button.set_imageindex (10)
			help_toolbar_button.set_imageindex (11)
			
				-- Set tooltips.
			name_toolbar_button.set_tooltiptext (dictionary.Name_menu_item)
			version_toolbar_button.set_tooltiptext (dictionary.Version_menu_item)
			culture_toolbar_button.set_tooltiptext (dictionary.Culture_menu_item)
			public_key_toolbar_button.set_tooltiptext (dictionary.Public_key_menu_item)
			path_toolbar_button.set_tooltiptext (dictionary.Path_menu_item)
			dependancies_toolbar_button.set_tooltiptext (dictionary.Dependancies_menu_item)
			show_all_toolbar_button.set_tooltiptext (dictionary.Show_all_menu_item)
			show_name_and_path_toolbar_button.set_tooltiptext (dictionary.Show_name_and_path_menu_item)
			edit_toolbar_button.set_tooltiptext (dictionary.Edit_menu_item)
			remove_toolbar_button.set_tooltiptext (dictionary.Remove_menu_item)
			import_toolbar_button.set_tooltiptext (dictionary.Import_menu_item)
			help_toolbar_button.set_tooltiptext (dictionary.Help_menu_item)
			
				-- Set button style.
			name_toolbar_button.set_style (dictionary.Toggle_button)
			version_toolbar_button.set_style (dictionary.Toggle_button)
			culture_toolbar_button.set_style (dictionary.Toggle_button)
			public_key_toolbar_button.set_style (dictionary.Toggle_button)
			path_toolbar_button.set_style (dictionary.Toggle_button)
			dependancies_toolbar_button.set_style (dictionary.Toggle_button)
			show_all_toolbar_button.set_style (dictionary.Push_button)
			show_name_and_path_toolbar_button.set_style (dictionary.Push_button)
			edit_toolbar_button.set_style (dictionary.Push_button)
			remove_toolbar_button.set_style (dictionary.Push_button)
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
			added := toolbar.buttons.add_toolbarbutton (path_toolbar_button)
			added := toolbar.buttons.add_toolbarbutton (dependancies_toolbar_button)
			added := toolbar.buttons.add_toolbarbutton (separator)
			added := toolbar.buttons.add_toolbarbutton (show_all_toolbar_button)
			added := toolbar.buttons.add_toolbarbutton (show_name_and_path_toolbar_button)
			added := toolbar.buttons.add_toolbarbutton (separator)
			added := toolbar.buttons.add_toolbarbutton (edit_toolbar_button)
			added := toolbar.buttons.add_toolbarbutton (remove_toolbar_button)
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
			path_image: SYSTEM_DRAWING_BITMAP
			dependancies_image: SYSTEM_DRAWING_BITMAP
			show_all_image: SYSTEM_DRAWING_BITMAP
			show_name_and_path_image: SYSTEM_DRAWING_BITMAP
			edit_image: SYSTEM_DRAWING_BITMAP
			remove_image: SYSTEM_DRAWING_BITMAP
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
			create path_image.make_bitmap (dictionary.Path_icon_filename)
			create dependancies_image.make_bitmap (dictionary.Dependancies_icon_filename)
			create show_all_image.make_bitmap (dictionary.Show_all_icon_filename)
			create show_name_and_path_image.make_bitmap (dictionary.Show_name_and_path_icon_filename)
			create edit_image.make_bitmap (dictionary.Edit_icon_filename)
			create remove_image.make_bitmap (dictionary.Remove_icon_filename)
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
			images.add (path_image)
			images.add (dependancies_image)
			images.add (show_all_image)
			images.add (show_name_and_path_image)
			images.add (edit_image)
			images.add (remove_image)
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
			create eiffel_path_column.make_datacolumn_2 (dictionary.Eiffel_path_column_title, type)			

				-- Add columns to data table
			data_table.Columns.Add_DataColumn (assembly_name_column)
			data_table.Columns.Add_DataColumn (eiffel_path_column)
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
			create eiffel_path_column_style.make_datagridtextboxcolumn
			
				-- Set `MappingName'.
			assembly_name_column_style.set_mappingname (dictionary.Assembly_name_column_title)
			assembly_version_column_style.set_mappingname (dictionary.Assembly_version_column_title)
			assembly_culture_column_style.set_mappingname (dictionary.Assembly_culture_column_title)
			assembly_public_key_column_style.set_mappingname (dictionary.Assembly_public_key_column_title)
			dependancies_column_style.set_mappingname (dictionary.Dependancies_column_title)
			eiffel_path_column_style.set_mappingname (dictionary.Eiffel_path_column_title)

				-- Set `HeaderText'.
			assembly_name_column_style.set_headertext (dictionary.Assembly_name_column_title)
			assembly_version_column_style.set_headertext (dictionary.Assembly_version_column_title)
			assembly_culture_column_style.set_headertext (dictionary.Assembly_culture_column_title)
			assembly_public_key_column_style.set_headertext (dictionary.Assembly_public_key_column_title)
			dependancies_column_style.set_headertext (dictionary.Dependancies_column_title)
			eiffel_path_column_style.set_headertext (dictionary.Eiffel_path_column_title)
			
				-- Set `width'.
			set_default_column_width
			
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
			added := data_grid_table_style.gridcolumnstyles.add (eiffel_path_column_style)
			
			if not data_grid.TableStyles.contains_datagridtablestyle (data_grid_table_style) then
				added := data_grid.TableStyles.Add (data_grid_table_style)
			end	

			create on_cell_delegate.make_eventhandler (Current, $on_cell)
			data_grid.add_currentcellchanged (on_cell_delegate)	
		end
		
feature -- Event handling

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
					if path_menu_item.checked then
						columns.add_datacolumn (eiffel_path_column)
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
					if path_menu_item.checked then
						columns.add_datacolumn (eiffel_path_column)
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
					if path_menu_item.checked then
						columns.add_datacolumn (eiffel_path_column)
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
					if path_menu_item.checked then
						columns.add_datacolumn (eiffel_path_column)
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
					if path_menu_item.checked then
						columns.add_datacolumn (eiffel_path_column)
					end	
					data_table.rows.clear
					display_assemblies
					resize_columns
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
				path_menu_item.set_checked (not checked)
				path_toolbar_button.set_enabled (not checked)			
				if checked and then columns.contains (dictionary.Eiffel_path_column_title) then
					columns.remove_datacolumn (eiffel_path_column)
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
					if dependancies_menu_item.checked then
						columns.add_datacolumn (dependancies_column)
					end					
					columns.add_datacolumn (eiffel_path_column)	
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
			path_menu_item.set_checked (True)
			
			name_toolbar_button.set_enabled (True)
			version_toolbar_button.set_enabled (True)
			culture_toolbar_button.set_enabled (True)
			public_key_toolbar_button.set_enabled (True)
			dependancies_toolbar_button.set_enabled (True)
			path_toolbar_button.set_enabled (True)
			
			columns := data_table.columns
			columns.clear
			columns.add_datacolumn (assembly_name_column)
			columns.add_datacolumn (assembly_version_column)
			columns.add_datacolumn (assembly_culture_column)
			columns.add_datacolumn (assembly_public_key_column)
			columns.add_datacolumn (dependancies_column)
			columns.add_datacolumn (eiffel_path_column)		
			data_table.rows.clear
			display_assemblies
			set_default_column_width
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
			name_menu_item.set_checked (True)
			version_menu_item.set_checked (False)
			culture_menu_item.set_checked (False)
			public_key_menu_item.set_checked (False)
			dependancies_menu_item.set_checked (False)
			path_menu_item.set_checked (True)
			
			name_toolbar_button.set_enabled (True)
			version_toolbar_button.set_enabled (False)
			culture_toolbar_button.set_enabled (False)
			public_key_toolbar_button.set_enabled (False)
			dependancies_toolbar_button.set_enabled (False)
			path_toolbar_button.set_enabled (True)
			
			columns := data_table.columns
			columns.clear
			columns.add_datacolumn (assembly_name_column)
			columns.add_datacolumn (eiffel_path_column)		
			data_table.rows.clear
			display_assemblies
			set_default_column_width
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
			a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			an_assembly: ISE_REFLECTION_EIFFELASSEMBLY
			a_type_list: SYSTEM_COLLECTIONS_ARRAYLIST
			assembly_view: ASSEMBLY_VIEW
			returned_value: INTEGER
			message_box: SYSTEM_WINDOWS_FORMS_MESSAGEBOX
		do
			returned_value := message_box.show (dictionary.Edit_type_message)
			selected_row := data_grid.CurrentRowIndex
			a_descriptor := current_assembly (selected_row)
			if a_descriptor /= Void then
				an_assembly := reflection_interface.assembly (a_descriptor)
				if an_assembly /= Void then
					a_type_list := an_assembly.types
					if a_type_list /= Void then
						create assembly_view.make (a_descriptor, a_type_list)
					end
				end
			end
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
		do
			create support
			selected_row := data_grid.CurrentRowIndex			
			a_descriptor := current_assembly (selected_row)
			if a_descriptor /= Void then
				assembly_dependancies := support.dependancies_from_info (a_descriptor)
				if assembly_dependancies /= Void then
					create remove_dialog.make (a_descriptor, assembly_dependancies)
				end
			end
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
		do
			create import_tool.make
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
			when 5 then
				display_path (sender, create {SYSTEM_EVENTARGS}.make)
			when 7 then
				show_all (sender, create {SYSTEM_EVENTARGS}.make)
			when 8 then
				show_name_and_path (sender, create {SYSTEM_EVENTARGS}.make)
			when 10 then
				edit (sender, create {SYSTEM_EVENTARGS}.make)
			when 11 then
				remove (sender, create {SYSTEM_EVENTARGS}.make)
			when 12 then
				import (sender, create {SYSTEM_EVENTARGS}.make)
			when 14 then
				display_help (sender, create {SYSTEM_EVENTARGS}.make)
			end
		end		

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

	build_assemblies is
		indexing
			description: "Build `imported_assemblies' and sort assemblies by assembly name."
			external_name: "BuildAssemblies"
		do
			imported_assemblies := reflection_interface.assemblies
			sort_assemblies
		ensure then
			non_void_imported_assemblies: imported_assemblies /= Void
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
			fill_data_grid
		end

	build_row (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR; row_count: INTEGER; eiffel_path: STRING) is 
		indexing
			description: "Build a row at index `row_count' and fill row with information from `a_descriptor' and `eiffel_path'."
			external_name: "BuildRow"
		require
			non_void_assembly_descriptor: a_descriptor /= Void
			positive_row_count: row_count >= 0
			non_void_eiffel_path: eiffel_path /= Void
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
			if path_menu_item.checked then
				row.set_Item_String (dictionary.Eiffel_path_column_title, eiffel_path)
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
			if path_menu_item.checked then
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
			create resizing_support.make (data_grid_font)
			assembly_name_column_style.set_width (resizing_support.assembly_name_column_width_from_assemblies (imported_assemblies))
			assembly_version_column_style.set_width (resizing_support.assembly_version_column_width_from_assemblies (imported_assemblies))
			assembly_culture_column_style.set_width (resizing_support.assembly_culture_column_width_from_assemblies (imported_assemblies))
			assembly_public_key_column_style.set_width (resizing_support.assembly_public_key_column_width_from_assemblies (imported_assemblies))
			dependancies_column_style.set_width (resizing_support.dependancies_column_width_from_assemblies (imported_assemblies))
			eiffel_path_column_style.set_width (resizing_support.eiffel_path_column_width (imported_assemblies))		
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
			if total_width < dictionary.Window_width then
				if path_menu_item.checked then
					current_width := eiffel_path_column_style.width
					eiffel_path_column_style.set_width (current_width + dictionary.Window_width - total_width)
				elseif	dependancies_menu_item.checked then
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
		
end -- class IMPORTED_ASSEMBLY_VIEWER