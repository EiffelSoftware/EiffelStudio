indexing
	description: "Assembly viewer (imported assemblies only)"
	external_name: "ISE.AssemblyManager.AssemblyViewer"

deferred class
	ASSEMBLY_VIEWER

inherit
	ASSMEBLY_MANAGER_SUPPORT [STRING]

feature {NONE} -- Initialization

	make is
		indexing
			description: "Initialize attributes, register to subject and initialize GUI."
			external_name: "Make"
		local
			return_value: WINFORMS_DIALOG_RESULT
			message_box_buttons: WINFORMS_MESSAGE_BOX_BUTTONS
			message_box_icon: WINFORMS_MESSAGE_BOX_ICON
			message_box: WINFORMS_MESSAGE_BOX
			retried: BOOLEAN
		do
			create main_win.make_winforms_form
			if not retried then
				prepare_gui
				initialize_gui
				return_value := main_win.show_dialog
			else
				return_value := message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Error_message.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
			end
		ensure
			non_void_reflection_interface: reflection_interface /= Void
		rescue
			retried := True
			retry
		end
		
feature -- Access

	main_win: WINFORMS_FORM
	
	dictionary: ASSEMBLY_VIEWER_DICTIONARY is
		indexing
			description: "Dictionary"
			external_name: "Dictionary"
		once
			create Result
		ensure
			dictionary_created: Result /= Void
		end

	imported_assemblies: LINKED_LIST [EIFFEL_ASSEMBLY]
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [EIFFELASSEMBLY]
		indexing
			description: "Assemblies in Eiffel assembly cache"
			external_name: "ImportedAssemblies"
		end
		
	main_menu: WINFORMS_MAIN_MENU	
		indexing
			description: "Menu"
			external_name: "MainMenu"
		end

	file_menu_item: WINFORMS_MENU_ITEM
		indexing
			description: "File menu item"
			external_name: "FileMenuItem"
		end
		
	exit_menu_item: WINFORMS_MENU_ITEM
		indexing
			description: "Exit menu item"
			external_name: "ExitMenuItem"
		end
		
	view_menu_item: WINFORMS_MENU_ITEM
		indexing
			description: "View menu item"
			external_name: "ViewMenuItem"
		end
		
	name_menu_item: WINFORMS_MENU_ITEM
		indexing
			description: "Assembly name menu item"
			external_name: "NameMenuItem"
		end
		
	version_menu_item: WINFORMS_MENU_ITEM
		indexing
			description: "Assembly version menu item"
			external_name: "VersionMenuItem"
		end
		
	culture_menu_item: WINFORMS_MENU_ITEM
		indexing
			description: "Assembly culture menu item"
			external_name: "CultureMenuItem"
		end
		
	public_key_menu_item: WINFORMS_MENU_ITEM
		indexing
			description: "Assembly public key menu item"
			external_name: "PublicKeyMenuItem"
		end
		
	show_all_menu_item: WINFORMS_MENU_ITEM
		indexing
			description: "`Show all' menu item"
			external_name: "ShowAllMenuItem"
		end
		
	dependancies_menu_item: WINFORMS_MENU_ITEM	
		indexing
			description: "Dependancies menu item"
			external_name: "DependanciesMenuItem"
		end
	
	tools_menu_item: WINFORMS_MENU_ITEM
		indexing
			description: "Tools menu item"
			external_name: "ToolsMenuItem"
		end

	dependancy_viewer_menu_item: WINFORMS_MENU_ITEM	
		indexing
			description: "Dependancy viewer menu item"
			external_name: "DependancyViewerMenuItem"
		end
		
	import_menu_item: WINFORMS_MENU_ITEM
		indexing
			description: "Import menu item"
			external_name: "ImportMenuItem"
		end
		
	help_menu_item: WINFORMS_MENU_ITEM
		indexing
			description: "Help menu item"
			external_name: "HelpMenuItem"
		end
		
	help_topics_menu_item: WINFORMS_MENU_ITEM
		indexing
			description: "Help topics menu item"
			external_name: "HelpTopicsMenuItem"
		end
		
	about_menu_item: WINFORMS_MENU_ITEM
		indexing
			description: "About ISE assembly manager menu item"
			external_name: "AboutMenuItem"
		end
		
	toolbar: WINFORMS_TOOL_BAR
		indexing
			description: "Toolbar"
			external_name: "Toolbar"
		end	
		
	name_toolbar_button: WINFORMS_TOOL_BAR_BUTTON
		indexing
			description: "Assembly name toolbar button"
			external_name: "NameToolbarButton"
		end
		
	version_toolbar_button: WINFORMS_TOOL_BAR_BUTTON
		indexing
			description: "Assembly version toolbar button"
			external_name: "VersionToolbarButton"
		end
		
	culture_toolbar_button: WINFORMS_TOOL_BAR_BUTTON
		indexing
			description: "Assembly culture toolbar button"
			external_name: "CultureToolbarButton"
		end
		
	public_key_toolbar_button: WINFORMS_TOOL_BAR_BUTTON
		indexing
			description: "Assembly public key toolbar button"
			external_name: "PublicKeyToolbarButton"
		end
				
	dependancies_toolbar_button: WINFORMS_TOOL_BAR_BUTTON
		indexing
			description: "Dependancies toolbar button"
			external_name: "DependanciesToolbarButton"
		end

	import_toolbar_button: WINFORMS_TOOL_BAR_BUTTON
		indexing
			description: "Import toolbar button"
			external_name: "ImportToolbarButton"
		end

	dependancy_viewer_toolbar_button: WINFORMS_TOOL_BAR_BUTTON
		indexing
			description: "Dependancy viewer toolbar button"
			external_name: "DependancyViewerToolbarButton"
		end
		
	help_toolbar_button: WINFORMS_TOOL_BAR_BUTTON
		indexing
			description: "Help toolbar button"
			external_name: "HelpToolbarButton"
		end
		
	assembly_name_column_style: WINFORMS_DATA_GRID_TEXT_BOX_COLUMN
		indexing
			description: "Assembly name column style"
			external_name: "AssemblyNameColumnStyle"
		end
		
	assembly_version_column_style: WINFORMS_DATA_GRID_TEXT_BOX_COLUMN
		indexing
			description: "Assembly versopm column style"
			external_name: "AssemblyVersionColumnStyle"
		end
		
	assembly_culture_column_style: WINFORMS_DATA_GRID_TEXT_BOX_COLUMN
		indexing
			description: "Assembly culture column style"
			external_name: "AssemblyCultureColumnStyle"
		end
		
	assembly_public_key_column_style: WINFORMS_DATA_GRID_TEXT_BOX_COLUMN
		indexing
			description: "Assembly public key column style"
			external_name: "AssemblyPublicKeyColumnStyle"
		end
		
	dependancies_column_style: WINFORMS_DATA_GRID_TEXT_BOX_COLUMN
		indexing
			description: "Dependancies column style"
			external_name: "DependanciesColumnStyle"
		end
		
	reflection_interface: REFLECTION_INTERFACE	
		indexing
			description: "Reflection interface"
			external_name: "ReflectionInterface"
		end
		
	data_grid: WINFORMS_DATA_GRID
		indexing
			description: "Data grid associated with `data_table'"
			external_name: "DataGrid"
		end
				
	data_table: DATA_DATA_TABLE
		indexing
			description: "Data table"
			external_name: "DataTable"
		end
	
	assembly_name_column: DATA_DATA_COLUMN
		indexing
			description: "Assembly name column"
			external_name: "AssemblyNameColumn"
		end

	assembly_version_column: DATA_DATA_COLUMN
		indexing
			description: "Assembly version column"
			external_name: "AssemblyVersionColumn"
		end

	assembly_culture_column: DATA_DATA_COLUMN
		indexing
			description: "Assembly culture column"
			external_name: "AssemblyCultureColumn"
		end

	assembly_public_key_column: DATA_DATA_COLUMN
		indexing
			description: "Assembly public_key column"
			external_name: "AssemblyPublicKeyColumn"
		end
		
	dependancies_column: DATA_DATA_COLUMN
		indexing
			description: "Dependancies column"
			external_name: "DependanciesColumn"
		end
	
	data_grid_font: DRAWING_FONT
		indexing
			description: "Data grid font"
			external_name: "DataGridFont"
		end
	
	data_grid_table_style: WINFORMS_DATA_GRID_TABLE_STYLE
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
			reflection_interface := create {REFLECTION_INTERFACE}.make_reflection_interface
			build_assemblies	
		ensure
			non_void_reflection_interface: reflection_interface /= Void
		end
		
	initialize_gui is
		indexing
			description: "Initialize ISE assembly viewer window."
			external_name: "InitializeGui"
		local
			a_size: DRAWING_SIZE
			on_resize_delegate: EVENT_HANDLER
			retried: BOOLEAN
			returned_value: WINFORMS_DIALOG_RESULT
			message_box_buttons: WINFORMS_MESSAGE_BOX_BUTTONS
			message_box_icon: WINFORMS_MESSAGE_BOX_ICON 
			windows_message_box: WINFORMS_MESSAGE_BOX	
		do
			main_win.set_enabled (True)
			main_win.set_text (dictionary.Title.to_cil)
			a_size.set_width (dictionary.Window_width)
			a_size.set_height (dictionary.Window_height)
			main_win.set_size (a_size)
			if not retried then
				main_win.set_icon (dictionary.Assembly_manager_icon)
			else
				returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Pixmap_not_found_error.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
			end

			build_menu
			set_menu_actions
			build_toolbar
			build_assemblies_table
			display_assemblies
			main_win.get_controls.add (data_grid)

			create on_resize_delegate.make_event_handler (Current, $on_resize_action)
			main_win.add_resize (on_resize_delegate)
			
			fill_data_grid
		ensure
			non_void_menu: main_menu /= Void
			non_void_toolbar: toolbar /= Void
			non_void_data_table: data_table /= Void
			non_void_data_grid: data_grid /= Void
		rescue
			retried := True
			retry
		end

	build_menu_assembly_viewer is
	--build_menu is
		indexing
			description: "Build ISE assembly manager menu."
			external_name: "BuildMenuAssemblyViewer"
			--external_name: "BuildMenu"
		local
			added: INTEGER
			separator: WINFORMS_MENU_ITEM
			shortcut: WINFORMS_SHORTCUT
		do
				-- Build menu.
			create main_menu.make_winforms_main_menu
			create file_menu_item.make_winforms_menu_item_1 (dictionary.File_menu_item.to_cil)
			create view_menu_item.make_winforms_menu_item_1 (dictionary.View_menu_item.to_cil)
			create tools_menu_item.make_winforms_menu_item_1 (dictionary.Tools_menu_item.to_cil)
			create help_menu_item.make_winforms_menu_item_1 (dictionary.Help_menu_item.to_cil)
				
				-- Build File menu item.
			create exit_menu_item.make_winforms_menu_item_1 (dictionary.Exit_menu_item.to_cil)
			exit_menu_item.set_shortcut (shortcut.Ctrl_X)
			
				-- Build View menu item.
			create name_menu_item.make_winforms_menu_item_1 (dictionary.Name_menu_item.to_cil)
			create version_menu_item.make_winforms_menu_item_1 (dictionary.Version_menu_item.to_cil)
			create culture_menu_item.make_winforms_menu_item_1 (dictionary.Culture_menu_item.to_cil)
			create public_key_menu_item.make_winforms_menu_item_1 (dictionary.Public_key_menu_item.to_cil)	
			create dependancies_menu_item.make_winforms_menu_item_1 (dictionary.Dependancies_menu_item.to_cil)
			create show_all_menu_item.make_winforms_menu_item_1 (dictionary.Show_all_menu_item.to_cil)
						
			name_menu_item.set_shortcut (shortcut.Ctrl_N)
			version_menu_item.set_shortcut (shortcut.Ctrl_R)
			culture_menu_item.set_shortcut (shortcut.Ctrl_U)
			public_key_menu_item.set_shortcut (shortcut.Ctrl_K)
			dependancies_menu_item.set_shortcut (shortcut.Ctrl_D)
			show_all_menu_item.set_shortcut (shortcut.Ctrl_A)
			
			name_menu_item.set_checked (True)
			version_menu_item.set_checked (False)
			culture_menu_item.set_checked (False)
			public_key_menu_item.set_checked (False)
			dependancies_menu_item.set_checked (False)

			added := view_menu_item.get_menu_items.add_menu_item (name_menu_item)	
			added := view_menu_item.get_menu_items.add_menu_item (version_menu_item)	
			added := view_menu_item.get_menu_items.add_menu_item (culture_menu_item)	
			added := view_menu_item.get_menu_items.add_menu_item (public_key_menu_item)				
			added := view_menu_item.get_menu_items.add_menu_item (dependancies_menu_item)
					
				-- Build Tools menu
			create dependancy_viewer_menu_item.make_winforms_menu_item_1 (dictionary.Dependancy_viewer_menu_item.to_cil)
			dependancy_viewer_menu_item.set_shortcut (shortcut.Ctrl_D)
			added := tools_menu_item.get_menu_items.add_menu_item (dependancy_viewer_menu_item)
			separator := tools_menu_item.get_menu_items.add (("-").to_cil)
			
				-- Build Help menu item.
			create help_topics_menu_item.make_winforms_menu_item_1 (dictionary.Help_topics_menu_item.to_cil)
			create about_menu_item.make_winforms_menu_item_1 (dictionary.About_menu_item.to_cil)
			help_topics_menu_item.set_shortcut (shortcut.Ctrl_H)
			added := help_menu_item.get_menu_items.add_menu_item (help_topics_menu_item)
			separator := help_menu_item.get_menu_items.add (("-").to_cil)
			added := help_menu_item.get_menu_items.add_menu_item (about_menu_item)			
				
			added := main_menu.get_menu_items.add_menu_item (file_menu_item)
			added := main_menu.get_menu_items.add_menu_item (view_menu_item)
			added := main_menu.get_menu_items.add_menu_item (tools_menu_item)
			added := main_menu.get_menu_items.add_menu_item (help_menu_item)
			main_win.set_menu (main_menu)
		end
	
	set_menu_actions_assembly_viewer is
		indexing
			description: "Set actions to `main_menu'."
			external_name: "SetMenuActionsAssemblyViewer"
		local
			exit_delegate: EVENT_HANDLER
			name_delegate: EVENT_HANDLER
			version_delegate: EVENT_HANDLER
			culture_delegate: EVENT_HANDLER
			public_key_delegate: EVENT_HANDLER
			dependancies_delegate: EVENT_HANDLER
			dependancy_viewer_delegate: EVENT_HANDLER
			show_all_delegate: EVENT_HANDLER
			help_topics_delegate: EVENT_HANDLER
			about_delegate: EVENT_HANDLER		
		do
				-- File menu
			create exit_delegate.make_event_handler (Current, $exit)
			exit_menu_item.add_click (exit_delegate)	
			
				-- View menu	
			create name_delegate.make_event_handler (Current, $display_name)
			create version_delegate.make_event_handler (Current, $display_version)
			create culture_delegate.make_event_handler (Current, $display_culture)
			create public_key_delegate.make_event_handler (Current, $display_public_key)
			create dependancies_delegate.make_event_handler (Current, $display_dependancies)
			create show_all_delegate.make_event_handler (Current, $show_all)
			name_menu_item.add_click (name_delegate)	
			version_menu_item.add_click (version_delegate)			
			culture_menu_item.add_click (culture_delegate)			
			public_key_menu_item.add_click (public_key_delegate)			
			dependancies_menu_item.add_click (dependancies_delegate)	
			show_all_menu_item.add_click (show_all_delegate)
				
				-- Tools menu
			create dependancy_viewer_delegate.make_event_handler (Current, $show_dependancy_viewer)
			dependancy_viewer_menu_item.add_click (dependancy_viewer_delegate)
			
				-- Help menu
			create help_topics_delegate.make_event_handler (Current, $display_help)
			create about_delegate.make_event_handler (Current, $about_assembly_manager)
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
			external_name: "Buildimage_list"
		require
			non_void_toolbar: toolbar /= Void
		deferred
		end

	build_toolbar_assembly_viewer is
		indexing
			description: "Build ISE assembly manager toolbar."
			external_name: "BuildToolbarAssemblyViewer"
		local
			added: INTEGER
			separator: WINFORMS_TOOL_BAR_BUTTON
			toolbar_button_click_delegate: WINFORMS_TOOL_BAR_BUTTON_CLICK_EVENT_HANDLER
			appearance: WINFORMS_TOOL_BAR_APPEARANCE
			style: WINFORMS_TOOL_BAR_BUTTON_STYLE
			a_size: DRAWING_SIZE
			retried: BOOLEAN
		do
			create toolbar.make_winforms_tool_bar
			toolbar.set_appearance (appearance.Flat)
			--toolbar.set_auto_size (True)
			a_size.set_width (main_win.get_width)
			a_size.set_height (32)
			toolbar.set_size (a_size)
			
			if not retried then
				build_image_list
			end
			
				-- Create toolbar buttons.
			create name_toolbar_button.make_winforms_tool_bar_button
			create version_toolbar_button.make_winforms_tool_bar_button
			create culture_toolbar_button.make_winforms_tool_bar_button
			create public_key_toolbar_button.make_winforms_tool_bar_button
			create dependancies_toolbar_button.make_winforms_tool_bar_button
			create dependancy_viewer_toolbar_button.make_winforms_tool_bar_button
			create help_toolbar_button.make_winforms_tool_bar_button
			create separator.make_winforms_tool_bar_button
			
				-- Set icons to toolbar buttons.
			if not retried then
				name_toolbar_button.set_image_index (0)
				version_toolbar_button.set_image_index (1)
				culture_toolbar_button.set_image_index (2)
				public_key_toolbar_button.set_image_index (3)
				dependancies_toolbar_button.set_image_index (4)
				dependancy_viewer_toolbar_button.set_image_index (5)
				help_toolbar_button.set_image_index (6)
			end
			
				-- Set tooltips.
			name_toolbar_button.set_tool_tip_text (dictionary.Name_menu_item.to_cil)
			version_toolbar_button.set_tool_tip_text (dictionary.Version_menu_item.to_cil)
			culture_toolbar_button.set_tool_tip_text (dictionary.Culture_menu_item.to_cil)
			public_key_toolbar_button.set_tool_tip_text (dictionary.Public_key_menu_item.to_cil)
			dependancies_toolbar_button.set_tool_tip_text (dictionary.Dependancies_menu_item.to_cil)
			dependancy_viewer_toolbar_button.set_tool_tip_text (dictionary.Dependancy_viewer_menu_item.to_cil)
			help_toolbar_button.set_tool_tip_text (dictionary.Help_menu_item.to_cil)
			
				-- Set button style.
			name_toolbar_button.set_style (style.Toggle_button)
			version_toolbar_button.set_style (style.Toggle_button)
			culture_toolbar_button.set_style (style.Toggle_button)
			public_key_toolbar_button.set_style (style.Toggle_button)
			dependancies_toolbar_button.set_style (style.Toggle_button)
			dependancy_viewer_toolbar_button.set_style (style.Push_button)
			help_toolbar_button.set_style (style.Push_button)
			separator.set_style (style.Separator)
			
				-- Set visible
			name_toolbar_button.set_pushed (True)
			version_toolbar_button.set_pushed (False)
			culture_toolbar_button.set_pushed (False)
			public_key_toolbar_button.set_pushed (False)
			dependancies_toolbar_button.set_pushed (False)
			
				-- Add buttons to `toolbar'.
			added := toolbar.get_buttons.add_tool_bar_button (name_toolbar_button)
			added := toolbar.get_buttons.add_tool_bar_button (version_toolbar_button)
			added := toolbar.get_buttons.add_tool_bar_button (culture_toolbar_button)
			added := toolbar.get_buttons.add_tool_bar_button (public_key_toolbar_button)
			added := toolbar.get_buttons.add_tool_bar_button (dependancies_toolbar_button)
			main_win.get_controls.add (toolbar)
			
				-- Set action.
  			create toolbar_button_click_delegate.make_winforms_tool_bar_button_click_event_handler (Current, $on_toolbar_button_clicked)
  			toolbar.add_button_click (toolbar_button_click_delegate)
  		rescue
  			retried := True
  			retry
		end

	build_image_list_assembly_viewer is
		indexing
			description: "Build toolbar image list."
			external_name: "Buildimage_listAssemblyViewer"
		local
			resources: RESOURCE_MANAGER
			name_icon: DRAWING_ICON
			name_image: DRAWING_IMAGE
			version_image: DRAWING_IMAGE
			culture_image: DRAWING_IMAGE
			public_key_image: DRAWING_IMAGE
			dependancies_image: DRAWING_IMAGE
			dependancy_viewer_image: DRAWING_IMAGE
			help_image: DRAWING_IMAGE	
			image_list: WINFORMS_IMAGE_LIST 
			images: WINFORMS_IMAGE_COLLECTION_IN_WINFORMS_IMAGE_LIST
			retried: BOOLEAN
			returned_value: WINFORMS_DIALOG_RESULT
			message_box_buttons: WINFORMS_MESSAGE_BOX_BUTTONS
			message_box_icon: WINFORMS_MESSAGE_BOX_ICON 
			windows_message_box: WINFORMS_MESSAGE_BOX
			file: PLAIN_TEXT_FILE
			added: INTEGER
		do
		--	create resources.make_2 (Current.Get_Type)
		--	name_icon ?= resources.getobject ("assembly_name_icon")
		--	 System.Resources.ResourceManager resources = new System.Resources.ResourceManager(typeof(ScrollBarCtl));
 		--	statusBarPanel1.Icon = (System.Drawing.Icon)resources.GetObject("statusBarPanel1.Icon");
 
				-- Create icons
			if not retried then
				create file.make (dictionary.Name_icon_filename)
				
				if file.exists then
					name_image := image_factory.from_file (dictionary.Name_icon_filename.to_cil)
				else
					returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Name_icon_not_found_error.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
				end
				
				file.reset (dictionary.Version_icon_filename)
				if file.exists then
					version_image := image_factory.from_file (dictionary.Version_icon_filename.to_cil)
				else
					returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Version_icon_not_found_error.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
				end
				
				file.reset (dictionary.Culture_icon_filename)
				if file.exists  then
					culture_image := image_factory.from_file (dictionary.Culture_icon_filename.to_cil)				
				else
					returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Culture_icon_not_found_error.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
				end
				
				file.reset (dictionary.Public_key_icon_filename)
				if file.exists  then
					public_key_image := image_factory.from_file (dictionary.Public_key_icon_filename.to_cil)
				else
					returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Public_key_icon_not_found_error.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
				end
				
				file.reset (dictionary.Dependancies_icon_filename)
				if file.exists then
					dependancies_image := image_factory.from_file (dictionary.Dependancies_icon_filename.to_cil)
				else
					returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Dependencies_icon_not_found_error.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
				end
				
				file.reset (dictionary.Dependancy_viewer_icon_filename)
				if file.exists then
					dependancy_viewer_image := image_factory.from_file (dictionary.Dependancy_viewer_icon_filename.to_cil)
				else
					returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Dependency_icon_not_found_error.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
				end
				
				file.reset (dictionary.Help_icon_filename)
				if file.exists then
					help_image := image_factory.from_file (dictionary.Help_icon_filename.to_cil)
				else
					returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Help_icon_not_found_error.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
				end
			
					-- Add icons to `image_list'.
				create image_list.make_winforms_image_list
				toolbar.set_image_list (image_list)
				images := image_list.get_images
				images.add (name_image)
				images.add (version_image)
				images.add (culture_image)
				images.add (public_key_image)
				images.add (dependancies_image)
				images.add (dependancy_viewer_image)
				images.add (help_image)
			else
				returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Toolbar_icon_not_found_error.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
			end
		rescue
			retried := True
			retry
		end

	build_data_table_assembly_viewer is
		indexing
			description: "Build `data_table'."
			external_name: "BuildDataTableAssemblyViewer"
		local
			type: TYPE
		do
			create data_table.make_data_data_table_1 (dictionary.Data_table_title.to_cil)
			
				-- Create table columns
			type := type_factory.Get_Type_String (dictionary.System_string_type.to_cil);
			create assembly_name_column.make_data_data_column_2 (dictionary.Assembly_name_column_title.to_cil, type)
			create assembly_version_column.make_data_data_column_2 (dictionary.Assembly_version_column_title.to_cil, type)
			create assembly_culture_column.make_data_data_column_2 (dictionary.Assembly_culture_column_title.to_cil, type)
			create assembly_public_key_column.make_data_data_column_2 (dictionary.Assembly_public_key_column_title.to_cil, type)
			create dependancies_column.make_data_data_column_2 (dictionary.Dependancies_column_title.to_cil, type)					

				-- Add columns to data table
			data_table.get_Columns.Add_Data_Column (assembly_name_column)
		end

	build_data_grid_assembly_viewer is
		indexing
			description: "Build `data_grid' and associate actions."
			external_name: "BuildDataGridAssemblyViewer"
		local
			row: DATA_DATA_ROW
			a_size: DRAWING_SIZE
			a_point: DRAWING_POINT
			added: INTEGER
			assembly: ASSEMBLY
			--on_cell_delegate: SYSTEM_EVENTHANDLER
			a_color: DRAWING_COLOR
			style: DRAWING_FONT_STYLE
		do
				-- Build data grid	
			create data_grid.make_winforms_data_grid
			data_grid.Begin_Init
			data_grid.set_Visible (True)
			create data_grid_font.make_drawing_font_10 (dictionary.Font_family_name.to_cil, dictionary.Font_size, style.Regular)
			data_grid.set_font (data_grid_font)
			
			if main_win.get_width /= Void and then main_win.get_width > 0 then
				a_size.set_width (main_win.get_width - dictionary.Margin // 2)
				a_size.set_height (main_win.get_height - 4 * dictionary.Row_height)				
			else
				a_size.set_width (dictionary.Window_width - dictionary.Margin // 2)
				a_size.set_height (dictionary.Window_height - 4 * dictionary.Row_height)
			end
			data_grid.set_Size (a_size)
			main_win.set_height (dictionary.Window_height)
			
			a_point.set_x (0)
			a_point.set_y (toolbar.get_height)
			data_grid.set_location (a_point)
			data_grid.set_Data_Source (data_table)
			data_grid.set_Tab_Index (0)
			data_grid.End_Init 
			
				-- Table styles
			create assembly_name_column_style.make_winforms_data_grid_text_box_column
			create assembly_version_column_style.make_winforms_data_grid_text_box_column
			create assembly_culture_column_style.make_winforms_data_grid_text_box_column
			create assembly_public_key_column_style.make_winforms_data_grid_text_box_column
			create dependancies_column_style.make_winforms_data_grid_text_box_column
			
				-- Set `MappingName'.
			assembly_name_column_style.set_mapping_name (dictionary.Assembly_name_column_title.to_cil)
			assembly_version_column_style.set_mapping_name (dictionary.Assembly_version_column_title.to_cil)
			assembly_culture_column_style.set_mapping_name (dictionary.Assembly_culture_column_title.to_cil)
			assembly_public_key_column_style.set_mapping_name (dictionary.Assembly_public_key_column_title.to_cil)
			dependancies_column_style.set_mapping_name (dictionary.Dependancies_column_title.to_cil)

				-- Set `HeaderText'.
			assembly_name_column_style.set_header_text (dictionary.Assembly_name_column_title.to_cil)
			assembly_version_column_style.set_header_text (dictionary.Assembly_version_column_title.to_cil)
			assembly_culture_column_style.set_header_text (dictionary.Assembly_culture_column_title.to_cil)
			assembly_public_key_column_style.set_header_text (dictionary.Assembly_public_key_column_title.to_cil)
			dependancies_column_style.set_header_text (dictionary.Dependancies_column_title.to_cil)
			
			set_read_only_assembly_viewer
			
				-- Set styles.
			create data_grid_table_style.make_winforms_data_grid_table_style_1 
			data_grid_table_style.set_back_color (a_color.get_White)
			data_grid_table_style.set_Preferred_Column_Width (dictionary.Window_width // 6)
			data_grid_table_style.set_preferred_row_height (dictionary.Row_height)
			data_grid_table_style.set_read_only (True)
			data_grid_table_style.set_selection_back_color (dictionary.White_color)
			data_grid_table_style.set_row_headers_visible (False)
			data_grid_table_style.set_column_headers_visible (True)
			data_grid_table_style.set_mapping_name (dictionary.Data_table_title.to_cil)
			data_grid_table_style.set_allow_sorting (False)
			
			added := data_grid_table_style.get_grid_column_styles.add (assembly_name_column_style)
			added := data_grid_table_style.get_grid_column_styles.add (assembly_version_column_style)
			added := data_grid_table_style.get_grid_column_styles.add (assembly_culture_column_style)
			added := data_grid_table_style.get_grid_column_styles.add (assembly_public_key_column_style)
			added := data_grid_table_style.get_grid_column_styles.add (dependancies_column_style)
			
			if not data_grid.get_Table_Styles.contains_data_grid_table_style (data_grid_table_style) then
				added := data_grid.get_Table_Styles.add (data_grid_table_style)
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
		
	on_resize_action (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Resize window and its content."
			external_name: "OnResizeAction"
		local
			a_size: DRAWING_SIZE
		do
			a_size.set_width (main_win.get_width - dictionary.Margin // 2)
			a_size.set_height (main_win.get_height - 4 * dictionary.Row_height)
			data_grid.set_Size (a_size)
			toolbar.set_width (main_win.get_width)
			resize_columns
			if data_table.get_rows /= Void and then data_table.get_rows.get_count > 0 then
				fill_data_grid
			end			
			main_win.refresh
		end
		
	display_name (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Display assembly name column if checked."
			external_name: "DisplayName"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		deferred
		end

	display_version (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Display assembly version column if checked."
			external_name: "DisplayVersion"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		deferred
		end

	display_culture (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Display assembly culture column if checked."
			external_name: "DisplayCulture"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		deferred
		end

	display_public_key (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Display assembly public key column if checked."
			external_name: "DisplayPublicKey"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		deferred
		end

	display_dependancies (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Display dependancies column if checked."
			external_name: "DisplayDependancies"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		deferred
		end

	show_all (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Show all columns."
			external_name: "ShowAll"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		deferred
		end

	show_all_assembly_viewer (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Show all columns."
			external_name: "ShowAllAssemblyViewer"
		local
			columns: DATA_DATA_COLUMN_COLLECTION
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
			
			main_win.get_controls.remove (data_grid)
			build_assemblies_table
			columns := data_table.get_columns
			columns.clear
			columns.add_data_column (assembly_name_column)
			columns.add_data_column (assembly_version_column)
			columns.add_data_column (assembly_culture_column)
			columns.add_data_column (assembly_public_key_column)
			columns.add_data_column (dependancies_column)
		end

	show_name_assembly_viewer (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Show assembly name column only."
			external_name: "ShowNameAssemblyViewer"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			columns: DATA_DATA_COLUMN_COLLECTION
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
			
			main_win.get_controls.remove (data_grid)
			build_assemblies_table
			columns := data_table.get_columns
			columns.clear
			columns.add_data_column (assembly_name_column)	
		end
		
	exit (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Close ISE assembly manager."
			external_name: "Exit"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		do
			main_win.close
		end
		
	display_help (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Display help for ISE assembly manager."
			external_name: "DisplayHelp"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			support: REFLECTION_SUPPORT
			help_filename: STRING
			help: WINFORMS_HELP
			navigator: WINFORMS_HELP_NAVIGATOR
			process: PROCESS
		do
			support := create {REFLECTION_SUPPORT}.make
			--support.make
			help_filename := from_reflection_string (support.Eiffel_delivery_path)
			help_filename.append (dictionary.Relative_help_filename)
			process := process.start_string (help_filename.to_cil)
		end
		
	about_assembly_manager (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
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
	
	on_toolbar_button_clicked (sender: SYSTEM_OBJECT; arguments: WINFORMS_TOOL_BAR_BUTTON_CLICK_EVENT_ARGS) is
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
--			a_descriptor: ASSEMBLYDESCRIPTOR
--			assembly_dependancies: ARRAY [SYSTEM_REFLECTION_ASSEMBLYNAME]
--			dependancy_viewer: DEPENDANCY_VIEWER
--			on_close_delegate: SYSTEM_EVENTHANDLER
--			support: ASSEMBLY_SUPPORT
--		do
--			if dependancies_menu_item.checked then
--				create support.make
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

	show_dependancy_viewer (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "If selected cell is in the dependancies column then display dependancies"
			external_name: "ShowDependancyViewer"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			selected_row: INTEGER
			a_descriptor: ASSEMBLY_DESCRIPTOR
			assembly_dependancies: ARRAY [CLI_CELL [ASSEMBLY_NAME]]
			dependancy_viewer: DEPENDANCY_VIEWER
			support: ASSEMBLY_SUPPORT
		do
			create support.make
			selected_row := data_grid.get_current_row_index
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
		
	update_add (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
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

	image_factory: DRAWING_IMAGE
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
				
	type_factory: TYPE
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

	empty_row (row_count: INTEGER): DATA_DATA_ROW is 
		indexing
			description: "Build an empty row at index `row_count'."
			external_name: "EmptyRow"
		local
			columns: DATA_DATA_COLUMN_COLLECTION
		do
			columns := data_table.get_columns
			Result := data_table.New_Row			
			Result.get_Table.get_Default_View.set_Allow_Edit (False)
			Result.get_Table.get_Default_View.set_Allow_New (False)
			Result.get_Table.get_Default_View.set_Allow_Delete (False)
			if columns.contains (dictionary.Assembly_name_column_title.to_cil) then
				Result.set_Item_String (dictionary.Assembly_name_column_title.to_cil, dictionary.Empty_string.to_cil)
			end
			if columns.contains (dictionary.Assembly_version_column_title.to_cil) then
				Result.set_Item_String (dictionary.Assembly_version_column_title.to_cil, dictionary.Empty_string.to_cil)
			end
			if columns.contains (dictionary.Assembly_culture_column_title.to_cil) then
				Result.set_Item_String (dictionary.Assembly_culture_column_title.to_cil, dictionary.Empty_string.to_cil)
			end
			if columns.contains (dictionary.Assembly_public_key_column_title.to_cil) then
				Result.set_Item_String (dictionary.Assembly_public_key_column_title.to_cil, dictionary.Empty_string.to_cil)
			end			
			if columns.contains (dictionary.Dependancies_column_title.to_cil) then
				Result.set_Item_String (dictionary.Dependancies_column_title.to_cil, dictionary.Empty_string.to_cil)
			end
			data_table.get_Rows.Add (Result)
		end	
		
	current_assembly (row_number: INTEGER): ASSEMBLY_DESCRIPTOR is
		indexing
			description: "Assembly descriptor corresponding to row at index `row_number'"
			external_name: "CurrentAssembly"
		require
			valid_row_number: row_number > -1 and row_number < data_table.get_rows.get_count
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
			rows: DATA_DATA_ROW_COLLECTION
			retried: BOOLEAN
		do
			if not retried then
				rows := data_table.get_rows
				if (rows.get_count + 3) * dictionary.Row_height < main_win.get_height - 4 * dictionary.Row_height then
					difference := main_win.get_height - 4 * dictionary.Row_height - (rows.get_count + 3) * dictionary.Row_height
					empty_row_count := difference // dictionary.Row_height + 1
					from
					until
						i = empty_row_count
					loop
						build_empty_row (rows.get_count)
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
			assembly_name_column_style.set_read_only (True)
			assembly_version_column_style.set_read_only (True)
			assembly_culture_column_style.set_read_only (True)
			assembly_public_key_column_style.set_read_only (True)
			dependancies_column_style.set_read_only (True)
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
			columns: DATA_DATA_COLUMN_COLLECTION
		do
			build_assemblies
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

	new_row (a_descriptor: ASSEMBLY_DESCRIPTOR; row_count: INTEGER): DATA_DATA_ROW is 
		indexing
			description: "Build a row at index `row_count' and fill row with information from `a_descriptor'."
			external_name: "NewRow"
		require
			non_void_assembly_descriptor: a_descriptor /= Void
			positive_row_count: row_count >= 0
		local
			columns: DATA_DATA_COLUMN_COLLECTION
			dependancies: ARRAY [CLI_CELL [ASSEMBLY_NAME]]
			support: ASSEMBLY_SUPPORT
		do
			create support.make
			Result := data_table.New_Row
			columns := data_table.get_columns			
			Result.get_Table.get_Default_View.set_Allow_Edit (False)
			Result.get_Table.get_Default_View.set_Allow_New (False)
			Result.get_Table.get_Default_View.set_Allow_Delete (False)
			if columns.contains (dictionary.Assembly_name_column_title.to_cil) then
				Result.set_Item_String (dictionary.Assembly_name_column_title.to_cil, a_descriptor.name.to_cil)
			end
			if columns.contains (dictionary.Assembly_version_column_title.to_cil) then
				Result.set_Item_String (dictionary.Assembly_version_column_title.to_cil, a_descriptor.version.to_cil)
			end
			if columns.contains (dictionary.Assembly_culture_column_title.to_cil) then
				Result.set_Item_String (dictionary.Assembly_culture_column_title.to_cil, a_descriptor.culture.to_cil)
			end
			if columns.contains (dictionary.Assembly_public_key_column_title.to_cil) then
				Result.set_Item_String (dictionary.Assembly_public_key_column_title.to_cil, a_descriptor.public_key.to_cil)
			end			
			if columns.contains (dictionary.Dependancies_column_title.to_cil) then
				dependancies := support.dependancies_from_info (a_descriptor)
				if dependancies.count > 0 then
					Result.set_Item_String (dictionary.Dependancies_column_title.to_cil, support.dependancies_string (dependancies).to_cil)
				else
					Result.set_Item_String (dictionary.Dependancies_column_title.to_cil, dictionary.No_dependancy.to_cil)
				end
			end
			data_table.get_rows.Add (Result)
		end
		
end -- class ASSEMBLY_VIEWER
