indexing
	description: "Constants for template files."
	date: "$Date$"
	revision: "$Revision$"

class
	TEMPLATE_CONSTANTS

feature -- File	Location

	code_template_file_name: STRING is 
			-- Template file for code HTML
		local
			l_file_path: FILE_NAME
		once
			create l_file_path.make_from_string ((create {APPLICATION_CONSTANTS}).templates_path)
			l_file_path.extend ("HTMLCodeTemplate.html")
			Result := l_file_path.string			
		end

	empty_html_template_file_name: STRING is
			-- Empty HTML template file
		local
			l_file_path: FILE_NAME
		once
			create l_file_path.make_from_string ((create {APPLICATION_CONSTANTS}).templates_path)
			l_file_path.extend ("HTMLEmptyTemplate.html")
			Result := l_file_path.string
		end	
		
	left_context_html_template_file_name: STRING is
			-- HTML template file for left side context (TOC)
		local
			l_file_path: FILE_NAME
		once
			create l_file_path.make_from_string ((create {APPLICATION_CONSTANTS}).templates_path)
			l_file_path.extend ("HTMLLeftContextTemplate.html")
			Result := l_file_path.string
		end	

	filter_html_template_file_name: STRING is
			-- HTML template file for left side filter code
		local
			l_file_path: FILE_NAME
		once
			create l_file_path.make_from_string ((create {APPLICATION_CONSTANTS}).templates_path)
			l_file_path.extend ("HTMLFilterTemplate.html")
			Result := l_file_path.string
		end	
		
	web_help_project_template_file_name: STRING is
			-- HTML template file for web based help project
		local
			l_file_path: FILE_NAME
		once
			create l_file_path.make_from_string ((create {APPLICATION_CONSTANTS}).templates_path)
			l_file_path.extend ("WebHelpTemplate.html")
			Result := l_file_path.string
		end	

	header_xml_template_file_name: STRING is
			-- Header XML template file
		local
			l_file_path: FILE_NAME
		once
			create l_file_path.make_from_string ((create {APPLICATION_CONSTANTS}).templates_path)
			l_file_path.extend ("XMLHeaderTemplate.xml")
			Result := l_file_path.string
		end	
		
	footer_xml_template_file_name: STRING is
			-- Footer XML template file
		local
			l_file_path: FILE_NAME
		once
			create l_file_path.make_from_string ((create {APPLICATION_CONSTANTS}).templates_path)
			l_file_path.extend ("XMLFooterTemplate.xml")
			Result := l_file_path.string
		end	

feature -- File Content

	template_text (a_filename: STRING): STRING is
			-- Template text
		local
			l_file: PLAIN_TEXT_FILE
		do
			create l_file.make (a_filename)
			if l_file.exists then
				l_file.open_read
				l_file.read_stream (l_file.count)
				Result := l_file.last_string
				l_file.close
			end
		end

feature -- Access

	html_title_token: STRING is "[!Title!]"
			-- Title tag token
	
	html_content_token: STRING is "[!Content!]"
			-- Content token
	
	html_stylesheet_token: STRING is "[!Stylesheet!]"
			-- Stylesheet token
			
	html_product_token: STRING is "[!Product!]"
			-- Token to indicate output product
	
	html_navigation_token: STRING is "[!Navigation!]"
			-- Token to replace with document navigation
	
	html_filter_token: STRING is "[!FilterHTML!]"
			-- Token to replace with document HTML filter
	
	html_toc_token: STRING is "[!TOCHTML!]"
			-- Token to replace with document HTML toc
	
	html_default_toc: STRING is "[!DefaultTOC!]"
			-- Token to replace default document toc
	
	chart_suffix: STRING is "_chart"
			-- Suffix for code chart view files
		
	contract_suffix: STRING is "_flatshort"
			-- Suffix for code contract view
			
feature -- Query

	replace_token (text, a_token, new_text: STRING) is
			-- Replace `a_token' in `text' with `new_text'
		do
			text.replace_substring_all (a_token, new_text)	
		end		

end -- class CODE_HTML_CONSTANTS
