indexing
	description: "Revised main panel which contains: %
				%	- menus %
				%	- a row of buttons %
				%	- a split window which contains the context %
				%	the context tree, the context catalog and the %
				%	history window."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class

	MAIN_PANEL

inherit

	WINDOWS

	COMMAND_ARGS
	
	CONSTANTS

	CLOSEABLE

	QUEST_POPUPER

	SHARED_CONTEXT

	LICENCE_COMMAND

	MODE_CONSTANTS

	SHARED_MODE

	SHARED_APPLICATION

creation

	make

feature -- Creation
	make (a_screen: SCREEN) is
		do
			!! hide_show_windows

			!! base.make ("1", a_screen)
			!! form.make (widget_names.form, base)
				--| Menu bar
			!! menu_bar.make (Menu_names.Menu_bar, base)
			!! file_category.make (Menu_names.File, menu_bar)
			!! action_category.make (Menu_names.Actions, menu_bar)
			!! view_category.make (Menu_names.View, menu_bar)
			!! help_category.make (Menu_names.Help, menu_bar)
			!! generate_menu_entry.make (Menu_names.Generate, file_category)
			!! import_menu_entry.make (Menu_names.Import, file_category)
			!! menu_separator.make ("", file_category)
			!! exit_menu_entry.make (Menu_names.Exit, file_category)
			!! create_command_entry.make (Menu_names.create_command, action_category)
			!! application_editor_entry.make (Menu_names.Application_editor, view_category)
			!! class_importer_entry.make (Menu_names.Class_importer, view_category)
			!! command_sub_menu.make (Menu_names.Command, view_category)
			!! context_sub_menu.make (Menu_names.Context, view_category)
			!! editors_entry.make (Menu_names.Editors, view_category)
			!! history_window_entry.make (Menu_names.History_window, view_category)
			!! interface_entry.make (Menu_names.Interface, view_category)
			!! interface_only_entry.make (Menu_names.Interface_only, view_category) 
			
			!! context_catalog_entry.make (Menu_names.Context_catalog, context_sub_menu)
			!! context_editor_entry.make (Menu_names.Context_editor, context_sub_menu)
			!! context_tree_entry.make (Menu_names.Context_tree, context_sub_menu)
			!! command_catalog_entry.make (Menu_names.Command_catalog, command_sub_menu)
			!! command_tool_entry.make (Menu_names.Instance_editor, command_sub_menu)
				--| Separators
			!! separator1.make (widget_names.separator, form)
			!! separator2.make (widget_names.separator, form)
				--| Button bar
			!! button_form.make (widget_names.form, form)
			!! quit_b.make (Current, button_form)
			!! cut_b.make (button_form)
			!! namer_b.make (button_form)
			!! help_b.make (button_form)
			!! con_b.make (button_form)
			!! cmd_b.make (button_form)
			!! state_b.make (button_form)
			!! generate_b.make (button_form)
			!! import_b.make (button_form)
			!! editing_box.make ("editing box", button_form)
			!! executing_box.make ("executing box", button_form)
 			!! execute_b.make ("Execute", executing_box)
			!! edit_b.make ("Edit", editing_box)
			!! current_state_hole.make (button_form)
			!! current_state_label.make ("", button_form)
			!! save_b.make (button_form)
			!! v_separator_1.make ("", button_form)
			!! v_separator_2.make ("", button_form)
			!! v_separator_3.make ("", button_form)
				--| Split windows
			!! main_split_window.make_horizontal ("Main split window", form)
			!! top_split_form.make ("Top split form", main_split_window)
			!! bottom_split_form.make ("Bottom split form", main_split_window)
			!! top_split_window.make_horizontal ("Top split window", top_split_form)
			!! bottom_split_window.make_horizontal ("Bottom split window", bottom_split_form)
			!! context_tree_split_form.make ("Context tree form", top_split_window)
			!! context_split_form.make ("Context form", top_split_window)
			!! context_split_window.make_vertical ("Context split window", context_split_form)
			!! context_catalog_split_form.make ("Context catalog form", context_split_window)
			!! context_editor_split_form.make ("Context editor form", context_split_window)
			!! command_split_form.make ("Command split form", bottom_split_window)
			!! command_editor_split_form.make ("Command editor form", bottom_split_window)
			!! command_split_window.make_vertical ("Command split window", command_split_form)
			!! command_catalog_split_form.make ("Command catalog form", command_split_window)
			!! command_tool_split_form.make ("Instance Editor form", command_split_window)

				--| Context Tree
			!! scrolled_w.make ("Scrolled Window", context_tree_split_form)
			!! context_tree_widget.make (widget_names.Context_Tree, scrolled_w)
			!! context_tree_button_form.make ("Context Tree Button Form", context_tree_split_form)
			!! raise_widget_hole.make (context_tree_button_form)
			!! show_window_hole.make (context_tree_button_form)
			!! expand_parent_hole.make (context_tree_button_form)
			!! vertical_separator.make ("", context_tree_split_form)

				--| Context split window
			!! context_catalog_widget.make (Widget_names.Context_catalog, context_catalog_split_form)
			!! context_editor.make ("Context editor", context_editor_split_form)

				--| Command split window
			!! command_catalog_widget.make (widget_names.Command_catalog, command_catalog_split_form)
			!! command_tool.make ("Instance editor", command_tool_split_form)
			!! command_editor.make ("Command editor", command_editor_split_form)
				
			set_values
			attach_all
			set_callbacks
		end

	set_values is
			-- Set the values for the GUI elements.
		local
			del_com: DELETE_WINDOW
		do
			set_title (widget_names.main_panel)
			resources.check_fonts (base)
			base.forbid_resize
			if Pixmaps.eiffelbuild_pixmap.is_valid then
				base.set_icon_pixmap (Pixmaps.eiffelbuild_pixmap)
			end
			base.initialize_window_attributes
			!! del_com.make (Current)
			base.set_delete_command (del_com)
			form.set_fraction_base (100)
			separator1.set_horizontal (True)
			separator2.set_horizontal (True)
			executing_box.set_always_one (False)
			editing_box.set_always_one (False)
			edit_b.arm
			context_catalog_entry.set_toggle_on
			context_tree_entry.set_toggle_on
			context_editor_entry.set_toggle_on
			command_catalog_entry.set_toggle_on
			command_tool_entry.set_toggle_on
			editors_entry.set_toggle_on
			interface_entry.set_toggle_on
			vertical_separator.set_horizontal (False)
			command_editor.set_command_tool (command_tool)
			v_separator_1.set_horizontal (False)
			v_separator_2.set_horizontal (False)
			v_separator_3.set_horizontal (False)
			main_split_window.set_proportion (66)
			top_split_window.set_proportion (50)
			command_split_window.set_proportion (50)
			context_split_window.set_proportion (50)
		end

	attach_all is
			-- Perform attachments.
		do
			button_form.attach_top (quit_b, 0)
			button_form.attach_top (cut_b, 0)
			button_form.attach_top (namer_b, 0)
			button_form.attach_top (help_b, 0)
			button_form.attach_top (con_b, 0)
			button_form.attach_top (cmd_b, 0)
			button_form.attach_top (state_b, 0)
			button_form.attach_top (generate_b, 0)
			button_form.attach_top (import_b, 0)
			button_form.attach_top (save_b, 0)
			button_form.attach_top (executing_box, 0)
			button_form.attach_top (editing_box, 0)
			button_form.attach_top (current_state_hole, 0)
			button_form.attach_top (current_state_label, 3)
			button_form.attach_top (v_separator_1, 0)
			button_form.attach_top (v_separator_2, 0)
			button_form.attach_top (v_separator_3, 0)
			button_form.attach_bottom (quit_b, 0)
			button_form.attach_bottom (cut_b, 0)
			button_form.attach_bottom (namer_b, 0)
			button_form.attach_bottom (help_b, 0)
			button_form.attach_bottom (con_b, 0)
			button_form.attach_bottom (cmd_b, 0)
			button_form.attach_bottom (state_b, 0)
			button_form.attach_bottom (generate_b, 0)
			button_form.attach_bottom (import_b, 0)
			button_form.attach_bottom (save_b, 0)
			button_form.attach_bottom (executing_box, 0)
			button_form.attach_bottom (editing_box, 0)
			button_form.attach_bottom (current_state_hole, 0)
			button_form.attach_bottom (current_state_label, 0)
			button_form.attach_bottom (v_separator_1, 0)
			button_form.attach_bottom (v_separator_2, 0)
			button_form.attach_bottom (v_separator_3, 0)
			button_form.attach_left (con_b, 0)
			button_form.attach_left_widget (con_b, cmd_b, 0)
			button_form.attach_left_widget (cmd_b, state_b, 0)
			button_form.attach_left_widget (state_b, help_b, 0)
			button_form.attach_left_widget (help_b, namer_b, 0)
			button_form.attach_left_widget (namer_b, cut_b, 0)
			button_form.attach_left_widget (cut_b, v_separator_1, 0)
			button_form.attach_left_widget (v_separator_1, generate_b, 0)
			button_form.attach_left_widget (generate_b, import_b, 0)
			button_form.attach_left_widget (import_b, v_separator_2, 0)
			button_form.attach_left_widget (v_separator_2, executing_box, 0)
			button_form.attach_left_widget (executing_box, editing_box, 0)
			button_form.attach_left_widget (editing_box, v_separator_3, 0)
			button_form.attach_left_widget (v_separator_3, current_state_hole, 0)
			button_form.attach_left_widget (current_state_hole, current_state_label, 3)
			button_form.attach_right (quit_b, 0)
			button_form.attach_right_widget (quit_b, save_b, 0)

			form.attach_top (separator1, 1)
			form.attach_left (separator1, 0)
			form.attach_right (separator1, 0)
			form.attach_top_widget (separator1, button_form, 0)
			form.attach_left (button_form, 0)
			form.attach_right (button_form, 0)
			form.attach_top_widget (button_form, separator2, 0)
			form.attach_left (separator2, 0)
			form.attach_right (separator2, 0)
			form.attach_top_widget (separator2, main_split_window, 0)
			form.attach_right (main_split_window, 0)
			form.attach_left (main_split_window, 0)
			form.attach_bottom (main_split_window, 0)

				--| Top split window
			top_split_form.attach_top (top_split_window, 0)
			top_split_form.attach_left (top_split_window, 0)
			top_split_form.attach_right (top_split_window, 0)
			top_split_form.attach_bottom (top_split_window, 0)

					--| Context tree split form
			context_tree_split_form.attach_top (scrolled_w, 0)
			context_tree_split_form.attach_top (context_tree_button_form, 0)
			context_tree_split_form.attach_top (vertical_separator, 0)
			context_tree_split_form.attach_left (context_tree_button_form, 0)
			context_tree_split_form.attach_bottom (context_tree_button_form, 0)
			context_tree_split_form.attach_left_widget (context_tree_button_form, vertical_separator, 2)
			context_tree_split_form.attach_bottom (vertical_separator, 0)
			context_tree_split_form.attach_left_widget (vertical_separator, scrolled_w, 0)
			context_tree_split_form.attach_right (scrolled_w, 0)
			context_tree_split_form.attach_bottom (scrolled_w, 0)

			context_tree_button_form.attach_top (raise_widget_hole, 0)
			context_tree_button_form.attach_right (raise_widget_hole, 0)
			context_tree_button_form.attach_right (show_window_hole, 0)
			context_tree_button_form.attach_right (expand_parent_hole, 0)
			context_tree_button_form.attach_left (raise_widget_hole, 0)
			context_tree_button_form.attach_left (show_window_hole, 0)
			context_tree_button_form.attach_left (expand_parent_hole, 0)
			context_tree_button_form.attach_top_widget (raise_widget_hole, show_window_hole, 0)
			context_tree_button_form.attach_top_widget (show_window_hole, expand_parent_hole, 0)

					--| Context split window
			context_split_form.attach_top (context_split_window, 0)
			context_split_form.attach_left (context_split_window, 0)
			context_split_form.attach_right (context_split_window, 0)
			context_split_form.attach_bottom (context_split_window, 0)

							--| Context catalog
			context_catalog_split_form.attach_top (context_catalog_widget, 0)
			context_catalog_split_form.attach_right (context_catalog_widget, 0)
			context_catalog_split_form.attach_left (context_catalog_widget, 0)
			context_catalog_split_form.attach_bottom (context_catalog_widget, 0)

							--| Context editor
			context_editor_split_form.attach_top (context_editor, 0)
			context_editor_split_form.attach_left (context_editor, 0)
			context_editor_split_form.attach_right (context_editor, 0)
			context_editor_split_form.attach_bottom (context_editor, 0)

				--| Bottom split window
			bottom_split_form.attach_top (bottom_split_window, 0)
			bottom_split_form.attach_left (bottom_split_window, 0)
			bottom_split_form.attach_right (bottom_split_window, 0)
			bottom_split_form.attach_bottom (bottom_split_window, 0)

					--| Command split window
			command_split_form.attach_top (command_split_window, 0)
			command_split_form.attach_left (command_split_window, 0)
			command_split_form.attach_right (command_split_window, 0)
			command_split_form.attach_bottom (command_split_window, 0)

						--| Command catalog
			command_catalog_split_form.attach_top (command_catalog_widget, 0)
			command_catalog_split_form.attach_left (command_catalog_widget, 0)
			command_catalog_split_form.attach_right (command_catalog_widget, 0)
			command_catalog_split_form.attach_bottom (command_catalog_widget, 0)
			
						-- Instance editor
			command_tool_split_form.attach_top (command_tool, 0)
			command_tool_split_form.attach_left (command_tool, 0)
			command_tool_split_form.attach_right (command_tool, 0)
			command_tool_split_form.attach_bottom (command_tool, 0)

					--| Command editor
			command_editor_split_form.attach_top (command_editor, 0)
			command_editor_split_form.attach_left (command_editor, 0)
			command_editor_split_form.attach_right (command_editor, 0)
			command_editor_split_form.attach_bottom (command_editor, 0)
		end

	set_callbacks is
			-- Set callbacks on GUI elements
		local
			raise_import_window: RAISE_IMPORT_WINDOW_CMD
			generate: GENERATE
			exit_cmd: EXIT_EIFFEL_BUILD_CMD
			change_mode: CHANGE_MODE_CMD
		do
			edit_b.add_value_changed_action (Current, edit_b)
			execute_b.add_value_changed_action (Current, execute_b)
			!! raise_import_window
			import_menu_entry.add_activate_action (raise_import_window, Void)
			!! generate
			generate_menu_entry.add_activate_action (generate, Void)
			!! exit_cmd
			exit_menu_entry.add_activate_action (exit_cmd, Void)
			!! change_mode
			execute_b.add_activate_action (change_mode, executing_mode)
			edit_b.add_activate_action (change_mode, editing_mode)
		end

