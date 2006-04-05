indexing
	description: "Manager for documents."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_MANAGER

inherit
	SHARED_OBJECTS
	
create
	make

feature -- Creation

	make is
			-- Create manager
		do
			create documents.make (10)
			documents.compare_objects
			create modified_documents.make (5)
			modified_documents.compare_objects
			counter := 1
			create editor_panels.make (2)
		end

feature -- Schema	
		
	schema: DOCUMENT_SCHEMA
			-- The currently assigned schema	
		
	initialize_schema (schema_filename: STRING) is
			-- Initialize `schema' with `a_filename'
		require
			schema_file_not_void: schema_filename /= Void
			schema_is_file: (create {PLAIN_TEXT_FILE}.make (schema_filename)).exists
		do
			create schema.make_from_schema_file (schema_filename)
			if schema.is_valid then
				set_schema (schema)				
			else
				shared_error_reporter.set_error (create {ERROR}.make (schema_filename + " is invalid."))
				set_schema (Void)				
			end
		end
		
	set_schema (a_schema: DOCUMENT_SCHEMA) is
			-- Set `schema' to 'a_name'
		do
			schema := a_schema
			if shared_constants.application_constants.is_gui_mode then				
				application_window.render_schema	
			end
		ensure
			schema_set: schema = a_schema
		end		
		
	has_schema: BOOLEAN is
			-- Is a valid schema loaded?
		do
			Result := schema /= Void	
		end	
		
	remove_schema is
			-- Remove schema
		do
			schema := Void	
		end		

feature -- HTML Stylesheet

	stylesheet: PLAIN_TEXT_FILE
			-- The currently assigned stylesheet	
		
	has_stylesheet: BOOLEAN is
			-- Is a stylesheet loaded?
		do
			Result := stylesheet /= Void	
		end	
		
	initialize_stylesheet (stylesheet_filename: STRING) is
			-- Initialize `stylesheet' with `a_filename'
		require
			stylesheet_file_not_void: stylesheet_filename /= Void
			stylesheet_is_file: (create {PLAIN_TEXT_FILE}.make (stylesheet_filename)).exists
		do
			create stylesheet.make (stylesheet_filename)
		end	

	remove_stylesheet is
			-- Remove stylesheet
		do
			stylesheet := Void	
		end		
		
feature -- Document Manipulation

	create_document is
			-- Create new document
		local
			document: DOCUMENT
		do
			create document.make_new (new_name)
			add_document (document, True)
		end		

	open_document is
			-- Called by `select_actions' of `open_xml_menu_item'.
		local
			l_open_dialog: EV_FILE_OPEN_DIALOG
		do
			create l_open_dialog
			l_open_dialog.show_modal_to_window (parent_window)
			if l_open_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_open) then
				load_document_from_file (l_open_dialog.file_name)
			end
		end	

	close_document is
			-- 
		local
			l_dlg: EV_QUESTION_DIALOG
			l_doc_name: STRING
		do
			create l_dlg
			l_dlg.set_text ("Would you like to save this document?")
			l_dlg.show_modal_to_window (application_window)
			if l_dlg.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_yes) then
				save_document
			end
			l_doc_name ?= notebook.selected_item.data
			documents.remove (l_doc_name)
			notebook.prune (current_editor.widget)
			editor_panels.remove (l_doc_name)
		end	

	load_document_from_file (a_filename: STRING) is
			-- Load a document with `a_filename'
		require
			filename_not_void: a_filename /= Void
			filename_not_empty: not a_filename.is_empty
		local
			l_util: UTILITY_FUNCTIONS
			l_file_type: STRING
			l_name: STRING
		do
			create l_util
			l_file_type := l_util.file_type (a_filename)
			l_name := a_filename
			l_name.replace_substring_all ("\", "/")
			if shared_constants.application_constants.allowed_file_types.has (l_file_type) then
				l_file_type.to_upper
				if (create {EV_ENVIRONMENT}).supported_image_formats.has (l_file_type) then
					load_image_document (a_filename)
				else				
					load_text_document (l_name)
					on_document_selected
				end
			else
				load_text_document (l_name)
				on_document_selected
			end
		end

	load_text_document (a_filename: STRING) is
			-- Load document as plain text file
		require
			no_forward_slash: not a_filename.has ('\')
		local
			document: DOCUMENT
			file: PLAIN_TEXT_FILE
		do
			if documents.has (a_filename) then
				document := documents.item (a_filename)
				notebook.select_item (editor_panels.item (document.name).widget)
			else
				create file.make (a_filename)
				if file /= Void and then file.exists then
					create document.make_from_file (file)
					add_document (document, True)
					current_editor.load_text (document.text)
				end
			end
		end
		
	load_image_document (a_filename: STRING) is
			-- Load image
		local
		do
			--not implemented
		end

	save_document is
			-- Called by `select_actions' of `save_xml_menu_item'.
		do
			current_document.set_text (current_editor.text)
			current_document.save
		end				
		
	save_all is
			-- Save all opened documents
		do
