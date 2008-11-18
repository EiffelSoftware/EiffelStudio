indexing
	description: "[
					Helper for cluster name and path.
																	]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLUSTER_NAME_AND_PATH_HELPER

feature -- Query

	is_cluster_full_path_valid (a_full_cluster_name_and_path: STRING): BOOLEAN is
			-- Check if `a_full_cluster_name_and_path' valid.
		require
			not_void: a_full_cluster_name_and_path /= Void and then not a_full_cluster_name_and_path.is_empty
		local
			l_cluster_name_and_path: like split_cluster_name_and_path
			l_conf_groups: ARRAYED_SET [CONF_GROUP]
			l_project: SHARED_EIFFEL_PROJECT
		do
			create l_project

			l_cluster_name_and_path := split_cluster_name_and_path (a_full_cluster_name_and_path)
			l_conf_groups := l_project.eiffel_universe.group_of_name_recursive (l_cluster_name_and_path.cluster_name.as_lower)

			if l_conf_groups.count < 1 then
				Result := False
			else
				-- Check if the cluster path valid
				from
					l_conf_groups.start
				until
					l_conf_groups.after or Result
				loop
					Result := is_cluster_path_valid (l_conf_groups.item, l_cluster_name_and_path.cluster_path)

					l_conf_groups.forth
				end
			end
		end

	cluster_path_by_id_and_sub_path (a_cluster_id, a_cluster_sub_path: STRING): DIRECTORY_NAME is
			-- Query cluster directory name by `a_cluster' and `a_cluster_sub_path'
		require
			not_void: a_cluster_id /= Void and then not a_cluster_id.is_empty
			exists: has_cluster_id (a_cluster_id)
			not_void: a_cluster_sub_path /= Void
		local
			l_list: LIST [STRING]
		do
			create Result.make_from_string (id_solution.group_of_id (a_cluster_id).location.evaluated_directory)

			from
				l_list := list_of_cluster_path (a_cluster_sub_path)
				l_list.start
			until
				l_list.after
			loop
				Result.extend (l_list.item)
				l_list.forth
			end
		ensure
			not_void: Result /= Void
			valid: Result.is_valid
		end

	cluster_path (a_cluster_name_and_subpath: STRING): DIRECTORY_NAME is
			-- Query cluster's directory path
		require
			not_void: a_cluster_name_and_subpath /= Void and then not a_cluster_name_and_subpath.is_empty
			valid: is_cluster_full_path_valid (a_cluster_name_and_subpath)
		local
			l_conf_group: CONF_GROUP
		do
			l_conf_group := conf_group_of (a_cluster_name_and_subpath)
			if l_conf_group /= Void then
				Result := create {DIRECTORY_NAME}.make_from_string (l_conf_group.location.evaluated_directory)
			end
		ensure
			not_void: Result /= Void
			valid: Result.is_valid
		end

	conf_group_of (a_cluster_name_and_subpath: STRING): CONF_GROUP
			-- Find unique group information of `a_cluster_name_and_subpath'.
		require
			not_void: a_cluster_name_and_subpath /= Void and then not a_cluster_name_and_subpath.is_empty
			valid: is_cluster_full_path_valid (a_cluster_name_and_subpath)
		local
			l_shared: SHARED_EIFFEL_PROJECT
			l_cluster_name_and_path: like split_cluster_name_and_path
			l_set: ARRAYED_SET [CONF_GROUP]
			l_dir: DIRECTORY_NAME
		do
			l_cluster_name_and_path := split_cluster_name_and_path (a_cluster_name_and_subpath)

			create l_shared
			l_set := l_shared.eiffel_universe.group_of_name_recursive (l_cluster_name_and_path.cluster_name)
			from
				l_set.start
			until
				l_set.after or Result /= Void
			loop
				l_dir := create {DIRECTORY_NAME}.make_from_string (l_set.item.location.evaluated_directory)
				if is_cluster_path_same_as_directory_name (l_cluster_name_and_path.cluster_name, l_cluster_name_and_path.cluster_path, l_dir) then
					Result := l_set.item
				end
				-- FIXIT: Maybe there are more than one cluster?

				l_set.forth
			end
		ensure
			not_void: Result /= Void
			valid: Result.is_valid
		end

	cluster_separator: STRING is "/"
			-- Cluster separator.

	has_cluster_id (a_cluster_id: STRING): BOOLEAN is
			-- Does current system have the cluster which represented by `a_cluster_id'?
		do
			Result := id_solution.group_of_id (a_cluster_id) /= Void
		end

