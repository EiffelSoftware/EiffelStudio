indexing

	description:	
		"Command to quit the Eiffel workbench.";
	date: "$Date$";
	revision: "$Revision$"

class QUIT_PROJECT 

inherit

	PROJECT_CONTEXT;
	SHARED_APPLICATION_EXECUTION;
	ICONED_COMMAND
		redefine
			licence_checked
		end;
	SHARED_DEBUG

creation

	make
	
feature -- Initialization

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
			-- Initialize the command.
		do
			init (c, a_text_window)
		end;

feature -- Licence managment
	
	licence_checked: BOOLEAN is True;
			-- Is the license checked.

feature -- Properties

	symbol: PIXMAP is 
			-- Pixmap for the button.
		once 
			Result := bm_Quit 
		end;
	
feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Quit project after saving.
		do
			if project_tool.initialized then
				-- Project_file is not void
				if last_warner /= Void and argument = last_warner then
					do_exit := false
				elseif 
					do_exit or else
					(last_confirmer /= Void and argument = last_confirmer)
				then
					set_global_cursor (watch_cursor);
					project_tool.set_changed (false);
					restore_cursors;
					if Application.is_running then
						Application.kill;
					end;
					discard_licence;
					exit
				elseif
					(window_manager.class_win_mgr.changed or
					system_tool.text_window.changed)
				then
					do_exit := true;
					warner (text_window).custom_call (Current,
						"Some files have not been saved.",
						"Don't exit", "Exit anyway", Void)
				else
					confirmer (text_window).call (Current, 
						"Do you really want to exit?", "Exit");
				end
			else
				discard_licence;
				exit
			end;
		end;

feature {NONE} -- Attributes

	do_exit: BOOLEAN;
			-- Should be called: `must_exit' OR comment has to change
			-- Do we really have to exit?

	command_name: STRING is
			-- Name of the command.
		do
			Result := l_Exit_project
		end;
 
end -- class QUIT_PROJECT
