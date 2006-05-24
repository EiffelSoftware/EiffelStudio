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
			criterion_type
		end

	QL_SHARED_FEATURE_INVOKE_RELATION_TYPES

create
	make

feature{NONE} -- Initialization

	make is
			-- Initialize.
		do
			create criterion_table.make (50)
			criterion_table.put (agent new_false_criterion, query_language_names.ql_cri_false)
			criterion_table.put (agent new_has_arguments_criterion, query_language_names.ql_cri_has_argument)
			criterion_table.put (agent new_has_assertion_criterion, query_language_names.ql_cri_has_assertion)
			criterion_table.put (agent new_has_assigner_criterion, query_language_names.ql_cri_has_assigner)
			criterion_table.put (agent new_has_comments_criterion, query_language_names.ql_cri_has_comment)
			criterion_table.put (agent new_has_indexing_criterion, query_language_names.ql_cri_has_indexing)
			criterion_table.put (agent new_has_locals_criterion, query_language_names.ql_cri_has_local)
			criterion_table.put (agent new_has_postcondition_criterion, query_language_names.ql_cri_has_postcondition)
			criterion_table.put (agent new_has_precondition_criterion, query_language_names.ql_cri_has_precondition)
			criterion_table.put (agent new_has_rescue_criterion, query_language_names.ql_cri_has_rescue)
			criterion_table.put (agent new_is_attribute_criterion, query_language_names.ql_cri_is_attribute)
			criterion_table.put (agent new_is_compiled_criterion, query_language_names.ql_cri_is_compiled)
			criterion_table.put (agent new_is_constant_criterion, query_language_names.ql_cri_is_constant)
			criterion_table.put (agent new_is_creator_criterion, query_language_names.ql_cri_is_creator)
			criterion_table.put (agent new_is_deferred_criterion, query_language_names.ql_cri_is_deferred)
			criterion_table.put (agent new_is_exported_criterion, query_language_names.ql_cri_is_exported)
			criterion_table.put (agent new_is_external_criterion, query_language_names.ql_cri_is_external)
			criterion_table.put (agent new_is_feature_criterion, query_language_names.ql_cri_is_feature)
			criterion_table.put (agent new_is_frozen_criterion, query_language_names.ql_cri_is_frozen)
			criterion_table.put (agent new_is_function_criterion, query_language_names.ql_cri_is_function)
			criterion_table.put (agent new_is_hidden_criterion, query_language_names.ql_cri_is_hidden)
			criterion_table.put (agent new_is_immediate_criterion, query_language_names.ql_cri_is_immediate)
			criterion_table.put (agent new_is_infix_criterion, query_language_names.ql_cri_is_infix)
			criterion_table.put (agent new_is_invariant_criterion, query_language_names.ql_cri_is_invariant_feature)
			criterion_table.put (agent new_is_obsolete_criterion, query_language_names.ql_cri_is_obsolete)
			criterion_table.put (agent new_is_once_criterion, query_language_names.ql_cri_is_once)
			criterion_table.put (agent new_is_origin_criterion, query_language_names.ql_cri_is_origin)
			criterion_table.put (agent new_is_prefix_criterion, query_language_names.ql_cri_is_prefix)
			criterion_table.put (agent new_is_procedure_criterion, query_language_names.ql_cri_is_procedure)
			criterion_table.put (agent new_is_unique_criterion, query_language_names.ql_cri_is_unique)
			criterion_table.put (agent new_true_criterion, query_language_names.ql_cri_true)
			criterion_table.put (agent new_name_is_criterion, query_language_names.ql_cri_name_is)
			criterion_table.put (agent new_text_contain_criterion, query_language_names.ql_cri_text_contain)
			criterion_table.put (agent new_ancestor_is_criterion, query_language_names.ql_cri_ancestor_is)
			criterion_table.put (agent new_descendant_is_criterion, query_language_names.ql_cri_descendant_is)
			criterion_table.put (agent new_implementors_of_criterion, query_language_names.ql_cri_implementors_of)
			criterion_table.put (agent new_is_exported_to_criterion, query_language_names.ql_cri_is_exported_to)
			criterion_table.put (agent new_callers_of_criterion, query_language_names.ql_cri_callee_is)
			criterion_table.put (agent new_caller_is_criterion, query_language_names.ql_cri_caller_is)
			criterion_table.put (agent new_assigners_of_criterion, query_language_names.ql_cri_assignee_is)
			criterion_table.put (agent new_assigner_is_criterion, query_language_names.ql_cri_assigner_is)
			criterion_table.put (agent new_creators_of_criterion, query_language_names.ql_cri_createe_is)
			criterion_table.put (agent new_creator_is_criterion, query_language_names.ql_cri_creator_is)
		end

feature{NONE} -- Implementation

	criterion_type: QL_FEATURE_CRITERION
			-- Criterion anchor type

