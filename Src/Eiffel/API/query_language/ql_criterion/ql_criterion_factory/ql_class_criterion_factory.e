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
			create criterion_table.make (32)
			criterion_table.put (agent new_false_criterion, query_language_names.ql_cri_false)
			criterion_table.put (agent new_has_bottom_indexing_criterion, query_language_names.ql_cri_has_bottom_indexing)
			criterion_table.put (agent new_has_indexing_criterion, query_language_names.ql_cri_has_indexing)
			criterion_table.put (agent new_has_invariant_criterion, query_language_names.ql_cri_has_invariant)
			criterion_table.put (agent new_has_top_indexing_criterion, query_language_names.ql_cri_has_top_indexing)
			criterion_table.put (agent new_is_compiled_criterion, query_language_names.ql_cri_is_compiled)
			criterion_table.put (agent new_is_deferred_criterion, query_language_names.ql_cri_is_deferred)
			criterion_table.put (agent new_is_effective_criterion, query_language_names.ql_cri_is_effective)
			criterion_table.put (agent new_is_enum_criterion, query_language_names.ql_cri_is_enum)
			criterion_table.put (agent new_is_expanded_criterion, query_language_names.ql_cri_is_expanded)
			criterion_table.put (agent new_is_external_criterion, query_language_names.ql_cri_is_external)
			criterion_table.put (agent new_is_frozen_criterion, query_language_names.ql_cri_is_frozen)
			criterion_table.put (agent new_is_generic_criterion, query_language_names.ql_cri_is_generic)
			criterion_table.put (agent new_is_obsolete_criterion, query_language_names.ql_cri_is_obsolete)
			criterion_table.put (agent new_is_precompiled_criterion, query_language_names.ql_cri_is_precompiled)
			criterion_table.put (agent new_true_criterion, query_language_names.ql_cri_true)

			criterion_table.put (agent new_path_in_criterion, query_language_names.ql_cri_path_in)
			criterion_table.put (agent new_path_is_criterion, query_language_names.ql_cri_path_is)
			criterion_table.put (agent new_ancestor_is_criterion, query_language_names.ql_cri_ancestor_is)
			criterion_table.put (agent new_proper_ancestor_is_criterion, query_language_names.ql_cri_proper_ancestor_is)
			criterion_table.put (agent new_parent_is_criterion, query_language_names.ql_cri_parent_is)
			criterion_table.put (agent new_indirect_parent_is_criterion, query_language_names.ql_cri_indirect_parent_is)
			criterion_table.put (agent new_descendant_is_criterion, query_language_names.ql_cri_descendant_is)
			criterion_table.put (agent new_proper_descendant_is_criterion, query_language_names.ql_cri_proper_descendant_is)
			criterion_table.put (agent new_heir_is_criterion, query_language_names.ql_cri_heir_is)
			criterion_table.put (agent new_indirect_heir_is_criterion, query_language_names.ql_cri_indirect_heir_is)
			criterion_table.put (agent new_supplier_criterion, query_language_names.ql_cri_supplier_is)
			criterion_table.put (agent new_indirect_supplier_criterion, query_language_names.ql_cri_indirect_supplier_is)
			criterion_table.put (agent new_client_criterion, query_language_names.ql_cri_client_is)
			criterion_table.put (agent new_indirect_client_criterion, query_language_names.ql_cri_indirect_client_is)

			criterion_table.put (agent new_name_is_criterion, query_language_names.ql_cri_name_is)
			criterion_table.put (agent new_text_contain_criterion, query_language_names.ql_cri_text_contain)
			criterion_table.put (agent new_top_indexing_contain_criterion, query_language_names.ql_cri_top_indexing_contain)
			criterion_table.put (agent new_bottom_indexing_contain_criterion, query_language_names.ql_cri_bottom_indexing_contain)
			criterion_table.put (agent new_indexing_contain_criterion, query_language_names.ql_cri_indexing_contain)
			criterion_table.put (agent new_top_indexing_has_tag_criterion, query_language_names.ql_cri_top_indexing_has_tag)
			criterion_table.put (agent new_bottom_indexing_has_tag_criterion, query_language_names.ql_cri_bottom_indexing_has_tag)
			criterion_table.put (agent new_indexing_has_tag_criterion, query_language_names.ql_cri_indexing_has_tag)
		end

feature{NONE} -- Implementation

	criterion_type: QL_CLASS_CRITERION
			-- Criterion anchor type

feature{NONE} -- New criterion

	new_false_criterion: QL_CLASS_FALSE_CRI is
			-- New {QL_CLASS_FALSE_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_has_bottom_indexing_criterion: QL_CLASS_HAS_BOTTOM_INDEXING_CRI is
			-- New {QL_CLASS_HAS_BOTTOM_INDEXING_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_has_indexing_criterion: QL_CLASS_HAS_INDEXING_CRI is
			-- New {QL_CLASS_HAS_INDEXING_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_has_invariant_criterion: QL_CLASS_HAS_INVARIANT_CRI is
			-- New {QL_CLASS_HAS_INVARIANT_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_has_top_indexing_criterion: QL_CLASS_HAS_TOP_INDEXING_CRI is
			-- New {QL_CLASS_HAS_TOP_INDEXING_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_is_compiled_criterion: QL_CLASS_IS_COMPILED_CRI is
			-- New {QL_CLASS_IS_COMPILED_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_is_deferred_criterion: QL_CLASS_IS_DEFERRED_CRI is
			-- New {QL_CLASS_IS_DEFERRED_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_is_effective_criterion: QL_CLASS_IS_EFFECTIVE_CRI is
			-- New {QL_CLASS_IS_EFFECTIVE_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_is_enum_criterion: QL_CLASS_IS_ENUM_CRI is
			-- New {QL_CLASS_IS_ENUM_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_is_expanded_criterion: QL_CLASS_IS_EXPANDED_CRI is
			-- New {QL_CLASS_IS_EXPANDED_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_is_external_criterion: QL_CLASS_IS_EXTERNAL_CRI is
			-- New {QL_CLASS_IS_EXTERNAL_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_is_frozen_criterion: QL_CLASS_IS_FROZEN_CRI is
			-- New {QL_CLASS_IS_FROZEN_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_is_generic_criterion: QL_CLASS_IS_GENERIC_CRI is
			-- New {QL_CLASS_IS_GENERIC_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_is_obsolete_criterion: QL_CLASS_IS_OBSOLETE_CRI is
			-- New {QL_CLASS_IS_OBSOLETE_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_is_precompiled_criterion: QL_CLASS_IS_PRECOMPILED_CRI is
			-- New {QL_CLASS_IS_PRECOMPILED_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_true_criterion: QL_CLASS_TRUE_CRI is
			-- New {QL_CLASS_TRUE_CRI} criterion.
		do
			create Result
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
