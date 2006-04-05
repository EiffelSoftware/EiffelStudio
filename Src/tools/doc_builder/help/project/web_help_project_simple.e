indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEB_HELP_PROJECT_SIMPLE

inherit
	WEB_HELP_PROJECT
		redefine
			create_toc_frame,
			create_filter_frame,
			full_filter_text
		end

create
	make

feature -- Commands

	create_toc_frame is
			-- Create left side navigation (toc)
		do				
			create formatter.make (toc)
			if toc.has_child then							
				create_node_sub_toc (toc)				
			end
		end	

	create_filter_frame is
			-- Create left side navigation (filter)
		local
			l_file,
			l_dest_file: PLAIN_TEXT_FILE			
			l_text: STRING
			l_filename: FILE_NAME
			l_util: UTILITY_FUNCTIONS
			l_dir: DIRECTORY
			l_formatter: TABLE_OF_CONTENTS_WEB_HELP_TOC_HASH_BUILDER
		do				
			create l_formatter.make (toc)			
		
				-- Open TOC template and fill with project toc data
			create l_util
			create l_file.make_open_read_write (filter_template_file_name)
			l_file.readstream (l_file.count)
			l_text := l_file.last_string.twin
			replace_token (l_text, html_subtoc_hash_token, l_formatter.text)
			replace_token (l_text, html_filter_token, full_filter_text)		
			replace_token (l_text, html_filter_search_token, search_text)
			l_file.close
			
				-- Now create toc file based on toc data
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
				replace_token (l_text, html_toc_script_token, "../" + toc_filename)
				replace_token (l_text, html_toc_style_token, "../toc.css")
			else
				replace_token (l_text, html_toc_script_token, toc_filename)
				replace_token (l_text, html_toc_style_token, "toc.css")
			end
			
				-- And write to it and close
			l_filename.extend (l_util.short_name (filter_template_file_name))
			create l_dest_file.make_create_read_write (l_filename.string)
			l_dest_file.put_string (l_text)
			l_dest_file.close
		end

feature -- Access

	full_toc_text: STRING is
			-- Full TOC text
		do			
		end		
		
	full_filter_text: STRING is
			-- Create filter HTML for client-side filter processing
		local
			l_filters: HASH_TABLE [DOCUMENT_FILTER, STRING]
			l_output_filter: OUTPUT_FILTER
			l_filter_count: INTEGER
			l_toc_name: STRING
			l_toc_url: FILE_NAME
			l_toc_url_string: STRING
			l_util: UTILITY_FUNCTIONS
		do	
			create Result.make_empty
			if shared_constants.application_constants.is_gui_mode then
				Result.append ("Show documentation for:<br>")
				if shared_project.preferences.generate_dhtml_filter then
					create l_util
					l_filters := shared_project.filter_manager.filters
					Result.append ("<select name=%"filterMenu%" onChange=%"swapTOC (this)%">")
					from
						l_filters.start
					until
						l_filters.after
					loop						
						l_output_filter ?= l_filters.item_for_iteration
						if not l_output_filter.description.is_empty and then generation_data.filter_toc_hash.has (l_output_filter.description) then							
							create l_toc_url.make_from_string ("..")
							l_toc_name := generation_data.filter_toc_hash.item (l_output_filter.description)
							if (create {PLAIN_TEXT_FILE}.make (l_toc_name)).exists then
								create l_util
								l_toc_name := l_util.file_no_extension (l_util.short_name (l_toc_name))
							end
							l_toc_url.extend (l_toc_name)
							l_toc_url.extend (l_util.short_name (tocs_directory.name))
							l_toc_url.extend (l_util.file_no_extension (default_toc_file_name))
							l_toc_url.add_extension ("html")
							l_toc_url_string := l_toc_url.string
							l_toc_url_string.replace_substring_all ("\", "/")
							Result.append ("<option value=%"" + l_toc_url_string + "%"")
							Result.append (" name=%"" + filter_option_string (l_output_filter) + "%"")
							Result.append (">")							
							Result.append (l_output_filter.description)
							Result.append ("</option>")
							l_filter_count := l_filter_count + 1
						end
						l_filters.forth
					end
					Result.append ("</select>")
					
					if l_filter_count < 2 then
							-- If there have been less than 2 filters successfully processed there is no
							-- point for filter combo, so just wipe out the Result
						Result.wipe_out
					end				
				end
			else
				Result.append ("Table of Contents")
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
			
				-- Process children needing sub toc also
			from				
				l_children.start
				create l_children_with_parents.make (1)
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
				replace_token (l_text, html_toc_script_token, "../../" + toc_filename)
				replace_token (l_text, html_toc_style_token, "../../toc.css")
			else
				replace_token (l_text, html_toc_script_token, "../" + toc_filename)
				replace_token (l_text, html_toc_style_token, "../toc.css")
			end
			
				-- Create a unique name for the toc for this node						
			l_url := a_node.id.out
			create l_filename.make_from_string (tocs_directory.name)
			l_filename.extend (l_util.file_no_extension (l_url))				
			l_filename.add_extension ("html")			
			create l_file.make_create_read_write (l_filename.string)
			
				-- Write the node information into the sub toc									
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
			if generation_data.filter_toc_hash.count > 1 then		
				if (create {PLAIN_TEXT_FILE}.make (toc.name)).exists then
					create l_util
					l_filename.extend (l_util.file_no_extension (l_util.short_name (toc.name)))
				else						
					l_filename.extend (toc.name)	
				end
				create l_dir.make (l_filename.string)
				if not l_dir.exists then
					l_dir.create_dir
				end
			end
			l_filename.extend ("sub_tocs")	
			create l_dir.make (l_filename.string)
			if not l_dir.exists then
				l_dir.create_dir
			end			
			create Result.make (l_filename.string)			
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
			Result := tocs_directory.name + "/0.html"
		end
		
	resource_files: ARRAYED_LIST [STRING] is
			-- List of resource file to copy with project
		once
			create Result.make (3)			
			Result.extend ("file.gif")
			Result.extend ("folder.gif")	
			Result.extend ("folder_open.gif")
			Result.extend ("go_up.gif")
			Result.extend ("sync_button.gif")			
			Result.extend ("spacer.gif")
		end

	root_resource_files: ARRAYED_LIST [STRING] is
			-- List of root level resource file to copy with project
		once		
			create Result.make (6)
			Result.extend ("toc.css")
			Result.extend ("simple_toc.js")
			Result.extend ("simple_toc_single.js")
			Result.extend ("header.html")
			Result.extend ("header_mainarea.jpg")
			Result.extend ("header.css")	
		end
		
	toc_count: INTEGER is
			-- Number of tocs being generated
		do
			Result := generation_data.filter_toc_hash.count
		end		
		
	toc_filename: STRING is
			-- Toc filename
		do
			if toc_count < 2 then
				Result := "simple_toc_single.js"
			else
				Result := "simple_toc.js"
			end
		end		
		
	filter_template_file_name: STRING is
			-- Filter file name
		do
			Result := html_simple_filter_template_file_name
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
end -- class WEB_HELP_PROJECT_SIMPLE
