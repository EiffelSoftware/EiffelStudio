note
	description: "Summary description for {IRON_REPO_DATABASE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IRON_REPO_DATABASE

inherit
	IRON_REPO_EXPORTER

feature -- Initialization

	initialize
		deferred
		ensure
			is_available
		end

feature -- Status report

	is_available: BOOLEAN
		deferred
		end

feature -- Credential

	is_valid_credential (u: READABLE_STRING_GENERAL; p: detachable READABLE_STRING_GENERAL): BOOLEAN
		deferred
		end

	user (u: READABLE_STRING_GENERAL): detachable IRON_REPO_USER
		deferred
		end

	user_by_email (a_email: READABLE_STRING_GENERAL): detachable IRON_REPO_USER
		deferred
		end

	update_user (u: IRON_REPO_USER)
		deferred
		end

feature -- Version

	versions: ITERABLE [IRON_REPO_VERSION]
		deferred
		end

feature -- Package

	update_package (v: IRON_REPO_VERSION; a_package: IRON_REPO_PACKAGE)
		deferred
		ensure
			has_id: a_package.has_id
		end

	delete_package (v: IRON_REPO_VERSION; a_package: IRON_REPO_PACKAGE)
		require
			has_id: a_package.has_id
		deferred
		ensure
			has_no_id: not a_package.has_id
			package (v, old a_package.id) = Void
		end

	save_uploaded_package_archive (v: IRON_REPO_VERSION; a_package: IRON_REPO_PACKAGE; a_file: WSF_UPLOADED_FILE)
		require
			has_id: a_package.has_id
		deferred
		ensure
			has_archive: a_package.has_archive
		end

	save_package_archive (v: IRON_REPO_VERSION; a_package: IRON_REPO_PACKAGE; a_file: PATH; a_keep_source_file: BOOLEAN)
		require
			has_id: a_package.has_id
		deferred
		ensure
			has_archive: a_package.has_archive
		end

	delete_package_archive (v: IRON_REPO_VERSION; a_package: IRON_REPO_PACKAGE)
		require
			has_id: a_package.has_id
			has_archive: a_package.has_archive
		deferred
		ensure
			has_no_archive: not a_package.has_archive
		end

	package (v: IRON_REPO_VERSION; a_id: READABLE_STRING_GENERAL): detachable IRON_REPO_PACKAGE
		deferred
		end

	package_by_path (v: IRON_REPO_VERSION; a_path: READABLE_STRING_GENERAL): detachable IRON_REPO_PACKAGE
		deferred
		end

	path_associated_with_package (v: IRON_REPO_VERSION; a_package: IRON_REPO_PACKAGE): ITERABLE [READABLE_STRING_32]
		deferred
		end

	associate_package_with_path (v: IRON_REPO_VERSION; a_package: IRON_REPO_PACKAGE; a_path: READABLE_STRING_GENERAL)
		require
			a_package_with_id: a_package.has_id
			a_path_not_empty: not a_path.is_empty
			path_unassociated: package_by_path (v, a_path) = Void
		deferred
		ensure
			path_associated: package_by_path (v, a_path) ~ a_package
		end

	unassociate_package_with_path (v: IRON_REPO_VERSION; a_package: IRON_REPO_PACKAGE; a_path: READABLE_STRING_GENERAL)
		require
			a_package_with_id: a_package.has_id
			a_path_not_empty: not a_path.is_empty
			path_associated: package_by_path (v, a_path) ~ a_package
		deferred
		ensure
			path_unassociated: package_by_path (v, a_path) = Void
		end

	packages (v: IRON_REPO_VERSION; a_lower, a_upper: INTEGER): detachable LIST [IRON_REPO_PACKAGE]
		deferred
		end

	path_browse_index (v: IRON_REPO_VERSION; a_path: READABLE_STRING_GENERAL): detachable ITERABLE [READABLE_STRING_32]
		deferred
		end

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