feature -- Command

	split_cluster_name_and_path (a_full_cluster_name: STRING): TUPLE [cluster_name, cluster_path: STRING] is
			-- Split cluster name and path from `a_full_cluster_name'.
		require
			not_void: a_full_cluster_name /= Void
		local
			l_list: LIST [STRING]
			l_path: STRING
			l_cluster_name: STRING
		do
			l_list := a_full_cluster_name.split (cluster_separator.item (1))
			l_cluster_name := l_list.first

			if l_list.count = 1 then
				l_path := ""
			else
				check larger_than_1: l_list.count > 1 end
				l_path := a_full_cluster_name.twin
				l_path.remove_substring (1, l_cluster_name.count)
			end

			Result := [l_cluster_name, l_path]
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- Implementation

	id_solution: EB_SHARED_ID_SOLUTION
			-- Id solution
		once
			create Result
		end

	is_cluster_path_same_as_directory_name (a_cluster_name, a_cluster_path: STRING; a_dir: DIRECTORY_NAME): BOOLEAN is
			-- If `a_cluster_path' same as `a_dir'
		require
			not_void: a_cluster_name /= Void and then not a_cluster_name.is_empty
			not_void: a_cluster_path /= Void
			not_void: a_dir /= Void and then a_dir.is_valid
		local
			l_tmp_dir: STRING
			l_start_index: INTEGER
			l_cluster_path_list: LIST [STRING]
			l_cluster_directory: DIRECTORY_NAME
			l_substring_start_index: INTEGER
		do
			l_tmp_dir := a_dir.twin

			l_substring_start_index := l_tmp_dir.count - a_cluster_name.count - a_cluster_path.count - 1 -- Add one for separator "/"
			l_start_index := l_tmp_dir.substring_index_in_bounds (a_cluster_name, l_substring_start_index, l_tmp_dir.count)
			if l_start_index < 1 then
				-- Don't found cluster name
				Result := False
			else
				-- Found cluster name, remove it.
				l_tmp_dir.remove_head (l_start_index + a_cluster_name.count)

				-- Check if path is same
				from
					create l_cluster_directory.make
					l_cluster_path_list := list_of_cluster_path (l_tmp_dir)
					l_cluster_path_list.start
				until
					l_cluster_path_list.after
				loop
					l_cluster_directory.extend (l_cluster_path_list.item)

					l_cluster_path_list.forth
				end
				Result := l_cluster_directory.string.same_string (a_cluster_path)
			end
		end

	list_of_cluster_path (a_cluster_path: STRING): LIST [STRING] is
			-- Split `a_cluster_path' to list.
		require
			not_void: a_cluster_path /= Void
		do
			Result := a_cluster_path.split (cluster_separator.item (1))
			remove_empty_strings (Result)
		ensure
			not_void: Result /= Void
		end

	is_cluster_path_valid (a_group: CONF_GROUP; a_path: STRING): BOOLEAN is
			-- Check if `a_path' exists in `a_group'.
		require
			not_void: a_group /= Void
			not_void: a_path /= Void
		local
			l_path_list: LIST [STRING]
			l_dir_name: DIRECTORY_NAME
			l_dir: DIRECTORY
		do
			l_path_list := list_of_cluster_path (a_path)

			create l_dir_name.make_from_string (a_group.location.evaluated_path)
			from
				l_path_list.start
			until
				l_path_list.after
			loop
				l_dir_name.extend (l_path_list.item_for_iteration)
				l_path_list.forth
			end

			create l_dir.make (l_dir_name)
			Result := l_dir.exists
			l_dir.dispose
		end

	remove_empty_strings (a_path: LIST [STRING]) is
			-- Remove emtpy strings in `a_path'.
		require
			not_void: a_path /= Void
		do
			from
				a_path.start
			until
				a_path.after
			loop
				if a_path.item_for_iteration.is_empty then
					a_path.remove
				else
					a_path.forth
				end
			end
		end

indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
