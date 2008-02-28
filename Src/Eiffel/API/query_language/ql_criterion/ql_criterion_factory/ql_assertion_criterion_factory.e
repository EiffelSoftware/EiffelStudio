indexing
	description: "Factory to produce criteria with assertion scope"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_ASSERTION_CRITERION_FACTORY

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
			create agent_table.make (20)
			agent_table.put (agent new_false_criterion, c_false)
			agent_table.put (agent new_has_expression_criterion, c_has_expression)
			agent_table.put (agent new_has_tag_criterion, c_has_tag)
			agent_table.put (agent new_is_compiled_criterion, c_is_compiled)
			agent_table.put (agent new_is_ensure_criterion, c_is_ensure)
			agent_table.put (agent new_is_ensure_then_criterion, c_is_ensure_then)
			agent_table.put (agent new_is_immediate_criterion, c_is_immediate)
			agent_table.put (agent new_is_invariant_criterion, c_is_invariant)
			agent_table.put (agent new_is_postcondition_criterion, c_is_postcondition)
			agent_table.put (agent new_is_precondition_criterion, c_is_precondition)
			agent_table.put (agent new_is_require_criterion, c_is_require)
			agent_table.put (agent new_is_require_else_criterion, c_is_require_else)
			agent_table.put (agent new_is_visible_criterion, c_is_visible)
			agent_table.put (agent new_true_criterion, c_true)
			agent_table.put (agent new_name_is_criterion, c_name_is)
			agent_table.put (agent new_text_contain_criterion, c_text_contain)
			agent_table.put (agent new_value_criterion, c_value_of_metric_is)
			agent_table.put (agent new_value_criterion, c_is_satisfied_by)

			create name_table.make (20)
			name_table.put (c_false, query_language_names.ql_cri_false)
			name_table.put (c_has_expression, query_language_names.ql_cri_has_expression)
			name_table.put (c_has_tag, query_language_names.ql_cri_has_tag)
			name_table.put (c_is_compiled, query_language_names.ql_cri_is_compiled)
			name_table.put (c_is_ensure, query_language_names.ql_cri_is_ensure)
			name_table.put (c_is_ensure_then, query_language_names.ql_cri_is_ensure_then)
			name_table.put (c_is_immediate, query_language_names.ql_cri_is_immediate)
			name_table.put (c_is_invariant, query_language_names.ql_cri_is_invariant)
			name_table.put (c_is_postcondition, query_language_names.ql_cri_is_postcondition)
			name_table.put (c_is_precondition, query_language_names.ql_cri_is_precondition)
			name_table.put (c_is_require, query_language_names.ql_cri_is_require)
			name_table.put (c_is_require_else, query_language_names.ql_cri_is_require_else)
			name_table.put (c_is_visible, query_language_names.ql_cri_is_visible)
			name_table.put (c_true, query_language_names.ql_cri_true)
			name_table.put (c_name_is, query_language_names.ql_cri_name_is)
			name_table.put (c_text_contain, query_language_names.ql_cri_text_contain)
			name_table.put (c_value_of_metric_is, query_language_names.ql_cri_value_of_metric_is)
			name_table.put (c_is_satisfied_by, query_language_names.ql_cri_is_satisfied_by)
		end

feature{NONE} -- Implementation

	criterion_type: QL_ASSERTION_CRITERION
			-- Criterion anchor type

	item_type: QL_ASSERTION
			-- Item anchor type

	simple_criterion_type: QL_SIMPLE_ASSERTION_CRITERION
			-- Simple criterion type

