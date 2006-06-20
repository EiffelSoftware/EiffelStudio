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

	SHARED_SERVER

	SHARED_EIFFEL_PROJECT

create
	make

feature{NONE} -- Initialization

	make is
			-- Initialize.
		do
			create agent_table.make (50)
			agent_table.put (agent new_false_criterion, c_false)
			agent_table.put (agent new_has_arguments_criterion, c_has_argument)
			agent_table.put (agent new_has_assertion_criterion, c_has_assertion)
			agent_table.put (agent new_has_assigner_criterion, c_has_assigner)
			agent_table.put (agent new_has_comments_criterion, c_has_comment)
			agent_table.put (agent new_has_indexing_criterion, c_has_indexing)
			agent_table.put (agent new_has_locals_criterion, c_has_local)
			agent_table.put (agent new_has_postcondition_criterion, c_has_postcondition)
			agent_table.put (agent new_has_precondition_criterion, c_has_precondition)
			agent_table.put (agent new_has_rescue_criterion, c_has_rescue)
			agent_table.put (agent new_is_attribute_criterion, c_is_attribute)
			agent_table.put (agent new_is_compiled_criterion, c_is_compiled)
			agent_table.put (agent new_is_constant_criterion, c_is_constant)
			agent_table.put (agent new_is_creator_criterion, c_is_creator)
			agent_table.put (agent new_is_deferred_criterion, c_is_deferred)
			agent_table.put (agent new_is_exported_criterion, c_is_exported)
			agent_table.put (agent new_is_external_criterion, c_is_external)
			agent_table.put (agent new_is_feature_criterion, c_is_feature)
			agent_table.put (agent new_is_frozen_criterion, c_is_frozen)
			agent_table.put (agent new_is_function_criterion, c_is_function)
			agent_table.put (agent new_is_hidden_criterion, c_is_hidden)
			agent_table.put (agent new_is_immediate_criterion, c_is_immediate)
			agent_table.put (agent new_is_infix_criterion, c_is_infix)
			agent_table.put (agent new_is_invariant_criterion, c_is_invariant_feature)
			agent_table.put (agent new_is_obsolete_criterion, c_is_obsolete)
			agent_table.put (agent new_is_once_criterion, c_is_once)
			agent_table.put (agent new_is_origin_criterion, c_is_origin)
			agent_table.put (agent new_is_prefix_criterion, c_is_prefix)
			agent_table.put (agent new_is_procedure_criterion, c_is_procedure)
			agent_table.put (agent new_is_unique_criterion, c_is_unique)
			agent_table.put (agent new_is_query_criterion, c_is_query)
			agent_table.put (agent new_is_command_criterion, c_is_command)
			agent_table.put (agent new_is_visible_criterion, c_is_visible)

			agent_table.put (agent new_true_criterion, c_true)
			agent_table.put (agent new_name_is_criterion, c_name_is)
			agent_table.put (agent new_text_contain_criterion, c_text_contain)
			agent_table.put (agent new_ancestor_is_criterion, c_ancestor_is)
			agent_table.put (agent new_descendant_is_criterion, c_descendant_is)
			agent_table.put (agent new_implementors_of_criterion, c_implementors_of)
			agent_table.put (agent new_is_exported_to_criterion, c_is_exported_to)
			agent_table.put (agent new_callers_of_criterion, c_callee_is)
			agent_table.put (agent new_caller_is_criterion, c_caller_is)
			agent_table.put (agent new_assigners_of_criterion, c_assignee_is)
			agent_table.put (agent new_assigner_is_criterion, c_assigner_is)
			agent_table.put (agent new_creators_of_criterion, c_createe_is)
			agent_table.put (agent new_creator_is_criterion, c_creator_is)
			agent_table.put (agent new_return_type_is_criterion, c_return_type_is)

			create name_table.make (50)
			name_table.put (c_false, query_language_names.ql_cri_false)
			name_table.put (c_has_argument, query_language_names.ql_cri_has_argument)
			name_table.put (c_has_assertion, query_language_names.ql_cri_has_assertion)
			name_table.put (c_has_assigner, query_language_names.ql_cri_has_assigner)
			name_table.put (c_has_comment, query_language_names.ql_cri_has_comment)
			name_table.put (c_has_indexing, query_language_names.ql_cri_has_indexing)
			name_table.put (c_has_local, query_language_names.ql_cri_has_local)
			name_table.put (c_has_postcondition, query_language_names.ql_cri_has_postcondition)
			name_table.put (c_has_precondition, query_language_names.ql_cri_has_precondition)
			name_table.put (c_has_rescue, query_language_names.ql_cri_has_rescue)
			name_table.put (c_is_attribute, query_language_names.ql_cri_is_attribute)
			name_table.put (c_is_compiled, query_language_names.ql_cri_is_compiled)
			name_table.put (c_is_constant, query_language_names.ql_cri_is_constant)
			name_table.put (c_is_creator, query_language_names.ql_cri_is_creator)
			name_table.put (c_is_deferred, query_language_names.ql_cri_is_deferred)
			name_table.put (c_is_exported, query_language_names.ql_cri_is_exported)
			name_table.put (c_is_external, query_language_names.ql_cri_is_external)
			name_table.put (c_is_feature, query_language_names.ql_cri_is_feature)
			name_table.put (c_is_frozen, query_language_names.ql_cri_is_frozen)
			name_table.put (c_is_function, query_language_names.ql_cri_is_function)
			name_table.put (c_is_hidden, query_language_names.ql_cri_is_hidden)
			name_table.put (c_is_immediate, query_language_names.ql_cri_is_immediate)
			name_table.put (c_is_infix, query_language_names.ql_cri_is_infix)
			name_table.put (c_is_invariant_feature, query_language_names.ql_cri_is_invariant_feature)
			name_table.put (c_is_obsolete, query_language_names.ql_cri_is_obsolete)
			name_table.put (c_is_once, query_language_names.ql_cri_is_once)
			name_table.put (c_is_origin, query_language_names.ql_cri_is_origin)
			name_table.put (c_is_prefix, query_language_names.ql_cri_is_prefix)
			name_table.put (c_is_procedure, query_language_names.ql_cri_is_procedure)
			name_table.put (c_is_unique, query_language_names.ql_cri_is_unique)
			name_table.put (c_is_query, query_language_names.ql_cri_is_query)
			name_table.put (c_is_command, query_language_names.ql_cri_is_command)
			name_table.put (c_is_visible, query_language_names.ql_cri_is_visible)
			name_table.put (c_true, query_language_names.ql_cri_true)
			name_table.put (c_name_is, query_language_names.ql_cri_name_is)
			name_table.put (c_text_contain, query_language_names.ql_cri_text_contain)
			name_table.put (c_ancestor_is, query_language_names.ql_cri_ancestor_is)
			name_table.put (c_descendant_is, query_language_names.ql_cri_descendant_is)
			name_table.put (c_implementors_of, query_language_names.ql_cri_implementors_of)
			name_table.put (c_is_exported_to, query_language_names.ql_cri_is_exported_to)
			name_table.put (c_callee_is, query_language_names.ql_cri_callee_is)
			name_table.put (c_caller_is, query_language_names.ql_cri_caller_is)
			name_table.put (c_assignee_is, query_language_names.ql_cri_assignee_is)
			name_table.put (c_assigner_is, query_language_names.ql_cri_assigner_is)
			name_table.put (c_createe_is, query_language_names.ql_cri_createe_is)
			name_table.put (c_creator_is, query_language_names.ql_cri_creator_is)
			name_table.put (c_return_type_is, query_language_names.ql_cri_return_type_is)
		end

