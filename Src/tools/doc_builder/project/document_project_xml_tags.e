indexing
	description: "XML tag constants for a project preferences file"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_PROJECT_XML_TAGS

feature {DOCUMENT_PROJECT_PREFERENCES} -- Access

	project_tag: STRING is "project"
	
	project_name_tag: STRING is "project_name"

	root_directory_tag: STRING is "root_directory"
			
	schema_file_tag: STRING is "schema"
		
	html_stylesheet_file_tag: STRING is "html_css"

	header_file_tag: STRING is "header_file"

	header_file_override_tag: STRING is "header_override"
	
	use_header_file_tag: STRING is "use_header_from_file"
	
	footer_file_tag: STRING is "footer_file"
	
	footer_file_override_tag: STRING is "footer_override"

	use_footer_file_tag: STRING is "use_footer_from_file"

	process_includes_tag: STRING is "process_includes"
	
	process_header_tag: STRING is "process_header"
	
	process_footer_tag: STRING is "process_footer"
	
	process_html_stylesheet_tag: STRING is "process_html_stylesheet"
	
	include_navigation_links_tag: STRING is "include_navigation_links"
	
	generate_dhtml_filter_tag: STRING is "generate_dhtml_filter"
	
	generate_feature_nodes_tag: STRING is "generate_feature_nodes"
	
	output_filter_tag: STRING is "filter"
	
	output_filter_description_tag: STRING is "filter_description"
	
	output_filter_primary_flag_tag: STRING is "filter_primary_flag"
	
	output_filter_highlight_red_tag: STRING is "filter_highlight_color_red"
	
	output_filter_highlight_green_tag: STRING is "filter_highlight_color_green"
	
	output_filter_highlight_blue_tag: STRING is "filter_highlight_color_blue"
	
	output_filter_highlight_enabled_tag: STRING is "filter_highlight_on"
	
	output_filter_tag_tag: STRING is "tag"
	
	shortcut_tag: STRING is "shortcut"
	
	shortcut_key_tag: STRING is "shortcut_key"
	
	shortcut_value_tag: STRING is "shortcut_value"
	
	toc_folder_tag: STRING is "folder";

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
end -- class DOCUMENT_PROJECT_XML_TAGS
