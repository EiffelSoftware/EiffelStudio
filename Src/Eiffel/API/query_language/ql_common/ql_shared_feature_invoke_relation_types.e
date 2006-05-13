indexing
	description: "Feature caller types"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_SHARED_FEATURE_INVOKE_RELATION_TYPES

inherit
	QL_SHARED_NAMES

feature -- Feature caller types

	normal_caller: QL_FEATURE_CALLER_TYPE is
			-- Normal caller
		once
			create Result.make (query_language_names.ql_normal_feature_caller, 0)
		ensure
			result_attached: Result /= Void
			good_result: Result.type = 0
		end

	assigner_caller: QL_FEATURE_CALLER_TYPE is
			-- Assigner caller
		once
			create Result.make (query_language_names.ql_assigner_feature_caller, {DEPEND_UNIT}.is_in_assignment_flag)
		ensure
			result_attached: Result /= Void
			good_result: Result.type = {DEPEND_UNIT}.is_in_assignment_flag
		end

	creator_caller: QL_FEATURE_CALLER_TYPE is
			-- Creator caller
		once
			create Result.make (query_language_names.ql_creator_feature_caller, {DEPEND_UNIT}.is_in_creation_flag)
		ensure
			result_attached: Result /= Void
			good_result: Result.type = {DEPEND_UNIT}.is_in_creation_flag
		end

feature -- Feature callee types

	normal_callee: QL_FEATURE_CALLEE_TYPE is
			-- Normal callee
		once
			create Result.make (query_language_names.ql_normal_feature_callee, 0)
		ensure
			result_attached: Result /= Void
			good_result: Result.type = 0
		end

	assigner_callee: QL_FEATURE_CALLEE_TYPE is
			-- Assigner callee
		once
			create Result.make (query_language_names.ql_assigner_feature_callee, {DEPEND_UNIT}.is_in_assignment_flag)
		ensure
			result_attached: Result /= Void
			good_result: Result.type = {DEPEND_UNIT}.is_in_assignment_flag
		end

	creator_callee: QL_FEATURE_CALLEE_TYPE is
			-- Creator callee
		once
			create Result.make (query_language_names.ql_creator_feature_callee, {DEPEND_UNIT}.is_in_creation_flag)
		ensure
			result_attached: Result /= Void
			good_result: Result.type = {DEPEND_UNIT}.is_in_creation_flag
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
