indexing
	description: "Use to search in whatever object that contains data."
	date: "$Date$"
	revision: "$Revision$"

class
	MSR_SEARCH_IN_SCOPE_STRATEGY

inherit
	MSR_SEARCH_CLUSTER_STRATEGY
		redefine
			launch,
			reset_all,
			is_search_prepared
		end
	
create
	
	make_with_scope_container

feature -- Initialization

	make_with_scope_container (widget: ANY) is
			-- Make with a scope container, a list for example
		require
			widget_not_void: widget /= Void
		do
			make
			reset_all
			scope_container:= widget
		ensure
			scope_container_not_void: scope_container /= Void
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
			Result := true
		end		
		
feature -- Basic operation

	launch is
			-- Launching searching.
		local
			l_list: EV_LIST
			l_class_i: CLASS_I
			l_cluster_i: CLUSTER_I
			l_cluster_strategy: MSR_SEARCH_CLUSTER_STRATEGY
			l_class_strategy:MSR_SEARCH_CLASS_STRATEGY
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
					l_cluster_i ?= l_list.item.data
					if l_cluster_i /= Void then
						create l_cluster_strategy.make_with_cluster (l_cluster_i)
						if case_sensitive then
							l_cluster_strategy.set_case_sensitive
						else
							l_cluster_strategy.set_case_insensitive
						end
						l_cluster_strategy.set_regular_expression_used (is_regular_expression_used)
						l_cluster_strategy.set_keyword (keyword)
						l_cluster_strategy.set_subcluster_searched (is_subcluster_searched)
						l_cluster_strategy.set_surrounding_text_range (surrounding_text_range_internal)
						l_cluster_strategy.set_whole_word_matched (is_whole_word_matched)
						l_cluster_strategy.launch
						item_matched.append (l_cluster_strategy.item_matched)
					end
					if l_class_i /= Void then
						create l_class_strategy.make_with_class (l_class_i)
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
					end
					l_list.forth
				end
			end
			launched := true
			item_matched.start
		end
		
	reset_all is
			-- Reset all.
		do
			Precursor
			scope_container := Void
		end
		

feature -- Implementation

	scope_container: ANY
			-- Container that contains data to be searched.

end
