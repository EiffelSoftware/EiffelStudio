indexing
	description: "Object that represents a query for cluster in an Eiffel system"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_CLUSTER_QUERY

inherit
	EQL_QUERY
		redefine
			last_result
		end

feature -- Result

	last_result: EQL_SCOPE_RESULT [EQL_CLUSTER]
			-- Last result

feature{NONE} -- Implementation

	execute_over_single_scope (a_single_scope: EQL_SINGLE_SCOPE; a_criterion: EQL_CRITERION) is
			-- Execute over `a_single_scope' with `a_criterion'.
			-- If successful, store result in `last_result'.
		local
			l_system: EQL_SYSTEM
			l_clusters: ARRAYED_LIST [CLUSTER_I]
			l_node: EQL_TREE_NODE [EQL_CLUSTER]
		do
			if a_single_scope.is_system_scope then
				l_system ?= a_single_scope
				l_clusters := l_system.system_i.universe.clusters
				if not l_clusters.is_empty then
					from
						l_clusters.start
					until
						l_clusters.after
					loop
						rec_find_clusters (l_clusters.item, a_criterion, last_result)
						l_clusters.forth
					end
				end
			end
		end

	rec_find_clusters (a_cluster: CLUSTER_I; a_criterion: EQL_CRITERION; a_node: EQL_TREE_NODE [EQL_CLUSTER]) is
			-- Find all subclusters in `a_cluster' which satisfy `a_criterion' and store them in `last_result'.
		require
			last_result_not_void: last_result /= Void
			a_cluster_not_void: a_cluster /= Void
			a_criterion_not_void: a_criterion /= Void
			a_node_not_void: a_node /= Void
		local
			l_node: EQL_TREE_NODE [EQL_CLUSTER]
			l_clusters: ARRAYED_LIST [CLUSTER_I]
			l_ctxt: EQL_CONTEXT
		do
			create l_ctxt.make_with_cluster_i (a_cluster)
			if a_criterion.evaluate (l_ctxt) then
				create l_node.make_with_data (last_result, create{EQL_CLUSTER}.make_with_cluster_i (a_cluster))
				a_node.extend (l_node)
				l_clusters := a_cluster.sub_clusters
				if not l_clusters.is_empty then
					from
						l_clusters.start
					until
						l_clusters.after
					loop
						rec_find_clusters (l_clusters.item, a_criterion, l_node)
						l_clusters.forth
					end
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
