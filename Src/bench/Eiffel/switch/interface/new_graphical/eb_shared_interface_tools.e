indexing
	description	: "All shared access windows."
	date		: "$Date$"
	revision	: "$Revision $"

class
	EB_SHARED_INTERFACE_TOOLS

inherit
	EB_SHARED_OUTPUT_TOOLS

	SHARED_EIFFEL_PROJECT

	EB_SHARED_MANAGERS

feature -- Access

	progress_dialog: EB_PROGRESS_DIALOG is
			-- Progress dialog associated with the project.
			-- It can be a graphical one or a text mode one.
		do
			Result := progress_dialog_cell.item
		end

	has_modified_classes: BOOLEAN is
			-- Are there unsaved class texts in the interface?
		do
			if not mode.item then
				Result := Window_manager.has_modified_windows
			end
		end

feature {NONE} -- Element change

	set_output_manager (a_output_manager: EB_OUTPUT_MANAGER) is
			-- Set `a_output_manager' as Output manager for development windows
		do
			Output_manager_cell.put (a_output_manager)
		end

	set_recent_projects_manager (a_recent_projects_manager: EB_RECENT_PROJECTS_MANAGER) is
			-- Set `a_recent_projects_manager' as Recent projects manager for $EiffelGraphicalCompiler$
		do
			Recent_projects_manager_cell.put (a_recent_projects_manager)
		end

	set_degree_output (a_progress_dialog: DEGREE_OUTPUT) is
			-- Set `progress_dialog' to `a_progress_dialog'.
			-- Set also `Eiffel_project' progress_dialog which needs to know
			-- that we changed the kind of `progress_dialog'.
		do
			Eiffel_project.set_degree_output (a_progress_dialog)

				-- If `process_dialog' is a graphical dialog then
				-- Its parent has been specified.
		end

	set_progress_dialog (a_progress_dialog: EB_PROGRESS_DIALOG) is
			-- Set `progress_dialog' to `a_progress_dialog'.
			-- Set also `Eiffel_project' progress_dialog which needs to know
			-- that we changed the kind of `progress_dialog'.
		do
			progress_dialog_cell.put (a_progress_dialog)
		end

feature {NONE} -- Shared tools access

	dynamic_lib_window: EB_DYNAMIC_LIB_WINDOW is
			-- Unique assembly tool
		do
			Result := Dynamic_lib_window_cell.item
		end

	dynamic_lib_window_is_valid: BOOLEAN is
			-- Is the dynamic_lib window valid?
		do
			Result := (dynamic_lib_window /= Void) and then	(not dynamic_lib_window.destroyed)
		end

	system_window: EB_SYSTEM_WINDOW is
			-- Project configuration tool
		do
			Result := System_window_cell.item
		end

	system_window_is_valid: BOOLEAN is
			-- Is `system_window' valid?
		do
			Result := (system_window /= Void) and then	(not system_window.destroyed)
		end
		
feature {NONE} -- Shared tools change

	set_dynamic_lib_window (a_dynamic_lib_window: EB_DYNAMIC_LIB_WINDOW) is
			-- Makes `a_dynamic_lib_window' shared dynamic library tool.
		do
			Dynamic_lib_window_cell.put (a_dynamic_lib_window)
		end

	set_system_window (sw: EB_SYSTEM_WINDOW) is
			-- Makes `sw' shared system window.
		do
			System_window_cell.put (sw)
		end

feature {NONE} -- Implementation

	mode: BOOLEAN_REF is
			-- In text mode?
		once
			create Result
			Result.set_item (True)
		end

	Progress_dialog_cell: CELL [EB_PROGRESS_DIALOG] is
			-- Progress dialog associated with the project.
		once
			create Result.put (Void)
		end

	Dynamic_lib_window_cell: CELL [EB_DYNAMIC_LIB_WINDOW] is
			-- Cell for the dynamic library window
		once
			create Result.put (Void)
		end

	System_window_cell: CELL [EB_SYSTEM_WINDOW] is
			-- Cell for system tool
		once
			create Result.put (Void)
		end

end -- class EB_SHARED_INTERFACE_TOOLS
