indexing
	description: "Command that checks if the working directory is a %
				% valid one."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	PERFORM_CHECKING_CMD

inherit

	WINDOWS

	ERROR_POPUPER
		redefine
			continue_after_error_popdown
		end

	CONSTANTS

feature

	execute is
			-- Check if the directory name has at least "EIFGEN".
			-- If so, open or create project.
		local
			dir_name: STRING
			open_cmd: OPEN_PROJECT
		do
			dir_name := environment.current_working_directory
			if dir_name.substring_index ("EIFGEN", 1) < 1 then
				error_box.popup (Current, messages.Eb_project_not_valid, dir_name)
			else
				if (tree = Void) then end
				if (context_catalog = Void) then end
				if (command_catalog = Void) then end
				if (history_window = Void) then end
				if (app_editor = Void) then end
				!! open_cmd
				open_cmd.execute (execution_environment.current_working_directory)
			end
		end

feature {NONE} -- Implementation

	continue_after_error_popdown is
		do
			main_panel.close_without_any_check
		end

	popuper_parent: COMPOSITE is
		do
			Result := main_panel.base
		end

end -- class PERFORM_CHECKING_CMD
