indexing
	description: "Help project for Web content."
	date: "$Date$"
	revision: "$Revision$"

class
	WEB_HELP_PROJECT

inherit
	HELP_PROJECT

	TEMPLATE_CONSTANTS

create
	make
	
feature -- Commands

	build_table_of_contents is
			-- Build table of contents and write to file
		do						
			create_toc
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
		do
			create l_file.make_open_read (web_help_project_template_file_name)
			l_file.read_stream (l_file.count)
			l_text := l_file.last_string.twin
			replace_token (l_text, html_default_toc, toc.name)
			l_file.close
			create l_filename.make_from_string (shared_constants.application_constants.temporary_help_directory)
			l_filename.extend (name)
			l_filename.add_extension (project_filename_extension)
			create project_file.make_create_read_write (l_filename.string)
			project_file.put_string (l_text)
			project_file.close
		end

feature {NONE} -- Implementation	

	create_toc is
			-- Create left side navigation (toc, filter, etc)
		local
			l_file,
			l_dest_file: PLAIN_TEXT_FILE			
			l_text: STRING
			l_filename: FILE_NAME
			l_util: UTILITY_FUNCTIONS
			l_dir: DIRECTORY
		do				
			create l_util
			create l_file.make_open_read_write (left_context_html_template_file_name.string)
			l_file.readstream (l_file.count)
			l_text := l_file.last_string.twin
			replace_token (l_text, html_toc_token, full_toc_text)
			replace_token (l_text, html_filter_token, full_filter_text)
			l_file.close
			create l_filename.make_from_string (shared_constants.application_constants.temporary_help_directory.string)
			l_filename.extend (toc.name)
			create l_dir.make (l_filename.string)
			if not l_dir.exists then
				l_dir.create_dir
			end
			l_dir.delete_content
			l_filename.extend (l_util.short_name (left_context_html_template_file_name.string))
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
			l_icon_dir: STRING
		do			
			create l_util
			l_icon_dir := shared_constants.application_constants.icon_resources_directory
			
			from
				resource_files.start
			until
				resource_files.after
			loop
				create l_filename.make_from_string (l_icon_dir)
				l_filename.extend (resource_files.item)	
				create l_file.make (l_filename)				
				if l_file.exists then
					create l_filename.make_from_string (shared_constants.application_constants.temporary_help_directory.string)
					l_filename.extend (toc.name)
					l_filename.extend (resource_files.item)
					create l_src_file.make_create_read_write (l_filename.string)
					l_src_file.close
					l_util.copy_file (l_file, l_src_file)
				end				
				resource_files.forth
			end
		end		

	full_filter_text: STRING is
			-- Create filter HTML for client-side filter processing
		local
			l_filters: HASH_TABLE [DOCUMENT_FILTER, STRING]
			l_output_filter: OUTPUT_FILTER
			l_show: BOOLEAN
			l_filter_count: INTEGER
			l_toc_name: STRING
			l_toc_url: FILE_NAME
		do	
			create Result.make_empty
			if shared_project.preferences.generate_dhtml_filter then
				l_filters := shared_project.filter_manager.filters
				Result.append ("<select name=%"filterMenu%" onChange=%"swapTOC (this.selectedIndex, this.form)%">")
				from
					l_filters.start
				until
					l_filters.after
				loop						
					l_output_filter ?= l_filters.item_for_iteration
					if not l_output_filter.description.is_empty and then generation_data.filter_toc_hash.has (l_output_filter.description) then							
						create l_toc_url.make_from_string ("..")
						l_toc_name := generation_data.filter_toc_hash.item (l_output_filter.description)
						l_toc_url.extend (l_toc_name)
						l_toc_url.extend ("HTMLLeftContextTemplate.html")
						Result.append ("<option value=%"" + l_toc_url + "%"")
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
		ensure
			result_not_void: Result /= Void
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
			Result.extend ("icon_toc_folder_closed.gif")
			Result.extend ("icon_toc_folder_open.gif")
		end

end -- class WEB_HELP_PROJECT
