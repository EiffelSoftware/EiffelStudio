indexing
	description: "Build a javascript script for hash of sub-tocs and associated file."
	date: "$Date$"
	revision: "$Revision$"

class
	TABLE_OF_CONTENTS_WEB_HELP_TOC_HASH_BUILDER

inherit
	TABLE_OF_CONTENTS_FORMATTER

create
	make

feature -- Access

	text: STRING is
			-- DHTML text
		do			
			Result := processed_text
		end

feature -- Processing

	node_text (a_node: TABLE_OF_CONTENTS_NODE): STRING is
			-- Node text.  Each node is made up from a table element.  Any sub nodes are then put 
			-- inside div element in the table, and so on.
		local
			l_url,
			l_id: STRING
			l_util: UTILITY_FUNCTIONS
		do
			create Result.make_empty
			create l_util
			l_url := l_util.toc_friendly_url (l_util.file_no_extension (a_node.url))				
			if a_node.url_is_directory then
				l_url.append ("/index.html")
			else
				l_url.append (".html")					
			end
			if a_node.has_child then
				l_id := a_node.id.out
			else
				l_id := a_node.parent.id.out
			end
			
			Result.append ("tH[tH.length] = {f:%"")
			Result.append (l_url)
			Result.append ("%", s:%"")
			Result.append (l_id + ".html%"};%N")
			
				-- Process children
			if a_node.has_child then			
				from
					a_node.children.start
				until
					a_node.children.after
				loop
					Result.append (node_text (a_node.children.item))
					a_node.children.forth
				end
			end
		end		

end -- class TABLE_OF_CONTENTS_WEB_HELP_TOC_HASH_BUILDER
