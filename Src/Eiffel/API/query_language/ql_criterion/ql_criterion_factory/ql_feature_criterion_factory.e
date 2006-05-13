indexing
	description: "Factory to produce feature criteria"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_FEATURE_CRITERION_FACTORY

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
			create criterion_table.make (40)
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

			criterion_table.put (agent is_ancestor_criterion, query_language_names.ql_cri_is_ancestor)
			criterion_table.put (agent is_deferred_criterion, query_language_names.ql_cri_is_deferred)
			criterion_table.put (agent is_descendant_criterion, query_language_names.ql_cri_is_descendant)
			criterion_table.put (agent is_external_criterion, query_language_names.ql_cri_is_external)
			criterion_table.put (agent is_frozen_criterion, query_language_names.ql_cri_is_frozen)
			criterion_table.put (agent is_obsolete_criterion, query_language_names.ql_cri_is_obsolete)

			criterion_table.put (agent has_argument_criterion, query_language_names.ql_cri_has_argument)
			criterion_table.put (agent has_assertion_criterion, query_language_names.ql_cri_has_assertion)
			criterion_table.put (agent has_assigner_criterion, query_language_names.ql_cri_has_assigner)
			criterion_table.put (agent has_comment_criterion, query_language_names.ql_cri_has_comment)
			criterion_table.put (agent has_indexing_criterion, query_language_names.ql_cri_has_indexing)
			criterion_table.put (agent has_local_criterion, query_language_names.ql_cri_has_local)
			criterion_table.put (agent has_postcondition_criterion, query_language_names.ql_cri_has_postcondition)
			criterion_table.put (agent has_precondition_criterion, query_language_names.ql_cri_has_precondition)
			criterion_table.put (agent has_rescue_criterion, query_language_names.ql_cri_has_rescue)
			criterion_table.put (agent is_attribute_criterion, query_language_names.ql_cri_is_attribute)
			criterion_table.put (agent is_constant_criterion, query_language_names.ql_cri_is_constant)
			criterion_table.put (agent is_function_criterion, query_language_names.ql_cri_is_function)
			criterion_table.put (agent is_immediate_criterion, query_language_names.ql_cri_is_immediate)
			criterion_table.put (agent is_infix_criterion, query_language_names.ql_cri_is_infix)
			criterion_table.put (agent is_once_criterion, query_language_names.ql_cri_is_once)
			criterion_table.put (agent is_origin_criterion, query_language_names.ql_cri_is_origin)
			criterion_table.put (agent is_prefix_criterion, query_language_names.ql_cri_is_prefix)
			criterion_table.put (agent is_procedure_criterion, query_language_names.ql_cri_is_procedure)
			criterion_table.put (agent is_unique_criterion, query_language_names.ql_cri_is_unique)
			criterion_table.put (agent is_implementor_criterion, query_language_names.ql_cri_is_implementor)
			criterion_table.put (agent is_feature_criterion, query_language_names.ql_cri_is_feature)
			criterion_table.put (agent is_invariant_criterion, query_language_names.ql_cri_is_invariant)
			criterion_table.put (agent is_caller_criterion, query_language_names.ql_cri_is_caller)
		end