feature -- Attributes

	base: TRANSPORTER

	project_initialized: BOOLEAN
			-- Is project initialized?

	hide_show_windows: HIDE_SHOW_WINDOWS
			-- Hide/show windows for Main panel iconization

feature -- Implementation

	set_saved_symbol is
			-- Change the symbol appearing on `save_b' to represent
			-- a saved folder.
		do
			save_b.set_saved_symbol
		end

	set_unsaved_symbol is
			-- Change the symbol appearing on `save_b' to represent
			-- an open folder.
		do
			save_b.set_unsaved_symbol
		end

	set_interface_toggle is
			-- Set `interface_entry' on.
		do
			interface_entry.set_toggle_on
		end

feature {NONE} -- Implementation

	changing_mode: BOOLEAN
			-- Is the application changing its mode?
			
feature {NONE} -- Graphical interface

		--| Forms
	form,
		-- Form of the main panel
	button_form,
		-- Form containing all the buttons
	context_tree_button_form: FORM
			-- Button form for the context tree

	separator1, separator2: THREE_D_SEPARATOR

	mode_box: ROW_COLUMN
			-- Box which contains current editing/executing mode
			-- contains actually two RADIO_BOX to look like
			-- a radio box in a row layout
	editing_box: RADIO_BOX
			-- Box containing the toggle button corresponding
			-- to the editing mode
	executing_box: RADIO_BOX
			-- Box containing the toggle button corresponding
			-- to the executing mode

		--| Split window
	main_split_window,
			-- Main split window
	top_split_window,
			-- Top split window containing the context tree and `context_split_window'
	bottom_split_window,
			-- Bottom split window containing `command_split_window' and the command text editor
	context_split_window,
			-- Contain context catalog and context editor
	command_split_window: SPLIT_WINDOW
			-- Contain command catalog and command instance editor

		--| Split window children
	top_split_form,
			-- Top frame in `main_split_window'
	bottom_split_form,
			-- Bottom frame in `main_split_window'
	context_tree_split_form,
			-- Form enclosing the context tree
	context_split_form,
			-- Form enclosing the bottom frame of `top_split_window'
	context_editor_split_form,
			-- Form enclosing the context editor
	context_catalog_split_form,
			-- Form enclosing the context catalog
	command_split_form,
			-- Form enclosing the top frame of `bottom_split_window'
	command_catalog_split_form,
			-- Form enclosing the command catalog
	command_tool_split_form,
			-- Form enclosing the command instance editor
	command_editor_split_form: SPLIT_WINDOW_CHILD
			-- Form enclosing the command editor

	scrolled_w: SCROLLED_W
			-- Scrolled window in which `context_tree_widget' will appear
	
