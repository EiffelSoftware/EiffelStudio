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
		undefine
			default_create, copy, is_equal
		end
		
	GB_ACCESSIBLE
		undefine
			default_create, copy, is_equal
		end
		
	GB_ACCESSIBLE_OBJECT_EDITOR
		undefine
			default_create, copy, is_equal
		end
		
	GB_DEFAULT_STATE
	
	GB_ACCESSIBLE_XML_HANDLER
		undefine
			default_create, copy, is_equal
		end

	GB_ACCESSIBLE_COMMAND_HANDLER
		undefine
			default_create, copy, is_equal
		end
		
	GB_ACCESSIBLE_SYSTEM_STATUS
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
			set_title (gb_main_window_title)
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
			help_about, file_exit, view_menu_display_window,
			view_menu_builder_window, view_menu_history, project_menu_build,
			project_menu_settings,  file_new: EV_MENU_ITEM
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
			create menu_separator
			view_menu.extend (menu_separator)
			view_menu.extend (command_handler.show_history_command.new_menu_item)

				-- Initialize the project menu.
			create project_menu.make_with_text (Gb_project_menu_text)
			project_menu.extend (command_handler.project_settings_command.new_menu_item)
			create project_menu_build.make_with_text (Gb_project_menu_build_text)
			project_menu.extend (project_menu_build)
			
				-- Initialize the help menu.
			create help_menu.make_with_text (Gb_help_menu_text)
			create help_about.make_with_text (Gb_help_about_menu_text)
			help_menu.extend (help_about)
			help_about.select_actions.extend (agent show_about_dialog)
				
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
			split_area: EV_HORIZONTAL_SPLIT_AREA
			vertical_box1: EV_VERTICAL_BOX
			horizontal_box: EV_HORIZONTAL_BOX
			vertical_split_area: EV_VERTICAL_SPLIT_AREA
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
			create split_area
			create horizontal_box
			tool_holder.extend (horizontal_box)
			horizontal_box.extend (split_area)
			create vertical_split_area
			split_area.extend (vertical_split_area)
			vertical_split_area.set_minimum_width (100)
			type_selector.set_minimum_size (100, 100)
			vertical_split_area.extend (type_selector)
			vertical_split_area.extend (component_selector)
			component_selector.set_minimum_height (100)
			create vertical_box1
			split_area.extend (vertical_box1)
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
			undo_button: GB_UNDO_TOOL_BAR_BUTTON
			redo_button: GB_REDO_TOOL_BAR_BUTTON
			separator: EV_TOOL_BAR_SEPARATOR
			generation_button: GB_CODE_GENERATION_TOOL_BAR_BUTTON
		once
			create Result
			Result.extend (command_handler.delete_object_command.new_toolbar_item (True, False))
			Result.extend (command_handler.save_command.new_toolbar_item (True, False))
			Result.extend (command_handler.object_editor_command.new_toolbar_item (True, False))
			create separator
			Result.extend (separator)
			create undo_button
			undo_button.disable_sensitive
			Result.extend (undo_button)
			Result.extend (command_handler.show_history_command.new_toolbar_item (True, False))
			create redo_button
			Result.extend (redo_button)
			redo_button.disable_sensitive
			create separator
			Result.extend (separator)
			create generation_button
			Result.extend (generation_button)
			create separator
			Result.extend (separator)
			Result.extend (command_handler.project_settings_command.new_toolbar_item (True, False))
			Result.extend (command_handler.show_hide_builder_window_command.new_toolbar_item (True, False))
			Result.extend (command_handler.show_hide_display_window_command.new_toolbar_item (True, False))
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

	close_requested is
			-- End the current application.
		do
			--| FIXME Need a confirmation_dialog.
				-- Save all the user generated components.
			xml_handler.save_components;
				-- Destroy the application.
			(create {EV_ENVIRONMENT}).application.destroy
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
		
invariant
	
	menus_initalized_so_top_level_menu_items_not_void: menus_initialized implies file_menu /= Void
		and project_menu /= Void and view_menu /= Void and help_menu /= Void

end -- class GB_MAIN_WINDOW
