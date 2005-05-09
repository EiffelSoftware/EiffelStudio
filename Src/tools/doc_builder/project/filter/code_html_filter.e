indexing
	description: "Eiffel code HTML filter.  Takes Eiffel generated XML library code file%
		%and produces HTML."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_HTML_FILTER

inherit
	TEMPLATE_CONSTANTS
	
	UTILITY_FUNCTIONS

create
	make

feature -- Creation	

	make (a_target, a_src: DIRECTORY) is
			-- Create new filter and build HTML recursively into `a_target' based upon
			-- xml in `a_src'
		require
			directory_not_void: a_target /= Void
			directory_exists: a_target.exists
			src_directory_not_void: a_src /= Void
			src_directory_exists: a_src.exists
		do
			target_directory := a_target
			src_directory := a_src
			build_html
		ensure
			has_target: target_directory /= Void and target_directory = a_target
		end	

feature -- Generation

	generated_html (a_file: PLAIN_TEXT_FILE): STRING is
			-- Generated HTML from `a_file'
		require
			file_not_void: a_file /= Void			
			file_exists: a_file.exists
		local
			retried: BOOLEAN
			l_string: STRING
			l_parser: XM_EIFFEL_PARSER
		do	
			if not retried then
				a_file.open_read
				a_file.readstream (a_file.count)
				l_string := a_file.laststring
				if not l_string.is_empty then					
					xml_reader.make (a_file)
					create l_parser.make
					l_parser.set_string_mode_ascii
					l_parser.set_callbacks (xml_reader)
					l_parser.parse_from_string (l_string)
					check
						ok_parsing: l_parser.is_correct
					end
					Result := xml_reader.output_string
				end
				a_file.close
			else
				create Result.make_empty
			end
		ensure
			generate_html_not_void: Result /= Void
		rescue
			retried := True
			retry
		end

feature {NONE} -- Access

	target_directory: DIRECTORY
			-- Target directory for HTML files		

	src_directory: DIRECTORY
			-- Src directory of XML files

feature {NONE} -- Commands

	build_html is
			-- Build HTML files
		do
			build_code (target_directory, src_directory)
		end		

	build_code (a_target, a_src: DIRECTORY) is
			-- Build code HTML
		local
			l_sub_dir, l_target: DIRECTORY
			l_dir_name: FILE_NAME
			l_cnt: INTEGER
			l_path, l_dir, 
			l_text, 
			l_html,
			l_title: STRING
			l_file, l_target_file: PLAIN_TEXT_FILE
		do
			from			
				l_cnt := 1
				a_src.open_read
				a_src.start
				create l_dir.make_empty
			until
				l_dir = Void
			loop
				l_path := a_src.name.string
				a_src.readentry
				l_dir := a_src.lastentry
				if l_dir /= Void and then not l_dir.is_equal (".") and not l_dir.is_equal ("..") then
					create l_dir_name.make_from_string (l_path)
					l_dir_name.extend (l_dir)
					create l_sub_dir.make (l_dir_name.string)
					if l_sub_dir.exists then
						create l_dir_name.make_from_string (a_target.name)
						l_dir_name.extend (l_dir)
						create l_target.make (l_dir_name.string)
						if not l_target.exists then
							l_target.create_dir							
						end
						build_code (l_target, l_sub_dir)
					else
						create l_file.make (l_dir_name.string)
						if l_file.exists then
							if file_type (l_file.name).is_equal ("xml") then
								create l_dir_name.make_from_string (a_target.name)
								l_title := file_no_extension (short_name (l_file.name))
								l_dir_name.extend (l_title)
								l_dir_name.add_extension ("html")

								create l_target_file.make_create_read_write (l_dir_name.string)					
								
									-- Workaround as result if including extra reference directory
								l_title.replace_substring_all (Chart_suffix, "")
								l_title.replace_substring_all (Contract_suffix, "")
								l_title.to_upper								
								
								l_html := generated_html (l_file)
								l_path := l_dir_name.string								
								l_text := 
									"<html><head><title>" + 
									l_title +
									"</title><link rel=%"stylesheet%" href=%"" + 
									stylesheet_path (l_file.name, True)	+
									"%" type=%"text/css%">" + filter_script (l_dir_name.string) +
									"</head><body><pre>" +
									l_html +
									"</pre></body></html>"
									
								l_target_file.putstring (l_text)
								l_target_file.close
							end
						end
					end								
				end			
				l_cnt := l_cnt + 1
			end
			a_src.close
		end

	xml_reader: CODE_XML_READER is
			-- XML reader that we reuse over and over.
		once
			create Result.make_filter
		ensure
			xml_reader_not_void: Result /= Void
		end
		
feature {NONE} -- Implementation
		
	filter_script (a_filename: STRING): STRING is
			-- Javascript filter script
		local
			l_toc_script_name,
			l_filename,
			l_toc_name: STRING
			l_util: UTILITY_FUNCTIONS
			l_shared_objects: SHARED_OBJECTS
		do
			create l_shared_objects
			create Result.make_empty
			if l_shared_objects.shared_constants.help_constants.is_web_help then
				if not l_shared_objects.shared_constants.help_constants.is_tree_web_help then				
					l_toc_script_name := "simple_toc.js"
				else				
					l_toc_script_name := "toc.js"
				end
				create l_util
				l_filename := a_filename
				l_filename.replace_substring_all (l_shared_objects.shared_constants.application_constants.temporary_html_directory, "")
				l_filename.replace_substring_all ("\", "/")
				l_filename.prune_all_leading ('/')
				l_toc_name := l_util.short_name (l_shared_objects.shared_constants.help_constants.toc.name)
				if l_filename.substring (1, l_toc_name.count).is_equal (l_toc_name) then
					l_filename.remove_substring (1, l_toc_name.count + 1)
				end
				l_filename := l_util.file_no_extension (l_filename)
				Result.append ("<script Language=%"JavaScript%" type=%"text/javascript%" src=%"" + relative_path_to_help_project (l_filename) + l_toc_script_name)
				Result.append ("%"></script><script Language=%"JavaScript%">")
				Result.append ("doc = '")
				Result.append (l_filename + ".html';")
				Result.append ("toc = '" + l_util.short_name (l_shared_objects.shared_constants.help_constants.toc.name) + "';")
				Result.append ("deleteCookie('tocName');var now = new Date();var expdate = new Date (now.getTime () + 1 * 24 + 60 * 60 * 1000);setCookie('tocName', toc, expdate);")
				Result.append ("if (parent.toc_frame){parent.toc_frame.documentLoaded(doc);}%
					%else{var now = new Date();var expdate = new Date (now.getTime () + 1 * 24 + 60 * 60 * 1000);setCookie ('delete', 'true', expdate);%
					%setCookie ('redirecturl', doc, expdate);window.location.replace ('" + relative_path_to_help_project (l_filename) + 
					l_shared_objects.shared_constants.help_constants.help_project_name + "_no_content.html');}</script>")			
			end
		ensure
			has_result: Result /= Void
		end	
		
	relative_path_to_help_project (a_file: STRING): STRING is
			-- 
		local
			l_link: DOCUMENT_LINK
			l_path: STRING
			l_shared_objects: SHARED_OBJECTS
		do
			create l_shared_objects
			l_path := temporary_html_location (a_file, True)			
			create l_link.make (l_path, l_shared_objects.shared_constants.application_constants.temporary_html_directory.string)
			Result := l_link.relative_url
			if Result.last_index_of ('/', Result.count) > 0 then				
				Result := Result.substring (1, Result.last_index_of ('/', Result.count))
			end
		end		
		
end -- class CODE_HTML_FILTER
