note
	description: "Shared Commands for all windows and tools."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision	: "$Revision$"

class
	EB_SHARED_GRAPHICAL_COMMANDS

feature -- Commands

	Wizard_precompile_cmd: EB_WIZARD_PRECOMPILE_COMMAND
			-- Command to launch the "Precompilations Wizard".
		once
			create Result
			Result.enable_sensitive
		end

	New_development_window_cmd: EB_NEW_DEVELOPMENT_WINDOW_COMMAND
			-- Command to create a new development window.
		once
			create Result.make
			Result.enable_sensitive
		end

	Exit_application_cmd: EB_EXIT_APPLICATION_COMMAND
			-- Command to end the current application.
		once
			create Result
			Result.enable_sensitive
		end

	Run_project_cmd: EB_EXEC_DEBUG_CMD
			-- Command to run a system.
		once
			create Result.make
			Result.disable_sensitive
		end

	Run_workbench_cmd: EB_EXEC_WORKBENCH_CMD
			-- Command to run the workbench project.
		once
			create Result.make
			Result.disable_sensitive
		end

	Run_finalized_cmd: EB_EXEC_FINALIZED_CMD
			-- Command to run the finalized project.
		once
			create Result.make
			Result.disable_sensitive
		end

	Override_scan_cmd: EB_OVERRIDE_SCAN_COMMAND
			-- Command to check override clusters for changes and recompile.
		once
			create Result.make
			Result.disable_sensitive
		end

	Discover_melt_cmd: EB_DISCOVER_AND_MELT_COMMAND
			-- Command to find unreferenced externally added classes and recompile.
		once
			create Result.make
			Result.disable_sensitive
		end

	Melt_project_cmd: EB_MELT_PROJECT_COMMAND
			-- Command to melt a system.
		once
			create Result.make
			Result.disable_sensitive
		end

	Freeze_project_cmd: EB_FREEZE_PROJECT_COMMAND
			-- Command to freeze a system.
		once
			create Result.make
			Result.disable_sensitive
		end

	Precompilation_cmd: EB_PRECOMPILE_PROJECT_COMMAND
			-- Command to precompile a system.
		once
			create Result.make
			Result.disable_sensitive
		end

	Finalize_project_cmd: EB_FINALIZE_PROJECT_COMMAND
			-- Command to finalize a system.
		once
			create Result.make
			Result.disable_sensitive
		end

	Project_cancel_cmd: EB_PROJECT_CANCEL_COMMAND
			-- Command to cancel any ongoing project computation such as compilation and diagram rebuilding.
		once
			create Result
			Result.disable_sensitive
		end

	clean_compile_project_cmd: EB_CLEAN_COMPILE_PROJECT_COMMAND
			-- Command to compile from scratch a project.
		once
			create Result.make
			Result.enable_sensitive
		end

	analyze_cmd: ES_CODE_ANALYSIS_COMMAND
			-- Command to analyze last item.
		once
			create Result.make
			Result.disable_sensitive
		end

	analyze_editor_cmd: ES_CODE_ANALYSIS_ANALYZE_EDITOR_COMMAND
			-- Command to analyze editor item.
		once
			create Result.make
			Result.disable_sensitive
		end

	analyze_parent_cmd: ES_CODE_ANALYSIS_ANALYZE_PARENT_COMMAND
			-- Command to analyze parent cluster.
		once
			create Result.make
			Result.disable_sensitive
		end

	analyze_target_cmd: ES_CODE_ANALYSIS_ANALYZE_TARGET_COMMAND
			-- Command to analyze current target.
		once
			create Result.make
			Result.disable_sensitive
		end

	analyzer_preferences_cmd: ES_CA_SHOW_PREFERENCES_COMMAND
			-- Command to set analyzer preferences.
		once
			create Result.make
		end

	Document_cmd: EB_DOCUMENTATION_WIZARD_COMMAND
			-- Command to generate the HTML documentation
		once
			create Result.make
			Result.disable_sensitive
		end

	Export_cmd: EXPORT_CMD
			-- Command to export XMI.
		once
			create Result.make
			Result.disable_sensitive
		end

	System_cmd: EB_SYSTEM_CMD
			-- Project setting command
		once
			create Result.make
			Result.disable_sensitive
		end

	System_information_cmd: EB_SYSTEM_INFORMATION_CMD
			-- Display system information in output tool
		once
			create Result.make
			Result.disable_sensitive
		end

	show_cloud_account_cmd: ES_CLOUD_ACCOUNT_CMD
			-- Display Cloud Account tool.
		once
			create Result.make
			Result.enable_sensitive
		end

	Show_preferences_cmd: EB_SHOW_PREFERENCES_COMMAND
			-- Command to Display the User Preferences Editor.
		once
			create Result.make
			Result.enable_sensitive
		end

	Show_settings_import_cmd: ES_SETTINGS_IMPORT_CMD
		once
			create Result.make
			Result.enable_sensitive
		end

	Terminate_c_compilation_cmd: EB_TERMINATE_C_COMPILATION_CMD
			--
		once
			create Result.make
			Result.disable_sensitive
		end

	Estudio_debug_cmd: ESTUDIO_DEBUG_CMD
			-- Show/Hide EiffelStudio self debug menu.
		once
			create Result.make
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
