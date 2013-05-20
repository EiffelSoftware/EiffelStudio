note
	description: "Summary description for {IRON_FS_CATALOG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_FS_CATALOG

inherit
	IRON_CATALOG

	IRON_EXPORTER

create
	make

feature {NONE} -- Initialization

	make (a_layout: IRON_LAYOUT)
		do
			layout := a_layout

			ensure_folder_exists (a_layout.repositories_path)
			ensure_folder_exists (a_layout.archives_path)
			ensure_folder_exists (a_layout.packages_path)

			load_repositories

			create installation_api.make_with_layout (a_layout)
		end

	installation_api: IRON_INSTALLATION_API

	load_repositories
		local
			repo_conf: IRON_REPOSITORY_CONFIGURATION_FILE
		do
			create repo_conf.make (layout.repositories_configuration_file)

			create repositories.make (1)
			across
				repo_conf.repositories as c
			loop
				repositories.force (c.item)
			end

			across
				repositories as c
			loop
				fill_repository (c.item)
			end
		end

	ensure_folder_exists (p: PATH)
		local
			d: DIRECTORY
		do
			create d.make_with_path (p)
			if not d.exists then
				d.recursive_create_dir
			end
		end

	layout: IRON_LAYOUT

feature -- Access: repository

	repositories: ARRAYED_LIST [IRON_REPOSITORY]

	register_repository (a_name: READABLE_STRING_8; a_repo: IRON_REPOSITORY)
		local
			repo_conf: IRON_REPOSITORY_CONFIGURATION_FILE
		do
			create repo_conf.make (layout.repositories_configuration_file)
			repo_conf.add_repository (a_name, a_repo)
			repo_conf.save
			load_repositories
		end

	unregister_repository (a_name_or_uri: READABLE_STRING_GENERAL)
		local
			repo: detachable IRON_REPOSITORY
			repo_conf: IRON_REPOSITORY_CONFIGURATION_FILE
			repo_name: detachable READABLE_STRING_GENERAL
		do
			create repo_conf.make (layout.repositories_configuration_file)
			if a_name_or_uri.starts_with ("http://") or a_name_or_uri.starts_with ("https://") then
				across
					repo_conf.repositories as c
				until
					repo_name /= Void
				loop
					if a_name_or_uri.same_string (c.item.uri.string) then
						repo_name := c.key
						repo := c.item
					end
				end
			else
				repo_name := a_name_or_uri
			end
			if repo_name /= Void then
				repo_conf.remove_repository (repo_name)
				repo_conf.save
			end
			load_repositories
		end

feature -- Acces: package

	installed_packages: LIST [IRON_PACKAGE]
		do
			Result := installation_api.installed_packages
		end

	available_packages: LIST [IRON_PACKAGE]
		do
			create {ARRAYED_LIST [IRON_PACKAGE]} Result.make (10)
			across
				repositories as c
			loop
				across
					c.item.available_packages as p
				loop
					Result.force (p.item)
				end
			end
		end

	available_path_associated_with_uri (a_uri: URI): detachable PATH
		local
			repo: detachable IRON_REPOSITORY
			s,r: STRING
			l_package: detachable IRON_PACKAGE
		do
			s := a_uri.string
			create r.make_empty
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
					l_package /= Void
				loop
					across
						p.item.associated_paths as pn
					until
						l_package /= Void
					loop
						if s.starts_with (pn.item) then
							l_package := p.item
							r.wipe_out
							r.append (s.substring (pn.item.count + 1, s.count))
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
		end

feature -- Operation

	update
		do
			across
				repositories as c
			loop
				update_repository (c.item)
			end
		end

	fill_repository (repo: IRON_REPOSITORY)
		local
			f: RAW_FILE
			p: PATH
			retried: BOOLEAN
		do
			if not retried then
				p := layout.repository_path (repo)
				create f.make_with_path (p)
				if f.exists and then f.is_access_readable then
					f.open_read
					if attached {IRON_REPOSITORY} f.retrieved as l_repo then
						repo.set_package_list (l_repo.available_packages)
					end
					f.close
				end
			else
				repo.available_packages.wipe_out
			end
		rescue
			retried := True
			retry
		end

	save_repository (repo: IRON_REPOSITORY)
		local
			f: RAW_FILE
			p: PATH
		do
			p := layout.repository_path (repo)
			create f.make_with_path (p)
			f.create_read_write
			f.independent_store (repo)
			f.close
		end

feature -- Package operations

	path_to_uri_string (p: PATH): STRING_32
		do
			Result := (create {IRON_UTILITIES}).path_to_uri_string (p)
		end

--	uri_to_path (u: URI): PATH
--		do

