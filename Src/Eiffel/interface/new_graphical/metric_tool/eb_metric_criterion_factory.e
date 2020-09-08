note
	description: "Metric criterion factory"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_CRITERION_FACTORY

inherit
	QL_SHARED_SCOPES

	QL_SHARED_NAMES

create
	make

feature{NONE} -- Initialization

	make
			-- Initialize.
		do
			create criterion_table.make (10)
			initialize_target_criteria
			initialize_group_criteria
			initialize_class_criteria
			initialize_generic_criteria
			initialize_feature_criteria
			initialize_argument_criteria
			initialize_local_criteria
			initialize_assertion_criteria
			initialize_line_criteria
		end

feature -- Access

	metric_criterion (a_scope: QL_SCOPE; a_name: STRING): EB_METRIC_CRITERION
			-- New metric criterion whose `type' is `a_scope' and `name' is `a_name'
		require
			a_scope_attached: a_scope /= Void
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			criterion_exists: has_criterion (a_name, a_scope)
		do
			Result := criterion_table.item (a_scope).item (a_name).item (Void)
		ensure
			result_attached: Result /= Void
		end

	criterion_names_with_scope (a_scope: QL_SCOPE): LIST [STRING]
			-- List of name of criterion of type `a_scope'
		require
			a_scope_attached: a_scope /= Void
		local
			l_table: HASH_TABLE [FUNCTION [EB_METRIC_CRITERION], STRING]
		do
			l_table := criterion_table.item (a_scope)
			if l_table /= Void then
				create {ARRAYED_LIST [STRING]}Result.make (l_table.count)
				from
					l_table.start
				until
					l_table.after
				loop
					Result.extend (l_table.key_for_iteration)
					l_table.forth
				end
			else
				create {ARRAYED_LIST [STRING]}Result.make (0)
			end
		ensure
			result_attached: Result /= Void
		end

	criteria_with_scope (a_scope: QL_SCOPE): LIST [EB_METRIC_CRITERION]
			-- List of criterion of type `a_scope'
			-- Can be Void if there is no criterion of `a_scope' registered in `criterion_table'.
		local
			l_table: HASH_TABLE [FUNCTION [EB_METRIC_CRITERION], STRING]
		do
			l_table := criterion_table.item (a_scope)
			if l_table /= Void then
				create {ARRAYED_LIST [EB_METRIC_CRITERION]}Result.make (l_table.count)
				from
					l_table.start
				until
					l_table.after
				loop
					Result.extend (metric_criterion (a_scope, l_table.key_for_iteration))
					l_table.forth
				end
			else
				create {ARRAYED_LIST [EB_METRIC_CRITERION]}Result.make (0)
			end
		ensure
			result_attached: Result /= Void
		end

feature -- Status report

	has_criterion (a_name: STRING; a_scope: QL_SCOPE): BOOLEAN
			-- Does metric with `a_name' and `a_scope' exist in current?
		require
			a_name_attached: a_name /= Void
			a_scope_attached: a_scope /= Void
		do
			Result := criterion_table.has (a_scope) and then criterion_table.item (a_scope).has (a_name)
		end

