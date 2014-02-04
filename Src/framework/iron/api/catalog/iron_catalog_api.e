note
	description: "Summary description for {IRON_CATALOG_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_CATALOG_API

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

	repositories: STRING_TABLE [IRON_REPOSITORY]
		do
			Result := catalog.repositories
		end

	register_repository (a_name: READABLE_STRING_8; a_repo: IRON_REPOSITORY)
		do
			catalog.register_repository (a_name, a_repo)
		end

	unregister_repository (a_name_or_uri: READABLE_STRING_GENERAL)
		do
			catalog.unregister_repository (a_name_or_uri)
		end

	repository (a_uri: URI): detachable IRON_REPOSITORY
			-- Registered repository related to `a_uri'.
		do
			Result := catalog.repository (a_uri)
		end

feature -- Access: package	

	available_packages: ARRAYED_LIST [IRON_PACKAGE]
		do
			create Result.make (10)
			across
				repositories as c
			loop
				Result.append (c.item.available_packages)
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

	package_associated_with_uri (a_uri_string: READABLE_STRING_GENERAL): detachable IRON_PACKAGE
		local
			iri: IRI
		do
			create iri.make_from_string (a_uri_string)
			Result := catalog.package_associated_with_uri (iri.to_uri)
		end

	package_associated_with_id (a_id: READABLE_STRING_GENERAL): detachable IRON_PACKAGE
		do
			Result := catalog.package_associated_with_id (a_id)
		end

feature -- Operations

	download_package (a_package: IRON_PACKAGE; ignoring_cache: BOOLEAN)
		do
			catalog.download_package (a_package, ignoring_cache)
		end

	install_package (a_package: IRON_PACKAGE; ignoring_cache: BOOLEAN)
		do
			catalog.install_package (a_package, ignoring_cache)
		end

	uninstall_package (a_package: IRON_PACKAGE)
		do
			catalog.uninstall_package (a_package)
		end


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
