indexing
	description: "Factory to produce criteria with local scope"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_LOCAL_CRITERION_FACTORY

inherit
	QL_CRITERION_FACTORY
		redefine
			criterion_type,
			item_type,
			simple_criterion_type
		end
create
	make

feature{NONE} -- Initialization

	make is
			-- Initialize.
		do
			create agent_table.make (10)
			agent_table.put (agent new_false_criterion, c_false)
			agent_table.put (agent new_is_compiled_criterion, c_is_compiled)
			agent_table.put (agent new_is_in_immediate_feature_criterion, c_is_immediate)
			agent_table.put (agent new_is_used_criterion, c_is_used)
			agent_table.put (agent new_is_visible_criterion, c_is_visible)
			agent_table.put (agent new_true_criterion, c_true)
			agent_table.put (agent new_name_is_criterion, c_name_is)
			agent_table.put (agent new_text_contain_criterion, c_text_contain)
			agent_table.put (agent new_value_criterion, c_value_of_metric_is)
			agent_table.put (agent new_value_criterion, c_is_satisfied_by)

			create name_table.make (10)
			name_table.put (c_false, query_language_names.ql_cri_false)
			name_table.put (c_is_compiled, query_language_names.ql_cri_is_compiled)
			name_table.put (c_is_immediate, query_language_names.ql_cri_is_immediate)
			name_table.put (c_is_used, query_language_names.ql_cri_is_used)
			name_table.put (c_is_visible, query_language_names.ql_cri_is_visible)
			name_table.put (c_true, query_language_names.ql_cri_true)
			name_table.put (c_name_is, query_language_names.ql_cri_name_is)
			name_table.put (c_text_contain, query_language_names.ql_cri_text_contain)
			name_table.put (c_value_of_metric_is, query_language_names.ql_cri_value_of_metric_is)
			name_table.put (c_is_satisfied_by, query_language_names.ql_cri_is_satisfied_by)
		end

feature{NONE} -- Implementation

	criterion_type: QL_LOCAL_CRITERION
			-- Criterion anchor type

	item_type: QL_LOCAL
			-- Item anchor type

	simple_criterion_type: QL_SIMPLE_LOCAL_CRITERION
			-- Simple criterion type

feature{NONE} -- New criterion

	new_false_criterion: QL_SIMPLE_LOCAL_CRITERION is
			-- New criterion that always returns False
		do
			create Result.make (agent false_agent, False)
		ensure
			result_attached: Result /= Void
		end

	new_is_compiled_criterion: QL_SIMPLE_LOCAL_CRITERION is
			-- New criterion to test if a local is compiled
		do
			create Result.make (agent is_compiled_agent, False)
		ensure
			result_attached: Result /= Void
		end

	new_is_in_immediate_feature_criterion: QL_SIMPLE_LOCAL_CRITERION is
			-- New criterion to test if a local is in immediate feature
		do
			create Result.make (agent is_in_immediate_feature_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_visible_criterion: QL_SIMPLE_LOCAL_CRITERION is
			-- New criterion to test if a local is visible
		do
			create Result.make (agent is_visible_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_used_criterion: QL_LOCAL_IS_USED_CRI is
			-- New {QL_LOCAL_IS_USED_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_true_criterion: QL_SIMPLE_LOCAL_CRITERION is
			-- New criterion that always returns True (tautology criterion)
		do
			create Result.make (agent true_agent, False)
		ensure
			result_attached: Result /= Void
		end

	new_name_is_criterion (a_name: STRING; a_case_sensitive: BOOLEAN; a_matching_strategy: INTEGER): QL_LOCAL_NAME_IS_CRI is
			-- New {QL_LOCAL_NAME_IS_CRI} criterion.
		require
			a_name_attached: a_name /= Void
		do
			create Result.make_with_setting (a_name, a_case_sensitive, a_matching_strategy)
		ensure
			result_attached: Result /= Void
		end

	new_text_contain_criterion (a_text: STRING; a_case_sensitive: BOOLEAN; a_matching_strategy: INTEGER): QL_LOCAL_TEXT_CONTAIN_CRI is
			-- New {QL_LOCAL_TEXT_CONTAIN_CRI} criterion.
		require
			a_text_attached: a_text /= Void
		do
			create Result.make_with_setting (a_text, a_case_sensitive, a_matching_strategy)
		ensure
			result_attached: Result /= Void
		end

	new_value_criterion (a_evaluate_value_func: FUNCTION [ANY, TUPLE [QL_ITEM], BOOLEAN]): like simple_criterion_type is
			-- New value criterion
		require
			a_evaluate_value_func_attached: a_evaluate_value_func /= Void
		do
			create Result.make (agent value_criterion_evalaute_agent ({QL_LOCAL}?, a_evaluate_value_func), False)
		end

feature -- Criterion index

	c_false: INTEGER is 1
	c_is_compiled: INTEGER is 2
	c_is_used: INTEGER is 3
	c_is_visible: INTEGER is 4
	c_true: INTEGER is 5
	c_name_is: INTEGER is 6
	c_text_contain: INTEGER is 7
	c_is_immediate: INTEGER is 8
	c_contain_ast: INTEGER is 9
	c_value_of_metric_is: INTEGER is 10
	c_is_satisfied_by: INTEGER is 11

feature{NONE} -- Implementation

	false_agent (a_item: QL_LOCAL): BOOLEAN is
			-- Agent that always returns False.
			-- Require compiled: False
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
		end

	true_agent (a_item: QL_LOCAL): BOOLEAN is
			-- Agent that always returns True (tautology criterion)
			-- Require compiled: False
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := True
		end

	is_compiled_agent (a_item: QL_LOCAL): BOOLEAN is
			-- Agent to test if `a_item' is compiled
			-- Require compiled: False
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.is_compiled
		end

	is_visible_agent (a_item: QL_LOCAL): BOOLEAN is
			-- Agent to test if `a_item' is visible
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.is_visible
		end

	is_in_immediate_feature_agent (a_item: QL_LOCAL): BOOLEAN is
			-- Agent to test if `a_item' is in immediate feature
		require
			a_item_attached: a_item /= Void
			a_item_is_valid: a_item.is_valid_domain_item
		local
			l_feature: QL_FEATURE
		do
			l_feature ?= a_item.parent
			check l_feature /= Void end
			Result := l_feature.is_immediate
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
