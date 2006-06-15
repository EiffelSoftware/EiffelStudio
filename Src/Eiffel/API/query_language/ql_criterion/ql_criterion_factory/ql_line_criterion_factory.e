indexing
	description: "Factory to produce criteria with line scope"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_LINE_CRITERION_FACTORY

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
			agent_table.put (agent new_is_blank_criterion, c_is_blank)
			agent_table.put (agent new_is_comment_criterion, c_is_comment)
			agent_table.put (agent new_is_compiled_criterion, c_is_compiled)
			agent_table.put (agent new_true_criterion, c_true)
			agent_table.put (agent new_name_is_criterion, c_name_is)
			agent_table.put (agent new_text_contain_criterion, c_text_contain)

			create name_table.make (10)
			name_table.put (c_false, query_language_names.ql_cri_false)
			name_table.put (c_is_blank, query_language_names.ql_cri_is_blank)
			name_table.put (c_is_comment, query_language_names.ql_cri_is_comment)
			name_table.put (c_is_compiled, query_language_names.ql_cri_is_compiled)
			name_table.put (c_true, query_language_names.ql_cri_true)
			name_table.put (c_name_is, query_language_names.ql_cri_name_is)
			name_table.put (c_text_contain, query_language_names.ql_cri_text_contain)
		end

feature{NONE} -- Implementation

	criterion_type: QL_LINE_CRITERION
			-- Criterion anchor type

feature{NONE} -- New criterion

	new_false_criterion: QL_SIMPLE_LINE_CRITERION is
			-- New criterion that always returns False
		do
			create Result.make (agent false_agent, False)
		ensure
			result_attached: Result /= Void
		end

	new_is_blank_criterion: QL_LINE_IS_BLANK_CRI is
			-- New {QL_LINE_IS_BLANK_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_is_comment_criterion: QL_LINE_IS_COMMENT_CRI is
			-- New {QL_LINE_IS_COMMENT_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_is_compiled_criterion: QL_SIMPLE_LINE_CRITERION is
			-- New criterion to test if a line is compiled
		do
			create Result.make (agent is_compiled_agent, False)
		ensure
			result_attached: Result /= Void
		end

	new_true_criterion: QL_SIMPLE_LINE_CRITERION is
			-- New criterion that always returns True (tautology criterion)
		do
			create Result.make (agent true_agent, False)
		ensure
			result_attached: Result /= Void
		end

	new_name_is_criterion (a_name: STRING; a_case_sensitive: BOOLEAN; a_identical: BOOLEAN): QL_LINE_NAME_IS_CRI is
			-- New {QL_LINE_NAME_IS_CRI} criterion.
		require
			a_name_attached: a_name /= Void
		do
			create Result.make_with_setting (a_name, a_case_sensitive, a_identical)
		ensure
			result_attached: Result /= Void
		end

	new_text_contain_criterion (a_text: STRING; a_case_sensitive: BOOLEAN; a_identical: BOOLEAN): QL_LINE_TEXT_CONTAIN_CRI is
			-- New {QL_LINE_TEXT_CONTAIN_CRI} criterion.
		require
			a_text_attached: a_text /= Void
		do
			create Result.make_with_setting (a_text, a_case_sensitive, a_identical)
		ensure
			result_attached: Result /= Void
		end

feature -- Criterion index

	c_false,
	c_is_blank,
	c_is_comment,
	c_is_compiled,
	c_true,
	c_name_is,
	c_text_contain: INTEGER is unique

feature{NONE} -- Implementation

	false_agent (a_item: QL_LINE): BOOLEAN is
			-- Agent that always returns False.
			-- Require compiled: False
		do
		end

	true_agent (a_item: QL_LINE): BOOLEAN is
			-- Agent that always returns True (tautology criterion)
			-- Require compiled: False
		do
			Result := True
		end

	is_compiled_agent (a_item: QL_LINE): BOOLEAN is
			-- Agent to test if `a_item' is compiled
			-- Require compiled: False
		do
			Result := a_item.is_compiled
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
