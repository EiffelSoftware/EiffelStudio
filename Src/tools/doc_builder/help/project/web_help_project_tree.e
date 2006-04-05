indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEB_HELP_PROJECT_TREE

inherit
	WEB_HELP_PROJECT

create
	make

feature -- Access

	full_toc_text: STRING is
			-- Full TOC text
		local
			l_formatter: TABLE_OF_CONTENTS_WEB_HELP_FORMATTER
		do			
			create Result.make_empty
			create l_formatter.make (toc)
			Result := l_formatter.text
		end
		
feature {NONE} -- Implementation

	template_file_name: STRING is
			-- Template file		
		do
			Result := web_help_project_template_file_name
		end

	default_toc_file_name,
	toc_template_file_name: STRING is
			-- Toc template file		
		do
			Result := html_tree_toc_template_file_name
		end
			
	filter_template_file_name: STRING is
			-- Filter template file
		do
			Result := html_filter_template_file_name
		end
		
	resource_files: ARRAYED_LIST [STRING] is
			-- List of resource file to copy with project
		once
			create Result.make (11)	
			Result.extend ("icon_toc_file.gif")
			Result.extend ("icon_toc_file_top.gif")
			Result.extend ("icon_toc_file_bottom.gif")
			Result.extend ("icon_toc_folder_closed.gif")
			Result.extend ("icon_toc_folder_closed_top.gif")
			Result.extend ("icon_toc_folder_open_top.gif")			 
			Result.extend ("icon_toc_folder_open.gif") 
			Result.extend ("spacer.gif")
			Result.extend ("spacer_line.gif")
			Result.extend ("icon_page_loading.gif")
			Result.extend ("sync_button.gif")
		end	
		
	root_resource_files: ARRAYED_LIST [STRING] is
			-- List of root level resource file to copy with project
		once		
			create Result.make (6)
			Result.extend ("toc.css")
			Result.extend ("toc.js")	
			Result.extend ("header.html")
			Result.extend ("header_mainarea.jpg")
			Result.extend ("header.css")	
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
end -- class WEB_HELP_PROJECT_TREE
