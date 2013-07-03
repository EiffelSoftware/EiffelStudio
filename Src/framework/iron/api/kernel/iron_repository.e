note
	description: "Summary description for {IRON_REPOSITORY}."
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_REPOSITORY

inherit
	ITERABLE [IRON_PACKAGE]

create {IRON_API, IRON_EXPORTER}
	make, make_from_version_uri

feature {NONE} -- Initialization

	make (a_uri: URI; a_version: READABLE_STRING_8)
		require
			valid_uri: a_uri.is_valid
		local
			l_path: READABLE_STRING_8
		do
			uri := a_uri.twin
			l_path := a_uri.path
			if l_path.ends_with ("/") then
				uri.set_path (l_path.head (l_path.count - 1))
			end
			if attached {like version} a_version as v then
				version := v
			else
				create version.make_from_string (a_version)
			end
			create available_packages.make (0)
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
					l_path.append (c.item)
				end
			end
			create l_uri.make_from_string (a_uri.string)
			l_uri.set_path (l_path)
			if v.ends_with ("/") then
				v := v.substring (1, v.count - 1)
			end
			make (l_uri, v)
		end

feature -- Access

	uri: URI

	version_uri: URI
		do
			create Result.make_from_string (uri.string + "/" + version)
		end

	version: IMMUTABLE_STRING_8

	available_packages: ARRAYED_LIST [IRON_PACKAGE]

	url: STRING
		do
			create Result.make_empty
			uri.append_to_string (Result)
			Result.append_character ('/')
			Result.append (version)
		end

	package_associated_with_path (a_path: READABLE_STRING_8; a_relative_path: detachable STRING): detachable IRON_PACKAGE
		do
			across
				available_packages as c
			until
				Result /= Void
			loop
				across
					c.item.associated_paths as p
				until
					Result /= Void
				loop
					if a_path.starts_with (p.item) then
						Result := c.item
						if a_relative_path /= Void then
							a_relative_path.wipe_out
							a_relative_path.append (a_path.substring (p.item.count + 1, a_path.count))
						end
					end
				end
			end
		end

	package_associated_with_id (a_id: READABLE_STRING_GENERAL): detachable IRON_PACKAGE
		do
			across
				available_packages as p
			until
				Result /= Void
			loop
				if a_id.is_case_insensitive_equal (p.item.id) then
					Result := p.item
				end
			end
		end

	packages_associated_with_name (a_name: READABLE_STRING_GENERAL): detachable LIST [IRON_PACKAGE]
		local
			l_package: detachable IRON_PACKAGE
		do
			create {ARRAYED_LIST [IRON_PACKAGE]} Result.make (1)
			across
				available_packages as p
			loop
				l_package := p.item
				if l_package.is_named (a_name) then
					Result.force (l_package)
				end
			end
			if Result.is_empty then
				Result := Void
			end
		end

	package_associated_with_uri (a_uri: URI): detachable IRON_PACKAGE
		local
			s: STRING
		do
			s := a_uri.string
			if s.starts_with (url) then
				s := s.substring (url.count + 1, s.count)
				across
					available_packages as p
				until
					Result /= Void
				loop
					across
						p.item.associated_paths as pn
					until
						Result /= Void
					loop
						if s.starts_with (pn.item) then
							Result := p.item
						end
					end
				end
			end
		end

feature -- Access

	new_cursor: ITERATION_CURSOR [IRON_PACKAGE]
			-- Fresh cursor associated with current structure
		do
			Result := available_packages.new_cursor
		end

feature -- Change

	put_package (p: IRON_PACKAGE)
		do
			available_packages.force (p)
		end

feature {IRON_EXPORTER} -- Change		

	set_package_list (v: like available_packages)
		do
			available_packages := v
		end

invariant
	uri_no_trailing_slash: not uri.path.ends_with ("/")

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
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
