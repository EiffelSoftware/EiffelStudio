note
	description: "Factory to produce criteria with target scope"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_TARGET_CRITERION_FACTORY

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

	make
			-- Initialize.
		do
			create agent_table.make (4)
			agent_table.put (agent new_false_criterion, c_false)
			agent_table.put (agent new_is_compiled_criterion, c_is_compiled)
			agent_table.put (agent new_true_criterion, c_true)
			agent_table.put (agent new_name_is_criterion, c_name_is)
			agent_table.put (agent new_value_criterion, c_value_of_metric_is)
			agent_table.put (agent new_value_criterion, c_is_satisfied_by)

			create name_table.make (4)
			name_table.put (c_false, query_language_names.ql_cri_false)
			name_table.put (c_true, query_language_names.ql_cri_true)
			name_table.put (c_is_compiled, query_language_names.ql_cri_is_compiled)
			name_table.put (c_name_is, query_language_names.ql_cri_name_is)
			name_table.put (c_value_of_metric_is, query_language_names.ql_cri_value_of_metric_is)
			name_table.put (c_is_satisfied_by, query_language_names.ql_cri_is_satisfied_by)
		end

feature{NONE} -- Implementation

	criterion_type: QL_TARGET_CRITERION
			-- Criterion anchor type

	item_type: QL_TARGET
			-- Item anchor type

	simple_criterion_type: QL_SIMPLE_TARGET_CRITERION
			-- Simple criterion type

feature{NONE} -- New criterion

	new_false_criterion: QL_SIMPLE_TARGET_CRITERION
			-- New criterion that always returns False.
		do
			create Result.make (agent false_agent, False)
		ensure
			result_attached: Result /= Void
		end

	new_is_compiled_criterion: QL_SIMPLE_TARGET_CRITERION
			-- New criterion to test if a target is compiled
		do
			create Result.make (agent is_compiled_agent, False)
		ensure
			result_attached: Result /= Void
		end

	new_true_criterion: QL_SIMPLE_TARGET_CRITERION
			-- New criterion that always returns True (tautology criterion)
		do
			create Result.make (agent true_agent, False)
		ensure
			result_attached: Result /= Void
		end

	new_name_is_criterion (a_name: STRING; a_case_sensitive: BOOLEAN; a_matching_strategy: INTEGER): QL_TARGET_NAME_IS_CRI
			-- New {QL_TARGET_NAME_IS_CRI} criterion.
		require
			a_name_attached: a_name /= Void
		do
			create Result.make_with_setting (a_name, a_case_sensitive, a_matching_strategy)
		ensure
			result_attached: Result /= Void
		end

	new_value_criterion (a_evaluate_value_func: FUNCTION [ANY, TUPLE [QL_ITEM], BOOLEAN]): like simple_criterion_type
			-- New value criterion
		require
			a_evaluate_value_func_attached: a_evaluate_value_func /= Void
		do
			create Result.make (agent value_criterion_evalaute_agent ({QL_TARGET}?, a_evaluate_value_func), False)
		end

feature -- Criterion index

	c_false: INTEGER = 1
	c_true: INTEGER = 2
	c_name_is: INTEGER = 3
	c_is_compiled: INTEGER = 4
	c_value_of_metric_is: INTEGER = 5
	c_is_satisfied_by: INTEGER = 6

feature{NONE} -- Implementation

	false_agent (a_item: QL_TARGET): BOOLEAN
			-- Agent that always returns False.
			-- Require compiled: False
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
		end

	true_agent (a_item: QL_TARGET): BOOLEAN
			-- Agent that always returns True (tautology criterion)
			-- Require compiled: False
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := True
		end

	is_compiled_agent (a_item: QL_TARGET): BOOLEAN
			-- Agent to test if `a_item' is compiled
			-- Require compiled: False
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			Result := a_item.is_compiled
		end

note
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
