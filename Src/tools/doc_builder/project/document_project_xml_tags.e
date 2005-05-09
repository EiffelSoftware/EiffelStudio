indexing
	description: "XML tag constants for a project preferences file"
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
	
	toc_folder_tag: STRING is "folder"

end -- class DOCUMENT_PROJECT_XML_TAGS
