note

	description:

		"Copy commands"

	library: "Gobo Eiffel Ant"
	copyright: "Copyright (c) 2001-2018, Sven Ehrke and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class GEANT_COPY_COMMAND

inherit

	GEANT_FILESYSTEM_COMMAND

	KL_IMPORTED_BOOLEAN_ROUTINES
		export {NONE} all end

create

	make

feature -- Status report

	is_file_to_file_executable: BOOLEAN
			-- Can command be executed on sourcefile `file' to targetfile `to_file'?
		do
			Result := attached file as l_file and then l_file.count > 0 and then
				attached to_file as l_to_file and then l_to_file.count > 0
		ensure
			file_not_void_and_not_empty: Result implies attached file as l_file and then l_file.count > 0
			to_file_not_void_and_not_empty: Result implies attached to_file as l_to_file and then l_to_file.count > 0
		end

	is_file_to_directory_executable: BOOLEAN
			-- Can command be executed on sourcefile `file' to targetdirectory `to_directory'?
		do
			Result := attached file as l_file and then l_file.count > 0 and then
				attached to_directory as l_to_directory and then l_to_directory.count > 0
		ensure
			file_not_void_and_not_empty: Result implies attached file as l_file and then l_file.count > 0
			to_directory_not_void_and_not_empty: Result implies attached to_directory as l_to_directory and then l_to_directory.count > 0
		end

	is_fileset_to_directory_executable: BOOLEAN
			-- Can command be executed on source fileset `fileset' to targetdirectory `to_directory'?
		do
			Result := fileset /= Void and then
				attached to_directory as l_to_directory and then l_to_directory.count > 0
		ensure
			fileset_not_void: Result implies fileset /= Void
			to_directory_not_void_and_not_empty: Result implies attached to_directory as l_to_directory and then l_to_directory.count > 0
		end

	is_executable: BOOLEAN
			-- Can command be executed?
		do
			Result := BOOLEAN_.nxor (<<is_file_to_file_executable,
				is_file_to_directory_executable, is_fileset_to_directory_executable>>)
		ensure then
			exclusive: Result implies BOOLEAN_.nxor (<<is_file_to_file_executable,
				is_file_to_directory_executable, is_fileset_to_directory_executable>>)
		end

feature -- Access

	file: detachable STRING
			-- Name of source file to copy

	to_file: detachable STRING
			-- Name of destination file

	to_directory: detachable STRING
			-- Name of destination directory

	fileset: detachable GEANT_FILESET
			-- Fileset for current command

	force: BOOLEAN
			-- Should source files be copied over target files,
			-- provided the target files exist, even when target files
			-- are newer than their corresponding source files?

feature -- Setting

	set_file (a_file: like file)
			-- Set `file' to `a_file'.
		require
			a_file_not_void: a_file /= Void
			a_file_not_empty: a_file.count > 0
		do
			file := a_file
		ensure
			file_set: file = a_file
		end

	set_to_file (a_to_file: like to_file)
			-- Set `to_file' to `a_to_file'.
		require
			a_to_file_not_void: a_to_file /= Void
			a_to_file_not_empty: a_to_file.count > 0
		do
			to_file := a_to_file
		ensure
			to_file_set: to_file = a_to_file
		end

	set_to_directory (a_to_directory: like to_directory)
			-- Set `to_directory' to `a_to_directory'.
		require
			a_to_directory_not_void: a_to_directory /= Void
			a_to_directory_not_empty: a_to_directory.count > 0
		do
			to_directory := a_to_directory
		ensure
			to_directory_set: to_directory = a_to_directory
		end

	set_fileset (a_fileset: like fileset)
			-- Set `fileset' to `a_fileset'.
		require
			a_fileset_not_void: a_fileset /= Void
		do
			fileset := a_fileset
		ensure
			fileset_set: fileset = a_fileset
		end

	set_force (b: BOOLEAN)
			-- Set `force' to `b'.
		do
			force := b
		ensure
			force_set: force = b
		end

feature -- Execution

	execute
			-- Execute command.
		local
			a_from_file: STRING
			a_to_file: STRING
			a_basename: STRING
		do
			exit_code := 0

			if is_file_to_directory_executable and then attached file as l_file and then attached to_directory as l_to_directory then
					-- Make sure directory named `to_directory' exists:
				create_directory (l_to_directory)

				if exit_code = 0 then
					a_basename := unix_file_system.basename (l_file)
					a_to_file := unix_file_system.pathname (l_to_directory, a_basename)
					copy_file (l_file, a_to_file)
				end
			elseif is_file_to_file_executable and then attached file as l_file and then attached to_file as l_to_file then
				copy_file (l_file, l_to_file)
			else
				check is_fileset_to_directory_executable: is_fileset_to_directory_executable and then attached fileset as l_fileset and then attached to_directory as l_to_directory then

					if not l_fileset.is_executable then
						project.log (<<"  [copy] error: fileset definition wrong">>)
						exit_code := 1
					end

					if exit_code = 0 then
						l_fileset.execute
						from
							l_fileset.start
						until
							l_fileset.after or else exit_code /= 0
						loop
							if l_fileset.is_in_gobo_31_format and then attached l_fileset.directory_name as l_fileset_directory_name then
								a_from_file := unix_file_system.pathname (l_fileset_directory_name, l_fileset.item_filename)
							else
								a_from_file := l_fileset.item_filename
							end
							a_to_file := unix_file_system.pathname (l_to_directory, l_fileset.item_mapped_filename)
								-- Create target directory if necessary:
							create_directory_for_pathname (a_to_file)
							copy_file (a_from_file, a_to_file)

							l_fileset.forth
						end
					end
				end
			end
		end

feature {NONE} -- Implementation

	copy_file (a_source_file, a_target_file: STRING)
			-- Copy `a_source_file' to `a_target_file;
			-- Set `exit_code' in case `a_source_file' does
			-- not exist or could not be copied.
		require
			a_source_file_not_void: a_source_file /= Void
			a_source_file_not_empty: a_source_file.count > 0
			a_target_file_not_void: a_target_file /= Void
			a_target_file_not_empty: a_target_file.count > 0
		local
			new_name, old_name: STRING
		do
			old_name := file_system.pathname_from_file_system (a_source_file, unix_file_system)
			new_name := file_system.pathname_from_file_system (a_target_file, unix_file_system)
			if not file_system.file_exists (old_name) then
					-- Check that source file exists:
				project.trace (<<"  [copy] ", old_name, " to ", new_name>>)
				project.log (<<"  [copy] error: cannot find file '", old_name, "%'">>)
				exit_code := 1
			else
					-- Copy file if target is out of date:
				if force or else is_file_outofdate (old_name, new_name) then
					project.trace (<<"  [copy] ", old_name, " to ", new_name>>)
					if not project.options.no_exec then
						file_system.copy_file (old_name, new_name)
						if not file_system.file_exists (new_name) then
							project.log (<<"  [copy] error: cannot copy file '", old_name, "' to file '", new_name, "%'">>)
							exit_code := 1
						end
					end
				else
					project.trace_debug (<<"  [*copy] not necessary to copy ", old_name, " to ", new_name>>)
				end
			end
		end

end
