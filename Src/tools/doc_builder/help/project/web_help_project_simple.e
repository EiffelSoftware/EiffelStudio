indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEB_HELP_PROJECT_SIMPLE

inherit
	WEB_HELP_PROJECT
		redefine
			create_toc_frame
		end

create
	make

feature -- Access

	full_toc_text: STRING is
			-- Full TOC text
		do			
		end
		
	create_toc_frame is
			-- Create left side navigation (toc)
		do				
			create formatter.make (toc)
			if toc.has_child then
				create_node_sub_toc (toc)				
			end
		end			
		
	create_node_sub_toc (a_node: TABLE_OF_CONTENTS_NODE) is
			-- Create sub-toc file for `a_node'
		require
			node_not_void: a_node /= Void
			node_has_child: a_node.has_child
		local
			l_text,
			l_url: STRING
			l_filename: FILE_NAME
			l_file: PLAIN_TEXT_FILE
			l_children, 
			l_children_with_parents: ARRAYED_LIST [like a_node]
			l_util: UTILITY_FUNCTIONS
			l_dir: DIRECTORY
		do
			create l_util
			l_children := a_node.children			
			current_toc_index := current_toc_index + 1
			
				-- Process children needing sub toc also
			from				
				l_children.start
				l_children_with_parents := l_children.twin
			until
				l_children.after
			loop				
				if l_children.item.has_child then
					l_children_with_parents.extend (l_children.item)
				end
				l_children.forth
			end
			
				-- Open TOC template and fill with node data
			create l_file.make_open_read_write (toc_template_file_name)
			l_file.readstream (l_file.count)
			l_text := l_file.last_string.twin			
			l_file.close			
			create l_filename.make_from_string (shared_constants.application_constants.temporary_help_directory.string)
			if shared_constants.application_constants.is_gui_mode then				
				if (create {PLAIN_TEXT_FILE}.make (toc.name)).exists then
					l_filename.extend (l_util.file_no_extension (l_util.short_name (toc.name)))
				else						
					l_filename.extend (toc.name)	
				end
				create l_dir.make (l_filename.string)
				if not l_dir.exists then
					l_dir.create_dir
				end
				replace_token (l_text, html_toc_script_token, "../../simple_toc.js")
				replace_token (l_text, html_toc_style_token, "../../toc.css")
			else
				replace_token (l_text, html_toc_script_token, "../simple_toc.js")
				replace_token (l_text, html_toc_style_token, "../toc.css")
			end
			
				-- Create a unique name for the toc for this node
			l_url := unique_toc_name						
			create l_filename.make_from_string (tocs_directory.name)
			l_filename.extend (l_util.file_no_extension (l_url))				
			l_filename.add_extension ("html")			
			create l_file.make_create_read_write (l_filename.string)
			
				-- Write the node information into the sub toc
			formatter.set_children_nodes (l_children_with_parents)
			formatter.set_parent_url (l_url)
			replace_token (l_text, html_toc_token, formatter.node_text (a_node))			
			l_file.put_string (l_text)
			l_file.close
			
				-- Process children
			from				
				l_children_with_parents.start
			until
				l_children_with_parents.after
			loop				
				if l_children_with_parents.item.has_child then
					create_node_sub_toc (l_children_with_parents.item)
				end
				l_children_with_parents.forth
			end
		end		
		
feature {NONE} -- Implementation

	unique_toc_name: STRING is
			-- Uniqe name for toc
		do
			Result := current_toc_index.out	
		end		

	current_toc_index: INTEGER
			-- Number of current sub toc

	formatter: TABLE_OF_CONTENTS_SIMPLE_WEB_HELP_FORMATTER
			-- Formatter

	tocs_directory: DIRECTORY is
			-- Directory to hold mini tocs
		local
			l_filename: FILE_NAME
			l_util: UTILITY_FUNCTIONS
			l_dir: DIRECTORY
		do
			create l_filename.make_from_string (shared_constants.application_constants.temporary_help_directory.string)
			if shared_constants.application_constants.is_gui_mode then				
				if (create {PLAIN_TEXT_FILE}.make (toc.name)).exists then
					l_filename.extend (l_util.file_no_extension (l_util.short_name (toc.name)))
				else						
					l_filename.extend (toc.name)	
				end
				create l_dir.make (l_filename.string)
				if not l_dir.exists then
					l_dir.create_dir
				end
				l_filename.extend ("sub_tocs")
				create Result.make (l_filename.string)
				if not Result.exists then
					Result.create_dir
				end
			end
		end

	template_file_name: STRING is
			-- Template file		
		do
			Result := web_help_project_template_file_name
		end

	toc_template_file_name: STRING is
			-- Toc template file		
		do
			Result := html_simple_toc_template_file_name
		end

	default_toc_file_name: STRING is
			-- Default toc
		do
			Result := tocs_directory.name + "/1.html"
		end
			
	filter_template_file_name: STRING is
			-- Filter template file
		do
			Result := html_simple_filter_template_file_name
		end			
		
	resource_files: ARRAYED_LIST [STRING] is
			-- List of resource file to copy with project
		once
			create Result.make (3)			
			Result.extend ("simple_toc.js")
			Result.extend ("file.gif")
			Result.extend ("folder.gif")	
			Result.extend ("go_up.gif")
			Result.extend ("sync_button.gif")
		end
		
end -- class WEB_HELP_PROJECT_SIMPLE
