indexing
	description: "Manager for documents of all kinds."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_MANAGER

inherit
	SHARED_OBJECTS
	
create
	make

feature -- Initialization

	make is
			-- Create manager
		do
			create documents.make (10)
			documents.compare_objects
			create modified_documents.make (5)
			modified_documents.compare_objects
			new_count := 1
		end
		
	initialize_schema (schema_filename: STRING) is
			-- Initialize `schema' with `a_filename'
		require
			schema_file_not_void: schema_filename /= Void
			schema_is_file: (create {PLAIN_TEXT_FILE}.make (schema_filename)).exists
		local
			error_message: STRING
		do
			create schema.make_from_schema_file (schema_filename)
			if schema.is_valid_xml then
				if not schema.is_valid then
					schema.validator.error_report.show
					set_schema (Void)
				end
			else
				schema.validator.error_report.show
				set_schema (Void)
			end
		end
		
	initialize_xslt (xsl_filename: STRING) is
			-- Initialize `xsl' with `a_filename'
		require
			xsl_file_not_void: xsl_filename /= Void
			xsl_is_file: (create {PLAIN_TEXT_FILE}.make (xsl_filename)).exists
		local
			error_message: STRING
		do
			create xsl.make_from_xsl_file (xsl_filename)
			if xsl.is_valid_xml then
				if not xsl.is_valid_xsl then
					if xsl.load_error_message /= Void then
						error_message := xsl.load_error_message
					else
						error_message := "Unknown error."
					end			
					xsl.validator.error_report.show
					set_xsl (Void)
				end
			else
				xsl.validator.error_report.show
				set_xsl (Void)
			end
		end	
		
feature -- Access

	documents: ARRAYED_LIST [DOCUMENT]
			-- Current editor documents
			
	current_document: DOCUMENT
			-- Current document		
			
	schema: DOCUMENT_SCHEMA
			-- The currently assigned schema
			
	xsl: XSL_TRANSFORM
			-- The currently assigned xsl transform

feature {DOCUMENT_PROPERTIES_DIALOG} -- Access
			
	synchronizer: DOCUMENT_SYNCHRONIZER is
			-- Used to synchronize documents between views
		once
			create Result		
		end		
			
feature -- Element Manipulation

	retrieve_document (a_doc_name: STRING): DOCUMENT is
			-- Retrieve a document from `documents', void otherwise.
		require
			a_doc_not_void: a_doc_name /= Void
		do
			from
				documents.start
			until
				documents.after or Result /= Void
			loop
				if documents.item.name.is_equal (a_doc_name) then
					Result := documents.item
				end
				documents.forth
			end
		end

	add_document (a_doc: DOCUMENT) is
			-- Add a document
		require
			a_doc_not_void: a_doc /= Void
			not_already_open: not is_document_open (a_doc.name)
		do
			documents.extend (a_doc)
		end
	
	remove_document (a_doc: DOCUMENT) is
			-- Remove a document
		require
			a_doc_not_void: a_doc /= Void
			valid_doc: documents.has (a_doc)
		do
			documents.prune_all (a_doc)
		end	

feature -- Commands

	transform_studio_output is
			-- Do a transformation for EiffelStudio documentation
			-- on the currently loaded document
		require
			has_schema: schema /= Void
			has_xsl: xsl /= Void
			has_current_document: current_document /= Void
			current_document_schema_valid: current_document.is_valid_to_schema
		local
			l_text: STRING
		do
			xsl.transform_xml_text (current_document.xml_text, Shared_constants.Application_constants.Studio_filter)
		end
		
	transform_envision_output is
			-- Do a transformation for Eiffel ENViSioN! documentation
			-- on the currently loaded document
		require
			has_schema: schema /= Void
			has_xsl: xsl /= Void
			has_current_document: current_document /= Void
			current_document_schema_valid: current_document.is_valid_to_schema
		do
			xsl.transform_xml_text (current_document.xml_text, Shared_constants.Application_constants.Envision_filter)
		end

feature -- Query

	has_schema: BOOLEAN is
			-- Is a valid schema loaded?
		do
			Result := schema /= Void	
		end	
		
	has_xsl: BOOLEAN is
			-- Is a valid xsl loaded?
		do
			Result := xsl /= Void	
		end	

	is_document_open (a_name: STRING): BOOLEAN is
			-- Is there a document with 'a_name' already open?
		require
			a_name_not_void: a_name /= Void
		do
			from
				documents.start
			until
				documents.after or Result
			loop
				Result := documents.item.name.is_equal (a_name)
				documents.forth
			end
		end		
		
	document_by_name (a_name: STRING): DOCUMENT is
			-- Retrieve document with 'a_name'?
		require
			a_name_not_void: a_name /= Void
			document_open: is_document_open (a_name)
		local
			found: BOOLEAN
		do
			from
				documents.start
			until
				found
			loop
				found := documents.item.name.is_equal (a_name)
				if found then
					Result := documents.item
				end
				documents.forth
			end
		ensure
			has_result: Result /= Void
		end	

	new_name: STRING is
			-- Return a new and unique name for a new Document
		do
			create Result.make_from_string ("Document " + new_count.out)
			new_count := new_count + 1
		ensure
			result_not_void: Result /= Void
		end
		
feature -- Status Setting

	set_current_document (a_doc: DOCUMENT) is
			-- Set `current_document' to 'a_doc'
		require
			a_doc_not_void: a_doc /= Void
		do
			current_document := a_doc
		end		
			
	set_schema (a_schema: DOCUMENT_SCHEMA) is
			-- Set `schema' to 'a_name'
		require
			schema_not_void: a_schema /= Void
		do
			schema := a_schema
		ensure
			schema_set: schema = a_schema
		end			
			
	set_xsl (a_xsl: XSL_TRANSFORM) is
			-- Set `xsl' to 'a_name'
		require
			xsl_not_void: a_xsl /= Void
		do
			xsl := a_xsl
		ensure
			xsl_set: xsl = a_xsl
		end			
		
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

feature {NONE} -- Implementation

	new_count: INTEGER
			-- Rolling counter for creating new documents

	has_modified: BOOLEAN
			-- Has Current any new modifed files?

	modified_documents: ARRAYED_LIST [DOCUMENT]
			-- List of documents which have been modified

invariant
	has_documents: documents /= Void

end -- class DOCUMENT_MANAGER
