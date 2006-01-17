indexing
	description: "Command to show super cluster of entity the diagram of which%
				%is currently displayed."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SUPER_CLUSTER_DIAGRAM_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND

create
	make

feature -- Basic operations

	execute is
			-- Perform operation.
		local
			cla_s: CLASSI_STONE
			clu_s: CLUSTER_STONE
			clu: CLUSTER_I
		do
			if tool.class_view /= Void then
				cla_s := tool.class_stone
				if cla_s /= Void and then cla_s.is_valid then
					clu := cla_s.class_i.cluster
				end
			elseif tool.cluster_view /= Void then
				clu_s := tool.cluster_stone
				if clu_s /= Void and then clu_s.is_valid then
					clu := clu_s.cluster_i.parent_cluster
				end
			end
			if clu /= Void then
				create clu_s.make (clu)
				if clu_s.is_valid then
					tool.tool.set_stone (clu_s)
				end
			end
		end

feature {NONE} -- Implementation

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_super_cluster
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.F_super_cluster_diagram
		end

	description: STRING is
			-- Description for this command.
		do
			Result := Interface_names.F_super_cluster_diagram
		end

	name: STRING is "Supercluster_diagram";
			-- Name of the command. Used to store the command in the
			-- preferences.

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

end -- class EB_SUPER_CLUSTER_DIAGRAM_COMMAND
