indexing
	description: "Document Schema."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_SCHEMA

inherit
	XML_ROUTINES
		rename
			is_valid_xml as is_valid_xml_text
		end

create
	make_from_schema_file
	
feature -- Initialization
	
	make_from_schema_file (a_filename: STRING) is
			-- Make from 'a_filename'
		do
			name := a_filename
		end

feature -- Access

	name: STRING
			-- Name of schema

	validator: SCHEMA_VALIDATOR
			-- Schema validation

feature -- Query	

	is_valid_xml: BOOLEAN is True
			-- Is Current valid xml?

	is_valid: BOOLEAN is True
			-- Is Current valid schema definition according to W3C?
		
	get_element_by_name (el_name: STRING): DOCUMENT_SCHEMA_ELEMENT is
			-- Get a schema element with name `el_name', if exists.
		require
			el_name_not_void: el_name /= Void
		do
		end	

end -- class DOCUMENT_SCHEMA	