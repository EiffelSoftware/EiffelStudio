indexing
	description: "Document link.  A url and the name of the file in which it occurs.  The `url'%
		%property could be in any format, relative, absolute or external.  Use functions to%
		%convert between formats."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_LINK

inherit
	SHARED_OBJECTS
	
	UTILITY_FUNCTIONS

create
	make

feature -- Creation

	make (a_filename, a_url: STRING) is
			-- Make from `a_url'
		require
			filename_not_void: a_filename /= Void
			url_not_void: a_url /= Void
		do
			filename := a_filename
			url := a_url
			tidy
		end

feature -- Access

	filename: STRING
			-- File name

	url: STRING
			-- File URL as it appears in `filename'
			
	format_type: INTEGER is
			-- The format of `url'
		do
			if relative_from_document then
				Result := Document_relative
			elseif relative_from_root then
				Result := Root_relative
			else
				Result := Absolute
			end	
		end		
			
	relative_url: STRING is
			-- The relative value of `url' in relation to `filename'.
		local
			l_abs, l_url_name, l_file_name: STRING
			l_url_arr, l_filename_arr: ARRAY [STRING]
		do
			if not external_link then				
				if relative_from_document then
					Result := url
				else
					l_abs := absolute_url
					if l_abs /= void and then not l_abs.is_empty then
						l_url_name := short_name (url)
						l_file_name := short_name (filename)
						l_url_arr := directory_array (url)
						l_filename_arr := directory_array (filename)
						if l_url_arr /= Void and l_filename_arr /= Void then
							
						end
					end
				end	
			end
		end		
			
	absolute_url: STRING is
			-- Return the absolute directory path from `url'.
			-- For example, given `./../../a_dir/a_file.html' url, where `file_name'
			-- is `C:\my_projects\a_project\a_dir\b_dir\c_dir\d_dir\current_file.html'
			-- the result would be, `C:\my_project\a_project\a_dir\a_file.html'.
			-- For a root level link of the type `/a_dir/a_file.html' return the absolute
			-- url from the known root directory in `root_directory'.
		local
			l_char: CHARACTER
			l_substring: STRING
			cnt, l_parents, l_sep_pos1, l_sep_pos2: INTEGER
			l_filename: FILE_NAME
		do
			if relative_from_root then
						-- Prepend `root_directory' to `url' to get absolute file name
				create l_filename.make_from_string (root_directory)
				l_filename.extend (url.substring (2, url.count))
   				Result := l_filename.string			  				
			elseif relative_from_document then
						-- Determine number of directory parents specified in relative url
				from
					cnt := 1
					create l_substring.make_empty
				until
					cnt > url.count				
				loop
					l_char := url.item (cnt)
					l_substring.append_character (l_char)
					if l_char = '\' or l_char = '/' then
						if l_substring.is_equal ("../") then
							l_parents := l_parents + 1
						end
						l_substring.wipe_out
					end
					cnt := cnt + 1
				end
						-- Strip './' and '../' from url to leave only the filename
				if l_parents > 0 then
					if url.substring (1, 2).is_equal ("./") then
						create Result.make_from_string (url.substring (1, 2))
					else
						create Result.make_from_string (url)
					end
					Result := Result.substring (l_parents * 3, Result.count)
				else
					Result := url
				end
				
				check
					result_assigned: Result /= Void
				end
				
				l_substring := directory_no_file_name (filename)
						-- Strip `filename' of directories according to number
						-- of parents to get correct absolute directory
				from
					cnt := 1
				until
					cnt > l_parents
				loop
					l_sep_pos1 := l_substring.last_index_of ('\', l_substring.count)
					l_sep_pos2 := l_substring.last_index_of ('/', l_substring.count)
					if l_sep_pos1 > l_sep_pos2 then
						l_substring := l_substring.substring (1, l_sep_pos1 - 1)
					elseif l_sep_pos2 > 0 then
						l_substring := l_substring.substring (1, l_sep_pos2 - 1)					
					end
					cnt := cnt + 1
				end
						-- Finally append the absolute directory and file name
				create l_filename.make_from_string (l_substring)
				l_filename.extend (Result)
				Result := l_filename.string
			else
					-- Since this is not relative `../../file.ext' or root relative `/a_dir/file.ext' or 
					-- simply relative `file.ext' then it must be either an external link or absolute link.
				Result := url
			end
		ensure
			result_not_void: Result /= Void
		end	
			
feature -- Commands

	format (a_type: INTEGER): STRING is
			-- Return `url' foramtted according to `a_type'
		require
			valid_type: (a_type = document_relative) or (a_type = root_relative) or (a_type = absolute)
		do
			if a_type = Document_relative or a_type = Root_relative then
				Result := relative_url
			else
				Result := absolute_url
			end		
		end		
			
