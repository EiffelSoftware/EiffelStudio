indexing
	description: "Help project for Web content."
	date: "$Date$"
	revision: "$Revision$"

class
	WEB_HELP_PROJECT

inherit
	HELP_PROJECT

	TEMPLATE_CONSTANTS
	
	APPLICATION_CONSTANTS

create
	make
	
feature -- Commands

	build_table_of_contents is
			-- Build table of contents and write to file
		do						
			create_toc_frame
			create_filter_frame
			create_resource_files
		end

	generate is
			-- Generate
		do			
			create_project_file			
		end		
		
feature {NONE} -- File

	create_project_file is
			-- Create the project file
		local
			l_file: PLAIN_TEXT_FILE
			l_filename: FILE_NAME
			l_text: STRING
			l_util: UTILITY_FUNCTIONS
		do
			create l_file.make_open_read (web_help_project_template_file_name)
			l_file.read_stream (l_file.count)
			l_text := l_file.last_string.twin
			if is_gui_mode then
				if (create {PLAIN_TEXT_FILE}.make (toc.name)).exists then
					create l_util
					create l_filename.make_from_string (l_util.file_no_extension (l_util.short_name (toc.name)) + "/")
				else
					create l_filename.make_from_string (toc.name + "/")
				end
				replace_token (l_text, filter_frame_size_token, "120")
			else
				create l_filename.make_from_string ("")
				replace_token (l_text, filter_frame_size_token, "25")
			end
			replace_token (l_text, html_default_toc, l_filename.string)
			l_file.close
			create l_filename.make_from_string (shared_constants.application_constants.temporary_help_directory)
			l_filename.extend (name)
			l_filename.add_extension (project_filename_extension)
			create project_file.make_create_read_write (l_filename.string)
			project_file.put_string (l_text)
			project_file.close
		end

