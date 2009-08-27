note
	description: "[
					Object that represents a domain used in Eiffel query language
					
					Basic conception
					
					The most basic conception in Eiffel Query Language (EQL) is domain. 
					A domain is a list of some type of basic element. A domain is like a one column relation in SQL.
					
					Type of a domain depends on type of its elements.
					There are 10 different kinds of basic elements:
					1.	Target: Target of current system or target of a library. See {QL_TAREGET}
					2.	Group: Groups in a target, can be a cluster, a library or an assembly. See {QL_GROUP}.
					3.	Class: Classes contained in a group. See {QL_CLASS}.
					4.	Generic: Formal generics of a class. See {QL_GENERIC}.
					5.	Feature: Features in a class, there two types of features: 
						real feature and invariant (class invariant is treated as a special type of feature). See{QL_FEATURE}.
					6.	Contract: Assertions associated with a feature. Class invariant assertions are considered 
						associated with feature `invariant'. See{QL_ASSERTION}.
					7.	Local: Local variables of a feature. See {QL_LOCAL}.
					8.	Argument: Formal arguments of a feature. See {QL_ARGUMENT}.
					9.	Line: A line in a code-related element. Code-related element is an basic element which represents 
						a piece of source code, including Class, Generic, Feature, Contract, Local and Argument. See{QL_LINE}.
					10.	Quantity: A double value element. See {QL_QUANTITY}.

					-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

					Major operation

					The major operation of EQL is domain projection or transformation using a domain generator with some criterion.
					For more information of domain generator, see {QL_DOMAIN_GENERATOR}.
					One domain of certain type can be projected to another domain of the same type using some criterion and
					one domain of certain type can be transformed into another domain with a different type.
					
					-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

					Criterion
	
					Each kind of basic element has a set of criteria associated with it. 
					For example, basic element class {QL_CLASS} has criteria such as "is_deferred", "is_effective", "name_is", "ancestor_is". 
					And basic element feature has criteria such as "is_query", "is_command", "return_type_is".

					A criterion can be prefixed with logical operator "not".
					And same type of criteria can be combined using logical operator "and", "or".
					Different kinds of criteria CANNOT be combined together.
					For more information of criteria for each type of basic element,
					see {QL_CRITERION_FACTORY} and its descendant classes.

					-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
					
					Example
					
						l_class_cri: QL_CLASS_CRITERION
						l_class_domain: QL_CLASS_DOMAIN
						l_class_domain_generator: QL_CLASS_DOMAIN_GENERATOR
						...
						l_class_cri := class_criterion_factory.criterion_with_name ("name_is", ["STRING", True, True])
							-- Get a class criterion from criterion factory. `class_criterion_factory' is defined in {QL_SHARED}.
							-- This criterion tests if a class is named "STRING".
						create l_class_domain_generator.make (l_class_cri, True)
							-- Get a class domain generator and set the class name criterion into it.
							-- The boolean argument means store satisfied item into result domain.
						l_class_domain ?= system_target_domain.new_domain (l_class_domain_generator)
							-- Transform `system_target_domain' into `l_class_domain'.
							-- `system_target_domain' is defined in `QL_SHARED'. It represents a domain which
							-- contains the application target element of current system.
						
						Now we get a class domin, in which there is a QL_CLASS item representing a class named "STRING".
						
						We can use `l_class_domain' to generate new domains:
						
						l_feature_cri: QL_FEATURE_CRITERION
						l_feature_domain: QL_FEATURE_DOMAIN
						l_feature_domain_generator: QL_FEATURE_DOMAIN_GENERATOR
						...
						l_feature_cri := feature_criterion_factory.criterion_with_name ("is_command", [])
							-- Get a feature criterion from `feature_criterion_factory' which is defined in {QL_SHARED}.
						create l_feature_domain_generator.make (l_feature_cri, True)
						l_feature_domain ?= l_class_domain.new_domain (l_feature_domain_generator)
						
						Now we get a feature domain, in which all commands in class {STRING} is available.
					
					And you can generate feature domain directly from a target domain.
					For example:
						Let's reuse system_target_domain, l_feature_cri, l_feature_domain, l_feature_domain_generator which
						are defined before.
						l_feature_domain ?= system_target_domain.new_domain (l_feature_domain_generator).
							-- Now we get all commands in current system, no matter to which classes they belong.
					]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_DOMAIN

