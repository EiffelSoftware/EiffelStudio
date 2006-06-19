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
			criterion_type
		end

	QL_SHARED_CLASS_RELATION

create
	make

feature{NONE} -- Initialization

	make is
			-- Initialize.
		do
			create agent_table.make (45)
			agent_table.put (agent new_false_criterion, c_false)
			agent_table.put (agent new_has_bottom_indexing_criterion, c_has_bottom_indexing)
			agent_table.put (agent new_has_indexing_criterion, c_has_indexing)
			agent_table.put (agent new_has_invariant_criterion, c_has_invariant)
			agent_table.put (agent new_has_top_indexing_criterion, c_has_top_indexing)
			agent_table.put (agent new_is_compiled_criterion, c_is_compiled)
			agent_table.put (agent new_is_deferred_criterion, c_is_deferred)
			agent_table.put (agent new_is_effective_criterion, c_is_effective)
			agent_table.put (agent new_is_enum_criterion, c_is_enum)
			agent_table.put (agent new_is_expanded_criterion, c_is_expanded)
			agent_table.put (agent new_is_external_criterion, c_is_external)
			agent_table.put (agent new_is_frozen_criterion, c_is_frozen)
			agent_table.put (agent new_is_generic_criterion, c_is_generic)
			agent_table.put (agent new_is_obsolete_criterion, c_is_obsolete)
			agent_table.put (agent new_is_precompiled_criterion, c_is_precompiled)
			agent_table.put (agent new_true_criterion, c_true)

			agent_table.put (agent new_is_valid_criterion, c_is_valid)
			agent_table.put (agent new_is_always_compiled_criterion, c_is_always_compiled)
			agent_table.put (agent new_is_partial_criterion, c_is_partial)
			agent_table.put (agent new_is_read_only_criterion, c_is_read_only)
			agent_table.put (agent new_is_overriden_criterion, c_is_overriden)
			agent_table.put (agent new_is_overrider_criterion, c_is_overrider)
			agent_table.put (agent new_is_visible_criterion, c_is_visible)

			agent_table.put (agent new_path_in_criterion, c_path_in)
			agent_table.put (agent new_path_is_criterion, c_path_is)
			agent_table.put (agent new_ancestor_is_criterion, c_descendant_is)
			agent_table.put (agent new_proper_ancestor_is_criterion, c_proper_descendant_is)
			agent_table.put (agent new_parent_is_criterion, c_heir_is)
			agent_table.put (agent new_indirect_parent_is_criterion, c_indirect_heir_is)
			agent_table.put (agent new_descendant_is_criterion, c_ancestor_is)
			agent_table.put (agent new_proper_descendant_is_criterion, c_proper_ancestor_is)
			agent_table.put (agent new_heir_is_criterion, c_parent_is)
			agent_table.put (agent new_indirect_heir_is_criterion, c_indirect_parent_is)
			agent_table.put (agent new_supplier_criterion, c_client_is)
			agent_table.put (agent new_indirect_supplier_criterion, c_indirect_client_is)
			agent_table.put (agent new_client_criterion, c_supplier_is)
			agent_table.put (agent new_indirect_client_criterion, c_indirect_supplier_is)

			agent_table.put (agent new_name_is_criterion, c_name_is)
			agent_table.put (agent new_text_contain_criterion, c_text_contain)
			agent_table.put (agent new_top_indexing_contain_criterion, c_top_indexing_contain)
			agent_table.put (agent new_bottom_indexing_contain_criterion, c_bottom_indexing_contain)
			agent_table.put (agent new_indexing_contain_criterion, c_indexing_contain)
			agent_table.put (agent new_top_indexing_has_tag_criterion, c_top_indexing_has_tag)
			agent_table.put (agent new_bottom_indexing_has_tag_criterion, c_bottom_indexing_has_tag)
			agent_table.put (agent new_indexing_has_tag_criterion, c_indexing_has_tag)

			create name_table.make (45)
			name_table.put (c_false, query_language_names.ql_cri_false)
			name_table.put (c_has_bottom_indexing, query_language_names.ql_cri_has_bottom_indexing)
			name_table.put (c_has_indexing, query_language_names.ql_cri_has_indexing)
			name_table.put (c_has_invariant, query_language_names.ql_cri_has_invariant)
			name_table.put (c_has_top_indexing, query_language_names.ql_cri_has_top_indexing)
			name_table.put (c_is_compiled, query_language_names.ql_cri_is_compiled)
			name_table.put (c_is_deferred, query_language_names.ql_cri_is_deferred)
			name_table.put (c_is_effective, query_language_names.ql_cri_is_effective)
			name_table.put (c_is_enum, query_language_names.ql_cri_is_enum)
			name_table.put (c_is_expanded, query_language_names.ql_cri_is_expanded)
			name_table.put (c_is_external, query_language_names.ql_cri_is_external)
			name_table.put (c_is_frozen, query_language_names.ql_cri_is_frozen)
			name_table.put (c_is_generic, query_language_names.ql_cri_is_generic)
			name_table.put (c_is_obsolete, query_language_names.ql_cri_is_obsolete)
			name_table.put (c_is_precompiled, query_language_names.ql_cri_is_precompiled)
			name_table.put (c_true, query_language_names.ql_cri_true)
			name_table.put (c_is_visible, query_language_names.ql_cri_is_visible)
			name_table.put (c_is_valid, query_language_names.ql_cri_is_valid)
			name_table.put (c_is_always_compiled, query_language_names.ql_cri_is_always_compiled)
			name_table.put (c_is_partial, query_language_names.ql_cri_is_partial)
			name_table.put (c_is_read_only, query_language_names.ql_cri_is_read_only)
			name_table.put (c_is_overriden, query_language_names.ql_cri_is_overriden)
			name_table.put (c_is_overrider, query_language_names.ql_cri_is_overrider)
			name_table.put (c_is_visible, query_language_names.ql_cri_is_visible)

			name_table.put (c_path_in, query_language_names.ql_cri_path_in)
			name_table.put (c_path_is, query_language_names.ql_cri_path_is)
			name_table.put (c_ancestor_is, query_language_names.ql_cri_ancestor_is)
			name_table.put (c_proper_ancestor_is, query_language_names.ql_cri_proper_ancestor_is)
			name_table.put (c_parent_is, query_language_names.ql_cri_parent_is)
			name_table.put (c_indirect_parent_is, query_language_names.ql_cri_indirect_parent_is)
			name_table.put (c_descendant_is, query_language_names.ql_cri_descendant_is)
			name_table.put (c_proper_descendant_is, query_language_names.ql_cri_proper_descendant_is)
			name_table.put (c_heir_is, query_language_names.ql_cri_heir_is)
			name_table.put (c_indirect_heir_is, query_language_names.ql_cri_indirect_heir_is)
			name_table.put (c_supplier_is, query_language_names.ql_cri_supplier_is)
			name_table.put (c_indirect_supplier_is, query_language_names.ql_cri_indirect_supplier_is)
			name_table.put (c_client_is, query_language_names.ql_cri_client_is)
			name_table.put (c_indirect_client_is, query_language_names.ql_cri_indirect_client_is)

			name_table.put (c_name_is, query_language_names.ql_cri_name_is)
			name_table.put (c_text_contain, query_language_names.ql_cri_text_contain)
			name_table.put (c_top_indexing_contain, query_language_names.ql_cri_top_indexing_contain)
			name_table.put (c_bottom_indexing_contain, query_language_names.ql_cri_bottom_indexing_contain)
			name_table.put (c_indexing_contain, query_language_names.ql_cri_indexing_contain)
			name_table.put (c_top_indexing_has_tag, query_language_names.ql_cri_top_indexing_has_tag)
			name_table.put (c_bottom_indexing_has_tag, query_language_names.ql_cri_bottom_indexing_has_tag)
			name_table.put (c_indexing_has_tag, query_language_names.ql_cri_indexing_has_tag)
		end


