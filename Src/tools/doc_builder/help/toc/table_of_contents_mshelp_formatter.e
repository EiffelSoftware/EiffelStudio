indexing
	description: "Converts a table of contents file to a corresponding Microsoft Help 2.0 table of contents."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TABLE_OF_CONTENTS_MSHELP_FORMATTER
	
inherit
	TABLE_OF_CONTENTS_FORMATTER
		rename
			text as mshelp_text
		end
	
create
	make

feature -- Access

	mshelp_text: STRING is
			-- HTML Help 1.x text
		do			
			Result := processed_text
		end

feature -- Processing

	node_text (a_node: TABLE_OF_CONTENTS_NODE): STRING is
			-- Node text
		local
			l_title,
			l_url,
			l_name,
			l_anchor: STRING
			l_util: UTILITY_FUNCTIONS
		do
			Result := ("<HelpTOCNode")
			
			l_title := a_node.title
			l_url := a_node.url
			if not a_node.url_is_directory and then l_url /= Void then
				create l_util
				l_name := l_util.toc_friendly_url (l_url)
				if l_name.occurrences ('#') > 0 then
					l_anchor := l_name.substring (l_name.last_index_of ('#', l_name.count), l_name.count)
				end
				l_name := l_util.file_no_extension (l_name)
				l_name.append (".html")				
				if l_anchor /= void then
					l_name.append (l_anchor)
				end
				Result.append (" Url=%"" + l_name + "%"")
			end 

			if l_title /= Void then
				Result.append (" Title=%"" + l_title + "%"")
			end
			
			Result.append (">")
			
			if a_node.has_child then
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
			
			Result.append ("</HelpTOCNode>%N")		
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
end -- class TABLE_OF_CONTENTS_MSHELP_FORMATTER
