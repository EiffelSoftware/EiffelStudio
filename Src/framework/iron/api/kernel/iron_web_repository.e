note
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_WEB_REPOSITORY

inherit
	IRON_REPOSITORY
		redefine
			available_packages
		end

	DEBUG_OUTPUT

create {IRON_API, IRON_EXPORTER, IRON_REPOSITORY_FACTORY}
	make,
	make_from_version_uri

feature {NONE} -- Initialization

	make (a_uri: URI; a_version: READABLE_STRING_8)
		require
			valid_uri: a_uri.is_valid
		local
			l_path: READABLE_STRING_8
		do
			server_uri := a_uri.twin
			l_path := a_uri.path
			if l_path.ends_with ("/") then
				server_uri.set_path (l_path.head (l_path.count - 1))
			end
			if attached {like version} a_version as v then
				version := v
			else
				create version.make_from_string (a_version)
			end
			create location.make_from_string (server_uri.string + "/" + version)
			initialize
		end

	make_from_version_uri (a_uri: URI)
			-- Make from uri containing version
		require
			valid_uri: a_uri.is_valid
			version_included: a_uri.path_segments.count > 0
		local
			lst: LIST [READABLE_STRING_8]
			v: READABLE_STRING_8
			l_path: STRING_8
			l_uri: URI
		do
			lst := a_uri.path_segments.twin
			v := lst.last -- attached due to precondition `version_included'
			lst.finish
			lst.remove
			create l_path.make_empty
			if lst.count > 0 then
				across
					lst as c
				loop
					l_path.append_character ('/')
					l_path.append (c)
				end
			end
			create l_uri.make_from_string (a_uri.string)
			l_uri.set_path (l_path)
			if v.ends_with ("/") then
				v := v.substring (1, v.count - 1)
			end
			make (l_uri, v)
		end

	create_available_packages
			-- <Precursor>
		do
			create available_packages.make (0)
		end

feature -- Access

	location: URI
			-- <Precursor>

	server_uri: URI
			-- URI location of associated iron server.

	version: IMMUTABLE_STRING_8
			-- Version on remote iron server.

	available_packages_count: INTEGER
			-- <Precursor>
		do
			Result := available_packages.count
		end

	available_packages: ARRAYED_LIST [IRON_PACKAGE]

--feature -- Query		

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

feature -- Status report

	is_same_repository (other: IRON_REPOSITORY): BOOLEAN
			-- <Precursor>
		do
			if attached {IRON_WEB_REPOSITORY} other as l_other_repo then
				Result := location_string.same_string (l_other_repo.location_string)
			end
		end

	debug_output: READABLE_STRING_GENERAL
		do
			Result := location_string
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

invariant
	server_uri_no_trailing_slash: not server_uri.path.ends_with ("/")
	location_no_trailing_slash: not location.path.ends_with ("/")

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
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
