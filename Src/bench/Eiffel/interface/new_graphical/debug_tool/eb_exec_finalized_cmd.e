indexing
	description: "Command to execute the finalized code."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXEC_FINALIZED_CMD

inherit
	EB_TOOL_COMMAND
	PROJECT_CONTEXT
		export
			{NONE} all
		end
	SHARED_EIFFEL_PROJECT

	NEW_EB_CONSTANTS

creation
	make

feature {NONE} -- Execution

	execute (argument: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
			-- Execute Current.
		local
			appl_name: STRING
			cmd_exec: EXTERNAL_COMMAND_EXECUTOR
			f: RAW_FILE
			f_name: FILE_NAME
			make_f: INDENT_FILE
--			mp: MOUSE_PTR
			system_name: STRING
			wd: EV_WARNING_DIALOG
		do
			if Eiffel_project.initialized and then Eiffel_project.system_defined then
				system_name := clone (Eiffel_system.name)
			end
			if system_name = Void then
				create wd.make_default (tool.parent, Interface_names.t_Warning,
					Warning_messages.w_Must_finalize_first)
			else
				appl_name := Eiffel_system.application_name (False)
				create f.make (appl_name)
				if not f.exists then
					create wd.make_default (tool.parent, Interface_names.t_Warning,
						Warning_messages.w_Unexisting_system)
				else
					create f_name.make_from_string (Final_generation_path)
					f_name.set_file_name (Makefile_SH)
					create make_f.make (f_name)
					if make_f.exists and then make_f.date > f.date then
						create wd.make_default (tool.parent, Interface_names.t_Warning,
							Warning_messages.w_MakefileSH_more_recent)
					else
--						create mp.set_watch_cursor
--						appl_name.extend (' ')
--						appl_name.append (argument_window.argument_list)
						create cmd_exec
						cmd_exec.execute (appl_name)
--						mp.restore
					end
				end
			end
		end

feature {NONE} -- Properties

	name: STRING is
			-- Short description of Current.
		do
			Result := Interface_names.f_Run_finalized
		end
		
	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Run_finalized
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

end -- class EB_EXEC_FINALIZED_CMD
