note
	description: "[
					Object that represents a value tester to test if a given is satisfied by given criteria
					The criterion is given like:
						(value > value1) or (value = value2) or (value = value3)
					And value1, value2, value3 are called base values, each base value is retrieved by a value retriever.
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_VALUE_TESTER

inherit
	EB_METRIC_VISITABLE

	EB_METRIC_SHARED

create
	make

feature{NONE} -- Initialization

	make
			-- Initialize.
		do
			create {LINKED_LIST [TUPLE [EB_METRIC_VALUE_RETRIEVER, INTEGER]]} criteria_internal.make
		end

feature -- Testing

	is_satisfied_by (a_value: DOUBLE; a_ql_domain: QL_DOMAIN): BOOLEAN
			-- Is Current tester satisfied by `a_value'?
		require
			a_ql_domain_attached: a_ql_domain /= Void
		do
			if is_anded then
				Result := criteria.for_all (agent is_criterion_satisfied (?, a_value, a_ql_domain))
			else
				Result := criteria.there_exists (agent is_criterion_satisfied (?, a_value, a_ql_domain))
			end
		end

	is_satisfied_by_domain (a_value: DOUBLE; a_domain: EB_METRIC_DOMAIN): BOOLEAN
			-- Is Current tester satisfied by `a_value'?
			-- This is used to check warnings in metric archive node.
			-- `a_domain' is the input domain used to calculate that archive node.
		require
			a_domain_attached: a_domain /= Void
		do
			if is_anded then
				Result := criteria.for_all (agent is_criterion_satisfied_with_domain (?, a_value, a_domain))
			else
				Result := criteria.there_exists (agent is_criterion_satisfied_with_domain (?, a_value, a_domain))
			end
		end

feature -- Access

	criteria: LIST [TUPLE [a_value_retriever: EB_METRIC_VALUE_RETRIEVER; a_criterion_type: INTEGER]]
			-- Criteria set in Current tester
		do
			Result := criteria_internal
		ensure
			result_attached: Result /= Void
		end

	visitable_name: STRING_GENERAL
			-- Name of current visitable item
		do
			Result := metric_names.l_value_tester
		end

feature -- Status report

	is_anded: BOOLEAN
			-- Is sub criteria "anded" together?

	is_ored: BOOLEAN
			-- Is sub criteria "ored" together?
		do
			Result := not is_anded
		ensure
			good_result: Result = not is_anded
		end

feature -- Setting

	enable_anded
			-- Enable that sub criteria are "anded" together.
		do
			is_anded := True
		ensure
			is_anded: is_anded
		end

	enable_ored
			-- Enable that sub criteria are "ored" together.
		do
			is_anded := False
		ensure
			is_ored: is_ored
		end

	set_criteria (a_criteria: LIST [TUPLE [a_value_retriever: EB_METRIC_VALUE_RETRIEVER; a_criterion_type: INTEGER]])
			-- Set `criteria' with `a_criteria'.
		do
			criteria_internal.wipe_out
			if a_criteria /= Void then
				criteria_internal.append (a_criteria)
			end
		end

	insert_criterion (a_criterion: TUPLE [a_value_retriever: EB_METRIC_VALUE_RETRIEVER; a_criterion_type: INTEGER])
			-- Insert `a_criterion' into `criteria'.
		require
			a_criterion_attached: a_criterion /= Void
		do
			criteria_internal.extend (a_criterion)
		end

feature -- Process

	process (a_visitor: EB_METRIC_VISITOR)
			-- Process current using `a_visitor'.
		do
			a_visitor.process_value_tester (Current)
		end

feature{NONE} -- Implementation

	equal_to_agent (a_value, a_base_value: DOUBLE): BOOLEAN
			-- Tester to test if `a_value' is equal to `a_base_value'
		do
			Result := a_value = a_base_value
		end

	not_equal_to_agent (a_value, a_base_value: DOUBLE): BOOLEAN
			-- Tester to test if `a_value' is not equal to `a_base_value'
		do
			Result := a_value /= a_base_value
		end

	less_than_agent (a_value, a_base_value: DOUBLE): BOOLEAN
			-- Tester to test if `a_value' is less than `a_base_value'
		do
			Result := a_value < a_base_value
		end

	less_than_equal_to_agent (a_value, a_base_value: DOUBLE): BOOLEAN
			-- Tester to test if `a_value' is less than or equal to `a_base_value'
		do
			Result := a_value <= a_base_value
		end

	greater_than_agent (a_value, a_base_value: DOUBLE): BOOLEAN
			-- Tester to test if `a_value' is greater than `a_base_value'
		do
			Result := a_value > a_base_value
		end

	greater_than_equal_to_agent (a_value, a_base_value: DOUBLE): BOOLEAN
			-- Tester to test if `a_value' is greater than or equal to `a_base_value'
		do
			Result := a_value >= a_base_value
		end

	tester_table: HASH_TABLE [FUNCTION [ANY, TUPLE [DOUBLE, DOUBLE], BOOLEAN], INTEGER]
			-- Table of tester agents.
			-- Key is criterion type, and value is agent for that type.
		once
			create Result.make (6)
			Result.put (agent equal_to_agent, equal_to_type)
			Result.put (agent not_equal_to_agent, not_equal_to_type)
			Result.put (agent less_than_agent, less_than_type)
			Result.put (agent less_than_equal_to_agent, less_than_equal_to_type)
			Result.put (agent greater_than_agent, greater_than_type)
			Result.put (agent greater_than_equal_to_agent, greater_than_equal_to_type)
		ensure
			result_attached: Result /= Void
		end

	criteria_internal: like criteria
			-- Implementation of `criteria'

	is_criterion_satisfied (a_criterion: TUPLE [a_value_retriever: EB_METRIC_VALUE_RETRIEVER; a_criterion_type: INTEGER]; a_value: DOUBLE; a_ql_domain: QL_DOMAIN): BOOLEAN
			-- Is `a_agent' satisfied by `a_crterion' and `a_value'?
		require
			a_criterion_attached: a_criterion /= Void
			a_ql_domain_attached: a_ql_domain /= Void
		do
			Result := tester_table.item (a_criterion.a_criterion_type).item ([a_value, a_criterion.a_value_retriever.value (a_ql_domain)])
		end

	is_criterion_satisfied_with_domain (a_criterion: TUPLE [a_value_retriever: EB_METRIC_VALUE_RETRIEVER; a_criterion_type: INTEGER]; a_value: DOUBLE; a_domain: EB_METRIC_DOMAIN): BOOLEAN
			-- Is `a_agent' satisfied by `a_crterion' and `a_value'?
		require
			a_criterion_attached: a_criterion /= Void
			a_domain_attached: a_domain /= Void
		do
			Result := tester_table.item (a_criterion.a_criterion_type).item ([a_value, a_criterion.a_value_retriever.value_with_domain (a_domain)])
		end

invariant
	criteria_internal_attached: criteria_internal /= Void

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
