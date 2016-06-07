note
	description: "Manages EiffelStudio tool and tool bar layouts"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_DEVELOPMENT_WINDOW_LAYOUT_MANAGER

inherit
	EB_RECYCLABLE
		redefine
			is_interface_usable,
			internal_detach_entities
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

	ES_EXCEPTION_HANDLER
		export
			{NONE} all
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_window: attached like development_window)
			-- Initializes the layout managed using an active development window.
			--
			-- `a_window': The window to managed a layout for.
		require
			a_window_is_interface_usable: a_window.is_interface_usable
		do
			development_window := a_window
		ensure
			development_window_set: development_window = a_window
		end

feature {NONE} -- Clean up

	internal_recycle
			-- <Precursor>
		do

		end

	internal_detach_entities
			-- <Precursor>
		do
			Precursor
			development_window := Void
		ensure then
			development_window_detached: development_window = Void
		end

feature -- Access

	development_window: detachable EB_DEVELOPMENT_WINDOW
			-- Window to perform layout rebuilding on.

feature {NONE} -- Access

	docking_manager: attached SD_DOCKING_MANAGER
			-- Docking manager for the development window
		require
			is_interface_usable: is_interface_usable
		do
			Result := development_window.docking_manager
		end

	editors_configuration_file: PATH
			-- The file name for the project's editors configuration.
		require
			is_interface_usable: is_interface_usable
			system_defined: (create {SHARED_WORKBENCH}).workbench.system_defined
		do
			Result := development_window.project_location.target_path.extended ("editors_" + development_window.window_id.out)
		end

feature -- Status report

	is_interface_usable: BOOLEAN
			-- <Precursor>
		do
			Result := Precursor and then development_window.is_interface_usable and then is_eiffel_layout_defined
		ensure then
			development_window_is_interface_usable: Result implies development_window.is_interface_usable
			is_eiffel_layout_defined: Result implies is_eiffel_layout_defined
		end

feature -- Basic operations: Standard persona

	build_standard_layout
			-- Constructs the standard (edition) layout for EiffelStudio, for first use.
		require
			is_interface_usable: is_interface_usable
		local
			l_shell_tools: ES_SHELL_TOOLS
			l_tool: ES_TOOL [EB_TOOL]
			l_last_tool: ES_TOOL [EB_TOOL]
			l_tool_bar_content: SD_TOOL_BAR_CONTENT
			l_tool_bar_content_2: SD_TOOL_BAR_CONTENT
			l_is_unlocked: BOOLEAN
		do
			l_is_unlocked := ((create {EV_ENVIRONMENT}).application.locked_window = Void)
			if l_is_unlocked then
				development_window.window.lock_update
			end

				--
				-- TO BE REMOVED: Use personas instead
				--
			development_window.close_all_tools

				-- Right bottom tools
			l_tool := l_shell_tools.tool ({ES_TESTING_RESULTS_TOOL})
			l_tool.content.set_top ({SD_ENUMERATION}.bottom)
			l_last_tool := l_tool

			l_tool := l_shell_tools.tool ({ES_ERROR_LIST_TOOL})
			l_tool.content.set_tab_with (l_last_tool.content, True)
			l_last_tool := l_tool

			l_tool := l_shell_tools.tool ({ES_OUTPUTS_TOOL})
			l_tool.content.set_tab_with (l_last_tool.content, True)
			l_last_tool := l_tool

			l_tool := l_shell_tools.tool ({ES_FEATURE_RELATION_TOOL})
			l_tool.content.set_tab_with (l_last_tool.content, True)
			l_last_tool := l_tool

			l_tool := l_shell_tools.tool ({ES_CLASS_TOOL})
			l_tool.content.set_tab_with (l_last_tool.content, True)
			l_last_tool := l_tool

			l_tool.content.set_split_proportion ({REAL_32} 0.6)

				-- Right tools
			l_tool := l_shell_tools.tool ({ES_FAVORITES_TOOL})
			l_tool.content.set_top ({SD_ENUMERATION}.right)
			l_last_tool := l_tool

			l_tool := l_shell_tools.tool ({ES_TESTING_TOOL})
			l_tool.content.set_tab_with (l_last_tool.content, True)
			l_last_tool := l_tool

			l_tool := l_shell_tools.tool ({ES_FEATURES_TOOL})
			l_tool.content.set_tab_with (l_last_tool.content, True)
			l_last_tool := l_tool

			l_tool := l_shell_tools.tool ({ES_GROUPS_TOOL})
			l_tool.content.set_tab_with (l_last_tool.content, True)

			l_tool.content.set_split_proportion ({REAL_32} 0.73)

				-- Auto hide (bottom) tools
			l_tool := l_shell_tools.tool ({ES_DIAGRAM_TOOL})
			if l_tool.content.state_value /= {SD_ENUMERATION}.auto_hide then
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
			else
				-- First we pin it, then pin it again. So we can make sure the tab stub order and tab stub direction.
				-- Docking library will add a feature to set auto hide tab stub order directly in the future. -- Larry 2007/7/13
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
			end
			l_last_tool := l_tool

			l_tool := l_shell_tools.tool ({ES_DEPENDENCY_TOOL})
			if l_tool.content.state_value /= {SD_ENUMERATION}.auto_hide then
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
			else
				-- First we pin it, then pin it again. So we can make sure the tab stub order and tab stub direction.
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
			end
			l_last_tool := l_tool

			l_tool := l_shell_tools.tool ({ES_METRICS_TOOL})
			l_tool.content.set_tab_with (l_last_tool.content, False)
			l_last_tool := l_tool

			l_tool := l_shell_tools.tool ({ES_INFORMATION_TOOL})
			l_tool.content.set_tab_with (l_last_tool.content, False)
			l_last_tool := l_tool
				--
				-- End TO BE REMOVED
				--

				-- Load the standard layout
				-- FIXME: Persona descriptions are not ready for prime time yet.
			--load_persona ({EIFFEL_ENV}.docking_standard_file)

				-- Tool bars construction is not yet handled in persona layout files.
			l_tool_bar_content := development_window.docking_manager.tool_bar_manager.content_by_title (interface_names.to_standard_toolbar)
			l_tool_bar_content_2 := l_tool_bar_content
			check not_void: l_tool_bar_content /= Void end
			l_tool_bar_content.set_top ({SD_ENUMERATION}.top)

			l_tool_bar_content := development_window.docking_manager.tool_bar_manager.content_by_title (interface_names.to_address_toolbar)
			check not_void: l_tool_bar_content /= Void end
			l_tool_bar_content.set_top ({SD_ENUMERATION}.top)

			l_tool_bar_content := development_window.docking_manager.tool_bar_manager.content_by_title (interface_names.to_project_toolbar)
			check not_void: l_tool_bar_content /= Void end
			l_tool_bar_content.set_top_with (l_tool_bar_content_2)

			l_tool_bar_content := development_window.docking_manager.tool_bar_manager.content_by_title (interface_names.to_refactory_toolbar)
			check not_void: l_tool_bar_content /= Void end
			l_tool_bar_content.set_top ({SD_ENUMERATION}.top)
				-- We first call `set_top' because we want set a default location for the tool bar.
			l_tool_bar_content.hide

			if l_is_unlocked then
				development_window.window.unlock_update
			end
		end

	store_standard_tools_layout
			-- Stores the standard persona tools layout information.
		require
			is_interface_usable: is_interface_usable
		local
			l_fn: PATH
			retried: BOOLEAN
		do
			if not retried then
				if not attached {EB_DEBUGGER_MANAGER} development_window.debugger_manager as l_debugger or else not l_debugger.is_exiting_eiffel_studio then
						-- If directly exiting Eiffel Studio from EB_DEBUGGER_MANAGER, then we don't save the tools
						-- layout, because current widgets layout is debug mode layout (not normal mode layout),
						-- and the debug mode widgets layout is saved by EB_DEBUGGER_MANAGER already -- larrym
					l_fn := eiffel_layout.user_docking_standard_file_name (development_window.window_id)
					if not docking_manager.save_tools_data_with_path (l_fn) then
						show_last_exception_with_template ("Unable to store the editor layout information.%N%N  Reason: $1")
					end
				end
			end
		rescue
			retried := True
			show_last_exception_with_template ("Unable to store the editor layout information.%N%N  Reason: $1")
			retry
		end

feature -- Basic operations: Editor configuration

	store_editors_layout
			-- Stores the open editors information.
		require
			is_interface_usable: is_interface_usable
			system_defined: (create {SHARED_WORKBENCH}).workbench.system_defined
		local
			retried: BOOLEAN
		do
			if not docking_manager.save_editors_data_with_path (editors_configuration_file) then
				show_last_exception_with_template ("Unable to store the editor layout information.%N%N  Reason: $1")
			end
		rescue
			retried := True
			show_last_exception_with_template ("Unable to store the editor layout information.%N%N  Reason: $1")
			retry
		end

	restore_editors_layout
			-- Restores previously stored open editors information.
		require
			is_interface_usable: is_interface_usable
			system_defined: (create {SHARED_WORKBENCH}).workbench.system_defined
		local
			l_fn: attached like editors_configuration_file
			retried: BOOLEAN
			u: FILE_UTILITIES
		do
			if not retried then
				l_fn := editors_configuration_file
				if u.file_path_exists (l_fn) then
					development_window.docking_manager.open_editors_config_with_path (l_fn)
				end
			end
		rescue
			retried := True
			show_last_exception_with_template ("Unable to restore the standard editor layout information.%N%N  Reason: $1")
			retry
		end

;note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
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
