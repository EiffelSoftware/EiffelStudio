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
	
feature -- Query

	is_contract: BOOLEAN is False
			-- Short format?
	
	is_interface: BOOLEAN is True
			-- Flat format

	replace_token (text, a_token, new_text: STRING) is
			-- Replace `a_token' in `text' with `new_text'
		do
			text.replace_substring_all (a_token, new_text)	
		end		

end -- class CODE_HTML_CONSTANTS
