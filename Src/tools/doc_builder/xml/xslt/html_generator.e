indexing
	description: "HTML Generator.  Converts XML into HTML."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_GENERATOR

inherit
	UTILITY_FUNCTIONS
	
	SHARED_OBJECTS
	
create
	make,
	default_create
	
feature -- Initialization

	make (a_file_list: ARRAYED_LIST [STRING]; a_path: DIRECTORY_NAME) is
			-- Make new generator with a file list and location `a_path'
		require
			a_list_exists: a_file_list /= Void
			a_path_exists: a_path /= Void
		do
			files := a_file_list
			location := a_path
			files.compare_objects
		ensure
			has_files: files /= Void
			has_location: location /= Void
		end		

feature -- Access

	files: ARRAYED_LIST [STRING]
			-- Files to generate

	location: DIRECTORY_NAME
			-- Location to generate files

	last_generated_file: PLAIN_TEXT_FILE
			-- Last generated file

feature -- Generation

	generate is
			-- Transform `files'
		local
			l_src,
			l_target: DIRECTORY
		do
			create l_src.make (Shared_project.root_directory)
			create l_target.make (location)
			if not l_target.exists then
				l_target.create_dir
			end
			l_target.delete_content
			if should_generate then
				progress_generator.set_title ("HTML Generation")
				progress_generator.set_procedure (agent generate_directory (l_src, l_target))
				progress_generator.set_upper_range (files.count)
				progress_generator.set_heading_text ("Generating HTML Files...")
				progress_generator.generate
			end
		end	

	generate_file (a_doc: DOCUMENT; target: DIRECTORY) is
			-- Generate HTML file from `a_doc' in `target'.  Resulting file stored in `last_generated_file'
		require
			document_not_void: a_doc /= Void
			target_not_void: target /= Void	
		do				
			if file_type (a_doc.name).is_equal ("xml") then
				generate_from_xml (a_doc, target)
			elseif file_type (a_doc.name).is_equal ("html") or file_type (a_doc.name).is_equal ("htm") then
				generate_from_html (a_doc, target)
			end
		ensure
			has_last_generated_file: last_generated_file /= Void
		end

