indexing
	description: "Scope constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Tanit Talbi"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_SCOPE_INFO

inherit
	EB_CONSTANTS

feature -- Access

	Feature_scope, Class_scope, Cluster_scope, System_scope, Archive_scope: INTEGER is unique
		-- Order relation between indexes of available scopes.

feature -- Access

	scope_name (scope_index: INTEGER): STRING is
			-- Name for scope indicated by `scope_index'
		require
			scope_index_valid: scope_index >= feature_scope and scope_index <= archive_scope
		do
			Result := name_table.item (scope_index)
		ensure
			Result_not_void: Result /= Void
		end

feature -- Status reporting

	valid_scope_index (scope_index: INTEGER): BOOLEAN is
			-- Is `scope_index' valid?
		do
			Result := scope_index = feature_scope or
					 scope_index = class_scope or
					 scope_index = cluster_scope or
					 scope_index = system_scope or
					 scope_index = archive_scope
		ensure
			good_result: Result implies (
					 scope_index = feature_scope or
					 scope_index = class_scope or
					 scope_index = cluster_scope or
					 scope_index = system_scope or
					 scope_index = archive_scope)
		end


feature{NONE} -- Implementation

	name_table: HASH_TABLE [STRING, INTEGER] is
			-- Name table for scopes
		once
			create Result.make (5)
			Result.force (interface_names.metric_this_archive, archive_scope)
			Result.force (interface_names.metric_this_system, system_scope)
			Result.force (interface_names.metric_this_cluster, cluster_scope)
			Result.force (interface_names.metric_this_class, class_scope)
			Result.force (interface_names.metric_this_feature, feature_scope)
		ensure
			good_result: Result /= Void and then Result.count = 5
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

end -- class EB_METRIC_SCOPE_INFO
