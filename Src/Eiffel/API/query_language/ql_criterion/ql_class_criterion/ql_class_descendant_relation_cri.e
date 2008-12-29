note
	description: "[
					Object that represents a criterion to decide whether a class is a descendant of a class
					Supported descendant relation includes:
						descendant
						proper descendant
						heir
						indirect heir

					This criterion will use `data' attribute in every QL_CLASS candidate object.
					IF a QL_CLASS candidate is satisfied by this criterion. it's `data' attribute will
					be set with a list of its heirs (of type LIST [QL_CLASS]).
					This is useful to build tree structure.

				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_CLASS_DESCENDANT_RELATION_CRI

inherit
	QL_CLASS_INHERITANCE_CRI
		rename
			inheritance_relation as descendant_relation,
			is_inheritance_relation_valid as is_descendant_relation_valid
		redefine
			intrinsic_domain,
			reset,
			is_satisfied_by_internal
		end

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

	descendant_type: INTEGER = 1
	proper_descendant_type: INTEGER = 2
	heir_type: INTEGER = 3
	indirect_heir_type: INTEGER = 4
			-- Different types of descendant relationship
			-- If we have the following inheritance tree:
			--				A
			--			  /	  \
			--           B     C
			--			  \   /
			--				D
			-- Then:
			--  1. A, B, C, D are ancestors of A
			--  2. B, C, D are proper descendants of A
			--  3. B, C are heirs of A
			--  4. D are indirect heir of A

feature -- Status report

	is_descendant_relation_valid (a_relation: INTEGER): BOOLEAN
			-- Is `a_relation' a valid descendant relation?			
		do
			Result := a_relation = descendant_type or
					  a_relation = proper_descendant_type or
					  a_relation = heir_type or
					  a_relation = indirect_heir_type
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

	find_descendant_classes (a_class_c: CLASS_C)
			-- Find descendant classes of `a_class_c' and put them in `candidate_class_list' and `candidate_class_table'.
		require
			a_class_c_attached: a_class_c /= Void
		do
			find_classes (a_class_c, True, True)
		end

	find_proper_descendant_classes (a_class_c: CLASS_C)
			-- Find descendant classes of `a_class_c' and put them in `candidate_class_list' and `candidate_class_table'.
		require
			a_class_c_attached: a_class_c /= Void
		do
			find_classes (a_class_c, False, True)
		end

	find_heir_classes (a_class_c: CLASS_C)
			-- Find heir classes of `a_class_c' and put them in `candidate_class_list' and `candidate_class_table'.
		require
			a_class_c_attached: a_class_c /= Void
		do
			find_classes (a_class_c, False, False)
		end

	find_indirect_heir_classes (a_class_c: CLASS_C)
			-- Find indirect heir classes of `a_class_c' and put them in `candidate_class_list' and `candidate_class_table'.
		require
			a_class_c_attached: a_class_c /= Void
		local
			l_descendants: ARRAYED_LIST [CLASS_C]
		do
			l_descendants := a_class_c.direct_descendants
			if not l_descendants.is_empty then
				from
					l_descendants.start
				until
					l_descendants.after
				loop
					find_classes (l_descendants.item, False, True)
					l_descendants.forth
				end
			end
		end

	find_classes (a_class_c: CLASS_C; a_including_self: BOOLEAN; a_recursive: BOOLEAN)
			-- Find all descendants of `a_class_c' and put them in `candidate_class_list' and `candidate_class_table'.
			-- If `a_including_self' is True, `a_class_c' will be in resultset.)
			-- If `a_recursive' is True, find recursively.			
		local
			l_descendants: ARRAYED_LIST [CLASS_C]
			l_descendant_class: CLASS_C
			l_list: HASH_TABLE [CLASS_C, INTEGER]
			l_class_id: INTEGER
			l_class_id2: INTEGER
			l_candidate_class_list: like candidate_class_list
			l_candidate_class_table: like candidate_class_table
		do
			if a_including_self then
				create l_descendants.make (1)
				l_descendants.extend (a_class_c)
			else
				l_descendants := a_class_c.direct_descendants
			end
			if not l_descendants.is_empty then
				l_candidate_class_list := candidate_class_list
				l_candidate_class_table := candidate_class_table
				l_class_id2 := a_class_c.class_id
				from
					l_descendants.start
				until
					l_descendants.after
				loop
					l_descendant_class := l_descendants.item
					l_class_id := l_descendant_class.class_id
					l_candidate_class_list.put (l_descendant_class, l_class_id)
					l_list := l_candidate_class_table.item (l_class_id2)
					if l_list = Void then
						create {HASH_TABLE [CLASS_C, INTEGER]}l_list.make (2)
						l_candidate_class_table.put (l_list, l_class_id2)
					end
					if not a_including_self and then not l_list.has (l_class_id) then
						l_list.put (l_descendant_class, l_class_id)
					end
					if a_recursive then
						find_classes (l_descendant_class, False, a_recursive)
					end
					l_descendants.forth
				end
			end
		end

feature{NONE} -- Implementation

	finder_agent: PROCEDURE [ANY, TUPLE [CLASS_C]]
			-- Finder used to find result for current criterion
		do
			inspect
				descendant_relation
			when descendant_type then
				Result := agent find_descendant_classes
			when proper_descendant_type then
				Result := agent find_proper_descendant_classes
			when heir_type then
				Result := agent find_heir_classes
			when indirect_heir_type then
				Result := agent find_indirect_heir_classes
			else
				check False end
			end
		end

	candidate_class_table: HASH_TABLE [HASH_TABLE [CLASS_C, INTEGER], INTEGER]
			-- Table of descendant classes
			-- Key is `class_id' of a descendant class, value is a list of its descendants.

	related_classes (a_class_id: INTEGER): LIST [QL_CLASS]
			-- List of related classes with class whose `class_id' is `a_class_id'
		local
			l_list: HASH_TABLE [CLASS_C, INTEGER]
		do
			l_list := candidate_class_table.item (a_class_id)
			if l_list /= Void and then not l_list.is_empty then
				create {ARRAYED_LIST [QL_CLASS]}Result.make (l_list.count)
				from
					l_list.start
				until
					l_list.after
				loop
					Result.extend (query_class_item (l_list.item_for_iteration.lace_class.config_class))
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
