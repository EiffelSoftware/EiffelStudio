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
			--build_commands
			build_menu
			build_widget_structure
			set_up_first_window
			set_minimum_size (640, 480)
				-- Tell `system_settings' that `Current' is the
				-- main window of the system.
			system_status.set_main_window (Current)
				-- When an attempt to close `Current' is made, call `close_requested'.
			close_request_actions.extend (agent close_requested)
		end

feature {NONE} -- Implementation

	build_menu is
			-- Generate menu for `Current'.
		local
			a_menu_bar: EV_MENU_BAR
			file_menu, help_menu, view_menu, project_menu: EV_MENU
			help_about, file_exit, view_menu_display_window,
			view_menu_builder_window, view_menu_history, project_menu_build,
			project_menu_settings,  file_new: EV_MENU_ITEM
			menu_separator: EV_MENU_SEPARATOR
		do
				-- Initialize the menu bar.
			create a_menu_bar
			set_menu_bar (a_menu_bar)
			
				-- Initialize the file menu.
			create file_menu.make_with_text (Gb_file_menu_text)
			a_menu_bar.extend (file_menu)
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
				--| FIXME make into a command.
			create view_menu_display_window.make_with_text ("Show display window")
			view_menu.extend (view_menu_display_window)
			create view_menu_builder_window.make_with_text ("Show builder window")
			view_menu.extend (view_menu_builder_window)
			create menu_separator
			view_menu.extend (menu_separator)
			view_menu.extend (command_handler.show_history_command.new_menu_item)

				-- Initialize the project menu.
			create project_menu.make_with_text (Gb_project_menu_text)
			a_menu_bar.extend (project_menu)
			project_menu.extend (command_handler.project_settings_command.new_menu_item)
			create project_menu_build.make_with_text (Gb_project_menu_build_text)
			project_menu.extend (project_menu_build)
			
			
			
				-- Initialize the help menu.
			create help_menu.make_with_text (Gb_help_menu_text)
			a_menu_bar.extend (help_menu)
			create help_about.make_with_text (Gb_help_about_menu_text)
			help_menu.extend (help_about)
			help_about.select_actions.extend (agent show_about_dialog)
			
			
		end
		
	build_widget_structure is
			-- create and layout "widgets" within `Current'.
		local
			vertical_box: EV_VERTICAL_BOX
			separator: EV_HORIZONTAL_SEPARATOR
			split_area: EV_HORIZONTAL_SPLIT_AREA
			vertical_box1: EV_VERTICAL_BOX
			horizontal_box: EV_HORIZONTAL_BOX
			vertical_split_area: EV_VERTICAL_SPLIT_AREA
		do
			create vertical_box
			extend (vertical_box)
			create separator
			vertical_box.extend (separator)
			vertical_box.disable_item_expand (separator)
			vertical_box.extend (tool_bar)
			vertical_box.disable_item_expand (tool_bar)
			create separator
			vertical_box.extend (separator)
			vertical_box.disable_item_expand (separator)
			create split_area
			create horizontal_box
			vertical_box.extend (horizontal_box)
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
			builder_window.show
		end
		
	toggle_builder_window is
			-- 
		do
			if builder_window.is_displayed then
				builder_window.hide
			else
				builder_window.show
			end
		end
	
	tool_bar: EV_TOOL_BAR is
			-- Tool bar of `Current'
		local
			delete_button: GB_DELETE_TOOL_BAR_BUTTON
			a_new_object_editor: GB_NEW_OBJECT_EDITOR_BUTTON
			undo_button: GB_UNDO_TOOL_BAR_BUTTON
			history_button: GB_HISTORY_TOOL_BAR_BUTTON
			redo_button: GB_REDO_TOOL_BAR_BUTTON
			separator: EV_TOOL_BAR_SEPARATOR
			generation_button: GB_CODE_GENERATION_TOOL_BAR_BUTTON
		once
			create Result
			create delete_button
			Result.extend (delete_button)
			Result.extend (command_handler.save_command.new_toolbar_item (True, False))
			create a_new_object_editor
			Result.extend (a_new_object_editor)
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
		end
		
	set_up_first_window is
			-- Initialize window to hold widgets.
		do
			display_window.show
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

end -- class GB_MAIN_WINDOW
