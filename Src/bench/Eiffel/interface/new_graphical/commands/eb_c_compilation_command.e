indexing
	description	: "Command to perform C compilation of the system"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_C_COMPILATION_COMMAND

inherit
	EB_DEVELOPMENT_WINDOW_COMMAND

	EB_MENUABLE_COMMAND

	SHARED_EIFFEL_PROJECT

	EB_SHARED_WINDOW_MANAGER

	PROJECT_CONTEXT

creation
	make_workbench, 
	make_finalized

feature {NONE} -- Initialization

	make_workbench (a_target: like target) is
			-- Initialize Current to invoke C compilation
			-- in workbench mode.
		do
			is_workbench := True
			make (a_target)
		end

	make_finalized (a_target: like target) is
			-- Initialize Current to invoke C compilation
			-- in finalize mode.
		do
			is_workbench := False
			make (a_target)
		end

feature -- Access

	is_workbench: BOOLEAN
			-- Is Current command used for workbench C compilation

feature -- Execution

	execute is
			-- Execute the C compilation.
		local
			makefile_sh_name: FILE_NAME
			file: PLAIN_TEXT_FILE
			wd: EV_WARNING_DIALOG
		do
			if is_workbench then
				create makefile_sh_name.make_from_string 
						(Workbench_generation_path)
			else
				create makefile_sh_name.make_from_string 
						(Final_generation_path)
			end
			makefile_sh_name.set_file_name (Makefile_SH)
			create file.make (makefile_sh_name)
			if file.exists then
				Eiffel_project.call_finish_freezing (is_workbench)
			else
				create wd.make_with_text (Warning_messages.w_Makefile_does_not_exist (makefile_sh_name))
				wd.show_modal_to_window (window_manager.last_focused_window.window)
			end
		end

feature {NONE} -- Implementation

	menu_name: STRING is
			-- Name as it appears in the menu (with & symbol).
		do
			if is_workbench then
				Result := Interface_names.m_Compilation_C_Workbench
			else
				Result := Interface_names.m_Compilation_C_Final
			end
		end

end -- class C_COMPILATION_COMMAND
