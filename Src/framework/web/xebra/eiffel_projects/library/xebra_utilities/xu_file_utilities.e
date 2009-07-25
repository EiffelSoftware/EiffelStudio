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

	Max_file_replace_size: INTEGER_32 = 1000000

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
			l_exp: STRING_AGENT_EXPANDER
		do
			create l_exp
			Result := l_exp.expand_string (a_path, replacer, a_keep)
		ensure
			result_attached: Result /= Void
		end

	replace_in_file (a_file: FILE_NAME; a_replacee: STRING; a_replacer: STRING)
			-- Opens a_file if it exists and replaces all occurrences of a_replacee with a_replacer
			-- Reads the whole file into a string. This feature should only be used on 'small' text files.
			-- Adds errors to ERROR_SHARED_MULTI_ERROR_MANAGER, don't forget to handle errors afterwards.
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
				if l_file.count > Max_file_replace_size then
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
			if plain_text_file.exists then
				if plain_text_file.is_readable and then plain_text_file.is_access_readable then
					plain_text_file.open_read
					if plain_text_file.is_open_read then
						Result := plain_text_file
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
			if plain_text_file.exists then
				if plain_text_file.is_writable and plain_text_file.is_access_writable then
					plain_text_file.open_write
					if plain_text_file.is_open_write then
						Result := plain_text_file
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
			if plain_text_file.exists or plain_text_file.is_creatable then
				plain_text_file.open_write
				if plain_text_file.is_writable and plain_text_file.is_access_writable then
					if plain_text_file.is_open_write then
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
			if plain_text_file.exists then
				if plain_text_file.is_writable and plain_text_file.is_access_writable then
					plain_text_file.open_append
					if plain_text_file.is_open_write then
						Result := plain_text_file
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
			if plain_text_file.exists or plain_text_file.is_creatable then
				plain_text_file.open_append
				if plain_text_file.is_writable and plain_text_file.is_access_writable then
					if plain_text_file.is_open_write then
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

	close
			-- Closes (all) open files
		do
			if attached  plain_text_file and then plain_text_file.is_open_read or plain_text_file.is_open_write then
				plain_text_file.close
			end
		end



	scan_for_files (a_folder: STRING; a_levels: INTEGER; a_include_pattern: STRING; a_exclude_pattern: STRING): ARRAYED_LIST [FILE_NAME]
			-- Scans a folder for matching folders.
			--
			-- `a_folder': Folder location to scan.
			-- `a_levels': Number of levels to recursively scan. 0 to scan the specified folder only, -1 to scan all folders.
			-- `a_include': Regular expression used to progressively include files/folders.
			-- `a_exclude': Regulat expression used to exclude files/folders.
		local
			l_include: RX_PCRE_MATCHER
			l_exclude: RX_PCRE_MATCHER
			l_list: DS_ARRAYED_LIST [STRING]
		do
			create Result.make (1)
			create l_include.make
			create l_exclude.make
			l_include.compile (a_include_pattern)
			l_exclude.compile (a_exclude_pattern)
			l_list := (create {FILE_UTILITIES}).scan_for_files (a_folder, a_levels, l_include, l_exclude)
			from
				l_list.start
			until
				l_list.after
			loop
				Result.force (create {FILE_NAME}.make_from_string (l_list.item_for_iteration))
				l_list.forth
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

	file_is_newer (a_file, a_dir: FILE_NAME; a_maching_files_expr: STRING): BOOLEAN
				-- Returns True if there is a file in a_dir (recursively) that matches a_maching_files_expr
				-- that is newer than a_file or a_file does not exist
		require
			not_a_file_is_detached_or_empty: a_file /= Void and then not a_file.is_empty
			not_a_dir_is_detached_or_empty: a_dir /= Void and then not a_dir.is_empty
			not_a_maching_files_expr_is_detached_or_empty: a_maching_files_expr /= Void and then not a_maching_files_expr.is_empty
		local
			l_dir: DIRECTORY
			l_files: LIST [STRING]
			l_file: RAW_FILE
			l_exec_access_date: INTEGER
		do
			Result := False
			if is_readable_file (a_file) then
				l_exec_access_date := (create {RAW_FILE}.make (a_file)).date
				l_files := scan_for_files (a_dir.out, -1, a_maching_files_expr, "\.svn|EIFGENs")
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

feature {NONE} -- Internal

	replacer: FUNCTION [ANY, TUPLE [READABLE_STRING_8], detachable STRING]
			-- Converts get from EXECUTION_ENVIRONMENT to be usable by string expander
		once
			Result := agent (ia_exec: EXECUTION_ENVIRONMENT; a_name: READABLE_STRING_8): STRING
				do
					Result := ia_exec.get (a_name.as_string_8)
				end (create {EXECUTION_ENVIRONMENT}, ?)
		end
end

