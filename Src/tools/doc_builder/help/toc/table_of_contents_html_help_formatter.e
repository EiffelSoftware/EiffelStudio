indexing
	description: "Converts a table of contents file to a corresponding HTML Help 1.x table of contents."
	date: "$Date$"
	revision: "$Revision$"

class
	TABLE_OF_CONTENTS_HTML_HELP_FORMATTER
	
inherit
	TABLE_OF_CONTENTS_FORMATTER
		redefine
			make,
			process_element
		end	
	
create
	make

feature -- Creation

	make is
			-- Create
		do
					-- Initialize text
			create html_help_text.make_empty
			html_help_text.append (html_help_header)
			html_help_text.append ("<OBJECT type=%"text/site properties%">%N%
				%%T<param name=%"ImageType%" value=%"Folder%">%N</OBJECT>")
			Precursor			
		end		

feature -- Access

	process_element (e: XM_ELEMENT) is
			-- Process`e'
		local
			l_parent: BOOLEAN
		do
			add_node_item (e)
			l_parent := not e.elements.is_empty
			if l_parent then
				html_help_text.append ("<UL>%N")
			end	
			Precursor (e)
			if l_parent then
				html_help_text.append ("</UL>%N")
			end
			if e.is_root_node then
				html_help_text.append (html_help_footer)
			end
		end

	invalid_urls: ARRAYED_LIST [STRING] is
			-- Invalid url references
		once
			create Result.make (1)
		end	

	html_help_text: STRING
			-- HTML Help 1.x text

feature {NONE} -- Status setting

	add_node_item (e: XM_ELEMENT) is
			-- Add new node item based on `e'
		do	
		 	if not e.is_root_node then
		 		html_help_text.append (node_text (e))	
		 	end				
		end		

feature {NONE} -- Implementation

	node_text (e: XM_ELEMENT): STRING is
			-- HTML text representing `e' for TOC file
		require
			e_not_void: e /= Void
		local
			l_url, l_name: STRING
			is_dir_url: BOOLEAN
			l_util: UTILITY_FUNCTIONS
		do
			create Result.make_from_string ("<LI> <OBJECT type=%"text/sitemap%">%N<param name=%"Name%" value=%"")
			
					-- Append Title
			Result.append (e.attribute_by_name (Title_string).value)
			Result.append ("%">")	
			
					-- Append Url
			l_url := e.attribute_by_name (Url_string).value
			if l_url /= Void and then e.name.is_equal (Folder_string) then
				is_dir_url := (create {UTILITY_FUNCTIONS}).file_type (l_url).is_empty
			end			
			
			if not is_dir_url then
				create l_util
				create l_name.make_from_string (l_util.toc_friendly_url (l_url))
				l_name := l_util.file_no_extension (l_name)
				l_name.append (".html")
				Result.append ("%N<param name=%"Local%" value=%"")
				Result.append (l_name)
				Result.append ("%">")
			end			
			
			Result.append ("%N</OBJECT>%N")
		end	

end -- class TABLE_OF_CONTENTS_WIDGET_FORMATTER
