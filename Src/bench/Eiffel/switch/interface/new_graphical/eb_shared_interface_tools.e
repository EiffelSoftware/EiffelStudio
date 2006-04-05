indexing
	description	: "All shared access windows."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision $"

class
	EB_SHARED_INTERFACE_TOOLS

inherit
	EB_SHARED_OUTPUT_TOOLS

	SHARED_EIFFEL_PROJECT

	EB_SHARED_MANAGERS

	CONF_REFACTORING

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

	set_external_output_manager (a_external_output_manager: EB_EXTERNAL_OUTPUT_MANAGER) is
			-- Set `a_output_manager' as Output manager for development windows
		do
			External_output_manager_cell.put (a_external_output_manager)
		end

	set_c_compilation_output_manager(a_c_compilation_output_manager: EB_C_COMPILATION_OUTPUT_MANAGER) is
			-- Set `a_c_compilation_output_manager' as c compilation output manager for development windows.
		do
			c_compilation_output_manager_cell.put (a_c_compilation_output_manager)
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

	argument_dialog: EB_ARGUMENT_DIALOG is
			-- Project argument dialog
		do
			Result := Argument_dialog_cell.item
		end

	argument_dialog_is_valid: BOOLEAN is
			-- Is `argument_dialog' valid?
		do
			Result := (argument_dialog /= Void)
		end

feature {NONE} -- Shared tools change

	set_dynamic_lib_window (a_dynamic_lib_window: EB_DYNAMIC_LIB_WINDOW) is
			-- Makes `a_dynamic_lib_window' shared dynamic library tool.
		do
			Dynamic_lib_window_cell.put (a_dynamic_lib_window)
		end

	set_argument_dialog (a_argument_dialog: EB_ARGUMENT_DIALOG) is
			-- Makes 'a_argument_dialog' shared argument dialog.
		do
			Argument_dialog_cell.put (a_argument_dialog)
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

	Argument_dialog_cell: CELL [EB_ARGUMENT_DIALOG] is
			-- Cell for argument dialog
		once
			create Result.put (Void)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_SHARED_INTERFACE_TOOLS
