indexing
	description: "Manager for documents."
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
				schema.validator.error_report.show
				set_schema (Void)				
			end
		end
		
	set_schema (a_schema: DOCUMENT_SCHEMA) is
			-- Set `schema' to 'a_name'
		do
			schema := a_schema
			application_window.render_schema
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
			add_document (document)
			editor.load_document (document)
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
					load_text_document (a_filename)	
				end
			else
				load_text_document (a_filename)	
			end
		end

	load_text_document (a_filename: STRING) is
			-- Load document as plain text file
		local
			document: DOCUMENT
			file: PLAIN_TEXT_FILE
		do
			if documents.has (a_filename) then
				document := documents.item (a_filename)
			else
				create file.make (a_filename)
				if file /= Void and then file.exists then
					create document.make_from_file (file)
					add_document (document)
				end
			end
			if document /= Void then
				editor.load_document (document)
			end		
		end

	load_image_document (a_filename: STRING) is
			-- Load document as image
		local
			l_container: EV_VERTICAL_BOX
			l_button: EV_BUTTON
			l_pixmap: EV_PIXMAP
		do
			create l_container
			create l_pixmap
			create l_button
			l_button.set_background_color ((create {EV_STOCK_COLORS}).white)
			l_container.extend (l_button)
			l_pixmap.set_with_named_file (a_filename)			
			l_button.set_pixmap (l_pixmap)
			editor.notebook.extend (l_container)
		end

feature {DOCUMENT_PROJECT, XML_TABLE_OF_CONTENTS, DOCUMENT_EDITOR, TABLE_OF_CONTENTS} -- Document Manipulation

	add_document (a_doc: DOCUMENT) is
			-- Add a document
		require
			a_doc_not_void: a_doc /= Void
		do
			if not documents.has (a_doc.name) then
				documents.extend (a_doc, a_doc.name)
			end			
		end

	remove_document (a_doc: DOCUMENT) is
			-- Remove document
		require
			a_doc_not_void: a_doc /= Void
		do
			if documents.has (a_doc.name) then
				documents.remove (a_doc.name)
			end
		end		
	
feature -- Access

	documents: HASH_TABLE [DOCUMENT, STRING]
			-- Loaded documents		
			
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
		do
			if documents.has (a_name) then
				Result := documents.item (a_name)
			end
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

	editor: DOCUMENT_EDITOR is
			-- Editor
		once
			Result := Shared_document_editor
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

end -- class DOCUMENT_MANAGER