feature {COMMAND_TOOL_WIDGET}

	command_editor: COMMAND_EDITOR
			-- Command editor included in main panel

feature -- Graphical interface

		--| Menu row
	menu_bar: BAR
	file_category: MENU_PULL
	view_category: MENU_PULL
	help_category: MENU_PULL
	action_category: MENU_PULL
		--| Entries in the File category
	generate_menu_entry: PUSH_B
	import_menu_entry: PUSH_B
	menu_separator: SEPARATOR
	exit_menu_entry: PUSH_B
		--| Entries in the Actions category
	create_command_entry: NEW_COMMAND_BUTTON
		--| Entries in the View category
	context_sub_menu: MENU_PULL
	command_sub_menu: MENU_PULL
	context_catalog_entry: CONTEXT_CATALOG_ENTRY
	context_editor_entry: CONTEXT_EDITOR_ENTRY
	context_tree_entry: CONTEXT_TREE_ENTRY
	history_window_entry: HISTORY_WINDOW_ENTRY
	command_catalog_entry: COMMAND_CATALOG_ENTRY
	command_tool_entry: INSTANCE_EDITOR_ENTRY
	command_editor_entry: COMMAND_EDITOR_ENTRY
	editors_entry: EDITORS_ENTRY
	application_editor_entry: APPLICATION_EDITOR_ENTRY
	interface_entry: INTERFACE_ENTRY
	interface_only_entry: INTERFACE_ONLY_ENTRY
	class_importer_entry: CLASS_IMPORTER_ENTRY
		--| Entries in the Help category
	-- None so far

		--| Button Row
	quit_b: CLOSE_WINDOW_BUTTON
			-- `Quit' button
	cut_b: CUT_HOLE
			-- `Trash' button
	namer_b: NAMER_HOLE
			-- `Renamer' button
	help_b: HELP_HOLE
			-- `Help' button
	con_b: CON_ED_HOLE
			-- `Context editor' button
	cmd_b: CMD_ED_HOLE
			-- `Command editor' button
	state_b: STATE_ED_HOLE
			-- `State editor' button
	generate_b: GENERATE_BUTTON
			-- `Generate Eiffel code' button
	import_b: IMPORT_BUTTON
			-- `Import' button
	execute_b: 	TOGGLE_B
			-- Button to switch to Execution mode
	edit_b: TOGGLE_B
			-- Button to switch to Editing mode
	current_state_hole: STATE_HOLE
			-- Hole used to change current state.
	current_state_label: LABEL
			-- Label displaying the current state.
	save_b: SAVE_BUTTON
			-- Button to save current project
	v_separator_1, v_separator_2, v_separator_3: THREE_D_SEPARATOR
			-- Vertical separators between menu buttons

		--| Split Window
	vertical_separator: THREE_D_SEPARATOR
			-- Separator between the context tree and the context tree buttons
	raise_widget_hole: RAISE_WIDGET_HOLE
			-- Hole used to raise a widget
	show_window_hole: SHOW_WINDOW_HOLE
			-- Hole used to show or hide a window
	expand_parent_hole: EXPAND_PARENT_HOLE
			-- Hole used to expand the parent tree in the context tree
	context_tree_widget: CONTEXT_TREE
			-- Context tree
	context_catalog_widget: CONTEXT_CATALOG
			-- Context catalog
	command_catalog_widget: COMMAND_CATALOG
			-- Command catalog
	command_tool: COMMAND_TOOL_WIDGET
			-- Command tool included in main panel.
	context_editor: CONTEXT_EDITOR_WIDGET
			-- Context editor included in main panel.

feature 

	set_title (s: STRING) is 
			-- Set the title of the main panel.
		do 
			base.set_title (s)
			base.set_icon_name (s)
		end

	set_project_initialized is 
			-- Set project_initialized to True.
		do 		
			project_initialized := True 
--			enable_toggle_buttons
		end

	unset_project_initialized is 
			-- Set project_initialized to False.
		do 		
			project_initialized := False 
			set_title (Widget_names.main_panel)
--			disable_toggle_buttons
		end

feature -- Realization

	realize is
		do
			base.realize
			context_catalog_widget.realize
			context_tree_widget.realize
			command_catalog.realize
			hide_context_tree
			show_context_tree
		end

feature -- Closing Current

	work (arg: ANY) is 
			-- We have to use `changing_mode' the way it is done because
			-- since we used add_value_changed_action on both TOGGLE_B `edit_b'
			-- and `execute_b', disarm one of them will trigger another event
			-- value_changed and call again this command.
		do 
			if arg = edit_b and not changing_mode then
				changing_mode := True
				execute_b.disarm
				set_mode (editing_mode)
			elseif arg = execute_b and not changing_mode then
				changing_mode := True
				edit_b.disarm
				set_mode (executing_mode)
			end
			changing_mode := False
		end

	save_question: BOOLEAN

	close is 
		do
			if history_window.saved_application then
				question_box.popup (Current, Messages.exit_qu, Void)
			else
				save_question := True
				question_box.popup (Current, Messages.save_project_qu, Void)
			end
		end

	question_ok_action, close_without_any_check is
		local
			save_proj: SAVE_PROJECT
			quit_app_com: QUIT_NOW_COM
		do
			if save_question then
				!!save_proj
				save_proj.execute (Void)
				save_question := False
				question_box.popup (Current, Messages.exit_qu, Void)
			else
				discard_license
				!! quit_app_com
				quit_app_com.execute (Void)
			end
		end

	question_cancel_action is
		do
			if save_question then
				save_question := False
				question_box.popup (Current, Messages.exit_qu, Void)
			end
		end

	popuper_parent: COMPOSITE is
		do
			Result := base
		end

