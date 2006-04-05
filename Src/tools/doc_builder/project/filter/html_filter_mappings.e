indexing
	description: "Mappings for Schema -> HTML filtering."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_FILTER_MAPPINGS

feature {HTML_FILTER} -- Access

	element_element_mappings: HASH_TABLE [STRING, STRING] is
			-- Element to element mappings
		once
			create Result.make (15)
			Result.compare_objects			
			Result.extend ("table", "table")
			Result.extend ("tr", "row")
			Result.extend ("td", "cell")
			Result.extend ("li", "item")
			Result.extend ("div", "div")
			Result.extend ("span", "span")
			Result.extend ("pre", "code_block")
			Result.extend ("b", "bold")
			Result.extend ("u", "underline")
			Result.extend ("i", "italic")			
			Result.extend ("a", "link")
			Result.extend ("img", "image")
			Result.extend ("title", "title")
			Result.extend ("a", "image_link")
			Result.extend ("meta", "meta")			
			Result.extend ("sub", "sub_script")
			Result.extend ("sup", "super_script")
			Result.extend ("span", "output")
			Result.extend ("script", "script")
		end
		
	element_element_complex_mappings: HASH_TABLE [STRING, STRING] is
			-- Complex element to element mappings
		once
			create Result.make (5)
			Result.compare_objects			
			Result.extend ("html", "document")
			Result.extend ("head", "meta_data")
			Result.extend ("body", "document_paragraph")
			Result.extend ("p", "paragraph")
			Result.extend ("p", "paragraph_end")
			Result.extend ("span", "start_end")
			Result.extend ("", "url")
			Result.extend ("", "anchor_name")
			Result.extend ("map", "image_map")
			Result.extend ("area", "area")
			Result.extend ("xml", "xml")
			Result.extend ("MSHelp:Keyword", "xmlkeyword")
			Result.extend ("MSHelp:link", "help_link")
			Result.extend ("a", "image_link")
			Result.extend ("p class=%"warning%"", "warning")
			Result.extend ("p class=%"tip%"", "tip")
			Result.extend ("p class=%"seealso%"", "seealso")
			Result.extend ("p class=%"sample%"", "sample")
			Result.extend ("p class=%"note%"", "note")
			Result.extend ("p class=%"info%"", "info")									
			Result.extend ("span class=%"tagged_text%"", "start")
			Result.extend ("ol", "list_ordered")
			Result.extend ("ul", "list_unordered")
			Result.extend ("", "list")
			Result.extend ("link", "stylesheet")
			Result.extend ("a", "anchor")
			Result.extend ("a", "link")
		end
		
	element_attribute_mappings: HASH_TABLE [STRING, STRING] is
			-- Elements to attribute mappings
		once
			create Result.make (5)
			Result.compare_objects
			Result.extend ("id", "id")			
			Result.extend ("target", "target")
			Result.extend ("border", "border")
			Result.extend ("width", "width")
			Result.extend ("height", "height")
			Result.extend ("alt", "alt_text")
			Result.extend ("usemap", "usemap")
			Result.extend ("shape", "shape")
			Result.extend ("co-ordinates", "co-ordinates")
			Result.extend ("href", "url")
			--Result.extend ("", "anchor_name")
			Result.extend ("src", "image_url")	
			Result.extend ("rel", "rel")
			Result.extend ("", "stylesheet")
			Result.extend ("cellpadding", "padding")
			Result.extend ("cellspacing", "spacing")
			Result.extend ("align", "alignment")			
			Result.extend ("valign", "vertical_alignment")
			Result.extend ("content", "meta_content")
			Result.extend ("name", "name")
			Result.extend ("indexMoniker", "index_moniker")
			Result.extend ("TABINDEX", "tab_index")
			Result.extend ("keywords", "keywords")
			Result.extend ("hover_color", "hover_color")
			Result.extend ("disambiguator", "disambiguator")
			Result.extend ("error_url", "error_url")
			Result.extend ("filter_name", "filter_name")
			Result.extend ("filter_string", "filter_string")
			Result.extend ("namespace", "namespace")
			Result.extend ("options", "options")
			Result.extend ("Index", "index")
			Result.extend ("Term", "term")
			Result.extend ("name", "anchor")
		end	
		
	attribute_attribute_mappings: HASH_TABLE [STRING, STRING] is
			-- Attribute to attribute name mappings
		once
			create Result.make (5)
			Result.compare_objects
			Result.extend ("class", "style")
			Result.extend ("stylesheet", "stylesheet")
			Result.extend ("title", "stylesheet_title")
			Result.extend ("rowspan", "rowspan")
			Result.extend ("colspan", "columnspan")
		end		
		
	single_element_element_mappings: HASH_TABLE [STRING, STRING] is
			-- List of elements which don't require a closing tag (e.g, '<line_break/>')
		once
			create Result.make (1)
			Result.compare_objects
			Result.extend ("br", "line_break")
		end		
		
	character_mappings: HASH_TABLE [STRING, STRING] is
			-- Character mappings
		once
			create Result.make (5)
			Result.compare_objects
			Result.extend ("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;", "tab_indent")			
		end
		
