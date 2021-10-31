note
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_NODE_BATCH

inherit
	IRON_EXPORTER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			iron := (create {IRON_NODE_FACTORY}).iron_node
			execute
		end

feature -- Access

	iron: IRON_NODE

feature -- Execution

	execute
		do
			if attached operation as l_operation and then attached Operations.item (l_operation) as op then
				op.call (Void)
			else
				operate_help
			end
		end

	Operations: STRING_TABLE [PROCEDURE]
		once
			create Result.make (3)
			Result.put (agent operate_help, "help")
			Result.put (agent operate_list, "list")
			Result.put (agent operate_import, "import")
			Result.put (agent operate_analyze, "analyze")
		end

	operate_help
		do
			print ("Usage: %N")
			across
				Operations as ic
			loop
				print (" - ")
				print (@ ic.key)
				print ("%N")
			end
		end

	operate_list
		local
			db: like {IRON_NODE}.database
		do
			db := iron.database
			across
				db.versions as ic
			loop
				print (ic.debug_output)
				print ("%N")
				if attached db.version_packages (ic, 1, 0) as lst then
					across
						lst as ic_package
					loop
						print ("%T")
						print (ic_package.name)
						print (" ")
						print (ic_package.id)
						print ("%N")
					end
				end
			end
		end

	operate_analyze
		local
			db: like {IRON_NODE}.database
			i: INTEGER_32
			ut: IRON_UTILITIES
			l_file_utilities: FILE_UTILITIES
			l_layout: IRON_LAYOUT
			p: PATH
			l_package: IRON_NODE_VERSION_PACKAGE
			l_analyzer: IRON_NODE_ARCHIVE_ANALYZER
			l_root: READABLE_STRING_32
			l_ecf_path: READABLE_STRING_32
		do
			create l_layout.make_with_path (iron.layout.path.extended ("sandbox"), iron.layout.binaries_path)
			db := iron.database
			across
				db.versions as ic
			loop
				print (ic.debug_output)
				print ("%N")
				i := 1
				if attached db.version_packages (ic, i, 5) as lst then
					create l_analyzer.make
					print (lst.count.out + " items.%N")
					create ut
					across
						lst as ic_package
					loop
						l_package := ic_package
						debug
							print (i)
						end
						print ("[")
						print (l_package.name)
						print (" ")
						print (l_package.id)
						print ("]%N")
						if l_package.has_archive and then attached l_package.archive_path as l_archive_path then
							p := iron.layout.path.extended ("sandbox").extended ("packages").extended (l_package.id)
							ut.extract_package_archive_file (l_archive_path, p, True, l_layout)
							if l_file_utilities.directory_path_exists (p) then
								p := p.canonical_path
								l_root := p.canonical_path.name
								l_analyzer.process_directory (p)
								across
									l_analyzer.ecfs as ic_ecfs
								loop
									l_ecf_path := ic_ecfs.name
									print (" - ")
									print_unicode (path_name_to_uri_path (l_ecf_path.substring (l_root.count + 1, l_ecf_path.count)))
									print ("%N")
								end
							else
								print ("Failure !%N")
							end
						end
						i := i + 1
					end
				end
			end
		end

	operate_import
		local
			cat: IRON_CATALOG_API
			l_layout: IRON_LAYOUT
			l_repo_fac: IRON_REPOSITORY_FACTORY
			l_repo: detachable IRON_REPOSITORY
			p: IRON_PACKAGE
			np: IRON_NODE_PACKAGE
			nvp: IRON_NODE_VERSION_PACKAGE
			ut: FILE_UTILITIES
			l_archive_path: PATH
			l_repo_version: IRON_NODE_VERSION
		do
			if attached argument (2) as l_repo_location then
				create l_repo_fac
				l_repo := l_repo_fac.new_repository (l_repo_location)
				if attached {IRON_WEB_REPOSITORY} l_repo as l_web_repo then
					create l_layout.make_with_path (iron.layout.path.extended ("import"), iron.layout.binaries_path)
					create cat.make_with_layout (l_layout, create {IRON_URL_BUILDER})


					cat.update_repository (l_repo, False)

					create l_repo_version.make (l_web_repo.version)

					print ("Importing " + l_repo.location_string + "%N")
					across
						l_repo.available_packages as ic
					loop
						p := ic
						if iron.database.version_package (l_repo_version, p.id) /= Void then
							print ("Importing ")
							print_unicode (p.human_identifier)
							print (" cancelled: already exists!%N")
						else
							create np.make (p.id)
							np.set_description (p.description)
							np.set_name (p.name)
							across
								p.tags as ic_tags
							loop
								np.add_tag (ic_tags)
							end
							create nvp.make (np, l_repo_version)
							iron.database.force_version_package (nvp)
							if p.has_archive_uri then
								cat.download_package (l_web_repo, p, True)
								l_archive_path := l_layout.package_archive_path (p)
								if ut.file_path_exists (l_archive_path) then
--									np.set_archive_path (l_archive_path)									
									iron.database.save_package_archive (nvp, l_archive_path, False)
								else
									print ("ERROR: missing archive for ")
									print_unicode (p.human_identifier)
									print ("%N")
								end
							end
							across
								p.associated_paths as ic_path
							loop
								iron.database.associate_package_with_path (nvp, ic_path)
							end
						end
					end
				else
					-- Local ..?
				end
			end
		end

feature {NONE} -- Implementation

	path_name_to_uri_path (s: READABLE_STRING_32): STRING_32
		do
			create Result.make_from_string (s)
			if {PLATFORM}.is_windows then
				Result.replace_substring_all ("\", "/")
				from

				until
					Result.is_empty or else not Result.starts_with ("/")
				loop
					Result.remove_head (1)
				end
			end
		end

	print_unicode (s: detachable READABLE_STRING_32)
			-- option ... not argument!
		local
			utf: UTF_CONVERTER
		do
			if s = Void then
				print ("Void")
			else
				print (utf.string_32_to_utf_8_string_8 (s))
			end
		end

	argument (a_index: INTEGER_32): detachable READABLE_STRING_32
		local
			args: ARGUMENTS_32
			v: READABLE_STRING_32
			i, n, j: INTEGER_32
		do
			create args
			n := args.argument_count
			from
				j := 0
				i := 1
			until
				i > n or Result /= Void or j > a_index
			loop
				v := args.argument (i)
				if v.starts_with ({STRING_32} "-") or v.starts_with ({STRING_32} "/") then
				else
					j := j + 1
					if j = a_index then
						Result := v
					end
				end
				i := i + 1
			end
		end

	operation: detachable READABLE_STRING_32
		do
			Result := argument (1)
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
