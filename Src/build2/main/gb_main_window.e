indexing
	description: "Objects that represent the main window for the system."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_MAIN_WINDOW

inherit
	
	EV_TITLED_WINDOW
		undefine
			is_in_default_state
		redefine
			initialize
		end
		
	GB_CONSTANTS
		export
			{NONE} all
		end
		
	GB_SHARED_TOOLS
		undefine
			default_create, copy, is_equal
		end
		
	GB_SHARED_OBJECT_EDITORS
		
	GB_DEFAULT_STATE
	
	GB_SHARED_XML_HANDLER
		undefine
			default_create, copy
		end

	GB_SHARED_COMMAND_HANDLER
		
	GB_SHARED_SYSTEM_STATUS
		undefine
			default_create, copy, is_equal
		end

create
	default_create

feature {NONE} -- Initialization

	initialize is
				-- initialize `Current'.
		do
			Precursor {EV_TITLED_WINDOW}
			set_title (Product_name)
			set_icon_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_build_window @ 1)
				-- Initialize the menu bar for `Current'.
			create a_menu_bar
			set_menu_bar (a_menu_bar)
				-- Initialize menu
			initialize_menu
				-- Build the menu
			build_menu
				-- Build the tools and other widgets within `Current'.
			build_widget_structure
			set_minimum_size (640, 480)
				-- Tell `system_settings' that `Current' is the
				-- main window of the system.
			system_status.set_main_window (Current)
				-- When an attempt to close `Current' is made, call `close_requested'.
			close_request_actions.extend (agent close_requested)
		end

feature -- Basic operation

	show_tools is
			-- Place tools in `Current'.
		require
			has_item: item /= Void
			item_is_filler: item = filler
		do
			lock_update
				-- Remove the filler.
			wipe_out
				-- Add the tools.
			extend (tool_holder)
				-- We build the menus here, as the only time they
				-- change at the moment is in conjunction with the
				-- tools being displayed. This may have to change later.
			horizontal_split_area.set_split_position (Default_width_of_type_selector)
			vertical_split_area.set_split_position (Default_height_of_type_selector)
			build_menu
			unlock_update
		ensure
			has_item: item /= Void
			item_is_tool_holder: item = tool_holder
		end
		
		
	hide_tools is
			-- Remove tools from `Current'.
		require
			has_item: item /= Void
			item_is_tool_holder: item = tool_holder
		do
			lock_update
				-- Remove the tools
			wipe_out
				-- Add the filler
			extend (filler)
				-- We build the menus here, as the only time they
				-- change at the moment is in conjunction with the
				-- tools being displayed. This may have to change later.
			build_menu
			unlock_update
		ensure
			has_item: item /= Void
			item_is_filler: item = filler
		end