inherit
	REFACTORING_HELPER
		undefine
			copy,
			is_equal
		end

	QL_VISITABLE

	QL_SHARED_SCOPE_CONSTANTS
		undefine
			copy,
			is_equal
		end

	QL_SHARED_SCOPES
		undefine
			is_equal,
			copy
		end

	QL_UTILITY
		undefine
			is_equal,
			copy
		end

feature -- Access

	content: LIST [QL_ITEM]
			-- Content of current domain
		deferred
		ensure
			result_attached: Result /= Void
		end

	scope: QL_SCOPE
			-- Scope of current domain			
		deferred
		ensure
			result_attached: Result /= Void
		end

	domain_generator: QL_DOMAIN_GENERATOR
			-- Domain generator which can generate domains of same type as Current domain
		deferred
		ensure
			result_attached: Result /= Void
		end

feature -- Status report

	is_empty: BOOLEAN
			-- Is `content' empty?
		deferred
		end

	count: INTEGER
			-- Number of items in `content'
		deferred
		end

	is_delayed: BOOLEAN
			-- Is `Current' a delayed domain?
			-- A delayed domain means that `content' of the domain is not defined until a certain time.
			-- For example, in query:
			--     from "base" select class where (count feature from current_class > 10)
			-- in this query, current_class is a delayed domain. Content of this delayed domain
			-- is only meaningful when this query is executed. To be more detailed, when this query
			-- executes, it will iterate all classes in group "base", and for every class, current_class
			-- defines a domain which has one item which is the current iterated class in it.			
		do
		end

	is_target_domain: BOOLEAN
			-- Is current a target domain?
		do
		end

	is_group_domain: BOOLEAN
			-- Is current a group domain?
		do
		end

	is_class_domain: BOOLEAN
			-- Is current a class domain?
		do
		end

	is_generic_domain: BOOLEAN
			-- Is current a generic domain?
		do
		end

	is_feature_domain: BOOLEAN
			-- Is current a feature domain?
		do
		end

	is_argument_domain: BOOLEAN
			-- Is current a argument domain?
		do
		end

	is_local_domain: BOOLEAN
			-- Is current a local domain?
		do
		end

	is_assertion_domain: BOOLEAN
			-- Is current a assertion domain?
		do
		end

	is_line_domain: BOOLEAN
			-- Is current a line domain?
		do
		end

	is_quantity_domain: BOOLEAN
			-- Is current a quantity domain?
		do
		end

feature -- Removal

	wipe_out
			-- Remove all items.
		deferred
		end

	clear_cache
			-- Clear cache information.
			-- cache information is used for optimization.
		do
		end

feature -- Domain creation

	new_domain (a_generator: QL_DOMAIN_GENERATOR): QL_DOMAIN
			-- New domain generated by `a_generator'
		require
			a_generator_attached: a_generator /= Void
		do
			a_generator.reset_domain
			prepare_before_new_domain_generation
			a_generator.process_domain (Current)
			cleanup_after_new_domain_generation
			Result := a_generator.domain.twin
		ensure
			result_attached: Result /= Void
		end

feature -- Visit

	process (a_visitor: QL_VISITOR)
			-- Process `a_visitor'.
		do
			a_visitor.process_domain (Current)
		end

feature -- Preparation and cleanup

	prepare_before_new_domain_generation
			-- Prepare before new domain generation.
		do
		end

	cleanup_after_new_domain_generation
			-- Clean up after new domain generation.
		do
		end

