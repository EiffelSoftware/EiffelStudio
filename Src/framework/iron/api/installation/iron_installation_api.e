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
			create d.make_with_path (layout.package_installation_path (a_package))
			Result := d.exists and then not d.is_empty
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
		local
			s,r: STRING
			l_pn_item: READABLE_STRING_8
			l_package: detachable IRON_PACKAGE
			repo_url: READABLE_STRING_8
			iri: IRI
			l_uri: READABLE_STRING_8
		do
			create iri.make_from_string (a_uri)
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
				Result := layout.package_installation_path (l_package)
				if (create {DIRECTORY}.make_with_path (Result)).exists then
					Result := Result.extended (r)
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

end
