note
	description: "Summary description for {IRON_CATALOG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IRON_CATALOG

feature -- Access

	layout: IRON_LAYOUT
		deferred
		end

feature -- Access: repository		

	repositories: LIST [IRON_REPOSITORY]
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
			repo: detachable IRON_REPOSITORY
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
		local
			l_package: detachable IRON_PACKAGE
		do
			create {ARRAYED_LIST [IRON_PACKAGE]} Result.make (1)
			across
				repositories as r
			loop
				if attached r.item.packages_associated_with_name (a_name) as lst then
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

end
