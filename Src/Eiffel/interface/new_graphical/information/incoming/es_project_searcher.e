note
	description: "Project searcher. Search project that match given system name or system UUID or target name or target UUID in given pathes."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_PROJECT_SEARCHER

feature -- Searcher

	search_project (a_path: STRING_32; a_system_name, a_system_uuid, a_target_name, a_target_uuid: detachable STRING)
			-- Search project
			-- `a_path' is in the format of "path1; path2; path3"
		require
			a_path_attached: a_path /= Void
		local
			l_splitted_path: LIST [STRING_32]
			l_path: STRING_32
			l_sep: CHARACTER_32
		do
			reset
			if not a_path.is_empty then
				system_name := a_system_name
				system_uuid := a_system_uuid
				target_name := a_target_name
				target_uuid := a_target_uuid
				if search_needed then
					l_splitted_path := a_path.split (';')
					if not l_splitted_path.is_empty then
						l_sep := (create {OPERATING_ENVIRONMENT}).directory_separator
						from
							l_splitted_path.start
						until
							l_splitted_path.after or project_found
						loop
							l_path := l_splitted_path.item_for_iteration
							l_path.left_adjust
							l_path.right_justify
								-- Remove the trailing directory separator.
								-- Or neither DIRECTORY nor KL_DIRECTORY can find it.
							if l_path.item (l_path.count) = l_sep then
								l_path.remove_tail (1)
							end
							if l_path /= Void then
								search_project_in_directory (l_path)
							end
							l_splitted_path.forth
						end
					end
				end
			end
		end

	search_projects (a_projects: ARRAYED_LIST [TUPLE [PATH, READABLE_STRING_32]]; a_system_name, a_system_uuid, a_target_name, a_target_uuid: detachable STRING)
			-- Search in projects
		local
			p: TUPLE [file: PATH; target: READABLE_STRING_32]
		do
			reset
			if not a_projects.is_empty then
				system_name := a_system_name
				system_uuid := a_system_uuid
				target_name := a_target_name
				target_uuid := a_target_uuid
				if search_needed then
					across
						a_projects as l_c
					until
						project_found
					loop
						p := l_c.item
						if attached p.file as l_file and then not l_file.is_empty then
							check_file (l_file)
						end
					end
				end
			end
		end

feature -- Querry

	project_found: BOOLEAN
			-- Has the project been found by last searching?

feature -- Access

	found_project_option: detachable USER_OPTIONS
			-- Found project option

	found_project: detachable PATH
			-- Found project file name.

feature {NONE} -- Access

	system_name, system_uuid, target_name, target_uuid: detachable STRING

feature {NONE} -- Implemetation

	search_needed: BOOLEAN
			-- Is current context needed to search?
		do
			Result := system_name /= Void or system_uuid /= Void or target_name /= Void or target_uuid /= Void
		end

	search_project_in_directory (a_path: STRING_32)
			-- Search project in `a_path'
		require
			a_path_attached: a_path /= Void
			a_path_not_empty: not a_path.is_empty
			search_needed: search_needed
		local
			l_files: like {FILE_UTILITIES}.ends_with
			u: FILE_UTILITIES
		do
			if u.directory_exists (a_path) then
				l_files := u.ends_with (create {PATH}.make_from_string (a_path), ".ecf", -1)
				from
					l_files.start
				until
					l_files.after or project_found
				loop
					check_file (l_files.item_for_iteration)
					l_files.forth
				end
			end
		end

	check_file (a_file: PATH)
			-- Check file and see if it is the system we need.
		require
			search_needed: search_needed
		local
			l_conf: CONF_LOAD
			l_conf_system: CONF_SYSTEM
			l_uuid: UUID
			l_all_libs: HASH_TABLE [CONF_TARGET, UUID]
			l_target: CONF_TARGET
			l_error, l_found: BOOLEAN
		do
			create l_conf.make (create {CONF_COMP_FACTORY})
			l_conf.retrieve_configuration (a_file.name)
			if not l_conf.is_error then
				l_conf_system := l_conf.last_system
				create l_uuid
				if system_name /= Void then
					l_error := not l_conf_system.name.is_case_insensitive_equal (system_name)
				end
				if not l_error and then system_uuid /= Void and then l_uuid.is_valid_uuid (system_uuid) then
					l_error := not l_conf_system.uuid.is_equal (create {UUID}.make_from_string (system_uuid))
				end
				if system_name = Void and then target_uuid = Void then
						-- Not too strict when we find system, we do not go further for target,
						-- Because before compiling, library targets are not ready.
					if not l_error and then target_uuid /= Void and then l_uuid.is_valid_uuid (target_uuid) then
						if l_conf_system.uuid.is_equal (create {UUID}.make_from_string (target_uuid)) then
								-- Current system and target share the same UUID
							l_error := False
						else
								-- Look into libraries
							l_all_libs := l_conf_system.all_libraries
							if l_all_libs /= Void then
								l_all_libs.search (create {UUID}.make_from_string (target_uuid))
								if l_all_libs.found then
									l_target := l_all_libs.found_item
								else
									l_error := True
								end
							else
									-- Not found
								l_error := True
							end
						end
					end
					if not l_error and then target_name /= Void then
						if l_target /= Void then
							l_error := not l_target.name.is_case_insensitive_equal_general (target_name)
						else
								-- Get target from the system.
							l_conf_system.targets.search (target_name)
							if not l_conf_system.targets.found then
								l_all_libs := l_conf_system.all_libraries
								if l_all_libs /= Void then
									from
										l_all_libs.start
									until
										l_all_libs.after or l_found
									loop
										if l_all_libs.item_for_iteration.name.is_case_insensitive_equal_general (target_name) then
											l_found := True
										end
										l_all_libs.forth
									end
								end
								l_error := not l_found
							end
						end
					end
				end

				project_found := not l_error
				if project_found then
					found_project := a_file
					read_user_options (l_conf_system.file_name)
				end
			end
		end

	reset
			-- Reset the searcher
		do
			project_found := False
			found_project := Void
			found_project_option := Void

			system_name := Void
			system_uuid := Void
			target_name := Void
			target_uuid := Void
		end

	read_user_options (a_file_path: STRING_32)
			-- Read user data for project of path `a_file_path'.
		require
			a_file_path_not_void: a_file_path /= Void
		local
			l_factory: USER_OPTIONS_FACTORY
		do
			create l_factory
			l_factory.load (a_file_path)
			if l_factory.successful then
				found_project_option := l_factory.last_options
			else
				found_project_option := Void
			end
		end

invariant
	project_found_implies_project_not_void: project_found implies (found_project /= Void)

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
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
