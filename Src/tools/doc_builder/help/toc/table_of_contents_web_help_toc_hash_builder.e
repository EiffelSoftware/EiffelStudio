indexing
	description: "Build a javascript script for hash of sub-tocs and associated file."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
end -- class TABLE_OF_CONTENTS_WEB_HELP_TOC_HASH_BUILDER