feature -- Popup and popdown actions

	was_popped_down: BOOLEAN

	popup is
		do
			hide_show_windows.show
		end

	popdown is
		do
			hide_show_windows.hide
		end

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
	
feature -- Enabel/Disable buttons

	enable_buttons is
			-- Enable all buttons on Main Panel.
		do
-- 			quit_b.set_sensitive
-- 			create_proj_b.set_sensitive
-- 			cut_b.set_sensitive
-- 			namer_b.set_sensitive
-- 			help_b.set_sensitive
-- 			con_b.set_sensitive
-- 			cmd_b.set_sensitive
-- 			cmdi_b.set_sensitive
-- 			state_b.set_sensitive
-- 			generate_b.set_sensitive
-- 			import_b.set_sensitive
-- 			save_b.set_sensitive
-- 			save_as_b.set_sensitive
-- 			load_proj_b.set_sensitive
		end

	disable_buttons is
			-- Disable all buttons on Main Panel except Exit button.
		do
-- 			quit_b.set_insensitive
-- 			create_proj_b.set_insensitive
-- 			cut_b.set_insensitive
-- 			namer_b.set_insensitive
-- 			help_b.set_insensitive
-- 			con_b.set_insensitive
-- 			cmd_b.set_insensitive
-- 			cmdi_b.set_insensitive
-- 			state_b.set_insensitive
-- 			generate_b.set_insensitive
-- 			import_b.set_insensitive
-- 			save_b.set_insensitive
-- 			save_as_b.set_insensitive
-- 			load_proj_b.set_insensitive
		end

