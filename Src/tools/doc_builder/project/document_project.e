indexing
	description: "A project."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_PROJECT
	
inherit
	SHARED_OBJECTS
	
	UTILITY_FUNCTIONS
	
	XML_ROUTINES
	
feature -- Initialize

	initialize is
			-- Initialize project from `preferences'
		require
			has_preferences: preferences /= Void
		local
			l_constants: APPLICATION_CONSTANTS
			l_documents: like documents
		do
			if preferences.is_valid then		
				is_valid := True			
				create filter_manager.make
				create invalid_files.make (5)
				invalid_files.compare_objects
				l_constants := Shared_constants.Application_constants
				has_been_validated := False				
				
						-- Initialize tree widget if in gui mode
				if l_constants.is_gui_mode then
					initialize_document_selector
				end
						-- Retrieve documents
				all_documents_read := False
				files_changed := False
				l_documents := documents
			end
			update
		end		

	initialize_document_selector is
			-- Initialize the document selector widget according to
			-- `root_directory' information from `preferences'. Takes also
			-- into account the output filter currently selected.
		do
			if document_map /= Void then
				document_map.clear
			end
			create document_map.make (root_directory, Application_window.document_selector)
		end		

feature -- Access

	name: STRING
			-- Project name

	root_directory: STRING
			-- Location of project root directory

	full_name: FILE_NAME is
			-- Full project name including directory
		do
			create Result.make_from_string (root_directory)
			Result.extend (name)
		end

feature -- Commands

	update is
			-- Update
		do
			Application_window.update
			if Shared_document_manager.has_schema then
				Application_window.render_schema	
			end
		end

	create_new is
			-- Create a new project
		local
			l_file_name: FILE_NAME
			l_file: PLAIN_TEXT_FILE
		do
			Shared_dialogs.project_dialog.show_modal_to_window (Shared_dialogs.template_dialog)			
			create l_file_name.make_from_string (full_name)
			create l_file.make_create_read_write (l_file_name)
			l_file.close
			create preferences.make_from_file (l_file)
			preferences.write
			initialize
		end
		
	open is
			-- Open an existing project
		local
			l_open_dialog: EV_FILE_OPEN_DIALOG
		do		
			create l_open_dialog
			l_open_dialog.show_modal_to_window (Application_window)
			if l_open_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_open) then
				load (l_open_dialog.file_name)
			end		
		end		

	close is
			-- Close open project
		do
			Shared_document_editor.close_documents
		end

	build_toc is
			-- Build a TOC tree from Current			
		do
			if can_build_toc then
				Shared_toc_manager.build_toc (create {DIRECTORY}.make (root_directory))				
			end
		end

	update_links (a_old, a_new: DOCUMENT_LINK) is
			-- Update all document links to `a_old' to link to `a_new'
		require
			old_link_not_void: a_old /= Void
			new_link_not_void: a_new /= void
		local
			l_documents: ARRAYED_LIST [DOCUMENT]
			l_link_manager: LINK_MANAGER
		do
			create l_link_manager.make_with_documents (documents)
			l_link_manager.run (a_old, a_new, False, False)
		end	