feature -- Criterion creation

	criterion (a_name: STRING; a_argu: TUPLE): QL_FEATURE_CRITERION is
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

	creation_function: FUNCTION [ANY, TUPLE, QL_FEATURE_CRITERION]
			-- Creation function type anchor

	true_criterion (a_argu: TUPLE): QL_FEATURE_TRUE_CRI is
			-- True criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	false_criterion (a_argu: TUPLE): QL_FEATURE_FALSE_CRI is
			-- True criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	and_criterion (a_argu: TUPLE): QL_FEATURE_AND_CRITERION is
			-- Binary "and" criterion
		local
			l_left: QL_FEATURE_CRITERION
			l_right: QL_FEATURE_CRITERION
		do
			if a_argu /= Void and then a_argu.count = 2 then
				l_left ?= a_argu.item (1)
				l_right ?= a_argu.item (2)
				if l_left /= Void and then l_right /= Void then
					create Result.make (l_left, l_right)
				end
			end
		end

	or_criterion (a_argu: TUPLE): QL_FEATURE_OR_CRITERION is
			-- Binary "and" criterion
		local
			l_left: QL_FEATURE_CRITERION
			l_right: QL_FEATURE_CRITERION
		do
			if a_argu /= Void and then a_argu.count = 2 then
				l_left ?= a_argu.item (1)
				l_right ?= a_argu.item (2)
				if l_left /= Void and then l_right /= Void then
					create Result.make (l_left, l_right)
				end
			end
		end

	not_criterion (a_argu: TUPLE): QL_FEATURE_NOT_CRITERION is
			-- Binary "and" criterion
		local
			l_cri: QL_FEATURE_CRITERION
		do
			if a_argu /= Void and then a_argu.count = 1 then
				l_cri ?= a_argu.item (1)
				if l_cri /= Void then
					create Result.make (l_cri)
				end
			end
		end

	is_compiled_criterion (a_argu: TUPLE): QL_FEATURE_IS_COMPILED_CRI is
			-- Is_compiled criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	name_criterion (a_argu: TUPLE): QL_FEATURE_NAME_IS_CRI is
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

	eq_criterion (a_argu: TUPLE): QL_FEATURE_EQ_CRI is
			-- Equality criterion
		local
			l_left: QL_FEATURE_CRITERION
			l_right: QL_FEATURE_CRITERION
		do
			if a_argu /= Void and then a_argu.count = 2 then
				l_left ?= a_argu.item (1)
				l_right ?= a_argu.item (2)
				if l_left /= Void and then l_right /= Void then
					create Result.make (l_left, l_right)
				end
			end
		end

	ne_criterion (a_argu: TUPLE): QL_FEATURE_NE_CRI is
			-- Equality criterion
		local
			l_left: QL_FEATURE_CRITERION
			l_right: QL_FEATURE_CRITERION
		do
			if a_argu /= Void and then a_argu.count = 2 then
				l_left ?= a_argu.item (1)
				l_right ?= a_argu.item (2)
				if l_left /= Void and then l_right /= Void then
					create Result.make (l_left, l_right)
				end
			end
		end