feature {NONE} -- Implementation	

	create_toc_frame is
			-- Create left side navigation (toc)
		local
			l_file,
			l_dest_file: PLAIN_TEXT_FILE			
			l_text: STRING
			l_filename: FILE_NAME
			l_util: UTILITY_FUNCTIONS
			l_dir: DIRECTORY
		do				
				-- Open TOC template and fill with project toc data
			create l_util
			create l_file.make_open_read_write (left_context_html_template_file_name.string)
			l_file.readstream (l_file.count)
			l_text := l_file.last_string.twin
			replace_token (l_text, html_toc_token, full_toc_text)
			l_file.close
			
				-- Now create toc file based on toc data
			create l_filename.make_from_string (shared_constants.application_constants.temporary_help_directory.string)
			if is_gui_mode then
				if (create {PLAIN_TEXT_FILE}.make (toc.name)).exists then
					l_filename.extend (l_util.file_no_extension (l_util.short_name (toc.name)))
				else						
					l_filename.extend (toc.name)	
				end
				create l_dir.make (l_filename.string)
				if not l_dir.exists then
					l_dir.create_dir
				end
				replace_token (l_text, html_toc_script, "../toc.js")
				replace_token (l_text, html_toc_style, "../toc.css")
			else
				replace_token (l_text, html_toc_script, "toc.js")
				replace_token (l_text, html_toc_style, "toc.css")
			end
			
				-- And write to it and close			
			l_filename.extend (l_util.short_name (left_context_html_template_file_name.string))
			create l_dest_file.make_create_read_write (l_filename.string)
			l_dest_file.put_string (l_text)
			l_dest_file.close
		end	

	create_filter_frame is
			-- Create left side navigation (filter)
		local
			l_file,
			l_dest_file: PLAIN_TEXT_FILE			
			l_text: STRING
			l_filename: FILE_NAME
			l_util: UTILITY_FUNCTIONS
			l_dir: DIRECTORY
		do				
				-- Open TOC template and fill with project toc data
			create l_util
			create l_file.make_open_read_write (filter_html_template_file_name.string)
			l_file.readstream (l_file.count)
			l_text := l_file.last_string.twin
			replace_token (l_text, html_filter_token, full_filter_text)		
			replace_token (l_text, html_filter_search_token, search_text)	
			l_file.close
			
				-- Now create toc file based on toc data
			create l_filename.make_from_string (shared_constants.application_constants.temporary_help_directory.string)
			if is_gui_mode then
				if (create {PLAIN_TEXT_FILE}.make (toc.name)).exists then
					l_filename.extend (l_util.file_no_extension (l_util.short_name (toc.name)))
				else						
					l_filename.extend (toc.name)	
				end
				create l_dir.make (l_filename.string)
				if not l_dir.exists then
					l_dir.create_dir
				end
				replace_token (l_text, html_toc_script, "../toc.js")
				replace_token (l_text, html_toc_style, "../toc.css")
			else
				replace_token (l_text, html_toc_script, "toc.js")
				replace_token (l_text, html_toc_style, "toc.css")
			end
			
				-- And write to it and close
			l_filename.extend (l_util.short_name (filter_html_template_file_name.string))
			create l_dest_file.make_create_read_write (l_filename.string)
			l_dest_file.put_string (l_text)
			l_dest_file.close
		end

	create_resource_files is
			-- Copy any resource files needed
		local
			l_util: UTILITY_FUNCTIONS
			l_src_file,
			l_file: RAW_FILE
			l_filename: FILE_NAME
			l_icon_dir,
			l_templates_dir: STRING
		do			
			create l_util
			l_icon_dir := shared_constants.application_constants.icon_resources_directory
			l_templates_dir := shared_constants.application_constants.templates_path
			
			from
				resource_files.start
			until
				resource_files.after
			loop
				create l_filename.make_from_string (l_icon_dir)
				l_filename.extend (resource_files.item)	
				create l_file.make (l_filename)				
				if not l_file.exists then					
					create l_filename.make_from_string (l_templates_dir)
					l_filename.extend (resource_files.item)
					create l_file.make (l_filename)		
				end
				
				if l_file.exists then
					create l_filename.make_from_string (shared_constants.application_constants.temporary_help_directory.string)
					if is_gui_mode then
						if (create {PLAIN_TEXT_FILE}.make (toc.name)).exists then
							l_filename.extend (l_util.file_no_extension (l_util.short_name (toc.name)))
						else						
							l_filename.extend (toc.name)	
						end
					end
					l_filename.extend (resource_files.item)
					create l_src_file.make_create_read_write (l_filename.string)
					l_src_file.close
					l_util.copy_file (l_file, l_src_file)
				end
				
				resource_files.forth
			end
			
			copy_root_resource_files
		end		

	full_filter_text: STRING is
			-- Create filter HTML for client-side filter processing
		local
			l_filters: HASH_TABLE [DOCUMENT_FILTER, STRING]
			l_output_filter: OUTPUT_FILTER
			l_filter_count: INTEGER
			l_toc_name: STRING
			l_toc_url: FILE_NAME
			l_toc_url_string: STRING
			l_util: UTILITY_FUNCTIONS
		do	
			create Result.make_empty
			if is_gui_mode then
				Result.append ("Show documentation for:<br>")
				if shared_project.preferences.generate_dhtml_filter then
					l_filters := shared_project.filter_manager.filters
					Result.append ("<select name=%"filterMenu%" onChange=%"swapTOC (this)%">")
					from
						l_filters.start
					until
						l_filters.after
					loop						
						l_output_filter ?= l_filters.item_for_iteration
						if not l_output_filter.description.is_empty and then generation_data.filter_toc_hash.has (l_output_filter.description) then							
							create l_toc_url.make_from_string ("..")
							l_toc_name := generation_data.filter_toc_hash.item (l_output_filter.description)
							if (create {PLAIN_TEXT_FILE}.make (l_toc_name)).exists then
								create l_util
								l_toc_name := l_util.file_no_extension (l_util.short_name (l_toc_name))
							end
							l_toc_url.extend (l_toc_name)
							l_toc_url.extend ("HTMLLeftContextTemplate.html")
							l_toc_url_string := l_toc_url.string
							l_toc_url_string.replace_substring_all ("\", "/")
							Result.append ("<option value=%"" + l_toc_url_string + "%"")
							Result.append (" name=%"" + filter_option_string (l_output_filter) + "%"")
							Result.append (">")							
							Result.append (l_output_filter.description)
							Result.append ("</option>")
							l_filter_count := l_filter_count + 1
						end
						l_filters.forth
					end
					Result.append ("</select>")
					
					if l_filter_count < 2 then
							-- If there have been less than 2 filters successfully processed there is no
							-- point for filter combo, so just wipe out the Result
						Result.wipe_out
					end				
				end
			else
				Result.append ("Table of Contents")
			end
		ensure
			result_not_void: Result /= Void
		end		

	search_text: STRING is
			-- Search HTML
		do
			create Result.make_empty
			if is_gui_mode then
				Result.append ("%
				%Search%
				%<br>%
				%<input type=%"hidden%" name=%"method%" value=%"and%">%
				%<input type=%"hidden%" name=%"format%" value=%"builtin-long%">%
				%<input type=%"hidden%" name=%"sort%" value=%"score%">%
				%<input type=%"hidden%" name=%"config%" value=%"betadocs_from_betadocs.eiffel.com%">%
				%<input type=%"hidden%" name=%"restrict%" value=%"%">%
				%<input type=%"hidden%" name=%"exclude%" value=%"%">%
				%<input type=%"text%" size=%"30%" name=%"words%" value=%"%">%
				%<input type=%"submit%" name=%"submitForm%" value=%"Go%">"
				)				
			end
		end

	filter_option_string (a_filter: OUTPUT_FILTER): STRING is
			-- Comma separated filter string for filter type
		local
			l_filters: ARRAYED_LIST [STRING]
		do
			from
				create Result.make_empty
				l_filters := a_filter.output_flags
				l_filters.start
			until
				l_filters.after
			loop
				Result.append (l_filters.item)				
				l_filters.forth
				if not l_filters.after then
					Result.append (",")
				end
			end
		end
		
	full_toc_text: STRING is
			-- Full TOC text
		local
			l_formatter: TABLE_OF_CONTENTS_WEB_HELP_FORMATTER
		do
			create Result.make_empty
			create l_formatter.make (toc)
			Result := l_formatter.text
		end

feature {NONE} -- File

	compiled_filename_extension: STRING is
			-- Extension for this project compiled file
		do
			Result := "html"
		end

	project_filename_extension: STRING is
			-- Extension for this project type
		do
			Result := "html"
		end
		
	toc_filename_extension: STRING is
			-- Extension for compiled help file
		do
			Result := "html"
		end

	project_file: PLAIN_TEXT_FILE
			-- Saved project file

	resource_files: ARRAYED_LIST [STRING] is
			-- List of resource file to copy with project
		once
			create Result.make (3)
			Result.extend ("icon_toc_file.gif")
			Result.extend ("icon_toc_file_top.gif")
			Result.extend ("icon_toc_file_bottom.gif")
			Result.extend ("icon_toc_folder_closed.gif")
			Result.extend ("icon_toc_folder_closed_top.gif")
			Result.extend ("icon_toc_folder_open_top.gif")			
			Result.extend ("icon_toc_folder_open.gif")
			Result.extend ("spacer.gif")
			Result.extend ("spacer_line.gif")
			Result.extend ("icon_page_loading.gif")
			Result.extend ("sync_button.gif")
		end

	root_resource_files: ARRAYED_LIST [STRING] is
			-- List of resource file to copy with project
		once	
			create Result.make (6)
			Result.extend ("toc.js")
			Result.extend ("toc.css")
			Result.extend ("header.html")
			Result.extend ("header_mainarea.jpg")
			Result.extend ("header.css")
		end

	copy_root_resource_files is
			-- Copy any resource files needed
		local
			l_util: UTILITY_FUNCTIONS
			l_src_file,
			l_file: RAW_FILE
			l_filename: FILE_NAME
			l_templates_dir: STRING
		do		
			create l_util
			l_templates_dir := shared_constants.application_constants.templates_path
			
			from
				root_resource_files.start
			until
				root_resource_files.after
			loop
				create l_filename.make_from_string (l_templates_dir)
				l_filename.extend (root_resource_files.item)
				create l_file.make (l_filename)						
				
				if l_file.exists then
					create l_filename.make_from_string (shared_constants.application_constants.temporary_help_directory.string)					
					l_filename.extend (root_resource_files.item)
					create l_src_file.make_create_read_write (l_filename.string)
					l_src_file.close
					l_util.copy_file (l_file, l_src_file)
				end
				
				root_resource_files.forth
			end
		end	

end -- class WEB_HELP_PROJECT
