note
	description: "Summary description for {IRON_INSTALLATION_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_INSTALLATION_API

inherit
	IRON_API
		redefine
			initialize
		end

create
	make_with_layout

feature {NONE} -- Initialization

	initialize
		do
			Precursor
			create {ARRAYED_LIST [IRON_PACKAGE]} installed_packages.make (0)
			load_installed_packages
		end

	load_installed_packages
		local
			p: PATH
			vis: IRON_FS_PACKAGE_INFO_DIRECTORY_ITERATOR
			lst: ARRAYED_LIST [PATH]
		do
			p := layout.packages_path
			create lst.make (10)
			create vis.make (lst)
			vis.scan_folder (p.absolute_path.canonical_path)
			across
				lst as c
			loop
				if attached file_content (c.item) as s then
					if attached repo_package_from_json_string (s) as l_package then
						installed_packages.force (l_package)
					end
				end
			end
		end

feature -- Access

	refresh
			-- Refresh associated data.
		do
			installed_packages.wipe_out
			load_installed_packages
		end

	is_installed (a_package: IRON_PACKAGE): BOOLEAN
			-- Is `a_package' installed?
		local
			d: DIRECTORY
		do
			if attached package_installation_path (a_package) as p then
				create d.make_with_path (p)
				Result := d.exists and then not d.is_empty
			end
		end

	package_installation_path (a_package: IRON_PACKAGE): detachable PATH
			-- Path to local installation folder related to `a_package'
			-- return Void if invalid data exists.
		do
			Result := layout.package_installation_path (a_package)
		end

	package_associated_with_id (a_id: READABLE_STRING_GENERAL): detachable IRON_PACKAGE
		do
			across
				installed_packages as p
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
				installed_packages as p
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

	package_associated_with_uri (a_uri: READABLE_STRING_GENERAL): detachable IRON_PACKAGE
		local
			s: STRING
			repo_url: READABLE_STRING_8
			iri: IRI
			l_uri: READABLE_STRING_8
		do
			create iri.make_from_string (a_uri)
			l_uri := iri.uri_string

			if attached installed_packages as lst then
				across
					lst as p
				until
					Result /= Void
				loop
					repo_url := p.item.repository.url
					if l_uri.starts_with (repo_url) then
						s := l_uri.substring (repo_url.count + 1, l_uri.count)
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
		end

	local_path_associated_with_uri (a_uri: READABLE_STRING_GENERAL): detachable PATH
			-- Local path for package referenced by `a_uri'.
		local
			iri: IRI
			p: INTEGER
			l_path: READABLE_STRING_8
		do
			if
				a_uri.starts_with ("http://") or
				a_uri.starts_with ("https://")
			then
				Result := local_path_associated_with_url (a_uri)
			elseif a_uri.starts_with ("iron:") then
				create iri.make_from_string (a_uri)
				l_path := iri.uri_path
				p := l_path.index_of (':', 1)
				if p > 0 then
					Result := local_path_associated_with_relative_uri (l_path.head (p - 1), l_path.substring (p + 1, l_path.count))
				else
						-- The tail could be the packagename, and there may be a default .ecf ... depending on the void-safety level.
						-- status: idea not implemented.
				end
			end
		end

	local_path_associated_with_url (a_url: READABLE_STRING_GENERAL): detachable PATH
		local
			s,r: STRING
			l_pn_item: READABLE_STRING_8
			l_package: detachable IRON_PACKAGE
			repo_url: READABLE_STRING_8
			iri: IRI
			l_uri: READABLE_STRING_8
		do
			create iri.make_from_string (a_url)
			l_uri := iri.uri_string

			create r.make_empty
			if attached installed_packages as lst then
				across
					lst as p
				until
					l_package /= Void
				loop
					repo_url := p.item.repository.url
					if l_uri.starts_with (repo_url) then
						s := l_uri.substring (repo_url.count + 1, l_uri.count)
						across
							p.item.associated_paths as pn
						until
							l_package /= Void
						loop
							l_pn_item := pn.item
							if
								s.starts_with (l_pn_item) and then
								(s.count = l_pn_item.count or else s.item (l_pn_item.count + 1) = '/')
							then
								l_package := p.item
								r.wipe_out
								r.append (s.substring (l_pn_item.count + 1, s.count))
							end
						end
					end
				end
			end
			if l_package /= Void then
				Result := package_installation_path (l_package)
				if Result /= Void and then (create {DIRECTORY}.make_with_path (Result)).exists then
					Result := Result.extended (r)
				else
					Result := Void
				end
			end
		end

	local_path_associated_with_relative_uri (a_package_name: READABLE_STRING_GENERAL; a_relative_uri: READABLE_STRING_GENERAL): detachable PATH
		local
			l_package: detachable IRON_PACKAGE
			iri: IRI
		do
			if attached installed_packages as lst then
				across
					lst as p
				until
					l_package /= Void
				loop
					if p.item.is_named (a_package_name) then
						l_package := p.item
					end
				end
			end
			if l_package /= Void then
				Result := package_installation_path (l_package)
				if Result /= Void and then (create {DIRECTORY}.make_with_path (Result)).exists then
					Result := Result.extended (a_relative_uri)
				else
					Result := Void
				end
			end
		end

	installed_packages: LIST [IRON_PACKAGE]

feature {NONE} -- Implementation

	repo_package_from_json_string (s: READABLE_STRING_8): detachable IRON_PACKAGE
		local
			f: JSON_TO_IRON_FACTORY
		do
			create f
			Result := f.json_to_package (s)
		end

invariant
	installed_packages /= Void

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
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