--	number_criterion (a_argu: TUPLE): QL_FEATURE_NUM_CRI is
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

	is_deferred_criterion (a_argu: TUPLE): QL_FEATURE_IS_DEFERRED_CRI is
			-- Has_invariant criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	is_external_criterion (a_argu: TUPLE): QL_FEATURE_IS_EXTERNAL_CRI is
			-- Has_invariant criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	is_frozen_criterion (a_argu: TUPLE): QL_FEATURE_IS_FROZEN_CRI is
			-- Has_invariant criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	is_obsolete_criterion (a_argu: TUPLE): QL_FEATURE_IS_OBSOLETE_CRI is
			-- Has_invariant criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	is_ancestor_criterion (a_argu: TUPLE): QL_FEATURE_ANCESTOR_RELATION_CRI is
			-- Has_invariant criterion
		local
			l_domain: QL_DOMAIN
		do
			if a_argu /= Void and then a_argu.count = 2 then
				l_domain ?= a_argu.item (1)
				if l_domain /= Void then
					create Result.make (l_domain)
				end
			end
		end

	is_descendant_criterion (a_argu: TUPLE): QL_FEATURE_DESCENDANT_RELATION_CRI is
			-- Has_invariant criterion
		local
			l_domain: QL_DOMAIN
		do
			if a_argu /= Void and then a_argu.count = 2 then
				l_domain ?= a_argu.item (1)
				if l_domain /= Void then
					create Result.make (l_domain)
				end
			end
		end

	has_argument_criterion (a_argu: TUPLE): QL_FEATURE_HAS_ARGUMENTS_CRI is
			-- Has_argument criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	has_assertion_criterion (a_argu: TUPLE): QL_FEATURE_HAS_ASSERTION_CRI is
			-- Has_argument criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	has_assigner_criterion (a_argu: TUPLE): QL_FEATURE_HAS_ASSIGNER_CRI is
			-- Has_argument criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	has_comment_criterion (a_argu: TUPLE): QL_FEATURE_HAS_COMMENTS_CRI is
			-- Has_argument criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	has_indexing_criterion (a_argu: TUPLE): QL_FEATURE_HAS_INDEXING_CRI is
			-- Has_argument criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	has_local_criterion (a_argu: TUPLE): QL_FEATURE_HAS_LOCALS_CRI is
			-- Has_argument criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	has_postcondition_criterion (a_argu: TUPLE): QL_FEATURE_HAS_POSTCONDITION_CRI is
			-- Has_argument criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	has_precondition_criterion (a_argu: TUPLE): QL_FEATURE_HAS_PRECONDITION_CRI is
			-- Has_argument criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	has_rescue_criterion (a_argu: TUPLE): QL_FEATURE_HAS_RESCUE_CRI is
			-- Has_argument criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	is_constant_criterion (a_argu: TUPLE): QL_FEATURE_IS_CONSTANT_CRI is
			-- Has_argument criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	is_function_criterion (a_argu: TUPLE): QL_FEATURE_IS_FUNCTION_CRI is
			-- Has_argument criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	is_immediate_criterion (a_argu: TUPLE): QL_FEATURE_IS_IMMEDIATE_CRI is
			-- Has_argument criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	is_infix_criterion (a_argu: TUPLE): QL_FEATURE_IS_INFIX_CRI is
			-- Has_argument criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	is_prefix_criterion (a_argu: TUPLE): QL_FEATURE_IS_PREFIX_CRI is
			-- Has_argument criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	is_once_criterion (a_argu: TUPLE): QL_FEATURE_IS_ONCE_CRI is
			-- Has_argument criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	is_attribute_criterion (a_argu: TUPLE): QL_FEATURE_IS_ATTRIBUTE_CRI is
			-- Has_argument criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	is_origin_criterion (a_argu: TUPLE): QL_FEATURE_IS_ORIGIN_CRI is
			-- Has_argument criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	is_procedure_criterion (a_argu: TUPLE): QL_FEATURE_IS_PROCEDURE_CRI is
			-- Has_argument criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	is_feature_criterion (a_argu: TUPLE): QL_FEATURE_IS_FEATURE_CRI is
			-- Has_argument criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	is_invariant_criterion (a_argu: TUPLE): QL_FEATURE_IS_INVARIANT_CRI is
			-- Has_argument criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	is_unique_criterion (a_argu: TUPLE): QL_FEATURE_IS_UNIQUE_CRI is
			-- Has_argument criterion
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	is_caller_criterion (a_argu: TUPLE): QL_FEATURE_CALLERS_OF_CRI is
			-- Has_argument criterion
		local
			l_domain: QL_DOMAIN
			l_caller_type: QL_FEATURE_CALLER_TYPE
		do
			if a_argu /= Void and then a_argu.count = 2 then
				l_domain ?= a_argu.item (1)
				l_caller_type ?= a_argu.item (2)
				if l_domain /= Void and then l_caller_type /= Void then
					create Result.make (l_domain, l_caller_type)
				end
			end
		end

	is_implementor_criterion (a_argu: TUPLE): QL_FEATURE_IMPLEMENTORS_OF_CRI is
			-- Has_argument criterion
		local
			l_domain: QL_DOMAIN
		do
			if a_argu /= Void and then a_argu.count = 2 then
				l_domain ?= a_argu.item (1)
				if l_domain /= Void then
					create Result.make (l_domain)
				end
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
