indexing
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

	execute is
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

	execute_with_class_stone (a_stone: CLASSI_STONE) is
			-- Create a development window and process `a_stone'.
		do
			if a_stone.is_valid then
				was_dropped := True
				tool.set_is_rebuild_world_needed (True)
			tool.launch_stone (a_stone)
			end
		end

	execute_with_cluster_stone (a_stone: CLUSTER_STONE) is
			-- Create a development window and process `a_stone'.
		do
			if a_stone.is_valid then
				was_dropped := True
				tool.set_is_rebuild_world_needed (True)
			tool.launch_stone (a_stone)
			end
		end

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
		do
			Result := Precursor (display_text)
			Result.drop_actions.extend (agent execute_with_class_stone)
			Result.drop_actions.extend (agent execute_with_cluster_stone)
			Result.drop_actions.set_veto_pebble_function (agent veto_pebble_fucntion)
				-- Fixme: when EB_SD_COMMAND_TOOL_BAR_BUTTON supports `pebble',
				-- we should uncomment following code.
--			Result.set_pebble_function (agent pebble)
		end

feature {NONE} -- Implementation

	pebble (x, y: INTEGER): STONE is
			-- pebble corresponding to class or cluster currently
			-- displayed in the context tool.
		local
			class_stone: CLASSI_STONE
			cluster_stone: CLUSTER_STONE
			tbi: EB_SD_COMMAND_TOOL_BAR_BUTTON
		do
			if not was_dropped then
				Result := tool.last_stone
				check
					internal_managed_sd_toolbar_items /= Void
					not internal_managed_sd_toolbar_items.is_empty
				end
				tbi := internal_managed_sd_toolbar_items.first
				class_stone ?= Result
				cluster_stone ?= Result
				if class_stone /= Void then
					tbi.set_accept_cursor (cursors.Cur_class)
				elseif cluster_stone /= Void then
					tbi.set_accept_cursor (cursors.Cur_cluster)
				end
			else
				was_dropped := False
			end
		end

	veto_pebble_fucntion (a_any: ANY): BOOLEAN is
			-- Veto function
		local
			cluster_stone: CLUSTER_STONE
			class_stone: CLASSI_STONE
		do
			cluster_stone ?= a_any
			Result := cluster_stone /= Void
			if not Result then
				class_stone ?= a_any
				Result := class_stone /= Void
			end
		end

	was_dropped: BOOLEAN

	pixmap: EV_PIXMAP is
			-- Pixmap representing the command.
		do
			Result := pixmaps.icon_pixmaps.diagram_target_cluster_or_class_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.diagram_target_cluster_or_class_icon_buffer
		end

	tooltip: STRING_GENERAL is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.F_retarget_diagram
		end

	menu_name: STRING_GENERAL is
			-- Name on corresponding menu items
		do
			Result := interface_names.m_center_diagram
		end

	name: STRING is "Center_diagram"
			-- Name of the command. Used to store the command in the
			-- preferences.

;indexing
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

end -- class EB_CENTER_DIAGRAM_COMMAND
