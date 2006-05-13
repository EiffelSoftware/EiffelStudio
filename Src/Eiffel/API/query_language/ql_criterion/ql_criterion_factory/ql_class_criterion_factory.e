indexing
	description: "Factory to produce criteria with class scope"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_CLASS_CRITERION_FACTORY

inherit
	QL_CRITERION_FACTORY
		redefine
			criterion,
			creation_function
		end
create
	initialize

feature{NONE} -- Initialization

	initialize is
			-- Initialize.
		do
			create criterion_table.make (25)
			criterion_table.put (agent true_criterion, query_language_names.ql_cri_true)
			criterion_table.put (agent false_criterion, query_language_names.ql_cri_false)
			criterion_table.put (agent and_criterion, query_language_names.ql_cri_and)
			criterion_table.put (agent or_criterion, query_language_names.ql_cri_or)
			criterion_table.put (agent not_criterion, query_language_names.ql_cri_not)
			criterion_table.put (agent is_compiled_criterion, query_language_names.ql_cri_is_compiled)
			criterion_table.put (agent name_criterion, query_language_names.ql_cri_name)
			criterion_table.put (agent eq_criterion, query_language_names.ql_cri_eq)
			criterion_table.put (agent ne_criterion, query_language_names.ql_cri_ne)
--			criterion_table.put (agent number_criterion, query_language_names.ql_cri_num)

			criterion_table.put (agent has_invariant_criterion, query_language_names.ql_cri_has_invariant)
			criterion_table.put (agent is_ancestor_criterion, query_language_names.ql_cri_is_ancestor)
			criterion_table.put (agent is_ancestor_criterion, query_language_names.ql_cri_is_indirect_ancestor)
			criterion_table.put (agent is_client_criterion, query_language_names.ql_cri_is_client)
			criterion_table.put (agent is_client_criterion, query_language_names.ql_cri_is_indirect_client)
			criterion_table.put (agent is_deferred_criterion, query_language_names.ql_cri_is_deferred)
			criterion_table.put (agent is_descendant_criterion, query_language_names.ql_cri_is_descendant)
			criterion_table.put (agent is_descendant_criterion, query_language_names.ql_cri_is_indirect_descendant)
			criterion_table.put (agent is_expanded_criterion, query_language_names.ql_cri_is_expanded)
			criterion_table.put (agent is_external_criterion, query_language_names.ql_cri_is_external)
			criterion_table.put (agent is_frozen_criterion, query_language_names.ql_cri_is_frozen)
			criterion_table.put (agent is_generic_criterion, query_language_names.ql_cri_is_generic)
			criterion_table.put (agent is_obsolete_criterion, query_language_names.ql_cri_is_obsolete)
			criterion_table.put (agent is_precompiled_criterion, query_language_names.ql_cri_is_precompiled)
			criterion_table.put (agent is_supplier_criterion, query_language_names.ql_cri_is_supplier)
			criterion_table.put (agent is_supplier_criterion, query_language_names.ql_cri_is_indirect_supplier)
			criterion_table.put (agent has_top_indexing_criterion, query_language_names.ql_cri_has_top_indexing)
			criterion_table.put (agent has_bottom_indexing_criterion, query_language_names.ql_cri_has_bottom_indexing)
			criterion_table.put (agent has_indexing_criterion, query_language_names.ql_cri_has_indexing)
			criterion_table.put (agent is_enum_criterion, query_language_names.ql_cri_is_enum)
		end