--			from
--				notebook.start
--			until
--				notebook.after
--			loop
--				if current_document = documents.item_for_iteration  then
--					documents.item_for_iteration.set_text (text)
--				end
--				documents.item_for_iteration.save
--				documents.forth
--			end
		end		

	current_editor: DOCUMENT_EDITOR is
			--
		local
			l_doc_name: STRING
		do
			if has_open_document then
				l_doc_name ?= notebook.selected_item.data
				if l_doc_name /= Void then
					Result := editor_panels.item (l_doc_name)
				end			
			end
		end	

	current_document: DOCUMENT is
			-- Currently open document in notebook
		local
			l_doc_name: STRING
		do
			if has_open_document then
				l_doc_name ?= notebook.selected_item.data
				if l_doc_name /= Void then
					Result := documents.item (l_doc_name)
				end
			end
		end

feature {DOCUMENT_PROJECT, XML_TABLE_OF_CONTENTS, DOCUMENT_EDITOR, TABLE_OF_CONTENTS} -- Document Manipulation

	add_document (a_doc: DOCUMENT; display: BOOLEAN) is
			-- Add a document
		require
			a_doc_not_void: a_doc /= Void
		local
			l_string: STRING
			l_editor: DOCUMENT_EDITOR
		do
			if not documents.has (a_doc.name) then
				l_string := a_doc.name
				l_string.replace_substring_all ("\", "/")
				documents.extend (a_doc, l_string)
			end
			
			if display then
				create l_editor.make
				l_editor.add_cursor_observer (application_window)
				l_editor.add_edition_observer (application_window)
				l_editor.add_selection_observer (application_window)
				editor_panels.extend (l_editor, l_string)
				notebook.extend (l_editor.widget)
				notebook.set_item_text (l_editor.widget, a_doc.short_name (l_string))
				l_editor.widget.set_data (l_string)
				notebook.select_item (l_editor.widget)
				l_editor.load_text (a_doc.text)
			end			
		end

	remove_document (a_doc: DOCUMENT) is
			-- Remove document
		require
			a_doc_not_void: a_doc /= Void
		local
			l_name: STRING
		do
			l_name := a_doc.name.twin
			l_name.replace_substring_all ("\", "/")
			if documents.has (l_name) then
				documents.remove (l_name)
			end
		end		
	
feature -- Access

	notebook: EV_NOTEBOOK is
			-- 
		once
			Result := application_window.editor_notebook
			Result.selection_actions.extend (agent on_document_selected)
		end

	documents: HASH_TABLE [DOCUMENT, STRING]
			-- Loaded documents		
			
	editor_panels: HASH_TABLE [DOCUMENT_EDITOR, STRING]
			-- Loaded document editor panels

	synchronizer: DOCUMENT_SYNCHRONIZER is
			-- Used to synchronize documents between views
		once
			create Result		
		end		

feature -- Query

	hash_code: INTEGER is
			-- Hash code
		do
			Result := counter
			counter := counter + 1
		end
		
	document_by_name (a_name: STRING): DOCUMENT is
			-- Retrieve document with 'a_name', Void otherwise?  
		require
			a_name_not_void: a_name /= Void
		local
			l_name: STRING
		do
			l_name := a_name.twin
			l_name.replace_substring_all ("\", "/")
			if documents.has (l_name) then
				Result := documents.item (l_name)
			end
		end	

	has_open_document: BOOLEAN is
			-- 
		do
			Result := not notebook.is_empty
		end	

feature -- Status Setting	
	
	add_modified_document (a_doc: DOCUMENT) is
			-- Add `a_doc' to list of modifed documents
		require
			doc_not_void : a_doc /= Void
		do
			if not modified_documents.has (a_doc) then
				modified_documents.extend (a_doc)
				has_modified := True
			end
		end

feature -- Events

	on_document_selected is
			-- Document was changed
		do		
			if has_open_document then
				application_window.set_title (current_document.name)
				if current_document /= Void then
					shared_web_browser.set_document (current_document)
				end
			end
		end

feature {NONE} -- Observer Pattern

	update is
			-- Update
		do			
		end		

feature {NONE} -- Implementation

	parent_window: DOC_BUILDER_WINDOW is
			-- Application window
		once
			Result := Application_window
		end		

	counter: INTEGER
			-- Rolling counter for creating new documents

	has_modified: BOOLEAN
			-- Has Current any new modifed files?

	modified_documents: ARRAYED_LIST [DOCUMENT]
			-- List of documents which have been modified
			
	new_name: STRING is
			-- Return a new and unique name for a new document
		do
			create Result.make_from_string ("Document " + counter.out)
			counter := counter + 1
		ensure
			result_not_void: Result /= Void
		end		

invariant
	has_documents: documents /= Void

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
end -- class DOCUMENT_MANAGER
