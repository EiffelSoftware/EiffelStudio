note
	description: "[
		Provides utility features that help to work with files.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XU_FILE_UTILITIES

inherit
	ERROR_SHARED_MULTI_ERROR_MANAGER


feature {NONE} -- Access

	plain_text_file: detachable PLAIN_TEXT_FILE

feature {NONE} -- Internal

	Max_file_size: INTEGER_32 = 1000000

feature -- Basic Opertaions

	resolve_env_vars (a_path: STRING; a_keep: BOOLEAN): STRING
			-- Resolves a path containing environment variables.
			--
			-- `a_path'    : The string to expand.
			-- `a_keep'    : True to retain any unmatched variables in the result; False otherwise.
			-- `Result'    : An expanded string with the match variable expanded.
		require
			a_path_attached: a_path /= Void
		local
			l_exp: XU_STRING_EXPANDER
		do
			create l_exp
			Result := l_exp.expand_string (a_path, a_keep)
		ensure
			result_attached: Result /= Void
		end

	replace_in_file (a_file: FILE_NAME; a_replacee: STRING; a_replacer: STRING)
			-- Opens a_file if it exists and replaces all occurrences of a_replacee with a_replacer
			-- Reads the whole file into a string. This feature should only be used on 'small' text files.
			-- Adds errors to ERROR_SHARED_MULTI_ERROR_MANAGER, don't forget to handle errors afterwards.
			-- Ignores files with more than Max_file_size characters!
			--
			-- `a_file': The file to be edited
			-- `a_replacee': The string that will be replaced by a_replacer
			-- `a_replacer': The string that will replacer a_replacee
		require
			a_file_attached: a_file /= Void
			a_replacee_not_empty: a_replacee /= Void and then not a_replacee.is_empty
			a_replacer_not_empty: a_replacer /= Void and then not a_replacer.is_empty
		local
			l_buf: STRING
		do
				-- Open the file in read mode first
			if attached {PLAIN_TEXT_FILE} plain_text_file_read (a_file) as l_file then
					-- Make sure the file is not too big
				if l_file.count > Max_file_size then
					error_manager.add_error (create {XERROR_FILE_TOO_BIG}.make (l_file.name), False)
				else
						-- Read the file into buffer
					from
						l_buf := ""
						l_file.start
					until
						l_file.after
					loop
						l_file.read_stream (50000)
						l_buf.append (l_file.last_string)
					end
					l_file.close
						-- Replace
					l_buf.replace_substring_all (a_replacee, a_replacer)
						-- Write back to file	
					if attached {PLAIN_TEXT_FILE} plain_text_file_open_write (a_file) as ll_file then
						ll_file.start
						ll_file.put_string (l_buf)
						ll_file.close
					end
				end
			end

		end

	text_file_read_to_string (a_file_name: STRING): detachable STRING
			-- Opens a plain text file for reading and reads the content into result. Does not create the file if it doesn't exsist.
			-- Adds errors to ERROR_SHARED_MULTI_ERROR_MANAGER, don't forget to handle errors afterwards.
			--
			-- `a_file_name': The file name.
			-- `Result': Returns a the content of the file
		require
			not_a_file_name_is_detached_or_empty: a_file_name /= Void and then not a_file_name.is_empty
		do
			if attached plain_text_file_read (a_file_name) as l_file then
				l_file.read_stream (l_file.count)
				Result := l_file.last_string
				l_file.close
			end
		end

	plain_text_file_read (a_file_name: STRING): detachable PLAIN_TEXT_FILE
			-- Opens a plain text file for reading. Does not create the file if it doesn't exsist.
			-- Adds errors to ERROR_SHARED_MULTI_ERROR_MANAGER, don't forget to handle errors afterwards.
			--
			-- `a_file_name': The file name.
			-- `Result': Returns a file if there were no errors, Void otherwise.
		require
			not_a_file_name_is_detached_or_empty: a_file_name /= Void and then not a_file_name.is_empty
		do
			create plain_text_file.make (a_file_name)
			if attached plain_text_file as l_f then
				if l_f.exists then
					if l_f.is_readable and then l_f.is_access_readable then
						l_f.open_read
						if l_f.is_open_read then
							Result := l_f
						else
							error_manager.add_error (create {XERROR_CANNOT_OPEN_FILE}.make (a_file_name), False)
						end
					else
						error_manager.add_error (create {XERROR_FILE_NOT_READABLE}.make (a_file_name), False)
					end
				else
					error_manager.add_error (create {XERROR_FILE_NOT_FOUND}.make (a_file_name), False)
				end
			end
		end


	plain_text_file_open_write (a_file_name: STRING): detachable PLAIN_TEXT_FILE
			-- Opens a plain text file for writing. Does not create the file if it doesn't exsist.
			-- Adds errors to ERROR_SHARED_MULTI_ERROR_MANAGER, don't forget to handle errors afterwards.
			--
			-- `a_file_name': The file name.
			-- `Result': Returns a file if there were no errors, Void otherwise.
		require
			not_a_file_name_is_detached_or_empty: a_file_name /= Void and then not a_file_name.is_empty
		do
			create plain_text_file.make (a_file_name)
			if attached plain_text_file as l_f then
				if l_f.exists then
					if l_f.is_writable and l_f.is_access_writable then
						l_f.open_write
						if l_f.is_open_write then
							Result := l_f
						else
							error_manager.add_error (create {XERROR_CANNOT_OPEN_FILE}.make (a_file_name), False)
						end
					else
						error_manager.add_error (create {XERROR_FILE_NOT_WRITABLE}.make (a_file_name), False)
					end
				else
					error_manager.add_error (create {XERROR_FILE_NOT_FOUND}.make (a_file_name), False)
				end
			end
		end

	plain_text_file_write (a_file_name: STRING): detachable PLAIN_TEXT_FILE
			-- Opens a plain text file for writing or creates one.
			-- Adds errors to ERROR_SHARED_MULTI_ERROR_MANAGER, don't forget to handle errors afterwards.
			--
			-- `a_file_name': The file name.
			-- `Result': Returns a file if there were no errors, Void otherwise.
		require
			not_a_file_name_is_detached_or_empty: a_file_name /= Void and then not a_file_name.is_empty
		do
			create plain_text_file.make (a_file_name)
			if attached plain_text_file as l_f then
				if l_f.exists or l_f.is_creatable then
					l_f.open_write
					if l_f.is_writable and l_f.is_access_writable then
						if l_f.is_open_write then
							Result := plain_text_file
						else
							error_manager.add_error (create {XERROR_CANNOT_OPEN_FILE}.make (a_file_name), False)
						end
					else
						error_manager.add_error (create {XERROR_FILE_NOT_WRITABLE}.make (a_file_name), False)
					end
				else
					error_manager.add_error (create {XERROR_FILE_NOT_CREATABLE}.make (a_file_name), False)
				end
			end
		end

	plain_text_file_append (a_file_name: STRING): detachable PLAIN_TEXT_FILE
			-- Opens a plain text file for appending. Does not create the file if it doesn't exsist.
			-- Adds errors to ERROR_SHARED_MULTI_ERROR_MANAGER, don't forget to handle errors afterwards.
			--
			-- `a_file_name': The file name.
			-- `Result': Returns a file if there were no errors, Void otherwise.
		require
			not_a_file_name_is_detached_or_empty: a_file_name /= Void and then not a_file_name.is_empty
		do
			create plain_text_file.make (a_file_name)
			if attached  plain_text_file as l_f then
				if l_f.exists then
					if l_f.is_writable and l_f.is_access_writable then
						l_f.open_append
						if l_f.is_open_write then
							Result := l_f
						else
							error_manager.add_error (create {XERROR_CANNOT_OPEN_FILE}.make (a_file_name), False)
						end
					else
						error_manager.add_error (create {XERROR_FILE_NOT_WRITABLE}.make (a_file_name), False)
					end
				else
					error_manager.add_error (create {XERROR_FILE_NOT_FOUND}.make (a_file_name), False)
				end
			end
		end

	plain_text_file_append_create (a_file_name: STRING): detachable PLAIN_TEXT_FILE
			-- Opens a plain text file for appending or creates one.
			-- Adds errors to ERROR_SHARED_MULTI_ERROR_MANAGER, don't forget to handle errors afterwards.
			--
			-- `a_file_name': The file name.
			-- `Result': Returns a file if there were no errors, Void otherwise.
		require
			not_a_file_name_is_detached_or_empty: a_file_name /= Void and then not a_file_name.is_empty
		do
			create plain_text_file.make (a_file_name)
			if attached  plain_text_file as l_f then
				if l_f.exists or l_f.is_creatable then
					l_f.open_append
					if l_f.is_writable and l_f.is_access_writable then
						if l_f.is_open_write then
							Result := l_f
						else
							error_manager.add_error (create {XERROR_CANNOT_OPEN_FILE}.make (a_file_name), False)
						end
					else
						error_manager.add_error (create {XERROR_FILE_NOT_WRITABLE}.make (a_file_name), False)
					end
				else
					error_manager.add_error (create {XERROR_FILE_NOT_CREATABLE}.make (a_file_name), False)
				end
			end
		end

	close
			-- Closes (all) open files
		do
			if attached  plain_text_file as l_f then
				if l_f.is_open_read or l_f.is_open_write then
					l_f.close
				end
			end
		end

	is_readable_file (a_path: STRING): BOOLEAN
			-- Checks if the path is a valid filename and the file can be read
		local
			l_file: RAW_FILE
		do
			create l_file.make (a_path)
			Result := l_file.exists and l_file.is_readable and not l_file.is_directory
		end

	is_executable_file (a_path: STRING): BOOLEAN
			-- Checks if the path is a valid filename and the file can be executed
		local
			l_file: RAW_FILE
		do
			create l_file.make (a_path)
			Result := l_file.exists and l_file.is_executable and not l_file.is_directory
		end


	is_dir (a_path: STRING): BOOLEAN
			-- Checks if the path is a valid directory
		local
			l_file: RAW_FILE
		do
			create l_file.make (a_path)
			Result := l_file.exists and l_file.is_directory
		end

	file_is_newer (a_file, a_dir: FILE_NAME; a_include: LINKED_LIST [STRING]): BOOLEAN
				-- Returns True if there is a file in a_dir (recursively) that matches a_maching_files_expr
				-- that is newer than a_file or a_file does not exist
		require
			not_a_file_is_detached_or_empty: a_file /= Void and then not a_file.is_empty
			not_a_dir_is_detached_or_empty: a_dir /= Void and then not a_dir.is_empty
			a_include_attached: a_include /= Void
		local
			l_dir: DIRECTORY
			l_files: LIST [STRING]
			l_file: RAW_FILE
			l_exec_access_date: INTEGER
			l_ex: LINKED_LIST [STRING]
		do
			create l_ex.make
			l_ex.force (".svn")
			l_ex.force ("EIFGENs")
			Result := False
			if is_readable_file (a_file) then
				l_exec_access_date := (create {RAW_FILE}.make (a_file)).date

				l_files := scan_for_files (a_dir.out, -1, a_include, l_ex)
				from
					l_files.start
				until
					l_files.after or Result
				loop
					create l_file.make (l_files.item_for_iteration)
					if (l_file.date > l_exec_access_date) then
						Result := True
					end
					l_files.forth
				end
			else
				Result := True
			end
		end

	file_is_older_than (a_file: FILE_NAME; a_date: INTEGER): BOOLEAN
				-- Returns False if the file exists and it is newer than `a_date'
		require
			not_a_file_is_detached_or_empty: a_file /= Void and then not a_file.is_empty
			a_date_positive: a_date >= 0
		local
			l_dir: DIRECTORY
			l_files: LIST [STRING]
			l_file: RAW_FILE
			l_exec_access_date: INTEGER
		do
			Result := True
			if is_readable_file (a_file) then
				l_exec_access_date := (create {RAW_FILE}.make (a_file)).date
				Result := l_exec_access_date < a_date
			end
		end


	match (a_string: STRING; a_patterns: LIST [STRING]): BOOLEAN
				-- Checks if a_string matches with any of the strings in a_patterns
				--
				-- `a_string': The string to be compared
				-- `a_patterns': A list of strings. Usage: 'match_exact' or '*match_ending' or '*' (match any string)
				--		Examples:
				--				- 'EIFGENs':	Matches all strings that are equal "EIFGENs"
				--				- '*safe.ecf':	Matches all strings that end with "safe.ecf"
				--				- '*':			Matches all strings
		local
			l_pattern: STRING
		do
			Result := False
			from
				a_patterns.start
			until
				a_patterns.after or Result
			loop
				if a_patterns.item_for_iteration.starts_with ("*") then
					if a_patterns.item_for_iteration.count < 2 then
							-- Always match if starts with * and only one char long
						Result := True
					end
					l_pattern := a_patterns.item_for_iteration.substring (2, a_patterns.item_for_iteration.count)
					if a_string.ends_with (l_pattern) then
						Result := True
					end
				else
					if a_string.is_equal (a_patterns.item_for_iteration) then
						Result := True
					end
				end
				a_patterns.forth
			end
		end

	scan_for_files (a_folder: STRING; a_levels: INTEGER_32; a_include_file_ext: LIST [STRING]; a_exclude_folder: LIST [STRING]): LINKED_LIST [FILE_NAME]
			-- Recursively scans a folder for matching files.
			--
			-- `a_folder': Folder location to scan.
			-- `a_levels': Number of levels to recursively scan. 0 to scan the specified folder only, -1 to scan all folders.
			-- `a_include_file_ext': A list of patterns that match files that should be included. See XU_FILE_UTILITIES.match.
			-- `a_exclude_folder': A list of patterns that match folders that should be excluded from the scan. See XU_FILE_UTILITIES.match.
		require
			not_a_folder_is_empty: not a_folder.is_empty
			a_include_attached: a_include_file_ext /= Void
			a_exclude_attached: a_exclude_folder /= Void
			is_dir_ok: is_dir (a_folder)
		local
			l_dir: DIRECTORY
			l_file: RAW_FILE
			l_files: LIST [STRING]
			l_fn: FILE_NAME
		do
			create Result.make
				-- Stop if levels reach zero (ignore levels below zero)
			if not (a_levels = 0) then
				create l_dir.make (a_folder)
					-- Travel through all files and folders inside a folder
				from
					l_files := l_dir.linear_representation
					l_files.start
				until
					l_files.after
				loop
					create l_fn.make_from_string (a_folder)
					l_fn.extend (l_files.item_for_iteration)
					create l_file.make (l_fn.string)

					if l_file.is_directory then
							-- Go into subfolders if not excluded
						if not (match (l_files.item_for_iteration, a_exclude_folder) or l_files.item_for_iteration.is_equal (".") or l_files.item_for_iteration.is_equal ("..")) then
							Result.append (scan_for_files (l_file.name, a_levels - 1, a_include_file_ext, a_exclude_folder))
						end
					else
							-- Append files if included
						if match (l_files.item_for_iteration, a_include_file_ext) then
							Result.force (l_fn)
						end
					end
					l_files.forth
				end
			end
		end
end

