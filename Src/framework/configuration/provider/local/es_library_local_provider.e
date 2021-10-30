note
	date: "$Date$"
	revision: "$Revision$"

class
	ES_LIBRARY_LOCAL_PROVIDER

inherit
	ES_LIBRARY_CACHING_CONF_SYSTEM_VIEW_PROVIDER

	CONF_VALIDITY

feature -- Access

	identifier: STRING = "local"
			-- Provider identifier.

	description: detachable READABLE_STRING_32
			-- Optional description
		do
			Result := {STRING_32} "Libraries installed locally with Eiffel Studio."
		end

	no_cached_libraries (a_query: detachable READABLE_STRING_GENERAL; a_target: CONF_TARGET): LIST [CONF_SYSTEM_VIEW]
			-- A set of libraries configurations to display in the dialog.
			-- Indexed by location.
		local
			l_libs: like library_locations
		do
			if is_eiffel_layout_defined then
				l_libs := library_locations (a_target)
				create {ARRAYED_LIST [CONF_SYSTEM_VIEW]} Result.make (l_libs.count)
				across
					l_libs as ic
				loop
					if attached conf_system_from (a_target, ic, True) as cfg then
						Result.force (cfg)
					end
				end
			else
				create {ARRAYED_LIST [CONF_SYSTEM_VIEW]} Result.make (0)
			end
		end

	cache_name (a_target: CONF_TARGET): STRING
		do
			if is_dotnet (a_target) then
				Result := "configuration_libraries_dotnet.cache"
			else
				Result := "configuration_libraries.cache"
			end
		end

feature {NONE} -- Access

	library_locations (a_target: CONF_TARGET): SEARCH_TABLE [STRING_32]
			-- A set of libraries.
		require
			is_eiffel_layout_defined: is_eiffel_layout_defined
		local
			l_dirs: like lookup_directories
		do
			l_dirs := lookup_directories
			create Result.make (l_dirs.count)
			across l_dirs as ic loop
				scan_library_location_to (a_target, ic.path, ic.depth, Result)
			end
		ensure
			result_attached: Result /= Void
		end

	scan_library_location_to (a_target: CONF_TARGET; a_path: IMMUTABLE_STRING_32; a_depth: INTEGER; a_table: like library_locations)
			-- Add library from `a_path' to `a_table'.
		local
			l_real_path: PATH
			l_real_path_count: INTEGER
			l_dir: DIRECTORY
			l_libraries: STRING_TABLE [BOOLEAN]
			l_lib_path: STRING_32
		do
			l_real_path := real_directory_path (a_target, a_path)
			create l_dir.make_with_path (l_real_path)
			if l_dir.is_readable then
				create l_libraries.make (10)
				add_configs_in_directory (l_dir, a_depth, l_libraries)

				l_real_path_count := l_real_path.name.count
				across l_libraries as ic_libs loop
						-- If the config file was using some environment variable, we just
						-- replace the computed path with what was specified in the config file
						-- for the current entry of `ic'.
					l_lib_path := @ ic_libs.key.as_string_32.twin
					l_lib_path.replace_substring (a_path, 1, l_real_path_count)
					a_table.put (l_lib_path)
				end
			end
		end

	lookup_directories: ARRAYED_LIST [TUPLE [path: STRING_32; depth: INTEGER]]
			-- A list of lookup directories
		require
			is_eiffel_layout_defined: is_eiffel_layout_defined
		local
			l_filename: detachable PATH
			l_file: RAW_FILE
		do
			create Result.make (10)

			l_filename := eiffel_layout.libraries_config_name
			create l_file.make_with_path (l_filename)
			if l_file.exists then
				add_lookup_directories (l_filename.name, Result)
			end
			if eiffel_layout.is_user_files_supported then
				l_filename := eiffel_layout.user_priority_file_name (l_filename, True)
				if l_filename /= Void then
					l_file.reset_path (l_filename)
					if l_file.exists then
						add_lookup_directories (l_filename.name, Result)
					end
				end
			end

			if Result.is_empty then
					-- Extend the default library path
				Result.extend ([eiffel_layout.library_path.name.as_string_32, 4])
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	add_configs_in_directory (a_dir: DIRECTORY; a_depth: INTEGER; a_libraries: STRING_TABLE [BOOLEAN])
			-- Add config files in `a_path' to `a_libraries'.
			-- if `a_depth' is -1, scan all subdirectories without any depth limits.
		require
			a_dir_attached: attached a_dir
			a_dir_is_readable: a_dir.is_readable
			a_depth_big_enough: a_depth >= -1
			a_libraries_attached: attached a_libraries
		local
			l_file_name: PATH
			l_file: RAW_FILE
			l_entry: PATH
		do
			across a_dir.entries as l_entries loop
				l_entry := l_entries
				if l_entry.is_current_symbol or l_entry.is_parent_symbol then
					 -- Nothing to do
				else
					l_file_name := a_dir.path.extended_path (l_entry)
					create l_file.make_with_path (l_file_name)
					if l_file.exists then
						if l_file.is_directory then
							if a_depth = -1 or a_depth > 0 then
									-- Recurse
								add_configs_in_directory (create {DIRECTORY}.make_with_path (l_file_name), (a_depth - 1).max (-1), a_libraries)
							end
						elseif l_file.is_plain and then valid_config_extension (l_entry.name) then
								-- File is an ECF, we add it to `a_libraries'.
							a_libraries.put (True, l_file_name.name)
						end
					end
				end
			end
		end

	add_lookup_directories (a_path: STRING_32; a_list: ARRAYED_LIST [TUPLE [path: READABLE_STRING_GENERAL; depth: INTEGER]])
			-- Adds look up directories from a file located at `a_path' into `a_list'
		require
			a_path_attached: attached a_path
			not_a_path_is_empty: not a_path.is_empty
			a_path_exists: (create {RAW_FILE}.make_with_name (a_path)).exists
			a_list_attached: attached a_list
		local
			l_file: RAW_FILE
			l_line: STRING
			l_pos: INTEGER
			l_location: STRING
			l_depth_string: detachable STRING
			l_depth: INTEGER
		do
			create l_file.make_with_name (a_path)
			if l_file.is_readable then
				from l_file.open_read until l_file.end_of_file loop
					l_file.read_line
					l_line := l_file.last_string
					if l_line.is_empty then
							-- Ignore
					elseif l_line.starts_with ("--") then
							-- Ignore comment
					else
						l_line.left_adjust
						l_line.right_adjust
						l_pos := l_line.last_index_of ('%T', l_line.count)
						if l_pos > 1 then
							l_location := l_line.substring (1, l_pos - 1)
							l_location.right_adjust
							if l_pos < l_line.count then
								l_depth_string := l_line.substring (l_pos + 1, l_line.count)
								l_depth_string.left_adjust
								l_depth_string.right_adjust
							end
						else
							l_location := l_line
						end
						l_depth := 1 -- Default
						if l_depth_string /= Void then
							if l_depth_string.is_integer then
								l_depth := l_depth_string.to_integer
							elseif l_depth_string.is_case_insensitive_equal_general ("*") then
								l_depth := -1
							end
						end
						--| FIXME: Unicode content of the file, does not provide Unicode file name
						--| unless it is UTF-8 encoded ...
						a_list.extend ([l_location.as_string_32, l_depth])
					end
				end
				l_file.close
			end
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
