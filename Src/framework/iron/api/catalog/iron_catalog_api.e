note
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_CATALOG_API

inherit
	IRON_API
		rename
			print as log_print -- To prevent unwanted output!
		redefine
			initialize
		end

create
	make_with_layout

feature {NONE} -- Initialization

	initialize
		do
			Precursor
			create {IRON_FS_CATALOG} catalog.make (layout, urls)
		end

	catalog: IRON_CATALOG

feature -- Change

	update
		do
			catalog.update
		end

	update_repository (repo: IRON_REPOSITORY; is_silent: BOOLEAN)
		do
			catalog.update_repository (repo, is_silent)
		end

feature -- Access: repositories		

	repositories: LIST [IRON_REPOSITORY]
		do
			Result := catalog.repositories
		end


	invalid_repositories: detachable LIST [IRON_REPOSITORY]
			-- Invalid repositories, if any.
			-- note: an invalid repository is an inexisting one.
		do
			across
				repositories as ic
			loop
				if
					attached {IRON_WORKING_COPY_REPOSITORY} ic as wc_repo and then
					not wc_repo.exists
				then
					if Result = Void then
						create {ARRAYED_LIST [IRON_REPOSITORY]} Result.make (1)
					end
					Result.force (wc_repo)
				end
			end
		end

	repository (a_uri: URI): detachable IRON_REPOSITORY
			-- Registered repository related to `a_uri'.
		do
			Result := catalog.repository (a_uri)
		end

	has_repository_registered (a_location: READABLE_STRING_GENERAL): BOOLEAN
			-- Has a repository registered with `a_location'?
		do
			Result := repository_at (a_location) /= Void
		end

	repository_at (a_location: READABLE_STRING_GENERAL): detachable IRON_REPOSITORY
			-- Registered repository related to `a_location'.
		local
			uri: PATH_URI
		do
			if a_location.has_substring ("://") then
				Result := catalog.repository_at (a_location)
			else
				create uri.make_from_path (create {PATH}.make_from_string (a_location))
				if uri.is_valid then
					Result := catalog.repository (uri)
				end
			end
		end

feature -- Repository registration				

	register_repository (a_repo: IRON_REPOSITORY)
		do
			catalog.register_repository (a_repo)
			catalog.update_repository (a_repo, False)
		end

	unregister_repository (a_uri: READABLE_STRING_GENERAL)
		require
			has_repository_registered: has_repository_registered (a_uri)
		do
			if attached repository_at (a_uri) as repo then
					-- Uninstall any package from the repository.
				across
					repo.available_packages as ic
				loop
					uninstall_package (ic)
				end
				catalog.unregister_repository (a_uri)
			end
		end

feature -- Access: package	

	is_package_installed (a_package: IRON_PACKAGE): BOOLEAN
			-- Is package `a_package' installed?
		do
			Result := catalog.is_package_installed (a_package)
		end

	available_packages: ARRAYED_LIST [IRON_PACKAGE]
		do
			create Result.make (10)
			across
				repositories as repo_ic
			loop
				across
					repo_ic.available_packages as ic
				loop
					Result.force (ic)
				end
			end
		end

	available_path_associated_with_uri (a_uri_string: READABLE_STRING_GENERAL): detachable PATH
		local
			iri: IRI
		do
			create iri.make_from_string (a_uri_string)
			Result := catalog.available_path_associated_with_uri (iri.to_uri)
		end

	packages_associated_with_name (a_name: READABLE_STRING_GENERAL): detachable LIST [IRON_PACKAGE]
		do
			Result := catalog.packages_associated_with_name (a_name)
		end

	package_associated_with_uri (a_location: READABLE_STRING_GENERAL): detachable IRON_PACKAGE
		local
			iri: IRI
			l_uri: URI
			exp: IRON_STRING_VARIABLE_EXPANSER
		do
			if
				a_location.starts_with ("http://") or
				a_location.starts_with ("https://")
			then
				create iri.make_from_string (a_location)
				l_uri := iri.to_uri
			elseif a_location.starts_with ("file://") then
				create iri.make_from_string (a_location)
				l_uri := iri.to_uri
			else
				create {PATH_URI} l_uri.make_from_path (create {PATH}.make_from_string (exp.expanded_string_32 (a_location.to_string_32, agent execution_environment.item)))
			end
			if l_uri.is_valid then
				Result := catalog.package_associated_with_uri (l_uri)
			end
		end

	package_associated_with_id (a_id: READABLE_STRING_GENERAL): detachable IRON_PACKAGE
		do
			Result := catalog.package_associated_with_id (a_id)
		end

feature -- Operations

	download_package (a_repo: IRON_WEB_REPOSITORY; a_package: IRON_PACKAGE; ignoring_cache: BOOLEAN)
		do
			catalog.download_package (a_repo, a_package, ignoring_cache)
		end

	install_package (a_repo: IRON_REPOSITORY; a_package: IRON_PACKAGE; ignoring_cache: BOOLEAN)
			-- Install package `a_package' from repository `a_repo'.
			-- If `ignoring_cache' is True, the archive will be download again even if it was already download before.
		do
			catalog.install_package (a_repo, a_package, ignoring_cache)
		end

	setup_package_installation (a_package: IRON_PACKAGE; cl_succeed: detachable CELL [BOOLEAN]; is_silent: BOOLEAN)
			-- Process setup instruction for installed package `a_package'.
			-- If `cl_succeed' is provided, return True if succeed.
		require
			is_package_installed: is_package_installed (a_package)
		do
			catalog.setup_package_installation (a_package, cl_succeed, is_silent)
		end

	uninstall_package (a_package: IRON_PACKAGE)
		do
			catalog.uninstall_package (a_package)
		end

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