feature{NONE} -- Implementation

	criterion_type: QL_CLASS_CRITERION
			-- Criterion anchor type

feature{NONE} -- New criterion

	new_false_criterion: QL_SIMPLE_CLASS_CRITERION is
			-- New criterion that always returns False.
		do
			create Result.make (agent false_agent, False)
		ensure
			result_attached: Result /= Void
		end

	new_has_bottom_indexing_criterion: QL_SIMPLE_CLASS_CRITERION is
			-- New criterion to test if a class has bottom indexing
		do
			create Result.make (agent has_bottom_indexing_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_has_indexing_criterion: QL_SIMPLE_CLASS_CRITERION is
			-- New  criterion to test if a class has indexing clause
		do
			create Result.make (agent has_indexing_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_has_invariant_criterion: QL_SIMPLE_CLASS_CRITERION is
			-- New criterion to test if a class has invariant part
		do
			create Result.make (agent has_invariant_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_has_top_indexing_criterion: QL_SIMPLE_CLASS_CRITERION is
			-- New criterion to test if a class has top indexing
		do
			create Result.make (agent has_top_indexing_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_compiled_criterion: QL_SIMPLE_CLASS_CRITERION is
			-- New criterion to test if a class is compiled
		do
			create Result.make (agent is_compiled_agent, False)
		ensure
			result_attached: Result /= Void
		end

	new_is_deferred_criterion: QL_SIMPLE_CLASS_CRITERION is
			-- New criterion to test if a class is deferred
		do
			create Result.make (agent is_deferred_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_effective_criterion: QL_SIMPLE_CLASS_CRITERION is
			-- New criterion to test if a class is effective
		do
			create Result.make (agent is_effective_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_enum_criterion: QL_SIMPLE_CLASS_CRITERION is
			-- New criterion to test if a class is enum
		do
			create Result.make (agent is_enum_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_expanded_criterion: QL_SIMPLE_CLASS_CRITERION is
			-- New criterion to test if a class is expanded
		do
			create Result.make (agent is_expanded_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_external_criterion: QL_SIMPLE_CLASS_CRITERION is
			-- New criterion to test if a class is external.
		do
			create Result.make (agent is_external_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_frozen_criterion: QL_SIMPLE_CLASS_CRITERION is
			-- New criterion to test if a class is frozen
		do
			create Result.make (agent is_frozen_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_generic_criterion: QL_SIMPLE_CLASS_CRITERION is
			-- New criterion to test if a class is generic
		do
			create Result.make (agent is_generic_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_obsolete_criterion: QL_SIMPLE_CLASS_CRITERION is
			-- New criterion to test if a class is obsolete
		do
			create Result.make (agent is_obsolete_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_precompiled_criterion: QL_SIMPLE_CLASS_CRITERION is
			-- New criterion to test if a class is precompiled
		do
			create Result.make (agent is_precompiled_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_valid_criterion: QL_SIMPLE_CLASS_CRITERION is
			-- New criterion to test if a class is valid
		do
			create Result.make (agent is_valid_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_always_compiled_criterion: QL_SIMPLE_CLASS_CRITERION is
			-- New criterion to test if a class is always compiled
		do
			create Result.make (agent is_always_compiled_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_partial_criterion: QL_SIMPLE_CLASS_CRITERION is
			-- New criterion to test if a class is partial
		do
			create Result.make (agent is_partial_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_read_only_criterion: QL_SIMPLE_CLASS_CRITERION is
			-- New criterion to test if a class is read-only
		do
			create Result.make (agent is_read_only_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_overriden_criterion: QL_SIMPLE_CLASS_CRITERION is
			-- New criterion to test if a class is overriden
		do
			create Result.make (agent is_overriden_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_overrider_criterion: QL_SIMPLE_CLASS_CRITERION is
			-- New criterion to test if a class is overrider
		do
			create Result.make (agent is_overrider_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_visible_criterion: QL_SIMPLE_CLASS_CRITERION is
			-- New criterion to test if a class is visible
		do
			create Result.make (agent is_visible_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_true_criterion: QL_SIMPLE_CLASS_CRITERION is
			-- New criterion that always returns True (tautology criterion)
		do
			create Result.make (agent true_agent, False)
		ensure
			result_attached: Result /= Void
		end

	new_name_is_criterion (a_name: STRING; a_case_sensitive: BOOLEAN; a_identical: BOOLEAN): QL_CLASS_NAME_IS_CRI is
			-- New {QL_CLASS_NAME_IS_CRI} criterion.
		require
			a_name_attached: a_name /= Void
		do
			create Result.make_with_setting (a_name, a_case_sensitive, a_identical)
		ensure
			result_attached: Result /= Void
		end

	new_top_indexing_has_tag_criterion (a_name: STRING; a_case_sensitive: BOOLEAN; a_identical: BOOLEAN): QL_CLASS_TOP_INDEXING_HAS_TAG_CRI is
			-- New {QL_CLASS_NAME_IS_CRI} criterion.
		require
			a_name_attached: a_name /= Void
		do
			create Result.make_with_setting (a_name, a_case_sensitive, a_identical)
		ensure
			result_attached: Result /= Void
		end

	new_bottom_indexing_has_tag_criterion (a_name: STRING; a_case_sensitive: BOOLEAN; a_identical: BOOLEAN): QL_CLASS_BOTTOM_INDEXING_HAS_TAG_CRI is
			-- New {QL_CLASS_NAME_IS_CRI} criterion.
		require
			a_name_attached: a_name /= Void
		do
			create Result.make_with_setting (a_name, a_case_sensitive, a_identical)
		ensure
			result_attached: Result /= Void
		end

	new_indexing_has_tag_criterion (a_name: STRING; a_case_sensitive: BOOLEAN; a_identical: BOOLEAN): QL_CLASS_INDEXING_HAS_TAG_CRI is
			-- New {QL_CLASS_NAME_IS_CRI} criterion.
		require
			a_name_attached: a_name /= Void
		do
			create Result.make_with_setting (a_name, a_case_sensitive, a_identical)
		ensure
			result_attached: Result /= Void
		end

	new_top_indexing_contain_criterion (a_name: STRING; a_case_sensitive: BOOLEAN; a_identical: BOOLEAN): QL_CLASS_TOP_INDEXING_CONTAIN_CRI is
			-- New {QL_CLASS_NAME_IS_CRI} criterion.
		require
			a_name_attached: a_name /= Void
		do
			create Result.make_with_setting (a_name, a_case_sensitive, a_identical)
		ensure
			result_attached: Result /= Void
		end

	new_bottom_indexing_contain_criterion (a_name: STRING; a_case_sensitive: BOOLEAN; a_identical: BOOLEAN): QL_CLASS_BOTTOM_INDEXING_CONTAIN_CRI is
			-- New {QL_CLASS_NAME_IS_CRI} criterion.
		require
			a_name_attached: a_name /= Void
		do
			create Result.make_with_setting (a_name, a_case_sensitive, a_identical)
		ensure
			result_attached: Result /= Void
		end

	new_indexing_contain_criterion (a_name: STRING; a_case_sensitive: BOOLEAN; a_identical: BOOLEAN): QL_CLASS_INDEXING_CONTAIN_CRI is
			-- New {QL_CLASS_NAME_IS_CRI} criterion.
		require
			a_name_attached: a_name /= Void
		do
			create Result.make_with_setting (a_name, a_case_sensitive, a_identical)
		ensure
			result_attached: Result /= Void
		end

	new_path_in_criterion (a_path: STRING): QL_CLASS_PATH_IN_CRI is
			-- New {QL_CLASS_PATH_IN_CRI} criterion.
		require
			a_path_attached: a_path /= Void
		do
			create Result.make (a_path)
		ensure
			result_attached: Result /= Void
		end

	new_path_is_criterion (a_path: STRING): QL_CLASS_PATH_IS_CRI is
			-- New {QL_CLASS_PATH_IS_CRI} criterion.
		require
			a_path_attached: a_path /= Void
		do
			create Result.make (a_path)
		ensure
			result_attached: Result /= Void
		end

	new_text_contain_criterion (a_text: STRING; a_case_sensitive: BOOLEAN; a_identical: BOOLEAN): QL_CLASS_TEXT_CONTAIN_CRI is
			-- New {QL_CLASS_TEXT_CONTAIN_CRI} criterion.
		require
			a_text_attached: a_text /= Void
		do
			create Result.make_with_setting (a_text, a_case_sensitive, a_identical)
		ensure
			result_attached: Result /= Void
		end

	new_ancestor_is_criterion (a_domain: QL_DOMAIN): QL_CLASS_ANCESTOR_RELATION_CRI is
			-- New {QL_CLASS_ANCESTOR_RELATION_CRI} criterion.
		require
			a_domain_attached: a_domain /= Void
		do
			create Result.make (a_domain, class_ancestor_relation)
		ensure
			result_attached: Result /= Void
		end

	new_proper_ancestor_is_criterion (a_domain: QL_DOMAIN): QL_CLASS_ANCESTOR_RELATION_CRI is
			-- New {QL_CLASS_ANCESTOR_RELATION_CRI} criterion.
		require
			a_domain_attached: a_domain /= Void
		do
			create Result.make (a_domain, class_proper_ancestor_relation)
		ensure
			result_attached: Result /= Void
		end

	new_parent_is_criterion (a_domain: QL_DOMAIN): QL_CLASS_ANCESTOR_RELATION_CRI is
			-- New {QL_CLASS_ANCESTOR_RELATION_CRI} criterion.
		require
			a_domain_attached: a_domain /= Void
		do
			create Result.make (a_domain, class_parent_relation)
		ensure
			result_attached: Result /= Void
		end

	new_indirect_parent_is_criterion (a_domain: QL_DOMAIN): QL_CLASS_ANCESTOR_RELATION_CRI is
			-- New {QL_CLASS_ANCESTOR_RELATION_CRI} criterion.
		require
			a_domain_attached: a_domain /= Void
		do
			create Result.make (a_domain, class_indirect_parent_relation)
		ensure
			result_attached: Result /= Void
		end

	new_descendant_is_criterion (a_domain: QL_DOMAIN): QL_CLASS_DESCENDANT_RELATION_CRI is
			-- New {QL_CLASS_DESCENDANT_RELATION_CRI} criterion.
		require
			a_domain_attached: a_domain /= Void
		do
			create Result.make (a_domain, class_descendant_relation)
		ensure
			result_attached: Result /= Void
		end

	new_proper_descendant_is_criterion (a_domain: QL_DOMAIN): QL_CLASS_DESCENDANT_RELATION_CRI is
			-- New {QL_CLASS_DESCENDANT_RELATION_CRI} criterion.
		require
			a_domain_attached: a_domain /= Void
		do
			create Result.make (a_domain, class_proper_descendant_relation)
		ensure
			result_attached: Result /= Void
		end

	new_heir_is_criterion (a_domain: QL_DOMAIN): QL_CLASS_DESCENDANT_RELATION_CRI is
			-- New {QL_CLASS_DESCENDANT_RELATION_CRI} criterion.
		require
			a_domain_attached: a_domain /= Void
		do
			create Result.make (a_domain, class_heir_relation)
		ensure
			result_attached: Result /= Void
		end

	new_indirect_heir_is_criterion (a_domain: QL_DOMAIN): QL_CLASS_DESCENDANT_RELATION_CRI is
			-- New {QL_CLASS_DESCENDANT_RELATION_CRI} criterion.
		require
			a_domain_attached: a_domain /= Void
		do
			create Result.make (a_domain, class_indirect_heir_relation)
		ensure
			result_attached: Result /= Void
		end

	new_supplier_criterion (a_domain: QL_DOMAIN): QL_CLASS_SUPPLIER_RELATION_CRI is
			-- New {QL_CLASS_SUPPLIER_RELATION_CRI} criterion.
		require
			a_domain_attached: a_domain /= Void
		do
			create Result.make (a_domain, class_supplier_relation)
		ensure
			result_attached: Result /= Void
		end

	new_indirect_supplier_criterion (a_domain: QL_DOMAIN): QL_CLASS_SUPPLIER_RELATION_CRI is
			-- New {QL_CLASS_SUPPLIER_RELATION_CRI} criterion.
		require
			a_domain_attached: a_domain /= Void
		do
			create Result.make (a_domain, class_indirect_supplier_relation)
		ensure
			result_attached: Result /= Void
		end

	new_client_criterion (a_domain: QL_DOMAIN): QL_CLASS_CLIENT_RELATION_CRI is
			-- New {QL_CLASS_CLIENT_RELATION_CRI} criterion.
		require
			a_domain_attached: a_domain /= Void
		do
			create Result.make (a_domain, class_client_relation)
		ensure
			result_attached: Result /= Void
		end

	new_indirect_client_criterion (a_domain: QL_DOMAIN): QL_CLASS_CLIENT_RELATION_CRI is
			-- New {QL_CLASS_CLIENT_RELATION_CRI} criterion.
		require
			a_domain_attached: a_domain /= Void
		do
			create Result.make (a_domain, class_indirect_client_relation)
		ensure
			result_attached: Result /= Void
		end

feature -- Criterion index

	c_false,
	c_has_bottom_indexing,
	c_has_indexing,
	c_has_invariant,
	c_has_top_indexing,
	c_is_compiled,
	c_is_deferred,
	c_is_effective,
	c_is_enum,
	c_is_expanded,
	c_is_external,
	c_is_frozen,
	c_is_generic,
	c_is_obsolete,
	c_is_precompiled,
	c_true,
	c_name_is,
	c_top_indexing_has_tag,
	c_bottom_indexing_has_tag,
	c_indexing_has_tag,
	c_top_indexing_contain,
	c_bottom_indexing_contain,
	c_indexing_contain,
	c_path_in,
	c_path_is,
	c_text_contain,
	c_ancestor_is,
	c_proper_ancestor_is,
	c_parent_is,
	c_indirect_parent_is,
	c_descendant_is,
	c_proper_descendant_is,
	c_heir_is,
	c_indirect_heir_is,
	c_supplier_is,
	c_indirect_supplier_is,
	c_client_is,
	c_indirect_client_is,
	c_is_valid,
	c_is_always_compiled,
	c_is_partial,
	c_is_read_only,
	c_is_overriden,
	c_is_overrider,
	c_is_visible: INTEGER is unique;

feature{NONE} -- Implementation/Evaluate agent

	true_agent (a_item: QL_CLASS): BOOLEAN is
			-- Agent which always returns True. (Tautology criterion)
			-- Require compiled: False
		do
			Result := True
		end

	false_agent (a_item: QL_CLASS): BOOLEAN is
			-- Agent which always returns False.
			-- Require compiled: False
		do
		end

	has_bottom_indexing_agent (a_item: QL_CLASS): BOOLEAN is
			-- Agent to test if a class has bottom indexing clause
			-- Require compiled: True		
		do
			Result := a_item.is_compiled and then a_item.ast.bottom_indexes /= Void
		end

	has_top_indexing_agent (a_item: QL_CLASS): BOOLEAN is
			-- Agent to test if a class has top indexing clause
			-- Require compiled: True		
		do
			Result := a_item.is_compiled and then a_item.ast.top_indexes /= Void
		end

	has_indexing_agent (a_item: QL_CLASS): BOOLEAN is
			-- Agent to test if a class has indexing clause (top or bottom or both)
			-- Require compiled: True
		do
			Result := a_item.is_compiled and then (a_item.ast.top_indexes /= Void or a_item.ast.bottom_indexes /= Void)
		end

	has_invariant_agent (a_item: QL_CLASS): BOOLEAN is
			-- Agent to test if a class has invariant part
			-- Require compiled: True
		do
			Result := a_item.is_compiled and then a_item.class_c.has_invariant
		end

	is_compiled_agent (a_item: QL_CLASS): BOOLEAN is
			-- Agent to test if a class is compiled
			-- Require compiled: False
		do
			Result := a_item.is_compiled
		end

	is_deferred_agent (a_item: QL_CLASS): BOOLEAN is
			-- Agent to test if a class is deferred
			-- Require compiled: True
		do
			Result := a_item.is_compiled and then a_item.class_c.is_deferred
		end

	is_effective_agent (a_item: QL_CLASS): BOOLEAN is
			-- Agent to test if a class is effective
			-- Require compiled: True
		do
			Result := a_item.is_compiled and then not a_item.class_c.is_deferred
		end

	is_enum_agent (a_item: QL_CLASS): BOOLEAN is
			-- Agent to test if a class is enum
			-- Require compiled: True
		do
			Result := a_item.is_compiled and then a_item.class_c.is_enum
		end

	is_expanded_agent (a_item: QL_CLASS): BOOLEAN is
			-- Agent to test if a class is expanded
			-- Require compiled: True
		do
			Result := a_item.is_compiled and then a_item.class_c.is_expanded
		end

	is_external_agent (a_item: QL_CLASS): BOOLEAN is
			-- Agent to test if a class is external
			-- Require compiled: True
		do
			Result := a_item.is_compiled and then a_item.class_c.is_external
		end

	is_frozen_agent (a_item: QL_CLASS): BOOLEAN is
			-- Agent to test if a class is frozen
			-- Require compiled: True
		do
			Result := a_item.is_compiled and then a_item.class_c.is_frozen
		end

	is_generic_agent (a_item: QL_CLASS): BOOLEAN is
			-- Agent to test if a class is generic
			-- Require compiled: True
		do
			Result := a_item.is_compiled and then a_item.class_c.is_generic
		end

	is_obsolete_agent (a_item: QL_CLASS): BOOLEAN is
			-- Agent to test if a class is obsolete
			-- Require compiled: True
		do
			Result := a_item.is_compiled and then a_item.class_c.is_obsolete
		end

	is_precompiled_agent (a_item: QL_CLASS): BOOLEAN is
			-- Agent to test if a class is precompiled
			-- Require compiled: True
		do
			Result := a_item.is_compiled and then a_item.class_c.is_precompiled
		end

	is_valid_agent (a_item: QL_CLASS): BOOLEAN is
			-- Agent to test if a class is valid
			-- Require compiled: True
		do
			Result := a_item.is_compiled and then a_item.conf_class.is_valid
		end

	is_always_compiled_agent (a_item: QL_CLASS): BOOLEAN is
			-- Agent to test if a class is always compiled
			-- Require compiled: True
		do
			Result := a_item.is_compiled and then a_item.conf_class.is_always_compile
		end

	is_partial_agent (a_item: QL_CLASS): BOOLEAN is
			-- Agent to test if a class is partial
			-- Require compiled: True
		do
			Result := a_item.is_compiled and then a_item.conf_class.is_partial
		end

	is_read_only_agent (a_item: QL_CLASS): BOOLEAN is
			-- Agent to test if a class is read-only
			-- Require compiled: True
		do
			Result := a_item.is_compiled and then a_item.conf_class.is_read_only
		end

	is_overriden_agent (a_item: QL_CLASS): BOOLEAN is
			-- Agent to test if a class is overriden
			-- Require compiled: True
		do
			Result := a_item.is_compiled and then a_item.conf_class.is_overriden
		end

	is_overrider_agent (a_item: QL_CLASS): BOOLEAN is
			-- Agent to test if a class is overrider
			-- Require compiled: True
		do
			Result := a_item.is_compiled and then a_item.conf_class.does_override
		end

	is_visible_agent (a_item: QL_CLASS): BOOLEAN is
			-- Agent to test if a class is visible from its original generated level
		do
			Result := a_item.is_visible
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
