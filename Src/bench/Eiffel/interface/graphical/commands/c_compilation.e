indexing

	description:
		"";
	date: "$Date$";
	revision: "$Revision$"

class C_COMPILATION

inherit

	ISE_COMMAND;
	SHARED_EIFFEL_PROJECT;
	WINDOWS;
	PROJECT_CONTEXT;
	EB_CONSTANTS

create
	make_workbench, 
	make_final

feature {NONE} -- Initialization

	make_workbench is
			-- Initialize Current to invoke C compilation
			-- in workbench mode.
		do
			is_workbench := True
		end;

	make_final is
			-- Initialize Current to invoke C compilation
			-- in finalize mode.
		do
			is_workbench := False
		end;

feature -- Access

	is_workbench: BOOLEAN
			-- Is Current command used for workbench C compilation

	name: STRING is
			-- Name of the command
		do
			if is_workbench then
				Result := Interface_names.f_Workbench_mode
			else
				Result := Interface_names.f_Final_mode
			end
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			if is_workbench then
				Result := Interface_names.m_Workbench_mode
			else
				Result := Interface_names.m_Final_mode
			end
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

feature -- Execution

	work (arg: ANY) is
			-- Execute the C compilation.
		local
			makefile_sh_name: FILE_NAME;
			file: PLAIN_TEXT_FILE
		do
			if is_workbench then
				create makefile_sh_name.make_from_string 
						(Workbench_generation_path);
			else
				create makefile_sh_name.make_from_string 
						(Final_generation_path);
			end;
			makefile_sh_name.set_file_name (Makefile_SH);
			create file.make (makefile_sh_name);
			if file.exists then
				Eiffel_project.call_finish_freezing (is_workbench)
			else
				warner (Project_tool.popup_parent).gotcha_call
					(Warning_messages.w_Makefile_does_not_exist 
						(makefile_sh_name))
			end
		end

end -- class C_COMPILATION
