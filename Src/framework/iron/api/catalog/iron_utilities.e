note
	description: "Summary description for {IRON_UTILITIES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_UTILITIES

inherit
	SHARED_EXECUTION_ENVIRONMENT

feature -- Archiving

	build_package_archive_command (a_source: PATH; a_archive: PATH; a_layout: IRON_LAYOUT): STRING_32
		local
			p: detachable PATH
		do
			if attached execution_environment.item ("IRON_BUILD_ARCHIVE_COMMAND_PATTERN") as l_pattern then
				create Result.make_from_string (l_pattern)
				Result.replace_substring_all ({STRING_32} "##SOURCEDIR##", a_source.name)
				if attached a_archive.entry as e then
					Result.replace_substring_all ({STRING_32} "##ARCHIVEDIR##", a_archive.parent.name)
					Result.replace_substring_all ({STRING_32} "##ARCHIVENAME##", e.name)
				else
					Result.replace_substring_all ({STRING_32} "##ARCHIVEDIR##", ".")
					Result.replace_substring_all ({STRING_32} "##ARCHIVENAME##", a_archive.name)
				end
			else
				create Result.make_empty
				p := a_layout.binaries_path
				if p = Void then
					create p.make_current
				end
				p := p.extended ("iron_build_archive")
				if {PLATFORM}.is_windows then
					p := p.appended_with_extension ("bat")
				end
					-- script filename
				Result.append (safe_path_name_in_script (p))
				Result.append_character (' ')
				Result.append (safe_path_name_in_script (a_source))
				if attached a_archive.entry as e then
					Result.append_character (' ')
					Result.append (safe_path_name_in_script (a_archive.parent))

					Result.append_character (' ')
					Result.append (safe_path_name_in_script (e))
				else
					Result.append_string_general (" . ")
					Result.append (safe_path_name_in_script (a_archive))
					Result.append_character ('%"')
				end
			end
		end

	extract_package_archive_command (a_archive: PATH; a_folder: PATH; a_layout: IRON_LAYOUT): STRING_32
		local
			p: detachable PATH
		do
			if attached execution_environment.item ("IRON_EXTRACT_ARCHIVE_COMMAND_PATTERN") as l_pattern then
				create Result.make_from_string (l_pattern)
				Result.replace_substring_all ({STRING_32} "##ARCHIVENAME##", a_archive.name)
				Result.replace_substring_all ({STRING_32} "##FOLDERNAME##", a_folder.name)
			else
				create Result.make_empty
				p := a_layout.binaries_path
				if p = Void then
					create p.make_current
				end
				p := p.extended ("iron_extract_archive")
				if {PLATFORM}.is_windows then
					p := p.appended_with_extension ("bat")
				end
				Result.append_character ('%"')
				Result.append (p.name)
				Result.append_character ('%"')
				Result.append_character (' ')
				Result.append_character ('%"')
				Result.append (a_archive.name)
				Result.append_character ('%"')
				Result.append_character (' ')
				Result.append_character ('%"')
				Result.append (a_folder.name)
				Result.append_character ('%"')
			end
		end

	build_package_archive (a_package: detachable IRON_PACKAGE; a_folder: PATH; a_target_file: PATH; a_layout: IRON_LAYOUT): detachable IRON_ARCHIVE
			--| note: this also update `a_package.archive...' data.
		require
			folder_exists: (create {FILE_UTILITIES}).directory_path_exists (a_folder)
		local
			d: DIRECTORY
			proc_fact: PROCESS_FACTORY
			proc: PROCESS
			cmd: STRING_32
			p: PATH
			f: detachable RAW_FILE
			l_id: READABLE_STRING_8
		do
			if a_package /= Void then
				l_id := a_package.id
			else
				l_id := ""
			end
			p := a_folder.absolute_path
			create d.make_with_path (p)
			if d.exists then
				create f.make_with_path (a_target_file)
				if f.exists then
					f.delete
				end
				f := Void

				create proc_fact
				cmd := build_package_archive_command (a_folder.absolute_path, a_target_file.absolute_path, a_layout)
				debug
					print (cmd + "%N")
				end
				proc := proc_fact.process_launcher_with_command_line (cmd, p.name)
				proc.redirect_output_to_file (".tmp.output.proc." + l_id)
				proc.redirect_error_to_same_as_output
				proc.launch
				if proc.launched then
					proc.wait_for_exit
				end
				create f.make_with_name (".tmp.output.proc." + l_id)
				delete_file (f)

					-- target archive file.
				create Result.make (a_target_file)
				if not Result.file_exists then
					Result := Void
				end
			end
		end

	extract_package_archive (a_package: IRON_PACKAGE; a_target_folder: PATH; a_create_dir_if_missing: BOOLEAN; a_layout: IRON_LAYOUT)
			-- Extract package's archive into `a_target_folder'
		require
			a_package.has_archive_file_uri
		do
			if attached a_package.archive_path as l_archive_path then
				extract_package_archive_file (l_archive_path, a_target_folder, a_create_dir_if_missing, a_layout)
			end
		end

	extract_package_archive_file (a_archive_path: PATH; a_target_folder: PATH; a_create_dir_if_missing: BOOLEAN; a_layout: IRON_LAYOUT)
			-- Extract `a_archive_path' into `a_target_folder'
		local
			d: DIRECTORY
			proc_fact: PROCESS_FACTORY
			proc: PROCESS
			cmd: STRING_32
			p: PATH
			f: RAW_FILE
		do
			p := a_target_folder.absolute_path
			create d.make_with_path (p)
			if d.exists then
				d.recursive_delete
			end
			if not d.exists then
				d.recursive_create_dir
			end

			create proc_fact
			cmd := extract_package_archive_command (a_archive_path, p, a_layout)
			debug
				print (cmd + "%N")
			end
			proc := proc_fact.process_launcher_with_command_line (cmd, p.name)
			proc.redirect_output_to_file (p.extended (".tmp.output.proc").name)
			proc.redirect_error_to_same_as_output
			proc.launch
			if proc.launched then
				proc.wait_for_exit
				if not proc.last_termination_successful then
					-- failure
				end
			else
				-- failure
			end
			create f.make_with_path (p.extended (".tmp.output.proc"))
			delete_file (f)
		end

	delete_file (f: FILE)
		local
			retried: INTEGER
		do
			if retried <= 5 then
				if f.exists then
					f.delete
				end
			end
		rescue
			execution_environment.sleep (1_000_000)
			retried := retried + 1
			retry
		end