feature -- Hide/Show Context tree

	hide_context_tree is
			-- Hide context tree.
		do
			context_tree_split_form.unmanage
			if not context_split_form.managed then
				top_split_form.unmanage
			end
		end

	show_context_tree is
			-- Show_context_tree.
		do
			if not context_split_form.managed then
				top_split_form.manage
			end
			context_tree_split_form.manage
		end

feature -- Hide/Show Context split form

	hide_context_split_form is
			-- Hide `context_split_form'.
		do
			context_split_form.unmanage
			if not context_tree_split_form.managed then
				top_split_form.unmanage
			end
		end

	show_context_split_form is
			-- Show `context_split_form'.
		do
			if not context_tree_split_form.managed then
				top_split_form.manage
			end
			context_split_form.manage
		end

feature -- Hide/Show Context catalog	

	hide_context_catalog is
			-- Hide Context Catalog.
		do
			context_catalog_split_form.unmanage
			if not context_editor_split_form.managed then
				hide_context_split_form
			end	
		end

	show_context_catalog is
			-- Show Context Catalog.
		do
			if not context_editor_split_form.managed then
				show_context_split_form
			end
			context_catalog_split_form.manage
		end

feature -- Hide/Show context editor

	hide_context_editor is
			-- Hide context editor
		do
			context_editor_split_form.unmanage
			if not context_catalog_split_form.managed then
				hide_context_split_form
			end
		end

	show_context_editor is
			-- Show context editor
		do
			if not context_catalog_split_form.managed then
				show_context_split_form
			end
			context_editor_split_form.manage
		end

