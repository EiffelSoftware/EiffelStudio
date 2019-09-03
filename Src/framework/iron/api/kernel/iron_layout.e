note
	description: "[
			Environment for various iron related path and resources ....
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_LAYOUT

inherit
	SHARED_EXECUTION_ENVIRONMENT

create
	make_default,
	make_with_path

feature {NONE} -- Initialization

	make_default
		local
			p: PATH
		do
			if attached execution_environment.item ({IRON_API_CONSTANTS}.iron_variable_name) as s then
				create p.make_from_string (s)
			else
				create p.make_current
				p := p.extended ("iron")
			end
			make_with_path (p, p)
		end

	make_with_path (a_root: PATH; a_installation: PATH)
			--
		do
			path := a_root.absolute_path.canonical_path
			installation_path := a_installation.absolute_path.canonical_path
		end

feature -- Access

	path: PATH
			-- root dir for iron.

	installation_path: PATH
			-- Installation dir useful to find client executable and utilities if any.

	binaries_path: detachable PATH
			-- Binaries path if available.
			-- contains iron client, and also tool to create package archive.
			--| Could be $IRON_PATH/spec/$ISE_PLATFORM/bin
			--| Could be $ISE_EIFFEL/tools/iron/spec/$ISE_PLATFORM/bin
			--| ...
		local
			s: detachable READABLE_STRING_32
		once
			if attached execution_environment.item ("IRON_PLATFORM") as e then
				s := e
			elseif attached execution_environment.item ("ISE_PLATFORM") as e then
				s := e
			end
			if s /= Void then
				Result := installation_path.extended ("spec").extended (s).extended ("bin")
			end
		end

	repositories_configuration_file: PATH
		once
			Result := path.extended ("repositories.conf")
		end

	repositories_revision_file: PATH
		once
			Result := packages_path.extended ("local.rev")
		end

	repositories_path: PATH
		once
			Result := path.extended ("repositories")
		end

	archives_path: PATH
		once
			Result := path.extended ("archives")
		end

	packages_path: PATH
		once
			Result := path.extended ("packages")
		end

feature -- Query

	repository_data_folder (a_repo: IRON_REPOSITORY): PATH
			-- Folder containing information related to `a_repo'
		do
			Result := repositories_path.extended_path (safe_repository_path (a_repo))
		end

	repository_data_file (a_repo: IRON_REPOSITORY): PATH
			-- File caching repository data for `a_repo'.
		do
			Result := repository_data_folder (a_repo).extended ("repository.data")
		end

	repository_packages_data_folder (a_repo: IRON_REPOSITORY): PATH
			-- Folder storing package info files for `a_repo'.
		do
			Result := repository_data_folder (a_repo).extended ("packages")
		end

	repository_packages_data_index (a_repo: IRON_REPOSITORY): PATH
			-- Index file of repository packages for `a_repo'.
		do
			Result := repository_packages_data_folder (a_repo).appended_with_extension ("index")
		end

	repository_archive_path (a_repo: IRON_REPOSITORY): PATH
		do
			Result := archives_path.extended_path (safe_repository_path (a_repo))
		end

	package_archive_path (a_package: IRON_PACKAGE): PATH
		do
			Result := repository_archive_path (a_package.repository).extended_path (safe_package_path (a_package, True))
		end

	package_installation_info_path (a_package: IRON_PACKAGE): PATH
		do
			Result := packages_path.extended_path (safe_package_path (a_package, True)).appended_with_extension ("info")
		end

	package_installation_iron_file_path (a_package: IRON_PACKAGE): detachable PATH
		do
			if attached package_installation_path (a_package) as p then
				Result := p.extended ("package").appended_with_extension ("iron")
			end
		end

	package_installation_path (a_package: IRON_PACKAGE): detachable PATH
		local
			f: RAW_FILE
			utf: UTF_CONVERTER
			s: READABLE_STRING_8
			l_uri: URI
			l_path_uri: PATH_URI
		do
			if attached {IRON_WORKING_COPY_REPOSITORY} a_package.repository as l_wc_repo then
				if not a_package.associated_paths.is_empty then
					s := a_package.associated_paths.first
					create l_uri.make_from_string (l_wc_repo.location.string)
					l_uri.add_unencoded_path_segment (s)
					create l_path_uri.make_from_file_uri (l_uri)
					Result := l_path_uri.file_path
				end
			else
				Result := package_expected_installation_path (a_package)
				if attached package_renaming_installation_path (a_package) as p then
					create f.make_with_path (p)
					if f.exists and then f.is_access_readable then
						f.open_read
						f.read_line_thread_aware
						s := f.last_string
						f.close
						create Result.make_from_string (utf.utf_8_string_8_to_escaped_string_32 (s))
					end
				end
			end
		end

	package_expected_installation_path (a_package: IRON_PACKAGE): PATH
		do
			Result := packages_path.extended_path (safe_package_path (a_package, False))
		end

	package_renaming_installation_path (a_package: IRON_PACKAGE): PATH
		do
			Result := packages_path.extended_path (safe_package_path (a_package, True)).appended_with_extension ("renaming")
		end

feature -- Operation

	iron_safe_delete_folder (p: detachable PATH)
			-- Delete recursively folder `p' only if this is safe.
			--| i.e: exist and under the installation iron folder
		local
			d: DIRECTORY
			ip: PATH
		do
			if p /= Void then
				ip := path
				if p.absolute_path.canonical_path.name.starts_with (ip.absolute_path.canonical_path.name) then
					create d.make_with_path (p)
					if d.exists then
						d.recursive_delete
					end
				end
			end
		end

	iron_safe_delete_file (p: detachable PATH)
			-- Delete file `p' only if this is safe.
			--| i.e: exist and under the installation iron folder
		local
			f: RAW_FILE
			ip: PATH
		do
			if p /= Void then
				ip := path
				if p.absolute_path.canonical_path.name.starts_with (ip.absolute_path.canonical_path.name) then
					create f.make_with_path (p)
					if f.exists then
						f.delete
					end
				end
			end
		end

feature {NONE} -- Implementation

	safe_package_path (a_package: IRON_PACKAGE; with_id: BOOLEAN): PATH
		local
			s: STRING_32
		do
			create s.make (10)
			if attached a_package.name as l_name then
				s.append (l_name)
			end
			if with_id then
				if not s.is_empty then
					s.append_character ('_')
					s.append_character ('_')
				end
				s.append_string_general (a_package.id)
			elseif s.is_empty then
				s.append_string_general (a_package.id.as_lower)
			end
			check s_not_empty: not s.is_empty end
			create Result.make_from_string (safe_name (s))
		end

	safe_repository_path (repo: IRON_REPOSITORY): PATH
		do
			create Result.make_from_string (safe_name (repo.location_string))
		end

	safe_name (a_name: READABLE_STRING_GENERAL): STRING_8
		local
			i,n: INTEGER
			c: CHARACTER_32
		do
			create Result.make (a_name.count)
			from
				i := 1
				n := a_name.count
			until
				i > n
			loop
				c := a_name[i]
				inspect c
				when ':', '/' then
					Result.append_character ('_')
				when 'a' .. 'z' then
					Result.append_character (c.to_character_8)
				when 'A' .. 'Z' then
					Result.append_character (c.to_character_8)
				when '0' .. '9' then
					Result.append_character (c.to_character_8)
				when '!', '@', '?' then
					Result.append_character ('+')
				when '-' then
					Result.append_character ('-')
				else
					Result.append_character ('_')
				end
				i := i + 1
			end
		end


note
	copyright: "Copyright (c) 1984-2018, Eiffel Software"
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
