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

	repositories: LIST [IRON_REPOSITORY]
		deferred
		end

	register_repository (a_name: READABLE_STRING_8; a_repo: IRON_REPOSITORY)
		deferred
		end

	unregister_repository (a_name_or_uri: READABLE_STRING_GENERAL)
		deferred
		end

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
				available_packages as p
			until
				Result /= Void
			loop
				if a_id.is_case_insensitive_equal (p.item.id) then
					Result := p.item
				end
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
				repo /= Void
			loop
				if s.starts_with (c.item.url) then
					repo := c.item
				end
			end
			if repo /= Void then
				s := s.substring (repo.url.count + 1, s.count)
				across
					repo.available_packages as p
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

feature -- Operation

	update
			-- Update catalog.
		deferred
		end

feature -- Package operations

	download_package (a_package: IRON_PACKAGE)
		deferred
		end

	install_package (a_package: IRON_PACKAGE)
			-- Install `a_package'.
		deferred
		end

	uninstall_package (a_package: IRON_PACKAGE)
			-- Uninstall `a_package'.
		deferred
		end

end
