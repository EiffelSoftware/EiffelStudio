indexing
	description: "Objects that ..."
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
			Result.extend ("toc.js")
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
		
end -- class WEB_HELP_PROJECT_TREE
