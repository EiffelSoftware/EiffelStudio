indexing
	description	: "Shared Commands for all $EiffelGraphicalCompiler$ windows and tools."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_SHARED_GRAPHICAL_COMMANDS

inherit
	EB_SHARED_DEBUG_TOOLS

feature -- Commands

	Wizard_precompile_cmd: EB_WIZARD_PRECOMPILE_COMMAND is
			-- Command to launch the "Precompilations Wizard".
		once
			create Result
			Result.enable_sensitive
		end

	New_development_window_cmd: EB_NEW_DEVELOPMENT_WINDOW_COMMAND is
			-- Command to create a new development window.
		once
			create Result.make_with_style (0)
			Result.enable_sensitive
		end

	New_editor_cmd: EB_NEW_DEVELOPMENT_WINDOW_COMMAND is
			-- Command used to create a new window where the editor is maximized.
		once
			create Result.make_with_style (1)
			Result.enable_sensitive
		end

	New_context_tool_cmd: EB_NEW_DEVELOPMENT_WINDOW_COMMAND is
			-- Command used to create a new window where the context tool is maximized.
		once
			create Result.make_with_style (2)
			Result.enable_sensitive
		end

	Exit_application_cmd: EB_EXIT_APPLICATION_COMMAND is
			-- Command to end the current application.
		once
			create Result
			Result.enable_sensitive
		end

	Run_project_cmd: EB_EXEC_DEBUG_CMD is
			-- Command to run a system.
		once
			create Result.make (eb_debugger_manager)
			Result.disable_sensitive
		end

	Run_finalized_cmd: EB_EXEC_FINALIZED_CMD is
			-- Command to run the finalized project.
		once
			create Result.make
			Result.disable_sensitive
		end

	Melt_project_cmd: EB_MELT_PROJECT_COMMAND is
			-- Command to melt a system.
		once
			create Result.make
			Result.disable_sensitive
		end

	Quick_melt_project_cmd: EB_QUICK_MELT_COMMAND is
			-- Command to melt a system.
		once
			create Result.make
			Result.disable_sensitive
		end

	Freeze_project_cmd: EB_FREEZE_PROJECT_COMMAND is
			-- Command to freeze a system.
		once
			create Result.make
			Result.disable_sensitive
		end

	Precompilation_cmd: EB_PRECOMPILE_PROJECT_COMMAND is
			-- Command to precompile a system.
		once
			create Result.make
			Result.disable_sensitive
		end

	Finalize_project_cmd: EB_FINALIZE_PROJECT_COMMAND is
			-- Command to finalize a system.
		once
			create Result.make
			Result.disable_sensitive
		end

	Project_cancel_cmd: EB_PROJECT_CANCEL_COMMAND is
			-- Command to cancel any ongoing project computation such as compilation and diagram rebuilding.
		once
			create Result
			Result.disable_sensitive
		end

	Document_cmd: DOCUMENT_CMD is
			-- Command to generate the HTML documentation
		once
			create Result.make
			Result.disable_sensitive
		end

	Export_cmd: EXPORT_CMD is
			-- Command to export XMI.
		once
			create Result.make
			Result.disable_sensitive
		end

	System_cmd: EB_SYSTEM_CMD is
			-- Project setting command
		once
			create Result.make
			Result.disable_sensitive
		end

	Show_preferences_cmd: EB_SHOW_PREFERENCES_COMMAND is
			-- Command to Display the User Preferences Editor.
		once
			create Result.make
			Result.enable_sensitive
		end

	Terminate_c_compilation_cmd: EB_TERMINATE_C_COMPILATION_CMD is
			--
		once
			create Result.make
			Result.disable_sensitive
		end

	Estudio_debug_cmd: ESTUDIO_DEBUG_CMD is
			-- Show/Hide EiffelStudio self debug menu.
		once
			create Result
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EB_SHARED_GRAPHICAL_COMMANDS
