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
			{ANY} is_empty, is_show_requested, show, hide, accelerators,
				item
		redefine
			initialize
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
			{ANY} system_status
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
		
	GB_SHARED_PREFERENCES
		undefine
			copy, default_create
		end
		
	GB_WIDGET_UTILITIES
		undefine
			copy, default_create
		end
		
		
create
	default_create
	
feature {NONE} -- Initialization

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_TITLED_WINDOW}
			set_icon_pixmap ((create {GB_SHARED_PIXMAPS}).icon_build_window @ 1)
		end

feature -- Basic operation

	build_interface is
			-- Create user interface in `Current'.
		do
			set_title (Product_name)
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
			set_width (preferences.integer_resource_value (Preferences.build_window__width, 640))
			set_height (preferences.integer_resource_value (Preferences.build_window__height, 480))
			set_x_position (preferences.integer_resource_value (Preferences.build_window__x_position, 200))
			set_y_position (preferences.integer_resource_value (Preferences.build_window__y_position, 200))
			
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
				-- When we are launching as the Envision modification
				-- wizard, we will not be able to ensure that the top item
				-- is visible as at window will not be displayed. If this is
				-- the case, then we perform the "itme_visible" i
				-- `make_and_launch_as_modify_wizard' of WIZARD_PROJECT_MANAGER.
			if is_show_requested then
				type_selector.ensure_top_item_visible
			end
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

				-- Now restore from preferences
			if horizontal_split_area.full then
				set_split_position (horizontal_split_area, preferences.integer_resource_value (Preferences.main_split__position, 100))
			end
			initialize_tool_positions (preferences.array_resource_value (preferences.tool_order, create {ARRAY [STRING]}.make (1, 1)))
			initialize_external_tool_positions (preferences.array_resource_value (preferences.external_tool_order, create {ARRAY [STRING]}.make (1, 1)))
			
				-- This will update the tool interface if `multiple_split_area' has no items contained,
				-- effectively hiding `multiple_split_area'.
			widget_removed_from_multiple_split_area
	
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
				-- Now store to preferences
			Preferences.set_integer_resource (Preferences.main_split__position, horizontal_split_area.split_position)
			store_tool_positions

					-- Actually save the preferences.
			Preferences.save_resources;

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
			--| FIXME when the vertical control is completed, add an appropriate setting.
			if horizontal_split_area.full then
				horizontal_split_area.set_split_position (Default_width_of_type_selector)
			end
		--	vertical_split_area.set_split_position (Default_height_of_type_selector)
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
			menu_item: EV_MENU_ITEM
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
			create menu_item.make_with_text ("Preferences...")
			menu_item.select_actions.extend (agent Preferences.show_preference_window)
			view_preferences.extend (menu_item)

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
			constructor_box: EV_HORIZONTAL_BOX
			temp_tool_bar: EV_TOOL_BAR
		do
				-- Now we perform a large hack. In Wizard, mode, the
				-- fourth state may be re-built, if we go back and change a setting
				-- in another window. This means that the widget structure built in
				-- "here", is still contained in another box. So we must now remove all
				-- `once' controls, from their current parents, so thay can be rebuilt correctly
				-- again.
				-- Another fix would have to been modify some of the Wizard classes, but I chose not to
				-- do this, as we want to modify as few library classes as possible, as it becomes
				-- difficult to track. Therefore, the fix is here.
			if tool_bar.parent /= Void then
					check
						parenting_consistent: type_selector.parent /= Void and
						component_selector.parent /= Void and
						layout_constructor.parent /= Void and
						docked_object_editor.parent /= Void
					end
				tool_bar.parent.prune_all (tool_bar)
				type_selector.parent.prune_all (type_selector)
				component_selector.parent.prune_all (component_selector)
				layout_constructor.parent.prune_all (layout_constructor)
				docked_object_editor.parent.prune_all (docked_object_editor)
			end

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
			
				-- Add the multiple split area, located to the left.
			multiple_split_area.enable_top_widget_resizing
			multiple_split_area.set_close_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_close @ 1)
			multiple_split_area.set_maximize_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_maximize @ 1)
			multiple_split_area.set_minimize_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_minimize @ 1)
			multiple_split_area.set_restore_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_restore @ 1)
			multiple_split_area.docked_out_actions.extend (agent widget_removed_from_multiple_split_area)
			multiple_split_area.docked_in_actions.extend (agent widget_inserted_into_multiple_split_area)

			create constructor_box
			create horizontal_split_area.make_with_tools (multiple_split_area, layout_constructor, "Layout constructor")
			create temp_tool_bar
			temp_tool_bar.extend (Layout_constructor.expand_all_button)
			temp_tool_bar.extend (Layout_constructor.view_object_button)
			horizontal_split_area.tool_holder.add_command_tool_bar (temp_tool_bar)
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
		
	widget_removed_from_multiple_split_area is
			-- Respond to a widget being removed from `multiple_split_area'
		local
			split_area_parent: EV_HORIZONTAL_BOX
		do
			if multiple_split_area.count = 0 then
				split_area_parent ?= horizontal_split_area.parent
				if split_area_parent /= Void then
						-- The non Void check is a hack to get around a bug in
						-- `docked_out_actions' which is fired when you drag a
						-- dockable item that is already external.
					split_area_parent.prune_all (horizontal_split_area)
					Layout_constructor.parent.prune_all (Layout_constructor)
					split_area_parent.go_i_th (1)
					split_area_parent.put_left (layout_constructor)
					multiple_split_area.parent.prune_all (multiple_split_area)
				end
			end
		end
	
	widget_inserted_into_multiple_split_area is
			-- Respond to a widget being inserted into `multiple_split_area'.
		local
			layout_constructor_parent: EV_HORIZONTAL_BOX
		do
			if multiple_split_area.count = 1 then
				layout_constructor_parent ?= layout_constructor.parent
				layout_constructor_parent.prune_all (layout_constructor)
				create horizontal_split_area.make_with_tools (multiple_split_area, layout_constructor, "Layout constructor")
				layout_constructor_parent.go_i_th (1)
				layout_constructor_parent.put_left (horizontal_split_area)
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

	initialize_tool_positions (info: ARRAY [STRING]) is
			-- Initialize tools in `multiple_split_area', based on `info'.
		require
			info_not_void: info /= Void
		local
			tool_name: STRING
			info_string: STRING
			state: STRING
			index: INTEGER
			counter: INTEGER
			stored_heights: ARRAYED_LIST [INTEGER]
			stored_widths: ARRAYED_LIST [INTEGER]
			minimized_items: ARRAYED_LIST [BOOLEAN]
			maximized_index: INTEGER
		do
			multiple_split_area.wipe_out
			create stored_heights.make (info.count)
			create stored_widths.make (info.count)
			create minimized_items.make (info.count)
			from
				counter := 1
			until
				counter > info.count
			loop
				info_string := info @ counter
				index := info_string.index_of ('_', 1)
				tool_name := info_string.substring (1, index - 1)
				info_string := info_string.substring (index + 1, info_string.count)
				
				index := info_string.index_of ('_', 1)
				state := info_string.substring (1, index - 1)
				if state.is_equal ("maximized") then
					maximized_index := counter					
				end
				if state.is_equal ("minimized") then
					minimized_items.extend (True)
				else
					minimized_items.extend (False)
				end
				info_string := info_string.substring (index + 1, info_string.count)
				
				index := info_string.index_of ('_', 1)
				stored_heights.extend (info_string.substring (1, index - 1).to_integer)
				info_string := info_string.substring (index + 1, info_string.count)
				
				index := info_string.index_of ('_', 1)
				stored_widths.extend (info_string.to_integer)
				info_string := info_string.substring (index + 1, info_string.count)
				
					-- Note that we convert from the stored name to the real name for the second argument.
				multiple_split_area.extend (tool_by_name (tool_name), name_by_tool (tool_by_name (tool_name)))				
				counter := counter + 1
			end

				-- The heights are restored after the multiple split area is built, as otherwise, the building
				-- will affect the heights, and they will not be restored correctly.
				-- The heights are only temporary, hence if the multiple split area is too small to contain
				-- all widgets at those heights, only some will remain at the desired height.
			from
				minimized_items.start
			until
				minimized_items.off
			loop
				if minimized_items.item then
					multiple_split_area.minimize_item (multiple_split_area.linear_representation.i_th (minimized_items.index))
					multiple_split_area.set_item_restore_height (multiple_split_area.linear_representation.i_th (minimized_items.index), 200)
				end
				minimized_items.forth
			end
			if maximized_index /= 0 then
				multiple_split_area.maximize_item (multiple_split_area.linear_representation.i_th (maximized_index))
			else
				from
					stored_heights.start
				until
					stored_heights.off
				loop
					if not minimized_items.i_th (stored_heights.index) then
						multiple_split_area.resize_widget_to (multiple_split_area.linear_representation.i_th (stored_heights.index), stored_heights.item)
					end
					stored_heights.forth
				end
			end
		end
		
	initialize_external_tool_positions (info: ARRAY [STRING]) is
			-- Initialize external tools of `multiple_split_area', based on `info'.
		require
			info_not_void: info /= Void
		local
			tool_name: STRING
			info_string: STRING
			index: INTEGER
			a_width, a_height: INTEGER
			an_x, a_y: INTEGER
			tool: EV_WIDGET
			counter: INTEGER
		do
			from
				counter := 1
			until
				counter > info.count
			loop
				info_string := info @ counter
				
				index := info_string.index_of ('_', 1)
				tool_name := info_string.substring (1, index - 1)
				info_string := info_string.substring (index + 1, info_string.count)
				
				index := info_string.index_of ('_', 1)
				an_x := info_string.substring (1, index - 1).to_integer
				info_string := info_string.substring (index + 1, info_string.count)
				
				index := info_string.index_of ('_', 1)
				a_y := info_string.substring (1, index - 1).to_integer
				info_string := info_string.substring (index + 1, info_string.count)
				
				index := info_string.index_of ('_', 1)
				a_width := info_string.substring (1, index - 1).to_integer
				info_string := info_string.substring (index + 1, info_string.count)
				
				index := info_string.index_of ('_', 1)
				a_height :=  info_string.to_integer
				info_string := info_string.substring (index + 1, info_string.count)

				tool := tool_by_name (tool_name)
					-- Remove `tool' from its parent if any.
				if tool.parent /= Void then
					tool.parent.prune_all (tool)
				end
					-- Add `tool' as an enternal tool, that is one that apepars if it has been docked out of
					-- `multiple_split_area'.
				multiple_split_area.add_external (tool, Current, name_by_tool (tool_by_name (tool_name)), 1, an_x, a_y, a_width, a_height)
				counter := counter + 1
			end
		end	
		
	store_tool_positions is
			-- Store positions of all tools in `multiple_split_area'
			-- into preferences.
		local
			info: ARRAY [STRING]
			linear_rep: ARRAYED_LIST [EV_WIDGET]
			output: STRING
			a_dialog: EV_DIALOG
		do
			output := ""
			create info.make (1, multiple_split_area.count)
			linear_rep := clone (multiple_split_area.linear_representation)
			from
				linear_rep.start
			until
				linear_rep.off
			loop
				output := storable_name_by_tool (linear_rep.item)
				output := output + "_"
				if multiple_split_area.is_item_maximized (linear_rep.item) then
					output := output + "maximized"
				elseif multiple_split_area.is_item_minimized (linear_rep.item) then
					output := output + "minimized"
				else
					output := output + "normal"
				end
				output := output + "_" + linear_rep.item.height.out
				output := output + "_" + linear_rep.item.width.out
				info.put (output, linear_rep.index)
				linear_rep.forth
			end
			preferences.set_array_resource (preferences.tool_order, info)
			linear_rep := clone (multiple_split_area.external_representation)
			create info.make (1, linear_rep.count)
			from	
				linear_rep.start				
			until
				linear_rep.off
			loop
				output := storable_name_by_tool (linear_rep.item)
				a_dialog := parent_dialog (linear_rep.item)
				check
					dialog_not_void: a_dialog /= Void
				end
				
				output := output + "_" + a_dialog.x_position.out
				output := output + "_" + a_dialog.y_position.out
				output := output + "_" + a_dialog.width.out
				output := output + "_" + a_dialog.height.out
				info.put (output, linear_rep.index)
				linear_rep.forth
			end
			preferences.set_array_resource (preferences.external_tool_order, info)
		end
		
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
				-- For now, always exit.
				must_exit := True
--				create confirmation.make_with_text (Exit_warning)
--				confirmation.show_modal_to_window (Current)
--				if confirmation.selected_button.is_equal (constants.ev_ok) then
--					must_exit := True
--				end
			end
			if must_save then
				command_handler.save_command.execute
			end
			if must_exit then
					-- Save all the user generated components.
				xml_handler.save_components
				
					-- Now store current window settings into preferences.
				Preferences.set_integer_resource (Preferences.Build_window__width, width)
				Preferences.set_integer_resource (Preferences.Build_window__height, height)
				Preferences.set_integer_resource (Preferences.Build_window__x_position, x_position)
				Preferences.set_integer_resource (Preferences.Build_window__y_position, y_position)

					-- Actually save the preferences.
				Preferences.save_resources;
				
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
