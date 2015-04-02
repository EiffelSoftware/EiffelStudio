note
	description: "Command to center the diagram on a stone"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CENTER_DIAGRAM_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		redefine
			new_sd_toolbar_item,
			menu_name
		end

create
	make

feature -- Basic operations

	execute
			-- Display information about `Current'.
		local
			cla_s: CLASSI_STONE
			clu_s: CLUSTER_STONE
			clu: CONF_GROUP
			warned: BOOLEAN
		do
			if tool.class_view /= Void then
				cla_s := tool.class_stone
				if cla_s /= Void and then cla_s.is_valid then
					clu := cla_s.class_i.group
				end
			elseif tool.cluster_view /= Void then
				clu_s := tool.cluster_stone
				if clu_s /= Void and then clu_s.is_valid then
					clu := clu_s.group --.parent_cluster
				end
			else
				(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_info_prompt (Interface_names.e_Diagram_hole, tool.develop_window.window, Void)
				warned := True
			end
			if clu /= Void then
				create clu_s.make (clu)
				if clu_s.is_valid then
					tool.develop_window.tools.set_stone (clu_s)
				end
			elseif not warned then
				(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_info_prompt (Warning_messages.W_does_not_have_enclosing_cluster, tool.develop_window.window, Void)
			end
		end

	execute_with_class_stone (a_stone: CLASSI_STONE)
			-- Create a development window and process `a_stone'.
		do
			if a_stone.is_valid then
				tool.set_is_rebuild_world_needed (True)
				tool.launch_stone (a_stone)
			end
		end

	execute_with_cluster_stone (a_stone: CLUSTER_STONE)
			-- Create a development window and process `a_stone'.
		do
			if a_stone.is_valid then
				tool.set_is_rebuild_world_needed (True)
				tool.launch_stone (a_stone)
			end
		end

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_BUTTON
			-- Create a new toolbar button for this command.
		do
			Result := Precursor (display_text)
			Result.drop_actions.extend (agent execute_with_class_stone)
			Result.drop_actions.extend (agent execute_with_cluster_stone)
			Result.drop_actions.set_veto_pebble_function (agent veto_pebble_function)
			Result.set_pebble_function (agent pebble (Result, ?, ?))
		end

feature {NONE} -- Implementation

	pebble (a_tbi: like new_sd_toolbar_item; x, y: INTEGER): detachable STONE
			-- Pebble corresponding to class or cluster currently
			-- displayed in the context tool.
		do
			Result := tool.last_stone
				-- Depending on the stone we need to use the proper p&d cursors.
			if attached {CLASSI_STONE} Result then
				a_tbi.set_accept_cursor (cursors.Cur_class)
				a_tbi.set_deny_cursor (cursors.cur_x_class)
			elseif attached {CLUSTER_STONE} Result then
				a_tbi.set_accept_cursor (cursors.Cur_cluster)
				a_tbi.set_deny_cursor (cursors.cur_x_cluster)
			end
		end

	veto_pebble_function (a_any: ANY): BOOLEAN
			-- Veto function. We only accept cluster or classes.
		do
			Result := attached {CLUSTER_STONE} a_any or attached {CLASSI_STONE} a_any
		end

	pixmap: EV_PIXMAP
			-- Pixmap representing the command.
		do
			Result := pixmaps.icon_pixmaps.diagram_target_cluster_or_class_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.diagram_target_cluster_or_class_icon_buffer
		end

	tooltip: STRING_GENERAL
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.F_retarget_diagram
		end

	menu_name: STRING_GENERAL
			-- Name on corresponding menu items
		do
			Result := interface_names.m_center_diagram
		end

	name: STRING = "Center_diagram"
			-- Name of the command. Used to store the command in the
			-- preferences.

;note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software"
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

end -- class EB_CENTER_DIAGRAM_COMMAND
