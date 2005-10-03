indexing
	description: "Search strategy used to search the whole project"
	date: "$Date$"
	revision: "$Revision$"

class
	MSR_SEARCH_WHOLE_PROJECT_STRATEGY

inherit
	MSR_SEARCH_IN_SCOPE_STRATEGY
		redefine
			launch
		end
	
create
	make_with_scope_container
	
feature -- Basic Operation	
	
	launch is
			-- Launch the search
		local
			l_clusters: EB_CLUSTERS
			l_cluster_strategy: MSR_SEARCH_CLUSTER_STRATEGY
		do
			create item_matched_internal.make (0)
			l_clusters ?= scope_container
			if l_clusters /= Void then
				from
					l_clusters.clusters.start
				until
					l_clusters.clusters.after
				loop
					create l_cluster_strategy.make_with_cluster (l_clusters.clusters.item.actual_cluster)
					if case_sensitive then
						l_cluster_strategy.set_case_sensitive
					else
						l_cluster_strategy.set_case_insensitive
					end
					l_cluster_strategy.set_regular_expression_used (is_regular_expression_used)
					l_cluster_strategy.set_keyword (keyword)
					l_cluster_strategy.set_subcluster_searched (true)
					l_cluster_strategy.set_surrounding_text_range (surrounding_text_range_internal)
					l_cluster_strategy.set_whole_word_matched (is_whole_word_matched)
					l_cluster_strategy.launch
					if l_cluster_strategy.is_launched then
						item_matched_internal.finish
						item_matched_internal.merge_right (l_cluster_strategy.item_matched)
					end
					l_clusters.clusters.forth
				end
			end
			launched := true
			item_matched.start
		end
end
