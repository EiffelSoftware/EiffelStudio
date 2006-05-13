indexing
	description: "Scope index in Eiffel query language"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_SHARED_SCOPE_CONSTANTS

inherit
	QL_SHARED_NAMES

feature -- Scope index

	quantity_scope_index: INTEGER is 1
			-- Scope index for quantity item

	line_scope_index: INTEGER is 2
			-- Scope index for line item

	local_scope_index: INTEGER is 3
			-- Scope index for local variable item

	argument_scope_index: INTEGER is 3
			-- Scope index for argument item

	assertion_scope_index: INTEGER is 3
			-- Scope index for assertion item

	feature_scope_index: INTEGER is 4
			-- Scope index for feature item

	generic_scope_index: INTEGER is 4
			-- Scope index for class generic

	class_scope_index: INTEGER is 5
			-- Scope index for class item

	group_scope_index: INTEGER is 6
			-- Scope index for group item

	target_scope_index: INTEGER is 7
			-- Scope index for target item

feature -- Scope names

	scope_names: HASH_TABLE [STRING, INTEGER] is
			-- Names for scopes
		once
			create Result.make (9)
			Result.put (query_language_names.ql_target, target_scope_index)
			Result.put (query_language_names.ql_group, group_scope_index)
			Result.put (query_language_names.ql_class, class_scope_index)
			Result.put (query_language_names.ql_feature, feature_scope_index)
			Result.put (query_language_names.ql_assertion, assertion_scope_index)
			Result.put (query_language_names.ql_local, local_scope_index)
			Result.put (query_language_names.ql_argument, argument_scope_index)
			Result.put (query_language_names.ql_line, line_scope_index)
			Result.put (query_language_names.ql_quantity, quantity_scope_index)
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
