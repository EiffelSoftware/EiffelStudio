
-- Command to quit the Eiffel workbench

class QUIT_PROJECT 

inherit

	PROJECT_CONTEXT;
	SHARED_WORKBENCH;
	SHARED_DEBUG;
	ICONED_COMMAND
		redefine
			licence_checked
		end

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

		do
			if project_tool.initialized then
				-- Project_file is not void
				if last_confirmer /= Void and argument = last_confirmer then
					set_global_cursor (watch_cursor);
					project_tool.set_changed (false);
					restore_cursors;
					quit_cmd.exit_now;
					discard_licence;
					exit
				else
					confirmer (text_window).call (Current, 
						"Do you really want to exit?", "Exit");
				end
			else
				discard_licence;
				exit
			end;
		end;

feature -- Licence managment
	
	licence_checked: BOOLEAN is True;

feature 

	symbol: PIXMAP is 
		once 
			Result := bm_Quit 
		end;
 
	
feature {NONE}

	command_name: STRING is do Result := l_Exit_project end

end