feature {NONE} -- Generation

	generate_directory (a_dir, target: DIRECTORY) is
			-- Take XML from `a_dir' and generate HTML in `target' for files in `files'
		local
			cnt, l_cnt: INTEGER
			sub_dir, src_sub_dir: DIRECTORY
			bin_file, target_bin_file: RAW_FILE
			doc_file: PLAIN_TEXT_FILE
			l_file,
			path: STRING
			l_doc: DOCUMENT
			l_filename: FILE_NAME
		do
			path := a_dir.name
			dir_counter := dir_counter + 1
			from
				cnt := 0
				a_dir.open_read
				a_dir.start								
				l_cnt := a_dir.count
			until
				cnt = l_cnt
			loop
				a_dir.readentry
				if not (a_dir.lastentry.is_equal (".") or a_dir.lastentry.is_equal ("..")) then
							-- Create directory/filename
					create l_filename.make_from_string (path)
					l_filename.extend (a_dir.lastentry)
					l_file := l_filename.string
					l_file.replace_substring_all ("\", "/")
					create src_sub_dir.make (l_file)
					progress_generator.set_status_text (l_file)
					if not src_sub_dir.exists then
						if files.has (l_file) then
									-- This is a file in `files' so convert it to HTML
							l_doc := Shared_document_manager.document_by_name (l_file)
							if l_doc = Void then
								create doc_file.make (l_file)
								create l_doc.make_from_file (doc_file)								
							end
							if not is_code_document (l_doc) and l_doc.is_valid_xml (l_doc.text) and l_doc.can_transform then 
								generate_file (l_doc, target)											
							end
						elseif not file_type (l_file).is_equal ("xml") and then shared_constants.application_constants.allowed_file_types.has (file_type (l_file)) then
									-- Not XML but does need copying
							create bin_file.make (l_file)
							create l_filename.make_from_string (target.name)
							l_filename.extend (a_dir.lastentry)
							create target_bin_file.make (l_filename.string)
							copy_file (bin_file, target_bin_file)
						end		
					else
						create l_filename.make_from_string (target.name)
						l_filename.extend (a_dir.lastentry)						
						if not excluded_directories.has (l_filename.string)  then
							create sub_dir.make (l_filename.string)
							if not sub_dir.exists then								
								sub_dir.create_dir	
							end
							l_doc := Void
							bin_file := Void
							target_bin_file := Void
							doc_file := Void
							generate_directory (src_sub_dir, sub_dir)
						end						
					end
				end
				cnt := cnt + 1				
			end
			dir_counter := dir_counter - 1
			a_dir.close
		end

	generate_from_xml (a_doc: DOCUMENT; target: DIRECTORY) is
			-- Generate HTML from XML file
		local
			l_name, l_html: STRING
			l_filename: FILE_NAME
			filtered_document: FILTERED_DOCUMENT
			retried: BOOLEAN
		do				
			if not retried then
						-- First filter the document according to correct filter
				filtered_document := Shared_project.filter_manager.filtered_document (a_doc)
					
						-- Now convert the filtered document to HTML
				if filtered_document.text.is_empty then
					l_html := (create {MESSAGE_CONSTANTS}).empty_html_document
				else
					l_html := Shared_project.filter_manager.convert_to_html (filtered_document)	
				end					
	
						-- Copy generated HTML to a file in `target'
				l_name := target.name
				create l_filename.make_from_string (l_name)
				l_filename.extend (file_no_extension (short_name (a_doc.name)))
				l_filename.add_extension ("html")
				create last_generated_file.make_create_read_write (l_filename.string)
				last_generated_file.put_string (l_html)
				last_generated_file.close
		
					-- Copy image if this is not full project generation		
				if not generation_data.is_generating then				
					copy_images (a_doc)	
				end
			else
				l_html := (create {MESSAGE_CONSTANTS}).empty_html_document
				l_name := target.name
				create l_filename.make_from_string (l_name)
				l_filename.extend (file_no_extension (short_name (a_doc.name)))
				l_filename.add_extension ("html")
				create last_generated_file.make_create_read_write (l_filename.string)
				last_generated_file.put_string (l_html)
				last_generated_file.close
			end
		rescue
			retried := True
			retry
		end

	generate_from_html (a_doc: DOCUMENT; target: DIRECTORY) is
			-- Generate HTML from HTML file
		local
			l_filename: FILE_NAME
		do				
			create l_filename.make_from_string (target.name)
			l_filename.extend (short_name (a_doc.name))
			create last_generated_file.make_create_read_write (l_filename.string)
			last_generated_file.put_string (a_doc.text)
			last_generated_file.close
		end

feature {NONE} -- Implementation

	copy_images (a_doc: DOCUMENT) is
			-- Copy images referenced in `a_doc' so they are still visible from newly generated file.
		local
			l_link: DOCUMENT_LINK
			l_link_manager: LINK_MANAGER
			l_images: ARRAYED_LIST [DOCUMENT_LINK]
			l_image_url: STRING
			l_src, l_target: RAW_FILE
		do
			if a_doc.is_valid_xml (a_doc.text) then				
				create l_link_manager
				l_images := l_link_manager.document_images (a_doc)
				from
					l_images.start
				until
					l_images.after
				loop
					l_link := l_images.item
					l_image_url := l_link.absolute_url	
					create l_src.make (l_image_url)
					if l_src.exists then
							-- Determine absolute url and call `temporary location' to build directory
							-- structure for storage of temporary image file, then copy file
						l_image_url := temporary_html_location (l_image_url, True)						
						create l_target.make (l_image_url)
						copy_file (l_src, l_target)
					end						
					l_images.forth
				end	
			end
		end			

	should_generate: BOOLEAN is
			-- Should generate files
		local			
--			l_question_dialog: EV_MESSAGE_DIALOG
		do
			Result := True
--			if shared_constants.application_constants.is_gui_mode and then Shared_project.has_invalid_files then
--				create l_question_dialog.make_with_text ((create {MESSAGE_CONSTANTS}).invalid_project_files_warning)
--				l_question_dialog.set_title ((create {MESSAGE_CONSTANTS}).report_title)
--				l_question_dialog.set_buttons (<<"Continue", (create {EV_DIALOG_CONSTANTS}).ev_cancel>>)
--				l_question_dialog.show_modal_to_window (Application_window)
--				if l_question_dialog.selected_button.is_equal ("Continue") then
--					l_question_dialog.destroy
--				else
--					l_question_dialog.destroy
--					Result := False
--				end				
--			end
		end

	dir_counter: INTEGER
			-- Directory counter 
		
	excluded_directories: ARRAYED_LIST [STRING] is
			-- Directories to be excluded from generation
		local
			l_exclude: FILE_NAME
		once
			create Result.make (10)
			Result.compare_objects
			create l_exclude.make_from_string (location.string)
			l_exclude.extend ("libraries")
			l_exclude.extend ("base")
			l_exclude.extend ("reference")
			Result.extend (l_exclude.string)
		end		
		
invariant
	has_files: files /= Void
	has_location: location /= Void

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
end -- class GENERATOR
