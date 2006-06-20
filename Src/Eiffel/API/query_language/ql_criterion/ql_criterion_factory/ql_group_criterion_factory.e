indexing
	description: "Factory to produce criteria with group scope"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_GROUP_CRITERION_FACTORY

inherit
	QL_CRITERION_FACTORY
		redefine
			criterion_type
		end
create
	make

feature{NONE} -- Initialization

	make is
			-- Initialize.
		do
			create agent_table.make (20)
			agent_table.put (agent new_false_criterion, c_false)
			agent_table.put (agent new_is_assembly_criterion, c_is_assembly)
			agent_table.put (agent new_is_cluster_criterion, c_is_cluster)
			agent_table.put (agent new_is_compiled_criterion, c_is_compiled)
			agent_table.put (agent new_is_library_criterion, c_is_library)
			agent_table.put (agent new_is_override_criterion, c_is_override)
			agent_table.put (agent new_is_valid_criterion, c_is_valid)
			agent_table.put (agent new_is_used_in_library_criterion, c_is_used_in_library)
			agent_table.put (agent new_is_valid_criterion, c_is_class_set)
			agent_table.put (agent new_true_criterion, c_true)
			agent_table.put (agent new_name_is_criterion, c_name_is)

			create name_table.make (20)
			name_table.put (c_false, query_language_names.ql_cri_false)
			name_table.put (c_is_assembly, query_language_names.ql_cri_is_assembly)
			name_table.put (c_is_cluster, query_language_names.ql_cri_is_cluster)
			name_table.put (c_is_compiled, query_language_names.ql_cri_is_compiled)
			name_table.put (c_is_library, query_language_names.ql_cri_is_library)
			name_table.put (c_is_override, query_language_names.ql_cri_is_override)
			name_table.put (c_is_valid, query_language_names.ql_cri_is_valid)
			name_table.put (c_is_used_in_library, query_language_names.ql_cri_is_used_in_library)
			name_table.put (c_is_class_set, query_language_names.ql_cri_is_class_set)
			name_table.put (c_true, query_language_names.ql_cri_true)
			name_table.put (c_name_is, query_language_names.ql_cri_name_is)
		end

feature{NONE} -- Implementation

	criterion_type: QL_GROUP_CRITERION
			-- Criterion anchor type

feature{NONE} -- New criterion

	new_false_criterion: QL_SIMPLE_GROUP_CRITERION is
			-- New criterion that always returns False
		do
			create Result.make (agent false_agent, False)
		ensure
			result_attached: Result /= Void
		end

	new_is_assembly_criterion: QL_SIMPLE_GROUP_CRITERION is
			-- New criterion to test if a group is assembly
		do
			create Result.make (agent is_assembly_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_cluster_criterion: QL_SIMPLE_GROUP_CRITERION is
			-- New criterion to test if a group is cluster
		do
			create Result.make (agent is_cluster_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_compiled_criterion: QL_SIMPLE_GROUP_CRITERION is
			-- New criterion to test if a group is compiled
		do
			create Result.make (agent is_compiled_agent, False)
		ensure
			result_attached: Result /= Void
		end

	new_is_library_criterion: QL_SIMPLE_GROUP_CRITERION is
			-- New criterion to test if a group is library
		do
			create Result.make (agent is_library_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_override_criterion: QL_SIMPLE_GROUP_CRITERION is
			-- New criterion to test if a group is override
		do
			create Result.make (agent is_override_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_valid_criterion: QL_SIMPLE_GROUP_CRITERION is
			-- New criterion to test if a group is valid
		do
			create Result.make (agent is_valid_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_used_in_library_criterion: QL_SIMPLE_GROUP_CRITERION is
			-- New criterion to test if a group is used in library
		do
			create Result.make (agent is_used_in_library_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_class_set_criterion: QL_SIMPLE_GROUP_CRITERION is
			-- New criterion to test if classes of a group are set
		do
			create Result.make (agent is_class_set_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_true_criterion: QL_SIMPLE_GROUP_CRITERION is
			-- New criterion that always returns True (tautology criterion)
		do
			create Result.make (agent true_agent, False)
		ensure
			result_attached: Result /= Void
		end

	new_name_is_criterion (a_name: STRING; a_case_sensitive: BOOLEAN; a_identical: BOOLEAN): QL_GROUP_NAME_IS_CRI is
			-- New {QL_GROUP_NAME_IS_CRI} criterion.
		require
			a_name_attached: a_name /= Void
		do
			create Result.make_with_setting (a_name, a_case_sensitive, a_identical)
		ensure
			result_attached: Result /= Void
		end

feature -- Criterion index

	c_false,
	c_is_assembly,
	c_is_cluster,
	c_is_compiled,
	c_is_library,
	c_is_override,
	c_true,
	c_name_is,
	c_is_class_set,
	c_is_valid,
	c_is_used_in_library: INTEGER is unique

feature{NONE} -- Implementation

	false_agent (a_item: QL_GROUP): BOOLEAN is
			-- Agent that always returns False.
			-- Require compiled: False
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
		end

	true_agent (a_item: QL_GROUP): BOOLEAN is
			-- Agent that always returns True (tautology criterion)
			-- Require compiled: False
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := True
		end

	is_compiled_agent (a_item: QL_GROUP): BOOLEAN is
			-- Agent to test if `a_item' is compiled
			-- Require compiled: False
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.is_compiled
		end

	is_assembly_agent (a_item: QL_GROUP): BOOLEAN is
			-- Agent to test if `a_item' is assembly
			-- Require compiled: True
		do
			Result := a_item.group.is_assembly
		end

	is_cluster_agent (a_item: QL_GROUP): BOOLEAN is
			-- Agent to test if `a_item' is cluster
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.group.is_cluster
		end

	is_library_agent (a_item: QL_GROUP): BOOLEAN is
			-- Agent to test if `a_item' is library
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.group.is_library
		end

	is_override_agent (a_item: QL_GROUP): BOOLEAN is
			-- Agent to test if `a_item' is override
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.group.is_override
		end

	is_valid_agent (a_item: QL_GROUP): BOOLEAN is
			-- Agent to test if `a_item' is valid
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.group.is_valid
		end

	is_used_in_library_agent (a_item: QL_GROUP): BOOLEAN is
			-- Agent to test if `a_item' is used in library
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.group.is_used_library
		end

	is_class_set_agent (a_item: QL_GROUP): BOOLEAN is
			-- Agent to test if classes in `a_item' are set
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.group.classes_set
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
