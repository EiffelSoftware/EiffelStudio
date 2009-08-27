note
	description: "[
					Object that represents reference relations (supplier/client) between classes
					For a supplier/client relation, we have two different kinds:
					1. classes referenced by feature invocation
						For example, if in class A, we have a feature foo:
							foo is
								local
									l_str: STRING_32
								do
									create l_str.make_empty
								end
						then STRING_32 is a supplier of class A and this relation is by feature invocation
					2. classes only syntactically referenced
						For example, if in class A, we have a feature goo:
							goo: STRING_32 is
								local
									l_list: LINKED_LIST [STRING_32]
								do
								end
					   then STRING_32 and LINKED_LIST are only syntactically referenced by class A.
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_CLASS_REFERENCE_RELATION_CRI

inherit
	QL_CLASS_HIERARCHY_CRI
		redefine
			intrinsic_domain,
			reset
		end

feature{NONE} -- Initialization

	make (a_criterion_domain: like criterion_domain; a_invocation: BOOLEAN; a_syntactical: BOOLEAN; a_indirect: BOOLEAN)
			-- Initialize `criterion_domain' with `a_criterion_domain', `is_invocation_referenced_class_enabled' with `a_invocation',
			-- `is_syntactical_class_enabled' with `a_syntactical' and
			-- `is_indirect_class_enabled' with `a_indirect'.
		require
			a_criterion_domain_attached: a_criterion_domain /= Void
		do
			old_make (a_criterion_domain)
			is_invocation_referenced_class_enabled := a_invocation
			is_syntactical_class_enabled := a_syntactical
			is_indirect_class_enabled := a_indirect
		ensure
			criterion_domain_set: criterion_domain = a_criterion_domain
			is_syntactical_class_enabled_set: is_syntactical_class_enabled = a_syntactical
			is_indirect_class_enabled_set: is_indirect_class_enabled = a_indirect
			is_invocation_referenced_class_enabled_set: is_invocation_referenced_class_enabled = a_invocation
		end

feature{QL_DOMAIN} -- Intrinsic domain

	intrinsic_domain: QL_CLASS_DOMAIN
			-- Intrinsic_domain which can be inferred from current criterion			
		local
			l_list: like candidate_class_list
			l_class: QL_CLASS
			l_syntactical_classes: like only_syntactical_class_set
			l_generator: like used_in_domain_generator
		do
			if not is_criterion_domain_evaluated then
				initialize_domain
			end
			source_domain.clear_cache
			create Result.make
			l_list := candidate_class_list
			l_syntactical_classes := only_syntactical_class_set
			l_generator := used_in_domain_generator
			from
				l_list.start
			until
				l_list.after
			loop
				l_class := query_class_item (l_list.item_for_iteration.lace_class.config_class)
				if l_syntactical_classes.has (l_class.class_c.class_id) then
						-- For only syntactical referenced classes, we set `data' to 1.
					l_class.set_data (1)
				end
				Result.extend (l_class)
				l_generator.increase_internal_counter (l_class)
				l_list.forth
			end
		end

feature -- Status report

	is_syntactical_class_enabled: BOOLEAN
			-- Should syntactical classes be retrieved?			

	is_invocation_referenced_class_enabled: BOOLEAN
			-- Should classes referenced by feature invocation be retrieved?

	is_indirect_class_enabled: BOOLEAN
			-- Should indirect referenced be retrieved.
			-- If False, only adjacently referenced classes are retrieved.

feature -- Access

	only_syntactical_class_set: SEARCH_TABLE [INTEGER]
			-- Set of class id of classes which appear only as syntactical class (no feature in those class are invoked explicitly).

	reference_table: HASH_TABLE [SEARCH_TABLE [INTEGER], INTEGER]
			-- Table of class references.
			-- Key is class id of a class who references classes whose class id are specified in value.
			-- For example, if we are looking at supplier relationship:
			-- if class A(id=1) depends on class B(id=2), C(id=3), than in this table,
			-- there is a pair (value={2, 3}, key= 1).			

	referenced_classes (a_class_c: CLASS_C): LIST [CLASS_C]
			-- A list of classes referenced by `a_class_c'.
			-- In supplier criterion, it's suppliers of `a_class_c'.
			-- In client criterion, it's clients of `a_class_c'.
		require
			a_class_c_attached: a_class_c /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end

	syntactical_referenced_classes (a_class_c: CLASS_C): LIST [CLASS_C]
			-- A list of syntactically referened by `a_class_c'.
			-- In supplier criterion, it's syntactical suppliers of `a_class_c'.
			-- In client criterion, it's ssyntactical clients of `a_class_c'.
		require
			a_class_c_attached: a_class_c /= Void
		deferred
		end