feature -- Sorting

	sort (a_test_agent: FUNCTION [ANY, TUPLE [item_a: like item_type; item_b: like item_type], BOOLEAN])
			-- Use `a_test_agent' to sort current.
		require
			a_test_agent_attached: a_test_agent /= Void
		local
			l_sorted_list: ARRAYED_LIST [like item_type]
			l_agent_tester: AGENT_EQUALITY_TESTER [like item_type]
			l_sorter: QUICK_SORTER [like item_type]
			l_content: like content
		do
			if not is_empty then
				create l_sorted_list.make (count)
				l_content := content
				l_content.do_all (agent l_sorted_list.extend)
				l_content.wipe_out
				create l_agent_tester.make (a_test_agent)
				create l_sorter.make (l_agent_tester)
				l_sorter.sort (l_sorted_list)
				from
					l_sorted_list.start
				until
					l_sorted_list.after
				loop
					l_content.extend (l_sorted_list.item_for_iteration)
					l_sorted_list.forth
				end
				l_sorted_list.wipe_out
			end
		end

feature -- Set operation

	union (other: like Current): like Current
			-- An new domain containing all the elements from both `Current' and `other'.
		require
			other_attached: other /= Void
			current_and_other_of_same_type: same_type (other)
		deferred
		ensure
			result_attached: Result /= Void
		end

	intersect (other: like Current): like Current
			-- A new domain containing all the elements that are in both `Current' and `other'.			
		require
			other_attached: other /= Void
			current_and_other_of_same_type: same_type (other)
		deferred
		ensure
			result_attached: Result /= Void
		end

	minus (other: like Current): like Current
			-- A new domain containing all the elements of `Current', with the elements from `other' removed.
		require
			other_attached: other /= Void
			current_and_other_of_same_type: same_type (other)
		deferred
		ensure
			result_attached: Result /= Void
		end

	distinct: like Current
			-- A new domain which only contain distinct items in Current
		deferred
		ensure
			result_attached: Result /= Void
		end

	is_subset_of (other: like Current): BOOLEAN
			-- Is current domain a subset of `other'?
		require
			other_attached: other /= Void
			current_and_other_are_of_same_type: scope = other.scope
		local
			l_other_set: SEARCH_TABLE [like item_type]
			l_cur_content: like content
			l_cursor: CURSOR
		do
			create l_other_set.make (other.count)
			other.content.do_all (agent l_other_set.put)
			l_cur_content := content
			l_cursor := l_cur_content.cursor
			from
				Result := True
				l_cur_content.start
			until
				l_cur_content.after or not Result
			loop
				Result := l_other_set.has (l_cur_content.item)
				l_cur_content.forth
			end
			l_cur_content.go_to (l_cursor)
		end

	is_proper_subset_of (other: like Current): BOOLEAN
			-- Is current domain a proper subset of `other'?
		do
			Result := other.count > count and then is_subset_of (other)
		end

