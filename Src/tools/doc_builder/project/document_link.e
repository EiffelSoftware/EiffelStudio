indexing
	description: "Document link.  A url and (optionally) the name of the file in which it occurs.  The `url'%
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
			url_not_void: a_url /= Void
		do
			filename := a_filename
			url := a_url
			tidy
		ensure
			has_url: url /= Void
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
		require
			occurs_in_file: filename /= Void
		local
			l_abs, l_url_name, l_file_name: STRING
			l_url_arr, l_filename_arr, 
			l_big_arr, l_small_arr: ARRAY [STRING]
			cnt: INTEGER
			l_match, l_parent: BOOLEAN
			l_filename: FILE_NAME
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
						create Result.make_from_string (l_url_name)
						if l_url_arr /= Void and l_filename_arr /= Void then
									-- Determine the larger of the arrays.  If the url
									-- array is larger the Result refers to a subdirectory
									-- of `filename', otherwise it refers to a parent directory.
							if l_url_arr.count >= l_filename_arr.count then
								l_big_arr := l_url_arr
								l_small_arr := l_filename_arr
							else
								l_big_arr := l_filename_arr
								l_small_arr := l_url_arr
								l_parent := True
							end
							
									-- Compare array directory items until they don't match
							from
								cnt := 1
								l_match := True
							until
								cnt > l_big_arr.count or cnt > l_small_arr.count or not l_match
							loop
								l_match := l_big_arr.item (cnt).is_equal (l_small_arr.item (cnt))
								cnt := cnt + 1
							end
							
								-- Build result based on position of first non-match
							from
								create l_filename.make
							until
								cnt > l_big_arr.count
							loop
								if l_parent then
									l_filename.extend ("..")
								else
									l_filename.extend (l_big_arr.item (cnt))									
								end
								cnt := cnt + 1
							end
							if not l_filename.is_empty then
								l_filename.extend (l_url_name)
								create l_filename.make_from_string (l_filename.string.substring (2, l_filename.string.count))
							else
								create l_filename.make_from_string (Result)
							end
							Result := l_filename.string
						end
					end
				end	
			end
		end		
		
	root_url: STRING is
			-- The value of `url' in relation to root directory.
		do
			if relative_from_root then
				Result := url
			else
				Result := absolute_url
				Result.replace_substring_all (root_directory, "")
			end
		end	
			
	absolute_url: STRING is
			-- Return the absolute directory path from `url'.
			-- For example, given `./../../a_dir/a_file.html' url, where `file_name'
			-- is `C:\my_projects\a_project\a_dir\b_dir\c_dir\d_dir\current_file.html'
			-- the result would be, `C:\my_project\a_project\a_dir\a_file.html'.
			-- For a root level link of the type `/a_dir/a_file.html' return the absolute
			-- url from the known root directory in `root_directory'.
		require
			occurs_in_file: filename /= Void
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
						if l_substring.is_equal ("../") or l_substring.is_equal ("..\") then
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
					Result := Result.substring ((l_parents * 3) + 1, Result.count)
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
			-- Return `url' formatted according to `a_type'
		require
			valid_type: (a_type = document_relative) or (a_type = root_relative) or (a_type = absolute)
		do
			if a_type = Document_relative then
				Result := relative_url
			elseif a_type = Root_relative then
				Result := root_url
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
				l_this_url.replace_substring_all ("\", "/")
				l_that_url.replace_substring_all ("\", "/")
				Result := l_this_url.is_equal (l_that_url)
			end
		end

	exists: BOOLEAN is
			-- Does `url' physically exists?  Use this function to determine bad links
		local
			l_file: RAW_FILE
			l_url: STRING
		do
			if external_link then
					-- TO DO:  Check for existence of external resource	
			else
					-- First check raw url
				create l_file.make (url)
				Result := l_file.exists
				
					-- If fails convert url and check again
				if not Result and then filename /= Void then
					l_url := absolute_url
					if l_url /= Void and then not l_url.is_empty then
						create l_file.make (l_url)
						Result := l_file.exists
					end
				end				
			end
		end		

	external_link: BOOLEAN is
			-- Is `url' a link to an external resource?
		do
			Result := 
				url.has_substring ("www.") or 
				url.has_substring ("http:") or
				url.has_substring ("https:") or
				url.has_substring ("ftp:") or
				url.has_substring ("mailto:")
		end

feature {DOCUMENT_LINK} -- Query

	relative_from_document: BOOLEAN is
			-- Is `url' relative to document from which it is referenced?
		require
			occurs_in_file: filename /= Void
		local			
			l_first_char: CHARACTER
			l_file: RAW_FILE
			l_filename: FILE_NAME
		do
					-- Does url begin with '.'?
			l_first_char := url.item (1)
			Result := l_first_char = '.'
			if not Result then
					-- Since it does not start with a '.', if it does not contain
					-- any path sepaartors it must be relative to document
				Result := url.occurrences ('/') = 0 and url.occurrences ('\') = 0
			end
			
					-- Can file be created from location of filename appended with
					-- url?  If so must be relative to document
			if not Result and then (url.occurrences (':') = 0)then
				create l_filename.make_from_string (directory_no_file_name (filename))
				l_filename.extend (url)
				create l_file.make (l_filename)
				Result := l_file.exists
			end
			
					-- Can a file be created from `url'.  If so it must be absolute, not relative
			if not Result then
				create l_file.make (url)
				if l_file.exists then
					Result := False
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
			Result := Shared_project.root_directory
		end

feature -- Implementation
		
	document_relative,
	root_relative,
	absolute: INTEGER is unique
		
invariant
	has_url: url /= Void
	has_filename: filename /= Void
	
end -- class DOCUMENT_LINK