--			Result := (create {IRON_UTILITIES}).uri_to_path (u)
--		end

	download_package (a_package: IRON_PACKAGE)
		local
			cl: like new_client
			ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT
			f: RAW_FILE
			p: PATH
			hdate: HTTP_DATE
			h: HTTP_HEADER
		do
			cl := new_client
			if attached a_package.archive_uri as l_uri then
				if attached cl.new_session (l_uri.string) as sess then
--					sess.add_header ("Accept", "application/zip")
					create ctx.make

					p := layout.package_archive_path (a_package)
					create f.make_with_path (p)
					if f.exists then
						create h.make_with_count (1)
						create hdate.make_from_timestamp (f.date)
						h.put_header_key_value ({HTTP_HEADER_NAMES}.header_if_modified_since, hdate.rfc1123_string)
						ctx.add_header_lines (h)
					end
					ensure_folder_exists (p.parent)
					create f.make_with_path (p)
					f.create_read_write
					ctx.set_output_content_file (f)
					if attached sess.get ("", ctx) as res then
						a_package.set_archive_uri (path_to_uri_string (p.absolute_path.canonical_path))
					end
					f.close
				end
			end
		end

	install_package (a_package: IRON_PACKAGE)
			-- Install `a_package'.
		local
			p: PATH
			l_uri: detachable URI
			ipu: IRON_UTILITIES
			f: RAW_FILE
			j: STRING
			js: JSON_STRING
		do
			l_uri := a_package.archive_uri
			if l_uri /= Void then
				if a_package.has_archive_file_uri then
					p := layout.package_installation_path (a_package)
					print ("Installing " + p.utf_8_name + "%N")
					create ipu
					ensure_folder_exists (p.parent)

					if attached a_package.json_item as l_json then
						create j.make (l_json.count)
						j.append_character ('{')
						j.append ("%"repository%": {")
						j.append ("%"uri%":")
						js := a_package.repository.uri.string
						j.append (js.representation)
						j.append_character (',')
						j.append ("%"version%":")
						js := a_package.repository.version
						j.append (js.representation)
						j.append_character ('}')
						j.append_character (',')
						j.append ("%"package%":")
						j.append (l_json)
						j.append_character ('}')

						create f.make_with_path (p.appended_with_extension ("info"))
						f.create_read_write
						f.put_string (j)
						f.close
					end

					ipu.extract_package_archive (a_package, p, True)

					installed_packages.force (a_package)
				else
						-- missing local archive
					download_package (a_package)

					if a_package.has_archive_file_uri then
							-- try again
						install_package (a_package)
					else
						-- nothing was download
					end
				end
			else
				-- no archive  (local or remote)
			end
		end

	uninstall_package (a_package: IRON_PACKAGE)
			-- Uninstall `a_package'.
		local
			p: PATH
			d: DIRECTORY
			f: RAW_FILE
		do
			p := layout.package_installation_path (a_package)
			create d.make_with_path (p)
			if d.exists then
				d.recursive_delete
			end

			p := p.appended_with_extension ("info")
			create f.make_with_path (p)
			if f.exists then
				f.delete
			end

			p := layout.package_archive_path (a_package)
			create f.make_with_path (p)
			if f.exists then
				f.delete
			end

			installed_packages.prune (a_package)
		end

feature -- Restricted

	update_repository (repo: IRON_REPOSITORY)
		local
			cl: HTTP_CLIENT
		do
			print ("Updating repository " + repo.uri.string + " version=" + repo.version + " ...%N")
			cl := new_client
			if attached cl.new_session (repo.uri.string) as sess then
				sess.add_header ("Accept", "application/json")
				if attached sess.get ("/access/" + repo.version + "/package/", Void) as res then
					if res.error_occurred then
						print ("ERROR: connection%N")
					elseif attached res.body as l_body then
						repo.available_packages.wipe_out
						import_packages_from_json (l_body, repo)
						if repo.available_packages.is_empty then
							print ("ERROR: invalid data!%N")
						end
					else
						print ("ERROR: empty%N")
					end
				else
					print ("ERROR: connection%N")
				end
			end
			print ("Updating repository " + repo.uri.string + " version=" + repo.version + " : completed.%N")
			save_repository (repo)
		end

	import_packages_from_json (a_json_string: READABLE_STRING_8; repo: IRON_REPOSITORY)
		local
			f: JSON_TO_IRON_FACTORY
		do
			create f
			if attached f.json_to_packages (a_json_string, repo) as lst then
				across
					lst as p
				loop
					repo.put_package (p.item)
					print ("- ")
					print (p.item.human_identifier)
					print ("%N")
				end
			end
		end

feature {NONE} -- Helper

	new_client: HTTP_CLIENT
		do
			create {LIBCURL_HTTP_CLIENT} Result.make
		end

end
