
-- Command to quit the Eiffel workbench

class QUIT_PROJECT 

inherit

	PROJECT_CONTEXT;
	SHARED_WORKBENCH;
	ICONED_COMMAND

creation

	make
	
feature 

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
		do
			init (c, a_text_window)
		end;
	
feature {NONE}

	work (argument: ANY) is
			-- Quit project after saving.
		local
			file: UNIX_FILE
		do
			if project_tool.initialized then
				-- Project_file is not void
				set_global_cursor (watch_cursor);
				project_tool.set_changed (false);
				System.server_controler.wipe_out;
				!!file.make (Project_file_name);
				file.open_write;
				Workbench.basic_store (file);
				file.close;
				restore_cursors
			end;
			exit
		end;

	
feature 

	symbol: PIXMAP is 
		once 
			!!Result.make; 
			Result.read_from_file (bm_Quit) 
		end;
 
	
feature {NONE}

	command_name: STRING is do Result := l_Exit_project end

end