feature{NONE} -- Implementation

	criterion_type: QL_FEATURE_CRITERION
			-- Criterion anchor type

feature{NONE} -- New criterion

	new_false_criterion: QL_SIMPLE_FEATURE_CRITERION is
			-- New criterion that always returns False.
		do
			create Result.make (agent false_agent, False)
		ensure
			result_attached: Result /= Void
		end

	new_has_arguments_criterion: QL_SIMPLE_FEATURE_CRITERION is
			-- New criterion to test if `a_item' has arguments
		do
			create Result.make (agent has_arguments_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_has_assertion_criterion: QL_SIMPLE_FEATURE_CRITERION is
			-- New criterion to test if a feature has assertion
		do
			create Result.make (agent has_assertion_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_has_assigner_criterion: QL_SIMPLE_FEATURE_CRITERION is
			-- New criterion to test if a feature has assigner
		do
			create Result.make (agent has_assigner_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_has_comments_criterion: QL_SIMPLE_FEATURE_CRITERION is
			-- New criterion to test if a feature has comments
		do
			create Result.make (agent has_comments_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_has_indexing_criterion: QL_SIMPLE_FEATURE_CRITERION is
			-- New criterion to test if a feature has indexing clause
		do
			create Result.make (agent has_indexing_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_has_locals_criterion: QL_SIMPLE_FEATURE_CRITERION is
			-- New criterion to test if a feature has locals
		do
			create Result.make (agent has_locals_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_has_postcondition_criterion: QL_SIMPLE_FEATURE_CRITERION is
			-- New criterion to test if a feature has postcondition
		do
			create Result.make (agent has_postcondition_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_has_precondition_criterion: QL_SIMPLE_FEATURE_CRITERION is
			-- New criterion to test if a feature has precondition
		do
			create Result.make (agent has_precondition_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_has_rescue_criterion: QL_SIMPLE_FEATURE_CRITERION is
			-- New criterion to test if a feature has rescue clause
		do
			create Result.make (agent has_rescue_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_attribute_criterion: QL_SIMPLE_FEATURE_CRITERION is
			-- New criterion to test if a feature is_attribute
		do
			create Result.make (agent is_attribute_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_compiled_criterion: QL_SIMPLE_FEATURE_CRITERION is
			-- New criterion to test if a feature is compiled
		do
			create Result.make (agent is_compiled_agent, False)
		ensure
			result_attached: Result /= Void
		end

	new_is_constant_criterion: QL_SIMPLE_FEATURE_CRITERION is
			-- New criterion to test if a feature is constant
		do
			create Result.make (agent is_constant_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_creator_criterion: QL_SIMPLE_FEATURE_CRITERION is
			-- New criterion to test if a feature is creator
		do
			create Result.make (agent is_creator_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_deferred_criterion: QL_SIMPLE_FEATURE_CRITERION is
			-- New criterion to test if a feature is deferred
		do
			create Result.make (agent is_deferred_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_exported_criterion: QL_SIMPLE_FEATURE_CRITERION is
			-- New criterion to test if a feature is exported (to {ANY})
		do
			create Result.make (agent is_exported_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_external_criterion: QL_SIMPLE_FEATURE_CRITERION is
			-- New criterion to test if a feature is external
		do
			create Result.make (agent is_external_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_feature_criterion: QL_SIMPLE_FEATURE_CRITERION is
			-- New criterion to test if a feature is a real feature
			-- while not an invariant
		do
			create Result.make (agent is_feature_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_frozen_criterion: QL_SIMPLE_FEATURE_CRITERION is
			-- New {QL_FEATURE_IS_FROZEN_CRI} criterion.
		do
			create Result.make (agent is_frozen_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_function_criterion: QL_SIMPLE_FEATURE_CRITERION is
			-- New criterion to test if a feature is function
		do
			create Result.make (agent is_function_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_hidden_criterion: QL_SIMPLE_FEATURE_CRITERION is
			-- New criterion to test if a feature is hidden (e.g., exported to {NONE})
		do
			create Result.make (agent is_hidden_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_immediate_criterion: QL_SIMPLE_FEATURE_CRITERION is
			-- New criterion to test if a feature is immediate
		do
			create Result.make (agent is_immediate_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_infix_criterion: QL_SIMPLE_FEATURE_CRITERION is
			-- New criterion to test if a feature is infix
		do
			create Result.make (agent is_infix_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_invariant_criterion: QL_SIMPLE_FEATURE_CRITERION is
			-- New criterion to test if a feature is invariant while not a real feature
		do
			create Result.make (agent is_invariant_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_obsolete_criterion: QL_SIMPLE_FEATURE_CRITERION is
			-- New criterion to test if a feature is obsolete
		do
			create Result.make (agent is_obsolete_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_once_criterion: QL_SIMPLE_FEATURE_CRITERION is
			-- New criterion to test if a feature is once
		do
			create Result.make (agent is_once_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_origin_criterion: QL_SIMPLE_FEATURE_CRITERION is
			-- New criterion to test if a feature is origin
		do
			create Result.make (agent is_origin_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_prefix_criterion: QL_SIMPLE_FEATURE_CRITERION is
			-- New criterion to test if a feature is prefix
		do
			create Result.make (agent is_prefix_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_procedure_criterion: QL_SIMPLE_FEATURE_CRITERION is
			-- New criterion to test if a feature is procedure
		do
			create Result.make (agent is_procedure_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_unique_criterion: QL_SIMPLE_FEATURE_CRITERION is
			-- New criterion to test if a feature is unique
		do
			create Result.make (agent is_unique_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_query_criterion: QL_SIMPLE_FEATURE_CRITERION is
			-- New criterion to test if a feature is query
		do
			create Result.make (agent is_query_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_command_criterion: QL_SIMPLE_FEATURE_CRITERION is
			-- New criterion to test if a feature is command
		do
			create Result.make (agent is_command_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_visible_criterion: QL_SIMPLE_FEATURE_CRITERION is
			-- New criterion to test if a feature is visible
		do
			create Result.make (agent is_visible_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_true_criterion: QL_SIMPLE_FEATURE_CRITERION is
			-- New criterion that always returns True (tautology criterion)
		do
			create Result.make (agent true_agent, False)
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

	new_return_type_is_criterion (a_domain: QL_DOMAIN): QL_FEATURE_RETURN_TYPE_IS_CRI is
			-- New {QL_FEATURE_RETURN_TYPE_IS_CRI} criterion.
		require
			a_domain_attached: a_domain /= Void
		do
			create Result.make (a_domain)
		ensure
			result_attached: Result /= Void
		end


feature -- Criterion index

	c_false,
	c_has_argument,
	c_has_assertion,
	c_has_assigner,
	c_has_comment,
	c_has_indexing,
	c_has_local,
	c_has_postcondition,
	c_has_precondition,
	c_has_rescue,
	c_is_attribute,
	c_is_compiled,
	c_is_constant,
	c_is_creator,
	c_is_deferred,
	c_is_exported,
	c_is_external,
	c_is_feature,
	c_is_frozen,
	c_is_function,
	c_is_hidden,
	c_is_immediate,
	c_is_infix,
	c_is_invariant_feature,
	c_is_obsolete,
	c_is_once,
	c_is_origin,
	c_is_prefix,
	c_is_procedure,
	c_is_unique,
	c_is_query,
	c_is_command,
	c_is_visible,
	c_true,
	c_name_is,
	c_text_contain,
	c_ancestor_is,
	c_descendant_is,
	c_implementors_of,
	c_is_exported_to,
	c_callee_is,
	c_caller_is,
	c_assignee_is,
	c_assigner_is,
	c_createe_is,
	c_creator_is,
	c_return_type_is: INTEGER is unique

feature{NONE} -- Implementation

	false_agent (a_item: QL_FEATURE): BOOLEAN is
			-- Agent that always returns False.
			-- Require compiled: False
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
		end

	has_arguments_agent (a_item: QL_FEATURE): BOOLEAN is
			-- Agent to test if `a_item' has arguments
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.is_real_feature and then a_item.e_feature.has_arguments
		end

	has_assertion_agent (a_item: QL_FEATURE): BOOLEAN is
			-- Agent to test if `a_item' has assertion
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		local
			l_feature: E_FEATURE
		do
			Result := a_item.is_real_feature
			if Result then
				l_feature := a_item.e_feature
				Result := l_feature.has_precondition or l_feature.has_postcondition
			end
		end

	has_assigner_agent (a_item: QL_FEATURE): BOOLEAN is
			-- Agent to test if `a_item' has assigner
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.is_real_feature and then a_item.e_feature.assigner_name /= Void
		end

	has_comments_agent (a_item: QL_FEATURE): BOOLEAN is
			-- Agent to test if `a_item' has comments
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		local
			l_comments: EIFFEL_COMMENTS
			l_feature: E_FEATURE
		do
			Result := a_item.is_real_feature
			if Result then
				if a_item.e_feature.is_il_external then
					Result := True
				else
					l_feature := a_item.e_feature
					l_comments := l_feature.ast.comment (match_list_server.item (l_feature.written_class.class_id))
					Result := not l_comments.is_empty
				end
			end
		end

	has_indexing_agent (a_item: QL_FEATURE): BOOLEAN is
			-- Agent to test if `a_item' has indexing clause
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.is_real_feature and then a_item.e_feature.ast.body.indexing_clause /= Void
		end

	has_locals_agent (a_item: QL_FEATURE): BOOLEAN is
			-- Agent to test if `a_item' has locals
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		local
			l_locals:  EIFFEL_LIST [TYPE_DEC_AS]
		do
			Result := a_item.is_real_feature
			if Result then
				l_locals := a_item.e_feature.locals
				Result := l_locals /= Void and then not l_locals.is_empty
			end
		end

	has_postcondition_agent (a_item: QL_FEATURE): BOOLEAN is
			-- Agent to test if `a_item' has postcondition
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.is_real_feature and then a_item.e_feature.has_postcondition
		end

	has_precondition_agent (a_item: QL_FEATURE): BOOLEAN is
			-- Agent to test if `a_item' has precondition
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.is_real_feature and then a_item.e_feature.has_precondition
		end

	has_rescue_agent (a_item: QL_FEATURE): BOOLEAN is
			-- Agent to test if `a_item' has rescue clause
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		local
			l_feature: E_FEATURE
			l_routine: ROUTINE_AS
		do
			Result := a_item.is_real_feature
			if Result then
				l_feature := a_item.e_feature
				Result := l_feature.is_procedure or l_feature.is_function
				if Result then
					l_routine ?= l_feature.ast.body.content
					if l_routine /= Void then
						Result := l_routine.rescue_clause /= Void
					end
				end
			end
		end

	is_attribute_agent (a_item: QL_FEATURE): BOOLEAN is
			-- Agent to test if `a_item' is attribute
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.is_real_feature and then a_item.e_feature.is_attribute
		end

	is_compiled_agent (a_item: QL_FEATURE): BOOLEAN is
			-- Agent to test if `a_item' is compiled
			-- Require compiled: False
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.is_compiled
		end

	is_constant_agent (a_item: QL_FEATURE): BOOLEAN is
			-- Agent to test if `a_item' is constant
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.is_real_feature and then a_item.e_feature.is_constant
		end

	is_creator_agent (a_item: QL_FEATURE): BOOLEAN is
			-- Agent to test if `a_item' is creator
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		local
			l_class: CLASS_C
			l_creators: HASH_TABLE [EXPORT_I, STRING]
		do
			if a_item.is_real_feature then
				l_class := a_item.class_c
					-- Note that this is not the most efficient way to know if `f'
					-- is a creation routine, as the quicked way would be to iterate
					--  through `current_class.creators', but this enables the reuse
					-- of the existing framework.
				l_creators := l_class.creators
				if l_creators = Void then
						-- Simply search for the version of `{ANY}.default_create'.
					Result := a_item.e_feature.rout_id_set.has (eiffel_system.system.default_create_id)
				elseif not l_creators.is_empty then
					Result := l_creators.has (a_item.e_feature.name)
				end
			end
		end

	is_exported_agent (a_item: QL_FEATURE): BOOLEAN is
			-- Agent to test if `a_item' is exported (to {ANY})
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			if a_item.is_real_feature then
				check a_item.e_feature.export_status /= Void end
				Result := a_item.e_feature.export_status.is_all
			end
		end

	is_deferred_agent (a_item: QL_FEATURE): BOOLEAN is
			-- Agent to test if `a_item' is deferred
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.is_real_feature and then a_item.e_feature.is_deferred
		end

	is_external_agent (a_item: QL_FEATURE): BOOLEAN is
			-- Agent to test if `a_item' is external
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.is_real_feature and then a_item.e_feature.is_external
		end

	is_feature_agent (a_item: QL_FEATURE): BOOLEAN is
			-- Agent to test if `a_item' is a real feature (while not an invariant)
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.is_real_feature
		end

	is_frozen_agent (a_item: QL_FEATURE): BOOLEAN is
			-- Agent to test if `a_item' is frozen
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.is_real_feature and then a_item.e_feature.is_frozen
		end

	is_function_agent (a_item: QL_FEATURE): BOOLEAN is
			-- Agent to test if `a_item' is function
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.is_real_feature and then a_item.e_feature.is_function
		end

	is_hidden_agent (a_item: QL_FEATURE): BOOLEAN is
			-- Agent to test if `a_item' is hidden (e.g., it is exported to {NONE})
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			if a_item.is_real_feature then
				check a_item.e_feature.export_status /= Void end
				Result := a_item.e_feature.export_status.is_none
			end
		end

	is_immediate_agent (a_item: QL_FEATURE): BOOLEAN is
			-- Agent to test if `a_item' is immediate
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.is_immediate
		end

	is_infix_agent (a_item: QL_FEATURE): BOOLEAN is
			-- Agent to test if `a_item' is infix
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.is_real_feature and then a_item.e_feature.is_infix
		end

	is_invariant_agent (a_item: QL_FEATURE): BOOLEAN is
			-- Agent to test if `a_item' is invariant (while not a real feature)
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.is_invariant_feature
		end

	is_obsolete_agent (a_item: QL_FEATURE): BOOLEAN is
			-- Agent to test if `a_item' is obsolete
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.is_real_feature and then a_item.e_feature.is_obsolete
		end

	is_once_agent (a_item: QL_FEATURE): BOOLEAN is
			-- Agent to test if `a_item' is once
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.is_real_feature and then a_item.e_feature.is_once
		end

	is_origin_agent (a_item: QL_FEATURE): BOOLEAN is
			-- Agent to test if `a_item' is origin
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.is_real_feature and then a_item.e_feature.is_origin
		end

	is_prefix_agent (a_item: QL_FEATURE): BOOLEAN is
			-- Agent to test if `a_item' is prefix
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.is_real_feature and then a_item.e_feature.is_prefix
		end

	is_procedure_agent (a_item: QL_FEATURE): BOOLEAN is
			-- Agent to test if `a_item' is procedure
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.is_real_feature and then a_item.e_feature.is_procedure
		end

	is_unique_agent (a_item: QL_FEATURE): BOOLEAN is
			-- Agent to test if `a_item' is unique
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.is_real_feature and then a_item.e_feature.is_unique
		end

	is_query_agent (a_item: QL_FEATURE): BOOLEAN is
			-- Agent to test if `a_item' is query
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		local
			l_feature: E_FEATURE
		do
			if a_item.is_real_feature then
				l_feature := a_item.e_feature
				Result := l_feature.is_function or l_feature.is_attribute or l_feature.is_constant or l_feature.is_unique
			end
		end

	is_command_agent (a_item: QL_FEATURE): BOOLEAN is
			-- Agent to test if `a_item' is command
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := is_procedure_agent (a_item)
		end

	is_visible_agent (a_item: QL_FEATURE): BOOLEAN is
			-- Agent to test if `a_item' is visible
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.is_visible
		end

	true_agent (a_item: QL_FEATURE): BOOLEAN is
			-- Agent that always returns True (tautology criterion)
			-- Require compiled: False
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := True
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
