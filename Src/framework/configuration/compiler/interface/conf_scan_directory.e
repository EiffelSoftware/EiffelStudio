note
	description: "Scan and process a cluster directory."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONF_SCAN_DIRECTORY

inherit
	CONF_VISITOR

feature -- Event handling

	on_process_directory (a_cluster: CONF_CLUSTER; a_path: READABLE_STRING_32)
			-- (Sub)directory a_path of a_cluster is processed.
		require
			a_cluster_not_void: a_cluster /= Void
			a_path_not_void: a_path /= Void
		do
		end

feature -- Processing

	process_cluster_recursive (a_path: READABLE_STRING_32; a_cluster: CONF_CLUSTER; a_file_rule: CONF_FILE_RULE)
			-- Recursively process `a_path'.
		require
			a_file_rule_not_void: a_file_rule /= Void
			a_cluster_not_void: a_cluster /= Void
			a_path_not_void: a_path /= Void
		local
			l_name: STRING_32
			l_path: PATH
			l_cluster_separator: READABLE_STRING_32
			u: FILE_UTILITIES
			l_full_path: STRING_32
		do
			l_cluster_separator := {STRING_32} "/"
			on_process_directory (a_cluster, a_path)
			l_path := a_cluster.location.build_path (a_path, {STRING_32} "")

			if not attached u.file_names (l_path.name) as l_files then
				if not a_cluster.is_test_cluster then
					add_and_raise_error (create {CONF_ERROR_DIR}.make (l_path.name, a_cluster.location.original_path + a_path, a_cluster.target.system.file_name))
				end
			else
					-- look for classes in directory itself.
				across
					l_files as f
				loop
					l_name := f
					if l_name.count >= 2 and then a_file_rule.is_included (a_path, l_name) then
						handle_class (l_name, a_path, a_cluster)
					end
				end

					-- if we check recursive
				if a_cluster.is_recursive and then attached u.directory_names (l_path.name) as l_subdirs then
					across
						l_subdirs as d
					loop
						if a_file_rule.is_included (a_path, d) then
								-- Reuse `l_full_path' string buffer.
							create l_full_path.make (a_path.count + d.count + 1)
							if not a_path.is_empty then
								l_full_path.append (a_path)
								l_full_path.append (l_cluster_separator)
							end
							l_full_path.append (d)
								-- We need a copy of the string as it is stored as a reference indirectly from this routine.
							process_cluster_recursive (l_full_path, a_cluster, a_file_rule)
						end
					end
				end
			end
		end

	handle_class (a_file, a_path: READABLE_STRING_32; a_cluster: CONF_CLUSTER)
			-- Handle class in `a_file' with `a_path' in `a_cluster'
		require
			a_file_not_void: a_file /= Void
			a_file_enough_count: a_file.count >= 2
			a_path_not_void: a_path /= Void
			a_cluster_not_void: a_cluster /= Void
		deferred
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
