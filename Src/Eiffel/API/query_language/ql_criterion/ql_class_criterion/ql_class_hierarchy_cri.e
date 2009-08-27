note
	description: "Object that represents a criterion to evaluate class hierarchy/relationship"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_CLASS_HIERARCHY_CRI

inherit
	QL_INTRINSIC_DOMAIN_CRITERION
		rename
			make as old_make
		redefine
			is_satisfied_by
		end

	QL_CLASS_CRITERION
		undefine
			has_inclusive_intrinsic_domain,
			process
		end

	QL_SHARED

	QL_UTILITY

feature -- Evaluate

	is_satisfied_by (a_item: QL_CLASS): BOOLEAN
			-- Evaluate `a_item'.
		do
			check
				a_item.is_compiled
			end
			if not is_criterion_domain_evaluated then
				initialize_domain
			end
			if
				has_intrinsic_domain and then
				used_in_domain_generator.is_temp_domain_used and then
				not is_intrinsic_domain_cached_in_domain_generator
			then
				cache_intrinsic_domain
			end
			Result := is_satisfied_by_internal (a_item)
		end

feature{NONE} -- Implementation

	find_result
			-- Find proper classes according to `criterion_domain'
		local
			l_class_tbl: HASH_TABLE [QL_CLASS, INTEGER]
			l_finder: PROCEDURE [ANY, TUPLE [CLASS_C]]
		do
			l_class_tbl := compiled_classes_from_domain (criterion_domain)
			l_finder := finder_agent
			check l_finder /= Void end
			from
				l_class_tbl.start
			until
				l_class_tbl.after
			loop
				l_finder.call ([l_class_tbl.item_for_iteration.class_c])
				l_class_tbl.forth
			end
			is_intrinsic_domain_cached_in_domain_generator := False
		end

	reset
			-- Reset internal structure
		do
			if candidate_class_list = Void then
				create candidate_class_list.make (100)
			else
				candidate_class_list.wipe_out
			end
			if processed_classes = Void then
				create processed_classes.make (100)
			else
				processed_classes.wipe_out
			end
		ensure then
			candidate_class_list_attached: candidate_class_list /= Void
			candidate_class_list_is_empty: candidate_class_list.is_empty
			processed_classes_attached: processed_classes /= Void
			processed_classes_is_empty: processed_classes.is_empty
		end

	compiled_classes_from_domain (a_domain: QL_DOMAIN): HASH_TABLE [QL_CLASS, INTEGER]
			-- Table of compiled class from `a_domain'
			-- Key is `class_id' from {CLASS_C}, value is {QL_CLASS} object representing that class
		require
			a_domain_attached: a_domain /= Void
		local
			l_generator: QL_CLASS_DOMAIN_GENERATOR
			l_domain: QL_CLASS_DOMAIN
			l_class: QL_CLASS
		do
			create l_generator.make (
				class_criterion_factory.simple_criterion_with_index (
					class_criterion_factory.c_is_compiled), True)
			l_domain ?= a_domain.new_domain (l_generator)
			check
				l_domain /= Void
			end
			if not l_domain.is_empty then
				create Result.make (l_domain.count)
				from
					l_domain.start
				until
					l_domain.after
				loop
					l_class := l_domain.item
					Result.put (l_class, l_class.class_c.class_id)
					l_domain.forth
				end
			else
				create Result.make (0)
			end
		ensure
			result_attached: Result /= Void
		end

	is_satisfied_by_internal (a_item: QL_CLASS): BOOLEAN
			-- Evaluate `a_item'.
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
			source_domain_attached: source_domain /= Void
		do
			Result := candidate_class_list.has (a_item.class_c.class_id)
		ensure then
			good_result: Result implies candidate_class_list.has (a_item.class_c.class_id)
		end

	query_class_item (a_class: CONF_CLASS): QL_CLASS
			-- Query class representation of `a_class'.
			-- Take care of both visible and invisible situation.
		require
			a_class_attached: a_class /= Void
		do
			Result := source_domain.class_item_from_current_domain (a_class)
			if Result = Void then
				Result := query_class_item_from_conf_class (a_class)
				Result.set_visible (False)
			end
		ensure
			result_attached: Result /= Void
		end

feature{NONE} -- Implemenation/Data

	candidate_class_list: HASH_TABLE [CLASS_C, INTEGER]
			-- Table of ancestor classes
			-- Key is `class_id' of a descendant class, value is CLASS_C object of that class

	processed_classes: SEARCH_TABLE [INTEGER];
			-- Flag structure to indicate whether or not a class has been processed
			-- Item of this set is `class_id' of a compiled class

	finder_agent: PROCEDURE [ANY, TUPLE [CLASS_C]]
			-- Finder used to find result for current criterion
		deferred
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
