note
	description: "[
					Criterion to test if a given class domain contain ancestor classes of a class.
					Supported ancestor relation includes:
						ancestor
						proper ancestor
						parent
						indirect parent
						
					This criterion will use `data' attribute in every QL_CLASS candidate object.
					IF a QL_CLASS candidate is satisfied by this criterion. it's `data' attribute will
					be set with a list of its parents (of type LIST [QL_CLASS]).
					This is useful to build tree structure.
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_CLASS_ANCESTOR_RELATION_CRI

inherit
	QL_CLASS_INHERITANCE_CRI
		rename
			inheritance_relation as ancestor_relation,
			is_inheritance_relation_valid as is_ancestor_relation_valid
		redefine
			intrinsic_domain,
			reset,
			is_satisfied_by_internal
		end

	QL_SHARED

create
	make

feature{QL_DOMAIN} -- Intrinsic domain

	intrinsic_domain: QL_CLASS_DOMAIN
			-- Intrinsic_domain which can be inferred from current criterion			
		local
			l_list: like candidate_class_list
			l_class: QL_CLASS
			l_class_c: CLASS_C
			l_generator: like used_in_domain_generator
		do
			if not is_criterion_domain_evaluated then
				initialize_domain
			end
			create Result.make
			l_list := candidate_class_list
			source_domain.clear_cache
			l_generator := used_in_domain_generator
			from
				l_list.start
			until
				l_list.after
			loop
				l_class_c := l_list.item_for_iteration
				l_class := query_class_item (l_class_c.lace_class.config_class)
				l_class.set_data (related_classes (l_class_c.class_id))
				Result.extend (l_class)
				l_generator.increase_internal_counter (l_class)
				l_list.forth
			end
		end

feature -- Access

	ancestor_type: INTEGER = 1
	proper_ancestor_type: INTEGER = 2
	parent_type: INTEGER = 3
	indirect_parent_type: INTEGER = 4
			-- Different types of ancestor relationship
			-- If we have the following inheritance tree:
			--				A
			--			  /	  \
			--           B     C
			--			  \   /
			--				D
			-- Then:
			--  1. A, B, C, D are ancestors of D
			--  2. A, B, C are proper ancestors of D
			--  3. B, C are parents of D
			--  4. A are indirect parent of D

