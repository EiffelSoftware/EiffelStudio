indexing
	description: "Toolbar of the main window."
	Id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	MAIN_TOOLBAR

inherit
	EB_HORIZONTAL_TOOLBAR
		redefine
			make
		end

	WINDOWS

creation
	make

feature {NONE}-- Initialization

	make (par: EV_CONTAINER) is
		local
			v_separator: EV_VERTICAL_SEPARATOR
		do
			{EB_HORIZONTAL_TOOLBAR} Precursor (par)
			create create_proj_b.make (Current)
			create load_proj_b.make (Current)
			create save_b.make (Current)
			create import_b.make (Current)
			create v_separator.make (Current)
			create execute_b.make (Current)
			create v_separator.make (Current)
			create help_b.make (Current)
			create namer_b.make (Current)
			create cut_b.make (Current)
			create v_separator.make (Current)
			create con_b.make (Current)
			create cmd_b.make (Current)
			create current_state_hole.make (Current)
			create current_state_label.make (Current)
			set_values
			set_callbacks
		end

	set_values is
		do
			set_spacing (3)
			execute_b.set_minimum_width (27)
			execute_b.set_expand (False)
		end

	set_callbacks is
		local
			cmd: EV_ROUTINE_COMMAND
-- 			change_mode_cmd: CHANGE_MODE_CMD
		do
			create cmd.make (~process_help)
			help_b.add_default_pnd_command (cmd, Void)
-- 			!! change_mode_cmd
-- 			execute_b.add_value_changed_action (change_mode_cmd, execute_b)
-- 			edit_b.add_value_changed_action (change_mode_cmd, edit_b)
		end

feature {MAIN_TOOLBAR} -- Help display

	process_help (arg: EV_ARGUMENT; ev_data: EV_PND_EVENT_DATA) is
		local
			hw: HELP_WINDOW
		do
			create hw.make (main_window)
			hw.update_text (arg, ev_data)
			hw.show
		end

feature -- Enabel/Disable buttons

	enable is
			-- Enable all buttons in the buttons menu.
		do
			create_proj_b.set_insensitive (False)
			load_proj_b.set_insensitive (False)
			cut_b.set_insensitive (False)
			namer_b.set_insensitive (False)
			help_b.set_insensitive (False)
			con_b.set_insensitive (False)
			cmd_b.set_insensitive (False)
			import_b.set_insensitive (False)
			current_state_hole.set_insensitive (False)
		end

	disable is
			-- Disable all buttons in the buttons menu except Save button.
		do
			create_proj_b.set_insensitive (True)
			load_proj_b.set_insensitive (True)
			cut_b.set_insensitive (True)
			namer_b.set_insensitive (True)
			help_b.set_insensitive (True)
			con_b.set_insensitive (True)
			cmd_b.set_insensitive (True)
			import_b.set_insensitive (True)
			current_state_hole.set_insensitive (True)
		end

feature -- GUI attributes

	create_proj_b: CREATE_PROJ_BUTTON
			-- Create new project button
	load_proj_b: LOAD_PROJ_BUTTON
			-- Retrieve project button
	save_b: SAVE_BUTTON
			-- Button to save current project
	import_b: IMPORT_BUTTON
			-- `Import' button

	execute_b: 	EV_TOGGLE_BUTTON
			-- Button to switch to Execution mode

	help_b: HELP_HOLE
			-- `Help' button
	namer_b: NAMER_HOLE
			-- `Renamer' button
	cut_b: CUT_HOLE
			-- `Trash' button

	con_b: CON_ED_HOLE
			-- `Context editor' button
	cmd_b: CMD_ED_HOLE
			-- `Command editor' button
	current_state_hole: STATE_HOLE
			-- Hole used to change current state.
	current_state_label: EV_LABEL
			-- Label displaying the current state.

end -- class MAIN_TOOLBAR

