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
			l_has_child: BOOLEAN
		do
			create l_util
			l_has_child := a_node.has_child
			
			Result := ("<table border=0><tr><td width=10></td><td>")

				-- This is the toggle image
			if a_node.icon /= Void then				
					-- Note: a custom icon assumes exitence of corresponding gif for web display
				l_icon := l_util.file_no_extension (a_node.icon) + ".gif"				
			elseif l_has_child then
				l_icon := "icon_toc_folder_closed.gif"
			else
				l_icon := "icon_toc_file.gif"
			end
			if l_has_child then
				Result.append ("<a onClick=%"Toggle(this)%">")
			end
			Result.append ("<img src=%"" + l_icon + "%"></a>")			

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

end -- class TABLE_OF_CONTENTS_WEB_HELP_FORMATTER