feature{QL_CRITERION} -- Implementation

	class_item_from_current_domain (a_class: CONF_CLASS): QL_CLASS
			-- If `a_class' is included in current domain, return the item,
			-- otherwise return Void.
		require
			a_class_attached: a_class /= Void
		deferred
		ensure
			good_result: Result /= Void implies Result.is_valid_domain_item
		end

	class_item_list_from_current_domain (a_classes: LIST [CLASS_C]): LIST [QL_CLASS]
			-- If a class in `a_classes' is included in current domain, then its coordinate QL_CLASS object
			-- will appear in `Result'. If no class in `a_classes' i s included in current domain,
			-- return an empty list.
		local
			l_class: QL_CLASS
		do
			if a_classes /= Void and then not a_classes.is_empty then
				create {ARRAYED_LIST [QL_CLASS]}Result.make (a_classes.count)
				from
					a_classes.start
				until
					a_classes.after
				loop
					l_class := class_item_from_current_domain (a_classes.item.lace_class.config_class)
					if l_class /= Void then
						Result.extend (l_class)
					end
					a_classes.forth
				end
			else
				create {ARRAYED_LIST [QL_CLASS]}Result.make (0)
			end
		ensure
			result_attached: Result /= Void
		end

	feature_item_from_current_domain (e_feature: E_FEATURE): QL_FEATURE
			-- If `e_feature' is included in current domain, return the item,
			-- otherwise return Void.
		require
			e_feature_attached: e_feature /= Void
		deferred
		ensure
			good_result: Result /= Void implies Result.is_valid_domain_item
		end

	invariant_item_from_current_domain (a_class_c: CLASS_C): QL_FEATURE
			-- If invariant part of `a_class_c' is included in current domain,
			-- then return an QL_FEATURE object representing this invariant part, otherwise,
			-- return Void.
		require
			a_class_c_attached: a_class_c /= Void
			a_class_c_has_invariant: a_class_c.has_invariant
		deferred
		ensure
			good_result: Result /= Void implies (Result.is_valid_domain_item and then Result.is_invariant_feature)
		end

	class_from_group (a_class: CONF_CLASS; a_group: QL_GROUP; a_class_table: HASH_TABLE [HASH_TABLE [QL_CLASS, CONF_CLASS], CONF_GROUP]): QL_CLASS
			-- Find out if `a_class' is defined directly in `a_group'.
			-- If yes, return a QL_CLASS object representing `a_class' in `a_group',
			-- otherwise return Void.
			-- `a_class_table' is used to cache temporary results for optimization.
		require
			a_class_attached: a_class /= Void
			a_group_attached: a_group /= Void
			a_group_valid: a_group.is_valid_domain_item
			a_class_table_attached: a_class_table /= Void
		local
			l_classes: HASH_TABLE [CONF_CLASS, STRING]
			l_class_table: HASH_TABLE [QL_CLASS, CONF_CLASS]
			l_conf_class: CONF_CLASS
		do
			l_class_table := a_class_table.item (a_group.group)
			if l_class_table = Void then
				if a_group.group.classes_set then
					l_classes := a_group.group.classes.twin
					create l_class_table.make (l_classes.count)
					a_class_table.put (l_class_table, a_group.group)
					from
						l_classes.start
					until
						l_classes.after
					loop
						l_conf_class := l_classes.item_for_iteration
						l_class_table.put (create{QL_CLASS}.make_with_parent (l_conf_class, a_group), l_conf_class)
						l_classes.forth
					end
				else
					create l_class_table.make (0)
					a_class_table.put (l_class_table, a_group.group)
				end
			end
			Result := l_class_table.item (a_class)
		end

feature{NONE} -- Implementation

	is_domain_valid: BOOLEAN
			-- Is current domain valid?
		do
			Result := content.for_all (agent is_item_valid)
		ensure
			good_result: Result implies content.for_all (agent is_item_valid)
		end

	is_item_valid (a_item: like item_type): BOOLEAN
			-- Is `a_item' valid?
			-- True if all items in current are valid domain item.
			-- See {QL_ITEM}.`is_valid_domain_item' for more information.
		do
			Result := a_item /= Void and then a_item.is_valid_domain_item
		ensure
			good_result: Result implies (a_item /= Void and then a_item.is_valid_domain_item)
		end

feature{NONE} -- Implementation/Set operations

	internal_union (a_new_domain, a_other_domain: like Current)
			-- Fill `a_new_domain' with elements from both `Current' and `other'.			
		require
			a_new_domain_attached: a_new_domain /= Void
			a_other_domain_attached: a_other_domain /= Void
			a_new_domain_and_a_other_domain_of_same_type: a_new_domain.same_type (a_other_domain)
			a_new_domain_is_empty: a_new_domain.is_empty
		local
			l_item_set: SEARCH_TABLE [like item_type]
			l_tester: AGENT_EQUALITY_TESTER [like item_type]
			l_content: like content
			l_content2: like content
			l_item: like item_type
		do
			if a_other_domain.is_empty then
				a_new_domain.content.fill (content)
			else
				create l_tester.make (agent are_items_equivalent)
				create l_item_set.make_with_key_tester (count, l_tester)
				content.do_all (agent l_item_set.put)
				l_content := a_other_domain.content
				l_content2 := a_new_domain.content
				from
					l_content.start
				until
					l_content.after
				loop
					l_item := l_content.item
					if not l_item_set.has (l_item) then
						l_content2.extend (l_item)
					end
					l_content.forth
				end
				l_item_set.wipe_out
				l_content2.fill (content)
			end
		end

	internal_intersect (a_new_domain, a_other_domain: like Current)
			-- Fill `a_new_domain' with all the elements that are in both `Current' and `a_other_domain'.
		require
			a_new_domain_attached: a_new_domain /= Void
			a_other_domain_attached: a_other_domain /= Void
			a_new_domain_and_a_other_domain_of_same_type: a_new_domain.same_type (a_other_domain)
			a_new_domain_is_empty: a_new_domain.is_empty
		local
			l_item_set: SEARCH_TABLE [like item_type]
			l_tester: AGENT_EQUALITY_TESTER [like item_type]
			l_content: like content
			l_content2: like content
			l_item: like item_type
		do
			if not a_other_domain.is_empty then
				create l_tester.make (agent are_items_equivalent)
				create l_item_set.make_with_key_tester (count, l_tester)
				content.do_all (agent l_item_set.put)
				l_content := a_other_domain.content
				l_content2 := a_new_domain.content
				from
					l_content.start
				until
					l_content.after
				loop
					l_item := l_content.item
					if l_item_set.has (l_item) then
						l_content2.extend (l_item)
					end
					l_content.forth
				end
				l_item_set.wipe_out
			end
		end

	internal_complement (a_new_domain, a_other_domain: like Current)
			-- Fill `a_new_domain' with all the elements of `Current', with the elements from `a_other_domain' removed.			
		require
			a_new_domain_attached: a_new_domain /= Void
			a_other_domain_attached: a_other_domain /= Void
			a_new_domain_and_a_other_domain_of_same_type: a_new_domain.same_type (a_other_domain)
			a_new_domain_is_empty: a_new_domain.is_empty
		local
			l_item_set: SEARCH_TABLE [like item_type]
			l_tester: AGENT_EQUALITY_TESTER [like item_type]
			l_content: like content
			l_content2: like content
			l_item: like item_type
		do
			if a_other_domain.is_empty then
				a_new_domain.content.fill (content)
			else
				create l_tester.make (agent are_items_equivalent)
				create l_item_set.make_with_key_tester (count, l_tester)
				content.do_all (agent l_item_set.put)
				l_content := a_other_domain.content
				l_content2 := a_new_domain.content
				from
					l_content.start
				until
					l_content.after
				loop
					l_item := l_content.item
					l_item_set.remove (l_item)
					l_content.forth
				end
				from
					l_item_set.start
				until
					l_item_set.after
				loop
					l_content2.extend (l_item_set.item_for_iteration)
					l_item_set.forth
				end
			end
		end

	internal_distinct (a_domain: like Current)
			-- Fill `a_domain' with distinct items in Current
		require
			a_domain_attached: a_domain /= Void
		local
			l_hash_set: SEARCH_TABLE [like item_type]
			l_content: like content
			l_domain_content: LIST [like item_type]
		do
			create l_hash_set.make (count)
			l_content := content
			l_content.do_all (agent l_hash_set.force)
			from
				l_domain_content := a_domain.content
				l_hash_set.start
			until
				l_hash_set.after
			loop
				l_domain_content.extend (l_hash_set.item_for_iteration)
				l_hash_set.forth
			end
		end

feature{NONE} -- Item comparison

	are_items_equivalent (a_item, b_item: like item_type): BOOLEAN
			-- Is `a_item' equal to `b_item'?
		require
			a_item_attached: a_item /= Void
			b_item_attached: b_item /= Void
		do
			if a_item.same_type (b_item) then
				Result := a_item.is_equal (b_item)
			end
		ensure
			good_result: Result implies (a_item.same_type (b_item) and then a_item.is_equal (b_item))
		end

	item_type: QL_ITEM
			-- Anchor type for items in current domain

invariant
	content_attached: content /= Void
	domain_valid: is_domain_valid

note
        copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
