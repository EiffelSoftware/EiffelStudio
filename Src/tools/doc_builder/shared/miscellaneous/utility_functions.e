indexing
	description: "Functions for general utility."
	date: "$Date$"
	revision: "$Revision$"

class
	UTILITY_FUNCTIONS

feature -- Copying

	copy_directory (a_dir, target: DIRECTORY) is
			-- Copy `a_dir' to `target' on disk including sub folders and files
		require
			directories_not_void: a_dir /= Void and target /= Void
			directories_exist: a_dir.exists and target.exists
			directories_not_already_open: a_dir.is_closed and target.is_closed
		local
			cnt, l_cnt: INTEGER
			sub_dir, src_sub_dir: DIRECTORY
			l_file, target_file: RAW_FILE
			path: STRING
		do	
			from
				cnt := 0
				a_dir.open_read
				a_dir.start
				path := a_dir.name
				l_cnt := a_dir.count
			until
				cnt = l_cnt
			loop	
				a_dir.readentry
				if not (a_dir.lastentry.is_equal (".") or a_dir.lastentry.is_equal ("..")) then
					create src_sub_dir.make (path + "\" + a_dir.lastentry)
					if not src_sub_dir.exists then
						create l_file.make (path + "\" + a_dir.lastentry)
						if l_file.exists then
							create target_file.make_create_read_write (target.name + "\" + a_dir.lastentry)
							target_file.close
							if not l_file.is_empty then
								copy_file (l_file, target_file)	
							end
						end
					else						
						create sub_dir.make (target.name + "\" + a_dir.lastentry)
						sub_dir.create_dir
						copy_directory (src_sub_dir, sub_dir)
					end
				end
				cnt := cnt + 1			
			end
			a_dir.close
		ensure
			directories_closed: a_dir.is_closed and target.is_closed
		end		

	copy_file (file, target: FILE) is
			-- Copy contents of `file' to `target'
		require
			files_not_void: file /= Void and target /= Void
			source_files_exists: file.exists
			source_file_not_already_open: not file.is_open_read 
			target_file_not_already_open: not target.is_open_write
		local
			l_ptf, l_ptf2: PLAIN_TEXT_FILE
		do
			l_ptf ?= file
			l_ptf2 ?= target
			if l_ptf /= Void and then l_ptf2 /= Void then
				copy_text_file (l_ptf, l_ptf2)
			else
				file.open_read
				target.open_write
				file.start
				target.start
				file.copy_to (target)
				file.close
				target.close
			end
		ensure
			files_closed: file.is_closed and target.is_closed
		end
		
	copy_text_file (text_file, target: PLAIN_TEXT_FILE) is
			-- Copy contents of `text_file' to `target'
		require
			files_not_void: text_file /= Void and target /= Void
			files_exists: text_file.exists and target.exists
			files_not_already_open: not text_file.is_open_read and not target.is_open_write
		do
			from
				text_file.open_read
				target.open_write
				text_file.start
			until
				text_file.end_of_file
			loop
				text_file.read_line
				target.put_string (text_file.last_string + "%N")
			end
			text_file.close
			target.close
		ensure
			files_closed: text_file.is_closed and target.is_closed
		end

feature -- Directory

	directory_recursive_count (a_dir: DIRECTORY; path: STRING): INTEGER is
			-- Number of children (files and sub-folders) of `a_dir'
		local
			sub_dir: DIRECTORY
			cnt, l_cnt: INTEGER
			l_filename: FILE_NAME
		do
			from
				a_dir.open_read
				cnt := 0
				l_cnt := a_dir.count
			until
				cnt = l_cnt
			loop
				a_dir.readentry
				if not (a_dir.lastentry.is_equal (".") or a_dir.lastentry.is_equal ("..")) then
					create l_filename.make_from_string (path)
					l_filename.extend (a_dir.lastentry)
					create sub_dir.make (l_filename)
					if sub_dir.exists then
						Result := Result + directory_recursive_count (sub_dir, l_filename)			
					else
						Result := Result + 1
					end
				end
				cnt := cnt + 1	
			end			
		end

	directory_array (a_dir: STRING): ARRAY [STRING] is
			-- Directory `a_dir' broken down into array or directories.  For example
			-- `C:\a_dir\b_dir' returns the array `<<"a_dir", "b_dir">>'.  If there is a
			-- filename at the end of `a_dir' it is discarded.  To be sure last directory
			-- name is not discarded mistakenly as a file name always put '\' or '/' at end,
			-- like so: `a_dir/b_dir/c_dir/', not: `a_dir/b_dir/c_dir'
		require
			directory_not_void: a_dir /= Void
			directory_not_empty: not a_dir.is_empty
		local
			cnt, l_max_index, l_arr_index: INTEGER
			l_char: CHARACTER
			l_dir_string: STRING
		do
			l_max_index := a_dir.occurrences ('\') + a_dir.occurrences ('/')
			if l_max_index > 0 then
				from
					cnt := 1
					l_arr_index := 1
					create Result.make (1, l_max_index)
					create l_dir_string.make_empty				
				until
					cnt > a_dir.count
				loop
					l_char := a_dir.item (cnt)
					if l_char = '/' or l_char = '\' and then not l_dir_string.is_empty then
						Result.put (clone (l_dir_string), l_arr_index)
						l_dir_string.wipe_out
						l_arr_index := l_arr_index + 1
					else
						l_dir_string.append_character (l_char)
					end
					cnt := cnt + 1
				end
				
--				if 
--					l_dir_string /= Void and then 
--					not l_dir_string.is_empty and then 
--					(l_dir_string.occurrences ('.') > 0) 
--				then
--					Result.put ("", l_arr_index)
--				end
			end
		ensure
			array_not_empty_if_has_separators: (a_dir.occurrences ('\') + a_dir.occurrences ('/') > 0) implies not Result.is_empty
		end

feature -- File

	file_type (a_file: STRING): STRING is
			-- Return file extension for `a_file', or else an empty string.
		do
			create Result.make_empty
			if not (a_file.occurrences ('.') = 0) then
				Result ?= a_file.substring (a_file.last_index_of ('.', a_file.count) + 1, a_file.count)
				Result.to_lower
			else
				create Result.make_empty
			end
		end
		
	file_no_extension (a_file: STRING): STRING is
			-- Return file name for `a_file' WITHOUT the extension
		require
			name_not_void: a_file /= Void
		do
			if not (a_file.occurrences ('.') = 0) then
				Result ?= a_file.substring (1, a_file.last_index_of ('.', a_file.count) - 1)
			else
				Result := a_file
			end
		ensure
			has_result: Result /= Void
		end
	
	short_name (a_name: STRING): STRING is
			-- Short file/directory name (minus directory hierarchy) of `a_name'
		require
			name_not_void: a_name /= Void
		do
			Result := a_name.substring (a_name.last_index_of ('\', a_name.count) + 1, a_name.count)
			if Result.is_empty then
				Result := a_name.substring (a_name.last_index_of ('/', a_name.count) + 1, a_name.count)
				if Result.is_empty then
					Result := a_name
				end
			end
		ensure
			has_result: Result /= Void
		end
	
	directory_no_file_name (a_path: STRING): STRING is
			-- The full directory path `a_path' WITHOUT the file name
		require
			path_not_void: a_path /= Void
		do
			Result := a_path.substring (1, a_path.last_index_of ('\', a_path.count) - 1)
			if Result.is_empty then
				Result := a_path.substring (1, a_path.last_index_of ('/', a_path.count) - 1)
				if Result.is_empty then
					Result := a_path	
				end
			end
		ensure
			has_result: Result /= Void
		end		

feature -- String

	is_alpha_numeric_string (a_string: STRING): BOOLEAN is
			-- Does `a_string' contain only alphanumeric characters?
		require
			string_not_not_void: a_string /= Void
		local
			cnt: INTEGER
			l_char: CHARACTER
		do
			from
				cnt := 1
				Result := True
			until
				cnt > a_string.count or not Result
			loop
				l_char := a_string.item (cnt)
				Result := (l_char.is_alpha or l_char.is_digit)
				cnt := cnt + 1
			end
		end		

	tidied_string (a_string: STRING): STRING is
			-- Tidy `a_string'
		do
			Result := a_string
			Result.prune_all_leading ('%N')
			Result.prune_all_leading ('%T')
			Result.prune_all_trailing ('%N')
			Result.prune_all_trailing ('%T')
		end		

feature -- Document

	temporary_html_location (a_name: STRING; with_name: BOOLEAN): STRING is
			-- Temporary directory for location of `document' in HTML
		require
			document_not_void: a_name /= Void
		local
			l_root_dir: STRING
			l_index: INTEGER
		do			
			create l_root_dir.make_from_string ((create {SHARED_CONSTANTS}).Application_constants.Temporary_html_directory.string)
			Result := temporary_location (a_name, l_root_dir)
			
			if with_name then
				if 
					not (file_type (Result).is_equal ("html") or 
					file_type (Result).is_equal ("css") or 
					file_type (Result).is_equal ("gif"))
				then
					l_index := Result.last_index_of ('.', Result.count)
					if l_index > 0 then					
						Result := Result.substring (1, l_index - 1)
					end
					Result.append (".html")
				end
			else
				Result := directory_no_file_name (Result)
			end			
		end	
		
	temporary_xml_location (a_name: STRING; with_name: BOOLEAN): STRING is
			-- Temporary directory for location of `document' in XML		
		require
			document_not_void: a_name /= Void
		local
			l_root_dir: STRING
			l_index: INTEGER
		do			
			create l_root_dir.make_from_string ((create {SHARED_CONSTANTS}).Application_constants.Temporary_xml_directory.string)
			Result := temporary_location (a_name, l_root_dir)
			
			if with_name then
				if not file_type (Result).is_equal ("xml") then
					l_index := Result.last_index_of ('.', Result.count)
					if l_index > 0 then					
						Result := Result.substring (1, l_index - 1)
					end						
					Result.append (".xml")
				end
			else
				Result := directory_no_file_name (Result)
			end
		end	

	toc_friendly_url (a_url: STRING): STRING is
			-- TOC friendly url of `a_url'
		require
			url_not_void: a_url /= Void
		local
			l_name: FILE_NAME
		do
			Result := clone (a_url)
			Result.replace_substring_all ((create {SHARED_OBJECTS}).Shared_project.root_directory, "")
			Result.prune_all_leading ('/')
			Result.prune_all_leading ('\')			
			create l_name.make_from_string (Result)				
			Result := l_name.string
		end		

	is_code_document (a_doc: DOCUMENT): BOOLEAN is
			-- Is `a_doc' a code document
		local
			l_code_dir: FILE_NAME
		do
			create l_code_dir.make_from_string (a_doc.shared_project.root_directory)
			l_code_dir.extend ("libraries")
			if a_doc.name.has_substring (l_code_dir.string) then
				Result := a_doc.name.has_substring ("reference")
			end
		end

feature {NONE} -- Implementation

	temporary_location (a_name: STRING; a_root: STRING): STRING is
			-- Temporary location
		require
			doc_not_void: a_name /= Void
			root_not_void: a_root /= Void
		local
			l_proj_root: STRING
			l_sub_dir_name,
			l_file_name: FILE_NAME
			l_dir_arr: ARRAY [STRING]
			l_cnt: INTEGER
			l_sub_dir: DIRECTORY
		do				
			Result := clone (a_name)
			l_proj_root := (create {SHARED_OBJECTS}).Shared_project.root_directory
			if l_proj_root /= Void then
				if Result.has_substring (l_proj_root) then
					Result.replace_substring_all (l_proj_root, "")
				else
					if Result.has (':') then
						Result := short_name (Result)
					end
				end
				
			end
			create l_file_name.make_from_string (a_root)
			if (Result.item (1) = '\' or Result.item (1) = '/') then
				Result := Result.substring (2, Result.count)
			end
			l_file_name.extend (Result)
			Result := clone (l_file_name.string)
			
					-- With Result path create sub-directories if necessary
			l_dir_arr := directory_array (Result)			
			if l_dir_arr /= Void then
				from
					l_cnt := 2
					create l_sub_dir_name.make_from_string (l_dir_arr.item (1))
				until
					l_cnt > l_dir_arr.count
				loop
					l_sub_dir_name.extend (l_dir_arr.item (l_cnt))
					create l_sub_dir.make (l_sub_dir_name)
					if not l_sub_dir.exists then
						l_sub_dir.create_dir
					end
					l_cnt := l_cnt + 1
				end
			end	
		end		

end -- class UTILITY_FUNCTIONS
