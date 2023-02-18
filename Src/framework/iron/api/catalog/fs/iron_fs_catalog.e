note
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_FS_CATALOG

inherit
	IRON_CATALOG

	IRON_EXPORTER

	REFACTORING_HELPER

	SHARED_EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make (a_layout: IRON_LAYOUT; a_urls: like urls)
		do
			layout := a_layout
			urls := a_urls
			create installation_api.make_with_layout (a_layout, a_urls)

			ensure_folder_exists (a_layout.repositories_path)
			ensure_folder_exists (a_layout.archives_path)
			ensure_folder_exists (a_layout.packages_path)

			repositories := installation_api.db.repositories
			load_repositories
		end

	load_repositories
		do
			across
				repositories as c
			loop
				fill_repository (c)
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

	installation_api: IRON_INSTALLATION_API

feature -- Access: repository

	repositories: LIST [IRON_REPOSITORY]

	register_repository (a_repo: IRON_REPOSITORY)
		do
			installation_api.db.save_repository (a_repo)
			fill_repository (a_repo)
		end

	unregister_repository (a_uri: READABLE_STRING_GENERAL)
		do
			installation_api.db.remove_repository_by_uri (a_uri)
			if attached repository_at (a_uri) as repo then
				layout.iron_safe_delete_folder (layout.repository_data_folder (repo))
