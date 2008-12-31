note
	description: "Mappings for Schema -> HTML filtering."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_FILTER_MAPPINGS

feature {HTML_FILTER} -- Access

	element_element_mappings: HASH_TABLE [STRING, STRING]
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
		
	element_element_complex_mappings: HASH_TABLE [STRING, STRING]
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
		
	element_attribute_mappings: HASH_TABLE [STRING, STRING]
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
		
	attribute_attribute_mappings: HASH_TABLE [STRING, STRING]
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
		
	single_element_element_mappings: HASH_TABLE [STRING, STRING]
			-- List of elements which don't require a closing tag (e.g, '<line_break/>')
		once
			create Result.make (1)
			Result.compare_objects
			Result.extend ("br", "line_break")
		end		
		
	character_mappings: HASH_TABLE [STRING, STRING]
			-- Character mappings
		once
			create Result.make (5)
			Result.compare_objects
			Result.extend ("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;", "tab_indent")			
		end
		
feature -- Element Data		
		
	content_elements: ARRAYED_LIST [STRING]
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

	conc_content_elements: ARRAYED_LIST [STRING]
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

	attributable_elements: ARRAYED_LIST [STRING]
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
	
	style_elements: ARRAYED_LIST [STRING]
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

	bufferable: ARRAYED_LIST [STRING]
			-- Bufferable elements
		once
			create Result.make (5)
			Result.compare_objects
			Result.extend ("heading")
		end	

feature -- String constans
		
	mapped_row_string: STRING = "tr"
	mapped_cell_string: STRING = "td"
	mapped_list_item_string: STRING = "li"
	item_string: STRING = "item"
	pre_string: STRING = "pre"
	code_block_string: STRING = "code_block"
	mapped_bold_string: STRING = "b"
	bold_string: STRING = "bold"
	mapped_underline_string: STRING = "u"
	underline_string: STRING = "underline"
	mapped_italic_string: STRING = "i"
	italic_string: STRING = "italic"			
	mapped_a_string: STRING = "a"
	mapped_image_string: STRING = "img"
	title_string: STRING = "title"
	sub_script_string: STRING =  "sub_script"
	super_script_string: STRING =  "super_script"					
	meta_data_string: STRING = "meta_data"
	paragraph_end_string: STRING = "paragraph_end"
	start_end_string: STRING = "start_end"			
	image_map_string: STRING = "image_map"
	area_string: STRING = "area"
	xml_string: STRING = "xml"
	warning_string: STRING = "warning"
	tip_string: STRING = "tip"
	seealso_string: STRING = "seealso"
	sample_string: STRING = "sample"
	note_string: STRING = "note"
	info_string: STRING = "info"						
	list_ordered_string: STRING = "list_ordered"
	list_unordered_string: STRING = "list_unordered"
	id_string: STRING = "id"		
	target_string: STRING = "target"
	border_string: STRING = "border"
	width_string: STRING = "width"
	height_string: STRING = "height"
	usemap_string: STRING = "usemap"
	shape_string: STRING = "shape"
	coordinates_string: STRING = "co-ordinates"						
	rel_string: STRING = "rel"
	padding_string: STRING =  "padding"
	spacing_string: STRING = "spacing"
	alignment_string: STRING = "alignment"		
	vertical_alignment_string: STRING = "vertical_alignment"
	name_string: STRING = "name"
	index_moniker_string: STRING = "index_moniker"
	tab_index_string: STRING = "tab_index"
	hover_color_string: STRING = "hover_color"
	disambiguator_string: STRING = "disambiguator"
	error_url_string: STRING = "error_url"
	filter_name_string: STRING = "filter_name"
	filter_string_string: STRING = "filter_string"
	namespace_string: STRING = "namespace"
	options_string: STRING = "options"
	index_string: STRING = "index"						
	rowspan_string: STRING = "rowspan"
	colspan_string: STRING = "columnspan"
	line_break_string: STRING = "line_break"			
	label_string: STRING = "label"
	size_string: STRING = "size"
	code_string: STRING = "code"
	character_string: STRING = "character"
	alt_text_string: STRING = "alt_text"
	content_string: STRING = "content"
	meta_content_string: STRING = "meta_content"
	url_string: STRING = "url"
	term_string: STRING = "term"
	keywords_string: STRING = "keywords"
	anchor_name_string: STRING = "anchor_name"
	link_string: STRING = "link"
	image_string: STRING = "image"
	table_string: STRING = "table"
	row_string: STRING = "row"
	cell_string: STRING = "cell"
	meta_string: STRING = "meta"
	map_string: STRING = "map"
	list_string: STRING = "list"
	stylesheet_string: STRING = "stylesheet"
	span_string: STRING = "span"
	div_string: STRING = "div"
	help_link_string: STRING = "help_link"
	script_string: STRING = "script"
	document_paragraph_string: STRING = "document_paragraph"
	start_string: STRING = "start"
	document_string: STRING = "document"
	keyword_string: STRING = "keyword"
	xmlkeyword_string: STRING = "xmlkeyword"
	anchor_string: STRING = "anchor"
	string_string: STRING = "string"			
	number_string: STRING = "number"
	reserved_word_string: STRING = "reserved_word"
	comment_string: STRING = "comment"
	local_variable_string: STRING = "local_variable"
	symbol_string: STRING = "symbol"
	local_variable_quoted_string: STRING = "local_variable_quoted"
	contract_tag_string: STRING = "contract_tag"
	generics_string: STRING = "generics"
	indexing_tag_string: STRING = "indexing_tag"	
	syntax_string: STRING = "syntax"
	class_name_string: STRING = "class_name"
	cluster_name_string: STRING = "cluster_name"
	feature_name_string: STRING = "feature_name"
	compiler_error_string: STRING = "compiler_error"
	heading_string: STRING = "heading"	
	paragraph_string: STRING = "paragraph"
	image_url_string: STRING = "image_url";

note
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