feature -- Element Data		
		
	content_elements: ARRAYED_LIST [STRING] is
			-- Elements denoting only content
		once
			create Result.make (5)
			Result.compare_objects
			Result.extend ("label")
			Result.extend ("size")
			Result.extend ("content")
			Result.extend ("code")
			Result.extend ("character")
			Result.extend ("output")
		end

	conc_content_elements: ARRAYED_LIST [STRING] is
			-- Elements where content must be concatenated between callbacks
		once
			create Result.make (5)
			Result.compare_objects
			Result.extend ("alt_text")
			Result.extend ("content")
			Result.extend ("meta_content")
			Result.extend ("url")
			Result.extend ("term")
			Result.extend ("keywords")
			Result.extend ("anchor")
			Result.extend ("anchor_name")
		end

	attributable_elements: ARRAYED_LIST [STRING] is
			-- Elements which may contain attributes (once converted to their HTML equivalent)
		once
			create Result.make (5)
			Result.compare_objects
			Result.extend ("link")
			Result.extend ("image")
			Result.extend ("table")
			Result.extend ("row")
			Result.extend ("cell")
			Result.extend ("meta")
			Result.extend ("map")
			Result.extend ("list")
			Result.extend ("stylesheet")
			Result.extend ("span")
			Result.extend ("div")
			Result.extend ("image_link")
			Result.extend ("paragraph")
			Result.extend ("help_link")
			Result.extend ("output")
			Result.extend ("script")
			Result.extend ("document_paragraph")
			Result.extend ("start")
			Result.extend ("document")
			Result.extend ("keyword")
			Result.extend ("xmlkeyword")
			Result.extend ("anchor")
		end
	
	style_elements: ARRAYED_LIST [STRING] is
			-- Elements which represent `class' styles
		once
			create Result.make (5)
			Result.compare_objects
			Result.extend ("string")			
			Result.extend ("number")
			Result.extend ("character")
			Result.extend ("keyword")
			Result.extend ("reserved_word")
			Result.extend ("comment")
			Result.extend ("local_variable")
			Result.extend ("symbol")			
			Result.extend ("local_variable_quoted")
			Result.extend ("contract_tag")
			Result.extend ("generics")
			Result.extend ("indexing_tag")
			Result.extend ("keyword")
			Result.extend ("syntax")
			Result.extend ("class_name")
			Result.extend ("cluster_name")
			Result.extend ("feature_name")
			Result.extend ("compiler_error")
		end	

	bufferable: ARRAYED_LIST [STRING] is
			-- Bufferable elements
		once
			create Result.make (5)
			Result.compare_objects
			Result.extend ("heading")
		end	

feature -- String constans
		
	mapped_row_string: STRING is "tr"
	mapped_cell_string: STRING is "td"
	mapped_list_item_string: STRING is "li"
	item_string: STRING is "item"
	pre_string: STRING is "pre"
	code_block_string: STRING is "code_block"
	mapped_bold_string: STRING is "b"
	bold_string: STRING is "bold"
	mapped_underline_string: STRING is "u"
	underline_string: STRING is "underline"
	mapped_italic_string: STRING is "i"
	italic_string: STRING is "italic"			
	mapped_a_string: STRING is "a"
	mapped_image_string: STRING is "img"
	title_string: STRING is "title"
	sub_script_string: STRING is  "sub_script"
	super_script_string: STRING is  "super_script"					
	meta_data_string: STRING is "meta_data"
	paragraph_end_string: STRING is "paragraph_end"
	start_end_string: STRING is "start_end"			
	image_map_string: STRING is "image_map"
	area_string: STRING is "area"
	xml_string: STRING is "xml"
	warning_string: STRING is "warning"
	tip_string: STRING is "tip"
	seealso_string: STRING is "seealso"
	sample_string: STRING is "sample"
	note_string: STRING is "note"
	info_string: STRING is "info"						
	list_ordered_string: STRING is "list_ordered"
	list_unordered_string: STRING is "list_unordered"
	id_string: STRING is "id"		
	target_string: STRING is "target"
	border_string: STRING is "border"
	width_string: STRING is "width"
	height_string: STRING is "height"
	usemap_string: STRING is "usemap"
	shape_string: STRING is "shape"
	coordinates_string: STRING is "co-ordinates"						
	rel_string: STRING is "rel"
	padding_string: STRING is  "padding"
	spacing_string: STRING is "spacing"
	alignment_string: STRING is "alignment"		
	vertical_alignment_string: STRING is "vertical_alignment"
	name_string: STRING is "name"
	index_moniker_string: STRING is "index_moniker"
	tab_index_string: STRING is "tab_index"
	hover_color_string: STRING is "hover_color"
	disambiguator_string: STRING is "disambiguator"
	error_url_string: STRING is "error_url"
	filter_name_string: STRING is "filter_name"
	filter_string_string: STRING is "filter_string"
	namespace_string: STRING is "namespace"
	options_string: STRING is "options"
	index_string: STRING is "index"						
	rowspan_string: STRING is "rowspan"
	colspan_string: STRING is "columnspan"
	line_break_string: STRING is "line_break"			
	label_string: STRING is "label"
	size_string: STRING is "size"
	code_string: STRING is "code"
	character_string: STRING is "character"
	alt_text_string: STRING is "alt_text"
	content_string: STRING is "content"
	meta_content_string: STRING is "meta_content"
	url_string: STRING is "url"
	term_string: STRING is "term"
	keywords_string: STRING is "keywords"
	anchor_name_string: STRING is "anchor_name"
	link_string: STRING is "link"
	image_string: STRING is "image"
	table_string: STRING is "table"
	row_string: STRING is "row"
	cell_string: STRING is "cell"
	meta_string: STRING is "meta"
	map_string: STRING is "map"
	list_string: STRING is "list"
	stylesheet_string: STRING is "stylesheet"
	span_string: STRING is "span"
	div_string: STRING is "div"
	help_link_string: STRING is "help_link"
	script_string: STRING is "script"
	document_paragraph_string: STRING is "document_paragraph"
	start_string: STRING is "start"
	document_string: STRING is "document"
	keyword_string: STRING is "keyword"
	xmlkeyword_string: STRING is "xmlkeyword"
	anchor_string: STRING is "anchor"
	string_string: STRING is "string"			
	number_string: STRING is "number"
	reserved_word_string: STRING is "reserved_word"
	comment_string: STRING is "comment"
	local_variable_string: STRING is "local_variable"
	symbol_string: STRING is "symbol"
	local_variable_quoted_string: STRING is "local_variable_quoted"
	contract_tag_string: STRING is "contract_tag"
	generics_string: STRING is "generics"
	indexing_tag_string: STRING is "indexing_tag"	
	syntax_string: STRING is "syntax"
	class_name_string: STRING is "class_name"
	cluster_name_string: STRING is "cluster_name"
	feature_name_string: STRING is "feature_name"
	compiler_error_string: STRING is "compiler_error"
	heading_string: STRING is "heading"	
	paragraph_string: STRING is "paragraph"
	image_url_string: STRING is "image_url";

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
end -- class HTML_FILTER_MAPPINGS
