indexing
	description: "Converts a table of contents file to a corresponding HTML Help 1.x table of contents."
	date: "$Date$"
	revision: "$Revision$"

class
	TABLE_OF_CONTENTS_HTML_HELP_FORMATTER
	
inherit
	TABLE_OF_CONTENTS_FORMATTER
		rename
			text as html_help_text
		end	
	
create
	make

feature -- Access

	html_help_text: STRING is
			-- HTML Help 1.x text
		do
			create Result.make_empty
			Result.append (html_help_header)
			Result.append ("<OBJECT type=%"text/site properties%">%N%
				%%T<param name=%"ImageType%" value=%"Folder%">%N</OBJECT><UL>")	
			Result.append (processed_text)
			Result.append (html_help_footer)
		end

feature {NONE} -- Implementation

	node_text (a_node: TABLE_OF_CONTENTS_NODE): STRING is
			-- Node text
		local
			l_url, l_name: STRING
			is_dir_url: BOOLEAN
			l_util: UTILITY_FUNCTIONS
		do
			create l_util
			create Result.make_from_string ("<LI> <OBJECT type=%"text/sitemap%">%N<param name=%"Name%" value=%"")
			
					-- Append Title
			Result.append (a_node.title)
			Result.append ("%">")	
			
					-- Append Url
			l_url := a_node.url
			if l_url /= Void then
				is_dir_url := l_util.file_type (l_url).is_empty	
			end			
			
			if not is_dir_url then
				create l_name.make_from_string (l_util.toc_friendly_url (l_url))
				l_name := l_util.file_no_extension (l_name)
				l_name.append (".html")
				Result.append ("%N<param name=%"Local%" value=%"")
				Result.append (l_name)
				Result.append ("%">")
			end			
			
			Result.append ("%N</OBJECT>%N")
			
			if a_node.has_child then
				Result.append ("<UL>%N")
				from
					a_node.children.start
				until
					a_node.children.after
				loop
					Result.append (node_text (a_node.children.item))
					a_node.children.forth
				end
				Result.append ("</UL>%N")
			end
		end	

end -- class TABLE_OF_CONTENTS_WIDGET_FORMATTER
