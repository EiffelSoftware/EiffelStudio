note
	description: "[
		{EC_TAG_TREE_NODE} representing clusters in an Eiffel project.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	EC_TAG_TREE_CLUSTER_NODE [G -> TAG_ITEM]

inherit
	EC_TAG_TREE_NODE [G, CONF_CLUSTER]

create
	make

feature {NONE} -- Implementation

	process_ec_node (a_visitor: EC_TAG_TREE_NODE_VISITOR [G])
			-- <Precursor>
		do
			a_visitor.process_cluster_node (Current)
		end

	retrieve_item (a_project: EC_PROJECT_ACCESS): like item
			-- <Precursor>
		do
			if attached {EC_TAG_TREE_NODE [G, CONF_CLUSTER]} parent as l_parent then
				if attached l_parent.item (a_project) as l_cluster then
					Result := l_cluster.target.clusters.item (name)
				end
			elseif attached {EC_TAG_TREE_NODE [G, CONF_LIBRARY]} parent as l_parent then
				if attached l_parent.item (a_project) as l_library then
					Result := l_library.library_target.clusters.item (name)
				end
			end
			if Result = Void then
				Result := a_project.project.universe.cluster_of_name (name)
			end
		end
note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
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
