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

create
	default_create

feature {NONE} -- Initialization

	initialize is
			-- initialize `Current'.
		do
			Precursor {EV_TITLED_WINDOW}
			set_title (gb_main_window_title)
			build_menu
			build_widget_structure
			set_up_first_window
			set_minimum_size (640, 480)
		end

feature {NONE} -- Implementation

	build_menu is
			-- Generate menu for `Current'.
		local
			a_menu_bar: EV_MENU_BAR
			file_menu: EV_MENU
			about_menu: EV_MENU
			settings_menu: EV_MENU
		do
			create a_menu_bar
			set_menu_bar (a_menu_bar)
			create file_menu.make_with_text (gb_file_menu_text)
			a_menu_bar.extend (file_menu)
			create settings_menu.make_with_text (gb_settings_menu_text)
			a_menu_bar.extend (settings_menu)
			create about_menu.make_with_text (gb_about_menu_text)
			a_menu_bar.extend (about_menu)
		end
		
	build_widget_structure is
			-- create and layout "widgets" within `Current'.
		local
			vertical_box: EV_VERTICAL_BOX
			separator: EV_HORIZONTAL_SEPARATOR
			split_area: EV_HORIZONTAL_SPLIT_AREA
			vertical_box1: EV_VERTICAL_BOX
			horizontal_box: EV_HORIZONTAL_BOX
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
			split_area.extend (type_selector)
			create vertical_box1
			split_area.extend (vertical_box1)
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
			save_button: GB_SAVE_TOOL_BAR_BUTTON
			load_button: GB_LOAD_TOOL_BAR_BUTTON
			a_new_object_editor: GB_NEW_OBJECT_EDITOR_BUTTON
			undo_button: GB_UNDO_TOOL_BAR_BUTTON
			history_button: GB_HISTORY_TOOL_BAR_BUTTON
			redo_button: GB_REDO_TOOL_BAR_BUTTON
			separator: EV_TOOL_BAR_SEPARATOR
		once
			create Result
			create delete_button
			Result.extend (delete_button)
			create save_button
			Result.extend (save_button)
			create load_button
			Result.extend (load_button)
			create a_new_object_editor
			Result.extend (a_new_object_editor)
			create separator
			Result.extend (separator)
			create undo_button
			undo_button.disable_sensitive
			Result.extend (undo_button)
			create history_button
			Result.extend (history_button)
			create redo_button
			Result.extend (redo_button)
			redo_button.disable_sensitive
			create separator
			Result.extend (separator)
		end
		
	set_up_first_window is
			-- Initialize window to hold widgets.
		do
			display_window.show
		end

end -- class GB_MAIN_WINDOW