feature{NONE} -- New criterion

	new_false_criterion: QL_FEATURE_FALSE_CRI is
			-- New {QL_FEATURE_FALSE_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_has_arguments_criterion: QL_FEATURE_HAS_ARGUMENTS_CRI is
			-- New {QL_FEATURE_HAS_ARGUMENTS_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_has_assertion_criterion: QL_FEATURE_HAS_ASSERTION_CRI is
			-- New {QL_FEATURE_HAS_ASSERTION_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_has_assigner_criterion: QL_FEATURE_HAS_ASSIGNER_CRI is
			-- New {QL_FEATURE_HAS_ASSIGNER_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_has_comments_criterion: QL_FEATURE_HAS_COMMENTS_CRI is
			-- New {QL_FEATURE_HAS_COMMENTS_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_has_indexing_criterion: QL_FEATURE_HAS_INDEXING_CRI is
			-- New {QL_FEATURE_HAS_INDEXING_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_has_locals_criterion: QL_FEATURE_HAS_LOCALS_CRI is
			-- New {QL_FEATURE_HAS_LOCALS_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_has_postcondition_criterion: QL_FEATURE_HAS_POSTCONDITION_CRI is
			-- New {QL_FEATURE_HAS_POSTCONDITION_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_has_precondition_criterion: QL_FEATURE_HAS_PRECONDITION_CRI is
			-- New {QL_FEATURE_HAS_PRECONDITION_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_has_rescue_criterion: QL_FEATURE_HAS_RESCUE_CRI is
			-- New {QL_FEATURE_HAS_RESCUE_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_is_attribute_criterion: QL_FEATURE_IS_ATTRIBUTE_CRI is
			-- New {QL_FEATURE_IS_ATTRIBUTE_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_is_compiled_criterion: QL_FEATURE_IS_COMPILED_CRI is
			-- New {QL_FEATURE_IS_COMPILED_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_is_constant_criterion: QL_FEATURE_IS_CONSTANT_CRI is
			-- New {QL_FEATURE_IS_CONSTANT_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_is_creator_criterion: QL_FEATURE_IS_CREATOR_CRI is
			-- New {QL_FEATURE_IS_CREATOR_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_is_deferred_criterion: QL_FEATURE_IS_DEFERRED_CRI is
			-- New {QL_FEATURE_IS_DEFERRED_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_is_exported_criterion: QL_FEATURE_IS_EXPORTED_CRI is
			-- New {QL_FEATURE_IS_EXPORTED_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_is_external_criterion: QL_FEATURE_IS_EXTERNAL_CRI is
			-- New {QL_FEATURE_IS_EXTERNAL_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_is_feature_criterion: QL_FEATURE_IS_FEATURE_CRI is
			-- New {QL_FEATURE_IS_FEATURE_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_is_frozen_criterion: QL_FEATURE_IS_FROZEN_CRI is
			-- New {QL_FEATURE_IS_FROZEN_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_is_function_criterion: QL_FEATURE_IS_FUNCTION_CRI is
			-- New {QL_FEATURE_IS_FUNCTION_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_is_hidden_criterion: QL_FEATURE_IS_HIDDEN_CRI is
			-- New {QL_FEATURE_IS_HIDDEN_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_is_immediate_criterion: QL_FEATURE_IS_IMMEDIATE_CRI is
			-- New {QL_FEATURE_IS_IMMEDIATE_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_is_infix_criterion: QL_FEATURE_IS_INFIX_CRI is
			-- New {QL_FEATURE_IS_INFIX_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_is_invariant_criterion: QL_FEATURE_IS_INVARIANT_CRI is
			-- New {QL_FEATURE_IS_INVARIANT_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_is_obsolete_criterion: QL_FEATURE_IS_OBSOLETE_CRI is
			-- New {QL_FEATURE_IS_OBSOLETE_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_is_once_criterion: QL_FEATURE_IS_ONCE_CRI is
			-- New {QL_FEATURE_IS_ONCE_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_is_origin_criterion: QL_FEATURE_IS_ORIGIN_CRI is
			-- New {QL_FEATURE_IS_ORIGIN_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_is_prefix_criterion: QL_FEATURE_IS_PREFIX_CRI is
			-- New {QL_FEATURE_IS_PREFIX_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_is_procedure_criterion: QL_FEATURE_IS_PROCEDURE_CRI is
			-- New {QL_FEATURE_IS_PROCEDURE_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_is_unique_criterion: QL_FEATURE_IS_UNIQUE_CRI is
			-- New {QL_FEATURE_IS_UNIQUE_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_true_criterion: QL_FEATURE_TRUE_CRI is
			-- New {QL_FEATURE_TRUE_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_name_is_criterion (a_name: STRING; a_case_sensitive: BOOLEAN; a_identical: BOOLEAN): QL_FEATURE_NAME_IS_CRI is
			-- New {QL_FEATURE_NAME_IS_CRI} criterion.
		require
			a_name_attached: a_name /= Void
		do
			create Result.make_with_setting (a_name, a_case_sensitive, a_identical)
		ensure
			result_attached: Result /= Void
		end

	new_text_contain_criterion (a_text: STRING; a_case_sensitive: BOOLEAN; a_identical: BOOLEAN): QL_FEATURE_TEXT_CONTAIN_CRI is
			-- New {QL_FEATURE_TEXT_CONTAIN_CRI} criterion.
		require
			a_text_attached: a_text /= Void
		do
			create Result.make_with_setting (a_text, a_case_sensitive, a_identical)
		ensure
			result_attached: Result /= Void
		end

	new_ancestor_is_criterion (a_domain: QL_DOMAIN): QL_FEATURE_ANCESTOR_RELATION_CRI is
			-- New {QL_FEATURE_ANCESTOR_RELATION_CRI} criterion.
		require
			a_domain_attached: a_domain /= Void
		do
			create Result.make (a_domain)
		ensure
			result_attached: Result /= Void
		end

	new_descendant_is_criterion (a_domain: QL_DOMAIN): QL_FEATURE_DESCENDANT_RELATION_CRI is
			-- New {QL_FEATURE_DESCENDANT_RELATION_CRI} criterion.
		require
			a_domain_attached: a_domain /= Void
		do
			create Result.make (a_domain)
		ensure
			result_attached: Result /= Void
		end

	new_implementors_of_criterion (a_domain: QL_DOMAIN): QL_FEATURE_IMPLEMENTORS_OF_CRI is
			-- New {QL_FEATURE_IMPLEMENTORS_OF_CRI} criterion.
		require
			a_domain_attached: a_domain /= Void
		do
			create Result.make (a_domain)
		ensure
			result_attached: Result /= Void
		end

	new_is_exported_to_criterion (a_domain: QL_DOMAIN): QL_FEATURE_IS_EXPORTED_TO_CRI is
			-- New {QL_FEATURE_IS_EXPORTED_TO_CRI} criterion.
		require
			a_domain_attached: a_domain /= Void
		do
			create Result.make (a_domain)
		ensure
			result_attached: Result /= Void
		end

	new_callers_of_criterion (a_domain: QL_DOMAIN; a_only_current_version: BOOLEAN): QL_FEATURE_CALLERS_OF_CRI is
			-- New {QL_FEATURE_CALLERS_OF_CRI} criterion.
		require
			a_domain_attached: a_domain /= Void
		do
			create Result.make (a_domain, normal_caller, a_only_current_version)
		ensure
			result_attached: Result /= Void
		end

	new_caller_is_criterion (a_domain: QL_DOMAIN; a_only_current_version: BOOLEAN): QL_FEATURE_CALLER_IS_CRI is
			-- New {QL_FEATURE_CALLER_IS_CRI} criterion.
		require
			a_domain_attached: a_domain /= Void
		do
			create Result.make (a_domain, normal_callee, a_only_current_version)
		ensure
			result_attached: Result /= Void
		end

	new_assigners_of_criterion (a_domain: QL_DOMAIN; a_only_current_version: BOOLEAN): QL_FEATURE_CALLERS_OF_CRI is
			-- New {QL_FEATURE_CALLERS_OF_CRI} criterion.
		require
			a_domain_attached: a_domain /= Void
		do
			create Result.make (a_domain, assigner_caller, a_only_current_version)
		ensure
			result_attached: Result /= Void
		end

	new_assigner_is_criterion (a_domain: QL_DOMAIN; a_only_current_version: BOOLEAN): QL_FEATURE_CALLER_IS_CRI is
			-- New {QL_FEATURE_CALLER_IS_CRI} criterion.
		require
			a_domain_attached: a_domain /= Void
		do
			create Result.make (a_domain, assigner_callee, a_only_current_version)
		ensure
			result_attached: Result /= Void
		end

	new_creators_of_criterion (a_domain: QL_DOMAIN; a_only_current_version: BOOLEAN): QL_FEATURE_CALLERS_OF_CRI is
			-- New {QL_FEATURE_CALLERS_OF_CRI} criterion.
		require
			a_domain_attached: a_domain /= Void
		do
			create Result.make (a_domain, creator_caller, a_only_current_version)
		ensure
			result_attached: Result /= Void
		end

	new_creator_is_criterion (a_domain: QL_DOMAIN; a_only_current_version: BOOLEAN): QL_FEATURE_CALLER_IS_CRI is
			-- New {QL_FEATURE_CALLER_IS_CRI} criterion.
		require
			a_domain_attached: a_domain /= Void
		do
			create Result.make (a_domain, creator_callee, a_only_current_version)
		ensure
			result_attached: Result /= Void
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
