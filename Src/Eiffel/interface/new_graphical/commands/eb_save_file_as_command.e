indexing
	description	: "Command to save a file under a different name."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	EB_SHARED_PREFERENCES
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
			on_text_reset, on_text_edited,
			on_text_back_to_its_last_saved_state,
			on_text_fully_loaded
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

	on_text_back_to_its_last_saved_state is
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

	on_text_fully_loaded is
			-- Enable `Current'.
		do
			enable_sensitive
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
				if to_write.item (to_write.count) /= '%N' then 
						-- Add a carriage return like `vi' if there's none at the end 
					to_write.extend ('%N')
				end
				if preferences.misc_data.text_mode_is_windows then
					to_write.replace_substring_all ("%N", "%R%N")
				end
				new_file.put_string (to_write)
			end
			new_file.close
		end

feature {EB_SAVE_FILE_COMMAND} -- Implementation

	execute_with_dialog (argument: EB_FILE_SAVE_DIALOG) is
			-- Save a file with the chosen name.
		local
			fsd: EB_FILE_SAVE_DIALOG
			l_env: EXECUTION_ENVIRONMENT
			l_dir: STRING
		do
			if argument = Void then
				create fsd.make_with_preference (preferences.dialog_data.last_saved_save_file_as_directory_preference)
				fsd.save_actions.extend (agent execute_with_dialog (fsd))
				create l_env
				l_dir := l_env.current_working_directory
				fsd.show_modal_to_window (window_manager.last_focused_development_window.window)
				l_env.change_working_directory (l_dir)
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

end -- class EB_SAVE_FILE_AS_COMMAND
