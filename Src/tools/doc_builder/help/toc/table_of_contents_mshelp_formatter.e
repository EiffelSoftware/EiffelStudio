indexing
	description: "Converts a table of contents file to a corresponding Microsoft Help 2.0 table of contents."
	date: "$Date$"
	revision: "$Revision$"

class
	TABLE_OF_CONTENTS_MSHELP_FORMATTER
	
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
			create mshelp_text.make_empty			
			Precursor
		end		

feature -- Access

	process_element (e: XM_ELEMENT) is
			-- Process`e'			
		do
			if not e.is_root_node then
				mshelp_text.append ("<HelpTOCNode")
				add_node_item (e)
				Precursor (e)			
				mshelp_text.append ("</HelpTOCNode>%N")
			else
				Precursor (e)
			end
			
		end

	mshelp_text: STRING
			-- HTML Help 1.x text

feature {NONE} -- Status setting

	add_node_item (e: XM_ELEMENT) is
			-- Add new node item based on `e'
		do
			mshelp_text.append (node_text (e))
		end		

feature {NONE} -- Implementation

	node_text (e: XM_ELEMENT): STRING is
			-- HTML text representing `e' for TOC file
		require
			e_not_void: e /= Void
		local
			l_title,
			l_url,
			l_name: STRING
			is_dir_url: BOOLEAN
			l_util: UTILITY_FUNCTIONS
		do
			create Result.make_empty
			l_title := e.attribute_by_name (Title_string).value
			l_url := e.attribute_by_name (Url_string).value
			
			if l_url /= Void and then e.name.is_equal (Folder_string) then
				is_dir_url := (create {UTILITY_FUNCTIONS}).file_type (l_url).is_empty
			end
			
			if not is_dir_url then
				create l_util
				create l_name.make_from_string (l_util.toc_friendly_url (l_url))
				l_name := l_util.file_no_extension (l_name)
				l_name.append (".html")
				Result.append (" Url=%"" + l_name + "%"")
			end
			
			if l_title /= Void then
				Result.append (" Title=%"" + l_title + "%"")
			end
			Result.append (">")
		end			

end -- class TABLE_OF_CONTENTS_MSHELP_FORMATTER