feature {NONE} -- Implementation

	criterion_table: HASH_TABLE [HASH_TABLE [FUNCTION [EB_METRIC_CRITERION], STRING], QL_SCOPE]
			-- Table of agents to create criteria
			-- Key of outer hash table is criterion scope type
			-- Key of inner hash table is criterion name,
			-- Value of inner hash table is an agent to create a criterion with given name and scope.

	new_normal_criterion (a_scope: QL_SCOPE; a_name: STRING): EB_METRIC_CRITERION
			-- New metric criterion whose `type' is `a_scope' and `name' is `a_name'
		require
			a_scope_attached: a_scope /= Void
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		do
			create {EB_METRIC_NORMAL_CRITERION}Result.make (a_scope, a_name)
		ensure
			result_attached: Result /= Void
		end

	new_name_criterion (a_scope: QL_SCOPE; a_name: STRING): EB_METRIC_CRITERION
			-- New metric criterion whose `type' is `a_scope' and `name' is `a_name'
		require
			a_scope_attached: a_scope /= Void
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		do
			create {EB_METRIC_TEXT_CRITERION}Result.make (a_scope, a_name)
		ensure
			result_attached: Result /= Void
		end

	new_path_criterion (a_scope: QL_SCOPE; a_name: STRING): EB_METRIC_CRITERION
			-- New metric criterion whose `type' is `a_scope' and `name' is `a_name'
		require
			a_scope_attached: a_scope /= Void
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		do
			create {EB_METRIC_PATH_CRITERION}Result.make (a_scope, a_name)
		ensure
			result_attached: Result /= Void
		end

	new_domain_criterion (a_scope: QL_SCOPE; a_name: STRING): EB_METRIC_CRITERION
			-- New metric criterion whose `type' is `a_scope' and `name' is `a_name'
		require
			a_scope_attached: a_scope /= Void
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		do
			create {EB_METRIC_DOMAIN_CRITERION}Result.make (a_scope, a_name)
		ensure
			result_attached: Result /= Void
		end

	new_caller_callee_criterion (a_scope: QL_SCOPE; a_name: STRING): EB_METRIC_CRITERION
			-- New metric criterion whose `type' is `a_scope' and `name' is `a_name'
		require
			a_scope_attached: a_scope /= Void
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		do
			create {EB_METRIC_CALLER_CALLEE_CRITERION}Result.make (a_scope, a_name)
		ensure
			result_attached: Result /= Void
		end

	new_supplier_client_criterion (a_scope: QL_SCOPE; a_name: STRING): EB_METRIC_CRITERION
			-- New metric criterion whose `type' is `a_scope' and `name' is `a_name'
		require
			a_scope_attached: a_scope /= Void
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		do
			create {EB_METRIC_SUPPLIER_CLIENT_CRITERION}Result.make (a_scope, a_name)
		ensure
			result_attached: Result /= Void
		end

	new_nary_criterion (a_scope: QL_SCOPE; a_name: STRING): EB_METRIC_CRITERION
			-- New metric criterion whose `type' is `a_scope' and `name' is `a_name'
		require
			a_scope_attached: a_scope /= Void
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		do
			if a_name.is_equal (query_language_names.ql_cri_and) then
				create {EB_METRIC_AND_CRITERION} Result.make (a_scope, a_name)
			elseif a_name.is_equal (query_language_names.ql_cri_or) then
				create {EB_METRIC_OR_CRITERION} Result.make (a_scope, a_name)
			end
		ensure
			result_attached: Result /= Void
		end

	new_value_criterion (a_scope: QL_SCOPE; a_name: STRING): EB_METRIC_VALUE_CRITERION
			-- New value criterion whose `type' is `a_scope' and `name' is `a_name'
		require
			a_scope_attached: a_scope /= Void
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		do
			create Result.make (a_scope, a_name)
		ensure
			result_attached: Result /= Void
		end

	new_external_command_criterion (a_scope: QL_SCOPE; a_name: STRING): EB_METRIC_EXTERNAL_COMMAND_CRITERION
			-- New external command criterion whose `type' is `a_scope' and `name' is `a_name'
		require
			a_scope_attached: a_scope /= Void
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		do
			create Result.make (a_scope, a_name)
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Initialization

	initialize_target_criteria
			-- Initialize target criteria.
		local
			l_hash_table: HASH_TABLE [FUNCTION [EB_METRIC_CRITERION], STRING]
		do
			create l_hash_table.make (10)
			criterion_table.put (l_hash_table, target_scope)
			l_hash_table.put (agent new_normal_criterion (target_scope, query_language_names.ql_cri_false), query_language_names.ql_cri_false)
			l_hash_table.put (agent new_normal_criterion (target_scope, query_language_names.ql_cri_is_compiled), query_language_names.ql_cri_is_compiled)
			l_hash_table.put (agent new_normal_criterion (target_scope, query_language_names.ql_cri_true), query_language_names.ql_cri_true)

			l_hash_table.put (agent new_name_criterion (target_scope, query_language_names.ql_cri_name_is), query_language_names.ql_cri_name_is)

			l_hash_table.put (agent new_nary_criterion (target_scope, query_language_names.ql_cri_and), query_language_names.ql_cri_and)
			l_hash_table.put (agent new_nary_criterion (target_scope, query_language_names.ql_cri_or), query_language_names.ql_cri_or)

			l_hash_table.put (agent new_value_criterion (target_scope, query_language_names.ql_cri_value_of_metric_is), query_language_names.ql_cri_value_of_metric_is)

			l_hash_table.put (agent new_external_command_criterion (target_scope, query_language_names.ql_cri_is_satisfied_by), query_language_names.ql_cri_is_satisfied_by)
		end

	initialize_group_criteria
			-- Initialize group criteria.
		local
			l_hash_table: HASH_TABLE [FUNCTION [EB_METRIC_CRITERION], STRING]
		do
			create l_hash_table.make (10)
			criterion_table.put (l_hash_table, group_scope)

			l_hash_table.put (agent new_normal_criterion (group_scope, query_language_names.ql_cri_false), query_language_names.ql_cri_false)
			l_hash_table.put (agent new_normal_criterion (group_scope, query_language_names.ql_cri_is_assembly), query_language_names.ql_cri_is_assembly)
			l_hash_table.put (agent new_normal_criterion (group_scope, query_language_names.ql_cri_is_cluster), query_language_names.ql_cri_is_cluster)
			l_hash_table.put (agent new_normal_criterion (group_scope, query_language_names.ql_cri_is_compiled), query_language_names.ql_cri_is_compiled)
			l_hash_table.put (agent new_normal_criterion (group_scope, query_language_names.ql_cri_is_library), query_language_names.ql_cri_is_library)
			l_hash_table.put (agent new_normal_criterion (group_scope, query_language_names.ql_cri_is_override), query_language_names.ql_cri_is_override)
			l_hash_table.put (agent new_normal_criterion (group_scope, query_language_names.ql_cri_true), query_language_names.ql_cri_true)
			l_hash_table.put (agent new_normal_criterion (group_scope, query_language_names.ql_cri_is_valid), query_language_names.ql_cri_is_valid)
			l_hash_table.put (agent new_normal_criterion (group_scope, query_language_names.ql_cri_is_used_in_library), query_language_names.ql_cri_is_used_in_library)
			l_hash_table.put (agent new_normal_criterion (group_scope, query_language_names.ql_cri_is_class_set), query_language_names.ql_cri_is_class_set)
			l_hash_table.put (agent new_name_criterion (group_scope, query_language_names.ql_cri_name_is), query_language_names.ql_cri_name_is)

			l_hash_table.put (agent new_nary_criterion (group_scope, query_language_names.ql_cri_and), query_language_names.ql_cri_and)
			l_hash_table.put (agent new_nary_criterion (group_scope, query_language_names.ql_cri_or), query_language_names.ql_cri_or)

			l_hash_table.put (agent new_value_criterion (group_scope, query_language_names.ql_cri_value_of_metric_is), query_language_names.ql_cri_value_of_metric_is)

			l_hash_table.put (agent new_external_command_criterion (group_scope, query_language_names.ql_cri_is_satisfied_by), query_language_names.ql_cri_is_satisfied_by)
		end

	initialize_class_criteria
			-- Initialize class criteria.
		local
			l_hash_table: HASH_TABLE [FUNCTION [EB_METRIC_CRITERION], STRING]
		do
			create l_hash_table.make (40)
			criterion_table.put (l_hash_table, class_scope)

			l_hash_table.put (agent new_normal_criterion (class_scope, query_language_names.ql_cri_false), query_language_names.ql_cri_false)
			l_hash_table.put (agent new_normal_criterion (class_scope, query_language_names.ql_cri_has_bottom_indexing), query_language_names.ql_cri_has_bottom_indexing)
			l_hash_table.put (agent new_normal_criterion (class_scope, query_language_names.ql_cri_has_indexing), query_language_names.ql_cri_has_indexing)
			l_hash_table.put (agent new_normal_criterion (class_scope, query_language_names.ql_cri_has_invariant), query_language_names.ql_cri_has_invariant)
			l_hash_table.put (agent new_normal_criterion (class_scope, query_language_names.ql_cri_has_top_indexing), query_language_names.ql_cri_has_top_indexing)
			l_hash_table.put (agent new_normal_criterion (class_scope, query_language_names.ql_cri_is_compiled), query_language_names.ql_cri_is_compiled)
			l_hash_table.put (agent new_normal_criterion (class_scope, query_language_names.ql_cri_is_deferred), query_language_names.ql_cri_is_deferred)
			l_hash_table.put (agent new_normal_criterion (class_scope, query_language_names.ql_cri_is_effective), query_language_names.ql_cri_is_effective)
			l_hash_table.put (agent new_normal_criterion (class_scope, query_language_names.ql_cri_is_enum), query_language_names.ql_cri_is_enum)
			l_hash_table.put (agent new_normal_criterion (class_scope, query_language_names.ql_cri_is_expanded), query_language_names.ql_cri_is_expanded)
			l_hash_table.put (agent new_normal_criterion (class_scope, query_language_names.ql_cri_is_once), query_language_names.ql_cri_is_once)
			l_hash_table.put (agent new_normal_criterion (class_scope, query_language_names.ql_cri_is_external), query_language_names.ql_cri_is_external)
			l_hash_table.put (agent new_normal_criterion (class_scope, query_language_names.ql_cri_is_frozen), query_language_names.ql_cri_is_frozen)
			l_hash_table.put (agent new_normal_criterion (class_scope, query_language_names.ql_cri_is_generic), query_language_names.ql_cri_is_generic)
			l_hash_table.put (agent new_normal_criterion (class_scope, query_language_names.ql_cri_is_obsolete), query_language_names.ql_cri_is_obsolete)
			l_hash_table.put (agent new_normal_criterion (class_scope, query_language_names.ql_cri_is_precompiled), query_language_names.ql_cri_is_precompiled)
			l_hash_table.put (agent new_normal_criterion (class_scope, query_language_names.ql_cri_true), query_language_names.ql_cri_true)
			l_hash_table.put (agent new_normal_criterion (class_scope, query_language_names.ql_cri_is_visible), query_language_names.ql_cri_is_visible)

			l_hash_table.put (agent new_normal_criterion (class_scope, query_language_names.ql_cri_is_valid), query_language_names.ql_cri_is_valid)
			l_hash_table.put (agent new_normal_criterion (class_scope, query_language_names.ql_cri_is_always_compiled), query_language_names.ql_cri_is_always_compiled)
			l_hash_table.put (agent new_normal_criterion (class_scope, query_language_names.ql_cri_is_partial), query_language_names.ql_cri_is_partial)
			l_hash_table.put (agent new_normal_criterion (class_scope, query_language_names.ql_cri_is_read_only), query_language_names.ql_cri_is_read_only)
			l_hash_table.put (agent new_normal_criterion (class_scope, query_language_names.ql_cri_is_overridden), query_language_names.ql_cri_is_overridden)
			l_hash_table.put (agent new_normal_criterion (class_scope, query_language_names.ql_cri_is_overrider), query_language_names.ql_cri_is_overrider)

			l_hash_table.put (agent new_path_criterion (class_scope, query_language_names.ql_cri_path_in), query_language_names.ql_cri_path_in)
			l_hash_table.put (agent new_path_criterion (class_scope, query_language_names.ql_cri_path_is), query_language_names.ql_cri_path_is)

			l_hash_table.put (agent new_domain_criterion (class_scope, query_language_names.ql_cri_ancestor_is), query_language_names.ql_cri_ancestor_is)
			l_hash_table.put (agent new_domain_criterion (class_scope, query_language_names.ql_cri_proper_ancestor_is), query_language_names.ql_cri_proper_ancestor_is)
			l_hash_table.put (agent new_domain_criterion (class_scope, query_language_names.ql_cri_parent_is), query_language_names.ql_cri_parent_is)
			l_hash_table.put (agent new_domain_criterion (class_scope, query_language_names.ql_cri_indirect_parent_is), query_language_names.ql_cri_indirect_parent_is)
			l_hash_table.put (agent new_domain_criterion (class_scope, query_language_names.ql_cri_descendant_is), query_language_names.ql_cri_descendant_is)
			l_hash_table.put (agent new_domain_criterion (class_scope, query_language_names.ql_cri_proper_descendant_is), query_language_names.ql_cri_proper_descendant_is)
			l_hash_table.put (agent new_domain_criterion (class_scope, query_language_names.ql_cri_heir_is), query_language_names.ql_cri_heir_is)
			l_hash_table.put (agent new_domain_criterion (class_scope, query_language_names.ql_cri_indirect_heir_is), query_language_names.ql_cri_indirect_heir_is)
			l_hash_table.put (agent new_supplier_client_criterion (class_scope, query_language_names.ql_cri_supplier_is), query_language_names.ql_cri_supplier_is)
			l_hash_table.put (agent new_supplier_client_criterion (class_scope, query_language_names.ql_cri_client_is), query_language_names.ql_cri_client_is)

			l_hash_table.put (agent new_name_criterion (class_scope, query_language_names.ql_cri_name_is), query_language_names.ql_cri_name_is)
			l_hash_table.put (agent new_name_criterion (class_scope, query_language_names.ql_cri_text_contain), query_language_names.ql_cri_text_contain)
			l_hash_table.put (agent new_name_criterion (class_scope, query_language_names.ql_cri_top_indexing_has_tag), query_language_names.ql_cri_top_indexing_has_tag)
			l_hash_table.put (agent new_name_criterion (class_scope, query_language_names.ql_cri_bottom_indexing_has_tag), query_language_names.ql_cri_bottom_indexing_has_tag)
			l_hash_table.put (agent new_name_criterion (class_scope, query_language_names.ql_cri_indexing_has_tag), query_language_names.ql_cri_indexing_has_tag)
			l_hash_table.put (agent new_name_criterion (class_scope, query_language_names.ql_cri_top_indexing_contain), query_language_names.ql_cri_top_indexing_contain)
			l_hash_table.put (agent new_name_criterion (class_scope, query_language_names.ql_cri_bottom_indexing_contain), query_language_names.ql_cri_bottom_indexing_contain)
			l_hash_table.put (agent new_name_criterion (class_scope, query_language_names.ql_cri_indexing_contain), query_language_names.ql_cri_indexing_contain)

			l_hash_table.put (agent new_nary_criterion (class_scope, query_language_names.ql_cri_and), query_language_names.ql_cri_and)
			l_hash_table.put (agent new_nary_criterion (class_scope, query_language_names.ql_cri_or), query_language_names.ql_cri_or)

			l_hash_table.put (agent new_value_criterion (class_scope, query_language_names.ql_cri_value_of_metric_is), query_language_names.ql_cri_value_of_metric_is)

			l_hash_table.put (agent new_external_command_criterion (class_scope, query_language_names.ql_cri_is_satisfied_by), query_language_names.ql_cri_is_satisfied_by)
		end

	initialize_generic_criteria
			-- Initialize generic criteria.
		local
			l_hash_table: HASH_TABLE [FUNCTION [EB_METRIC_CRITERION], STRING]
		do
			create l_hash_table.make (10)
			criterion_table.put (l_hash_table, generic_scope)
			l_hash_table.put (agent new_normal_criterion (generic_scope, query_language_names.ql_cri_false), query_language_names.ql_cri_false)
			l_hash_table.put (agent new_normal_criterion (generic_scope, query_language_names.ql_cri_has_constraint), query_language_names.ql_cri_has_constraint)
			l_hash_table.put (agent new_normal_criterion (generic_scope, query_language_names.ql_cri_has_creation_constraint), query_language_names.ql_cri_has_creation_constraint)
			l_hash_table.put (agent new_normal_criterion (generic_scope, query_language_names.ql_cri_is_compiled), query_language_names.ql_cri_is_compiled)
			l_hash_table.put (agent new_normal_criterion (generic_scope, query_language_names.ql_cri_is_expanded), query_language_names.ql_cri_is_expanded)
			l_hash_table.put (agent new_normal_criterion (generic_scope, query_language_names.ql_cri_is_reference), query_language_names.ql_cri_is_reference)
			l_hash_table.put (agent new_normal_criterion (generic_scope, query_language_names.ql_cri_is_visible), query_language_names.ql_cri_is_visible)
			l_hash_table.put (agent new_normal_criterion (generic_scope, query_language_names.ql_cri_true), query_language_names.ql_cri_true)

			l_hash_table.put (agent new_name_criterion (generic_scope, query_language_names.ql_cri_name_is), query_language_names.ql_cri_name_is)
			l_hash_table.put (agent new_name_criterion (generic_scope, query_language_names.ql_cri_text_contain), query_language_names.ql_cri_text_contain)

			l_hash_table.put (agent new_nary_criterion (generic_scope, query_language_names.ql_cri_and), query_language_names.ql_cri_and)
			l_hash_table.put (agent new_nary_criterion (generic_scope, query_language_names.ql_cri_or), query_language_names.ql_cri_or)

			l_hash_table.put (agent new_value_criterion (generic_scope, query_language_names.ql_cri_value_of_metric_is), query_language_names.ql_cri_value_of_metric_is)

			l_hash_table.put (agent new_external_command_criterion (generic_scope, query_language_names.ql_cri_is_satisfied_by), query_language_names.ql_cri_is_satisfied_by)
		end

	initialize_feature_criteria
			-- Initialize feature criteria.
		local
			l_hash_table: HASH_TABLE [FUNCTION [EB_METRIC_CRITERION], STRING]
		do
			create l_hash_table.make (54)
			criterion_table.put (l_hash_table, feature_scope)

			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_false), query_language_names.ql_cri_false)
			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_has_argument), query_language_names.ql_cri_has_argument)
			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_has_assertion), query_language_names.ql_cri_has_assertion)
			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_has_assigner), query_language_names.ql_cri_has_assigner)
			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_has_comment), query_language_names.ql_cri_has_comment)
			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_has_indexing), query_language_names.ql_cri_has_indexing)
			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_has_local), query_language_names.ql_cri_has_local)
			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_has_postcondition), query_language_names.ql_cri_has_postcondition)
			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_has_class_postcondition), query_language_names.ql_cri_has_class_postcondition)
			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_has_precondition), query_language_names.ql_cri_has_precondition)
			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_has_rescue), query_language_names.ql_cri_has_rescue)
			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_is_attribute), query_language_names.ql_cri_is_attribute)
			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_is_compiled), query_language_names.ql_cri_is_compiled)
			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_is_constant), query_language_names.ql_cri_is_constant)
			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_is_creator), query_language_names.ql_cri_is_creator)
			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_is_deferred), query_language_names.ql_cri_is_deferred)
			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_is_effective), query_language_names.ql_cri_is_effective)
			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_is_exported), query_language_names.ql_cri_is_exported)
			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_is_external), query_language_names.ql_cri_is_external)
			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_is_feature), query_language_names.ql_cri_is_feature)
			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_is_frozen), query_language_names.ql_cri_is_frozen)
			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_is_function), query_language_names.ql_cri_is_function)
			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_is_ghost), query_language_names.ql_cri_is_ghost)
			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_is_hidden), query_language_names.ql_cri_is_hidden)
			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_is_immediate), query_language_names.ql_cri_is_immediate)
			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_is_infix), query_language_names.ql_cri_is_infix)
			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_is_invariant_feature), query_language_names.ql_cri_is_invariant_feature)
			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_is_obsolete), query_language_names.ql_cri_is_obsolete)
			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_is_once), query_language_names.ql_cri_is_once)
			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_is_class), query_language_names.ql_cri_is_class)
			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_is_origin), query_language_names.ql_cri_is_origin)
			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_is_prefix), query_language_names.ql_cri_is_prefix)
			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_is_procedure), query_language_names.ql_cri_is_procedure)
			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_is_query), query_language_names.ql_cri_is_query)
			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_is_command), query_language_names.ql_cri_is_command)
			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_is_visible), query_language_names.ql_cri_is_visible)
			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_is_unique), query_language_names.ql_cri_is_unique)
			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_true), query_language_names.ql_cri_true)
			l_hash_table.put (agent new_normal_criterion (feature_scope, query_language_names.ql_cri_is_from_any), query_language_names.ql_cri_is_from_any)

			l_hash_table.put (agent new_name_criterion (feature_scope, query_language_names.ql_cri_name_is), query_language_names.ql_cri_name_is)
			l_hash_table.put (agent new_name_criterion (feature_scope, query_language_names.ql_cri_text_contain), query_language_names.ql_cri_text_contain)

			l_hash_table.put (agent new_domain_criterion (feature_scope, query_language_names.ql_cri_ancestor_is), query_language_names.ql_cri_ancestor_is)
			l_hash_table.put (agent new_domain_criterion (feature_scope, query_language_names.ql_cri_descendant_is), query_language_names.ql_cri_descendant_is)
			l_hash_table.put (agent new_domain_criterion (feature_scope, query_language_names.ql_cri_implementors_of), query_language_names.ql_cri_implementors_of)
			l_hash_table.put (agent new_domain_criterion (feature_scope, query_language_names.ql_cri_is_exported_to), query_language_names.ql_cri_is_exported_to)
			l_hash_table.put (agent new_domain_criterion (feature_scope, query_language_names.ql_cri_return_type_is), query_language_names.ql_cri_return_type_is)

			l_hash_table.put (agent new_caller_callee_criterion (feature_scope, query_language_names.ql_cri_callee_is), query_language_names.ql_cri_callee_is)
			l_hash_table.put (agent new_caller_callee_criterion (feature_scope, query_language_names.ql_cri_caller_is), query_language_names.ql_cri_caller_is)
			l_hash_table.put (agent new_caller_callee_criterion (feature_scope, query_language_names.ql_cri_assignee_is), query_language_names.ql_cri_assignee_is)
			l_hash_table.put (agent new_caller_callee_criterion (feature_scope, query_language_names.ql_cri_assigner_is), query_language_names.ql_cri_assigner_is)
			l_hash_table.put (agent new_caller_callee_criterion (feature_scope, query_language_names.ql_cri_createe_is), query_language_names.ql_cri_createe_is)
			l_hash_table.put (agent new_caller_callee_criterion (feature_scope, query_language_names.ql_cri_creator_is), query_language_names.ql_cri_creator_is)

			l_hash_table.put (agent new_nary_criterion (feature_scope, query_language_names.ql_cri_and), query_language_names.ql_cri_and)
			l_hash_table.put (agent new_nary_criterion (feature_scope, query_language_names.ql_cri_or), query_language_names.ql_cri_or)

			l_hash_table.put (agent new_value_criterion (feature_scope, query_language_names.ql_cri_value_of_metric_is), query_language_names.ql_cri_value_of_metric_is)

			l_hash_table.put (agent new_external_command_criterion (feature_scope, query_language_names.ql_cri_is_satisfied_by), query_language_names.ql_cri_is_satisfied_by)
		end

	initialize_argument_criteria
			-- Initialize argument criteria.
		local
			l_hash_table: HASH_TABLE [FUNCTION [EB_METRIC_CRITERION], STRING]
		do
			create l_hash_table.make (10)
			criterion_table.put (l_hash_table, argument_scope)

			l_hash_table.put (agent new_normal_criterion (argument_scope, query_language_names.ql_cri_false), query_language_names.ql_cri_false)
			l_hash_table.put (agent new_normal_criterion (argument_scope, query_language_names.ql_cri_is_compiled), query_language_names.ql_cri_is_compiled)
			l_hash_table.put (agent new_normal_criterion (argument_scope, query_language_names.ql_cri_is_visible), query_language_names.ql_cri_is_visible)
			l_hash_table.put (agent new_normal_criterion (argument_scope, query_language_names.ql_cri_is_immediate), query_language_names.ql_cri_is_immediate)
			l_hash_table.put (agent new_normal_criterion (argument_scope, query_language_names.ql_cri_true), query_language_names.ql_cri_true)

			l_hash_table.put (agent new_name_criterion (argument_scope, query_language_names.ql_cri_name_is), query_language_names.ql_cri_name_is)
			l_hash_table.put (agent new_name_criterion (argument_scope, query_language_names.ql_cri_text_contain), query_language_names.ql_cri_text_contain)

			l_hash_table.put (agent new_nary_criterion (argument_scope, query_language_names.ql_cri_and), query_language_names.ql_cri_and)
			l_hash_table.put (agent new_nary_criterion (argument_scope, query_language_names.ql_cri_or), query_language_names.ql_cri_or)

			l_hash_table.put (agent new_value_criterion (argument_scope, query_language_names.ql_cri_value_of_metric_is), query_language_names.ql_cri_value_of_metric_is)

			l_hash_table.put (agent new_external_command_criterion (argument_scope, query_language_names.ql_cri_is_satisfied_by), query_language_names.ql_cri_is_satisfied_by)
		end

	initialize_local_criteria
			-- Initialize local criteria.
		local
			l_hash_table: HASH_TABLE [FUNCTION [EB_METRIC_CRITERION], STRING]
		do
			create l_hash_table.make (10)
			criterion_table.put (l_hash_table, local_scope)

			l_hash_table.put (agent new_normal_criterion (local_scope, query_language_names.ql_cri_false), query_language_names.ql_cri_false)
			l_hash_table.put (agent new_normal_criterion (local_scope, query_language_names.ql_cri_is_compiled), query_language_names.ql_cri_is_compiled)
			l_hash_table.put (agent new_normal_criterion (local_scope, query_language_names.ql_cri_is_immediate), query_language_names.ql_cri_is_immediate)
			l_hash_table.put (agent new_normal_criterion (local_scope, query_language_names.ql_cri_is_used), query_language_names.ql_cri_is_used)
			l_hash_table.put (agent new_normal_criterion (local_scope, query_language_names.ql_cri_is_visible), query_language_names.ql_cri_is_visible)
			l_hash_table.put (agent new_normal_criterion (local_scope, query_language_names.ql_cri_true), query_language_names.ql_cri_true)

			l_hash_table.put (agent new_name_criterion (local_scope, query_language_names.ql_cri_name_is), query_language_names.ql_cri_name_is)
			l_hash_table.put (agent new_name_criterion (local_scope, query_language_names.ql_cri_text_contain), query_language_names.ql_cri_text_contain)

			l_hash_table.put (agent new_nary_criterion (local_scope, query_language_names.ql_cri_and), query_language_names.ql_cri_and)
			l_hash_table.put (agent new_nary_criterion (local_scope, query_language_names.ql_cri_or), query_language_names.ql_cri_or)

			l_hash_table.put (agent new_value_criterion (local_scope, query_language_names.ql_cri_value_of_metric_is), query_language_names.ql_cri_value_of_metric_is)

			l_hash_table.put (agent new_external_command_criterion (local_scope, query_language_names.ql_cri_is_satisfied_by), query_language_names.ql_cri_is_satisfied_by)
		end

	initialize_assertion_criteria
			-- Initialize assertion criteria.
		local
			l_hash_table: HASH_TABLE [FUNCTION [EB_METRIC_CRITERION], STRING]
		do
			create l_hash_table.make (20)
			criterion_table.put (l_hash_table, assertion_scope)

			l_hash_table.put (agent new_normal_criterion (assertion_scope, query_language_names.ql_cri_false), query_language_names.ql_cri_false)
			l_hash_table.put (agent new_normal_criterion (assertion_scope, query_language_names.ql_cri_has_expression), query_language_names.ql_cri_has_expression)
			l_hash_table.put (agent new_normal_criterion (assertion_scope, query_language_names.ql_cri_has_tag), query_language_names.ql_cri_has_tag)
			l_hash_table.put (agent new_normal_criterion (assertion_scope, query_language_names.ql_cri_is_compiled), query_language_names.ql_cri_is_compiled)
			l_hash_table.put (agent new_normal_criterion (assertion_scope, query_language_names.ql_cri_is_ensure), query_language_names.ql_cri_is_ensure)
			l_hash_table.put (agent new_normal_criterion (assertion_scope, query_language_names.ql_cri_is_ensure_then), query_language_names.ql_cri_is_ensure_then)
			l_hash_table.put (agent new_normal_criterion (assertion_scope, query_language_names.ql_cri_is_immediate), query_language_names.ql_cri_is_immediate)
			l_hash_table.put (agent new_normal_criterion (assertion_scope, query_language_names.ql_cri_is_invariant), query_language_names.ql_cri_is_invariant)
			l_hash_table.put (agent new_normal_criterion (assertion_scope, query_language_names.ql_cri_is_postcondition), query_language_names.ql_cri_is_postcondition)
			l_hash_table.put (agent new_normal_criterion (assertion_scope, query_language_names.ql_cri_is_precondition), query_language_names.ql_cri_is_precondition)
			l_hash_table.put (agent new_normal_criterion (assertion_scope, query_language_names.ql_cri_is_require), query_language_names.ql_cri_is_require)
			l_hash_table.put (agent new_normal_criterion (assertion_scope, query_language_names.ql_cri_is_require_else), query_language_names.ql_cri_is_require_else)
			l_hash_table.put (agent new_normal_criterion (assertion_scope, query_language_names.ql_cri_is_visible), query_language_names.ql_cri_is_visible)
			l_hash_table.put (agent new_normal_criterion (assertion_scope, query_language_names.ql_cri_true), query_language_names.ql_cri_true)

			l_hash_table.put (agent new_name_criterion (assertion_scope, query_language_names.ql_cri_name_is), query_language_names.ql_cri_name_is)
			l_hash_table.put (agent new_name_criterion (assertion_scope, query_language_names.ql_cri_text_contain), query_language_names.ql_cri_text_contain)

			l_hash_table.put (agent new_nary_criterion (assertion_scope, query_language_names.ql_cri_and), query_language_names.ql_cri_and)
			l_hash_table.put (agent new_nary_criterion (assertion_scope, query_language_names.ql_cri_or), query_language_names.ql_cri_or)

			l_hash_table.put (agent new_value_criterion (assertion_scope, query_language_names.ql_cri_value_of_metric_is), query_language_names.ql_cri_value_of_metric_is)

			l_hash_table.put (agent new_external_command_criterion (assertion_scope, query_language_names.ql_cri_is_satisfied_by), query_language_names.ql_cri_is_satisfied_by)
		end

	initialize_line_criteria
			-- Initialize line criteria.
		local
			l_hash_table: HASH_TABLE [FUNCTION [EB_METRIC_CRITERION], STRING]
		do
			create l_hash_table.make (10)
			criterion_table.put (l_hash_table, line_scope)

			l_hash_table.put (agent new_normal_criterion (line_scope, query_language_names.ql_cri_false), query_language_names.ql_cri_false)
			l_hash_table.put (agent new_normal_criterion (line_scope, query_language_names.ql_cri_is_blank), query_language_names.ql_cri_is_blank)
			l_hash_table.put (agent new_normal_criterion (line_scope, query_language_names.ql_cri_is_comment), query_language_names.ql_cri_is_comment)
			l_hash_table.put (agent new_normal_criterion (line_scope, query_language_names.ql_cri_is_implementation_comment), query_language_names.ql_cri_is_implementation_comment)
			l_hash_table.put (agent new_normal_criterion (line_scope, query_language_names.ql_cri_is_compiled), query_language_names.ql_cri_is_compiled)
			l_hash_table.put (agent new_normal_criterion (line_scope, query_language_names.ql_cri_true), query_language_names.ql_cri_true)

			l_hash_table.put (agent new_name_criterion (line_scope, query_language_names.ql_cri_name_is), query_language_names.ql_cri_name_is)
			l_hash_table.put (agent new_name_criterion (line_scope, query_language_names.ql_cri_text_contain), query_language_names.ql_cri_text_contain)

			l_hash_table.put (agent new_nary_criterion (line_scope, query_language_names.ql_cri_and), query_language_names.ql_cri_and)
			l_hash_table.put (agent new_nary_criterion (line_scope, query_language_names.ql_cri_or), query_language_names.ql_cri_or)

			l_hash_table.put (agent new_value_criterion (line_scope, query_language_names.ql_cri_value_of_metric_is), query_language_names.ql_cri_value_of_metric_is)

			l_hash_table.put (agent new_external_command_criterion (line_scope, query_language_names.ql_cri_is_satisfied_by), query_language_names.ql_cri_is_satisfied_by)
		end

invariant
	criterion_table_attached: criterion_table /= Void

note
        copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
