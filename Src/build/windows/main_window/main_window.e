indexing
	description: "Revised main panel which contains: %
				%	- a menu bar %
				%	- a toolbar %
				%	- a split window which contains %
				%	the context catalog, the context tree, %
				%	the command catalog and the context editor."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class

	MAIN_WINDOW

inherit

	EV_WINDOW
		redefine
			make_top_level
		end

	WINDOWS
		rename
			exit_build as close
		undefine
			context_catalog
		end

	CONSTANTS

	CLOSEABLE

	SHARED_CONTEXT

--	SHARED_LICENSE

--	MODE_CONSTANTS

--	SHARED_MODE

--	SHARED_APPLICATION

creation

	make_top_level

feature -- Initialization

	make_top_level is
			-- Create the main window.
		local
			hbox: EV_HORIZONTAL_BOX
		do
			{EV_WINDOW} Precursor
			create vertical_box.make (Current)

			create menu_bar.make (Current)
			create toolbar.make (vertical_box)

 				--| Context catalog
			create context_catalog.make (vertical_box)

				--| Split areas
			create horizontal_split_area.make (vertical_box)
					--| Context Tree
			create context_tree.make (horizontal_split_area)
			create vertical_split_area.make (horizontal_split_area)
					--| Command catalog
			create command_catalog.make (vertical_split_area)
					--| Context Editor
--			create context_editor.make (horizontal_split_area)

					--| Status bar
--			create status_bar.make (Current)

			set_values
			set_callbacks
  		end

	set_values is
 			-- Set the values for the GUI elements.
		do
			set_title (widget_names.main_panel)
-- 			resources.check_fonts (base)
-- 			if Pixmaps.eiffelbuild_pixmap.is_valid then
-- 				set_icon_pixmap (Pixmaps.eiffelbuild_pixmap)
-- 			end
-- 			initialize_window_attributes
		end

	set_callbacks is
			-- Set callbacks on GUI elements
-- 		local
-- 			raise_import_window: RAISE_IMPORT_WINDOW_CMD
-- 			generate: GENERATE
-- 			save_project: SAVE_PROJECT
-- 			exit_cmd: EXIT_EIFFEL_BUILD_CMD
		do
			set_close_callback (Void)
-- 			new_project_entry.add_activate_action (create_proj_b, Void)
-- 			base.set_action ("Ctrl<Key>N", create_proj_b, Void)
-- 			open_project_entry.add_activate_action (load_proj_b, Void)
-- 			base.set_action ("Ctrl<Key>O", load_proj_b, Void)
-- 			!! save_project
-- 			save_project_menu_entry.add_activate_action (save_project, Void)
-- 			base.set_action ("Ctrl<Key>S", save_project, Void)
-- 			!! raise_import_window
-- 			import_menu_entry.add_activate_action (raise_import_window, Void)
-- 			!! generate
-- 			generate_menu_entry.add_activate_action (generate, Void)
-- 			!! exit_cmd
-- 			exit_menu_entry.add_activate_action (exit_cmd, Void)
		end

feature -- Attributes

	project_initialized: BOOLEAN
			-- Is project initialized?

	project_changed: BOOLEAN
			-- Project changed since last compilation

--	hide_show_windows: HIDE_SHOW_WINDOWS
			-- Hide/show windows for Main panel iconization

feature -- Implementation

	set_saved_symbol is
			-- Change the symbol appearing on `save_b' to represent
			-- a saved folder.
		do
--			save_b.set_saved_symbol
		end

	set_unsaved_symbol is
			-- Change the symbol appearing on `save_b' to represent
			-- an open folder.
		do
--			save_b.set_unsaved_symbol
			project_changed := True
		end

	set_project_compiled is
			-- Set `project_changed' to false.
		do
			project_changed := False
		end

feature -- Graphical interface

	vertical_box: EV_VERTICAL_BOX
	
	horizontal_split_area: EV_HORIZONTAL_SPLIT_AREA
	
	vertical_split_area: EV_VERTICAL_SPLIT_AREA
	
	menu_bar: MAIN_MENU_BAR

	toolbar: MAIN_TOOLBAR

		--| Split Window
	context_tree: CONTEXT_TREE
			-- Context tree
	context_catalog: CONTEXT_CATALOG
			-- Context catalog
	command_catalog: COMMAND_CATALOG
			-- Command catalog
--	context_editor: CONTEXT_EDITOR_WIDGET
			-- Context editor included in main panel.

feature -- Status setting

	set_project_initialized is 
			-- Set project_initialized to True.
		do 		
--			project_initialized := True 
--			enable_menus
--			enable_toggle_buttons
--			set_mode (editing_mode)
		end

	unset_project_initialized is 
			-- Set project_initialized to False.
		do 		
--			project_initialized := False 
--			set_title (Widget_names.main_panel)
--			disable_menus
--			disable_toggle_buttons
--			set_mode (executing_mode)
		end

feature -- Popup and popdown actions

	was_popped_down: BOOLEAN

-- 	popup is
-- 		do
-- 			hide_show_windows.show
-- 		end

-- 	popdown is
-- 		do
-- 			hide_show_windows.hide
-- 		end

feature -- Interface

	hide_interface is
			-- Hide the interface.
		local
			window_c: WINDOW_C
		do
			from
				Shared_window_list.start
			until
				Shared_window_list.after
			loop
				window_c := Shared_window_list.item
				window_c.hide
				Shared_window_list.forth
			end
		end

	show_interface is
			-- Show the interface.
		local
			window_c: WINDOW_C
		do
			from
				Shared_window_list.start
			until
				Shared_window_list.after
			loop
				window_c := Shared_window_list.item
				window_c.show
				Shared_window_list.forth
			end
		end

--feature -- Raise

--	raise is
--			-- Raise main panel
--		do
--			base.raise
--		end

feature -- Current state

--	current_state: BUILD_STATE
--			-- Current state

--	set_current_state (s: BUILD_STATE) is
--			-- Set `current_state' to `s'.
--		do
--			current_state := s
--			current_state_label.set_text (s.label)
--		end

feature -- Enable/Disable EiffelBuild

	enable is
			-- Enable widgets of Main Panel and popup previously
			-- hidden tools.
		do
			menu_bar.enable
			toolbar.enable
		end

	disable is
			-- Disable all widgets of Main Panel and popdown
			-- every tools.
		do
			menu_bar.disable
			toolbar.disable
		end

end -- class MAIN_WINDOW

