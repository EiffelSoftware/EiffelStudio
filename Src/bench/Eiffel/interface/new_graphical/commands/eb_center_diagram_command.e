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
			new_toolbar_item
		end

	CONF_REFACTORING

create
	make

feature -- Basic operations

	execute is
			-- Display information about `Current'.
		local
			cla_s: CLASSI_STONE
			clu_s: CLUSTER_STONE
			clu: CLUSTER_I
			warned: BOOLEAN
		do
			if tool.class_view /= Void then
				cla_s := tool.class_stone
				if cla_s /= Void and then cla_s.is_valid then
					conf_todo
--					clu := cla_s.class_i.cluster
				end
			elseif tool.cluster_view /= Void then
				clu_s := tool.cluster_stone
				if clu_s /= Void and then clu_s.is_valid then
					clu := clu_s.cluster_i.parent_cluster
				end
			else
				create explain_dialog.make_with_text (Interface_names.e_Diagram_hole)
				explain_dialog.show_modal_to_window (tool.development_window.window)
				warned := True
			end
			if clu /= Void then
				create clu_s.make (clu)
				if clu_s.is_valid then
					tool.tool.set_stone (clu_s)
				end
			elseif not warned then
				create explain_dialog.make_with_text (Warning_messages.W_does_not_have_enclosing_cluster)
				explain_dialog.show_modal_to_window (tool.development_window.window)
			end
		end

	execute_with_class_stone (a_stone: CLASSI_STONE) is
			-- Create a development window and process `a_stone'.
		do
			was_dropped := True
			tool.set_is_rebuild_world_needed (True)
			tool.tool.launch_stone (a_stone)
		end

	execute_with_cluster_stone (a_stone: CLUSTER_STONE) is
			-- Create a development window and process `a_stone'.
		do
			was_dropped := True
			tool.set_is_rebuild_world_needed (True)
			tool.tool.launch_stone (a_stone)
		end

	new_toolbar_item (display_text: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
		do
			Result := Precursor (display_text)
			Result.drop_actions.extend (agent execute_with_class_stone)
			Result.drop_actions.extend (agent execute_with_cluster_stone)
			Result.set_pebble_function (agent pebble)
		end

feature {NONE} -- Implementation

	pebble (x, y: INTEGER): STONE is
			-- pebble corresponding to class or cluster currently
			-- displayed in the context tool.
		local
			class_stone: CLASSI_STONE
			cluster_stone: CLUSTER_STONE
			tbi: EB_COMMAND_TOOL_BAR_BUTTON
		do
			if not was_dropped then
				Result := tool.tool.stone
				tbi := managed_toolbar_items.first
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

	was_dropped: BOOLEAN

	pixmap: EV_PIXMAP is
			-- Pixmap representing the command.
		do
			Result := Pixmaps.Icon_center_diagram
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.F_retarget_diagram
		end

	name: STRING is "Center_diagram"
			-- Name of the command. Used to store the command in the
			-- preferences.

	explain_dialog: EB_INFORMATION_DIALOG;
			-- Dialog explaining how to use `Current'.

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

end -- class EB_CENTER_DIAGRAM_COMMAND
