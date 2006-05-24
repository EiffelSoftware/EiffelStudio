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
			create criterion_table.make (10)
			criterion_table.put (agent new_false_criterion, query_language_names.ql_cri_false)
			criterion_table.put (agent new_is_blank_criterion, query_language_names.ql_cri_is_blank)
			criterion_table.put (agent new_is_comment_criterion, query_language_names.ql_cri_is_comment)
			criterion_table.put (agent new_is_compiled_criterion, query_language_names.ql_cri_is_compiled)
			criterion_table.put (agent new_true_criterion, query_language_names.ql_cri_true)
			criterion_table.put (agent new_name_is_criterion, query_language_names.ql_cri_name_is)
			criterion_table.put (agent new_text_contain_criterion, query_language_names.ql_cri_text_contain)
		end

feature{NONE} -- Implementation

	criterion_type: QL_LINE_CRITERION
			-- Criterion anchor type

feature{NONE} -- New criterion

	new_false_criterion: QL_LINE_FALSE_CRI is
			-- New {QL_LINE_FALSE_CRI} criterion.
		do
			create Result
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

	new_is_compiled_criterion: QL_LINE_IS_COMPILED_CRI is
			-- New {QL_LINE_IS_COMPILED_CRI} criterion.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_true_criterion: QL_LINE_TRUE_CRI is
			-- New {QL_LINE_TRUE_CRI} criterion.
		do
			create Result
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
