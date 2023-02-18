note
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IRON_CATALOG

feature -- Access

	api_version: IMMUTABLE_STRING_8
		once
			Result := (create {IRON_API_CONSTANTS}).version
		end

	layout: IRON_LAYOUT
		deferred
		end

feature -- Access: repository		

	repositories: LIST [IRON_REPOSITORY]
			-- Ordered list of repositories.
			--| ordered by priority (first has priority over next)
			--| the order is used to resolved eventual conflict.
		deferred
		end

	register_repository (a_repo: IRON_REPOSITORY)
			-- Register repository associated with `a_uri'
		deferred
		end

	unregister_repository (a_uri: READABLE_STRING_GENERAL)
			-- Unregister repository associated with `a_uri'
			-- and also uninstall all related packages.
		deferred
		end

	repository (a_uri: URI): detachable IRON_REPOSITORY
			-- Repository associated with uri `a_uri'
		deferred
		end

	repository_at (a_uri: READABLE_STRING_GENERAL): detachable IRON_REPOSITORY
			-- Repository associated with uri string `a_uri'	
		local
			iri: IRI
		do
			create iri.make_from_string (a_uri)
			if iri.is_valid then
				Result := repository (iri.to_uri)
			end
		end

feature -- Access: packages

	is_package_installed (a_package: IRON_PACKAGE): BOOLEAN
			-- Is package `a_package' installed?
		deferred
		end

	installed_packages: LIST [IRON_PACKAGE]
			-- List of installed packages.
		deferred
		end

	available_packages: LIST [IRON_PACKAGE]
			-- List of available packages.	
		deferred
		end

	available_path_associated_with_uri (a_uri: URI): detachable PATH
			-- Expected installation path of available package associated with `a_uri'.
		deferred
		end

	package_associated_with_id (a_id: READABLE_STRING_GENERAL): detachable IRON_PACKAGE
			-- Available package associated with `a_id'.
		do
			across
				repositories as c
			until
				Result /= Void
			loop
				Result := c.package_associated_with_id (a_id)
			end
		end

	package_associated_with_uri (a_uri: URI): detachable IRON_PACKAGE
			-- Available package associated with `a_uri'.
		local
			s: STRING
		do
			s := a_uri.string
			across
				repositories as c
			until
				Result /= Void
			loop
				Result := c.package_associated_with_uri (a_uri)
			end
		end

	packages_associated_with_name (a_name: READABLE_STRING_GENERAL): detachable LIST [IRON_PACKAGE]
			-- List of available packages with name `a_name'.	
			--| used to find out conflicts.
		do
			create {ARRAYED_LIST [IRON_PACKAGE]} Result.make (1)
			across
				repositories as ic
			loop
				if attached ic.packages_associated_with_name (a_name) as lst then
					Result.append (lst)
				end
			end
			if Result.is_empty then
				Result := Void
			end
		end

feature -- Operation

	update
			-- Update catalog.
		deferred
		end

	update_repository (repo: IRON_REPOSITORY; is_silent: BOOLEAN)
			-- Update repository `repo'.
		deferred
		end

feature -- Package operations

	download_package (a_repo: IRON_WEB_REPOSITORY; a_package: IRON_PACKAGE; ignoring_cache: BOOLEAN)
		deferred
		end

	install_package (a_repo: IRON_REPOSITORY; a_package: IRON_PACKAGE; ignoring_cache: BOOLEAN)
			-- Install package `a_package' from repository `a_repo'.
			-- If `ignoring_cache' is True, the archive will be download again even if it was already download before.
		deferred
		end

	setup_package_installation (a_package: IRON_PACKAGE; cl_succeed: detachable CELL [BOOLEAN]; is_silent: BOOLEAN)
			-- Process setup instruction for installed package `a_package'.
		require
			is_package_installed: is_package_installed (a_package)
		deferred
		end

	uninstall_package (a_package: IRON_PACKAGE)
			-- Uninstall `a_package'.
		deferred
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