feature -- URI

	path_to_uri_string (p: PATH): STRING_32
		local
			path_uri: PATH_URI
		do
			create path_uri.make_from_path (p)
			if path_uri.is_valid then
				Result := path_uri.string
			else
				create Result.make_from_string (p.absolute_path.canonical_path.name)
				if {PLATFORM}.is_windows then
					Result.replace_substring_all ("\", "/")
					Result.prepend ("/")
				end
				Result := {STRING_32} "file://" + Result
			end
		end

feature -- Helpers

	safe_path_name_in_script (p: PATH): STRING_32
		local
			i,n: INTEGER
			b: BOOLEAN
		do
			create Result.make_from_string (p.name)
			if Result.is_empty then
				Result := {STRING_32} ""
			elseif Result[1] = '%"' then
				if Result[Result.count] /= '%"' then
					Result.append_character ('%"')
				end
			else
				from
					i := 1
					n := Result.count
				until
					i > n or b
				loop
					b := Result[i].is_space
					i := i + 1
				end
				if b then
					Result.prepend_character ('%"')
					Result.append_character ('%"')
				end
			end
		end

feature -- File and date

	file_date (f: FILE): DATE_TIME
		do
			Result := timestamp_to_date (f.date)
		end

	timestamp_to_date (n: INTEGER): DATE_TIME
		local
			d: HTTP_DATE
		do
			create d.make_from_timestamp (n)
			Result := d.date_time
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
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
