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
		
	children_nodes: ARRAYED_LIST [TABLE_OF_CONTENTS_NODE]
			-- Children nodes
		
feature -- Status Setting

	set_parent_url (a_url: STRING) is
			-- Parent url
		require
			url_not_void: a_url /= Void
		do
			parent_url := a_url
		end		

	set_children_nodes (a_children_with_parents: ARRAYED_LIST [TABLE_OF_CONTENTS_NODE]) is
			-- Set children nodes
		require
			list_not_void: a_children_with_parents /= Void
		do
			children_nodes := a_children_with_parents	
		end		

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
			
				-- Add parent link
			if a_node.has_parent then
				Result.append ("<tr><td><a href=%"" + (parent_url.to_integer - 1).out + ".html" + "%"><img src=%"../go_up.gif%" align=%"center%">Up one level</a></td></tr>%N")
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
						if parent_url /= Void then							
							Result.append ((parent_url.to_integer + children_nodes.index).out + ".html")	
						end
						children_nodes.forth
						Result.append ("')%"")	
					end
					Result.append ("><img src=%"")
					if l_item.has_child then
						Result.append ("../folder.gif")						
					else
						Result.append ("../file.gif")
					end			
					Result.append ("%" align=%"center%">&nbsp;")			 	
					
					if l_item.title /= Void then
						Result.append (l_item.title)	
					end					
					Result.append ("</a></td></tr>%N")
							
					a_node.children.forth
				end
			end			
		end		

feature {NONE} -- Implmentation

	parent_url: STRING
			-- Parent url

end -- class TABLE_OF_CONTENTS_SIMPLE_WEB_HELP_FORMATTER
