indexing
	description: "Object that represents a query for cluster in an Eiffel system"
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

end
