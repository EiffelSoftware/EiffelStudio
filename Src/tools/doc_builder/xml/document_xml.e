indexing
	description: "XML document."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_XML

inherit
	XML_ROUTINES
		rename
			is_valid_xml as is_valid_xml_text
		end
	
	UTILITY_FUNCTIONS

create
	make_from_file,
	make_from_filename

feature -- Creation

	make_from_file (a_file: PLAIN_TEXT_FILE) is
			-- Make from existing file
		require
			file_not_void: a_file /= Void
			file_exists: a_file.exists
		do
			file := a_file
			name := a_file.name
			is_persisted := True
		ensure
			has_file: file /= Void
		end

	make_from_filename (a_filename: STRING) is
			-- Make with `a_filename'
		require
			file_not_void: a_filename /= Void
			is_file: (create {PLAIN_TEXT_FILE}.make (a_filename)).exists
		do
			name := a_filename
		ensure
			name_set: name /= Void
		end		

feature -- Access

	file: PLAIN_TEXT_FILE
			-- Associated file
		
	text: STRING is
			-- XML text
		do
			
		end

	name: STRING
			-- Filename

feature -- Query

	is_persisted: BOOLEAN
			-- Is Current persisted to disk?
			
	is_valid_xml: BOOLEAN is
			-- Is Current a valid XML file?
		do
			Result := is_valid_xml_text (text)
		end

feature -- Status Setting

	set_name (a_name: STRING) is
			-- Set `name'
		do
			name := a_name	
		end

invariant
	has_file: file /= Void
	has_name: name /= Void

end -- class DOCUMENT_XML
