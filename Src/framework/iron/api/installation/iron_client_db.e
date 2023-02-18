note
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_CLIENT_DB

inherit
	ANY
		rename
			print as log_print -- To prevent
		end

create
	make

feature {NONE} -- Initialization

	make (a_layout: IRON_LAYOUT)
		do
			layout := a_layout
		end

	layout: IRON_LAYOUT

feature -- Access

	revision: INTEGER
			-- Revision for the client database.
			-- Note: It is incremented for each install or uninstall operations.
			--| See `increment_revision' for format.
		local
			f: RAW_FILE
			s: READABLE_STRING_8
		do
			create f.make_with_path (layout.repositories_revision_file)
			if f.exists and then f.is_readable then
				f.open_read
				f.read_line_thread_aware
				s := f.last_string
				if s.is_integer then
					Result := s.to_integer
				else
					Result := -1
				end
				f.close
			else
				Result := -1
			end
		end

	repositories: ARRAYED_LIST [IRON_REPOSITORY]
		local
			repo_conf: IRON_REPOSITORY_CONFIGURATION_FILE
		do
			create repo_conf.make (layout.repositories_configuration_file)
			Result := repo_conf.repositories
		end

	installed_packages: ARRAYED_LIST [IRON_PACKAGE]
		local
			p: PATH
			vis: IRON_FS_PACKAGE_INFO_DIRECTORY_ITERATOR
			lst: ARRAYED_LIST [PATH]
			l_inst_info: IRON_PACKAGE_INSTALLATION_INFO
			l_unordered_result: like installed_packages
		do
			debug ("iron_api")
				log_print ("DEBUG:[" + revision.out + "] Scan for installed packages!!%N")
			end
				-- FIXME: repository order !!
			create l_unordered_result.make (0)
			l_unordered_result.compare_objects
			p := layout.packages_path
			create lst.make (10)
			create vis.make (lst)
			vis.scan_folder (p.absolute_path.canonical_path)
			across
				lst as c
			loop
				create l_inst_info.make_with_file (c)
				if attached l_inst_info.package as l_package then
					l_unordered_result.force (l_package)
				else
						-- Backward compatibility
					if
						attached file_content (c) as s and then
						attached repo_package_from_json_string (s) as l_package
					then
						l_unordered_result.force (l_package)
					end
				end
			end

			create Result.make (l_unordered_result.count)
			Result.compare_objects
			across
				repositories as ic
			until
				l_unordered_result.is_empty
			loop
				from
					l_unordered_result.start
				until
					l_unordered_result.after
				loop
					if ic.is_same_repository (l_unordered_result.item.repository) then
						Result.force (l_unordered_result.item)
						l_unordered_result.remove
					else
						l_unordered_result.forth
					end
				end
			end
			if not l_unordered_result.is_empty then
					-- Should not happen, otherwise it means it is not related to a registered repository...
					-- but for now, keep those packages with lowest priority
					-- FIXME: probably remove this flexibility
					--	      check associated_with_registered_repository: False end
				across
					l_unordered_result as ic
				loop
					Result.force (ic)
				end
			end
			debug ("iron_api")
				log_print ("DEBUG:[" + revision.out + "] Scan for installed packages: COMPLETED!!%N")
			end
		end

	quick_installed_package (a_package_name: READABLE_STRING_GENERAL): detachable IRON_PACKAGE
			-- Installed package `a_package_name' if any.
			-- Minor optimization.
		local
			p: PATH
			vis: IRON_FS_PACKAGE_INFO_DIRECTORY_ITERATOR
			lst: ARRAYED_LIST [PATH]
			l_inst_info: IRON_PACKAGE_INSTALLATION_INFO
			l_unordered_result: ARRAYED_LIST [IRON_PACKAGE]
		do
			create l_unordered_result.make (0)
			l_unordered_result.compare_objects
			p := layout.packages_path
			create lst.make (10)
			create vis.make (lst)
			vis.scan_folder (p.absolute_path.canonical_path)
			across
				lst as c
			loop
				if
					attached repo_package_identifier_from_json_string (file_content (c)) as l_package_id and then
					l_package_id.is_case_insensitive_equal (a_package_name)
				then
					create l_inst_info.make_with_file (c)
					if attached l_inst_info.package as l_package then
						l_unordered_result.force (l_package)
					else
							-- Backward compatibility
						if
							attached file_content (c) as s and then
							attached repo_package_from_json_string (s) as l_package
						then
							l_unordered_result.force (l_package)
						end
					end
				end
			end

			across
				repositories as ic
			until
				l_unordered_result.is_empty or Result /= Void
			loop
				from
					l_unordered_result.start
				until
					l_unordered_result.after or Result /= Void
				loop
					if ic.is_same_repository (l_unordered_result.item.repository) then
						Result := l_unordered_result.item
						l_unordered_result.remove
					else
						l_unordered_result.forth
					end
				end
			end
		end

	available_packages: ARRAYED_LIST [IRON_PACKAGE]
			-- URI indexed by package name.
		local
			fp,p: PATH
			f: PLAIN_TEXT_FILE
			s: STRING
			l_name: STRING_32
			utf: UTF_CONVERTER
			pif_fac: IRON_PACKAGE_FILE_FACTORY
			pif: IRON_PACKAGE_FILE
			l_package: detachable IRON_PACKAGE
			l_repo_uri: READABLE_STRING_8
		do
			create Result.make (0)
			create pif_fac

			across
				repositories as ic
			loop
				fp := layout.repository_packages_data_index (ic)
				create f.make_with_path (fp)
				if f.exists and then f.is_access_readable then
					l_repo_uri := ic.location_string
					f.open_read
					from
						f.read_line_thread_aware
					until
						f.exhausted
					loop
						s := f.last_string
						if s.is_empty then
								-- ignore
						elseif s[1].is_space then
							if l_package /= Void then
								s.left_adjust
								if s.starts_with_general (l_repo_uri) then
									s.remove_head (l_repo_uri.count + 1)
								else
									check wrong_path: False end
								end
								l_package.associated_paths.force (s.string)
							else
									-- no parent package -> ignored
							end
						else
							l_package := Void
								-- Package name
							l_name := utf.utf_8_string_8_to_string_32 (s)

							if across Result as result_ic some result_ic.is_identified_by (l_name) end then
									-- Conflict, but still listed, order matters
							end

							p := layout.repository_packages_data_folder (ic).extended (l_name)
							pif := pif_fac.new_package_file (p)
							if pif.exists and then not pif.has_error then
								l_package := pif.to_package (ic)
								Result.force (l_package)
							end
						end
						f.read_line_thread_aware
					end
					f.close
				end
			end
		end

