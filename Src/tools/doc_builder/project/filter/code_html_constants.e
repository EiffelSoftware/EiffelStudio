indexing
	description: "Code HTML generation constants."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_HTML_CONSTANTS

feature -- File

	template_file_name: STRING is 
			-- Template file
		local
			l_file_path: FILE_NAME
		do
			create l_file_path.make_from_string ((create {APPLICATION_CONSTANTS}).templates_path)
			l_file_path.extend ("HTMLTemplate.txt")
			Result := l_file_path.string			
		end

	template_text: STRING is
			-- Template text
		local
			l_file: PLAIN_TEXT_FILE
		once
			create l_file.make (template_file_name)
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
	
feature -- Query

	replace_token (text, a_token, new_text: STRING) is
			-- Replace `a_token' in `text' with `new_text'
		do
			text.replace_substring_all (a_token, new_text)	
		end	
		
	chart_suffix: STRING is "_chart"
			-- Suffix for code chart view files
		
	contract_suffix: STRING is "_flatshort"
			-- Suffix for code contract view

end -- class CODE_HTML_CONSTANTS
