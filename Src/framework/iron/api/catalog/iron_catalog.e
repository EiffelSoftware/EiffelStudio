note
	description: "Summary description for {IRON_CATALOG}."
	author: ""
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

	repositories: STRING_TABLE [IRON_REPOSITORY]
		deferred
		end

	register_repository (a_name: READABLE_STRING_8; a_repo: IRON_REPOSITORY)
		deferred
		end

	unregister_repository (a_name_or_uri: READABLE_STRING_GENERAL)
		deferred
		end

	repository (a_version_uri: URI): detachable IRON_REPOSITORY
		deferred
		end

feature -- Access: packages

	installed_packages: LIST [IRON_PACKAGE]
		deferred
		end

	available_packages: LIST [IRON_PACKAGE]
		deferred
		end

	available_path_associated_with_uri (a_uri: URI): detachable PATH
		deferred
		end

	package_associated_with_id (a_id: READABLE_STRING_GENERAL): detachable IRON_PACKAGE
		do
			across
				repositories as c
			until
				Result /= Void
			loop
				Result := c.item.package_associated_with_id (a_id)
			end
		end

	package_associated_with_uri (a_uri: URI): detachable IRON_PACKAGE
		local
			s: STRING
		do
			s := a_uri.string
			across
				repositories as c
			until
				Result /= Void
			loop
				if s.starts_with (c.item.url) then
					Result := c.item.package_associated_with_uri (a_uri)
				end
			end
		end

	packages_associated_with_name (a_name: READABLE_STRING_GENERAL): detachable LIST [IRON_PACKAGE]
		do
			create {ARRAYED_LIST [IRON_PACKAGE]} Result.make (1)
			across
				repositories as ic
			loop
				if attached ic.item.packages_associated_with_name (a_name) as lst then
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

	download_package (a_package: IRON_PACKAGE; ignoring_cache: BOOLEAN)
		deferred
		end

	install_package (a_package: IRON_PACKAGE; ignoring_cache: BOOLEAN)
			-- Install `a_package'.
		deferred
		end

	uninstall_package (a_package: IRON_PACKAGE)
			-- Uninstall `a_package'.
		deferred
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
