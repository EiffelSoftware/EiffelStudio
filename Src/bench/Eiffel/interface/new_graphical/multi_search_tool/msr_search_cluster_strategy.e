indexing
	description: "Use to search in a CLUSTER_I"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MSR_SEARCH_CLUSTER_STRATEGY
	
inherit
	MSR_SEARCH_STRATEGY
		redefine
			launch,
			reset_all,
			is_search_prepared
		end

create
	make
		
feature {NONE} -- Initialization
	
	make (a_keyword: STRING; a_range: INTEGER; a_cluster: CLUSTER_I; only_compiled_class: BOOLEAN) is
			-- Initialization with a cluster
		require
			a_cluster_not_void: a_cluster /= Void
			keyword_attached: a_keyword /= Void
			range_positive: a_range >= 0
		do
			make_search_strategy (a_keyword, a_range)
			set_cluster (a_cluster)
			only_compiled_class_searched := only_compiled_class
		end
		
feature -- Status report
	
	is_cluster_set: BOOLEAN is
			-- Is `cluster_i' set?
		do
			Result := (cluster_i /= Void)	
		end

	is_subcluster_searched: BOOLEAN is
			-- Are subclusters in `cluster_i' searched?
		do
			Result := is_subcluster_searched_internal
		end
	
	is_search_prepared: BOOLEAN is
			-- Is search prepared?
		do
			Result := 
			Precursor and
			is_cluster_set	
		end	
		
	only_compiled_class_searched: BOOLEAN
			-- Only compiled class are searched?

feature -- Element change

	set_subcluster_searched (a_bool: BOOLEAN) is
			-- If set subclusters in `cluster_i' are searched.
		do
			is_subcluster_searched_internal := a_bool
		end
		
feature -- Basic operatioin

	launch is
			-- Launch searching.
		local
			subcluster: ARRAYED_LIST [CLUSTER_I]
			classes:HASH_TABLE [CLASS_I, STRING]
		do
			create item_matched_internal.make (0)
			if is_subcluster_searched then
				subcluster := cluster_i.sub_clusters
				if not subcluster.is_empty then
					from
						subcluster.start
					until
						subcluster.after
					loop
						create cluster_strategy.make (keyword, surrounding_text_range_internal, subcluster.item, only_compiled_class_searched)
						if case_sensitive then
							cluster_strategy.set_case_sensitive
						else
							cluster_strategy.set_case_insensitive
						end
						cluster_strategy.set_regular_expression_used (is_regular_expression_used)
						cluster_strategy.set_subcluster_searched (is_subcluster_searched)
						cluster_strategy.set_whole_word_matched (is_whole_word_matched)
						cluster_strategy.launch
						if cluster_strategy.is_launched then
							item_matched_internal.finish
							item_matched_internal.merge_right (cluster_strategy.item_matched)
						end
						subcluster.forth
					end
				end
			end
			classes := cluster_i.classes
			if not classes.is_empty then
				from 
					classes.start
				until
					classes.after
				loop
					create class_strategy.make (keyword, surrounding_text_range_internal, classes.item_for_iteration, only_compiled_class_searched)
					if case_sensitive then
						class_strategy.set_case_sensitive
					else
						class_strategy.set_case_insensitive
					end
					class_strategy.set_regular_expression_used (is_regular_expression_used)
					class_strategy.set_whole_word_matched (is_whole_word_matched)
					class_strategy.launch
					if class_strategy.is_launched then
						item_matched_internal.finish
						item_matched_internal.merge_right (class_strategy.item_matched)
					end
					classes.forth
				end
			end
			launched := true
			if not item_matched_internal.is_empty then
				item_matched_internal.start
			end
		end
	
	reset_all is
			-- Reset all
		do
			Precursor
			class_strategy := Void
			cluster_strategy := Void
			cluster_i := Void
			is_subcluster_searched_internal := false
			only_compiled_class_searched := false
		end

feature -- Element change

	set_cluster (a_cluster: CLUSTER_I) is
			-- Set `cluster_i' to a_cluster.
		do
			cluster_i := a_cluster
		end

feature {NONE} -- Implementation

	class_strategy: MSR_SEARCH_CLASS_STRATEGY
			-- Class strategy to search in classes in current cluster
	
	cluster_strategy: MSR_SEARCH_CLUSTER_STRATEGY
			-- Cluster strategy to search in subclusters in current cluster
	
	cluster_i: CLUSTER_I
			-- Cluster to be searched in
			
	is_subcluster_searched_internal: BOOLEAN
			-- Are subclusters in `cluster_i' searched.

invariant
	invariant_clause: True -- Your invariant here

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

end