--				layout.iron_safe_delete_file (layout.repository_packages_data_path (repo))
				layout.iron_safe_delete_folder (layout.repository_archive_path (repo))
			end
			installation_api.refresh
		end

	repository (a_location: URI): detachable IRON_REPOSITORY
		do
			across
				repositories as c
			until
				Result /= Void
			loop
				if c.is_located_at (a_location) then
					Result := c
				end
			end
		end

	is_package_installed (a_package: IRON_PACKAGE): BOOLEAN
			-- Is package `a_package' installed?
		do
			Result := installation_api.is_package_installed (a_package)
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
					c.available_packages as p
				loop
					Result.force (p)
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
				if s.starts_with (c.location_string) then
					repo := c
				end
			end
			if repo /= Void then
				s := s.substring (repo.location_string.count + 1, s.count)
				across
					repo.available_packages as p
				until
					l_package /= Void
				loop
					across
						p.associated_paths as pn
					until
						l_package /= Void
					loop
						if s.starts_with (pn) then
							l_package := p
							r.wipe_out
							r.append (s.substring (pn.count + 1, s.count))
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
				update_repository (c, False)
			end
		end

	update_repository (repo: IRON_REPOSITORY; is_silent: BOOLEAN)
		local
			remote_node: IRON_REMOTE_NODE
			dir_vis: IRON_PACKAGE_FILE_SCANNER
			p: IRON_PACKAGE
			l_package_file_factory: IRON_PACKAGE_FILE_FACTORY
			pif: IRON_PACKAGE_FILE
			l_last_operation_succeed: BOOLEAN
		do
			if not is_silent then
				print ("Updating repository " + repo.location_string + " ...%N")
			end
			repo.reset_available_packages
			if attached {IRON_WEB_REPOSITORY} repo as l_remote_repo then
				create remote_node.make_with_repository (urls, api_version, l_remote_repo)
				if attached remote_node.packages as lst then
					l_last_operation_succeed := remote_node.last_operation_succeed
					if l_last_operation_succeed then
						across lst as ic loop
							if not is_silent then
								print ("- ")
								print (ic.human_identifier)
								print ("%N")
							end
							repo.put_package (ic)
						end
					elseif not is_silent then
						if attached remote_node.last_operation_error_message as err then
							print ("ERROR: " + err + "%N")
						else
							print ("ERROR: unable to get packages information!%N")
						end
					end
				end
			elseif attached {IRON_WORKING_COPY_REPOSITORY} repo as l_wc_repo then
				if l_wc_repo.exists then
					create dir_vis.make_empty
					dir_vis.set_default_iron_file_name ("package.iron")
					dir_vis.exclude_directory_names (<<"EIFGENs", ".svn", ".git">>)
					dir_vis.stop_on_first_matching_file (True)
					dir_vis.process_directory (l_wc_repo.path)
					create l_package_file_factory
					across
						dir_vis.list as ic
					loop
						pif := l_package_file_factory.new_package_file (ic)
						p := pif.to_package (l_wc_repo)
						if not is_silent then
							print ("- ")
							print (p.human_identifier)
							print ("%N")
							if not pif.has_expected_file_name then
								print ("!Warning: expected file name is %"")
								print (pif.expected_file_name)
								print ("%" instead of %"")
								print (ic)
								print ("%"%N")
							end
						end
						repo.put_package (p)
					end
				else
					if not is_silent then
						print ("ERROR: Repository %"" + l_wc_repo.location_string + "%" does not exist!%N")
					end
				end
			else
				debug ("refactor_fixme")
					fixme ("Local repository update is not yet implemented%N")
				end
				print ("Local repository update is not yet implemented%N")
			end
			save_updated_repository (repo)
		end

	fill_repository (repo: IRON_REPOSITORY)
		local
			f: RAW_FILE
			p: PATH
			retried: BOOLEAN
		do
			if not retried then
				p := layout.repository_data_file (repo)
				create f.make_with_path (p)
				if f.exists and then f.is_access_readable then
					f.open_read
					if attached {IRON_REPOSITORY} f.retrieved as l_repo then
						repo.set_package_list (l_repo.available_packages)
					end
					f.close
				end
			else
				repo.reset_available_packages
			end
		rescue
			retried := True
			retry
		end

	save_updated_repository (repo: IRON_REPOSITORY)
		local
			f: RAW_FILE
			p: PATH
		do
			installation_api.db.save_available_repository_packages (repo)

				-- Save repository object
			p := layout.repository_data_file (repo)
			ensure_folder_exists (p.parent)
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

	download_package (a_repository: IRON_WEB_REPOSITORY; a_package: IRON_PACKAGE; ignoring_cache: BOOLEAN)
		local
			f: RAW_FILE
			p: PATH
			remote_node: IRON_REMOTE_NODE
		do
			p := layout.package_archive_path (a_package)
			ensure_folder_exists (p.parent)
			if a_package.has_archive_uri then
				create remote_node.make_with_repository (urls, api_version, a_repository)
				remote_node.download_package_archive (a_package, p, ignoring_cache)
				create f.make_with_path (p)
				if f.exists then
					a_package.set_archive_path (p.absolute_path.canonical_path)
				else
						-- Failure
				end
			end
		end

	install_package (a_repo: IRON_REPOSITORY; a_package: IRON_PACKAGE; ignoring_cache: BOOLEAN)
			-- <Precursor>
		do
			if attached {IRON_WEB_REPOSITORY} a_repo as l_web_repo then
				install_web_package (l_web_repo, a_package, ignoring_cache)
			elseif attached {IRON_WORKING_COPY_REPOSITORY} a_repo as l_wc_repo then
				install_fs_package (l_wc_repo, a_package)
			else
				check unsupported: False end
			end
		end

	install_fs_package (a_repo: IRON_WORKING_COPY_REPOSITORY; a_package: IRON_PACKAGE)
				-- Install `a_package' from local (file system) iron repository.
		local
			pii: IRON_PACKAGE_INSTALLATION_INFO
			p_info: PATH
			d: DIRECTORY
		do
			p_info := layout.package_installation_info_path (a_package)
			if attached layout.package_installation_path (a_package) as p then

				create d.make_with_path (p)
				if d.exists then
					create pii.make_with_package (a_package, p_info, p)
					pii.save
					on_package_just_installed (a_package)
				end
			end
		end

	install_web_package (a_repo: IRON_WEB_REPOSITORY; a_package: IRON_PACKAGE; ignoring_cache: BOOLEAN)
			-- Install `a_package' from web iron repository.
		local
			p: detachable PATH
			p_info,p_renaming,t: PATH
			l_uri: detachable URI
			ipu: IRON_UTILITIES
			f: RAW_FILE
--			j: STRING
--			js: JSON_STRING
			d: DIRECTORY
			i: INTEGER
			pii: IRON_PACKAGE_INSTALLATION_INFO
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
							create pii.make_with_package (a_package, p_info, p)
							pii.save
							on_package_just_installed (a_package)
						else
							layout.iron_safe_delete_folder (d.path)
						end
					end
				else
						-- missing local archive
					download_package (a_repo, a_package, ignoring_cache)

					if a_package.has_archive_file_uri then
							-- try again
						install_package (a_repo, a_package, ignoring_cache)
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
		do
				-- Installation info file.
			layout.iron_safe_delete_file (layout.package_installation_info_path (a_package))

			if a_package.is_local_working_copy then
					-- DO NOT REMOVE local source folder
					-- No archive file to delete for local package
			else
				layout.iron_safe_delete_folder (layout.package_installation_path (a_package))

					-- Eventual renaming installation path
				layout.iron_safe_delete_file (layout.package_renaming_installation_path (a_package))

					-- Associated archive file
				layout.iron_safe_delete_file (layout.package_archive_path (a_package))
			end

			installed_packages.prune (a_package)
		end

	on_package_just_installed (a_package: IRON_PACKAGE)
			-- `a_package' just got installed.
		do
			installed_packages.force (a_package)
		end

	setup_package_installation (a_package: IRON_PACKAGE; cl_succeed: detachable CELL [BOOLEAN]; is_silent: BOOLEAN)
			-- <Precursor}
		local
			pif_fac: IRON_PACKAGE_FILE_FACTORY
			ip,p: detachable PATH
			ut: FILE_UTILITIES
			envs: STRING_TABLE [detachable READABLE_STRING_GENERAL]
			cl_code: CELL [INTEGER]
			l_ok: BOOLEAN
		do
			l_ok := True
			create pif_fac
			ip := layout.package_installation_path (a_package)
			if ip /= Void then
				p := ip.extended ("package.iron")
				if
					ut.file_path_exists (p) and then
					attached pif_fac.new_package_file (p) as pif
				then
					if attached pif.setup_operations as l_operations then
						create envs.make (3)
						envs.force (execution_environment.item ("IRON_PATH"), "IRON_PATH")
						envs.force (execution_environment.item ("IRON_PACKAGE_PATH"), "IRON_PACKAGE_PATH")
						envs.force (execution_environment.item ("IRON_PACKAGE_NAME"), "IRON_PACKAGE_NAME")

						execution_environment.put (layout.path.name, "IRON_PATH")
						execution_environment.put (ip.name, "IRON_PACKAGE_PATH")
						execution_environment.put (a_package.identifier, "IRON_PACKAGE_NAME")

						across
							l_operations as ic
						loop
							if ic.name.is_case_insensitive_equal ("compile_library") then
								create cl_code.put (0)
								if is_silent then
									execute_command_line (finish_freezing_command_name, ip.extended (ic.instruction), agent (s: STRING) do end, cl_code)
								else
									execute_command_line (finish_freezing_command_name, ip.extended (ic.instruction), agent (s: STRING) do print (s) end, cl_code)
								end
								l_ok := l_ok and cl_code.item = 0
							else
								if not is_silent then
									print (" ##setup %"")
									print (ic)
									print ("%" ignored.##")
								end
							end
						end
						across
							envs as ic
						loop
							if attached ic as v then
								execution_environment.put (v, @ ic.key)
							else
								execution_environment.put ("", @ ic.key) -- FIXME: would be better to use unsetenv but this is not available.
							end
						end
					end
				end
			end
			if cl_succeed /= Void then
				cl_succeed.replace (l_ok)
			end
		end

	finish_freezing_command_name: STRING_32
		local
			p: detachable PATH
		do
			if attached execution_environment.item ("ISE_EIFFEL") as l_ise_eiffel then
				if attached execution_environment.item ("ISE_PLATFORM") as l_ise_platform then
					create p.make_from_string (l_ise_eiffel)
					p := p.extended ("studio").extended ("spec").extended (l_ise_platform).extended ("bin")
				end
			end
			if p /= Void then
				if {PLATFORM}.is_windows then
					Result := p.extended ("finish_freezing.exe").name  + {STRING_32} " -library"
				else
					Result := p.extended ("finish_freezing").name + {STRING_32} " -library"
				end
			else
				if {PLATFORM}.is_windows then
					Result := {STRING_32} "finish_freezing.bat -library"
				else
					Result := {STRING_32} "finish_freezing -library"
				end
			end
		end

	execute_command_line (a_command_line: READABLE_STRING_GENERAL; a_dir: detachable PATH; agt_output: detachable PROCEDURE [STRING_8]; cell_return_code: detachable CELL [INTEGER])
			-- Execute `a_command_line' in folder `a_dir' (if provided),
			-- return the exit code in `cell_return_code.item' if `cell_return_code' is provided,
			-- and return the output in `cell_output.item' if `a_output' is provided.
		local
			proc_fact: PROCESS_FACTORY
			proc: PROCESS
			wdir: detachable READABLE_STRING_GENERAL
		do
			create proc_fact
			if a_dir /= Void then
				wdir := a_dir.name
			end
			proc := proc_fact.process_launcher_with_command_line (a_command_line, wdir)
			if agt_output /= Void then
				proc.redirect_output_to_agent (agt_output)
				proc.redirect_error_to_same_as_output
			else
				proc.cancel_output_redirection
			end
			proc.launch
			if proc.launched then
				proc.wait_for_exit
			end
			if cell_return_code /= Void then
				if proc.launched then
					cell_return_code.replace (proc.exit_code)
				else
					cell_return_code.replace (-1)
				end
			end
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
					repo.put_package (p)
					if not is_silent then
						print ("- ")
						print (p.human_identifier)
						print ("%N")
					end
				end
			end
		end

feature {NONE} -- Helper

	new_client: HTTP_CLIENT
		do
			create {DEFAULT_HTTP_CLIENT} Result
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
