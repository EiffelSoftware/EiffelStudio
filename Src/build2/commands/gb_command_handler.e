indexing
	description: "Objects that handle commands."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMMAND_HANDLER
	
inherit
	
	ANY
	
	GB_SHARED_XML_HANDLER
	
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
		
	object_editor_command: GB_OBJECT_EDITOR_COMMAND is
			-- Command representing a new object editor request.
		once
			create Result.make
		end
		
	show_hide_builder_window_command: GB_SHOW_HIDE_BUILDER_WINDOW_COMMAND is
			-- Command representing a show/hide builder window request.
		once
			create Result.make
		end
		
	show_hide_display_window_command: GB_SHOW_HIDE_DISPLAY_WINDOW_COMMAND is
			-- Command representing a show/hide display window request.
		once
			create Result.make
		end
		
	show_hide_component_viewer_command: GB_SHOW_HIDE_COMPONENT_VIEWER_COMMAND is
			-- Command representing a show/hide component viewer request.
		once
			create Result.make
		end
		
	redo_command: GB_REDO_COMMAND is
			-- Command representing a redo.
		once
			create Result.make
		end
		
	undo_command: GB_UNDO_COMMAND is
			-- Command representing undo.
		once
			create Result.make
		end
		
	generation_command: GB_GENERATION_COMMAND is
			-- Command representing code generation.
		once
			create Result.make
		end
		
	expand_layout_tree_command: GB_EXPAND_LAYOUT_TREE_COMMAND is
			-- Command representing expansion of the layout constructor.
		once
			create Result.make
		end
		
	collapse_layout_tree_command: GB_COLLAPSE_LAYOUT_TREE_COMMAND is
			-- Command representing collapse of the layout constructor.
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
		

feature {GB_MAIN_WINDOW} -- Implementation


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
			Result.extend (object_editor_command)
			Result.extend (undo_command)
			Result.extend (redo_command)
			Result.extend (generation_command)
		end
		

end -- class GB_COMMAND_HANDLER
