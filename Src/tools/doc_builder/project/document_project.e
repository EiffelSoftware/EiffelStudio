indexing
	description: "A project."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_PROJECT
	
inherit
	SHARED_OBJECTS
	
	UTILITY_FUNCTIONS

	GENERATOR	
	
feature -- Initialize

	initialize is
			-- Initialize project from `preferences'
		local
			l_constants: APPLICATION_CONSTANTS
		do
			if preferences.is_valid then
				create invalid_files.make (5)
				create modified_files.make (5)
				invalid_files.compare_objects
				l_constants := Shared_constants.Application_constants
				has_been_validated := False
						-- Schema
				if preferences.has_schema then
					Shared_document_manager.initialize_schema (preferences.schema_file)
				end
						-- XSL
				if preferences.has_transform_file then
					Shared_document_manager.initialize_xslt (preferences.transform_file)
							-- CSS
					if Shared_document_manager.has_xsl and then preferences.has_stylesheet_file then
						Shared_document_manager.xsl.set_stylesheet (preferences.stylesheet_file)
					end
				end
						-- Index file
				if preferences.has_index_file_name then
					Shared_constants.Application_constants.set_index_file_name (preferences.index_filename)
				end
				l_constants.set_make_index_root (preferences.is_index_root)
				l_constants.set_include_empty_directories (preferences.include_empty_directories)
				l_constants.set_include_directories_no_index (preferences.include_directories_no_index)
				l_constants.set_include_skipped_sub_directories (preferences.include_skipped_sub_directories)
				if l_constants.is_gui_mode then
					initialize_document_selector
				end
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
			create document_map.make (preferences.root_directory, Application_window.document_selector)
		end		

feature -- Commands

	update is
			-- Update
		do
			Application_window.render_schema
		end

	open_new is
			-- Create a new project from scratch.  Can only be done
			-- via the template dialog.
		do
			create preferences
			Shared_dialogs.project_dialog.show_modal_to_window (Shared_dialogs.template_dialog)
			initialize
		end
		
	open_from_existing_project is
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

	load (a_filename: STRING) is
			-- Load preference from `a_filename'
		do
			create preferences.make_from_file (a_filename)
			initialize
		end

	close is
			-- Close open project
		do
			document_map.clear
			Shared_document_editor.close_documents
		end

	build_toc is
			-- Build a TOC tree from Current
		do
			if can_build_toc then
				create document_toc.make (preferences.root_directory)
				if not document_toc.is_empty then
					Application_window.set_document_toc (document_toc)
				end
			end			
		end		

	validate_links (a_dir: DIRECTORY) is
			-- Validate links in all files recursively.
		local
			l_documents: ARRAYED_LIST [DOCUMENT]
			l_document: DOCUMENT
		do		
			if error_report /= Void then
				error_report.clear
			else
				create error_report.make_empty ("Invalid Links")
			end
			from				
				l_documents := documents (Void)
				l_documents.start
			until
				l_documents.after
			loop				
				l_document := l_documents.item
				l_document.check_links
				if not l_document.invalid_links.is_empty then
					error_report.append_report (l_document.invalid_links) 
				end
				l_documents.forth
			end
			error_report.show
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
			l_documents := documents (Void)
			create l_link_manager.make_with_documents (l_documents)
			l_link_manager.run (a_old, a_new, False, False)
		end		

feature -- Status Setting

	set_toc (a_toc: DOCUMENT_TOC) is
			-- Set `document_toc'
		require
			toc_not_void: a_toc /= Void
		do
			document_toc := a_toc
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

feature -- Access
			
	documents (a_dir: DIRECTORY): ARRAYED_LIST [DOCUMENT] is
			-- Get project xml documents from disk
		local
			cnt: INTEGER
			l_dir, l_sub_dir: DIRECTORY
			l_file: PLAIN_TEXT_FILE
			path: STRING
			doc: DOCUMENT
		do
			if internal_documents = Void then
					-- Since `internal_documents' is Void this is first generation		
				if a_dir = Void then
					path := preferences.root_directory
				else
					path := a_dir.name
				end			
				create l_dir.make (path)
				create Result.make (l_dir.count)
				from
					cnt := 0
					l_dir.open_read
					l_dir.start
				until
					cnt = l_dir.count
				loop
					l_dir.readentry
					if not (l_dir.lastentry.is_equal (".") or l_dir.lastentry.is_equal ("..")) then
						create l_sub_dir.make (path + "\" + l_dir.lastentry)
						if not l_sub_dir.exists then
							create l_file.make (path + "\" + l_dir.lastentry)
							if l_file.exists and then file_type (l_file.name).is_equal ("xml") then
								create doc.make_from_file (l_file, Void)
								Result.extend (doc)
							end
						else
							Result.append (documents (l_sub_dir))
						end
					end
					cnt := cnt + 1
				end	
			else
				Result := internal_documents
			end			
		end		
			
	preferences: DOCUMENT_PROJECT_FILE
			-- Preferences file

	document_map: DOCUMENT_SELECTOR
			-- Document selector	

	document_toc: DOCUMENT_TOC
			-- Document TOC

	validate_files is
			-- Validate files in Current to loaded schema.  Put invalid files
			-- in `invalid_files' list.
		do			
			if has_been_validated then
				build_error_report				
				show_error_report
			else
				generate
			end
		end

	has_invalid_files: BOOLEAN is
			-- Has Current any invalid files
		do
			if not has_been_validated then			
				generate	
			end
			Result := invalid_files.count > 0				
		end		

	file_count: INTEGER is
			-- Number of files in project
		do
			Result := upper_range_value			
		end

feature {DOCUMENT_SELECTOR, DOCUMENT_TOC} -- Access 

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
				l_documents := documents (Void)
				l_documents.start
			until
				l_documents.after
			loop
				l_document := l_documents.item
				if not l_document.is_valid_to_schema then
					if not invalid_files.has (l_document.name) then
						invalid_files.extend (l_document.name)
					end
				end
				l_documents.forth
				update_progress_report
			end
		end

	internal_generate is
			-- Generation
		do
			has_been_validated := True
			invalid_files.wipe_out
			validate_against_schema
			if has_invalid_files then
				build_error_report
				show_error_report
			end
		end		

	build_error_report is
			-- Build a new error report
		local
			l_actions: ERROR_ACTIONS
		do
			if error_report = Void or files_changed then
				if error_report /= Void then
					error_report.clear
				end
				create l_actions
				from
					invalid_files.start				
				until
					invalid_files.after
				loop
					if error_report /= Void then
						error_report.append_error (invalid_files.item, 0, 0)
					else
						create error_report.make ((create {MESSAGE_CONSTANTS}).invalid_files_title, invalid_files.item, 0, 0)
					end
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
			if has_invalid_files then
				error_report.show
			end
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

	modified_files: ARRAYED_LIST [DOCUMENT]
			-- List of files which have been modified since `documents' was first calculated
			
	internal_documents: ARRAYED_LIST [DOCUMENT]
			-- List of documents

	error_report: ERROR_REPORT
			-- Error report

feature {NONE} -- Generation	

	progress_title: STRING is "Validating project files"
			-- Render bar title
	
	Upper_range_value: INTEGER is
			-- Upper value range for progress bar
		once
			Result := directory_recursive_count (create {DIRECTORY}.make (preferences.root_directory), preferences.root_directory)
		end	

invariant
	has_preferences: preferences /= Void
	gui_initialized: document_map /= Void

end -- class DOCUMENT_PROJECT
