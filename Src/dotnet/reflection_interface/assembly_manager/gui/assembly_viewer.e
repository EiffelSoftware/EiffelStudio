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
				return_value := message_box.show_string_string_messageboxbuttons_messageboxicon (dictionary.Error_message, dictionary.Error_caption, dictionary.Ok_message_box_button, dictionary.Error_icon)
			end
		ensure
			non_void_reflection_interface: reflection_interface /= Void
		rescue
			retried := True
			retry
		end
		
feature -- Access
	
	dictionary: ASSEMBLY_VIEWER_DICTIONARY is
		indexing
			description: "Dictionary"
			external_name: "Dictionary"
		once
			create Result
		ensure
			dictionary_created: Result /= Void
		end

	imported_assemblies: SYSTEM_COLLECTIONS_ARRAYLIST
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_EIFFELASSEMBLY]
		indexing
			description: "Assemblies in Eiffel assembly cache"
			external_name: "ImportedAssemblies"
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

	dependancy_viewer_menu_item: SYSTEM_WINDOWS_FORMS_MENUITEM	
		indexing
			description: "Dependancy viewer menu item"
			external_name: "DependancyViewerMenuItem"
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

	dependancy_viewer_toolbar_button: SYSTEM_WINDOWS_FORMS_TOOLBARBUTTON
		indexing
			description: "Dependancy viewer toolbar button"
			external_name: "DependancyViewerToolbarButton"
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
	
	data_grid_table_style: SYSTEM_WINDOWS_FORMS_DATAGRIDTABLESTYLE
		indexing
			description: "Data grid table style"
			external_name: "DataGridTableStyle"
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
			on_resize_delegate: SYSTEM_EVENTHANDLER
		do
			set_enabled (True)
			set_text (dictionary.Title)
			a_size.set_width (dictionary.Window_width)
			a_size.set_height (dictionary.Window_height)
			set_size (a_size)
			--set_borderstyle (dictionary.Border_style)
			set_icon (dictionary.Assembly_manager_icon)

			build_menu
			set_menu_actions
			build_toolbar
			build_assemblies_table
			display_assemblies
			controls.Add (data_grid)

			create on_resize_delegate.make_eventhandler (Current, $on_resize)
			add_resize (on_resize_delegate)
		ensure
			non_void_menu: main_menu /= Void
			non_void_toolbar: toolbar /= Void
			non_void_data_table: data_table /= Void
			non_void_data_grid: data_grid /= Void
		end

	build_menu_assembly_viewer is
	--build_menu is
		indexing
			description: "Build ISE assembly manager menu."
			external_name: "BuildMenuAssemblyViewer"
			--external_name: "BuildMenu"
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
			
				-- Build View menu item.
			create name_menu_item.make_menuitem_1 (dictionary.Name_menu_item)
			create version_menu_item.make_menuitem_1 (dictionary.Version_menu_item)
			create culture_menu_item.make_menuitem_1 (dictionary.Culture_menu_item)
			create public_key_menu_item.make_menuitem_1 (dictionary.Public_key_menu_item)	
			create dependancies_menu_item.make_menuitem_1 (dictionary.Dependancies_menu_item)
			create show_all_menu_item.make_menuitem_1 (dictionary.Show_all_menu_item)
						
			name_menu_item.set_shortcut (dictionary.Ctrl_N_shortcut)
			version_menu_item.set_shortcut (dictionary.Ctrl_V_shortcut)
			culture_menu_item.set_shortcut (dictionary.Ctrl_C_shortcut)
			public_key_menu_item.set_shortcut (dictionary.Ctrl_K_shortcut)
			dependancies_menu_item.set_shortcut (dictionary.Ctrl_D_shortcut)
			show_all_menu_item.set_shortcut (dictionary.Ctrl_A_shortcut)
			
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
					
				-- Build Tools menu
			create dependancy_viewer_menu_item.make_menuitem_1 (dictionary.Dependancy_viewer_menu_item)
			dependancy_viewer_menu_item.set_shortcut (dictionary.Ctrl_D_shortcut)
			added := tools_menu_item.menuitems.add (dependancy_viewer_menu_item)
			separator := tools_menu_item.menuitems.add_string ("-")
			
				-- Build Help menu item.
			create help_topics_menu_item.make_menuitem_1 (dictionary.Help_topics_menu_item)
			create about_menu_item.make_menuitem_1 (dictionary.About_menu_item)
			help_topics_menu_item.set_shortcut (dictionary.Ctrl_H_shortcut)
			added := help_menu_item.menuitems.add (help_topics_menu_item)
			separator := help_menu_item.menuitems.add_string ("-")
			added := help_menu_item.menuitems.add (about_menu_item)			
				
			added := main_menu.menuitems.add (file_menu_item)
			added := main_menu.menuitems.add (view_menu_item)
			added := main_menu.menuitems.add (tools_menu_item)
			added := main_menu.menuitems.add (help_menu_item)
			set_menu (main_menu)
		end
	
	set_menu_actions_assembly_viewer is
		indexing
			description: "Set actions to `main_menu'."
			external_name: "SetMenuActionsAssemblyViewer"
		local
			exit_delegate: SYSTEM_EVENTHANDLER
			name_delegate: SYSTEM_EVENTHANDLER
			version_delegate: SYSTEM_EVENTHANDLER
			culture_delegate: SYSTEM_EVENTHANDLER
			public_key_delegate: SYSTEM_EVENTHANDLER
			dependancies_delegate: SYSTEM_EVENTHANDLER
			dependancy_viewer_delegate: SYSTEM_EVENTHANDLER
			show_all_delegate: SYSTEM_EVENTHANDLER
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
			create show_all_delegate.make_eventhandler (Current, $show_all)
			name_menu_item.add_click (name_delegate)	
			version_menu_item.add_click (version_delegate)			
			culture_menu_item.add_click (culture_delegate)			
			public_key_menu_item.add_click (public_key_delegate)			
			dependancies_menu_item.add_click (dependancies_delegate)	
			show_all_menu_item.add_click (show_all_delegate)
				
				-- Tools menu
			create dependancy_viewer_delegate.make_eventhandler (Current, $show_dependancy_viewer)
			dependancy_viewer_menu_item.add_click (dependancy_viewer_delegate)
			
				-- Help menu
			create help_topics_delegate.make_eventhandler (Current, $display_help)
			create about_delegate.make_eventhandler (Current, $about_assembly_manager)
			help_topics_menu_item.add_click (help_topics_delegate)
			about_menu_item.add_click (about_delegate)	
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

	build_toolbar_assembly_viewer is
		indexing
			description: "Build ISE assembly manager toolbar."
			external_name: "BuildToolbarAssemblyViewer"
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
			create dependancy_viewer_toolbar_button.make_toolbarbutton
			create help_toolbar_button.make_toolbarbutton
			create separator.make_toolbarbutton
			
				-- Set icons to toolbar buttons.
			name_toolbar_button.set_imageindex (0)
			version_toolbar_button.set_imageindex (1)
			culture_toolbar_button.set_imageindex (2)
			public_key_toolbar_button.set_imageindex (3)
			dependancies_toolbar_button.set_imageindex (4)
			dependancy_viewer_toolbar_button.set_imageindex (5)
			help_toolbar_button.set_imageindex (6)
			
				-- Set tooltips.
			name_toolbar_button.set_tooltiptext (dictionary.Name_menu_item)
			version_toolbar_button.set_tooltiptext (dictionary.Version_menu_item)
			culture_toolbar_button.set_tooltiptext (dictionary.Culture_menu_item)
			public_key_toolbar_button.set_tooltiptext (dictionary.Public_key_menu_item)
			dependancies_toolbar_button.set_tooltiptext (dictionary.Dependancies_menu_item)
			dependancy_viewer_toolbar_button.set_tooltiptext (dictionary.Dependancy_viewer_menu_item)
			help_toolbar_button.set_tooltiptext (dictionary.Help_menu_item)
			
				-- Set button style.
			name_toolbar_button.set_style (dictionary.Toggle_button)
			version_toolbar_button.set_style (dictionary.Toggle_button)
			culture_toolbar_button.set_style (dictionary.Toggle_button)
			public_key_toolbar_button.set_style (dictionary.Toggle_button)
			dependancies_toolbar_button.set_style (dictionary.Toggle_button)
			dependancy_viewer_toolbar_button.set_style (dictionary.Push_button)
			help_toolbar_button.set_style (dictionary.Push_button)
			separator.set_style (dictionary.Separator)
			
				-- Set visible
			name_toolbar_button.set_pushed (True)
			version_toolbar_button.set_pushed (False)
			culture_toolbar_button.set_pushed (False)
			public_key_toolbar_button.set_pushed (False)
			dependancies_toolbar_button.set_pushed (False)
			
				-- Add buttons to `toolbar'.
			added := toolbar.buttons.add_toolbarbutton (name_toolbar_button)
			added := toolbar.buttons.add_toolbarbutton (version_toolbar_button)
			added := toolbar.buttons.add_toolbarbutton (culture_toolbar_button)
			added := toolbar.buttons.add_toolbarbutton (public_key_toolbar_button)
			added := toolbar.buttons.add_toolbarbutton (dependancies_toolbar_button)
			controls.add (toolbar)
			
				-- Set action.
  			create toolbar_button_click_delegate.make_toolbarbuttonclickeventhandler (Current, $on_toolbar_button_clicked)
  			toolbar.add_buttonclick (toolbar_button_click_delegate)
		end

	build_image_list_assembly_viewer is
		indexing
			description: "Build toolbar image list."
			external_name: "BuildImageListAssemblyViewer"
		local
			resources: SYSTEM_RESOURCES_RESOURCEMANAGER
			name_icon: SYSTEM_DRAWING_ICON
			name_image: SYSTEM_DRAWING_IMAGE
			version_image: SYSTEM_DRAWING_IMAGE
			culture_image: SYSTEM_DRAWING_IMAGE
			public_key_image: SYSTEM_DRAWING_IMAGE
			dependancies_image: SYSTEM_DRAWING_IMAGE
			dependancy_viewer_image: SYSTEM_DRAWING_IMAGE
			help_image: SYSTEM_DRAWING_IMAGE	
			image_list: SYSTEM_WINDOWS_FORMS_IMAGELIST
			images: IMAGECOLLECTION_IN_SYSTEM_WINDOWS_FORMS_IMAGELIST 
		do
		--	create resources.make_2 (Current.GetType)
		--	name_icon ?= resources.getobject ("assembly_name_icon")
		--	 System.Resources.ResourceManager resources = new System.Resources.ResourceManager(typeof(ScrollBarCtl));
 		--	statusBarPanel1.Icon = (System.Drawing.Icon)resources.GetObject("statusBarPanel1.Icon");
 
				-- Create icons
			name_image := image_factory.fromfile (dictionary.Name_icon_filename)
			version_image := image_factory.fromfile (dictionary.Version_icon_filename)
			culture_image := image_factory.fromfile (dictionary.Culture_icon_filename)
			public_key_image := image_factory.fromfile (dictionary.Public_key_icon_filename)
			dependancies_image := image_factory.fromfile (dictionary.Dependancies_icon_filename)
			dependancy_viewer_image := image_factory.fromfile (dictionary.Dependancy_viewer_icon_filename)
			help_image := image_factory.fromfile (dictionary.Help_icon_filename)
			
				-- Add icons to `imagelist'.
			create image_list.make_imagelist
			toolbar.set_imagelist (image_list)
			images := image_list.images
			images.add (name_image)
			images.add (version_image)
			images.add (culture_image)
			images.add (public_key_image)
			images.add (dependancies_image)
			images.add (dependancy_viewer_image)
			images.add (help_image)
		end

	build_data_table_assembly_viewer is
		indexing
			description: "Build `data_table'."
			external_name: "BuildDataTableAssemblyViewer"
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

	build_data_grid_assembly_viewer is
		indexing
			description: "Build `data_grid' and associate actions."
			external_name: "BuildDataGridAssemblyViewer"
		local
			row: SYSTEM_DATA_DATAROW
			a_size: SYSTEM_DRAWING_SIZE
			a_point: SYSTEM_DRAWING_POINT
			added: INTEGER
			assembly: SYSTEM_REFLECTION_ASSEMBLY
			--on_cell_delegate: SYSTEM_EVENTHANDLER
			a_color: SYSTEM_DRAWING_COLOR
		do
				-- Build data grid	
			create data_grid.make_datagrid
			data_grid.BeginInit
			data_grid.set_Visible (True)
			create data_grid_font.make_font_10 (dictionary.Font_family_name, dictionary.Font_size, dictionary.Regular_style)
			data_grid.set_font (data_grid_font)
			
			if width /= Void and then width > 0 then
				a_size.set_width (width - dictionary.Margin // 2)
				a_size.set_height (height - 4 * dictionary.Row_height)				
			else
				a_size.set_width (dictionary.Window_width - dictionary.Margin // 2)
				a_size.set_height (dictionary.Window_height - 4 * dictionary.Row_height)
			end
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
			
			set_read_only_assembly_viewer
			
				-- Set styles.
			create data_grid_table_style.make_datagridtablestyle_1 
			data_grid_table_style.set_backcolor (a_color.White)
			data_grid_table_style.set_PreferredColumnWidth (dictionary.Window_width // 6)
			data_grid_table_style.set_preferredrowheight (dictionary.Row_height)
			data_grid_table_style.set_readonly (True)
			data_grid_table_style.set_selectionbackcolor (dictionary.White_color)
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

			--create on_cell_delegate.make_eventhandler (Current, $on_cell)			
			--data_grid.add_click (on_cell_delegate)				
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

	on_resize (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Resize window and its content."
			external_name: "OnResize"
		local
			a_size: SYSTEM_DRAWING_SIZE
		do
			a_size.set_width (width - dictionary.Margin // 2)
			a_size.set_height (height - 4 * dictionary.Row_height)
			data_grid.set_Size (a_size)			
			fill_data_grid
			resize_columns
			refresh
		end
		
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

	show_all_assembly_viewer (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Show all columns."
			external_name: "ShowAllAssemblyViewer"
		local
			columns: SYSTEM_DATA_DATACOLUMNCOLLECTION
		do
			name_menu_item.set_checked (True)
			version_menu_item.set_checked (True)
			culture_menu_item.set_checked (True)
			public_key_menu_item.set_checked (True)
			dependancies_menu_item.set_checked (True)
			
			name_toolbar_button.set_pushed (True)
			version_toolbar_button.set_pushed (True)
			culture_toolbar_button.set_pushed (True)
			public_key_toolbar_button.set_pushed (True)
			dependancies_toolbar_button.set_pushed (True)
			
			controls.remove (data_grid)
			build_assemblies_table
			columns := data_table.columns
			columns.clear
			columns.add_datacolumn (assembly_name_column)
			columns.add_datacolumn (assembly_version_column)
			columns.add_datacolumn (assembly_culture_column)
			columns.add_datacolumn (assembly_public_key_column)
			columns.add_datacolumn (dependancies_column)
		end

	show_name_assembly_viewer (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Show assembly name column only."
			external_name: "ShowNameAssemblyViewer"
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
			
			name_toolbar_button.set_pushed (True)
			version_toolbar_button.set_pushed (False)
			culture_toolbar_button.set_pushed (False)
			public_key_toolbar_button.set_pushed (False)
			dependancies_toolbar_button.set_pushed (False)
			
			controls.remove (data_grid)
			build_assemblies_table
			columns := data_table.columns
			columns.clear
			columns.add_datacolumn (assembly_name_column)	
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
				--TOC
			help.showhelp_control_string_helpnavigator (Current, help_filename, 2147483650)
		end
		
	about_assembly_manager (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Display general information about ISE assembly manager."
			external_name: "AboutAssemblyManager"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			about_dialog: ABOUT_DIALOG
		do
			create about_dialog.make
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

--	on_cell (sender: ANY; arguments: SYSTEM_EVENTARGS) is
--		indexing
--			description: "If selected cell is in the dependancies column then display dependancies"
--			external_name: "OnCell"
--		require
--			non_void_sender: sender /= Void
--			non_void_arguments: arguments /= Void
--		local
--			selected_row: INTEGER
--			selected_column: INTEGER
--			a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
--			assembly_dependancies: ARRAY [SYSTEM_REFLECTION_ASSEMBLYNAME]
--			dependancy_viewer: DEPENDANCY_VIEWER
--			on_close_delegate: SYSTEM_EVENTHANDLER
--			support: SUPPORT
--		do
--			if dependancies_menu_item.checked then
--				create support
--				selected_row := data_grid.CurrentRowIndex
--				if selected_row /= -1 then
--					if data_grid.CurrentCell /= Void and then data_grid.currentcell.columnnumber /= Void then
--						selected_column := data_grid.currentcell.columnnumber
--						a_descriptor := current_assembly (selected_row)	
--						if a_descriptor /= Void then
--							if selected_column = dictionary.Dependancies_column_number then
--								assembly_dependancies := support.dependancies_from_info (a_descriptor)
--								if assembly_dependancies /= Void and then assembly_dependancies.count > 0 then
--									create dependancy_viewer.make (a_descriptor, assembly_dependancies)
--								end
--							end
--						end
--					end
--				end
--			end
--		end

	show_dependancy_viewer (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "If selected cell is in the dependancies column then display dependancies"
			external_name: "ShowDependancyViewer"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			selected_row: INTEGER
			a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			assembly_dependancies: ARRAY [SYSTEM_REFLECTION_ASSEMBLYNAME]
			dependancy_viewer: DEPENDANCY_VIEWER
			support: SUPPORT
		do
			create support
			selected_row := data_grid.CurrentRowIndex
			if selected_row /= -1 then
				a_descriptor := current_assembly (selected_row)	
				if a_descriptor /= Void then
					assembly_dependancies := support.dependancies_from_info (a_descriptor)
					if assembly_dependancies /= Void and then assembly_dependancies.count > 0 then
						create dependancy_viewer.make (a_descriptor, assembly_dependancies)
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

	image_factory: SYSTEM_DRAWING_IMAGE
		indexing
			description: "Static needed to create an image"
			external_name: "ImageFactory"
		end
		
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

	empty_row (row_count: INTEGER): SYSTEM_DATA_DATAROW is 
		indexing
			description: "Build an empty row at index `row_count'."
			external_name: "EmptyRow"
		local
			columns: SYSTEM_DATA_DATACOLUMNCOLLECTION
		do
			columns := data_table.columns
			Result := data_table.NewRow			
			Result.Table.DefaultView.set_AllowEdit (False)
			Result.Table.DefaultView.set_AllowNew (False)
			Result.Table.DefaultView.set_AllowDelete (False)
			if columns.contains (dictionary.Assembly_name_column_title) then
				Result.set_Item_String (dictionary.Assembly_name_column_title, dictionary.Empty_string)
			end
			if columns.contains (dictionary.Assembly_version_column_title) then
				Result.set_Item_String (dictionary.Assembly_version_column_title, dictionary.Empty_string)
			end
			if columns.contains (dictionary.Assembly_culture_column_title) then
				Result.set_Item_String (dictionary.Assembly_culture_column_title, dictionary.Empty_string)
			end
			if columns.contains (dictionary.Assembly_public_key_column_title) then
				Result.set_Item_String (dictionary.Assembly_public_key_column_title, dictionary.Empty_string)
			end			
			if columns.contains (dictionary.Dependancies_column_title) then
				Result.set_Item_String (dictionary.Dependancies_column_title, dictionary.Empty_string)
			end
			data_table.Rows.Add (Result)
		end	
		
	current_assembly (row_number: INTEGER): ISE_REFLECTION_ASSEMBLYDESCRIPTOR is
		indexing
			description: "Assembly descriptor corresponding to row at index `row_number'"
			external_name: "CurrentAssembly"
		require
			valid_row_number: row_number > -1 and row_number < data_table.rows.count
		deferred
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
			retried: BOOLEAN
		do
			if not retried then
				rows := data_table.rows
				if (rows.count + 3) * dictionary.Row_height < height - 4 * dictionary.Row_height then
					difference := height - 4 * dictionary.Row_height - (rows.count + 3) * dictionary.Row_height
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
		rescue
			retried := True
			retry
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

	set_read_only is
		indexing
			description: "Set read-only property to each column of the data grid."
			external_name: "SetReadOnly"
		deferred
		end

	set_read_only_assembly_viewer is
		indexing
			description: "Set read-only property to each column of the data grid."
			external_name: "SetReadOnlyAssemblyViewer"
		do
			assembly_name_column_style.set_readonly (True)
			assembly_version_column_style.set_readonly (True)
			assembly_culture_column_style.set_readonly (True)
			assembly_public_key_column_style.set_readonly (True)
			dependancies_column_style.set_readonly (True)
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

	update_gui_assembly_viewer is
		indexing
			description: "Update GUI."
			external_name: "UpdateGuiAssemblyViewer"
		local
			columns: SYSTEM_DATA_DATACOLUMNCOLLECTION
		do
			build_assemblies
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

	new_row (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR; row_count: INTEGER): SYSTEM_DATA_DATAROW is 
		indexing
			description: "Build a row at index `row_count' and fill row with information from `a_descriptor'."
			external_name: "NewRow"
		require
			non_void_assembly_descriptor: a_descriptor /= Void
			positive_row_count: row_count >= 0
		local
			columns: SYSTEM_DATA_DATACOLUMNCOLLECTION
			dependancies: ARRAY [SYSTEM_REFLECTION_ASSEMBLYNAME]
			support: SUPPORT
		do
			create support
			Result := data_table.NewRow
			columns := data_table.columns			
			Result.Table.DefaultView.set_AllowEdit (False)
			Result.Table.DefaultView.set_AllowNew (False)
			Result.Table.DefaultView.set_AllowDelete (False)
			if columns.contains (dictionary.Assembly_name_column_title) then
				Result.set_Item_String (dictionary.Assembly_name_column_title, a_descriptor.name)
			end
			if columns.contains (dictionary.Assembly_version_column_title) then
				Result.set_Item_String (dictionary.Assembly_version_column_title, a_descriptor.version)
			end
			if columns.contains (dictionary.Assembly_culture_column_title) then
				Result.set_Item_String (dictionary.Assembly_culture_column_title, a_descriptor.culture)
			end
			if columns.contains (dictionary.Assembly_public_key_column_title) then
				Result.set_Item_String (dictionary.Assembly_public_key_column_title, a_descriptor.publickey)
			end			
			if columns.contains (dictionary.Dependancies_column_title) then
				dependancies := support.dependancies_from_info (a_descriptor)
				if dependancies.count > 0 then
					Result.set_Item_String (dictionary.Dependancies_column_title, support.dependancies_string (dependancies))
				else
					Result.set_Item_String (dictionary.Dependancies_column_title, dictionary.No_dependancy)
				end
			end
			data_table.rows.Add (Result)
		end
		
end -- class ASSEMBLY_VIEWER