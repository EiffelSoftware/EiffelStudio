indexing
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

	on_process_directory (a_cluster: CONF_CLUSTER; a_path: STRING_8) is
			-- (Sub)directory a_path of a_cluster is processed.
		require
			a_cluster_not_void: a_cluster /= Void
			a_path_not_void: a_path /= Void
		do
		end

feature -- Processing

	process_cluster_recursive (a_path: STRING; a_cluster: CONF_CLUSTER; a_file_rule: CONF_FILE_RULE) is
			-- Recursively process `a_path'.
		require
			a_file_rule_not_void: a_file_rule /= Void
			a_cluster_not_void: a_cluster /= Void
			a_path_not_void: a_path /= Void
		local
			l_dir: KL_DIRECTORY
			l_files: ARRAY [STRING]
			l_subdirs: ARRAY [STRING]
			i, cnt: INTEGER
			l_name: STRING
			l_path: STRING
			l_cluster_separator: STRING
			l_full_path: STRING
		do
			l_cluster_separator := "/"
			on_process_directory (a_cluster, a_path)
			l_path := a_cluster.location.build_path (a_path, "")
			create l_dir.make (l_path)
			create l_full_path.make (128)

			if not l_dir.is_readable then
				add_and_raise_error (create {CONF_ERROR_DIR}.make (l_path, a_cluster.location.original_path + a_path, a_cluster.target.system.file_name))
			else
					-- look for classes in directory itself.
				l_files := l_dir.filenames
				if l_files = Void then
					add_and_raise_error (create {CONF_ERROR_DIR}.make (l_path, a_cluster.location.original_path + a_path, a_cluster.target.system.file_name))
				else
					from
						i := l_files.lower
						cnt := l_files.upper
					until
						i > cnt
					loop
						l_name := l_files [i]
							-- Reuse `l_full_path' string buffer.
						l_full_path.keep_head (0)
						l_full_path.append (a_path)
						l_full_path.append (l_cluster_separator)
						l_full_path.append (l_name)
						if a_file_rule.is_included (l_full_path) then
							handle_class (l_name, a_path, a_cluster)
						end
						i := i + 1
					end

						-- if we check recursive
					if a_cluster.is_recursive then
						l_subdirs := l_dir.directory_names
						from
							i := 1
							cnt := l_subdirs.count
						until
							i > cnt
						loop
								-- Reuse `l_full_path' string buffer.
							l_full_path.keep_head (0)
							l_full_path.append (a_path)
							l_full_path.append (l_cluster_separator)
							l_full_path.append (l_subdirs [i])
							if a_file_rule.is_included (l_full_path) then
									-- We need a copy of the string as it is stored as a reference indirectly from this routine.
								process_cluster_recursive (l_full_path.string, a_cluster, a_file_rule)
							end
							i := i + 1
						end
					end
				end
			end
		end

	handle_class (a_file, a_path: STRING_8; a_cluster: CONF_CLUSTER) is
			-- Handle class in `a_file' with `a_path' in `a_cluster'
		deferred
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
