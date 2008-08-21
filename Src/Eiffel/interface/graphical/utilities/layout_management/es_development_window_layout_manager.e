indexing
	description: "[
		Manages EiffelStudio tool and tool bar layouts
	]"
	author: ""
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

	make (a_window: !like development_window)
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

	development_window: ?EB_DEVELOPMENT_WINDOW
			-- Window to perform layout rebuilding on.

feature {NONE} -- Access

	docking_manager: !SD_DOCKING_MANAGER
			-- Docking manager for the development window
		require
			is_interface_usable: is_interface_usable
		do
			Result ?= development_window.docking_manager
		end

	editors_configuration_file: !FILE_NAME
			-- The file name for the project's editors configuration.
		require
			is_interface_usable: is_interface_usable
			system_defined: (create {SHARED_WORKBENCH}).workbench.system_defined
		do
			create Result.make_from_string (development_window.project_location.target_path)
			Result.set_file_name ("editors_" + development_window.window_id.out)
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

feature {NONE} -- Helpers

	frozen xml_parser: !XM_EIFFEL_PARSER
			-- Access to an XML parser
		once
			create {XM_EIFFEL_PARSER} Result.make
		end

feature -- Basic operations: Standard persona

	build_standard_layout
			-- Constructs the standard (edition) layout for EiffelStudio, for first use.
		require
			is_interface_usable: is_interface_usable
		local
			l_tool: EB_TOOL
			l_last_tool: EB_TOOL
			l_features_tool: ES_FEATURES_TOOL

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
			l_tool := development_window.tools.c_output_tool
			l_tool.content.set_top ({SD_ENUMERATION}.bottom)

			l_tool := development_window.shell_tools.tool ({ES_ERROR_LIST_TOOL}).panel
			l_tool.content.set_tab_with (development_window.tools.c_output_tool.content, True)
			l_last_tool := l_tool

			l_tool := development_window.tools.output_tool
			l_tool.content.set_tab_with (l_last_tool.content, True)

			l_tool := development_window.tools.features_relation_tool
			l_tool.content.set_tab_with (development_window.tools.output_tool.content, True)

			l_tool := development_window.tools.class_tool
			l_tool.content.set_tab_with (development_window.tools.features_relation_tool.content, True)

			l_tool.content.set_split_proportion (0.6)

				-- Right tools
			l_features_tool ?= development_window.shell_tools.tool ({ES_FEATURES_TOOL})

			l_tool := development_window.tools.favorites_tool
			l_tool.content.set_top ({SD_ENUMERATION}.right)
			l_tool := l_features_tool.panel
			l_tool.content.set_tab_with (development_window.tools.favorites_tool.content, True)
			l_tool := development_window.tools.cluster_tool
			l_tool.content.set_tab_with (l_features_tool.panel.content, True)
			l_tool.content.set_split_proportion (0.73)

				-- Auto hide tools
			l_tool := development_window.tools.diagram_tool
			if l_tool.content.state_value /= {SD_ENUMERATION}.auto_hide then
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
			else
				-- First we pin it, then pin it again. So we can make sure the tab stub order and tab stub direction.
				-- Docking library will add a feature to set auto hide tab stub order directly in the future. -- Larry 2007/7/13
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
			end

			l_tool := development_window.tools.dependency_tool
			if l_tool.content.state_value /= {SD_ENUMERATION}.auto_hide then
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
			else
				-- First we pin it, then pin it again. So we can make sure the tab stub order and tab stub direction.
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
			end

			l_tool := development_window.tools.metric_tool
			l_tool.content.set_tab_with (development_window.tools.dependency_tool.content, False)

			development_window.shell_tools.tool ({ES_INFORMATION_TOOL}).panel.content.set_tab_with (l_tool.content, False)
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
			l_fn: !FILE_NAME
			retried: BOOLEAN
		do
			if not retried then
				if not {l_debugger: EB_DEBUGGER_MANAGER} development_window or else not l_debugger.is_exiting_eiffel_studio then
						-- If directly exiting Eiffel Studio from EB_DEBUGGER_MANAGER, then we don't save the tools
						-- layout, because current widgets layout is debug mode layout (not normal mode layout),
						-- and the debug mode widgets layout is saved by EB_DEBUGGER_MANAGER already -- larrym
					l_fn := eiffel_layout.user_docking_standard_file_name (development_window.window_id)
					if not docking_manager.save_tools_data (l_fn.string) then
						show_last_exception_with_template ("Unable to store the editor layout information.%N%N  Reason: $1")
					end
				end
			end
		rescue
			retried := True
			show_last_exception_with_template ("Unable to store the editor layout information.%N%N  Reason: $1")
			retry
		end

	restore_standard_tools_layout
			-- Restores previously stored standard persona tools layout information.
		require
			is_interface_usable: is_interface_usable
		local
			l_dev_window: ?like development_window
			l_window: EB_VISION_WINDOW
			l_fn: !FILE_NAME
			l_opened: BOOLEAN
			retried: BOOLEAN
		do
			if not retried then
				l_dev_window := development_window
				if l_dev_window /= Void then
					l_window := l_dev_window.window
					if l_window.is_minimized then
							-- We can't restore tools layout when `window.is_minimized' since EV_SPLIT_AREA can't be
							-- restored if window minimized. See bug#14309 - larrym

							-- Register actions to perform a restore when the window is restored to it's former self.
						l_dev_window.register_kamikaze_action (l_window.restore_actions, agent restore_standard_tools_layout)
						l_dev_window.register_kamikaze_action (l_window.maximize_actions, agent restore_standard_tools_layout)
					else
							-- Remove any previous registration.
						l_dev_window.unregister_action (l_window.restore_actions, agent restore_standard_tools_layout)
						l_dev_window.unregister_action (l_window.maximize_actions, agent restore_standard_tools_layout)

							-- Attempt to load
						l_fn := eiffel_layout.user_docking_standard_file_name (l_dev_window.window_id)
						if (create {RAW_FILE}.make (l_fn.string)).exists then
							l_opened := development_window.docking_manager.open_tools_config (l_fn.string)
							if not l_opened then
									-- Failed to open the stored docking configuration data, so rebuild using the standard.
								show_last_exception_with_template ("Unable to restore the standard tools layout information.%N%N  Reason: $1")
								build_standard_layout
							end
						else
								-- Build standard layout
							build_standard_layout
						end

						l_dev_window.menus.update_menu_lock_items
						l_dev_window.menus.update_show_tool_bar_items
					end
				else
						-- Should never happen if `is_interface_usable' is satisfied.
					check False end
				end
			end
		rescue
			retried := True
			show_last_exception_with_template ("Unable to restore the standard tools layout information.%N%N  Reason: $1")
			retry
		end

feature -- Basic operations: Debugger persona

	build_debugger_layout
			-- Constructs the debugger layout for EiffelStudio, for first use.
		require
			is_interface_usable: is_interface_usable
		do
			load_persona ({EIFFEL_ENV}.docking_debug_file)

				-- Minimize all editors
			docking_manager.contents.do_all (agent (ia_content: SD_CONTENT)
				do
					if ia_content /= Void and then not ia_content.is_destroyed and then ia_content.type = {SD_ENUMERATION}.editor then
						ia_content.minimize
					end
				end)
		end

	store_debugger_tools_layout
			-- Stores the debugger persona tools layout information.
		require
			is_interface_usable: is_interface_usable
		local
			l_fn: !FILE_NAME
			retried: BOOLEAN
		do
			if not retried then
				l_fn := eiffel_layout.user_docking_debug_file_name (development_window.window_id)
				if not docking_manager.save_tools_data (l_fn.string) then
					show_last_exception_with_template ("Unable to store the standard layout information.%N%N  Reason: $1")
				end
			end
		rescue
			retried := True
			show_last_exception_with_template ("Unable to store the standard layout information.%N%N  Reason: $1")
			retry
		end

	restore_debugger_tools_layout
			-- Restores previously stored debugger persona tools layout information.
		require
			is_interface_usable: is_interface_usable
		local
			l_dev_window: ?like development_window
			l_window: EB_VISION_WINDOW
			l_fn: !FILE_NAME
			l_opened: BOOLEAN
			retried: BOOLEAN
		do
			if not retried then
				l_dev_window := development_window
				if l_dev_window /= Void then
					l_window := l_dev_window.window
					if l_window.is_minimized then
							-- We can't restore tools layout when `window.is_minimized' since EV_SPLIT_AREA can't be
							-- restored if window minimized. See bug#14309 - larrym

							-- Register actions to perform a restore when the window is restored to it's former self.
						l_dev_window.register_kamikaze_action (l_window.restore_actions, agent restore_standard_tools_layout)
						l_dev_window.register_kamikaze_action (l_window.maximize_actions, agent restore_standard_tools_layout)
					else
							-- Remove any previous registration.
						l_dev_window.unregister_action (l_window.restore_actions, agent restore_standard_tools_layout)
						l_dev_window.unregister_action (l_window.maximize_actions, agent restore_standard_tools_layout)

							-- Attempt to load
						l_fn := eiffel_layout.user_docking_debug_file_name (l_dev_window.window_id)
						if (create {RAW_FILE}.make (l_fn.string)).exists then
							l_opened := development_window.docking_manager.open_tools_config (l_fn.string)
							if not l_opened then
									-- Failed to open the stored docking configuration data, so rebuild using the standard.
								show_last_exception_with_template ("Unable to restore the debugger tools layout information.%N%N  Reason: $1")
								build_debugger_layout
							end
						else
								-- Build debugger layout
							build_debugger_layout
						end

						l_dev_window.menus.update_menu_lock_items
						l_dev_window.menus.update_show_tool_bar_items
					end
				else
						-- Should never happen if `is_interface_usable' is satisfied.
					check False end
				end
			end
		rescue
			retried := True
			show_last_exception_with_template ("Unable to restore the debugger tools layout information.%N%N  Reason: $1")
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
			if not docking_manager.save_editors_data (editors_configuration_file) then
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
			l_fn: !FILE_NAME
			retried: BOOLEAN
		do
			if not retried then
				l_fn := editors_configuration_file
				if (create {RAW_FILE}.make (l_fn.string)).exists then
					development_window.docking_manager.open_editors_config (l_fn.string)
				end
			end
		rescue
			retried := True
			show_last_exception_with_template ("Unable to restore the standard editor layout information.%N%N  Reason: $1")
			retry
		end

feature {NONE} -- Basic operations

	load_persona (a_name: !STRING)
			-- Loads a persona from an indexed persona names.
			--
			-- `a_name': A name alias to use to load a persona file.
		require
			is_interface_usable: is_interface_usable
			not_a_name_is_empty: not a_name.is_empty
		local
			l_fn: !FILE_NAME
			l_user_fn: ?FILE_NAME
		do
			create l_fn.make_from_string (eiffel_layout.eifinit_path.string)
			l_fn.set_file_name (a_name)
			l_fn.add_extension ("lay")
			l_user_fn := eiffel_layout.user_priority_file_name (l_fn, True)
			if l_user_fn /= Void then
				l_fn := l_user_fn
			end
			if (create {RAW_FILE}.make (l_fn)).exists and then {l_string: STRING} l_fn.string then
				load_persona_from_file (l_string)
			else
