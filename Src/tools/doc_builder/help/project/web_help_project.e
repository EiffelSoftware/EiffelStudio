indexing
	description: "Help project for Web content."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEB_HELP_PROJECT

inherit
	HELP_PROJECT

	TEMPLATE_CONSTANTS
	
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

feature -- Access

	template_file_name: STRING is
			-- Template file		
		deferred
		end

	toc_template_file_name: STRING is
			-- Toc template file
		
		deferred
		end
			
	filter_template_file_name: STRING is
			-- Filter template file
		deferred
		end
		
	default_toc_file_name: STRING is
			-- Default toc
		deferred
		end
		
feature {NONE} -- File

	create_project_file is
			-- Create the project file
		local
			l_file: PLAIN_TEXT_FILE
			l_filename,
			l_sub_toc_filename: FILE_NAME
			l_text,
			l_text_no_index: STRING
			l_util: UTILITY_FUNCTIONS
		do
			create l_util
			create l_file.make_open_read (template_file_name)
			l_file.read_stream (l_file.count)
			l_text := l_file.last_string.twin
			if shared_constants.application_constants.is_gui_mode then
				if (create {PLAIN_TEXT_FILE}.make (toc.name)).exists then
					create l_filename.make_from_string (l_util.file_no_extension (l_util.short_name (toc.name)) + "/")
				else
					create l_filename.make_from_string (toc.name + "/")
				end
				replace_token (l_text, filter_frame_size_token, filter_frame_height.out)
			else
				create l_filename.make_from_string ("")
				replace_token (l_text, filter_frame_size_token, filter_frame_height.out)
			end
			if shared_constants.help_constants.is_web_help and not shared_constants.help_constants.is_tree_web_help then
				create l_sub_toc_filename.make_from_string ("sub_tocs/")
			end
			replace_token (l_text, html_default_toc_token, l_sub_toc_filename.string + l_util.short_name (default_toc_file_name))
			replace_token (l_text, html_default_filter_token, l_filename.string + l_util.short_name (filter_template_file_name))
			l_text_no_index := l_text.twin
			replace_token (l_text, html_default_index_token, l_filename.string + "index.html")
			replace_token (l_text_no_index, html_default_index_token, "")
			l_file.close
			
				-- Create the main project file
			create l_filename.make_from_string (shared_constants.application_constants.temporary_help_directory)
			l_filename.extend (name)
			l_filename.add_extension (project_filename_extension)
			create project_file.make_create_read_write (l_filename.string)
			project_file.put_string (l_text)
			project_file.close
			
				-- Create the main project file which has no index file
			create l_filename.make_from_string (shared_constants.application_constants.temporary_help_directory)
			l_filename.extend (name + "_no_content")
			l_filename.add_extension (project_filename_extension)
			create project_file.make_create_read_write (l_filename.string)
			project_file.put_string (l_text_no_index)
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
			create l_file.make_open_read_write (toc_template_file_name)
			l_file.readstream (l_file.count)
			l_text := l_file.last_string.twin
			replace_token (l_text, html_toc_token, full_toc_text)
			l_file.close
			
				-- Now create toc file based on toc data
			create l_filename.make_from_string (shared_constants.application_constants.temporary_help_directory.string)
			if shared_constants.application_constants.is_gui_mode then
				if (create {PLAIN_TEXT_FILE}.make (toc.name)).exists then
					l_filename.extend (l_util.file_no_extension (l_util.short_name (toc.name)))
				else						
					l_filename.extend (toc.name)	
				end
				create l_dir.make (l_filename.string)
				if not l_dir.exists then
					l_dir.create_dir
				end
				replace_token (l_text, html_toc_script_token, "../toc.js")
				replace_token (l_text, html_toc_style_token, "../toc.css")
			else
				replace_token (l_text, html_toc_script_token, "toc.js")
				replace_token (l_text, html_toc_style_token, "toc.css")
			end
			
				-- And write to it and close			
			l_filename.extend (l_util.short_name (toc_template_file_name))
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
			create l_file.make_open_read_write (filter_template_file_name)
			l_file.readstream (l_file.count)
			l_text := l_file.last_string.twin
			replace_token (l_text, html_filter_token, full_filter_text)		
			replace_token (l_text, html_filter_search_token, search_text)	
			l_file.close
			
				-- Now create toc file based on toc data
			create l_filename.make_from_string (shared_constants.application_constants.temporary_help_directory.string)
			if shared_constants.application_constants.is_gui_mode then
				if (create {PLAIN_TEXT_FILE}.make (toc.name)).exists then
					l_filename.extend (l_util.file_no_extension (l_util.short_name (toc.name)))
				else						
					l_filename.extend (toc.name)	
				end
				create l_dir.make (l_filename.string)
				if not l_dir.exists then
					l_dir.create_dir
				end
				replace_token (l_text, html_toc_script_token, "../toc.js")
				replace_token (l_text, html_toc_style_token, "../toc.css")
			else
				replace_token (l_text, html_toc_script_token, "toc.js")
				replace_token (l_text, html_toc_style_token, "toc.css")
			end
			
				-- And write to it and close
			l_filename.extend (l_util.short_name (filter_template_file_name))
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
					if shared_constants.application_constants.is_gui_mode then
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
			if shared_constants.application_constants.is_gui_mode then
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
							l_toc_url.extend (l_util.short_name (toc_template_file_name))
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
			if shared_constants.application_constants.is_gui_mode then
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
		deferred
		end

	filter_frame_height: INTEGER is
			-- Height to set filter frame		
		do
			Result := 50
			if not search_text.is_empty then
				Result := Result + 60
			end
			if not full_filter_text.is_empty then
				Result := Result + 50
			end
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
		deferred			
		end

	root_resource_files: ARRAYED_LIST [STRING] is
			-- List of resource file to copy with project
		deferred				
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
end -- class WEB_HELP_PROJECT