feature{NONE} -- New criterion

	new_false_criterion: QL_SIMPLE_ASSERTION_CRITERION is
			-- New criterion that always return False
		do
			create Result.make (agent false_agent, False)
		ensure
			result_attached: Result /= Void
		end

	new_has_expression_criterion: QL_SIMPLE_ASSERTION_CRITERION is
			-- New criterion to test if an assertion has expression
		do
			create Result.make (agent has_expression_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_has_tag_criterion: QL_SIMPLE_ASSERTION_CRITERION is
			-- New criterion to test if an assertion has tag
		do
			create Result.make (agent has_tag_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_compiled_criterion: QL_SIMPLE_ASSERTION_CRITERION is
			-- New criterion to test if an assertion is compiled
		do
			create Result.make (agent is_compiled_agent, False)
		ensure
			result_attached: Result /= Void
		end

	new_is_ensure_criterion: QL_SIMPLE_ASSERTION_CRITERION is
			-- New criterion to test if an assertion is ensure
		do
			create Result.make (agent is_ensure_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_ensure_then_criterion: QL_SIMPLE_ASSERTION_CRITERION is
			-- New criterion to test if an assertion is ensure then
		do
			create Result.make (agent is_ensure_then_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_immediate_criterion: QL_SIMPLE_ASSERTION_CRITERION is
			-- New criterion to test if an assertion is immediate
		do
			create Result.make (agent is_immediate_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_invariant_criterion: QL_SIMPLE_ASSERTION_CRITERION is
			-- New criterion to test if an assertion is invariant
		do
			create Result.make (agent is_invariant_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_postcondition_criterion: QL_SIMPLE_ASSERTION_CRITERION is
			-- New criterion to test if an assertion is postcondition
		do
			create Result.make (agent is_postcondition_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_precondition_criterion: QL_SIMPLE_ASSERTION_CRITERION is
			-- New criterion to test if an assertion is precondition
		do
			create Result.make (agent is_precondition_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_require_criterion: QL_SIMPLE_ASSERTION_CRITERION is
			-- New criterion to test if an assertion is require
		do
			create Result.make (agent is_require_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_require_else_criterion: QL_SIMPLE_ASSERTION_CRITERION is
			-- New criterion to test if an assertion is require else
		do
			create Result.make (agent is_require_else_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_visible_criterion: QL_SIMPLE_ASSERTION_CRITERION is
			-- New criterion to test if an assertion is visible
		do
			create Result.make (agent is_visible_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_true_criterion: QL_SIMPLE_ASSERTION_CRITERION is
			-- New criterion that always returns True (tautology criterion)
		do
			create Result.make (agent true_agent, False)
		ensure
			result_attached: Result /= Void
		end

	new_name_is_criterion (a_name: STRING; a_case_sensitive: BOOLEAN; a_matching_strategy: INTEGER): QL_ASSERTION_NAME_IS_CRI is
			-- New {QL_ASSERTION_NAME_IS_CRI} criterion.
		require
			a_name_attached: a_name /= Void
		do
			create Result.make_with_setting (a_name, a_case_sensitive, a_matching_strategy)
		ensure
			result_attached: Result /= Void
		end

	new_text_contain_criterion (a_text: STRING; a_case_sensitive: BOOLEAN; a_matching_strategy: INTEGER): QL_ASSERTION_TEXT_CONTAIN_CRI is
			-- New {QL_ASSERTION_TEXT_CONTAIN_CRI} criterion.
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
			create Result.make (agent value_criterion_evalaute_agent ({QL_ASSERTION}?, a_evaluate_value_func), False)
		end

feature -- Criterion index

	c_false: INTEGER is 1
	c_has_expression: INTEGER is 2
	c_has_tag: INTEGER is 3
	c_is_compiled: INTEGER is 4
	c_is_ensure: INTEGER is 5
	c_is_ensure_then: INTEGER is 6
	c_is_immediate: INTEGER is 7
	c_is_invariant: INTEGER is 8
	c_is_postcondition: INTEGER is 9
	c_is_precondition: INTEGER is 10
	c_is_require: INTEGER is 11
	c_is_require_else: INTEGER is 12
	c_is_visible: INTEGER is 13
	c_true: INTEGER is 14
	c_name_is: INTEGER is 15
	c_text_contain: INTEGER is 16
	c_contain_ast: INTEGER is 17
	c_value_of_metric_is: INTEGER is 18
	c_is_satisfied_by: INTEGER is 19

feature{NONE} -- Implementation

	false_agent (a_item: QL_ASSERTION): BOOLEAN is
			-- Agent that always returns False.
			-- Require compiled: False
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
		end

	true_agent (a_item: QL_ASSERTION): BOOLEAN is
			-- Agent that always returns True (tautology criterion)
			-- Require compiled: False
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := True
		end

	is_compiled_agent (a_item: QL_ASSERTION): BOOLEAN is
			-- Agent to test if `a_item' is compiled
			-- Require compiled: False
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.is_compiled
		end

	has_expression_agent (a_item: QL_ASSERTION): BOOLEAN is
			-- Agent to test if `a_item' has expression
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.ast.expr /= Void
		end

	has_tag_agent (a_item: QL_ASSERTION): BOOLEAN is
			-- Agent to test if `a_item' has tag
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := not a_item.name.is_empty
		end

	is_ensure_agent (a_item: QL_ASSERTION): BOOLEAN is
			-- Agent to test if `a_item' is ensure
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.is_ensure
		end

	is_ensure_then_agent (a_item: QL_ASSERTION): BOOLEAN is
			-- Agent to test if `a_item' is ensure then
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.is_ensure_then
		end

	is_immediate_agent (a_item: QL_ASSERTION): BOOLEAN is
			-- Agent to test if `a_item' is immediate
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.is_immediate
		end

	is_invariant_agent (a_item: QL_ASSERTION): BOOLEAN is
			-- Agent to test if `a_item' is invariant
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.is_invariant
		end

	is_postcondition_agent (a_item: QL_ASSERTION): BOOLEAN is
			-- Agent to test if `a_item' is postcondition
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.is_postcondition
		end

	is_precondition_agent (a_item: QL_ASSERTION): BOOLEAN is
			-- Agent to test if `a_item' is precondition
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.is_precondition
		end

	is_require_agent (a_item: QL_ASSERTION): BOOLEAN is
			-- Agent to test if `a_item' is require
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.is_require
		end

	is_require_else_agent (a_item: QL_ASSERTION): BOOLEAN is
			-- Agent to test if `a_item' is require else
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.is_require_else
		end

	is_visible_agent (a_item: QL_ASSERTION): BOOLEAN is
			-- Agent to test if `a_item' is visible
			-- Require compiled: True
		require
			a_item_attached: a_item /= Void
			a_item_is_valid: a_item.is_valid_domain_item
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

