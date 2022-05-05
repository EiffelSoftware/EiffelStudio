note
	description: "Summary description for {IRON_SHARE_TASK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_SHARE_TASK

inherit
	IRON_TASK

	IRON_EXPORTER
		rename
			print as print_any
		end

create
	make

feature -- Access

	name: STRING = "share"
			-- Iron client task

feature -- Execute

	process (a_iron: IRON)
		local
			args: IRON_SHARE_ARGUMENT_PARSER
		do
			create args.make (Current)
			args.execute (agent execute (args, a_iron))
		end

	execute (args: IRON_SHARE_ARGUMENTS; a_iron: IRON)
		local
			l_data: like data_from
			uri: URI
			tgt: PATH
			l_remove_iron_archive: BOOLEAN
			l_package: detachable IRON_PACKAGE
			err, done: BOOLEAN
			l_title, l_name, l_id: detachable READABLE_STRING_32
			remote_node: IRON_REMOTE_NODE
			u,p, repo_url: detachable READABLE_STRING_32
			ini: INI_FILE
			cl_body: CELL [detachable READABLE_STRING_8]
			l_upload_new_archive: BOOLEAN
			l_iron_archive: detachable IRON_ARCHIVE
			l_local_hash: detachable READABLE_STRING_8
			b: BOOLEAN
		do
			err := False

			u := args.username
			p := args.password
			repo_url := args.repository

			if attached args.configuration_file as l_cfg then
				create ini.make_with_path (l_cfg)
				if u = Void then
					u := ini.adjusted_item ("username")
				end
				if p = Void then
					p := ini.adjusted_item ("password")
				end
				if repo_url = Void then
					repo_url := ini.adjusted_item ("repository")
				end
			end
			if
				u /= Void and p /= Void and
				repo_url /= Void and
				attached args.operation as op
			then
				create uri.make_from_string (repo_url.to_string_8)
				if
					uri.is_valid and then
					attached {IRON_WEB_REPOSITORY} a_iron.catalog_api.repository (uri) as repo
				then
					create remote_node.make_with_repository (a_iron.urls, a_iron.api_version, repo)

					l_data := data_from (args)
					if l_data /= Void then
						l_name := l_data.name
						l_title := l_data.title
						l_id := l_data.id

						if attached args.package_indexes as l_indexes then
							across
								l_indexes as c
							loop
								l_data.add_index (c.item)
							end
						end

						a_iron.catalog_api.update_repository (repo, True)
						if l_name /= Void then
							l_package := package_by_name_from_repo (repo, l_name)
						elseif l_id /= Void then
							l_package := repo.package_associated_with_id (l_id)
						end

						l_upload_new_archive := l_package = Void or else not l_package.has_archive_uri
											or else l_data.archive /= Void
											or else args.is_forcing

						if err then
							-- error
						elseif args.is_delete then
							if l_package /= Void then
								remote_node.delete_package (l_package, u, p)
								if remote_node.last_operation_succeed then
									print ("Package successfully deleted.")
									print_new_line
									done := True
								else
									if attached remote_node.last_operation_error_message as l_last_operation_error_message then
										print (l_last_operation_error_message)
									else
										print ("[Error] deletion failed!")
									end
									print_new_line
									err := True
								end
							else
								if l_name /= Void then
									print ({STRING_32} "[Error] Could not find package named %"" + l_name + "%" !")
								elseif l_id /= Void then
									print ({STRING_32} "[Error] Could not find package with id %"" + l_id + "%" !")
								else
									print ({STRING_32} "[Error] Could not find package !")
								end
								print_new_line
								err := True
							end
						elseif args.is_create then
							if l_package /= Void then
								err := True
								if l_name /= Void then
									print ({STRING_32} "[Error] a package with name %"" + l_name + "%" already exists!")
								else
									print ({STRING_32} "[Error] please provide a non empty name!")
								end
								print_new_line
							end
						else
							if args.is_update then
								if l_package = Void then
									err := True
									if l_name /= Void then
										print ({STRING_32} "[Error] Could not find package named %"" + l_name + "%" !")
									elseif l_id /= Void then
										print ({STRING_32} "[Error] Could not find package with id %"" + l_id + "%" !")
									else
										print ({STRING_32} "[Error] Could not find package !")
									end
									print_new_line
								else
									create {STRING_32} l_id.make_from_string_general (l_package.id)
								end
							else
								err := True
								print ({STRING_32} "[" + op + {STRING_32} "] Not yet supported!")
								print_new_line
							end
						end

						if not done and not err then
							if l_package = Void then
								if l_name /= Void then
									print ({STRING_32} "Create new package %"" + l_name + "%"%N")
								else
									print ({STRING_32} "Create new package %N")
								end
							else
								print ({STRING_32} "Update package " + l_package.human_identifier + {STRING_32} " %N")
							end
							remote_node.publish_package (l_id, l_name, l_title, l_data.description, l_data.package_file_location, l_package, Void, u, p)
							if remote_node.last_operation_succeed then
								if l_package /= Void then
									print ({STRING_32} "Package "+ l_package.human_identifier + {STRING_32} " updated.")
									print_new_line
								else
									print ({STRING_32} "Package created.")
									print_new_line
									a_iron.catalog_api.update_repository (repo, True)
									if l_name /= Void then
										l_package := package_by_name_from_repo (repo, l_name)
									else
										l_package := Void
										err := True
									end
								end
							else
								if attached remote_node.last_operation_error_message as errmsg then
									print (errmsg)
								else
									print ("[Error] operation failed!")
								end
								print_new_line
								err := True
							end
							if not err and l_package /= Void then
									-- Only on existing package !

									--| About indexes
								if attached l_data.indexes as l_paths then
									print ({STRING_32} "Adding indexes:%N")
									from
										l_paths.start
									until
										l_paths.after
									loop
										print ({STRING_32} "  - " + l_paths.item)

										if across l_package.associated_paths as p_ic some p_ic.item.same_string (l_paths.item) end then
												-- Already mapped to this index
											l_paths.remove
											print (" : already associated (skipped)")
										else
											l_paths.forth
										end
										print_new_line
									end
									if l_paths.is_empty then
										print ("Package has no new index.")
									else
										remote_node.add_indexes (l_package, l_paths, u, p)
										if remote_node.last_operation_succeed then
											if l_paths.count > 1 then
												print ("Package successfully associated with indexes!")
											else
												print ("Package successfully associated with index!")
											end
											print_new_line
										else
											if attached remote_node.last_operation_error_message as errmsg then
												print (errmsg)
											else
												print ("[Error] path association failed!")
											end
											print_new_line
											err := True
										end
									end
								end

									-- About archive
								if l_upload_new_archive then
									if attached l_data.source as src then
										create tgt.make_from_string ("tmp_archive_" + (create {UUID_GENERATOR}).generate_uuid.out)
										print ({STRING_32} "Building the archive from folder %"" + src.name + {STRING_32} "%" %N");

										l_iron_archive := (create {IRON_UTILITIES}).build_package_archive (l_package, src, tgt, a_iron.layout)
										if l_iron_archive = Void or else not l_iron_archive.file_exists then
											print ("[Error] Failure occured during package archive creation!%N")
										end
										l_remove_iron_archive := True