-- Error
			end
		end

	load_persona_from_file (a_file_name: !STRING)
			-- Loads a persona from a persona description file.
			--
			-- `a_file_name': The name of the file to load a persona from.
		require
			is_interface_usable: is_interface_usable
			not_a_file_name_is_empty: not a_file_name.is_empty
			a_file_name_exists: (create {RAW_FILE}.make (a_file_name)).exists
		local
			l_parser: !like xml_parser
			l_resolver: !XM_FILE_EXTERNAL_RESOLVER
			l_callbacks: !ES_DOCKING_PERSONA_LOAD_CALLBACKS
			l_is_unlocked: BOOLEAN
			retried: BOOLEAN
		do
			if not retried then
				l_is_unlocked := (create {EV_ENVIRONMENT}).application.locked_window = Void
				if l_is_unlocked then
					development_window.window.lock_update
				end

				create l_resolver.make
				l_resolver.resolve (a_file_name)
				if not l_resolver.has_error and then {l_window: like development_window} development_window then
						-- File is loaded, create the callbacks and parse the XML.
					l_parser := xml_parser
					create l_callbacks.make (l_window, l_parser)
					check
						l_parser_callbacks_set: l_parser.callbacks = l_callbacks
					end
					l_parser.parse_from_stream (l_resolver.last_stream)
					l_resolver.last_stream.close
					if l_callbacks.has_error then
-- Error
					end
				end
			else
				if l_resolver.last_stream /= Void then
					l_resolver.last_stream.close
				end
-- Error
			end
			if l_is_unlocked then
				development_window.window.unlock_update
			end
		rescue
			retried := True
			retry
		end

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

end
