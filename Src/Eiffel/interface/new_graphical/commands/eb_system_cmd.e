indexing
	description: "Command to open system configuration tool window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SYSTEM_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			new_toolbar_item,
			tooltext
		end

	EB_SHARED_INTERFACE_TOOLS
		export {NONE} all end

	EB_GRAPHICAL_ERROR_MANAGER
		export {NONE} all end

	SHARED_WORKBENCH
		export {NONE} all end

	EB_CONSTANTS
		export {NONE} all end

	EB_SHARED_PREFERENCES
		export {NONE} all end

	EV_SHARED_APPLICATION
		export {NONE} all end

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize default_values.
		do
		end

feature -- Access

	new_toolbar_item (display_text: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
		do
			Result := Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND} (display_text)
			Result.pointer_button_press_actions.put_front (agent button_right_click_action)
		end

feature -- Basic operations

	execute is
			-- Open the Project configuration window.
		local
			rescued: BOOLEAN
			wd: EV_WARNING_DIALOG
			l_debugs: SEARCH_TABLE [STRING]
			l_sorted_debugs: DS_ARRAYED_LIST [STRING]
			l_config_window: CONFIGURATION_WINDOW
			l_fact: CONF_COMP_FACTORY
			l_load: CONF_LOAD
		do
			if not rescued then
				if ev_application.ctrl_pressed then
					gc_window.show
				else
					create l_fact
					create l_load.make (l_fact)
					l_load.retrieve_configuration (lace.conf_system.file_name)
					if l_load.is_error then
						create wd.make_with_text (l_load.last_error.out)
						wd.show_modal_to_window (window_manager.
							last_focused_development_window.window)
					else
							-- sort debugs
						if workbench.system_defined then
							l_debugs := system.debug_clauses
						end
						if l_debugs /= Void then
							create l_sorted_debugs.make (l_debugs.count)
							from
								l_debugs.start
							until
								l_debugs.after
							loop
								l_sorted_debugs.put_last (l_debugs.item_for_iteration)
								l_debugs.forth
							end
							l_sorted_debugs.sort (create {DS_QUICK_SORTER [STRING]}.make (create {KL_COMPARABLE_COMPARATOR [STRING]}.make))
						else
							create l_sorted_debugs.make_default
						end

						l_load.last_system.targets.start
						l_load.last_system.set_application_target (l_load.last_system.targets.item_for_iteration)
						create l_config_window.make (l_load.last_system, l_fact, l_sorted_debugs)
						l_config_window.show
					end
				end
			end
		rescue
			display_error_message (window_manager.last_focused_development_window.window)
			if catch_exception then
				rescued := True
				retry
			end
		end

feature {NONE} -- Implementation

	gc_window: EB_GC_STATISTIC_WINDOW is
		once
			create Result.make
		ensure
			gc_window_not_void: Result /= Void
		end

	name: STRING is "System_tool"
			-- Name of command. Used to store command in preferences

	pixmap: EV_PIXMAP is
			-- Pixmap representing command.
		do
			Result := Pixmaps.Icon_system
		end

	description: STRING is
			-- Description for command
		do
			Result := Interface_names.e_Project_settings
		end

	tooltip: STRING is
			-- Tooltip for toolbar button
		do
			Result := Interface_names.e_Project_settings
		end

	tooltext: STRING is
			-- Tooltip for toolbar button
		do
			Result := Interface_names.b_Project_settings
		end

	menu_name: STRING is
		do
			Result := Interface_names.m_System_new
		end

	button_right_click_action (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Show the ace file in editor.
		local
			cmd_exec: COMMAND_EXECUTOR
			cmd_string: STRING
		do
			if a_button = 3 and is_sensitive then
				cmd_string := preferences.misc_data.xml_editor_command.twin
				if not cmd_string.is_empty then
					cmd_string.replace_substring_all ("$target", eiffel_ace.lace.file_name)
					cmd_string.replace_substring_all ("$line", "")
					create cmd_exec
					cmd_exec.execute (cmd_string)
				end
			end
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

end
