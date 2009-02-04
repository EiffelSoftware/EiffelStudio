note
	description: "[
		A command used to locate a class or cluster in the groups tool ({ES_GROUPS_TOOL}).
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_FIND_CLASS_OR_CLUSTER_CMD

inherit
	EB_DEVELOPMENT_WINDOW_COMMAND
		redefine
			initialize
		end

	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			mini_pixel_buffer,
			mini_pixmap
		end

	EB_STONABLE_COMMAND

inherit {NONE}
	EB_SHARED_PIXMAPS
		export
			{NONE} all
		end

	ES_SHARED_LOCALE_FORMATTER
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

create
	make

feature

	initialize
			-- <Precursor>
		local
			l_project_manager: EB_PROJECT_MANAGER
		do
			Precursor
			l_project_manager := workbench.eiffel_project.manager
			if not workbench.is_already_compiled then
				disable_sensitive
				register_action (l_project_manager.load_agents, agent on_project_loaded)
			else
				on_project_loaded
			end
			register_action (l_project_manager.close_agents, agent on_project_unloaded)
		end

feature -- Access: User interface

	name: STRING_GENERAL
			-- <Precursor>
		do
			Result := locale_formatter.translation (l_name)
		end

	menu_name: STRING_GENERAL
			-- <Precursor>
		do
			Result := locale_formatter.translation (m_menu_name)
		end

	tooltip: STRING_GENERAL
			-- <Precursor>
		do
			Result := locale_formatter.translation (tt_tool_tip)
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- <Precursor>
		do
			Result := icon_pixmaps.tool_search_icon_buffer
		end

	pixmap: EV_PIXMAP
			-- <Precursor>
		do
			Result := icon_pixmaps.tool_search_icon
		end

	mini_pixel_buffer: EV_PIXEL_BUFFER
			-- <Precursor>
		do
			Result := mini_pixmaps.general_search_icon_buffer
		end

	mini_pixmap: EV_PIXMAP
			-- <Precursor>
		do
			Result := mini_pixmaps.general_search_icon
		end

	description: STRING_GENERAL
			-- <Precursor>
		do
			Result := tooltip
		end

feature -- Status report

	is_valid_stone (a_stone: STONE): BOOLEAN
			-- <Precursor>
		do
			if {l_tool: ES_GROUPS_TOOL} target.shell_tools.tool ({ES_GROUPS_TOOL}) then
				Result := l_tool.is_stone_usable (a_stone)
			end
		end

feature -- Basic operations

	execute
			-- <Precursor>
		do
			if {l_commander: ES_GROUPS_COMMANDER_I} target.shell_tools.tool ({ES_GROUPS_TOOL}) then
				l_commander.highlight_editor_stone
			end
		end

	execute_with_stone (a_stone: STONE)
			-- <Precursor>
		do
			if a_stone /= Void and then {l_commander: ES_GROUPS_COMMANDER_I} target.shell_tools.tool ({ES_GROUPS_TOOL}) then
				l_commander.highlight_stone (a_stone)
			end
		end

feature {NONE} -- Basic operations

	on_project_loaded
			-- Called when a project has been loaded.
		require
			is_interface_usable: is_interface_usable
		do
			enable_sensitive
		end

	on_project_unloaded
			-- Called when a project has been unloaded/closed.
		require
			is_interface_usable: is_interface_usable
		do
			disable_sensitive
		end

feature {NONE} -- Internationalization

	l_name: STRING = "Locate"
	m_menu_name: STRING = "Locate in Groups Tool"
	tt_tool_tip: STRING = "Locate the class or cluster currently in the editor.%NYou can also pick and class or cluster and drop it here"

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
