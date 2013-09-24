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

	make (a_layout: IRON_LAYOUT; a_urls: like urls)
		do
			layout := a_layout
			urls := a_urls

			ensure_folder_exists (a_layout.repositories_path)
			ensure_folder_exists (a_layout.archives_path)
			ensure_folder_exists (a_layout.packages_path)

			load_repositories

			create installation_api.make_with_layout (a_layout, a_urls)
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

feature -- Access		

	layout: IRON_LAYOUT

	urls: IRON_URL_BUILDER

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

	repository (a_version_uri: URI): detachable IRON_REPOSITORY
		do
			across
				repositories as c
			until
				Result /= Void
			loop
				if c.item.version_uri.is_same_uri (a_version_uri) then
					Result := c.item
				end
			end
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
					if Result /= Void and then (create {DIRECTORY}.make_with_path (Result)).exists then
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
				update_repository (c.item, False)
			end
		end

	update_repository (repo: IRON_REPOSITORY; is_silent: BOOLEAN)
		local
			cl: HTTP_CLIENT
		do
			if not is_silent then
				print ("Updating repository " + repo.uri.string + " version=" + repo.version + " ...%N")
			end
			cl := new_client
			if attached cl.new_session (repo.uri.string) as sess then
				sess.add_header ("Accept", "application/json")
				if attached sess.get (urls.path_package_list (repo), Void) as res then
					if res.error_occurred then
						if not is_silent then
							print ("ERROR: connection%N")
						end
					elseif attached res.body as l_body then
						repo.available_packages.wipe_out
						import_packages_from_json (l_body, repo, is_silent)
						if not is_silent and then repo.available_packages.is_empty then
							print ("ERROR: invalid data!%N")
						end
					else
						if not is_silent then
							print ("ERROR: empty%N")
						end
					end
				else
					if not is_silent then
						print ("ERROR: connection%N")
					end
				end
			end
			save_repository (repo)
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

	download_package (a_package: IRON_PACKAGE; ignoring_cache: BOOLEAN)
		local
			cl: like new_client
			ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT
			f: RAW_FILE
			p,t: PATH
			hdate: HTTP_DATE
			h: HTTP_HEADER
			res: HTTP_CLIENT_RESPONSE
		do
			cl := new_client
			if attached a_package.archive_uri as l_uri then
				if attached cl.new_session (l_uri.string) as sess then
--					sess.add_header ("Accept", "application/zip")
					create ctx.make
					sess.set_timeout (0)

					p := layout.package_archive_path (a_package)
					create f.make_with_path (p)
					if f.exists then
						if ignoring_cache then
							f.delete
						else
							create h.make_with_count (1)
							create hdate.make_from_timestamp (f.date)
							h.put_header_key_value ({HTTP_HEADER_NAMES}.header_if_modified_since, hdate.rfc1123_string)
							ctx.add_header_lines (h)
						end
					end
					t := p.appended_with_extension ("tmp-download")
					ensure_folder_exists (p.parent)
					ensure_folder_exists (t.parent)
					create f.make_with_path (t)
					f.create_read_write
					ctx.set_output_content_file (f)
					res := sess.get ("", ctx)
					if res.error_occurred then
						f.close
						f.delete
					else
						a_package.set_archive_uri (path_to_uri_string (p.absolute_path.canonical_path))
						f.close
						if res.status = {HTTP_STATUS_CODE}.not_modified then
							f.delete
						else
							f.rename_path (p)
							if f.exists and then f.is_empty then
									-- No empty package !!!
								f.delete
							end
						end
					end
				end
			end
		end

	install_package (a_package: IRON_PACKAGE; ignoring_cache: BOOLEAN)
			-- Install `a_package'.
		local
			p: detachable PATH
			p_info,p_renaming,t: PATH
			l_uri: detachable URI
			ipu: IRON_UTILITIES
			f: RAW_FILE
			j: STRING
			js: JSON_STRING
			d: DIRECTORY
			i: INTEGER
		do
			l_uri := a_package.archive_uri
			if l_uri /= Void then
				if a_package.has_archive_file_uri then
					p_renaming := layout.package_renaming_installation_path (a_package)
					p_info := layout.package_installation_info_path (a_package)
					create ipu
					ensure_folder_exists (p_renaming.parent)
					create f.make_with_path (p_renaming)
					if f.exists then
						-- Was renamed, then follow the new name
						p := layout.package_installation_path (a_package)
					end
					if p = Void then
							-- Expected folder for `a_package' local installation.
						p := layout.package_expected_installation_path (a_package)
						create d.make_with_path (p)
						if d.exists then
								-- There is conflict on package name
							t := p.appended ("-" + a_package.id)
							d.make_with_path (t)
							if d.exists then
									-- This is unlikely to occurs, but in this case,
									-- try to find a free name
								from
									i := 0
									t := p
								until
									not d.exists
								loop
									i := i + 1
									t := p.appended ("-" + i.out)
									d.make_with_path (t)
								end
							end
							p := t
							create f.make_with_path (p_renaming)
							f.create_read_write
							f.put_string (p.utf_8_name)
							f.close
						end
					end
					ipu.extract_package_archive (a_package, p, True, layout)
					create d.make_with_path (p)
					if d.exists then
						if not d.is_empty then
							create j.make (512)
							j.append_character ('{')
							if attached p.entry as p_entity then
								j.append ("%"local_path%": ")
								js := p_entity.name
								j.append (js.representation)
								j.append (",")
							end

							j.append ("%"repository%": {")
							j.append ("%"uri%":")
							js := a_package.repository.uri.string
							j.append (js.representation)
							j.append_character (',')
							j.append ("%"version%":")
							js := a_package.repository.version
							j.append (js.representation)
							j.append_character ('}')

							if attached a_package.json_item as l_json then
								j.append_character (',')
								j.append ("%"package%":")
								j.append (l_json)
							end
							j.append_character ('}')

							ensure_folder_exists (p_info.parent)
							create f.make_with_path (p_info)
							f.create_read_write
							f.put_string (j)
							f.put_new_line
							f.close

							installed_packages.force (a_package)
						else
							d.recursive_delete
						end
					end
				else
						-- missing local archive
					download_package (a_package, ignoring_cache)

					if a_package.has_archive_file_uri then
							-- try again
						install_package (a_package, ignoring_cache)
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
			p: detachable PATH
			d: DIRECTORY
			f: RAW_FILE
		do
			p := layout.package_installation_path (a_package)
			if p /= Void then
				create d.make_with_path (p)
				if d.exists then
					d.recursive_delete
				end
			end

			p := layout.package_installation_info_path (a_package)
			create f.make_with_path (p)
			if f.exists then
				f.delete
			end

			p := layout.package_renaming_installation_path (a_package)
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

	import_packages_from_json (a_json_string: READABLE_STRING_8; repo: IRON_REPOSITORY; is_silent: BOOLEAN)
		local
			f: JSON_TO_IRON_FACTORY
		do
			create f
			if attached f.json_to_packages (a_json_string, repo) as lst then
				across
					lst as p
				loop
					repo.put_package (p.item)
					if not is_silent then
						print ("- ")
						print (p.item.human_identifier)
						print ("%N")
					end
				end
			end
		end

feature {NONE} -- Helper

	new_client: HTTP_CLIENT
		do
			create {LIBCURL_HTTP_CLIENT} Result.make
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
