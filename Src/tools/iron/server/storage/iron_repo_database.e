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

	is_valid_credential (u: like {IRON_REPO_USER}.name; p: detachable READABLE_STRING_GENERAL): BOOLEAN
		deferred
		end

	user (u: like {IRON_REPO_USER}.name): detachable IRON_REPO_USER
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

end
