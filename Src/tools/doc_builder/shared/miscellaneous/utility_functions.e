indexing
	description: "Functions for general utility."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			l_filename: FILE_NAME
			retried: BOOLEAN
		do	
			if not retried then
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
						create l_filename.make_from_string (path)
						l_filename.extend (a_dir.lastentry)
						create src_sub_dir.make (l_filename.string)
						if not src_sub_dir.exists then
								-- This is not a directory, so check for file
							create l_filename.make_from_string (path)
							l_filename.extend (a_dir.lastentry)
							create l_file.make (l_filename.string)
							if l_file.exists then
									-- This is a file
								create l_filename.make_from_string (target.name)
								create sub_dir.make (l_filename.string)
								if not sub_dir.exists then
									print ("Unable to make file: " + a_dir.lastentry + " because the following directory does not%
									% exist:" + l_filename.string + "%N")
								else
									l_filename.extend (a_dir.lastentry)
									create target_file.make_create_read_write (l_filename.string)
									target_file.close
									if not l_file.is_empty then
										copy_file (l_file, target_file)	
									end
								end
								
							end
						else		
								-- This is a directory
							create l_filename.make_from_string (target.name)
							create sub_dir.make (l_filename.string)
							if not sub_dir.exists then
								print ("Unable to copy directory: " + src_sub_dir.name + " to " + sub_dir.name + "because " +
								sub_dir.name + " does not exist%N")
							else
								l_filename.extend (a_dir.lastentry)
								create sub_dir.make (l_filename.string)
								if not sub_dir.exists then							
									sub_dir.create_dir	
								end
								copy_directory (src_sub_dir, sub_dir)
							end
						end
					end
					cnt := cnt + 1			
				end
				a_dir.close
			end		
		ensure
			directories_closed: a_dir.is_closed and target.is_closed			
		rescue
			retried := True
			print ("Exception in UTILITY_FUNCTIONS 'copy_directory'%N")
			io.read_character
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
					create sub_dir.make (l_filename.string)
					if sub_dir.exists then
						Result := Result + directory_recursive_count (sub_dir, l_filename.string)			
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
			l_dir,
			l_dir_string: STRING
		do
			l_dir := a_dir
			l_dir.replace_substring_all ("\", "/")
			l_dir.prune_all_leading ('\')
			l_max_index := l_dir.occurrences ('\') + l_dir.occurrences ('/')
			if l_max_index > 0 then
				from
					cnt := 1
					l_arr_index := 1
					if (create {PLATFORM}).is_windows then
						create Result.make (1, l_max_index)	
					else					
						create Result.make (1, l_max_index - 1)	
					end
					create l_dir_string.make_empty
				until
					cnt > l_dir.count
				loop
					l_char := l_dir.item (cnt)
					if l_char = '/' and not l_dir_string.is_empty then
						Result.put (l_dir_string.twin, l_arr_index)
						l_dir_string.wipe_out
						l_arr_index := l_arr_index + 1
					else
						l_dir_string.append_character (l_char)
					end
					cnt := cnt + 1
				end
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
		local
			l_name: STRING
		do
			l_name := a_name.twin
			l_name.replace_substring_all ("\", "/")
			if l_name.last_index_of ('/', a_name.count) > 0 then
				Result := l_name.substring (l_name.last_index_of ('/', l_name.count) + 1, l_name.count)			
			else
				Result := l_name
			end
		ensure
			has_result: Result /= Void
		end
	
	directory_no_file_name (a_path: STRING): STRING is
			-- The full directory path `a_path' WITHOUT the file name
		require
			path_not_void: a_path /= Void
		local
			l_path: STRING
		do
			l_path := a_path.twin
			l_path.replace_substring_all ("\", "/")
			if l_path.last_index_of ('/', l_path.count) > 0 then
				Result := l_path.substring (1, l_path.last_index_of ('/', l_path.count) - 1)
			else
				Result := l_path	
			end
		ensure
			has_result: Result /= Void
		end			

	unique_name: STRING is
			-- Unique name
		do
			Result := (create {DATE_TIME}.make_now).out
			Result.replace_substring_all (".", "_")
			Result.replace_substring_all (":", "_")
			Result.replace_substring_all (" ", "_")
			Result.replace_substring_all ("\", "_")
			Result.replace_substring_all ("/", "_")
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
			l_consts: APPLICATION_CONSTANTS
		do			
			l_consts := (create {SHARED_CONSTANTS}).Application_constants
			create l_root_dir.make_from_string (l_consts.Temporary_html_directory.string)
			Result := temporary_location (a_name, l_root_dir)
			
			if with_name then
				if not l_consts.allowed_file_types.has (file_type (Result)) then
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

	temporary_help_location (a_name: STRING; with_name: BOOLEAN): STRING is
			-- Temporary directory for location of `document' in Help project
		require
			document_not_void: a_name /= Void
		local
			l_root_dir: STRING
			l_index: INTEGER
		do			
			create l_root_dir.make_from_string ((create {SHARED_CONSTANTS}).Application_constants.Temporary_help_directory.string)
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

	toc_friendly_url (a_url: STRING): STRING is
			-- TOC friendly url of `a_url'
		require
			url_not_void: a_url /= Void
		local
			l_proj_name: STRING
			l_name: FILE_NAME
		do
			Result := a_url.twin
			l_proj_name := (create {SHARED_OBJECTS}).Shared_project.root_directory
			l_proj_name.replace_substring_all ("\", "/")
			Result.replace_substring_all (l_proj_name, "")
			Result.replace_substring_all ((create {APPLICATION_CONSTANTS}).Temporary_help_directory, "")
			Result.prune_all_leading ('/')
			Result.prune_all_leading ('\')			
			create l_name.make_from_string (Result)				
			Result := l_name.string
			Result.replace_substring_all ("\", "/")
		end		

	is_code_document (a_doc: DOCUMENT): BOOLEAN is
			-- Is `a_doc' a code document
		local
			l_name,
			l_lib_name: STRING
			l_code_dir: FILE_NAME
		do
			create l_code_dir.make_from_string (a_doc.shared_project.root_directory)
			l_code_dir.extend ("libraries")
			l_lib_name := l_code_dir.string
			l_lib_name.replace_substring_all ("\", "/")
			l_name := a_doc.name
			l_name.replace_substring_all ("\", "/")
			if l_name.has_substring (l_lib_name) then
				Result := l_name.has_substring ("/reference/")
			end
		end

	stylesheet_path (a_file: STRING; rel: BOOLEAN): STRING is
			-- Path to stylesheet from `a_file'
		local
			l_name,
			a_filename: STRING
			l_link: DOCUMENT_LINK
			l_consts: SHARED_OBJECTS
		do
			create l_consts					
			if l_consts.Shared_document_manager.has_stylesheet then
				a_filename := a_file.twin
				l_name := l_consts.Shared_document_manager.stylesheet.name.twin
					-- Create a project relative link to the stylesheet file
				create l_link.make (a_file, l_name)
				if rel then
					Result := l_link.relative_url
				else
					Result := l_link.absolute_url
				end
			end				
		end	

	copy_stylesheet (a_loc: STRING) is
			-- Copy stylesheet to `a_loc'
		require
			a_loc_not_void: a_loc /= Void
		local
			l_objs: SHARED_OBJECTS
			l_target, l_src: PLAIN_TEXT_FILE
			l_filename: FILE_NAME
		do
			create l_objs
			if l_objs.Shared_document_manager.has_stylesheet then				
				create l_filename.make_from_string (a_loc)
				l_filename.extend (short_name (l_objs.Shared_document_manager.stylesheet.name))
				create l_target.make_create_read_write (l_filename.string)
				l_target.close
				create l_src.make (l_objs.Shared_document_manager.stylesheet.name)
				copy_file (l_src, l_target)
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
			Result := a_name.twin
			Result.replace_substring_all ("\", "/")
			l_proj_root := (create {SHARED_OBJECTS}).Shared_project.root_directory
			l_proj_root.replace_substring_all ("\", "/")
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
			if Result.item (1) = '/' then
				Result := Result.substring (2, Result.count)
			end
			l_file_name.extend (Result)
			Result := l_file_name.string.twin
			
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
					create l_sub_dir.make (l_sub_dir_name.string)
					if not l_sub_dir.exists then
						l_sub_dir.create_dir
					end
					l_cnt := l_cnt + 1
				end
			end	
		end		

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class UTILITY_FUNCTIONS
