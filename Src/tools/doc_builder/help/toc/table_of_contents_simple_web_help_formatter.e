indexing
	description: "Convert a table of contents to a DHTML table of contents.  DHTML is a one-level toc control similar%
		%to that found at http://msdn.microsoft.com."
	date: "$Date$"
	revision: "$Revision$"

class
	TABLE_OF_CONTENTS_SIMPLE_WEB_HELP_FORMATTER

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
		
	children_nodes: INTEGER
			-- Children nodes
		
feature -- Processing

	node_text (a_node: TABLE_OF_CONTENTS_NODE): STRING is
			-- Node text
		local
			l_url,
			l_name,
			l_anchor: STRING
			l_util: UTILITY_FUNCTIONS				
			l_children: ARRAYED_LIST [like a_node]
			l_item: like a_node
		do
			create Result.make_empty
			create l_util
			
				-- Add parent links
			if a_node.has_parent then
				Result.append ("<tr><td>&nbsp;You are in:<br><br></td></tr>")
				Result.append (parent_hierarchy_text (a_node))
				Result.append ("<tr><td>" + spacer_html (number_of_parents (a_node)))
				Result.append ("<a href=%"" + a_node.parent.id.out + ".html" + "%"><img src=%"../folder_open.gif%" align=%"center%"></a>&nbsp;" + a_node.title)			
				Result.append ("<tr><td><br></td></tr>")
				Result.append ("<tr><td>&nbsp;Topics:<br><br></td></tr>")
			end

				-- Child links
			if a_node.has_child then
				l_children := a_node.children
				from
					l_children.start
				until
					l_children.after
				loop
					l_item := l_children.item
					if l_item.url = Void then
						l_url := l_util.unique_name
					else
						l_url := l_util.toc_friendly_url (l_item.url)
					end
					
					if not l_item.url_is_directory then				
						l_name := l_util.toc_friendly_url (l_url)
						if l_name.occurrences ('#') > 0 then
							l_anchor := l_name.substring (l_name.last_index_of ('#', l_name.count), l_name.count)
						end
						l_name := l_util.file_no_extension (l_name)
						l_name.append (".html")				
						if l_anchor /= void then
							l_name.append (l_anchor)
						end
						l_url := l_name
					end
		
					Result.append ("<tr><td><a href=%"../" + l_url + "%" target=%"content_frame%"")
					if l_item.has_child then						
						Result.append (" onClick=%"changeSubTOC('")						
						Result.append (l_item.id.out + ".html")			
						Result.append ("')%"")
					end
					Result.append ("><img src=%"")
					if l_item.has_child then
						Result.append ("../folder.gif")						
					else
						Result.append ("../file.gif")
					end			
					Result.append ("%" align=%"center%"></a>")
					
					Result.append ("<a href=%"../" + l_url + "%" target=%"content_frame%">&nbsp;")			 	
					
					if l_item.title /= Void then
						Result.append (l_item.title)	
					end					
					Result.append ("</a></td></tr>%N")
							
					a_node.children.forth
				end
			end			
		end		

feature {NONE} -- Implementation

	parent_hierarchy_text (a_node: TABLE_OF_CONTENTS_NODE): STRING is
			-- Hierarchy text
		require
			node_has_parent: a_node.has_parent
		local
			l_parent: like a_node
			l_title: STRING			
		do
			create Result.make_empty
			l_parent := a_node.parent
			
				-- Process parents of parent
			if l_parent.has_parent then
				Result.append (parent_hierarchy_text (l_parent))
			end
			
			Result.append ("<tr><td>")
			
				-- Add spacers for tree effect
			Result.append (spacer_html (number_of_parents (l_parent)))
			
				-- Add parent node
			l_title := l_parent.title.twin
			if not l_title.is_equal ("table_of_contents") then
				Result.append ("<a href=%"" + l_parent.id.out + ".html" + "%" align=%"center%"><img src=%"../folder_open.gif%" align=%"center%">&nbsp;</a>" + l_title)
			else
				Result.append ("<a href=%"" + "0.html" + "%" align=%"center%"><img src=%"../folder_open.gif%" align=%"center%">&nbsp;</a>Documentation")
			end			
		end		

	spacer_html (cnt: INTEGER): STRING is
			-- Spacer html
		local
			l_cnt: INTEGER
		do
			create Result.make_empty
			from
				l_cnt := cnt
			until
				l_cnt = 0
			loop				
				Result.append ("<img src=%"../spacer.gif%">")
				l_cnt := l_cnt - 1
			end
		end

	number_of_parents (a_node: TABLE_OF_CONTENTS_NODE): INTEGER is
			-- Number of parents that `a_node' has
		do
			if a_node.has_parent then
				Result := Result + 1
				Result := Result + number_of_parents (a_node.parent)
			end
		end

end -- class TABLE_OF_CONTENTS_SIMPLE_WEB_HELP_FORMATTER
