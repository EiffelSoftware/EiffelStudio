indexing
	description: "Objects that alows to remove anchors from classes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_REMOVE_ANCHOR_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		redefine
			new_sd_toolbar_item,
			description,
			menu_name
		end

create
	make

feature -- Basic operations

	execute is
			-- Perform operation.
		do
			(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_info_prompt (Interface_names.e_diagram_remove_anchor, tool.develop_window.window, Void)
		end

	execute_with_class (a_stone: CLASSI_FIGURE_STONE) is
			-- Set `is_fixed' to false for class in `a_stone'.
		do
			if a_stone.source.is_fixed then
				a_stone.source.set_is_fixed (False)
				tool.restart_force_directed
			else
				a_stone.source.set_is_fixed (True)
			end
		end

	execute_with_class_list (a_stone: CLASS_FIGURE_LIST_STONE) is
			-- Set `is_fixed' to false for all classes in `a_stone'.
		do
			from
				a_stone.classes.start
			until
				a_stone.classes.after
			loop
				a_stone.classes.item.set_is_fixed (not a_stone.classes.item.is_fixed)
				a_stone.classes.forth
			end
			tool.restart_force_directed
		end

	execute_with_cluster (a_stone: CLUSTER_STONE) is
			-- Set `is_fixed' to false for cluster in `a_stone'.
		local
			es_cluster: ES_CLUSTER
			cluster_fig: EG_CLUSTER_FIGURE
			l_clusters: ARRAYED_LIST [ES_CLUSTER]
		do
			l_clusters := tool.graph.cluster_from_interface (a_stone.group)
			if not l_clusters.is_empty then
				from
					l_clusters.start
				until
					l_clusters.after
				loop
					es_cluster := l_clusters.item
					cluster_fig ?= tool.world.figure_from_model (es_cluster)
					if cluster_fig /= Void then
						if cluster_fig.is_fixed then
							cluster_fig.set_is_fixed (False)
							tool.restart_force_directed
						else
							cluster_fig.set_is_fixed (True)
						end
					end
					l_clusters.forth
				end

			end
		end

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
			--
			-- Call `recycle' on the result when you don't need it anymore otherwise
			-- it will never be garbage collected.
		do
			Result := Precursor (display_text)
			Result.drop_actions.extend (agent execute_with_class)
			Result.drop_actions.extend (agent execute_with_class_list)
			Result.drop_actions.extend (agent execute_with_cluster)
		end

feature {NONE} -- Implementation.

	pixmap: EV_PIXMAP is
			-- Pixmaps representing the command.
		do
			Result := pixmaps.icon_pixmaps.diagram_remove_anchor_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.diagram_remove_anchor_icon_buffer
		end

	tooltip: STRING_GENERAL is
			-- Tooltip for the toolbar button.
		do
			Result := interface_names.f_diagram_remove_anchor
		end

	description: STRING_GENERAL is
			-- Description for this command.
		do
			Result := Interface_names.l_diagram_remove_anchor
		end

	menu_name: STRING_GENERAL is
			-- Name on corresponding menu items
		do
			Result := Interface_names.l_diagram_remove_anchor
		end

	name: STRING is "Anchor_remove";
			-- Name of the command. Used to store the command in the
			-- preferences.

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

end -- class EB_REMOVE_ANCHOR_COMMAND
