indexing
	description: "Objects that represent the main window for the system."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class		
	GB_MAIN_WINDOW

inherit
	
	EV_TITLED_WINDOW
		export
			{NONE} all
			{ANY} is_empty, is_show_requested, show, hide
		undefine
			is_in_default_state
		end
		
	GB_CONSTANTS
		export
			{NONE} all
		end
		
	GB_SHARED_TOOLS
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end
		
	GB_SHARED_OBJECT_EDITORS
		export
			{NONE} all
		end
		
	GB_DEFAULT_STATE
		export
			{NONE} all
		end
	
	GB_SHARED_XML_HANDLER
		export
			{NONE} all
		undefine
			default_create, copy
		end

	GB_SHARED_COMMAND_HANDLER
		export
			{NONE} all
		end
		
	GB_SHARED_SYSTEM_STATUS
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end
		
	EV_LAYOUT_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end
		
	GB_SHARED_STATUS_BAR
		undefine
			copy, default_create
		end
create
	default_create	

feature -- Basic operation

	build_interface is
			-- Create user interface in `Current'.
		do
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
			build_widget_structure (Void)
			set_minimum_size (640, 480)
				-- The split areas do not re-position correctly when
				-- `Current' is not shown, so when shown, we initialize
				-- them. This is only done once, as if the user moves through the
				-- wizard, we need to keep their desired layout.
			show_actions.extend_kamikaze (agent initialize_split_areas)
			
				-- When an attempt to close `Current' is made, call `close_requested'.
			close_request_actions.extend (agent close_requested)
		end
		
		
		
	generate_interface (vb: EV_VERTICAL_BOX) is
			-- Build interface of `Current' into `vb'.
			-- This is used in Wizard mode.
		require
			box_exists: vb /= Void
		do
			build_widget_structure (vb)
			type_selector.ensure_top_item_visible
			initialize_split_areas
			command_handler.update
		end
		

	show_tools is
			-- Place tools in `Current'.
		require
			has_item: item /= Void
			not_in_wizard_mode: not system_status.is_wizard_system
		local
			vertical_box: EV_VERTICAL_BOX
		do
			lock_update
				-- Remove the filler.
			vertical_box ?= item
			check
				item_was_vertical_box: vertical_box /= Void
			end
			vertical_box.go_i_th (1)
			vertical_box.remove
			vertical_box.put_left (tool_holder)
			build_menu
				-- This causes a postcondition to fail in EV_SPLIT_AREA.
				-- However, it needs to be executed here so that it is not
				-- visible. The problem is, that while the window is still
				-- locked, the re-sizing is not completely calculated, hence
				-- the postcondition violation.
			initialize_split_areas

			unlock_update
		ensure
			has_item: item /= Void
		end
		
	hide_all_floating_tools is
			-- Hide all windows displayed to `Current'.
			-- i.e. display window, all floarint object editors etc etc.
		do
			command_handler.show_hide_builder_window_command.safe_disable_selected
			command_handler.show_hide_component_viewer_command.safe_disable_selected
			command_handler.show_hide_display_window_command.safe_disable_selected
			command_handler.show_hide_history_command.safe_disable_selected
			destroy_floating_editors
		end	
		
	hide_tools is
			-- Remove tools from `Current'.
		require
			has_item: item /= Void
			not_in_wizard_mode: not system_status.is_wizard_system
		local
			vertical_box: EV_VERTICAL_BOX
		do
			lock_update
				-- Remove the tools
			vertical_box ?= item
			check
				item_is_vertical_box: vertical_box /= Void
			end
			vertical_box.go_i_th (1)
			vertical_box.replace (filler)
				-- We build the menus here, as the only time they
				-- change at the moment is in conjunction with the
				-- tools being displayed. This may have to change later.
			build_menu
			unlock_update
		ensure
			has_item: item /= Void
		end

feature {NONE} -- Implementation
	
	initialize_split_areas is
			-- Set splitters to default positions.
		do
			horizontal_split_area.set_split_position (Default_width_of_type_selector)
			vertical_split_area.set_split_position (Default_height_of_type_selector)
		end

	initialize_menu is
			-- Initialize menus.
			-- Create menu items, and place in `menu_items'.
		require
			menus_not_initialized: menus_initialized = False
		local
			help_about, file_exit: EV_MENU_ITEM
			view_preferences, view_tools: EV_MENU
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
			create view_tools.make_with_text (Gb_view_tools_text)
			view_menu.extend (view_tools)
			view_tools.extend (command_handler.show_hide_builder_window_command.new_menu_item)
			view_tools.extend (command_handler.show_hide_display_window_command.new_menu_item)
			view_tools.extend (command_handler.show_hide_component_viewer_command.new_menu_item)
			view_tools.extend (command_handler.show_hide_history_command.new_menu_item)
			create menu_separator
			view_menu.extend (menu_separator)
			view_menu.extend (command_handler.expand_layout_tree_command.new_menu_item)
			view_menu.extend (command_handler.collapse_layout_tree_command.new_menu_item)
			create menu_separator
			view_menu.extend (menu_separator)
			create view_preferences.make_with_text (Gb_view_preferences_text)
			view_menu.extend (view_preferences)
			
			view_preferences.extend (command_handler.tools_always_on_top_command.new_menu_item)

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
				-- No file menu options are available
				-- for the wizard.
			if not system_status.is_wizard_system then
				a_menu_bar.extend (file_menu)	
			end
			if system_status.project_open then
				a_menu_bar.extend (view_menu)
				if not system_status.is_wizard_system then
					a_menu_bar.extend (project_menu)	
				end
			end
			a_menu_bar.extend (help_menu)
		end
		
	build_widget_structure (a_tool_holder: EV_VERTICAL_BOX) is
			-- create and layout "widgets" within `Current'.
			-- if `a_tool_holder' not Void then build widgets into
			-- `a_tool_holder', else build widgets into `tool_holder'.
		local
			separator: EV_HORIZONTAL_SEPARATOR
			horizontal_box: EV_HORIZONTAL_BOX
			the_tool_holder: EV_VERTICAL_BOX
			vertical_box: EV_VERTICAL_BOX
		do
			if a_tool_holder /= Void then
				the_tool_holder := a_tool_holder
			else
				create tool_holder
				the_tool_holder := tool_holder
			end
			create separator
			the_tool_holder.extend (separator)
			the_tool_holder.disable_item_expand (separator)
			the_tool_holder.extend (tool_bar)
			the_tool_holder.disable_item_expand (tool_bar)
			create separator
			the_tool_holder.extend (separator)
			the_tool_holder.disable_item_expand (separator)
			create horizontal_box
			the_tool_holder.extend (horizontal_box)
			create vertical_split_area.make_with_tools (type_selector, component_selector, "Type selector", "Component selector")
			create horizontal_split_area.make_with_tools (vertical_split_area, layout_constructor, "Layout constructor")
			horizontal_box.extend (horizontal_split_area)
			horizontal_box.extend (docked_object_editor)
			horizontal_box.disable_item_expand (docked_object_editor)
			
			if not system_status.is_wizard_system then
				create vertical_box
				extend (vertical_box)
				create filler
				vertical_box.extend (filler)
				vertical_box.extend (status_bar)
				vertical_box.disable_item_expand (status_bar)
			end
		end
		
	status_bar: EV_VERTICAL_BOX is
			-- `Result' is status bar displayed in `Current'.
		local
			padding_box: EV_HORIZONTAL_BOX
			horizontal_box: EV_HORIZONTAL_BOX
			frame: EV_FRAME
		once
			create Result
			create horizontal_box
			create frame
			horizontal_box.extend (frame)
			frame.set_style (1)
			create padding_box
			padding_box.set_minimum_height (2)
			Result.extend (padding_box)
			Result.disable_item_expand (padding_box)
			Result.extend (horizontal_box)
			Result.disable_item_expand (horizontal_box)
			frame.extend (status_bar_label)
			frame.set_minimum_height (frame.minimum_height + 3)
		ensure
			result_not_void: Result /= Void
		end
		

	tool_bar: EV_TOOL_BAR is
			-- Tool bar of `Current'
		local
			separator: EV_TOOL_BAR_SEPARATOR
		once
			create Result
			Result.extend (command_handler.delete_object_command.new_toolbar_item (True, False))
				-- No save option in the wizard.
			if not system_status.is_wizard_system then
				Result.extend (command_handler.save_command.new_toolbar_item (True, False))	
			end
			Result.extend (command_handler.object_editor_command.new_toolbar_item (True, False))
			create separator
			Result.extend (separator)
			Result.extend (command_handler.undo_command.new_toolbar_item (True, False))
			Result.extend (command_handler.show_hide_history_command.new_toolbar_item (True, False))
			Result.extend (command_handler.redo_command.new_toolbar_item (True, False))
			create separator
			Result.extend (separator)
				-- No generation button or project settings for the wizard.
				-- Project settings are reached by going back and forth in
				-- the wizard.
			if not system_status.is_wizard_system then
				Result.extend (command_handler.generation_command.new_toolbar_item (True, False))		
				create separator
				Result.extend (separator)
				Result.extend (command_handler.project_settings_command.new_toolbar_item (True, False))
			end
			
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
		
	horizontal_split_area: GB_HORIZONTAL_SPLIT_AREA_TOOL_HOLDER
		-- Horizontal split area holding main tools.
		
	vertical_split_area: GB_VERTICAL_SPLIT_AREA_TOOL_HOLDER
		-- Vertical split area holding main tools.
		
invariant
	
	menus_initalized_so_top_level_menu_items_not_void: menus_initialized implies file_menu /= Void
		and project_menu /= Void and view_menu /= Void and help_menu /= Void

end -- class GB_MAIN_WINDOW
