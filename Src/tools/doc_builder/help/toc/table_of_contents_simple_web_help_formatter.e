indexing
	description: "Convert a table of contents to a DHTML table of contents.  DHTML is a one-level toc control similar%
		%to that found at http://msdn.microsoft.com."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			l_url: STRING					
			l_children: ARRAYED_LIST [like a_node]
			l_item: like a_node
		do
			create Result.make_empty
			
			l_url := friendly_node_url (a_node)
			l_url.prepend ("../")
			
				-- Add parent links
			Result.append ("<tr><td>&nbsp;You are in:<br><br></td></tr>")
			Result.append (parent_hierarchy_text (a_node))						
			Result.append ("<tr><td>" + spacer_html (number_of_parents (a_node)))
			if a_node.title.is_equal ("table_of_contents") then
				Result.append ("<a href=%"" + a_node.id.out + ".html" + "%"><img src=%"../folder_open.gif%" align=%"center%"></a>&nbsp;<a href=%"" + l_url + "%" target=%"content_frame%">Documentation</a>")			
			else
				Result.append ("<a href=%"" + a_node.id.out + ".html" + "%"><img src=%"../folder_open.gif%" align=%"center%"></a>&nbsp;<a href=%"" + l_url + "%" target=%"content_frame%">" + a_node.title + "</a>")			
			end
			Result.append ("<tr><td><br></td></tr>")
			Result.append ("<tr><td>&nbsp;Topics:<br><br></td></tr>")

				-- Child links
			if a_node.has_child then
				l_children := a_node.children
				from
					l_children.start
				until
					l_children.after
				loop
					l_item := l_children.item
					l_url := friendly_node_url (l_item)
		
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
		local
			l_parent: like a_node
			l_title,
			l_url: STRING
		do
			create Result.make_empty
			l_parent := a_node.parent
			
				-- Process parents of parent
			if l_parent /= Void and then l_parent.has_parent then
				Result.append (parent_hierarchy_text (l_parent))
			end
			
			Result.append ("<tr><td>")
			
				-- Add spacers for tree effect
			Result.append (spacer_html (number_of_parents (l_parent)))

			if l_parent /= Void then
				l_url := friendly_node_url (l_parent)				
			end
			if l_url /= Void then
				l_url.prepend ("../")
			
					-- Add parent node
				if l_parent /= Void then
					l_title := l_parent.title.twin					
				end
				if l_title /= Void and then not l_title.is_equal ("table_of_contents") then
					Result.append ("<a href=%"" + l_parent.id.out + ".html" + "%" align=%"center%"><img src=%"../folder_open.gif%" align=%"center%">&nbsp;</a><a href=%"" + l_url + "%" target=%"content_frame%">" + l_title + "</a>")
				else
					Result.append ("<a href=%"" + "0.html" + "%" align=%"center%"><img src=%"../folder_open.gif%" align=%"center%">&nbsp;</a><a href=%"" + l_url + "%" target=%"content_frame%">Documentation Home</a>")
				end			
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
			if a_node /= Void and then a_node.has_parent then
				Result := Result + 1
				Result := Result + number_of_parents (a_node.parent)
			end
		end
		
	friendly_node_url (a_node: TABLE_OF_CONTENTS_NODE): STRING is
			-- Friendly node url for toc
		local
			l_url,
			l_name,
			l_anchor: STRING
			l_util: UTILITY_FUNCTIONS
		do
			create l_util
			create Result.make_empty
			
			if a_node.url = Void then
				l_url := "index"
			else
				l_url := l_util.toc_friendly_url (a_node.url)
			end
			
			if not a_node.url_is_directory then				
				l_name := l_util.toc_friendly_url (l_url)
				if l_name.occurrences ('#') > 0 then
					l_anchor := l_name.substring (l_name.last_index_of ('#', l_name.count), l_name.count)
				end
				l_name := l_util.file_no_extension (l_name)
				l_name.append (".html")				
				if l_anchor /= void then
					l_name.append (l_anchor)
				end
				Result := l_name
			end	
		ensure
			Result_not_void: Result /= Void
		end	

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class TABLE_OF_CONTENTS_SIMPLE_WEB_HELP_FORMATTER