feature -- Query

	matches (a_link: like Current): BOOLEAN is
			-- Does url in `a_link' match `url' in Current?  Match here means
			-- the objects urls refer to the same physical location, NOT that the
			-- `url' STRING values are equivalent.
		require
			link_not_void: a_link /= Void
		local
			l_this_url, l_that_url: STRING
		do
					-- For external links just match url directly
			if external_link or a_link.external_link then
				Result := url.is_equal (a_link.url)
			else					
				l_this_url := absolute_url
				l_that_url := a_link.absolute_url
				Result := l_this_url.is_equal (l_that_url)
			end
		end

	exists: BOOLEAN is
			-- Does `url' physically exists?  Use this finction to determine bad links in `filename'
		local
			l_file: RAW_FILE
			l_url: STRING
		do
			if external_link then
					-- TO DO:  Check for existence of external resource	
			else
				l_url := absolute_url
				if l_url /= Void and then not l_url.is_empty then
					create l_file.make (l_url)
					Result := l_file.exists
				end
			end
		end		

feature {DOCUMENT_LINK} -- Query

	relative_from_document: BOOLEAN is
			-- Is `url' relative to document from which it is referenced?
		local			
			l_first_char: CHARACTER
			l_file: RAW_FILE
			l_filename: FILE_NAME
		do
					-- Does url begin with '.'?
			l_first_char := url.item (1)
			Result := l_first_char = '.'
			
					-- Can a file be created from `url'.  If so it must be
					-- absolute
			if not Result then
				create l_file.make (url)
				Result := l_file.exists
						-- Can file be created from location of filename appended with
						-- url?  If so must be relative to document
				if not Result and then not (url.occurrences (':') > 0) then
					create l_filename.make_from_string (directory_no_file_name (filename))
					l_filename.extend (url)
					create l_file.make (l_filename)
					Result := l_file.exists
				else
					Result := not Result
				end
			end				
		end		
	
	relative_from_root: BOOLEAN is
			-- Is `url' relative from project root?
		local			
			l_first_char: CHARACTER
		do
			l_first_char := url.item (1)
			Result := l_first_char = '\' or l_first_char = '/'
		end		

	external_link: BOOLEAN is
			-- Is `url' a link to an external resource?
		do
			Result := 
				url.has_substring ("www.") or 
				url.has_substring ("http:") or
				url.has_substring ("https:") or
				url.has_substring ("ftp:")
		end

	in_document (a_document: DOCUMENT): BOOLEAN is
			-- Is there a link to `url' in `a_document'?
		require
			document_not_void: a_document /= Void
		local
			l_link: like Current
		do
			from 
				a_document.links.start
			until
				a_document.links.after
			loop
				l_link := a_document.links.item
				a_document.links.forth
			end
		end
		
feature {NONE} -- Implmentation

	tidy is
			-- Tidy `url'
		do
			url.prune_all_leading ('%N')
			url.prune_all_leading ('%T')
			url.prune_all_trailing ('%N')
			url.prune_all_trailing ('%T')
		end	

	root_directory: STRING is
			-- Root
		do
			Result := Shared_project.preferences.root_directory
		end

feature -- Implemntation
		
	document_relative,
	root_relative,
	absolute: INTEGER is unique
		
invariant
	has_url: url /= Void
	has_filename: filename /= Void
	
end -- class DOCUMENT_LINK
