indexing
	description: "Cpnvert a table of contents to a DHTML table of contents"
	date: "$Date$"
	revision: "$Revision$"

class
	TABLE_OF_CONTENTS_WEB_HELP_FORMATTER

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
			l_title,
			l_url,
			l_name,
			l_anchor,
			l_icon: STRING
			l_util: UTILITY_FUNCTIONS
			l_has_child,
			l_is_last_node,
			l_parent_has_sibling: BOOLEAN
		do
			create l_util
			l_has_child := a_node.has_child
			
			if a_node.has_parent then
				l_is_last_node := a_node.parent.children.index = a_node.parent.children.count								
				if a_node.parent.has_parent then					
					l_parent_has_sibling := a_node.parent.parent.children.index < a_node.parent.parent.children.count									
				end
			end
			
			Result := "<table border=%"0%" cellpadding=%"0%" cellspacing=%"0%"><tr><td "
			if l_parent_has_sibling then
				Result.append ("background=%"spacer_line.gif%"")
				Result.append ("><img src=%"spacer_line.gif%"></td><td>")
			else				
				Result.append ("><img src=%"spacer.gif%"></td><td>")
			end

				-- This is the toggle image
			if a_node.icon /= Void then				
					-- Note: a custom icon assumes existence of corresponding gif for web display
				l_icon := l_util.file_no_extension (a_node.icon) + ".gif"				
			elseif l_has_child then
				if not first_node_processed then					
					l_icon := "icon_toc_folder_closed_top.gif"
					first_node_processed := True					
				else	
					l_icon := "icon_toc_folder_closed.gif"	
				end
			else
				if not first_node_processed then
					l_icon := "icon_toc_file_top.gif"
					first_node_processed := True
				elseif l_is_last_node then
					l_icon := "icon_toc_file_bottom.gif"
				else										
					l_icon := "icon_toc_file.gif"					
				end
			end
			if l_has_child then
				Result.append ("<a onClick=%"toggle(this)%">")
			end
			Result.append ("<img src=%"" + l_icon + "%" align=%"top%">")			
			if l_has_child then
				Result.append ("</a>")
			end

				-- Append title (and link)
			l_url := a_node.url
			if not a_node.url_is_directory and then l_url /= Void then				
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
			
			l_title := a_node.title
			Result.append ("<a target=%"content_frame%"")
			if l_url /=Void then
				Result.append (" href=%"" + l_url + "%"> ")
			else
				Result.append ("> ")
			end
			if l_title /= Void then
				Result.append (l_title)
			end
			Result.append ("</a>")

				-- Process children
			Result.append ("<div>")
			if l_has_child then
				Result.append ("%N")
				from
					a_node.children.start
				until
					a_node.children.after
				loop
					Result.append (node_text (a_node.children.item))
					a_node.children.forth
				end
			end
			
			Result.append ("</div></td></tr></table>")
		end		

feature {NONE} -- Implmentation

	first_node_processed: BOOLEAN
			-- Has the very first tree node been processed?

end -- class TABLE_OF_CONTENTS_WEB_HELP_FORMATTER
