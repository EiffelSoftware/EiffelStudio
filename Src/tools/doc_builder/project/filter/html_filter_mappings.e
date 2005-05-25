indexing
	description: "Mappings for Schema -> HTML filtering."
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
			Result.extend ("MSHelp:Keyword", "keyword")
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
			Result.extend ("href", "anchor_name")
			Result.extend ("src", "image_url")	
			Result.extend ("rel", "rel")
			Result.extend ("", "stylesheet")
			Result.extend ("cellpadding", "padding")
			Result.extend ("cellspacing", "spacing")
			Result.extend ("align", "alignment")			
			Result.extend ("valign", "vertical_alignment")
			Result.extend ("content", "meta_content")
			Result.extend ("name", "name")
			Result.extend ("index_moniker", "index_moniker")
			Result.extend ("tab_index", "tab_index")
			Result.extend ("keywords", "keywords")
			Result.extend ("hover_color", "hover_color")
			Result.extend ("disambiguator", "disambiguator")
			Result.extend ("error_url", "error_url")
			Result.extend ("filter_name", "filter_name")
			Result.extend ("filter_string", "filter_string")
			Result.extend ("namespace", "namespace")
			Result.extend ("options", "options")
			Result.extend ("index", "index")
			Result.extend ("term", "term")
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

end -- class HTML_FILTER_MAPPINGS
