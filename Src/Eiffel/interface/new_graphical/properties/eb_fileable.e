indexing
	description	: "Tool or window associated with a text file."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

deferred class
	EB_FILEABLE

inherit
	EB_STONABLE

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

feature -- Access

	stone: STONE
			-- Stone for current.

	file_name: FILE_NAME
			-- Name of the file being displayed.
			-- This attribute is useful when `stone'
			-- is Void (this case occurs after loading
			-- a file with the "open" command, or after
			-- saving a file with the "save as" command).

	last_saving_date: INTEGER is
			-- Date of last save
		require
			file_name_not_void: file_name /= Void
		do
			Result := internal_last_saving_date
		end

	changed: BOOLEAN is
			-- Has the content changed since last save?
		deferred
		end

	is_empty: BOOLEAN is
			-- Does `Current' have no text loaded?
		deferred
		end

	text: STRING_32 is
			-- Text representing Current
		deferred
		end

	encoding: ENCODING
			-- Encoding in which text is saved.
		deferred
		end

	last_save_failed: BOOLEAN

feature -- Status Settings

	set_file_name (a_filename: FILE_NAME) is
			-- Make `f' the name of the file associated with tool.
			-- If `f' is Void, the tool is associated with no file.
		do
			file_name := a_filename
		ensure
			file_name_set: equal (file_name, a_filename)
		end

	set_last_saving_date (a_timestamp: INTEGER) is
			--  make `a_timestamp' the value of `last_saving_date'
		require
			file_name_not_void: file_name /= Void
		do
			internal_last_saving_date := a_timestamp
		end

	set_stone (new_stone: STONE) is
			-- Make `s' the new value of stone.
			-- Change file name as a consequence, to keep invariant.
		local
			filed_stone: FILED_STONE
		do
			stone := new_stone
			filed_stone ?= new_stone
			if filed_stone /= Void then
				set_file_name_from_stone (filed_stone)
			else
				file_name := Void
			end
--| FIXME ARNAUD
--			if stone_b /= Void then
--				stone_b.set_pebble (new_stone)
--			end
--| END FIXME
		end

	set_last_save_failed (a_fail: BOOLEAN) is
			-- Set `last_save_failed' with `a_fail'.
		do
			last_save_failed := a_fail
		ensure
			set: a_fail = last_save_failed
		end

	reset_stone is
			-- Reset the stone to Void, without resetting display.
			-- Only usable for starting to edit a file without using stones.
		require
			file_being_edited: (file_name /= Void) and then (not file_name.is_empty)
		do
			stone := Void
		ensure
			stone = Void
		end

	on_text_saved is
			-- Notify the editor that the text has been saved.
		do
		end

feature {NONE} -- Status Settings

	set_file_name_from_stone (s: FILED_STONE) is
			-- Update `file_name' using information from `s'.
		local
			f: RAW_FILE
		do
			if (s = Void) or else (s.file_name = Void) then
				set_file_name (Void)
			else
				set_file_name (s.file_name)
				create f.make (file_name)
				if f.exists then
					set_last_saving_date (f.date)
				else
					set_file_name (Void)
				end
			end
		end

feature -- Basic Operations

	show_file (f: PLAIN_TEXT_FILE) is
			-- Display content of file `f' and its name as the title
			-- of the ancestor tool. Forget about clicking and stones.
		require
			file_no_void: f /= Void
			valid_file: f.exists and then f.is_readable and then f.is_plain
		local
			filename: FILE_NAME
		do
			f.open_read
			f.read_stream (f.count)
			f.close
			update_save_symbol
			create filename.make_from_string (f.name)
			set_file_name (filename)
			set_last_saving_date (f.date)
			reset_stone
		ensure
			up_to_date: not changed
			no_stone: stone = Void
		end

	reset is
			-- Reset the window contents.
		do
			update_save_symbol
		end

feature -- "Save command" related features

	update_save_symbol is
			-- Update the save symbol in tool.
		do
			if changed then
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

	save_all is
			-- Launch the save all command.
		do
			save_all_cmd.execute
		end

	perform_check_before_save is
			-- Perform checks, if any, before saving
		do
		end

	check_passed: BOOLEAN is
		do
			Result := True
		end

feature -- Commands

--	open_cmd: EB_OPEN_FILE_COMMAND
		-- Command to open a file in the tool
			-- patrickr Tuesday, 29 August 2006:
			-- at the moment the open command doesn't do anything usefull but it may
			-- be usefull later, that's why we keep it here

	save_cmd: EB_SAVE_FILE_COMMAND
			-- Command to save current text in the associated file.
			-- If no file is associated, `save_as_cmd' is executed.

	save_all_cmd: EB_SAVE_ALL_FILE_COMMAND
			-- Command t sava all tabs's text in the associated file.

feature {NONE} -- Execution

	take_focus is
			-- Check if a save has been by a different tool or editor.
			-- If yes, prompt user for updating text.
			-- This function is called when mouse cames on tool window.
		local
			f: PLAIN_TEXT_FILE
		do
			if file_name /= Void then
				create f.make (file_name)
				if f.exists and then f.date > last_saving_date then
					(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_question_prompt (interface_names.l_file_changed_by_other_tool, Void, agent revert, Void)
					set_last_saving_date (f.date)
				end
			end
		end

	revert is
			-- Upload text from file associated with Current
		local
			f: PLAIN_TEXT_FILE
		do
			create f.make (file_name)
			show_file (f)
			refresh
		end

feature {NONE} -- Implementation

	internal_last_saving_date: INTEGER;
			-- Date of last save

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_FILEABLE