--										if not (create {FILE_UTILITIES}).file_path_exists (l_archive_path) then
--											print ("[Error] Failure occured during package archive creation!%N")
--										end
									elseif attached l_data.archive as l_archive then
										create l_iron_archive.make (l_archive)
									end

									if l_iron_archive /= Void then
										if l_iron_archive.file_exists then
											if
												l_package.has_archive_uri and then
												l_package.archive_size = l_iron_archive.file_size and then
												(attached l_package.archive_hash_string as l_package_archive_hash and
												 attached l_iron_archive.hash as l_iron_hash) and then l_package_archive_hash.is_case_insensitive_equal_general (l_iron_hash)
											then
													-- Same archive .. no need to upload
												print ("Package archive is already uploaded (")
												print (" size=" + l_iron_archive.file_size.out)
												print (" hash=" + l_iron_hash)
												print (" ).")
												print_new_line
											else
												if args.verbose then
													print ("Computing the archive hash (sha1) ...%N")
													l_local_hash := l_iron_archive.hash
												else
													l_local_hash := Void
												end
												print ("Uploading package archive [size="+ l_iron_archive.file_size.out +"]")
												if l_local_hash /= Void then
													print (" ["+ l_local_hash + "]")
												end
												print ("...%N")
												if l_package.has_archive_uri then
													print (" -> replacing previous archive [size=" + l_package.archive_size.out)
													if attached l_package.archive_hash_string as l_hash then
														print (" hash=" + l_hash)
													end
													print (" ].")
													print_new_line
												end
												create cl_body.put (Void)
												remote_node.upload_package_archive (l_package, l_iron_archive, u, p, cl_body)
												if remote_node.last_operation_succeed then
													print ("Archive successfully uploaded!")
													print_new_line
												else
													if attached remote_node.last_operation_error_message as errmsg then
														print (errmsg)
													else
														print ("[Error] Archive uploading failed!")
													end
													print_new_line
													err := True
												end
												if args.verbose then
													if attached cl_body.item as l_resp_body then
														print (l_resp_body)
														print_new_line
													end
												end
											end
												-- Clean temp archive file
											if l_remove_iron_archive then
												l_iron_archive.delete_file
											end
										else
											print ({STRING_32} "Unable to find package archive %""+ l_iron_archive.path.name +"%"!")
											print_new_line
										end
									end
								end
							end
						end
					else
						print ({STRING_32} "missing or invalid input data!")
						print_new_line
					end
				else
					print ({STRING_32} "Repository url [" + repo_url + "] is unknown or invalid!")
					print_new_line
					print ({STRING_32} "hint: iron repository --add " + repo_url + " !")
					print_new_line
				end
			else
				b := False
				if u = Void then
					b := True
					print ({STRING_32} "[ERROR] Missing required argument %"username%"!")
				end
				if p = Void then
					b := True
					print ({STRING_32} "[ERROR] Missing required argument %"password%"!")
				end
				if repo_url = Void then
					b := True
					print ({STRING_32} "[ERROR] Missing required argument %"repository%"!")
				end
				if args.operation = Void then
					b := True
					print ({STRING_32} "[ERROR] Missing required argument %"operation%"!")
				end
				if not b then
					print ({STRING_32} "[ERROR] Missing arguments!")
				end
				print_new_line
			end
		end

	file_sha1 (p: PATH): STRING
		local
			f: RAW_FILE
			sha1: SHA1
		do
			create f.make_with_path (p)
			if f.exists and then f.is_readable then
				create sha1.make
				f.open_read
				sha1.update_from_io_medium (f)
				f.close
				Result := "SHA1=" + sha1.digest_as_string
			else
				Result := ""
			end
		end

	file_size (p: PATH): INTEGER
		local
			f: RAW_FILE
		do
			create f.make_with_path (p)
			if f.exists and then f.is_readable then
				Result := f.count
			end
		end

	data_from (args: IRON_SHARE_ARGUMENTS): detachable IRON_SHARE_TASK_DATA
		local
			u: FILE_UTILITIES
			p: detachable PATH
			pf: detachable IRON_PACKAGE_FILE
			l_dft_name: detachable READABLE_STRING_32
		do
			p := args.data_file
			if p /= Void and then u.file_path_exists (p) then
				create Result.make_from_file (p)
			else
				create Result.make
			end

			if attached args.package_file as l_loc then
				Result.set_package_file_location (l_loc)
				pf := (create {IRON_PACKAGE_FILE_FACTORY}).new_package_file (l_loc)
				if attached pf.title as l_title then
					Result.set_title (l_title)
				end
				if attached pf.description as l_description then
					Result.set_description (l_description)
				end
				Result.set_source (l_loc.parent)
				l_dft_name := pf.package_name
			end

			if Result.has_name then
					-- Do no overwrite package name from package.iron!
			else
				if attached args.package_name as l_name then
					Result.set_name (l_name)
				elseif args.is_batch then
					Result.set_name (l_dft_name)
				else
					print ("Name? ")
					if l_dft_name /= Void then
						print ("[")
						print (l_dft_name)
						print ("]")
					end
					print (" >")
					io.read_line
					if l_dft_name /= Void and then io.last_string.is_whitespace then
						Result.set_name (l_dft_name)
					else
						Result.set_name (io.last_string.to_string_32)
					end
				end
			end

			if not args.is_delete then
				if Result.has_title then
						-- Do no overwrite package title from package.iron!
				elseif attached args.package_title as l_title then
					Result.set_title (l_title)
				elseif not args.is_batch then
					print ("Title? >")
					io.read_line
					Result.set_title (io.last_string.to_string_32)
				end

				if Result.has_description then
						-- Do no overwrite package description from package.iron!
				elseif attached args.package_description as l_desc then
					Result.set_description (l_desc)
				elseif not args.is_batch then
					print ("Description? >")
					io.read_line
					Result.set_description (io.last_string.to_string_32)
				end

				if attached args.package_archive_file as l_file then
					Result.set_archive (l_file)
				else
					if Result.has_source_or_archive then
							-- Do no overwrite previous source or archive value!
					elseif attached args.package_archive_source as l_src then
						Result.set_source (l_src)
					elseif not args.is_batch then
						print ("Archive file? >")
						io.read_line
						Result.set_archive (create {PATH}.make_from_string (io.last_string))
						if Result.archive = Void then
							print ("Source folder? >")
							io.read_line
							Result.set_source (create {PATH}.make_from_string (io.last_string))
						end
					end
				end
			end
		end

	package_by_name_from_repo (repo: IRON_REPOSITORY; a_name: READABLE_STRING_32): detachable IRON_PACKAGE
			-- Return package named `a_name' from `repo'
			-- if there are more than one, return Void !
		do
			if
				attached repo.packages_associated_with_name (a_name) as lst and then
				lst.count = 1
			then
				Result := lst.first
			end
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
