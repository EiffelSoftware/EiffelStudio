indexing
	description: "Command to execute the finalized code."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXEC_FINALIZED_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND

	PROJECT_CONTEXT
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	EB_SHARED_ARGUMENTS
		export
			{NONE} all
		end

	EB_CONSTANTS
		export
			{NONE} all
		end
	
	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end

creation
	make

feature -- Initialization

	make is
			-- Initialize `Current'.
		do
		end

feature -- Execution

	execute is
			-- Execute Current.
		local
			appl_name: STRING
			cmd_exec: COMMAND_EXECUTOR
			f: RAW_FILE
			f_name: FILE_NAME
			make_f: INDENT_FILE
			system_name: STRING
			wd: EV_WARNING_DIALOG
		do
			if Eiffel_project.initialized and then Eiffel_project.system_defined then
				system_name := clone (Eiffel_system.name)
			end
			if system_name = Void then
				create wd.make_with_text (Warning_messages.w_Must_finalize_first)
				wd.show_modal_to_window (window_manager.last_focused_development_window.window)
			else
				appl_name := Eiffel_system.application_name (False)
				create f.make (appl_name)
				if not f.exists then
					create wd.make_with_text (Warning_messages.w_Unexisting_system)
					wd.show_modal_to_window (window_manager.last_focused_development_window.window)
				else
					create f_name.make_from_string (Final_generation_path)
					f_name.set_file_name (Makefile_SH)
					create make_f.make (f_name)
					if make_f.exists and then make_f.date > f.date then
						create wd.make_with_text (Warning_messages.w_MakefileSH_more_recent)
						wd.show_modal_to_window (window_manager.last_focused_development_window.window)
					else
						appl_name.extend (' ')
						appl_name.append (current_cmd_line_argument)
						create cmd_exec
						cmd_exec.execute (appl_name)
					end
				end
			end
		end

feature -- Properties

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_run
		end

	description: STRING is
			-- Text describing `Current' in the customize tool bar dialog.
		do
			Result := Interface_names.f_Run_finalized
		end

	tooltip: STRING is
			-- Short description of Current.
		do
			Result := Interface_names.f_Run_finalized
		end

	name: STRING is "Run_final"
			-- Text internally defining Current.
		
	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Run_finalized
		end

end -- class EB_EXEC_FINALIZED_CMD
