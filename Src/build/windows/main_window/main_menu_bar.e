indexing
	description: "Menu bar of the main window."
	Id: "$Id $"
	date: "$Date$"
	revision: "$Revision$"

class
	MAIN_MENU_BAR

inherit
	EV_STATIC_MENU_BAR
		redefine
			make
		end

	WINDOWS

	CONSTANTS

creation
	make

feature {NONE} -- Initialization

	make (par: MAIN_WINDOW) is
		local
			file_category, action_category, view_category,
			windows_category, help_category: EV_MENU
--			menu_separator: EV_MENU_SEPARATOR
		do
			{EV_STATIC_MENU_BAR} Precursor (par)
 			create file_category.make_with_text (Current, Menu_names.File)
 			create action_category.make_with_text (Current, Menu_names.Actions)
 			create view_category.make_with_text (Current, Menu_names.View)
 			create windows_category.make_with_text (Current, Menu_names.Windows)
 			create help_category.make_with_text (Current, Menu_names.Help)
 					--| File menu
			create new_project_entry.make_with_text (file_category, Menu_names.New)
			create open_project_entry.make_with_text (file_category, Menu_names.Open)
--			create menu_separator.make (file_category)
			create save_project_menu_entry.make_with_text (file_category, Menu_names.Save)
			create save_as_menu_entry.make_with_text (file_category, Menu_names.Save_as)
--			create menu_separator.make (file_category)
			create import_menu_entry.make_with_text (file_category, Menu_names.Import)
			create generate_menu_entry.make_with_text (file_category, Menu_names.Generate)
--			create menu_separator.make (file_category)
			create exit_menu_entry.make_with_text (file_category, Menu_names.Exit)
					--| Action menu
			create create_command_entry.make_with_text (action_category, Menu_names.create_command)
					--| View menu
			create context_catalog_entry.make_with_text (view_category, Menu_names.Context_catalog)
			create context_tree_entry.make_with_text (view_category, Menu_names.Context_tree)
			create command_catalog_entry.make_with_text (view_category, Menu_names.Command_catalog)
			create context_editor_entry.make_with_text (view_category, Menu_names.Context_editor)
					--| Windows menu
			create application_editor_entry.make_with_text (windows_category, Menu_names.Application_editor)
			create class_importer_entry.make_with_text (windows_category, Menu_names.Class_importer)
			create history_window_entry.make_with_text (windows_category, Menu_names.History_window)
--			create menu_separator.make (windows_category)
			create command_editor_entry.make_with_text (windows_category, Menu_names.Instance_editor)
			create editors_entry.make_with_text (windows_category, Menu_names.Editors)
			create interface_entry.make_with_text (windows_category, Menu_names.Interface)
			create interface_only_entry.make_with_text (windows_category, Menu_names.Interface_only)
--			set_values
			set_callbacks
		end

	set_values is
		do
 			context_catalog_entry.set_selected (True)
 			context_tree_entry.set_selected (True)
 			context_editor_entry.set_selected (True)
 			command_catalog_entry.set_selected (True)
 			editors_entry.set_selected (True)
 			command_editor_entry.set_selected (True)
 			interface_entry.set_selected (True)
		end

	set_callbacks is
		local
--			raise_import_window: RAISE_IMPORT_WINDOW_CMD
--			generate: GENERATE
--			save_project: SAVE_PROJECT
--			exit_cmd: EXIT_EIFFEL_BUILD_CMD
--			change_mode_cmd: CHANGE_MODE_CMD
			rout_cmd: EV_ROUTINE_COMMAND
		do
--			new_project_entry.add_activate_action (create_proj_b, Void)
--			base.set_action ("Ctrl<Key>N", create_proj_b, Void)
--			open_project_entry.add_activate_action (load_proj_b, Void)
--			base.set_action ("Ctrl<Key>O", load_proj_b, Void)
--			!! save_project
--			save_project_menu_entry.add_activate_action (save_project, Void)
--			base.set_action ("Ctrl<Key>S", save_project, Void)
--			!! raise_import_window
--			import_menu_entry.add_activate_action (raise_import_window, Void)
--			!! generate
--			generate_menu_entry.add_activate_action (generate, Void)
--			!! exit_cmd
--			exit_menu_entry.add_activate_action (exit_cmd, Void)
--			!! change_mode_cmd
--			execute_b.add_value_changed_action (change_mode_cmd, execute_b)
--			edit_b.add_value_changed_action (change_mode_cmd, edit_b)

				--| View category
			create rout_cmd.make (~view_context_catalog)
			context_catalog_entry.add_select_command (rout_cmd, Void)
			create rout_cmd.make (~view_context_tree)
			context_tree_entry.add_select_command (rout_cmd, Void)
			create rout_cmd.make (~view_command_catalog)
			command_catalog_entry.add_select_command (rout_cmd, Void)
			create rout_cmd.make (~view_context_editor)
			context_editor_entry.add_select_command (rout_cmd, Void)

				--| Windows category
			create rout_cmd.make (~view_app_editor)
			application_editor_entry.add_select_command (rout_cmd, Void)
			create rout_cmd.make (~view_history)
			history_window_entry.add_select_command (rout_cmd, Void)
		end