feature{NONE} -- Implementation

	reset
			-- Reset internal structure
		do
			Precursor
			if only_syntactical_class_set = Void then
				create only_syntactical_class_set.make (100)
			else
				only_syntactical_class_set.wipe_out
			end
			if reference_table = Void then
				create reference_table.make (64)
			else
				reference_table.wipe_out
			end
		ensure then
			only_syntactical_class_set_valid: only_syntactical_class_set /= Void and then only_syntactical_class_set.is_empty
			reference_table_valid: reference_table /= Void and then reference_table.is_empty
		end

	mark_only_syntactical_classes (a_syntactical_class_list: LIST [CLASS_C]; a_non_syntactical_class_list: LIST [CLASS_C]): SEARCH_TABLE [CLASS_C]
			-- Mark only syntactically referenced classes in `only_syntactical_class_set' and
			-- return a class set which are distinct classes retrieved from `a_syntactical_class_list' and `a_non_syntactical_class_list' (Because
			-- referenced classes (`suppliers' or `clients') from a class may overlap with syntactically referenced classes (`syntactical_suppliers' or
			-- `syntactical_clients') from that class.
			-- `a_syntactical_class_list' and `a_non_syntactical_class_list'.
			-- `a_syntactical_class_list' is syntactically referenced classes.
			-- `a_non_syntactical_class_list' is explicitly referenced classes.
		require
			a_non_syntactical_class_list_attached: a_non_syntactical_class_list /= Void
		local
			l_class_id: INTEGER
			l_class_c: CLASS_C
			l_only_syntactical_class_set: like only_syntactical_class_set
			l_candidate_classes: like candidate_class_list
			l_cursor: CURSOR
			l_invocation_referenced: BOOLEAN
			l_referenced_class_set: SEARCH_TABLE [CLASS_C]
		do
			create Result.make_with_key_tester (a_non_syntactical_class_list.count, create {AGENT_EQUALITY_TESTER [CLASS_C]}.make (agent (a_class, b_class: CLASS_C): BOOLEAN do Result := a_class.class_id = b_class.class_id end))
			create l_referenced_class_set.make (a_non_syntactical_class_list.count)
			l_only_syntactical_class_set := only_syntactical_class_set
			l_invocation_referenced := is_invocation_referenced_class_enabled
			l_candidate_classes := candidate_class_list
				-- Unmark those classes who were considered as only syntatical referenced before but now
				-- found not only syntactical referenced.
			l_cursor := a_non_syntactical_class_list.cursor
			from
				a_non_syntactical_class_list.start
			until
				a_non_syntactical_class_list.after
			loop
				l_class_c := a_non_syntactical_class_list.item
				l_class_id := l_class_c.class_id
				if l_only_syntactical_class_set.has (l_class_id) then
					l_only_syntactical_class_set.remove (l_class_id)
				end
				l_referenced_class_set.force (l_class_c)
				a_non_syntactical_class_list.forth
			end
			if l_invocation_referenced then
				Result.merge (l_referenced_class_set)
			end
			a_non_syntactical_class_list.go_to (l_cursor)

				-- Mark classes who are considered as only syntatical referenced now.
				-- May be unmarked later.
			if is_syntactical_class_enabled and then a_syntactical_class_list /= Void then
				l_cursor := a_syntactical_class_list.cursor
				from
					a_syntactical_class_list.start
				until
					a_syntactical_class_list.after
				loop
					l_class_c := a_syntactical_class_list.item
					l_class_id := l_class_c.class_id
					if not l_referenced_class_set.has (l_class_c) then
						if not l_candidate_classes.has (l_class_id) then
							l_only_syntactical_class_set.force (l_class_id)
						end
						Result.force (l_class_c)
					end
					a_syntactical_class_list.forth
				end
				a_syntactical_class_list.go_to (l_cursor)
			end
		ensure
			result_attached: Result /= Void
		end

	find_referenced_classes (a_class_c: CLASS_C)
			-- Find all referenced classes (from `referenced_classes' or `syntactical_referenced_classes') of
			-- `a_class_c' and put them in `candidate_class_list'.
		local
			l_list: LIST [CLASS_C]
			l_syn_list: LIST [CLASS_C]
			l_candidate_class_list: like candidate_class_list
			l_source_id: INTEGER
			l_class_id: INTEGER
			l_processed_classes: like processed_classes
			l_class_set: like mark_only_syntactical_classes
			l_class_c: CLASS_C
			l_indirect: BOOLEAN
		do
			l_source_id := a_class_c.class_id
			l_processed_classes := processed_classes
			l_candidate_class_list := candidate_class_list
				-- We only process unprocessed class to avod reference cycle.
			if not l_processed_classes.has (l_source_id) then
				l_processed_classes.force (l_source_id)
				l_list := referenced_classes (a_class_c)
				if is_syntactical_class_enabled then
					l_syn_list := syntactical_referenced_classes (a_class_c)
				end
				l_class_set := mark_only_syntactical_classes (l_syn_list, l_list)
				l_indirect := is_indirect_class_enabled
				from
					l_class_set.start
				until
					l_class_set.after
				loop
					l_class_c := l_class_set.item_for_iteration
					l_class_id := l_class_c.class_id
					if l_class_id /= l_source_id then
						l_candidate_class_list.put (l_class_c, l_class_id)
					end
					if l_indirect then
						find_referenced_classes (l_class_c)
					end
					l_class_set.forth
				end
			end
		end

	find_indirect_referenced_classes (a_class_c: CLASS_C)
			-- Find indirect referenced (supplier/client) of `a_class_c' and put them in `candidate_class_list'
		local
			l_invocation: BOOLEAN
			l_syntactical: BOOLEAN
			l_class_set: SEARCH_TABLE [CLASS_C]
		do
			l_invocation := is_invocation_referenced_class_enabled
			l_syntactical := is_syntactical_class_enabled
			if (not l_invocation) and then (not l_syntactical) then
			else
				if l_invocation and then not l_syntactical then
						-- Only invocation referenced classes
					l_class_set := list_to_set (referenced_classes (a_class_c))
				elseif l_invocation and then l_syntactical then
						-- Both invocation referenced and syntactically referenced classes
					l_class_set :=unioned_set (
												list_to_set (referenced_classes (a_class_c)),
												list_to_set (syntactical_referenced_classes (a_class_c))
								  )
				elseif not l_invocation and then l_syntactical then
						-- Only syntactically referenced classes
					l_class_set := excepted_set (
										list_to_set (syntactical_referenced_classes (a_class_c)),
										list_to_set (referenced_classes (a_class_c))
								   )
				end
				from
					l_class_set.start
				until
					l_class_set.after
				loop
					find_referenced_classes (l_class_set.item_for_iteration)
					l_class_set.forth
				end
			end
		end

	finder_agent: PROCEDURE [ANY, TUPLE [CLASS_C]]
			-- Finder used to find result for current criterion
		do
			if is_indirect_class_enabled then
				Result := agent find_indirect_referenced_classes (?)
			else
				Result := agent find_referenced_classes (?)
			end
		end

feature {NONE} -- Implementation

	excepted_set (a_list, b_list: SEARCH_TABLE [CLASS_C]): SEARCH_TABLE [CLASS_C]
			-- Return `a_lsit' - `b_list'.
		require
			a_list_attached: a_list /= Void
			b_list_attached: b_list /= Void
		local
			l_class: CLASS_C
		do
			create Result.make (a_list.count)
			from
				a_list.start
			until
				a_list.after
			loop
				l_class := a_list.item_for_iteration
				if not b_list.has (l_class) then
					Result.put (l_class)
				end
				a_list.forth
			end
		ensure
			result_attached: Result /= Void
		end

	unioned_set (a_list, b_list: SEARCH_TABLE [CLASS_C]): SEARCH_TABLE [CLASS_C]
			-- Return `a_list' + `b_list'.
		require
			a_list_attached: a_list /= Void
			b_list_attached: b_list /= Void
		local
			l_class: CLASS_C
		do
			create Result.make (a_list.count)
			from
				a_list.start
			until
				a_list.after
			loop
				l_class := a_list.item_for_iteration
				if b_list.has (l_class) then
					Result.put (l_class)
				end
				a_list.forth
			end
		ensure
			result_attached: Result /= Void
		end

	list_to_set (a_list: LIST [CLASS_C]): SEARCH_TABLE [CLASS_C]
			-- Set representation of `a_list'
		do
			if a_list /= Void then
				create Result.make (a_list.count)
				a_list.do_all (agent Result.force)
			else
				create Result.make (0)
			end
		ensure
			result_attached: Result /= Void
		end

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
