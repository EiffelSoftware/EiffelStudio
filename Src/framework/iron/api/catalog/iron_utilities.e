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
				Result.append (p.name)
				Result.append_string_general (" %"")
				Result.append (a_source.name)
				Result.append_string_general ("%"")
				if attached a_archive.entry as e then
					Result.append_string_general (" %"")
					Result.append (a_archive.parent.name)
					Result.append_string_general ("%"")

					Result.append_string_general (" %"")
					Result.append (e.name)
					Result.append_string_general ("%"")

				else
					Result.append_string_general (" . %"")
					Result.append (a_archive.name)
					Result.append_string_general ("%"")
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

				Result.append (p.name)
				Result.append_string_general (" %"")
				Result.append (a_archive.name)
				Result.append_string_general ("%"")
				Result.append_string_general (" %"")
				Result.append (a_folder.name)
				Result.append_string_general ("%"")
			end
		end

	build_package_archive (a_package: IRON_PACKAGE; a_folder: PATH; a_target_file: PATH; a_layout: IRON_LAYOUT)
		require
			folder_exists: (create {FILE_UTILITIES}).directory_path_exists (a_folder)
		local
			d: DIRECTORY
			proc_fact: PROCESS_FACTORY
			proc: PROCESS
			cmd: STRING_32
			p: PATH
			f: RAW_FILE
		do
			p := a_folder.absolute_path
			create d.make_with_path (p)
			if d.exists then
				create proc_fact
				cmd := build_package_archive_command (a_folder, a_target_file, a_layout)
				debug
					print (cmd + "%N")
				end
				proc := proc_fact.process_launcher_with_command_line (cmd, p.name)
				proc.redirect_output_to_file (".tmp.output.proc")
				proc.redirect_error_to_same_as_output
				proc.launch
				if proc.launched then
					proc.wait_for_exit
				end
				create f.make_with_name (".tmp.output.proc")
				delete_file (f)

				-- target archive file.
				create f.make_with_path (a_target_file)
				if f.exists then
					a_package.set_archive_uri (path_to_uri_string (a_target_file))
				end
			end
		end

	extract_package_archive (a_package: IRON_PACKAGE; a_target_folder: PATH; a_create_dir_if_missing: BOOLEAN; a_layout: IRON_LAYOUT)
		require
			a_package.has_archive_file_uri
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
			if not d.exists then
				d.recursive_create_dir
			end

			if attached a_package.archive_path as l_archive_path then
				create proc_fact
				cmd := extract_package_archive_command (l_archive_path, p, a_layout)
				debug
					print (cmd + "%N")
				end
				proc := proc_fact.process_launcher_with_command_line (cmd, p.name)
				proc.redirect_output_to_file (".tmp.output.proc")
				proc.redirect_error_to_same_as_output
				proc.launch
				if proc.launched then
					proc.wait_for_exit
				end
				create f.make_with_name (".tmp.output.proc")
				delete_file (f)
			end
		end

	delete_file (f: FILE)
		local
			retried: INTEGER
		do
			if retried > 5 then
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
		do
			create Result.make_from_string (p.absolute_path.canonical_path.name)
			if {PLATFORM}.is_windows then
				Result.replace_substring_all ("\", "/")
				Result.prepend ("/")
			end
			Result := {STRING_32} "file://" + Result
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

end
