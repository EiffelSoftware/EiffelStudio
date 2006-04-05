indexing
	description: "A project."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			-- Initialize project
		require
			has_preferences: preferences /= Void
		do
			create invalid_files.make (5)
			invalid_files.compare_objects

			if preferences.is_valid then												
				files_changed := False	
				
						-- Copy stylesheet file
				if Shared_document_manager.has_stylesheet then
					copy_stylesheet (Shared_constants.Application_constants.Temporary_html_directory)
				end
				
						-- Perform gui initialization if in GUI mode
				if Shared_constants.Application_constants.is_gui_mode then
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
			create document_map.make (root_directory, application_window.document_selector)
		end	

	reset is
			-- Reset current
		do
			name := Void
			root_directory := Void
			invalid_files := Void
			document_map := Void
			files_changed := False
			if shared_constants.application_constants.is_gui_mode then				
				Application_window.document_selector.wipe_out
			end
			filter_manager.filters.clear_all
			filter_manager.initialize
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

	documents: ARRAYED_LIST [DOCUMENT] is
			-- Get all project documents from disk		
		do
			progress_generator.set_title ("Retrieving Documents")
			Progress_generator.set_heading_text ("Retrieving file...")
			shared_document_manager.documents.clear_all
			progress_generator.set_procedure (agent retrieve_documents (create {DIRECTORY}.make (root_directory)))
			progress_generator.suppress_progress_bar (True)
			progress_generator.generate
			progress_generator.suppress_progress_bar (False)
			Result := Shared_document_manager.documents.linear_representation
		end		

feature -- Commands

	update is
			-- Update
		do
			if Shared_constants.Application_constants.is_gui_mode then
				application_window.update
				application_window.update_output_combo
				if Shared_document_manager.has_schema then
					Application_window.render_schema	
				end
			end						
		end

	create_new is
			-- Create a new project
		do
			Shared_dialogs.project_dialog.show_modal_to_window (Shared_dialogs.template_dialog)
			if Shared_dialogs.project_dialog.valid then
				create file.make_create_read_write (create {FILE_NAME}.make_from_string (full_name))
				file.close
				create preferences.make (Current)
				preferences.write
				initialize
			end
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

	load_documents is
			-- Load all documents under root
		do
			shared_document_manager.documents.clear_all
			retrieve_documents (create {DIRECTORY}.make (root_directory))	
		end		

feature {VALIDATOR_TOOL_DIALOG, TOC_DIALOG} -- Validation

	validate_files_xml is
			-- Validate files in Current to XML.
		do
			invalid_files.wipe_out
			validate_against_xml			
			if not invalid_files.is_empty then
				build_error_report
				shared_error_reporter.show
			end
		end

	validate_files is
			-- Validate files in Current to loaded schema.  Put invalid files
			-- in `invalid_files' list.
		do
			invalid_files.wipe_out		
			validate_against_schema	
			build_error_report
			shared_error_reporter.show
		end

	spell_check is
			-- Spell check all documents in the project
		local
			spell_checker: SPELL_CHECKER
		do			
			create spell_checker
			spell_checker.spell_check_documents (documents)
		end		

feature -- Links

	update_links (a_old, a_new: DOCUMENT_LINK) is
			-- Update all document links to `a_old' to link to `a_new'
		require
			old_link_not_void: a_old /= Void
			new_link_not_void: a_new /= void
		local
			l_link_manager: LINK_MANAGER
		do
			create l_link_manager.make_with_documents (documents)
			l_link_manager.update_links (a_old, a_new)
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

	add_include_document (a_name: STRING) is
			-- Add `a_name' to list of files/directories to exclude
		require
			name_not_void: a_name /= Void
			name_not_empty: not a_name.is_empty
		do
			if not include_documents_list.has (a_name) then
				include_documents_list.extend (a_name)
			end	
		end
	
	include_documents_list: ARRAYED_LIST [STRING] is
			-- List of file and directory names to include in document processing
		once
			create Result.make (1)
			Result.compare_objects	
		end

feature -- Access
			
	filter_manager: FILTER_MANAGER	is
			-- Filter manager
		once
			create Result.make
		end		
			
	preferences: DOCUMENT_PROJECT_PREFERENCES
			-- Preferences file

	document_map: DOCUMENT_SELECTOR
			-- Document selector	

	has_invalid_files: BOOLEAN is
			-- Has Current any invalid files
		do
			validate_files
			Result := invalid_files.count > 0			
		end		

	is_valid: BOOLEAN is
			-- Valid project?
		do
			Result := preferences /= Void and then preferences.is_valid	
		end		

feature {DOCUMENT_PROJECT_PREFERENCES} -- File

	file: PLAIN_TEXT_FILE
			-- Project file	

feature {NONE} -- Implementation								
				
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

	validate_against_xml is
			-- Validate all files for XML validity
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
				if not l_document.is_valid_xml (l_document.text) then
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
			l_error: ERROR
		do
			if shared_error_reporter = Void or files_changed then
				shared_error_reporter.clear				
				from
					invalid_files.start				
				until
					invalid_files.after
				loop
					create l_error.make (invalid_files.item)
					l_error.set_action (agent (shared_error_reporter.actions).load_file_in_editor (invalid_files.item))
					shared_error_reporter.set_error (l_error)
					invalid_files.forth
				end
			end
		ensure
			has_report: shared_error_reporter /= Void
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

feature {NONE} -- Document Retrieval

	retrieve_documents (a_dir: DIRECTORY) is
			-- Retrieve all documents recursively in `a_dir'.  Only include those documents
			-- listed in `include_documents_list'
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
			l_cnt: INTEGER
		do
			path := a_dir.name
			create l_dir.make (path)
			from
				cnt := 0
				l_dir.open_read
				l_dir.start
				l_cnt := l_dir.count				
			until
				cnt = l_cnt
			loop
				l_dir.readentry
				if not (l_dir.lastentry.is_equal (".") or l_dir.lastentry.is_equal ("..")) then
					create l_filename.make_from_string (path)
					l_filename.extend (l_dir.lastentry)
					create l_sub_dir.make (l_filename.string)
					if not l_sub_dir.exists then
						create l_file.make (l_filename.string)
						if l_file.exists and then file_type (l_file.name).is_equal ("xml") then
							if (shared_constants.application_constants.is_include_list and include_documents_list.has (l_file.name)) or
								not shared_constants.application_constants.is_include_list then						
									-- Read documents
								create doc.make_from_file (l_file)
									-- Add to manager
								Shared_document_manager.add_document (doc, False)							
								progress_generator.set_status_text (doc.name)
							end
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

feature {ARGUMENTS_PARSER} -- Retrieval

	load (a_filename: STRING) is
			-- Load from `a_filename'
		do
			reset
			create file.make (a_filename)
			create preferences.make (Current)
			preferences.read
			initialize
--			if shared_constants.application_constants.is_gui_mode and then preferences.is_valid then
--					-- Write back in case there were changes during loading
--				preferences.write	
--			end
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
end -- class DOCUMENT_PROJECT
