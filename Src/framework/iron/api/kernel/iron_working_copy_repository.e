note
	description: "Summary description for {IRON_WORKING_COPY_REPOSITORY}."
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_WORKING_COPY_REPOSITORY

inherit
	IRON_REPOSITORY
		redefine
			available_packages
		end

	SHARED_EXECUTION_ENVIRONMENT

	DEBUG_OUTPUT

create {IRON_API, IRON_EXPORTER, IRON_REPOSITORY_FACTORY}
	make,
	make_from_path,
	make_from_uri

feature {NONE} -- Initialization

	make (a_location: READABLE_STRING_GENERAL)
			-- Create current repository from directory location `a_location'.
		local
			l_resolved_location: STRING_32
		do
			create l_resolved_location.make_from_string_general (a_location)
			expand_variables (l_resolved_location)
			make_from_path (create {PATH}.make_from_string (l_resolved_location))
		end

	make_from_path (a_location_path: PATH)
		do
			path := a_location_path
			location := uri_location_from_path (a_location_path)
			initialize
		end

	make_from_uri (a_location_uri: URI)
		require
			a_location_uri.scheme.is_case_insensitive_equal_general ("file")
		local
			l_path_uri: PATH_URI
			s: STRING_32
		do
			location := a_location_uri

				-- Be sure to use same format C:\ vs C|\
			create l_path_uri.make_from_file_uri (a_location_uri)
			create l_path_uri.make_from_path (l_path_uri.file_path)
			location := l_path_uri
			path := l_path_uri.file_path

			if a_location_uri.path.has ('$') then
				create s.make_from_string (path.name)
				expand_variables (s)
				create path.make_from_string (s)
			else
				create l_path_uri.make_from_file_uri (a_location_uri)
				path := l_path_uri.file_path
			end

			initialize
		end

	create_available_packages
			-- <Precursor>
		do
			create available_packages.make (0)
		end

feature -- Access

	path: PATH

	location: URI

	available_packages_count: INTEGER
			-- <Precursor>
		do
			Result := available_packages.count
		end

	available_packages: ARRAYED_LIST [IRON_PACKAGE]

--	package_associated_with_path (a_path: READABLE_STRING_8; a_relative_path: detachable STRING): detachable IRON_PACKAGE
--		do
--			across
--				available_packages as c
--			until
--				Result /= Void
--			loop
--				across
--					c.item.associated_paths as p
--				until
--					Result /= Void
--				loop
--					if a_path.starts_with (p.item) then
--						Result := c.item
--						if a_relative_path /= Void then
--							a_relative_path.wipe_out
--							a_relative_path.append (a_path.substring (p.item.count + 1, a_path.count))
--						end
--					end
--				end
--			end
--		end
--

feature -- Status report

	is_same_repository (other: IRON_REPOSITORY): BOOLEAN
			-- <Precursor>
		do
			if attached {IRON_WORKING_COPY_REPOSITORY} other as l_other_repo then
				Result := path.canonical_path.name.same_string (l_other_repo.path.canonical_path.name)
			end
		end

	exists: BOOLEAN
			-- Does repository exists?
		local
			ut: FILE_UTILITIES
		do
			Result := ut.directory_path_exists (path)
		end

	debug_output: READABLE_STRING_GENERAL
		do
			Result := path.name
		end

feature -- Change

	reset_available_packages
		do
			available_packages.wipe_out
		end

	put_package (p: IRON_PACKAGE)
		do
			available_packages.force (p)
		end

feature -- Helpers

	expand_variables (s: STRING_32)
		local
			exp: IRON_STRING_VARIABLE_EXPANSER
		do
			exp.expand_string_32 (s, agent execution_environment.item)
		end

	uri_location_from_path (a_path: PATH): URI
		local
			conv: PATH_URI
		do
			create conv.make_from_path (a_path)
			Result := conv
		end

	uri_to_local_path (a_uri: URI): PATH
		local
			conv: PATH_URI
		do
			create conv.make_from_file_uri (a_uri)
			Result := conv.file_path
		end

invariant
--	uri_no_trailing_slash: not uri.path.ends_with ("/")
--	version_uri_no_trailing_slash: not version_uri.path.ends_with ("/")

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