feature -- Criterion creation

	criterion (a_name: STRING; a_argu: TUPLE): QL_CLASS_CRITERION is
			-- Criterion with `a_name' as `a_argu' as its initialization arguments
			-- Void if no criterion with `a_name' is applicable with respect to current scope
		local
			l_creation_function: like creation_function
		do
			l_creation_function := criterion_table.item (a_name.as_lower)
			if l_creation_function /= Void then
				Result := l_creation_function.item ([a_argu])
			end
		end

feature{NONE} -- Implementation

	creation_function: FUNCTION [ANY, TUPLE, QL_CLASS_CRITERION]
			-- Creation function type anchor

	true_criterion (a_argu: TUPLE): QL_CLASS_TRUE_CRI is
			-- True criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	false_criterion (a_argu: TUPLE): QL_CLASS_FALSE_CRI is
			-- True criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	and_criterion (a_argu: TUPLE): QL_CLASS_AND_CRITERION is
			-- Binary "and" criterion
		local
			l_left: QL_CLASS_CRITERION
			l_right: QL_CLASS_CRITERION
		do
			if a_argu /= Void and then a_argu.count = 2 then
				l_left ?= a_argu.item (1)
				l_right ?= a_argu.item (2)
				if l_left /= Void and then l_right /= Void then
					create Result.make (l_left, l_right)
				end
			end
		end

	or_criterion (a_argu: TUPLE): QL_CLASS_OR_CRITERION is
			-- Binary "and" criterion
		local
			l_left: QL_CLASS_CRITERION
			l_right: QL_CLASS_CRITERION
		do
			if a_argu /= Void and then a_argu.count = 2 then
				l_left ?= a_argu.item (1)
				l_right ?= a_argu.item (2)
				if l_left /= Void and then l_right /= Void then
					create Result.make (l_left, l_right)
				end
			end
		end

	not_criterion (a_argu: TUPLE): QL_CLASS_NOT_CRITERION is
			-- Binary "and" criterion
		local
			l_cri: QL_CLASS_CRITERION
		do
			if a_argu /= Void and then a_argu.count = 1 then
				l_cri ?= a_argu.item (1)
				if l_cri /= Void then
					create Result.make (l_cri)
				end
			end
		end

	is_compiled_criterion (a_argu: TUPLE): QL_CLASS_IS_COMPILED_CRI is
			-- Is_compiled criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	name_criterion (a_argu: TUPLE): QL_CLASS_NAME_IS_CRI is
			-- Name (is or like) criterion
		local
			l_name: STRING
			l_case: BOOLEAN_REF
			l_identical: BOOLEAN_REF
		do
			if a_argu /= Void and then a_argu.count = 3 then
				l_name ?= a_argu.item (1)
				l_case ?= a_argu.item (2)
				l_identical ?= a_argu.item (3)
				if l_name /= Void and then l_case /= Void and then l_identical /= Void then
					create Result.make_with_setting (l_name, l_case.item, l_identical.item)
				end
			end
		end

	eq_criterion (a_argu: TUPLE): QL_CLASS_EQ_CRI is
			-- Equality criterion
		local
			l_left: QL_CLASS_CRITERION
			l_right: QL_CLASS_CRITERION
		do
			if a_argu /= Void and then a_argu.count = 2 then
				l_left ?= a_argu.item (1)
				l_right ?= a_argu.item (2)
				if l_left /= Void and then l_right /= Void then
					create Result.make (l_left, l_right)
				end
			end
		end

	ne_criterion (a_argu: TUPLE): QL_CLASS_NE_CRI is
			-- Equality criterion
		local
			l_left: QL_CLASS_CRITERION
			l_right: QL_CLASS_CRITERION
		do
			if a_argu /= Void and then a_argu.count = 2 then
				l_left ?= a_argu.item (1)
				l_right ?= a_argu.item (2)
				if l_left /= Void and then l_right /= Void then
					create Result.make (l_left, l_right)
				end
			end
		end

--	number_criterion (a_argu: TUPLE): QL_CLASS_NUM_CRI is
--			-- Number criterion
--		local
--			l_number: QL_BOOL_NUM_BIN_INFO
--		do
--			if a_argu /= Void and then a_argu.count = 1 then
--				l_number ?= a_argu.item (1)
--				if l_number /= Void then
--					create Result.make (l_number)
--				end
--			end
--		end

	has_invariant_criterion (a_argu: TUPLE): QL_CLASS_HAS_INVARIANT_CRI is
			-- Has_invariant criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	has_top_indexing_criterion (a_argu: TUPLE): QL_CLASS_HAS_TOP_INDEXING_CRI is
			-- Has_invariant criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	has_bottom_indexing_criterion (a_argu: TUPLE): QL_CLASS_HAS_BOTTOM_INDEXING_CRI is
			-- Has_invariant criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	has_indexing_criterion (a_argu: TUPLE): QL_CLASS_HAS_INDEXING_CRI is
			-- Has_invariant criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	is_deferred_criterion (a_argu: TUPLE): QL_CLASS_IS_DEFERRED_CRI is
			-- Has_invariant criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	is_enum_criterion (a_argu: TUPLE): QL_CLASS_IS_ENUM_CRI is
			-- is_enum criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	is_expanded_criterion (a_argu: TUPLE): QL_CLASS_IS_EXPANDED_CRI is
			-- Has_invariant criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	is_external_criterion (a_argu: TUPLE): QL_CLASS_IS_EXTERNAL_CRI is
			-- Has_invariant criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	is_frozen_criterion (a_argu: TUPLE): QL_CLASS_IS_FROZEN_CRI is
			-- Has_invariant criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	is_generic_criterion (a_argu: TUPLE): QL_CLASS_IS_GENERIC_CRI is
			-- Has_invariant criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	is_obsolete_criterion (a_argu: TUPLE): QL_CLASS_IS_OBSOLETE_CRI is
			-- Has_invariant criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	is_precompiled_criterion (a_argu: TUPLE): QL_CLASS_IS_PRECOMPILED_CRI is
			-- Has_invariant criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	is_ancestor_criterion (a_argu: TUPLE): QL_CLASS_ANCESTOR_RELATION_CRI is
			-- Has_invariant criterion
		local
			l_class: QL_DOMAIN
			l_bool: BOOLEAN_REF
		do
--			if a_argu /= Void and then a_argu.count = 2 then
--				l_class ?= a_argu.item (1)
--				l_bool ?= a_argu.item (2)
--				if l_class /= Void and then l_bool /= Void then
--					create Result.make (l_class, l_bool.item)
--				end
--			end
		end

	is_descendant_criterion (a_argu: TUPLE): QL_CLASS_DESCENDANT_RELATION_CRI is
			-- Has_invariant criterion
		local
			l_domain: QL_DOMAIN
			l_bool: BOOLEAN_REF
		do
--			if a_argu /= Void and then a_argu.count = 2 then
--				l_domain ?= a_argu.item (1)
--				l_bool ?= a_argu.item (2)
--				if l_domain /= Void and then l_bool /= Void then
--					create Result.make (l_domain, l_bool)
--				end
--			end
		end

	is_client_criterion (a_argu: TUPLE): QL_CLASS_CLIENT_RELATION_CRI is
			-- Has_invariant criterion
		local
			l_domain: QL_DOMAIN
			l_bool: BOOLEAN_REF
		do
--			if a_argu /= Void and then a_argu.count = 2 then
--				l_domain ?= a_argu.item (1)
--				l_bool ?= a_argu.item (2)
--				if l_domain /= Void and then l_bool /= Void then
--					create Result.make (l_domain, l_bool)
--				end
--			end
		end

	is_supplier_criterion (a_argu: TUPLE): QL_CLASS_SUPPLIER_RELATION_CRI is
			-- Has_invariant criterion
		local
			l_domain: QL_DOMAIN
			l_bool: BOOLEAN_REF
		do
--			if a_argu /= Void and then a_argu.count = 2 then
--				l_domain ?= a_argu.item (1)
--				l_bool ?= a_argu.item (2)
--				if l_domain /= Void and then l_bool /= Void then
--					create Result.make (l_domain, l_bool.item)
--				end
--			end
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
