indexing
	description: "HTML Generator.  Converts XML into HTML."
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
			src: DIRECTORY
		do
			create src.make (Shared_project.root_directory)
			if should_generate then
				progress_generator.set_title ("HTML Generation")
				progress_generator.set_procedure (agent generate_directory (src, create {DIRECTORY}.make (location)))
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
		local
			l_filename: FILE_NAME
			filtered_document: FILTERED_DOCUMENT
			l_html: STRING
		do				
					-- First filter the document according to correct filter
			filtered_document := Shared_project.filter_manager.filtered_document (a_doc)
				
					-- Now convert the filtered document to HTML
			if filtered_document.text.is_empty then
				l_html := "Error: After filtering the document the content is empty.%N%
					%If this is not what you were expecting check your filter settings%
					%and document filter tags and try again."
			else
				l_html := Shared_project.filter_manager.convert_to_html (filtered_document)	
			end					

			create l_filename.make_from_string (target.name)
			l_filename.extend (file_no_extension (short_name (a_doc.name)))
			l_filename.add_extension ("html")
			create last_generated_file.make_create_read_write (l_filename)
			last_generated_file.put_string (l_html)
			last_generated_file.close
		ensure
			has_last_generated_file: last_generated_file /= Void
		end

feature {NONE} -- Implementation

	generate_directory (a_dir, target: DIRECTORY) is
			-- Take XML from `a_dir' and generate HTML in `target' for files in `files'
		local
			cnt: INTEGER
			sub_dir, src_sub_dir: DIRECTORY
			bin_file, target_bin_file: RAW_FILE
			doc_file: PLAIN_TEXT_FILE
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
			until
				cnt = a_dir.count
			loop
				a_dir.readentry
				if not (a_dir.lastentry.is_equal (".") or a_dir.lastentry.is_equal ("..")) then
							-- Create directory/filename
					create l_filename.make_from_string (path)
					l_filename.extend (a_dir.lastentry)
					create src_sub_dir.make (l_filename)
					progress_generator.set_status_text (l_filename)
					if not src_sub_dir.exists then
						if files.has (l_filename.string) then
									-- This is a file in `files' so convert it to HTML
							l_doc := Shared_document_manager.document_by_name (l_filename.string)
							if l_doc = Void then
								create doc_file.make (l_filename)
								create l_doc.make_from_file (doc_file)								
							end
							if l_doc.can_transform then 
								generate_file (l_doc, target)											
							end
						elseif file_types.has (file_type (l_filename.string)) then
									-- Not XML but does need copying
							create bin_file.make (l_filename)
							create l_filename.make_from_string (target.name)
							l_filename.extend (a_dir.lastentry)
							create target_bin_file.make (l_filename)
							copy_file (bin_file, target_bin_file)
						end		
					else
						create l_filename.make_from_string (target.name)
						l_filename.extend (a_dir.lastentry)						
						if not excluded_directories.has (l_filename.string)  then
							create sub_dir.make (l_filename)
							sub_dir.create_dir
							generate_directory (src_sub_dir, sub_dir)
						end						
					end
				end
				cnt := cnt + 1				
			end
			dir_counter := dir_counter - 1
			a_dir.close
		end

	should_generate: BOOLEAN is
			-- Should generate files
		local			
			l_question_dialog: EV_MESSAGE_DIALOG
		do
			Result := True
--			if Shared_project.has_invalid_files then
--				if Shared_constants.Application_constants.is_gui_mode then
--					create l_question_dialog.make_with_text ((create {MESSAGE_CONSTANTS}).invalid_project_files_warning)
--					l_question_dialog.set_title ((create {MESSAGE_CONSTANTS}).report_title)
--					l_question_dialog.set_buttons (<<"Continue", (create {EV_DIALOG_CONSTANTS}).ev_cancel>>)
--					l_question_dialog.show_modal_to_window (Application_window)
--					if l_question_dialog.selected_button.is_equal ("Continue") then
--						l_question_dialog.destroy
--					else
--						l_question_dialog.destroy
--						Result := False
--					end				
--				end				
--			end
		end

	dir_counter: INTEGER
			-- Directory counter 
		
	file_types: ARRAYED_LIST [STRING] is
			-- List of file types allowed in HTML project
		once
			create Result.make (6)
			Result.compare_objects
			Result.extend ("css")
			Result.extend ("gif")
			Result.extend ("bmp")
			Result.extend ("js")
			Result.extend ("jpg")
			Result.extend ("png")
		end
		
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

end -- class GENERATOR
