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
			create db.make (layout)
		end

feature {IRON_EXPORTER} -- Storage

	db: IRON_CLIENT_DB

	db_revision: INTEGER
			-- revision of the database.
			-- (incremented for any install or uninstall operation).

	increment_db_revision
			-- Increment revision.
			-- note: usually after an installation or uninstallation operation.
			-- could also be used to request refresh for any installation api.
		do
			db.increment_revision
		ensure
			db.revision > old db.revision
		end

feature {NONE} -- Internal

	internal_installed_packages: detachable like installed_packages

	internal_available_packages: detachable like available_packages

feature -- Access

	is_up_to_date: BOOLEAN
			-- Does current has up-to-date data?
			-- If not, it will need to be refreshed.
		do
			Result := db_revision = db.revision
		end

	installed_packages_count: INTEGER
			-- Number of installed packages.
		do
			Result := installed_packages.count
		end

	installed_package (a_package_name: READABLE_STRING_GENERAL; a_skip_cache: BOOLEAN): detachable IRON_PACKAGE
			-- Installed package `a_package_name' if any.
			-- note: this is an optimized query.
		do
			if a_skip_cache then
				Result := db.quick_installed_package (a_package_name)
			elseif attached installed_packages as lst then
				across
					lst as p
				until
					Result /= Void
				loop
					if p.item.is_identified_by (a_package_name) then
						Result := p.item
					end
				end
			end
		end

	installed_packages: LIST [IRON_PACKAGE]
			-- List of installed package represented as a list of package object.
		local
			res: like internal_installed_packages
		do
			if not is_up_to_date then
				internal_installed_packages := Void
				internal_available_packages := Void
			end
			res := internal_installed_packages
			if res = Void then
				res := db.installed_packages
				db_revision := db.revision
				internal_installed_packages := res
			end
			Result := res
		end

	unexpected_installed_packages: LIST [IRON_PACKAGE]
			-- List of unexpected installed packages.
			-- i.e: installed packages without any associated registered repository.
		local
			p: IRON_PACKAGE
			l_repositories: LIST [IRON_REPOSITORY]
		do
			l_repositories := db.repositories
			create {ARRAYED_LIST [IRON_PACKAGE]} Result.make (0)
			across
				installed_packages as ic
			loop
				p := ic.item
				if across l_repositories as repo_ic some p.repository.is_same_repository (repo_ic.item) end then
						-- Ok
				else
						-- no associated registered repository !!
					Result.force (p)
				end
			end
		end

	available_packages: LIST [IRON_PACKAGE]
			-- Associated path indexed by package name.
			-- It does not include conflicting packages.
		local
			res: like internal_available_packages
		do
			if not is_up_to_date then
				internal_installed_packages := Void
				internal_available_packages := Void
			end
			res := internal_available_packages
			if res = Void then
				res := db.available_packages
				db_revision := db.revision
				internal_available_packages := res
			end
			Result := res
		end

	repositories: LIST [IRON_REPOSITORY]
			-- List of registered repositories.
		do
			Result := db.repositories
		end

feature -- Change

	notify_change
			-- Notify an operation changed the client database.
			-- note: usually after an installation or uninstallation operation.
			-- could also be used to request refresh for any installation api.
		do
			increment_db_revision
		ensure
			need_refresh: db_revision /= 0 implies not is_up_to_date
		end

	refresh
			-- Refresh associated data.
		do
			refresh_installed_packages
			refresh_available_packages
		end

	refresh_installed_packages
		do
			reset_installed_packages
		end

	refresh_available_packages
		do
			reset_available_packages
		end

	reset
			-- Reset associated cached data.
		do
			reset_installed_packages
			reset_available_packages
		end

	reset_installed_packages
			-- Refresh associated data.
		do
			internal_installed_packages := Void
			db_revision := 0
		end

	reset_available_packages
			-- Refresh associated data.
		do
			internal_available_packages := Void
			db_revision := 0
		end

feature -- Query		

	is_available (a_uri: READABLE_STRING_GENERAL): BOOLEAN
			-- Is there an available package associated with `a_uri'?
		do
			Result := available_package_name_for_uri (a_uri) /= Void
		end

	available_package_name_for_uri (a_uri: READABLE_STRING_GENERAL): detachable READABLE_STRING_GENERAL
			-- Name of eventual available package associated with `a_uri'?
		local
			iri: IRI
			p: INTEGER
			l_path: READABLE_STRING_8
			l_package_name: READABLE_STRING_GENERAL
			l_project_path: READABLE_STRING_8
			l_package_full_path,
			l_repo_uri_string: READABLE_STRING_8
			l_package: IRON_PACKAGE
		do
			if
				a_uri.starts_with ("http://") or
				a_uri.starts_with ("https://") or
				a_uri.starts_with ("file://")
			then
				across
					available_packages as ic
				until
					Result /= Void
				loop
					l_package := ic.item
					l_repo_uri_string := l_package.repository.location_string
					if a_uri.starts_with (l_repo_uri_string) then
						across
							l_package.associated_paths as path_ic
						until
							Result /= Void -- order matters
						loop
							l_package_full_path := l_repo_uri_string + path_ic.item
							if a_uri.same_string (l_package_full_path) then
								Result := l_package.identifier
							end
						end
					end
				end
			elseif a_uri.starts_with ("iron:") then
				create iri.make_from_string (a_uri)
				l_path := iri.uri_path
				p := l_path.index_of (':', 1)
				if p > 0 then
					l_package_name := l_path.head (p - 1)
					l_project_path := l_path.substring (p + 1, l_path.count)
					across
						available_packages as ic
					until
						Result /= Void -- order matters
					loop
						l_package := ic.item
						if l_package.is_identified_by (l_package_name) then
							Result := l_package.identifier
						end
					end
				else
						-- The tail could be the packagename, and there may be a default .ecf ... depending on the void-safety level.
						-- status: idea not implemented.
				end
			end
		end

	is_installed (a_uri: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := package_associated_with_uri (a_uri) /= Void
		end

	is_package_installed (a_package: IRON_PACKAGE): BOOLEAN
			-- Is `a_package' installed?
		local
			d: DIRECTORY
		do
			across
				installed_packages as ic
			until
				Result
			loop
				Result := a_package.is_same_package (ic.item)
			end
			if Result then
					-- Also check that package is really installed on disk!
				if attached package_installation_path (a_package) as p then
					create d.make_with_path (p)
					Result := d.exists and then not d.is_empty
				end
			end
		end

	conflicting_available_package (p: IRON_PACKAGE): detachable IRON_PACKAGE
			-- Return eventual available or installed package with same identifier as `p'
			-- and which exists with priority over `p'.
		local
			l_identifier: READABLE_STRING_GENERAL
		do
			l_identifier := p.identifier
			across
				available_packages as ic
			until
				Result /= Void
			loop
				if ic.item.is_identified_by (l_identifier) then
					Result := ic.item
				end
			end
			if Result /= Void and then p.is_same_package (Result) then
					-- It has top priority
				Result := Void
			end
		end

	projects_from_installed_package (a_package: IRON_PACKAGE): ARRAYED_LIST [PATH]
		require
			is_package_installed (a_package)
		local
			p: detachable PATH
			l_scanner: IRON_ECF_SCANNER
			p_name: READABLE_STRING_32
			s: STRING_32
		do
			p := package_installation_path (a_package)
			if p = Void then
				create Result.make (0)
			else
				create l_scanner.make
				l_scanner.process_directory (p)
				create Result.make (l_scanner.items.count)
				p_name := p.name
				across
					l_scanner.items as ic
				loop
					s := ic.item.name
					s.remove_head (p_name.count + 1)
					Result.force (create {PATH}.make_from_string (s))
				end
			end
		end

