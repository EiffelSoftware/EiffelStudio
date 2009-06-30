note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XU_FILE_UTILITIES

inherit
	ERROR_SHARED_MULTI_ERROR_MANAGER


create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do

		end

feature {NONE} -- Access

	plain_text_file: detachable PLAIN_TEXT_FILE

feature {NONE} -- Internal


feature -- Basic Opertaions

	plain_text_file_read (a_file_name: STRING): detachable PLAIN_TEXT_FILE
			-- Opens a plain text file for reading
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
			-- Opens a plain text file for writing
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
			-- Opens a plain text file for writing or creates one
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

	close
			-- Closes (all) open files
		do
			if attached  plain_text_file and then plain_text_file.is_open_read or plain_text_file.is_open_write then
				plain_text_file.close
			end
		end



	scan_for_files (a_folder: STRING; a_levels: INTEGER; a_include_pattern: STRING; a_exclude_pattern: STRING): ARRAYED_LIST [FILE_NAME]
		-- See FILE_UTILITIES.scan_for_files
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
			Result := l_file.exists and l_file.is_readable
		end

	is_executable_file (a_path: STRING): BOOLEAN
			-- Checks if the path is a valid filename and the file can be executed
		local
			l_file: RAW_FILE
		do
			create l_file.make (a_path)
			Result := l_file.exists and l_file.is_executable
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
				-- Returns True iff there is a file in a_dir (recursively)  that matches a_maching_files_expr
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
				--	if l_files.item_for_iteration.ends_with (a_ext1) or l_files.item_for_iteration.ends_with (a_ext2) then
						create l_file.make (l_files.item_for_iteration)

						if (l_file.date > l_exec_access_date) then
							Result := True
						--o.dprint ("File '" + l_file.name + "' is newer (" + l_file.date.out + ")  than  (" + l_exec_access_date.out + ")",5)
						end
				--	end
					l_files.forth
				end
			else
				Result := True
				--o.dprint ("File '" + a_file + "' does not exist.", 5)
			end
		end

	file_is_older_than (a_file: FILE_NAME; a_date: INTEGER): BOOLEAN
				-- Returns False iff the file exists and it is newer than `a_date'
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


feature -- Status setting

feature -- Basic operations

feature {NONE} -- Implementation

invariant

end

