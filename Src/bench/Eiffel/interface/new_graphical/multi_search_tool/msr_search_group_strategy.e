indexing
	description: "Search in a CONF_GROUP"
	date: "$Date$"
	revision: "$Revision$"

class
	MSR_SEARCH_GROUP_STRATEGY

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

	make (a_keyword: STRING; a_range: INTEGER; a_group: CONF_GROUP; only_compiled_class: BOOLEAN) is
			-- Initialization with a group.
		require
			a_group_not_void: a_group /= Void
			keyword_attached: a_keyword /= Void
			range_positive: a_range >= 0
		do
			make_search_strategy (a_keyword, a_range)
			set_group (a_group)
			only_compiled_class_searched := only_compiled_class
		end

feature -- Status report

	is_group_set: BOOLEAN is
			-- Is `group' set?
		do
			Result := (group /= Void)
		end

	is_subgroup_searched: BOOLEAN is
			-- Are subgroups in `group' searched?
		do
			Result := is_subgroup_searched_internal
		end

	is_search_prepared: BOOLEAN is
			-- Is search prepared?
		do
			Result :=
			Precursor and
			is_group_set
		end

	only_compiled_class_searched: BOOLEAN
			-- Only compiled class are searched?

feature -- Element change

	set_subgroup_searched (a_bool: BOOLEAN) is
			-- If set subgroups in `group' are searched.
		do
			is_subgroup_searched_internal := a_bool
		end

feature -- Basic operatioin

	launch is
			-- Launch searching.
		local
			classes: HASH_TABLE [CLASS_I, STRING]
			subcluster: ARRAYED_LIST [CLUSTER_I]
			l_cluster: CLUSTER_I
			l_cluster_strategy: MSR_SEARCH_CLUSTER_STRATEGY
			l_library: CONF_LIBRARY
			l_clusters: HASH_TABLE [CONF_CLUSTER, STRING]
			l_group_strategy: like Current
		do
			create item_matched_internal.make (100)
			if group.is_cluster then
				check
					l_cluster_not_void: l_cluster /= Void
				end
				l_cluster ?= group
				if is_subgroup_searched then
					subcluster := l_cluster.sub_clusters
					if not subcluster.is_empty then
						from
							subcluster.start
						until
							subcluster.after
						loop
							create l_cluster_strategy.make (keyword,
														surrounding_text_range_internal,
														subcluster.item,
														only_compiled_class_searched)
							if case_sensitive then
								l_cluster_strategy.set_case_sensitive
							else
								l_cluster_strategy.set_case_insensitive
							end
							l_cluster_strategy.set_regular_expression_used (is_regular_expression_used)
							l_cluster_strategy.set_subcluster_searched (is_subgroup_searched)
							l_cluster_strategy.set_whole_word_matched (is_whole_word_matched)
							l_cluster_strategy.launch
							if l_cluster_strategy.is_launched then
								item_matched_internal.finish
								item_matched_internal.merge_right (l_cluster_strategy.item_matched)
							end
							subcluster.forth
						end
					end
				end
				classes := l_cluster.classes
				if classes /= Void and then not classes.is_empty then
					from
						classes.start
					until
						classes.after
					loop
						create class_strategy.make (keyword,
												surrounding_text_range_internal,
												classes.item_for_iteration,
												only_compiled_class_searched)
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
			elseif group.is_library then
				l_library ?= group
				check
					l_libary_not_void: l_library /= Void
				end
				if l_library.library_target /= Void then
					l_clusters := l_library.library_target.clusters
				end
				if l_clusters /= Void then
					from
						l_clusters.start
					until
						l_clusters.after
					loop
						create l_group_strategy.make (keyword,
													surrounding_text_range,
													l_clusters.item_for_iteration,
													only_compiled_class_searched)
						if case_sensitive then
							l_group_strategy.set_case_sensitive
						else
							l_group_strategy.set_case_insensitive
						end
						l_group_strategy.set_regular_expression_used (is_regular_expression_used)
						l_group_strategy.set_subgroup_searched (is_subgroup_searched)
						l_group_strategy.set_whole_word_matched (is_whole_word_matched)
						l_group_strategy.launch
						item_matched.append (l_group_strategy.item_matched)
						l_clusters.forth
					end
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
			group := Void
			is_subgroup_searched_internal := false
			only_compiled_class_searched := false
		end

feature -- Element change

	set_group (a_group: CONF_GROUP) is
			-- Set `group' to a_group.
		do
			group := a_group
		end

feature {NONE} -- Implementation

	class_strategy: MSR_SEARCH_CLASS_STRATEGY
			-- Class strategy to search in classes in current group

	group: CONF_GROUP
			-- Group to be searched in

	is_subgroup_searched_internal: BOOLEAN
			-- Are subgroups in `group' searched.

invariant
	invariant_clause: True -- Your invariant here

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
