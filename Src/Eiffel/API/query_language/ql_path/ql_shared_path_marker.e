indexing
	description: "Shared path marker"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_SHARED_PATH_MARKER

inherit
	QL_SHARED_NAMES

	QL_SHARED_SCOPES

feature -- Path marker

	target_path_marker: QL_PATH_MARKER is
			-- Path marker for target item
		once
			create Result.make (query_language_names.ql_target_path_opener, query_language_names.ql_target_path_closer)
		ensure
			result_attached: Result /= Void
		end

	group_path_marker: QL_PATH_MARKER is
			-- Path marker for group item
		once
			create Result.make (query_language_names.ql_group_path_opener, query_language_names.ql_group_path_closer)
		ensure
			result_attached: Result /= Void
		end

	class_path_marker: QL_PATH_MARKER is
			-- Path marker for class item
		once
			create Result.make (query_language_names.ql_class_path_opener, query_language_names.ql_class_path_closer)
		ensure
			result_attached: Result /= Void
		end

	generic_path_marker: QL_PATH_MARKER is
			-- Path marker for generic item
		once
			create Result.make (query_language_names.ql_generic_path_opener, query_language_names.ql_generic_path_closer)
		ensure
			result_attached: Result /= Void
		end

	feature_path_marker: QL_PATH_MARKER is
			-- Path marker for feature item
		once
			create Result.make (query_language_names.ql_feature_path_opener, query_language_names.ql_feature_path_closer)
		ensure
			result_attached: Result /= Void
		end

	argument_path_marker: QL_PATH_MARKER is
			-- Path marker for argument item
		once
			create Result.make (query_language_names.ql_argument_path_opener, query_language_names.ql_argument_path_closer)
		ensure
			result_attached: Result /= Void
		end

	local_path_marker: QL_PATH_MARKER is
			-- Path marker for local item
		once
			create Result.make (query_language_names.ql_local_path_opener, query_language_names.ql_local_path_closer)
		ensure
			result_attached: Result /= Void
		end

	line_path_marker: QL_PATH_MARKER is
			-- Path marker for line item
		once
			create Result.make (query_language_names.ql_line_path_opener, query_language_names.ql_line_path_closer)
		ensure
			result_attached: Result /= Void
		end

	quantity_path_marker: QL_PATH_MARKER is
			-- Path marker for quantity item
		once
			create Result.make (query_language_names.ql_quantity_path_opener, query_language_names.ql_quantity_path_closer)
		ensure
			result_attached: Result /= Void
		end

	assertion_path_marker: QL_ASSERTION_PATH_MARKER is
			-- Path marker for assertion item
		once
			create Result.make (query_language_names.ql_assertion_path_opener, query_language_names.ql_assertion_path_closer)
		ensure
			result_attached: Result /= Void
		end

	path_markers: HASH_TABLE [QL_PATH_MARKER, QL_SCOPE] is
			--  Path marker for every scope
		once
			create Result.make (10)
			Result.put (target_path_marker, target_scope)
			Result.put (group_path_marker, group_scope)
			Result.put (class_path_marker, class_scope)
			Result.put (generic_path_marker, generic_scope)
			Result.put (feature_path_marker, feature_scope)
			Result.put (local_path_marker, local_scope)
			Result.put (argument_path_marker, argument_scope)
			Result.put (assertion_path_marker, assertion_scope)
			Result.put (line_path_marker, line_scope)
			Result.put (quantity_path_marker, quantity_scope)
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
