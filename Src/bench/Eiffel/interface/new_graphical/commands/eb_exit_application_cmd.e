indexing
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXIT_APPLICATION_CMD

inherit
--	GRAPHICS
	PROJECT_CONTEXT
	SHARED_APPLICATION_EXECUTION
	EV_COMMAND
		redefine
--			license_checked
		end
--	WARNER_CALLBACKS
--		rename
--			execute_warner_help as exit_anyway,
--			execute_warner_ok as do_not_exit
--		end
	EB_SHARED_INTERFACE_TOOLS
	INTERFACE_NAMES

feature -- Callbacks

	exit_anyway is
		local
--			mp: MOUSE_PTR
		do
			if Application.is_running then
				Application.kill
			end
--			discard_licenses

			if Project_tool.initialized then
				Project_tool.save_environment
			end
				-- exit not reachable now.
			project_tool.destroy
--			exit
		end

feature -- License managment
	
	license_checked: BOOLEAN is True
			-- Is the license checked.

feature -- Properties

--	symbol: EV_PIXMAP is 
--			-- Pixmap for the button.
--		once 
--			Result := Pixmaps.bm_Quit 
--		end
	
feature {NONE} -- Implementation

	execute (arg: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
			-- Quit project after saving.
		local
			wd: EV_WARNING_DIALOG
		do
			if arg = Void then
				if 
					Project_tool.initialized and then
					tool_supervisor.has_modified_editor_tools
				then
					create wd.make_with_text (project_tool.parent, t_Confirm, "Some files have not been saved.%NDo you want to save them?")
					wd.show_yes_no_cancel_buttons
					wd.add_yes_command(Current, save_and_exit)
					wd.add_no_command(Current, do_exit)
					wd.show
				else
					create wd.make_with_text (project_tool.parent, t_Confirm, "Quit EiffelBench?")
					wd.show_ok_cancel_buttons
					wd.add_ok_command(Current, do_exit)
					wd.show
				end
			elseif arg = do_exit then
				exit_anyway
			else
				tool_supervisor.save_all_editors
				exit_anyway
			end
		end

feature {NONE} -- Attributes

	save_and_exit : EV_ARGUMENT1 [ANY] is
		once
			create Result.make (Void)
		end

	do_exit : EV_ARGUMENT1 [ANY] is
		once
			create Result.make (Void)
		end

--	name: STRING is
--			-- Name of the command.
--		do
--			Result := Interface_names.f_Exit_project
--		end

--	menu_name: STRING is
--			-- Name used in menu entry
--		do
--			Result := Interface_names.m_Exit_project
--		end

--	accelerator: STRING is
--			-- Accelerator action for menu entry
--		do
--		end
--
end -- class EB_EXIT_APPLICATION_CMD
