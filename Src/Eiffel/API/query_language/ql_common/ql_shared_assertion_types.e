indexing
	description: "Shared assertion types used in Eiffel Query Language"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_SHARED_ASSERTION_TYPES

inherit
	QL_SHARED_NAMES

feature -- Assertion types

	require_type: QL_ASSERTION_TYPE is
			-- Require type
		once
			create Result.make (query_language_names.ql_require_assertion)
		ensure
			result_attached: Result /= Void
		end

	require_else_type: QL_ASSERTION_TYPE is
			-- Require else type
		once
			create Result.make (query_language_names.ql_require_else_assertion)
		ensure
			result_attached: Result /= Void
		end

	ensure_type: QL_ASSERTION_TYPE is
			-- Ensure type
		once
			create Result.make (query_language_names.ql_ensure_assertion)
		ensure
			result_attached: Result /= Void
		end

	ensure_then_type: QL_ASSERTION_TYPE is
			-- Ensure then type
		once
			create Result.make (query_language_names.ql_ensure_then_assertion)
		ensure
			result_attached: Result /= Void
		end

	invariant_type: QL_ASSERTION_TYPE is
			-- Invariant type
		once
			create Result.make (query_language_names.ql_invariant_assertion)
		ensure
			result_attached: Result /= Void
		end

	assertion_types: LIST [QL_ASSERTION_TYPE] is
			-- Shared assertion types
		once
			create {ARRAYED_LIST [QL_ASSERTION_TYPE]}Result.make (5)
			Result.extend (require_type)
			Result.extend (require_else_type)
			Result.extend (ensure_type)
			Result.extend (ensure_then_type)
			Result.extend (invariant_type)
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