feature {VALIDATOR_TOOL_DIALOG} -- Validation

	validate_files is
			-- Validate files in Current to loaded schema.  Put invalid files
			-- in `invalid_files' list.
		do			
			if not has_been_validated then
				has_been_validated := True
				invalid_files.wipe_out
				progress_generator.set_title ("File Validation")
				progress_generator.set_procedure (agent validate_against_schema)
				progress_generator.set_heading_text ("Validating project files...")
				progress_generator.set_upper_range (documents.count)
				progress_generator.generate	
			end
			build_error_report
			show_error_report
		end

	validate_links (a_dir: DIRECTORY) is
			-- Validate links in all files recursively.
		local
			l_link_manager: LINK_MANAGER
		do
			create l_link_manager.make_with_documents (documents)
			l_link_manager.check_links
		end	

feature -- Status Setting	

	set_name (a_name: STRING) is
			-- Set `name'
		require
			name_not_void: a_name /= Void
			name_not_empty: not a_name.is_empty
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

	set_root_directory (a_name: STRING) is
			-- Set `root_directory'
		require
			name_not_void: a_name /= Void
			name_not_empty: not a_name.is_empty
		do
			root_directory := a_name
		ensure
			dir_set: root_directory = a_name
		end

	add_invalid_file (a_filename: STRING) is
			-- Add `a_filename' to list of invalid files
		require
			filename_not_void: a_filename /= Void
			filename_not_empty: not a_filename.is_empty
		do
			if not invalid_files.has (a_filename) then
				invalid_files.extend (a_filename)
			end	
			files_changed := True
		end		

	remove_invalid_file (a_filename: STRING) is
			-- Remove `a_filename' from list of invalid files
		require
			filename_not_void: a_filename /= Void
			filename_not_empty: not a_filename.is_empty
		do
			if invalid_files.has (a_filename) then
				invalid_files.prune_all (a_filename)
			end	
			files_changed := True
		end

	is_valid: BOOLEAN
			-- Is this a valid project?

feature -- Access
			
	filter_manager: FILTER_MANAGER				
			
	preferences: DOCUMENT_PROJECT_FILE
			-- Preferences file

	document_map: DOCUMENT_SELECTOR
			-- Document selector	

	has_invalid_files: BOOLEAN is
			-- Has Current any invalid files
		do
			if not has_been_validated then
				validate_files
			end
			Result := invalid_files.count > 0			
		end		

feature {DOCUMENT_SELECTOR, XML_TABLE_OF_CONTENTS} -- Access 

	allowed_file_types: ARRAYED_LIST [STRING] is
			-- List of allowed file types
		once
			create Result.make (3)
			Result.compare_objects
			Result.extend ("xml")
			Result.extend ("htm")
			Result.extend ("html")
		end	

feature {NONE} -- Implementation
		
	documents: ARRAYED_LIST [DOCUMENT] is
			-- Get all project documents from disk		
		do
			if not all_documents_read then
				progress_generator.set_title ("Retrieving Documents")
				Progress_generator.set_heading_text ("Retrieving file...")
				progress_generator.set_procedure (agent retrieve_documents (create {DIRECTORY}.make (root_directory)))
				progress_generator.suppress_progress_bar (True)
				progress_generator.generate
				progress_generator.suppress_progress_bar (False)
				all_documents_read := True
			end
			Result := Shared_document_manager.documents.linear_representation
		end			
		
	has_been_validated: BOOLEAN
			-- Has Current been validated?
		
	files_changed: BOOLEAN
			-- Have files changed?

	validate_against_schema is
			-- Validate all files according to project schema.
		local
			l_documents: ARRAYED_LIST [DOCUMENT]
			l_document: DOCUMENT
		do		
			from
				l_documents := documents
				l_documents.start
			until
				l_documents.after
			loop
				l_document := l_documents.item
				progress_generator.set_status_text (l_document.name)
				if not l_document.is_valid_to_schema then
					if not invalid_files.has (l_document.name) then
						add_invalid_file (l_document.name)
					end
				end
				l_documents.forth
				progress_generator.update_progress_report
			end
		end	

	build_error_report is
			-- Build a new error report
		local
			l_actions: ERROR_ACTIONS
		do
			if error_report = Void or files_changed then
				if error_report = Void then					
					create error_report.make_empty ((create {MESSAGE_CONSTANTS}).invalid_files_title)
				else
					error_report.clear
				end
				create l_actions
				from
					invalid_files.start				
				until
					invalid_files.after
				loop
					error_report.append_error (invalid_files.item, 0, 0)
					invalid_files.forth
				end
				error_report.set_error_action (agent l_actions.load_file (?))
			end
		ensure
			has_report: error_report /= Void
		end

	show_error_report is
			-- Show report of errors
		require
			has_report: error_report /= Void
		local
			l_message_dialog: EV_MESSAGE_DIALOG
			l_constants: EV_DIALOG_CONSTANTS
		do
			error_report.show
		end

	can_build_toc: BOOLEAN is
			-- Can/should toc be built from Current?
		local
			l_constants: EV_DIALOG_CONSTANTS
			l_question_dialog: EV_MESSAGE_DIALOG
		do
			if Shared_constants.Application_constants.is_gui_mode then
				if Shared_project.has_invalid_files then
					create l_constants
					create l_question_dialog.make_with_text ((create {MESSAGE_CONSTANTS}).invalid_project_files_toc_warning)
					l_question_dialog.set_title (l_constants.ev_warning_dialog_title)
					l_question_dialog.set_buttons (<<"Continue", l_constants.ev_cancel >>)
					l_question_dialog.show_modal_to_window (Application_window)
					if l_question_dialog.selected_button.is_equal ("Continue") then
						l_question_dialog.destroy
						Result := True
					else
						l_question_dialog.destroy
					end
				else
					Result := True
				end
			else
				Result := True
			end			
		end
	
	invalid_files: ARRAYED_LIST [STRING]
			-- List of filenames for known invalid files in Current

	error_report: ERROR_REPORT
			-- Error report

feature {NONE} -- Document Retrieval

	retrieve_documents (a_dir: DIRECTORY) is
			-- Retrieve all documents recusrsively in `a_dir'.
		require
			a_dir_not_void: a_dir /= Void
			a_dir_exists: a_dir.exists
		local
			cnt: INTEGER
			l_dir, l_sub_dir: DIRECTORY
			l_file: PLAIN_TEXT_FILE
			path: STRING
			doc: DOCUMENT
			l_filename: FILE_NAME
		do
			path := a_dir.name
			create l_dir.make (path)
			from
				cnt := 0
				l_dir.open_read
				l_dir.start
			until
				cnt = l_dir.count
			loop
				l_dir.readentry
				if not (l_dir.lastentry.is_equal (".") or l_dir.lastentry.is_equal ("..")) then
					create l_filename.make_from_string (path)
					l_filename.extend (l_dir.lastentry)
					create l_sub_dir.make (l_filename.string)
					if not l_sub_dir.exists then
						create l_file.make (l_filename.string)
						if l_file.exists and then file_type (l_file.name).is_equal ("xml") then
								-- Read documents
							create doc.make_from_file (l_file)
								-- Add to manager
							Shared_document_manager.add_document (doc)							
							progress_generator.set_status_text (doc.name)
						end
					else
							-- Retrieve sub directory documents
						retrieve_documents (l_sub_dir)
					end
				end
				cnt := cnt + 1
				progress_generator.update_progress_report
			end
		end

	all_documents_read: BOOLEAN
			-- Have all project documents been read?

feature {ARGUMENTS_PARSER} -- Retrieval

	load (a_filename: STRING) is
			-- Load from `a_filename'
		local
			l_file: PLAIN_TEXT_FILE
		do
			create l_file.make (a_filename)
			create preferences.make_from_file (l_file)
			preferences.read
			initialize
		end

invariant
	has_preferences: preferences /= Void
	gui_initialized: document_map /= Void

end -- class DOCUMENT_PROJECT
