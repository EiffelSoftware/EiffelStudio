indexing
	description: "HTML Generator.  Converts XML into HTML."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_GENERATOR

inherit
	GENERATOR
	
	UTILITY_FUNCTIONS
	
	SHARED_OBJECTS
	
create
	make
	
feature -- Initialization

	make (a_project: DOCUMENT_PROJECT; a_path: DIRECTORY_NAME) is
			-- Make new generator to generate contents of `a_project' at
			-- location `a_path'
		require
			a_project_exists: a_project /= Void
			a_path_exists: a_path /= Void
		do
			project := a_project
			location := a_path
		ensure
			has_project: project /= Void
			has_location: location /= Void
		end		

feature -- Access 
	
	project: DOCUMENT_PROJECT
			-- Project

	location: DIRECTORY_NAME
			-- Location to generate files

feature -- Generation

	internal_generate is
			-- Transform `project'
		local
			src: DIRECTORY
		do
			create src.make (project.preferences.root_directory)
			Shared_document_manager.xsl.set_stylesheet_relative (True)
			if should_generate then
				generate_directory (src, create {DIRECTORY}.make (location))
			end
			Shared_document_manager.xsl.set_stylesheet_relative (False)
		end	

feature {NONE} -- Implementation

	generate_directory (a_dir, target: DIRECTORY) is
			-- Take XML from `a_dir' and generate HTML in `target'
		local
			cnt: INTEGER
			sub_dir, src_sub_dir: DIRECTORY
			bin_file, target_bin_file: RAW_FILE
			doc_file, target_file: PLAIN_TEXT_FILE
			path: STRING
			doc: DOCUMENT
			l_is_index: BOOLEAN
		do
			path := a_dir.name
			dir_counter := dir_counter + 1
			Shared_document_manager.xsl.set_stylesheet_parents (dir_counter)
			process_index_file (path, target)
			from
				cnt := 0
				a_dir.open_read
				a_dir.start								
			until
				cnt = a_dir.count
			loop
				a_dir.readentry
				if not (a_dir.lastentry.is_equal (".") or a_dir.lastentry.is_equal ("..")) then
					create src_sub_dir.make (path + "\" + a_dir.lastentry)
					if not src_sub_dir.exists then
						create doc_file.make (path + "\" + a_dir.lastentry)
						if file_type (a_dir.lastentry).is_equal ("xml") then
								-- This an XML file
							create doc.make_from_file (doc_file, Shared_document_editor)
							if doc.file.exists and then not (short_name (doc.file.name).is_equal ("index.xml")) then 
								generate_file (doc, target)
							end
						elseif Wizard_data.replicate_source_contents then
								-- Not XML, possibly a binary file to copy
							create bin_file.make (doc_file.name)
							if bin_file /= Void and then bin_file.exists then
								create target_bin_file.make (target.name + "\" + a_dir.lastentry)
							end							
							copy_file (bin_file, target_bin_file)
						end					
					else
						create sub_dir.make (target.name + "\" + a_dir.lastentry)
						sub_dir.create_dir
						generate_directory (src_sub_dir, sub_dir)
					end
				end
				cnt := cnt + 1
				update_progress_report
			end
			dir_counter := dir_counter - 1
			a_dir.close
		end
		
	generate_file (a_doc: DOCUMENT; target: DIRECTORY) is
			-- Generate file
		local
			target_file: PLAIN_TEXT_FILE
		do	
			if a_doc.is_valid_to_schema then
				if a_doc.can_transform then
					Shared_document_manager.xsl.set_stylesheet_parents (dir_counter)
					Shared_document_manager.xsl.transform_file_text (a_doc.file, Shared_constants.Application_constants.output_filter)
					create target_file.make_create_read_write 
						(target.name + "\" + file_no_extension (short_name (a_doc.file.name) ) + ".html")
					target_file.putstring (Shared_document_manager.xsl.transformed_text)
					target_file.close
				end
			else
				project.add_invalid_file (a_doc.name)
			end	
		end
		
	process_index_file (a_loc: STRING; target: DIRECTORY) is
			-- Process the directory index file in the directory at `a_loc' and
			-- generate in `target'.
		require
			a_loc_not_void: a_loc /= Void
			a_loc_not_empty: not a_loc.is_empty
			a_loc_is_directory: (create {DIRECTORY}.make (a_loc)).exists
		local
			cnt: INTEGER
			doc_file: PLAIN_TEXT_FILE
			doc: DOCUMENT
			l_dir: DIRECTORY
			l_filename: STRING
		do
			create l_dir.make_open_read (a_loc)
			if l_dir.has_entry ("index.xml") then
				create l_filename.make_empty
				from
					cnt := 0
					l_dir.start				
				until
					l_filename.is_equal ("index.xml")
				loop
					l_dir.readentry
					l_filename := l_dir.lastentry
					cnt := cnt + 1
				end
				create doc_file.make (a_loc + "\" + l_dir.lastentry)
				create doc.make_from_file (doc_file, Shared_document_editor)
				if doc.file.exists then 
					generate_file (doc, target)
				end
			end
			l_dir.close
		end		

feature {NONE} -- Implementation

	should_generate: BOOLEAN is
			-- Should generate files
		local			
			l_question_dialog: EV_MESSAGE_DIALOG
		do
			Result := True
			if project.has_invalid_files then
				if Shared_constants.Application_constants.is_gui_mode then
					create l_question_dialog.make_with_text ((create {MESSAGE_CONSTANTS}).invalid_project_files_warning)
					l_question_dialog.set_title ((create {MESSAGE_CONSTANTS}).report_title)
					l_question_dialog.set_buttons (<<"Continue", (create {EV_DIALOG_CONSTANTS}).ev_cancel>>)
					l_question_dialog.show_modal_to_window (Application_window)
					if l_question_dialog.selected_button.is_equal ("Continue") then
						l_question_dialog.destroy
					else
						l_question_dialog.destroy
						Result := False
					end				
				end				
			end
		end

	is_root_directory (a_loc: STRING): BOOLEAN is
			-- Is `a_loc' the root directory?
		do
			Result := a_loc.is_equal (project.preferences.root_directory)
		end		
		
	progress_title: STRING is "Generating HTML..."
			-- Progress report title
		
	Upper_range_value: INTEGER is
			-- Upper value range for progress bar
		local
			dir: DIRECTORY
		once
			create dir.make (project.preferences.root_directory)
			Result := directory_recursive_count (dir, dir.name)
		end
	
	dir_counter: INTEGER
			-- Directory counter 
		
invariant
	has_project: project /= Void
	has_location: location /= Void

end -- class GENERATOR
