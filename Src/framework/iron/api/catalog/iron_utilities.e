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

	build_package_archive (a_package: IRON_PACKAGE; a_folder: PATH; a_target_file: PATH)
		do

		end

	extract_package_archive (a_package: IRON_PACKAGE; a_target_folder: PATH; a_create_dir_if_missing: BOOLEAN)
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
				create cmd.make_empty
				cmd.append ({STRING_32} "C:\apps\utility\7-Zip\7z.exe")
				cmd.append_string_general (" x -bd -y ")
				cmd.append_string_general ("%"")
				cmd.append_string_general (l_archive_path.name)
				cmd.append_string_general ("%"")
				cmd.append_string_general (" -o%""+ p.name + {STRING_32} "%"")
				debug
					print (cmd + "%N")
				end
				proc := proc_fact.process_launcher_with_command_line (cmd, p.name)
				proc.redirect_output_to_file (".tmp.output.proc")
				proc.redirect_error_to_same_as_output
				proc.launch
				if proc.launched then
					proc.wait_for_exit
--					proc.terminate_tree
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