feature -- Change

	increment_revision
			-- Increment db revision
		local
			rev: INTEGER
			f: RAW_FILE
		do
			rev := revision + 1
			create f.make_with_path (layout.repositories_revision_file)
			if not f.exists or else f.is_access_writable then
				f.open_write
				f.put_string (rev.out)
				f.put_new_line
				f.close
			end
		end

	save_repository (a_repo: IRON_REPOSITORY)
			-- Save repository `a_repo' into current db.
		local
			repo_conf: IRON_REPOSITORY_CONFIGURATION_FILE
		do
			create repo_conf.make (layout.repositories_configuration_file)
			if repo_conf.has_repository (a_repo) then
				repo_conf.remove_repository (a_repo)
			end
			repo_conf.add_repository (a_repo)
			repo_conf.save
		end

	remove_repository_by_uri (a_uri: READABLE_STRING_GENERAL)
			-- Remove repository associated with `a_uri' into current db.
		local
			repo_conf: IRON_REPOSITORY_CONFIGURATION_FILE
		do
			create repo_conf.make (layout.repositories_configuration_file)
			if repo_conf.has_repository_by_uri (a_uri) then
				repo_conf.remove_repository_by_uri (a_uri)
				repo_conf.save
			end
		end

	save_available_repository_packages	(a_repo: IRON_REPOSITORY)
			-- Save available packages from `a_repo'.
		local
			f: RAW_FILE
			utf: UTF_CONVERTER
			pif_fac: IRON_PACKAGE_FILE_FACTORY
			pif: IRON_PACKAGE_FILE
			dp, p: PATH
			d: DIRECTORY
		do
			create pif_fac
			p := layout.repository_packages_data_folder (a_repo)
			dp := p
			create d.make_with_path (dp)
			if not d.exists then
				d.recursive_create_dir
			end
			create f.make_with_path (layout.repository_packages_data_index (a_repo))
			f.create_read_write
			across
				a_repo.available_packages as ic
			loop
				pif := pif_fac.new_package_file (dp.extended (ic.identifier))
				pif.reset
				pif.load_package (ic)
				pif.remove ("_json")
				pif.save

				f.put_string (utf.string_32_to_utf_8_string_8 (ic.identifier))
				f.put_new_line
				across
					ic.associated_paths as maps_ic
				loop
					f.put_character ('%T')

					f.put_string (a_repo.location_string + maps_ic)
					f.put_new_line
				end
			end
			f.close
		end

feature {NONE} -- Implementation

	file_content (p: PATH): detachable STRING
		local
			f: RAW_FILE
		do
			create f.make_with_path (p)
			if f.exists and then f.is_access_readable then
				f.open_read
				create Result.make (1_024)
				from
				until
					f.exhausted
				loop
					f.read_stream (1_024)
					Result.append (f.last_string)
				end
				f.close
			end
		end

	repo_package_from_json_string (s: READABLE_STRING_8): detachable IRON_PACKAGE
		local
			f: JSON_TO_IRON_FACTORY
		do
			create f
			Result := f.json_to_package (s)
		end

	repo_package_identifier_from_json_string (s: detachable READABLE_STRING_8): detachable READABLE_STRING_GENERAL
		local
			f: JSON_TO_IRON_FACTORY
		do
			if s /= Void then
				create f
				Result := f.json_to_package_identifier (s)
			end
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
