indexing
	description: "Use to search in whatever object that contains data."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MSR_SEARCH_IN_SCOPE_STRATEGY

inherit
	MSR_SEARCH_STRATEGY
		redefine
			launch,
			reset_all,
			is_search_prepared
		end

create

	make

feature -- Initialization

	make (a_keyword: like keyword;
			a_range: like surrounding_text_range;
			widget: like scope_container;
			only_compiled_class: like only_compiled_class_searched) is
			-- Make with a scope container, a list for example
		require
			widget_not_void: widget /= Void
			keyword_attached: a_keyword /= Void
			range_positive: a_range >= 0
		do
			make_search_strategy (a_keyword, a_range)
			scope_container:= widget
			only_compiled_class_searched_internal := only_compiled_class
		ensure
			scope_container_not_void: scope_container /= Void
			only_compiled_class_set: only_compiled_class_searched_internal = only_compiled_class
		end

feature	-- Status report

	is_scope_container_set: BOOLEAN is
			-- Is container set?
		do
			Result:= (scope_container /= Void)
		end

	is_search_prepared: BOOLEAN is
			-- Is search prepared?
		do
			Result := True
		end

	is_subcluster_searched: BOOLEAN is
			-- Are subclusters searched?
		do
			Result := is_subcluster_searched_internal
		end

	only_compiled_class_searched: BOOLEAN is
			-- Only compiled class are searched?
		do
			Result := only_compiled_class_searched_internal
		end

feature -- Basic operation

	launch is
			-- Launching searching.
		local
			l_list: EV_LIST
			l_class_i: CLASS_I
			l_group: CONF_GROUP
			l_folder: EB_FOLDER
			l_group_strategy: MSR_SEARCH_GROUP_STRATEGY
			l_class_strategy: MSR_SEARCH_CLASS_STRATEGY
			l_folder_strategy: MSR_SEARCH_EB_FOLDER_STRATEGY
		do
			create item_matched_internal.make (0)
			l_list ?= scope_container
			if l_list /= Void then
				from
					l_list.start
				until
					l_list.after
				loop
					l_class_i ?= l_list.item.data
					l_group ?= l_list.item.data
					l_folder ?= l_list.item.data
					if l_group /= Void then
						create l_group_strategy.make (keyword,
														surrounding_text_range_internal,
														l_group,
														only_compiled_class_searched)
						if case_sensitive then
							l_group_strategy.set_case_sensitive
						else
							l_group_strategy.set_case_insensitive
						end
						l_group_strategy.set_regular_expression_used (is_regular_expression_used)
						l_group_strategy.set_subgroup_searched (is_subcluster_searched)
						l_group_strategy.set_whole_word_matched (is_whole_word_matched)
						l_group_strategy.launch
						item_matched.append (l_group_strategy.item_matched)
					elseif l_class_i /= Void then
						create l_class_strategy.make (keyword,
														surrounding_text_range_internal,
														l_class_i,
														only_compiled_class_searched)
						if case_sensitive then
							l_class_strategy.set_case_sensitive
						else
							l_class_strategy.set_case_insensitive
						end
						l_class_strategy.set_regular_expression_used (is_regular_expression_used)
						l_class_strategy.set_keyword (keyword)
						l_class_strategy.set_surrounding_text_range (surrounding_text_range_internal)
						l_class_strategy.set_whole_word_matched (is_whole_word_matched)
						l_class_strategy.launch
						item_matched.append (l_class_strategy.item_matched)
					elseif l_folder /= Void then
						create l_folder_strategy.make (keyword,
														surrounding_text_range_internal,
														l_folder,
														only_compiled_class_searched)
						if case_sensitive then
							l_folder_strategy.set_case_sensitive
						else
							l_folder_strategy.set_case_insensitive
						end
						l_folder_strategy.set_regular_expression_used (is_regular_expression_used)
						l_folder_strategy.set_subgroup_searched (is_subcluster_searched)
						l_folder_strategy.set_whole_word_matched (is_whole_word_matched)
						l_folder_strategy.launch
						item_matched.append (l_folder_strategy.item_matched)
					end
					l_list.forth
				end
			end
			launched := True
			item_matched.start
		end

	reset_all is
			-- Reset all.
		do
			Precursor
			scope_container := Void
		end

feature -- Element change.

	set_subcluster_searched (a_bool: BOOLEAN) is
			-- If set subclusters in `cluster_i' are searched.
		do
			is_subcluster_searched_internal := a_bool
		end

feature -- Implementation

	scope_container: ANY
			-- Container that contains data to be searched.

	class_strategy: MSR_SEARCH_CLASS_STRATEGY
			-- Class strategy to search in classes in current cluster

	cluster_strategy: MSR_SEARCH_CLUSTER_STRATEGY
			-- Cluster strategy to search in subclusters in current cluster

	is_subcluster_searched_internal: BOOLEAN
			-- Are subclusters in `cluster_i' searched.

	only_compiled_class_searched_internal: BOOLEAN;
			-- Only compiled class are searched?

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
