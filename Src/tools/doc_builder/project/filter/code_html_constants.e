indexing
	description: "Constants for template files."
	date: "$Date$"
	revision: "$Revision$"

class
	TEMPLATE_CONSTANTS

feature -- HTML

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
		
feature -- XML

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

feature -- Web Help Files
	
	html_tree_toc_template_file_name: STRING is
			-- HTML template file for tree TOC
		local
			l_file_path: FILE_NAME
		once
			create l_file_path.make_from_string ((create {APPLICATION_CONSTANTS}).templates_path)
			l_file_path.extend ("HTMLLeftContextTemplate.html")
			Result := l_file_path.string
		end	

	html_simple_toc_template_file_name: STRING is
			-- HTML template file for simple toc
		local
			l_file_path: FILE_NAME
		once
			create l_file_path.make_from_string ((create {APPLICATION_CONSTANTS}).templates_path)
			l_file_path.extend ("HTMLSimpleTOCTemplate.html")
			Result := l_file_path.string
		end	

	html_filter_template_file_name: STRING is
			-- HTML template file for left side filter code
		local
			l_file_path: FILE_NAME
		once
			create l_file_path.make_from_string ((create {APPLICATION_CONSTANTS}).templates_path)
			l_file_path.extend ("HTMLFilterTemplate.html")
			Result := l_file_path.string
		end	
		
	html_simple_filter_template_file_name: STRING is
			-- HTML template file for left side filter code
		local
			l_file_path: FILE_NAME
		once
			create l_file_path.make_from_string ((create {APPLICATION_CONSTANTS}).templates_path)
			l_file_path.extend ("HTMLSimpleFilterTemplate.html")
			Result := l_file_path.string
		end	
		
	web_help_project_template_file_name: STRING is
			-- HTML template file for web based help project
		local
			l_file_path: FILE_NAME
		once
			create l_file_path.make_from_string ((create {APPLICATION_CONSTANTS}).templates_path)
			l_file_path.extend ("WebHelpTemplateWithHeader.html")
			Result := l_file_path.string
		end	

	html_simple_toc_file_name: STRING is
			-- HTML file for simple toc
		local
			l_file_path: FILE_NAME
		once
			create l_file_path.make_from_string ((create {APPLICATION_CONSTANTS}).templates_path)
			l_file_path.extend ("simple_toc.js.")
			Result := l_file_path.string
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
	
	html_filter_search_token: STRING is "[!FilterSearchHTML!]"
			-- Token to replace with document HTML filter for search form
	
	html_toc_token: STRING is "[!TOCHTML!]"
			-- Token to replace with document HTML toc
			
	html_toc_script_token: STRING is "[!TOCScript!]"
			-- Token for location of toc javascript

	html_toc_style_token: STRING is "[!TOCStyle!]"
			-- Token for location of toc stylesheet
	
	html_default_toc_token: STRING is "[!DefaultTOC!]"
			-- Token to replace default document toc
			
	html_default_filter_token: STRING is "[!DefaultFilter!]"
			-- Token to replace default document filter
	
	html_default_index_token: STRING is "[!DefaultIndex!]"
			-- Token to replace default index document
	
	filter_frame_size_token: STRING is "[!FilterFrameSize!]"
			-- Token to replace filter frame size
	
	html_subtoc_hash_token: STRING is "[!TOCHash!]"
			-- Token to replace with sub-toc hash 
	
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
