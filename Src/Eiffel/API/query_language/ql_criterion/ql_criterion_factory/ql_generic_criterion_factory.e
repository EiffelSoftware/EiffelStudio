indexing
	description: "Factory to produce criteria with generic scope"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_GENERIC_CRITERION_FACTORY

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
			create agent_table.make (10)
			agent_table.put (agent new_false_criterion, c_false)
			agent_table.put (agent new_has_constraint_criterion, c_has_constraint)
			agent_table.put (agent new_has_creation_constraint_criterion, c_has_creation_constraint)
			agent_table.put (agent new_is_compiled_criterion, c_is_compiled)
			agent_table.put (agent new_is_expanded_criterion, c_is_expanded)
			agent_table.put (agent new_is_reference_criterion, c_is_reference)
			agent_table.put (agent new_true_criterion, c_true)
			agent_table.put (agent new_name_is_criterion, c_name_is)
			agent_table.put (agent new_text_contain_criterion, c_text_contain)

			create name_table.make (10)
			name_table.put (c_false, query_language_names.ql_cri_false)
			name_table.put (c_has_constraint, query_language_names.ql_cri_has_constraint)
			name_table.put (c_has_creation_constraint, query_language_names.ql_cri_has_creation_constraint)
			name_table.put (c_is_compiled, query_language_names.ql_cri_is_compiled)
			name_table.put (c_is_expanded, query_language_names.ql_cri_is_expanded)
			name_table.put (c_is_reference, query_language_names.ql_cri_is_reference)
			name_table.put (c_true, query_language_names.ql_cri_true)
			name_table.put (c_name_is, query_language_names.ql_cri_name_is)
			name_table.put (c_text_contain, query_language_names.ql_cri_text_contain)
		end

feature{NONE} -- Implementation

	criterion_type: QL_GENERIC_CRITERION
			-- Criterion anchor type

feature{NONE} -- New criterion

	new_false_criterion: QL_SIMPLE_GENERIC_CRITERION is
			-- New criterion that always returns False
		do
			create Result.make (agent false_agent, False)
		ensure
			result_attached: Result /= Void
		end

	new_has_constraint_criterion: QL_SIMPLE_GENERIC_CRITERION is
			-- New criterion to test if a generic has constraint
		do
			create Result.make (agent has_constraint_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_has_creation_constraint_criterion: QL_SIMPLE_GENERIC_CRITERION is
			-- New criterion to test if a generic has creation contraint
		do
			create Result.make (agent has_creation_constraint_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_compiled_criterion: QL_SIMPLE_GENERIC_CRITERION is
			-- New criterion to test if a generic is compiled
		do
			create Result.make (agent is_compiled_agent, False)
		ensure
			result_attached: Result /= Void
		end

	new_is_expanded_criterion: QL_SIMPLE_GENERIC_CRITERION is
			-- New criterion to test if a generic is expanded
		do
			create Result.make (agent is_expanded_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_is_reference_criterion: QL_SIMPLE_GENERIC_CRITERION is
			-- New criterion to test if a generic is reference
		do
			create Result.make (agent is_reference_agent, True)
		ensure
			result_attached: Result /= Void
		end

	new_true_criterion: QL_SIMPLE_GENERIC_CRITERION is
			-- New criterion that always returns True (tautology criterion)
		do
			create Result.make (agent true_agent, False)
		ensure
			result_attached: Result /= Void
		end

	new_name_is_criterion (a_name: STRING; a_case_sensitive: BOOLEAN; a_identical: BOOLEAN): QL_GENERIC_NAME_IS_CRI is
			-- New {QL_GENERIC_NAME_IS_CRI} criterion.
		require
			a_name_attached: a_name /= Void
		do
			create Result.make_with_setting (a_name, a_case_sensitive, a_identical)
		ensure
			result_attached: Result /= Void
		end

	new_text_contain_criterion (a_text: STRING; a_case_sensitive: BOOLEAN; a_identical: BOOLEAN): QL_GENERIC_TEXT_CONTAIN_CRI is
			-- New {QL_GENERIC_TEXT_CONTAIN_CRI} criterion.
		require
			a_text_attached: a_text /= Void
		do
			create Result.make_with_setting (a_text, a_case_sensitive, a_identical)
		ensure
			result_attached: Result /= Void
		end

feature -- Criterion index

	c_false,
	c_has_constraint,
	c_has_creation_constraint,
	c_is_compiled,
	c_is_expanded,
	c_is_reference,
	c_true,
	c_name_is,
	c_text_contain: INTEGER is unique;

feature{NONE} -- Implementation

	false_agent (a_item: QL_GENERIC): BOOLEAN is
			-- Agent that always returns False.
			-- Require compiled: False
		do
		end

	true_agent (a_item: QL_GENERIC): BOOLEAN is
			-- Agent that always returns True (tautology criterion)
			-- Require compiled: False
		do
			Result := True
		end

	is_compiled_agent (a_item: QL_GENERIC): BOOLEAN is
			-- Agent to test if `a_item' is compiled
			-- Require compiled: False
		do
			Result := a_item.is_compiled
		end

	has_constraint_agent (a_item: QL_GENERIC): BOOLEAN is
			-- Agent to test if `a_item' has constaint
			-- Require compiled: True
		do
			Result := a_item.has_constraint
		end

	has_creation_constraint_agent (a_item: QL_GENERIC): BOOLEAN is
			-- Agent to test if `a_item' has creation constaint
			-- Require compiled: True
		do
			Result := a_item.has_creation_constraint
		end

	is_expanded_agent (a_item: QL_GENERIC): BOOLEAN is
			-- Agent to test if `a_item' is expanded
			-- Require compiled: True
		do
			Result := a_item.is_expanded
		end

	is_reference_agent (a_item: QL_GENERIC): BOOLEAN is
			-- Agent to test if `a_item' is reference
			-- Require compiled: True
		do
			Result := a_item.is_reference
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