feature -- Installed package		

	package_installation_path (a_package: IRON_PACKAGE): detachable PATH
			-- Path to local installation folder related to `a_package'
			-- return Void if invalid data exists.
		do
			Result := layout.package_installation_path (a_package)
		end

	packages_conflicting_with_package (a_package: IRON_PACKAGE): detachable LIST [IRON_PACKAGE]
			-- Installed packages that are conflicting with `a_package'.
			--| note: in case of conflict the declaration order of the repositories is taken into account.
		require
			has_name: a_package.name /= Void
		do
			if attached a_package.name as l_name then
				Result := packages_associated_with_name (l_name)
				if Result /= Void then
					from
						Result.start
					until
						Result.after
					loop
						if a_package.is_same_package (Result.item) then
							Result.remove
						else
							Result.forth
						end
					end
					if Result.is_empty then
						Result := Void
					end
				end
			end
		ensure
			Result /= Void implies Result.count > 0
		end

	package_associated_with_id (a_id: READABLE_STRING_GENERAL): detachable IRON_PACKAGE
			-- Installed package associated with id `a_id'.
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
			-- Installed package associated with name `a_name'.
		local
			l_package: detachable IRON_PACKAGE
		do
			create {ARRAYED_LIST [IRON_PACKAGE]} Result.make (1)

			across
				installed_packages as p
			loop
				l_package := p.item
				if l_package.is_identified_by (a_name) then
					Result.force (l_package)
				end
			end

			if Result.is_empty then
				Result := Void
			end
		end

	package_associated_with_uri (a_uri: READABLE_STRING_GENERAL): detachable IRON_PACKAGE
			-- Installed package associated with uri `a_uri'.
		local
			s: READABLE_STRING_8
			l_loc: READABLE_STRING_8
			iri: IRI
			l_uri: detachable URI
			l_uri_string: READABLE_STRING_8
		do
			if
				a_uri.starts_with ("http://") or
				a_uri.starts_with ("https://") or
				a_uri.starts_with ("file://")
			then
				create iri.make_from_string (a_uri)
				l_uri := iri.to_uri
			else
				create {PATH_URI} l_uri.make_from_path (create {PATH}.make_from_string (a_uri))
			end
			if l_uri /= Void and then l_uri.is_valid then
				l_uri_string := l_uri.string
				if attached installed_packages as lst then
					across
						lst as p
					until
						Result /= Void
					loop
						l_loc := p.item.repository.location_string
						if l_uri_string.starts_with (l_loc) then
							s := l_uri_string.substring (l_loc.count + 1, l_uri_string.count)
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
		end

feature -- Local path		

	local_path_associated_with_uri (a_uri: READABLE_STRING_GENERAL): detachable PATH
			-- Local path for installed package referenced by `a_uri'.
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
			-- Local path related to eventual installed package in association with url `a_url'.
			--| note: `a_url' can reference the location of the ecf file.
			--| example: http://iron.eiffel.com/13.11/com.eiffel/library/text/parser/xml/parser/xml_parser.ecf
			--| (the package is located at "http://iron.eiffel.com/13.11/com.eiffel/library/text/parser/xml")
		local
			s: READABLE_STRING_8
			r: STRING_8
			l_pn_item: READABLE_STRING_8
			l_package: detachable IRON_PACKAGE
			l_loc: READABLE_STRING_8
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
					l_loc := p.item.repository.location_string
					if l_uri.starts_with (l_loc) then
						s := l_uri.substring (l_loc.count + 1, l_uri.count)
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
			-- Local path of eventual installed package reference by `a_package_name' and `a_relative_uri'.
			--| note: `a_url' can reference the location of the ecf file.			
			--| ex: xml and parser/xml_parser.ecf
		local
			l_package: detachable IRON_PACKAGE
		do
			l_package := installed_package (a_package_name, False)
			if l_package /= Void then
				Result := package_installation_path (l_package)
				if Result /= Void and then (create {DIRECTORY}.make_with_path (Result)).exists then
					Result := Result.extended (a_relative_uri)
				else
					Result := Void
				end
			end
		end

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
	available_packages /= Void

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