feature -- Status report

	is_ancestor_relation_valid (a_relation: INTEGER): BOOLEAN
			-- Is `a_relation' a valid ancestor relation?			
		do
			Result := a_relation = ancestor_type or
					  a_relation = proper_ancestor_type or
					  a_relation = parent_type or
					  a_relation = indirect_parent_type
		end

feature{NONE} -- Implementation

	reset
			-- Reset internal structure
		do
			Precursor
			if candidate_class_table = Void then
				create candidate_class_table.make (100)
			else
				candidate_class_table.wipe_out
			end
		ensure then
			processed_classes_attached: processed_classes /= Void
			processed_classes_is_empty: processed_classes.is_empty
			candidate_class_table_attached: candidate_class_table /= Void
			candidate_class_table_is_empty: candidate_class_table.is_empty
		end

	find_ancestor_classes (a_class_c: CLASS_C)
			-- Find ancestor classes of `a_class_c' and put them in `candidate_class_list' and `candidate_class_table'.
		require
			a_class_c_attached: a_class_c /= Void
		do
			find_classes (a_class_c, True, True)
		end

	find_proper_ancestor_classes (a_class_c: CLASS_C)
			-- Find ancestor classes of `a_class_c' and put them in `candidate_class_list' and `candidate_class_table'.
		require
			a_class_c_attached: a_class_c /= Void
		do
			find_classes (a_class_c, False, True)
		end

	find_parent_classes (a_class_c: CLASS_C)
			-- Find parent classes of `a_class_c' and put them in `candidate_class_list' and `candidate_class_table'.
		require
			a_class_c_attached: a_class_c /= Void
		do
			find_classes (a_class_c, False, False)
		end

	find_indirect_parent_classes (a_class_c: CLASS_C)
			-- Find indirect parent classes of `a_class_c' and put them in `candidate_class_list' and `candidate_class_table'.
		require
			a_class_c_attached: a_class_c /= Void
		local
			l_parents: FIXED_LIST [CL_TYPE_A]
		do
			l_parents := a_class_c.parents
			if not l_parents.is_empty then
				from
					l_parents.start
				until
					l_parents.after
				loop
					find_classes (l_parents.item.associated_class, False, True)
					l_parents.forth
				end
			end
		end

	find_classes (a_class_c: CLASS_C; a_including_self: BOOLEAN; a_recursive: BOOLEAN)
			-- Find all ancestors of `a_class_c' and put them in `candidate_class_list' and `candidate_class_table'.
			-- If `a_including_self' is True, `a_class_c' will be in resultset.
			-- If `a_recursive' is True, find recursively.
		local
			l_list: LIST [CLASS_C]
			l_class_id: INTEGER
			l_parents: FIXED_LIST [CL_TYPE_A]
			l_parent_class: CLASS_C
			l_processed_classes: like processed_classes
			l_candidate_class_list: like candidate_class_list
			l_candidate_class_table: like candidate_class_table
			l_origin_class_id: INTEGER
		do
			if a_including_self then
				create l_parents.make (1)
				l_parents.extend (a_class_c.actual_type)
			else
				l_parents := a_class_c.parents
			end
			if not l_parents.is_empty then
				l_processed_classes := processed_classes
				l_candidate_class_list := candidate_class_list
				l_candidate_class_table := candidate_class_table
				l_origin_class_id := a_class_c.class_id
				from
					l_parents.start
				until
					l_parents.after
				loop
					l_parent_class := l_parents.item.associated_class
					l_class_id := l_parent_class.class_id
					l_candidate_class_list.put (l_parent_class, l_class_id)
					l_list := l_candidate_class_table.item (l_origin_class_id)
					if l_list = Void then
						create {ARRAYED_LIST [CLASS_C]}l_list.make (4)
						l_candidate_class_table.put (l_list, l_origin_class_id)
					end
					if not a_including_self then
						l_list.extend (l_parent_class)
					end
					if not l_processed_classes.has (l_class_id) then
						l_processed_classes.force (l_class_id)
						if a_recursive then
							find_classes (l_parent_class, False, a_recursive)
						end
					end
					l_parents.forth
				end
			end
		end

feature{NONE} -- Implementation

	finder_agent: PROCEDURE [ANY, TUPLE [CLASS_C]]
			-- Finder used to find result for current criterion
		do
			inspect
				ancestor_relation
			when ancestor_type then
				Result := agent find_ancestor_classes
			when proper_ancestor_type then
				Result := agent find_proper_ancestor_classes
			when parent_type then
				Result := agent find_parent_classes
			when indirect_parent_type then
				Result := agent find_indirect_parent_classes
			else
				check False end
			end
		end

	candidate_class_table: HASH_TABLE [LIST [CLASS_C], INTEGER]
			-- Table of candidate classes with extra information
			-- Key is `class_id' of a candidate class, value is a list of its related classes,
			-- they can be ancestors, descendants ...

	related_classes (a_class_id: INTEGER): LIST [QL_CLASS]
			-- List of related classes with class whose `class_id' is `a_class_id'
		local
			l_list: LIST [CLASS_C]
			l_class: QL_CLASS
			l_source_domain: like source_domain
		do
			l_list := candidate_class_table.item (a_class_id)
			if l_list /= Void and then not l_list.is_empty then
				create {ARRAYED_LIST [QL_CLASS]}Result.make (l_list.count)
				l_source_domain := source_domain
				from
					l_list.start
				until
					l_list.after
				loop
					l_class := query_class_item (l_list.item.lace_class.config_class)
					Result.extend (l_class)
					l_list.forth
				end
			end
		end

	is_satisfied_by_internal (a_item: QL_CLASS): BOOLEAN
			-- Evaluate `a_item'.
		do
			Result := candidate_class_list.has (a_item.class_c.class_id)
			if Result then
				a_item.set_data (related_classes (a_item.class_c.class_id))
			end
		end

note
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
