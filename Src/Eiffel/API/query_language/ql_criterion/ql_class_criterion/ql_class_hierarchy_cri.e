indexing
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
			has_intrinsic_domain
		end

feature{NONE} -- Initialization

	make (a_criterion_domain: like criterion_domain; a_type: like relation_type) is
			-- Initialize `criteiron_domain' with `a_criterion_domain'.
			-- If `only_indirect' is True, we only find out indirect ones.
		require
			a_criterion_domain_attached: a_criterion_domain /= Void
			a_type_attached: a_type /= Void
			a_type_valid: is_relation_type_valid (a_type)
		do
			relation_type := a_type
			old_make (a_criterion_domain)
		ensure
			relation_type_set: relation_type = a_type
			criterion_domain_set: criterion_domain = a_criterion_domain
		end

feature -- Evaluate

	is_satisfied_by (a_item: QL_CLASS): BOOLEAN is
			-- Evaluate `a_item'.
		do
			check
				a_item.is_compiled
			end
				-- Make sure we refresh delayed `criterion_domain' every time.
			if criterion_domain.is_delayed then
				initialize_delayed_domain
			end
			Result := is_satisfied_by_internal (a_item)
		end

feature -- Access

	relation_type: QL_CLASS_RELATION
			-- Type of class relation

feature -- Status report

	is_relation_type_valid (a_type: like relation_type): BOOLEAN is
			-- Is `a_type' a valid type according to current criterion?
		require
			a_type_attached: a_type /= Void
		deferred
		end

feature{NONE} -- Implementation

	find_result is
			-- Find proper classes according to `criterion_domain'
		local
			l_class_tbl: HASH_TABLE [QL_CLASS, INTEGER]
			l_finder: PROCEDURE [ANY, TUPLE [CLASS_C]]
		do
			l_class_tbl := compiled_classes_from_domain (criterion_domain)
			l_finder := finder_agent_table.item (relation_type)
			check l_finder /= Void end
			from
				l_class_tbl.start
			until
				l_class_tbl.after
			loop
				l_finder.call ([l_class_tbl.item_for_iteration.class_c])
				l_class_tbl.forth
			end
		end

	reset is
			-- Reset internal structure
		do
			if candidate_class_list = Void then
				create candidate_class_list.make (100)
			else
				candidate_class_list.wipe_out
			end
		ensure then
			candidate_class_list_attached: candidate_class_list /= Void
			candidate_class_list_is_empty: candidate_class_list.is_empty
		end

	compiled_classes_from_domain (a_domain: QL_DOMAIN): HASH_TABLE [QL_CLASS, INTEGER] is
			-- Table of compiled class from `a_domain'
			-- Key is `class_id' from {CLASS_C}, value is {QL_CLASS} object representing that class
		require
			a_domain_attached: a_domain /= Void
		local
			l_generator: QL_CLASS_DOMAIN_GENERATOR
			l_criterion: QL_CLASS_IS_COMPILED_CRI
			l_domain: QL_CLASS_DOMAIN
			l_class: QL_CLASS
		do
			create l_generator
			create l_criterion
			l_generator.enable_fill_domain
			l_generator.set_criterion (l_criterion)
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

	is_satisfied_by_internal (a_item: QL_CLASS): BOOLEAN is
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

feature{NONE} -- Implemenation/Data

	candidate_class_list: HASH_TABLE [CLASS_C, INTEGER]
			-- Table of ancestor classes
			-- Key is `class_id' of a descendant class, value is CLASS_C object of that class

	compiled_classes_in_source: HASH_TABLE [QL_CLASS, INTEGER] is
			-- Compiled classes in `source_domain'
		require
			source_domain_attached: source_domain /= Void
		do
			if internal_compiled_classes_in_source = Void then
				internal_compiled_classes_in_source := compiled_classes_from_domain (source_domain)
			end
			Result := internal_compiled_classes_in_source
		ensure
			Result_attached: Result /= Void
		end

	internal_compiled_classes_in_source: like compiled_classes_in_source
			-- Implementation of `compiled_classes_in_source'

	finder_agent_table: HASH_TABLE [PROCEDURE [ANY, TUPLE [CLASS_C]], QL_CLASS_RELATION] is
			-- Table for finders of certain kind of class supplier (supplier, indirect supplier) relation.
			-- Key is class ancestor relation, value is the finder agent associated to the relation.
		deferred
		ensure
			result_attached: Result /= Void
		end

invariant
	relation_type_attached: relation_type /= Void

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