feature -- Hide/Show `command split form'

	hide_command_split_form is
			-- Hide `command_split_form'.
		do
			command_split_form.unmanage
			if not command_editor_split_form.managed then
				bottom_split_form.unmanage
			end
		end

	show_command_split_form is
			-- Show `command_split_form'.
		do
			if not command_editor_split_form.managed then
				bottom_split_form.manage
			end
			command_split_form.manage
		end

feature -- Hide/Show Command catalog

	hide_command_catalog is
			-- Hide command catalog.
		do
			command_catalog_split_form.unmanage
			if not command_tool_split_form.managed then
				hide_command_split_form
			end				
		end

	show_command_catalog is
			-- Show command catalog.
		do
			if not command_tool_split_form.managed then
				show_command_split_form
	  		end
			command_catalog_split_form.manage
		end

feature -- Hide/Show Instance editor

	hide_command_tool is
			-- Hide instance editor.
		do
			command_tool_split_form.unmanage
			if not command_catalog_split_form.managed then
				hide_command_split_form
			end
		end

	show_command_tool is
			-- Show instance editor.
		do
			if not command_catalog_split_form.managed then
				show_command_split_form
			end
			command_tool_split_form.manage
		end

feature -- Hide/Show Command editor

	hide_command_editor is
			-- Hide Command editor.
		do
 			base.set_height (form.height - command_editor_split_form.height)
			form.set_height (base.height)
			command_editor_split_form.unmanage
			if not command_tool_split_form.managed then
				bottom_split_form.unmanage
			end
		end

	show_command_editor is
			-- Show command editor.
		do
				--| at the beginning, to have the precedent height of 'command_split_form'
			bottom_split_window.set_proportion (100 * command_split_form.height //
 					(command_split_form.height + resources.cmd_ed_height))
 			base.set_height (base.height + resources.cmd_ed_height)
			form.set_height (base.height)
			if not command_split_form.managed then
				bottom_split_form.manage
			end
			command_editor_split_form.manage
		end

feature -- Access

	command_editor_shown: BOOLEAN is
			-- Is context editor shown?
		do
			Result := command_editor_split_form.managed
		end

feature -- Raise

	raise is
			-- Raise main panel
		do
			base.raise
		end

feature {NONE} -- Size attributes

--	context_tree_height,
			-- Backup of context tree height

--	context_catalog_width,
			-- Backup of context catalog width

--	top_split_form_height,
			-- Backup of bottom split form height

--	command_catalog_width: INTEGER
			-- Backup of command catalog width

feature -- Current state

	current_state: BUILD_STATE
			-- Current state

	set_current_state (s: BUILD_STATE) is
			-- Set `current_state' to `s'.
		do
			current_state := s
			current_state_label.set_text (s.label)
		end

feature -- Enable/Disable EiffelBuild

	enable is
			-- Enable widgets of Main Panel and popup previously
			-- hidden tools.
		do
			menu_bar.set_sensitive
		end

	disable is
			-- Disable all widgets of Main Panel and popdown
			-- every tools.
		do
			menu_bar.set_insensitive
		end

feature -- Closing Current



end
