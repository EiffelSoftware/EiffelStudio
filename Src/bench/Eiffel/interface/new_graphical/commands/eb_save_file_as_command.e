indexing
	description	: "Command to save a file under a different name."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_SAVE_FILE_AS_COMMAND

inherit
	EB_FILEABLE_COMMAND

	EB_MENUABLE_COMMAND

	EB_CONSTANTS
		export
			{NONE} all
		end

	SYSTEM_CONSTANTS
		export
			{NONE} all
		end

	EB_GENERAL_DATA
		export
			{NONE} all
		end

	EB_FILE_OPENER_CALLBACK
		export
			{NONE} all
		end

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end

	TEXT_OBSERVER
		redefine
			on_text_reset,
			on_text_edited
		end

create
	make
	
feature -- Execution

	execute is
			-- Execute the command. Prompt the user for the new filenane and save it.
		do
			execute_with_dialog (Void)
		end

	execute_with_filename (new_filename: STRING) is
			-- Save a file with a chosen name.
		require
			valid_filename: new_filename /= Void and then not new_filename.is_empty
		local
			file_opener: EB_FILE_OPENER
		do
			create file_opener.make_with_parent (Current, new_filename, window_manager.last_focused_development_window.window)
		end

feature -- Status setting

	on_text_reset is
			-- Disable `Current'.
		do
			if target.is_empty then
				disable_sensitive
			else
				enable_sensitive
			end
		end

	on_text_edited (directly_edited: BOOLEAN) is
			-- Enable `Current'.
		do
			-- Do nothing
		end

feature {EB_FILE_OPENER} -- Callbacks

	save_file (new_file: RAW_FILE) is
		local
			to_write: STRING
		do
			to_write := target.text
			new_file.open_write
			if not to_write.is_empty then
				to_write.prune_all ('%R')
				if text_mode_is_windows then
					to_write.replace_substring_all ("%N", "%R%N")
					new_file.putstring (to_write)
				else
					new_file.putstring (to_write)
					if to_write.item (to_write.count) /= '%N' then 
						-- Add a carriage return like `vi' if there's none at the end 
						new_file.new_line
					end
				end
			end
			new_file.close
		end

feature {EB_SAVE_FILE_COMMAND} -- Implementation

	execute_with_dialog (argument: EV_FILE_SAVE_DIALOG) is
			-- Save a file with the chosen name.
		local
			fsd: EV_FILE_SAVE_DIALOG
		do
			if argument = Void then
				create fsd
				fsd.ok_actions.extend (agent execute_with_dialog (fsd))
				fsd.show_modal_to_window (window_manager.last_focused_development_window.window)
			else
				execute_with_filename (argument.file_name)
			end
		end

feature {NONE} -- Implementation

	menu_name: STRING is
			-- Name as it appears in the menu (with & symbol).
		do
			Result := Interface_names.m_Export_to
		end

feature -- Obsolete

	save_it (fn: STRING) is
			-- Save a file with a chosen name.
		obsolete "use `save_as' instead"
		do
			save_as (fn)
		end

	save_as (new_filename: STRING) is
			-- Save a file with a chosen name.
		obsolete "use `execute_with_filename' instead"
		do
			execute_with_filename (new_filename)
		end

end -- class EB_SAVE_FILE_AS_COMMAND
