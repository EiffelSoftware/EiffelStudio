indexing
	description: "Command to quit the Eiffel workbench."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLOSE_PROJECT_CMD

inherit
	GRAPHICS
	PROJECT_CONTEXT
	SHARED_APPLICATION_EXECUTION
	PIXMAP_COMMAND
		rename
			init as make
		redefine
			license_checked
		end
	WARNER_CALLBACKS
		rename
			execute_warner_help as exit_anyway,
			execute_warner_ok as do_not_exit
		end

creation
	make
	
feature -- Callbacks

	exit_anyway is
		local
			mp: MOUSE_PTR
		do
			if Application.is_running then
				Application.kill
			end
			discard_licenses

			if Project_tool.initialized then
				Project_tool.save_environment
			end
			exit
		end

	do_not_exit (argument: ANY) is
		do
			do_exit := false
		end

feature -- License managment
	
	license_checked: BOOLEAN is True
			-- Is the license checked.

feature -- Properties

	symbol: PIXMAP is 
			-- Pixmap for the button.
		once 
			Result := Pixmaps.bm_Quit 
		end
	
feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Quit project after saving.
		do
			if Project_tool.initialized then
				-- Project_file is not void
				if do_exit or else (last_confirmer /= Void and then argument = last_confirmer) then
					exit_anyway
				elseif
					window_manager.class_win_mgr.changed or else
					(is_system_tool_created and then system_tool.changed)
				then
					do_exit := True
					warner (popup_parent).custom_call (Current,
						"Some files have not been saved.",
						"Don't exit", "Exit anyway", Void)
				else
					confirmer (popup_parent).call (Current, 
						"Quit "+Interface_names.EiffelBench_name+"?", "Exit")
				end
			else
				if do_exit or else (last_confirmer /= Void and then argument = last_confirmer) then
					exit_anyway
				else
					confirmer (popup_parent).call (Current, 
						"Quit "+Interface_names.EiffelBench_name+"?", "Exit")
				end
			end
		end

feature {NONE} -- Attributes

	do_exit: BOOLEAN
			-- Should be called: `must_exit' OR comment has to change
			-- Do we really have to exit?

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.f_Exit_project
		end
 
	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Exit_project
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

end -- class EB_CLOSE_PROJECT_CMD
