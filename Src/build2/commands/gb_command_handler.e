indexing
	description: "Objects that handle commands."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMMAND_HANDLER
	
inherit
	GB_ACCESSIBLE_XML_HANDLER
	
feature -- Access

	save_command: GB_FILE_SAVE_COMMAND is
			-- Command representing `Save'.
			-- Not sensitive by default.
		once
			create Result.make
		end
		
	new_project_command: GB_NEW_PROJECT_COMMAND is
			-- Command representing a new project.
		once
			create Result.make
		end
		
	project_settings_command: GB_SHOW_PROJECT_SETTINGS_COMMAND is
			-- Command representing `project settings'.
		once
			create Result.make
		end
		
	open_project_command: GB_FILE_OPEN_COMMAND is
			-- Command representing open project.
		once
			create Result.make
		end
		
	close_project_command: GB_CLOSE_PROJECT_COMMAND is
			-- Command representing close project.
		once
			create Result.make
		end
		
	show_history_command: GB_SHOW_HISTORY_COMMAND is
			-- Command representing display history.
		once
			create Result.make
		end
		
	delete_object_command: GB_DELETE_OBJECT_COMMAND is
			-- Command representing delete.
		once
			create Result.make
		end

feature -- Basic operation

	update is
			-- For every command in `all_commands',
			-- update their state.
		local
			current_command: EB_STANDARD_CMD
		do
			from
				all_commands.start
			until
				all_commands.off
			loop
				current_command := all_commands.item
				if current_command.executable then
					current_command.enable_sensitive
				else
					current_command.disable_sensitive
				end
				all_commands.forth
			end
		end
		

feature {NONE} -- Implementation


	all_commands: ARRAYED_LIST [EB_STANDARD_CMD] is
			-- All the commands accessible through `Current'.
			-- This assumes that the commands are static and no new
			-- commands are created during the programs execution.
		once
			create Result.make (0)
			Result.extend (save_command)
			Result.extend (new_project_command)
			Result.extend (project_settings_command)
			Result.extend (open_project_command)
			Result.extend (close_project_command)
			Result.extend (show_history_command)
			Result.extend (delete_object_command)
		end
		

end -- class GB_COMMAND_HANDLER