feature -- Command

	view_context_catalog (arg: EV_ARGUMENT; ev_data: EV_EVENT_DATA) is
		do
			if context_catalog_entry.is_selected then
				main_window.context_catalog.show
			else
				main_window.context_catalog.hide
			end
		end

	view_context_tree (arg: EV_ARGUMENT; ev_data: EV_EVENT_DATA) is
		do
			if context_tree_entry.is_selected then
				main_window.context_tree.show
			else
				main_window.context_tree.hide
			end
		end

	view_command_catalog (arg: EV_ARGUMENT; ev_data: EV_EVENT_DATA) is
		do
			if command_catalog_entry.is_selected then
				main_window.command_catalog.show
			else
				main_window.command_catalog.hide
			end
		end

	view_context_editor (arg: EV_ARGUMENT; ev_data: EV_EVENT_DATA) is
		do
			if context_editor_entry.is_selected then
--				main_window.context_editor.show
			else
--				main_window.context_editor.hide
			end
		end

	view_app_editor (arg: EV_ARGUMENT; ev_data: EV_EVENT_DATA) is
		do
			if application_editor_entry.is_selected then
				App_editor.show
			else
				App_editor.hide
			end
		end

	view_history (arg: EV_ARGUMENT; ev_data: EV_EVENT_DATA) is
		do
			if history_window_entry.is_selected then
				history_window.show
			else
				history_window.hide
			end
		end

feature -- Enable/Disable menus

	enable is 
			-- Enable menus after openning a project.
		do
			save_project_menu_entry.set_insensitive (False)
			save_as_menu_entry.set_insensitive (False)
			import_menu_entry.set_insensitive (False)
			generate_menu_entry.set_insensitive (False)
			create_command_entry.set_insensitive (False)
			application_editor_entry.set_insensitive (False)
			class_importer_entry.set_insensitive (False)
			history_window_entry.set_insensitive (False)
			command_editor_entry.set_insensitive (False)
			editors_entry.set_insensitive (False)
			interface_entry.set_insensitive (False)
			interface_only_entry.set_insensitive (False)
		end

	disable is
			-- Disable all the menus except `File' and `Help'.
		do
			save_project_menu_entry.set_insensitive (True)
			save_as_menu_entry.set_insensitive (True)
			import_menu_entry.set_insensitive (True)
			generate_menu_entry.set_insensitive (True)
			create_command_entry.set_insensitive (True)
			application_editor_entry.set_insensitive (True)
			class_importer_entry.set_insensitive (True)
			history_window_entry.set_insensitive (True)
			command_editor_entry.set_insensitive (True)
			editors_entry.set_insensitive (True)
			interface_entry.set_insensitive (True)
			interface_only_entry.set_insensitive (True)
		end

feature -- Enable/Disable toggle buttons

--	enable_toggle_buttons is
--			-- Enable `execute_b' and `edit_b'.
--		do
--			execute_b.set_sensitive
--			edit_b.set_sensitive
--		end

--	disable_toggle_buttons is
--			-- Disable `execute_b' and `edit_b'.
--		do
--			execute_b.set_insensitive
--			edit_b.set_insensitive
--		end

feature -- GUI attributes

		--| Entries in the File category
	generate_menu_entry: EV_MENU_ITEM
	import_menu_entry: EV_MENU_ITEM
	new_project_entry: EV_MENU_ITEM
	open_project_entry: EV_MENU_ITEM
	save_project_menu_entry: EV_MENU_ITEM
	save_as_menu_entry: EV_MENU_ITEM -- SAVE_AS_BUTTON
	exit_menu_entry: EV_MENU_ITEM

		--| Entries in the Actions category
	create_command_entry: EV_MENU_ITEM -- NEW_COMMAND_BUTTON

		--| Entries in the View category
	context_tree_entry: EV_CHECK_MENU_ITEM -- CONTEXT_TREE_ENTRY
	context_catalog_entry: EV_CHECK_MENU_ITEM -- CONTEXT_CATALOG_ENTRY
	command_catalog_entry: EV_CHECK_MENU_ITEM -- COMMAND_CATALOG_ENTRY
	context_editor_entry: EV_CHECK_MENU_ITEM -- CONTEXT_EDITOR_ENTRY

		--| Entries in the Windows category
	application_editor_entry: EV_CHECK_MENU_ITEM -- APPLICATION_EDITOR_ENTRY
	class_importer_entry: EV_CHECK_MENU_ITEM -- CLASS_IMPORTER_ENTRY
	history_window_entry: EV_CHECK_MENU_ITEM -- HISTORY_WINDOW_ENTRY
	command_editor_entry: EV_CHECK_MENU_ITEM -- COMMAND_EDITOR_ENTRY
	editors_entry: EV_CHECK_MENU_ITEM -- EDITORS_ENTRY
	interface_entry: EV_CHECK_MENU_ITEM -- INTERFACE_ENTRY
	interface_only_entry: EV_CHECK_MENU_ITEM -- INTERFACE_ONLY_ENTRY

		--| Entries in the Help category
	-- None so far

end -- class MAIN_MENU_BAR

