note
	description: "[
			The groups tool to view a project's group hierarchy and contained classes
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_GROUPS_TOOL_PANEL

inherit
	ES_DOCKABLE_STONABLE_TOOL_PANEL [EB_CLASSES_TREE]
		redefine
			on_after_initialized,
			is_stone_sychronization_required,
			create_mini_tool_bar_items
		end

	ES_HELP_CONTEXT
		export
			{NONE} all
		end

	ES_GROUPS_COMMANDER_I
		export
			{ES_GROUPS_COMMANDER_I} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization: User interface

	build_tool_interface (a_widget: !EB_CLASSES_TREE)
			-- <Precursor>
		do
			a_widget.associate_with_window (develop_window)
		end

	on_after_initialized
			-- <Precursor>
		local
			l_project_manager: ?EB_PROJECT_MANAGER
		do
			Precursor

			l_project_manager := workbench.eiffel_project.manager
			if not workbench.is_already_compiled then
					-- The is an incomplete compiled project, set up the agents to handle
					-- senitivity setting of project-sensitive widgets.
				find_stone_button.disable_sensitive
				register_action (l_project_manager.load_agents, agent on_project_loaded)
			else
				check find_stone_button_enabled: find_stone_button.is_sensitive end
				on_project_loaded
			end
		end

feature {NONE} -- Access: User interface elements

	new_cluster_button: SD_TOOL_BAR_BUTTON
			-- Button use to add a new cluster.

	new_library_button: SD_TOOL_BAR_BUTTON
			-- Button use to add a new library.

	new_assembly_button: ?SD_TOOL_BAR_BUTTON
			-- Button use to add a new assembly.

	new_class_button: SD_TOOL_BAR_BUTTON
			-- Button use to add a new class.

	delete_group_button: SD_TOOL_BAR_BUTTON
			-- Button use to remove a group.

	find_stone_button: SD_TOOL_BAR_BUTTON
			-- Button used to locate a class or cluster

feature -- Access: Help

	help_context_id: !STRING_GENERAL
			-- <Precursor>
		once
			Result := "0BAEBAA5-A9C8-4C7C-6ACE-C11D82804906"
		end

feature {NONE} -- Status report

	is_stone_sychronization_required (a_old_stone: ?STONE; a_new_stone: ?STONE): BOOLEAN
			-- <Precursor>
		do
				-- No synchornization required, stone setting is only used to locate a stone.
			Result := False
		end

feature {ES_GROUPS_COMMANDER_I} -- Basic operations

	highlight_stone (a_stone: !STONE)
			-- <Precursor>
		do
			set_stone (a_stone)
		end

	highlight_editor_stone
			-- <Precursor>
		local
			l_editor: ?EB_SMART_EDITOR
			l_stone: ?STONE
			l_error: ES_ERROR_PROMPT
		do
			l_editor := develop_window.editors_manager.current_editor
			if l_editor /= Void then
				l_stone := l_editor.stone
				if l_stone /= Void then
					if is_stone_usable (l_stone) then
						highlight_stone (l_stone)
					elseif not is_in_stone_synchronization then
							-- No need to show an error during a synchornization. This should never actually
							-- happen because the tool {ES_GROUPS_TOOL} does not permit stone synchronization.
						create l_error.make_standard (locale_formatter.translation (e_invalid_editor))
						l_error.show_on_active_window
					end
				end
			else
--				create l_error.make_standard (locale_formatter.translation (e_no_open_editor))
--				l_error.show_on_active_window
			end
		end

feature {NONE} -- Action handlers

	on_stone_changed (a_old_stone: ?like stone)
			-- <Precursor>
		local
			l_stone: like stone
		do
			l_stone := stone
			if l_stone /= Void and then not user_widget.is_empty then
				if {l_class: CLASSI_STONE} l_stone then
					user_widget.show_class (l_class.class_i)
				elseif {l_group: CLUSTER_STONE} l_stone then
					user_widget.show_subfolder (l_group.group, l_group.path)
				else
					user_widget.show_stone (l_stone)
				end
			end
		end

	on_project_loaded
			-- Called when a project has been loaded.
		require
			is_interface_usable: is_interface_usable
			workbench_is_already_compiled: workbench.is_already_compiled
		do
			user_widget.on_project_loaded
			highlight_editor_stone
		end

feature {NONE} -- Factory

    create_widget: !EB_CLASSES_TREE
			-- <Precursor>
		do
			create Result.make (context_menus)
		end

    create_mini_tool_bar_items: ?DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		local
			l_button: SD_TOOL_BAR_BUTTON
			l_commands: EB_DEVELOPMENT_WINDOW_COMMANDS
		do
			create Result.make (7)

			l_commands := develop_window.commands
			l_button := l_commands.new_cluster_cmd.new_mini_sd_toolbar_item
			Result.put_last (l_button)
			new_cluster_button := l_button

			l_button := l_commands.new_library_cmd.new_mini_sd_toolbar_item
			Result.put_last (l_button)
			new_library_button := l_button

			if eiffel_layout.default_il_environment.is_dotnet_installed then
				l_button := l_commands.new_assembly_cmd.new_mini_sd_toolbar_item
				Result.put_last (l_button)
				new_assembly_button := l_button
			end

			l_button := l_commands.new_class_cmd.new_mini_sd_toolbar_item
			Result.put_last (l_button)
			new_class_button := l_button

			l_button := l_commands.delete_class_cluster_cmd.new_mini_sd_toolbar_item
			Result.put_last (l_button)
			delete_group_button := l_button

			Result.put_last (create {SD_TOOL_BAR_SEPARATOR}.make)

				-- `find_stone_button'.
			l_button := l_commands.find_class_or_cluster_command.new_mini_sd_toolbar_item
			find_stone_button := l_button

			Result.put_last (l_button)
		end

    create_tool_bar_items: ?DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		do
		end

feature {NONE} -- Internationalization

	e_no_open_editor: STRING = "There is no open editor to locate a class or cluster from."
	e_invalid_editor: STRING = "The active editor does not contain a valid class or cluster."

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
