indexing
	description	: "Editable text window associated with a file."
	author		: "Christophe Bonnard"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_EDITABLE_WINDOW

inherit
	EB_TEXTABLE_WINDOW

feature -- Access

	file_name: STRING
			-- Name of the file being displayed.
			-- This attribute is useful when `stone'
			-- is Void (this case occurs after loading
			-- a file with the "open" command, or after
			-- saving a file with the "save as" command).

	stone: FILED_STONE
			-- Stone in tool.

	last_saving_date: INTEGER is
			-- Date of last save
		require
			file_name_not_void: file_name /= Void
		do
			Result := internal_last_saving_date
		end

feature -- Status Settings

	set_file_name (f: STRING) is
			-- Make `f' the name of the file associated with tool.
			-- If `f' is Void, the tool is associated with no file.
		do
			file_name := f
		ensure
			file_name_set: equal (file_name, f)
		end

	set_last_saving_date (a_timestamp: INTEGER) is
			--  make `a_timestamp' the value of `last_saving_date'
		require
			file_name_not_void: file_name /= Void
		do
			internal_last_saving_date := a_timestamp
		end

	set_stone (s: like stone) is
			-- Make `s' the new value of stone.
			-- Change file name as a consequence, to keep invariant.
		do
			if not equal (s, stone) then
				stone := s
				if s /= Void then
					add_to_history (s)
				end
			set_file_name_from_stone (s)
			if stone_b /= Void then
				stone_b.set_pebble (s)
			end
			synchronize
		end

	reset_stone is
			-- Reset the stone to Void, without resetting display.
			-- Only usable for starting to edit a file without using stones.
		require
			file_being_edited: (file_name /= Void) and then (not file_name.empty)
		do
			stone := Void
		ensure
			stone = Void
		end

feature {NONE} -- Status Settings

	set_file_name_from_stone (s: like stone) is
			-- Update `file_name' using information from `s'.
		local
			f: RAW_FILE
		do
			if (s = Void) or else (s.file_name = Void) then
				set_file_name (Void)
			else
				set_file_name (s.file_name)
				create f.make (file_name)
				set_last_saving_date (f.date)
			end
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
			enable_editable
			update_save_symbol
			set_file_name (f.name)
			set_last_saving_date (f.date)
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
			-- 
		do
			if file_name = Void then
				Precursor
			end
			update_save_symbol
		end

feature -- "Save command" related features

	update_save_symbol is
			-- Update the save symbol in tool.
		do
			if text_area.changed then
				save_cmd.enable_sensitive
			else
				save_cmd.disable_sensitive
			end
		end

	save_text is
			-- Launch the save command.
		do
			save_cmd.execute
		end

feature {EB_TOOL_MANAGER} -- Commands

	close_cmd: EB_CLOSE_EDITOR_CMD

	open_cmd: EB_OPEN_CMD
		-- Command to open a file in the tool

	save_cmd: EB_SAVE_CMD
		-- Command to save current text in the associated file.
		-- If no file is associated, `save_as_cmd' is executed.

feature {EB_TOOL_MANAGER} -- Menus Implementation

	fill_edit_menu (a_menu: EV_MENU) is
			-- Fill the menu edit with menu entries in `a_menu'
		local
			i: EV_MENU_ITEM
			edit_cmd: EB_TEXT_EDITION_CMD
			sep: EV_MENU_SEPARATOR
		do
			create edit_cmd.make (Current)
			create i.make_with_text (Interface_names.m_Windows_cut)
			a_menu.extend (i)
			i.select_actions.extend (edit_cmd~cut_selection)

			create edit_cmd.make (Current)
			create i.make_with_text (Interface_names.m_Windows_copy)
			a_menu.extend (i)
			i.select_actions.extend (edit_cmd~copy_selection)

			create edit_cmd.make (Current)
			create i.make_with_text (Interface_names.m_Windows_paste)
			a_menu.extend (i)
			i.select_actions.extend (edit_cmd~paste)
		end

feature {NONE} -- Execution

	take_focus is
			-- Check if a save has been by a different tool or editor.
			-- If yes, prompt user for updating text.
			-- This function is called when mouse cames on tool window.
		local
			f: PLAIN_TEXT_FILE
			qd: EV_QUESTION_DIALOG
		do
			if file_name /= Void then
				create f.make (file_name)
				if f.exists and then f.date > last_saving_date then
					create qd.make_with_text ("File has been changed by another tool/editor%NDo you want to load the changes?")
					qd.button ("Yes").select_actions.extend (~revert)
					qd.button ("Cancel").hide
					set_last_saving_date (f.date)
				end
			end
		end

	revert is
			-- upload text from file associated with Current
		do
			--| FIXME, to be implemented
		end

feature {NONE} -- Implementation

	internal_last_saving_date: INTEGER
			-- Date of last save

	stone_b : EV_TOOL_BAR_BUTTON

end -- class EB_EDIT_TOOL
