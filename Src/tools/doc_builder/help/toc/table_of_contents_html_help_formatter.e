indexing
	description: "Converts a table of contents file to a corresponding HTML Help 1.x table of contents."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			Result.append (icon_type_text)
			Result.append ("<UL>")	
			Result.append (processed_text)
			Result.append (html_help_footer)
		end

feature {NONE} -- Implementation

	node_text (a_node: TABLE_OF_CONTENTS_NODE): STRING is
			-- Node text
		local
			l_url, l_name, l_anchor: STRING
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
				Result.append ("%N<param name=%"Local%" value=%"")	
				if l_url /= Void then					
					create l_name.make_from_string (l_util.toc_friendly_url (l_url))
					if l_name.has ('#') then
							-- Contains anchor
						l_anchor := l_name.substring (l_name.last_index_of ('#', l_name.count), l_name.count)
					end
					l_name := l_util.file_no_extension (l_name)
					l_name.append (".html")
					if l_anchor /= Void then
						l_name.append (l_anchor)
					end
				else
					create l_name.make_empty
				end									
				Result.append (l_name)
				Result.append ("%">")
				if not a_node.has_child then
					Result.append ("%N<param name=%"ImageNumber%" value=%"11%">")
				end	
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
end -- class TABLE_OF_CONTENTS_WIDGET_FORMATTER
