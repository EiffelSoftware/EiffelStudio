indexing
	description: "Tool associated with a file."
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_EDIT_TOOL

inherit
	EB_MULTIFORMAT_TOOL
		redefine
			close_cmd, reset,
			build_text_area,
			stone, set_stone
		end

feature -- Access

	file_name: STRING
			-- Name of the file being displayed

	stone: FILED_STONE
			-- Stone in tool

feature -- Status Report

	last_saving_date: INTEGER
			-- Date of last save

feature -- Status Settings

	set_last_saving_date (i: INTEGER) is
			--  make `i' the value of `last_saving_date'
		do
			last_saving_date := i
		end

	set_file_name (f: STRING) is
			-- Make `f' the name of the file associated with tool.
			-- If `f' is Void, the tool is associated with no file.
		do
			file_name := f
		ensure
			file_name_set: equal (file_name, f)
		end

	set_stone (s: like stone) is
			-- Make `s' the new value of stone.
			-- Change file name as a consequence, to keep invariant.
		local
			f: RAW_FILE
		do
			Precursor (s)
			if s = Void then
				set_file_name (Void)
			else
				set_file_name (s.file_name)
				create f.make (file_name)
				set_last_saving_date (f.date)
			end
		end

feature -- Text area creation

	build_text_area is
			-- Create the text component where information will be displayed,
			-- and add event to set the save command sensitive when text is modified
		do
			create {EB_CLICKABLE_RICH_TEXT} text_area.make_from_tool (container, Current)
			check
				text_area_set: text_area /= Void
			end
			set_mode_for_editing
		end

feature -- Basic Operations

	show_file (f: PLAIN_TEXT_FILE) is
			-- Display content of file `f' and its name as the title
			-- of the ancestor tool. Forget about clicking and stones.
		require
			file_no_void: f /= Void
			valid_file: f.exists and then f.is_readable and then f.is_plain
		do
			f.open_read
			f.readstream (f.count)
			f.close
			text_area.clear_window
			show
			text_area.set_text (f.laststring)
			set_mode_for_editing
			update_save_symbol
			set_file_name (f.name)
			set_last_saving_date (f.date)
			set_title (f.name)
			reset_stone
			set_default_format
		ensure
			up_to_date: not text_area.changed
			no_stone: stone = Void
		end

	parse_file is 
			-- Parse the file if possible.
		require
			valid_stone: stone /= Void
		deferred
		end

	reset is
			-- Reset the window contents.
		do
			Precursor
			set_file_name (Void)
			update_save_symbol
		end

feature -- "Save command" related features

	update_save_symbol is
			-- Update the save symbol in tool.
		do
			save_cmd.set_insensitive (not text_area.changed)
		end

	save_text is
			-- launch the save command.
		do
			save_cmd.execute (Void, Void)
		end

feature {EB_TOOL_MANAGER} -- Commands

	close_cmd: EB_CLOSE_EDITOR_CMD
		-- Command to close the tool, after propting user
		-- for saving text if it has been changed.

	open_cmd: EB_OPEN_FILE_CMD
		-- Command to open a file in the tool

	save_cmd: EB_SAVE_FILE_CMD
		-- Command to save current text in the associated file.
		-- If no file is associated, `save_as_cmd' is executed.

feature {NONE} -- Execution

	take_focus (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Check if a save has been by a different tool or editor.
			-- If yes, prompt user for updating text.
			-- This function is called when mouse cames on tool window.
		local
			f: PLAIN_TEXT_FILE
			wd: EV_WARNING_DIALOG
			cmd: EV_ROUTINE_COMMAND
		do
			if file_name /= Void then
				create f.make (file_name)
				if f.date > last_saving_date then
					create wd.make_default (parent, "File changed", "File has been changed by another tool/editor%NDo you want to load the changes?")
					wd.show_yes_no_buttons
					create cmd.make (~revert)
					wd.add_yes_command (cmd, Void)
					set_last_saving_date (f.date)
				end
			end
		end

	revert (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- upload text from file associated with Current
		local
			f: PLAIN_TEXT_FILE
		do
			create f.make (file_name)
			show_file (f)
		end

invariant
	stone_and_file_consistent: (stone /= Void) implies equal (file_name, stone.file_name)

end -- class EB_EDIT_TOOL
