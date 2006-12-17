indexing
	description: "Object that represents reference relations (supplier/client) between classes"
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

	make (a_criterion_domain: like criterion_domain; a_syntactical: BOOLEAN; a_indirect: BOOLEAN) is
			-- Initialize `criterion_domain' with `a_criterion_domain', `is_syntactical_class_enabled' with `a_syntactical' and
			-- `is_indirect_class_enabled' with `a_indirect'.
		require
			a_criterion_domain_attached: a_criterion_domain /= Void
		do
			old_make (a_criterion_domain)
			is_syntactical_class_enabled := a_syntactical
			is_indirect_class_enabled := a_indirect
		ensure
			criterion_domain_set: criterion_domain = a_criterion_domain
			is_syntactical_class_enabled_set: is_syntactical_class_enabled = a_syntactical
			is_indirect_class_enabled_set: is_indirect_class_enabled = a_indirect
		end

feature{QL_DOMAIN} -- Intrinsic domain

	intrinsic_domain: QL_CLASS_DOMAIN is
			-- Intrinsic_domain which can be inferred from current criterion			
		local
			l_list: like candidate_class_list
			l_class: QL_CLASS
			l_syntactical_classes: like only_syntactical_class_set
		do
			if not is_criterion_domain_evaluated then
				initialize_domain
			end
			source_domain.clear_cache
			create Result.make
			l_list := candidate_class_list
			l_syntactical_classes := only_syntactical_class_set
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
				l_list.forth
			end
		end

feature -- Status report

	is_syntactical_class_enabled: BOOLEAN
			-- Should syntactical classes be retrieved?
			-- If False, only classes whose features are invoked explicitly are retrieved.

	is_indirect_class_enabled: BOOLEAN
			-- Should indirect referenced be retrieved.
			-- If False, only adjacently referenced classes are retrieved.

feature -- Access

	only_syntactical_class_set: DS_HASH_SET [INTEGER]
			-- Set of class id of classes which appear only as syntactical class (no feature in those class are invoked explicitly).

	reference_table: HASH_TABLE [DS_HASH_SET [INTEGER], INTEGER]
			-- Table of class references.
			-- Key is class id of a class who references classes whose class id are specified in value.
			-- For example, if we are looking at supplier relationship:
			-- if class A(id=1) depends on class B(id=2), C(id=3), than in this table,
			-- there is a pair (value={2, 3}, key= 1).			

	referenced_classes (a_class_c: CLASS_C): LIST [CLASS_C] is
			-- A list of classes referenced by `a_class_c'.
			-- In supplier criterion, it's suppliers of `a_class_c'.
			-- In client criterion, it's clients of `a_class_c'.
		require
			a_class_c_attached: a_class_c /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end

	syntactical_referenced_classes (a_class_c: CLASS_C): LIST [CLASS_C] is
			-- A list of syntactically referened by `a_class_c'.
			-- In supplier criterion, it's syntactical suppliers of `a_class_c'.
			-- In client criterion, it's ssyntactical clients of `a_class_c'.
		require
			a_class_c_attached: a_class_c /= Void
		deferred
		end

feature{NONE} -- Implementation

	reset is
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

	mark_only_syntactical_classes (a_syntactical_class_list: LIST [CLASS_C]; a_non_syntactical_class_list: LIST [CLASS_C]): DS_HASH_SET [CLASS_C] is
			-- 	Mark only syntactically referenced classes in `only_syntactical_class_set' and
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
		do
			create Result.make (a_non_syntactical_class_list.count)
			Result.set_equality_tester (create {AGENT_BASED_EQUALITY_TESTER [CLASS_C]}.make (agent (a_class, b_class: CLASS_C): BOOLEAN do Result := a_class.class_id = b_class.class_id end))
			l_only_syntactical_class_set := only_syntactical_class_set
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
				Result.force (l_class_c)
				a_non_syntactical_class_list.forth
			end
			a_non_syntactical_class_list.go_to (l_cursor)

				-- Mark classes who are considered as only syntatical referenced now.
				-- May be unmarked later.
			if a_syntactical_class_list /= Void then
				l_cursor := a_syntactical_class_list.cursor
				from
					a_syntactical_class_list.start
				until
					a_syntactical_class_list.after
				loop
					l_class_c := a_syntactical_class_list.item
					l_class_id := l_class_c.class_id
					if not Result.has (l_class_c) then
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

	find_referenced_classes (a_class_c: CLASS_C; a_recursive: BOOLEAN) is
			-- Find all referenced classes (from `referenced_classes' or `syntactical_referenced_classes') of
			-- `a_class_c' and put them in `candidate_class_list'.
			-- `a_recursive' indicates if recursive referenced classes should be retrieved also.
		local
			l_list: LIST [CLASS_C]
			l_syn_list: LIST [CLASS_C]
			l_candidate_class_list: like candidate_class_list
			l_source_id: INTEGER
			l_class_id: INTEGER
			l_processed_classes: like processed_classes
			l_class_set: like mark_only_syntactical_classes
			l_hash_set_cursor: DS_HASH_SET_CURSOR [CLASS_C]
			l_class_c: CLASS_C
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
				l_hash_set_cursor := l_class_set.new_cursor
				from
					l_hash_set_cursor.start
				until
					l_hash_set_cursor.after
				loop
					l_class_c := l_hash_set_cursor.item
					l_class_id := l_class_c.class_id
					if l_class_id /= l_source_id then
						l_candidate_class_list.put (l_class_c, l_class_id)
					end
					if a_recursive then
						find_referenced_classes (l_class_c, a_recursive)
					end
					l_hash_set_cursor.forth
				end
			end
		end

	find_indirect_referenced_classes (a_class_c: CLASS_C) is
			-- Find indirect referenced (supplier/client) of `a_class_c' and put them in `candidate_class_list'
		local
			l_list: LIST [CLASS_C]
			l_cursor: CURSOR
		do
			if is_syntactical_class_enabled then
				l_list := syntactical_referenced_classes (a_class_c)
			end
			if l_list = Void then
				l_list := referenced_classes (a_class_c)
			end
			l_cursor := l_list.cursor
			l_list.do_all (agent find_referenced_classes (?, is_indirect_class_enabled))
			l_list.go_to (l_cursor)
		end

	finder_agent: PROCEDURE [ANY, TUPLE [CLASS_C]] is
			-- Finder used to find result for current criterion
		do
			if is_indirect_class_enabled then
				Result := agent find_indirect_referenced_classes (?)
			else
				Result := agent find_referenced_classes (?, is_indirect_class_enabled)
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