feature {NONE} -- Implementation

	initialize_menu is
			-- Initialize menus.
			-- Create menu items, and place in `menu_items'.
		require
			menus_not_initialized: menus_initialized = False
		local
			help_about, file_exit, project_menu_settings: EV_MENU_ITEM
			menu_separator: EV_MENU_SEPARATOR
			
		do
				-- Initialize the file menu.
			create file_menu.make_with_text (Gb_file_menu_text)
			create menu_separator
			file_menu.extend (command_handler.open_project_command.new_menu_item)
			file_menu.extend (command_handler.new_project_command.new_menu_item)
			file_menu.extend (command_handler.save_command.new_menu_item)
			file_menu.extend (command_handler.close_project_command.new_menu_item)
			file_menu.extend (menu_separator)
			create file_exit.make_with_text (Gb_file_exit_menu_text)
			file_menu.extend (file_exit)
			file_exit.select_actions.extend (agent close_requested)

				-- Initialize the view menu.
			create view_menu.make_with_text (Gb_view_menu_text)
			a_menu_bar.extend (view_menu)
			view_menu.extend (command_handler.show_hide_builder_window_command.new_menu_item)
			view_menu.extend (command_handler.show_hide_display_window_command.new_menu_item)
			view_menu.extend (command_handler.show_hide_component_viewer_command.new_menu_item)
			create menu_separator
			view_menu.extend (menu_separator)
			view_menu.extend (command_handler.expand_layout_tree_command.new_menu_item)
			view_menu.extend (command_handler.collapse_layout_tree_command.new_menu_item)
			
			
			create menu_separator
			view_menu.extend (menu_separator)
			view_menu.extend (command_handler.show_history_command.new_menu_item)

				-- Initialize the project menu.
			create project_menu.make_with_text (Gb_project_menu_text)
			project_menu.extend (command_handler.project_settings_command.new_menu_item)
			project_menu.extend (command_handler.generation_command.new_menu_item)		
			
				-- Initialize the help menu.
			create help_menu.make_with_text (Gb_help_menu_text)
			create help_about.make_with_text (Gb_help_about_menu_text)
			help_menu.extend (help_about)
			help_about.select_actions.extend (agent show_about_dialog)
			
			assign_command_accelerators_to_window
				
				-- Assign `True' to `menus_initialized'.
			menus_initialized := True
		end
		

	build_menu is
			-- Generate menu for `Current'.
		require
			menus_intitialized : menus_initialized
		do
			a_menu_bar.wipe_out
			a_menu_bar.extend (file_menu)
			if system_status.project_open then
				a_menu_bar.extend (view_menu)
				a_menu_bar.extend (project_menu)
			end
			a_menu_bar.extend (help_menu)
		end
		
	build_widget_structure is
			-- create and layout "widgets" within `Current'.
		local
			separator: EV_HORIZONTAL_SEPARATOR
			vertical_box1: EV_VERTICAL_BOX
			horizontal_box: EV_HORIZONTAL_BOX
		do
			create tool_holder
			create separator
			tool_holder.extend (separator)
			tool_holder.disable_item_expand (separator)
			tool_holder.extend (tool_bar)
			tool_holder.disable_item_expand (tool_bar)
			create separator
			tool_holder.extend (separator)
			tool_holder.disable_item_expand (separator)
			create horizontal_split_area
			create horizontal_box
			tool_holder.extend (horizontal_box)
			horizontal_box.extend (horizontal_split_area)
			create vertical_split_area
			horizontal_split_area.extend (vertical_split_area)
			vertical_split_area.set_minimum_width (100)
			type_selector.set_minimum_size (100, 100)
			vertical_split_area.extend (type_selector)
			vertical_split_area.extend (component_selector)
			component_selector.set_minimum_height (100)
			create vertical_box1
			horizontal_split_area.extend (vertical_box1)
			layout_constructor.set_minimum_size (100, 100)
			vertical_box1.extend (layout_constructor)
			horizontal_box.extend (docked_object_editor)
			horizontal_box.disable_item_expand (docked_object_editor)
			
			create filler
			extend (filler)
		end
	
	tool_bar: EV_TOOL_BAR is
			-- Tool bar of `Current'
		local
			separator: EV_TOOL_BAR_SEPARATOR
		once
			create Result
			Result.extend (command_handler.delete_object_command.new_toolbar_item (True, False))
			Result.extend (command_handler.save_command.new_toolbar_item (True, False))
			Result.extend (command_handler.object_editor_command.new_toolbar_item (True, False))
			create separator
			Result.extend (separator)
			Result.extend (command_handler.undo_command.new_toolbar_item (True, False))
			Result.extend (command_handler.show_history_command.new_toolbar_item (True, False))
			Result.extend (command_handler.redo_command.new_toolbar_item (True, False))
			create separator
			Result.extend (separator)
			Result.extend (command_handler.generation_command.new_toolbar_item (True, False))		
			create separator
			Result.extend (separator)
			Result.extend (command_handler.project_settings_command.new_toolbar_item (True, False))
			Result.extend (command_handler.show_hide_builder_window_command.new_toolbar_item (True, False))
			Result.extend (command_handler.show_hide_display_window_command.new_toolbar_item (True, False))
			Result.extend (command_handler.show_hide_component_viewer_command.new_toolbar_item (True, False))
		end
		
	show_about_dialog is
			-- Display an about dialog.
		local
			about_dialog: GB_ABOUT_DIALOG
		do
			create about_dialog.make
			about_dialog.show_modal_to_window (Current)
		end
		
feature {NONE} -- Implementation

	assign_command_accelerators_to_window is
			-- For all command accelerators,
			-- add them to the accelerators of `Current'.
		local
			local_commands: ARRAYED_LIST [EB_STANDARD_CMD]
		do
			local_commands := command_handler.all_commands
			from
				local_commands.start
			until
				local_commands.off
			loop
				if local_commands.item.accelerator /= Void then
					accelerators.extend (local_commands.item.accelerator)
				end
				local_commands.forth
			end
		end
		

	close_requested is 
			-- End the current application.
		local
			confirmation: EV_CONFIRMATION_DIALOG
			question: EV_QUESTION_DIALOG
			must_exit, must_save: BOOLEAN
			constants: EV_DIALOG_CONSTANTS
		do
			create constants
			if system_status.project_modified then
				create question.make_with_text (Exit_save_warning)
				question.show_modal_to_window (Current)
				if question.selected_button.is_equal (constants.ev_yes) then
					must_save := True
				end
				if not question.selected_button.is_equal (constants.ev_cancel) then
					must_exit := True
				end
			else
				create confirmation.make_with_text (Exit_warning)
				confirmation.show_modal_to_window (Current)
				if confirmation.selected_button.is_equal (constants.ev_ok) then
					must_exit := True
				end
			end
			if must_save then
				command_handler.save_command.execute
			end
			if must_exit then
					-- Save all the user generated components.
				xml_handler.save_components;
					-- Destroy the application.
				(create {EV_ENVIRONMENT}).application.destroy
			end
		end
		
	tool_holder: EV_VERTICAL_BOX
		-- Holds all the tools to be placed in `Current'.
			
	filler: EV_TREE
		-- To be placed in `Current' when we do not want
		-- the tools to be available.
		
	a_menu_bar: EV_MENU_BAR
		-- The menu bar of `Current'.
		
	file_menu, project_menu, view_menu, help_menu: EV_MENU
		-- Top level menus used in `Current'.
		
	menus_initialized: BOOLEAN
		-- Has `initialize_menus' been called?
		
	horizontal_split_area: EV_HORIZONTAL_SPLIT_AREA
		-- Horizontal split area holding main tools.
		
	vertical_split_area: EV_VERTICAL_SPLIT_AREA
		-- Vertical split area holding main tools.
		
invariant
	
	menus_initalized_so_top_level_menu_items_not_void: menus_initialized implies file_menu /= Void
		and project_menu /= Void and view_menu /= Void and help_menu /= Void

end -- class GB_MAIN_WINDOW
