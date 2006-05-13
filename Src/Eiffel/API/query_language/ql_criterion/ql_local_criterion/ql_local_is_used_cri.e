indexing
	description: "Criterion to decide whether or not a local is used"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_LOCAL_IS_USED_CRI

inherit
	QL_LOCAL_CRITERION

feature -- Evaluate

	is_satisfied_by (a_item: QL_LOCAL): BOOLEAN is
			-- Evaluate `a_item'.
		local
			l_real_feature: QL_REAL_FEATURE
			l_checker: like usage_checker
		do
			l_real_feature ?= a_item.parent
			check l_real_feature /= Void end
			l_checker := usage_checker
			l_checker.process_ast (l_real_feature.ast, a_item.name)
			Result := l_checker.last_is_used
		end

feature{NONE} -- Implementation

	usage_checker: QL_LOCAL_USED_CHECKER is
			-- Checker to check if a local is used
		once
			create Result
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
