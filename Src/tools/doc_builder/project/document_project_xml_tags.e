indexing
	description: "XML tag constants for a project preferences file"
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_PROJECT_XML_TAGS

feature {DOCUMENT_PROJECT_PREFERENCES} -- Access

	project_tag: STRING is "project"
	
	project_name_tag: STRING is "project_name"

	root_directory_tag: STRING is "root_directory"
			
	schema_file_tag: STRING is "schema"
		
	html_stylesheet_file_tag: STRING is "html_css"

	header_file_tag: STRING is "header_file"
	
	footer_file_tag: STRING is "footer_file"

end -- class DOCUMENT_PROJECT_XML_TAGS
