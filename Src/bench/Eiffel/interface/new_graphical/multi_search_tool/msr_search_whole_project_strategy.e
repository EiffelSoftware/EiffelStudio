indexing
	description: "Search strategy used to search the whole project"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MSR_SEARCH_WHOLE_PROJECT_STRATEGY

inherit
	MSR_SEARCH_IN_SCOPE_STRATEGY
		redefine
			launch
		end

	CONF_REFACTORING

create
	make

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
				conf_todo
--				from
--					l_clusters.clusters.start
--				until
--					l_clusters.clusters.after
--				loop
--					create l_cluster_strategy.make (keyword, surrounding_text_range_internal, l_clusters.clusters.item.actual_cluster, only_compiled_class_searched)
--					if case_sensitive then
--						l_cluster_strategy.set_case_sensitive
--					else
--						l_cluster_strategy.set_case_insensitive
--					end
--					l_cluster_strategy.set_regular_expression_used (is_regular_expression_used)
--					l_cluster_strategy.set_subcluster_searched (true)
--					l_cluster_strategy.set_whole_word_matched (is_whole_word_matched)
--					l_cluster_strategy.launch
--					if l_cluster_strategy.is_launched then
--						item_matched_internal.finish
--						item_matched_internal.merge_right (l_cluster_strategy.item_matched)
--					end
--					l_clusters.clusters.forth
--				end
			end
			launched := true
			item_matched.start
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
