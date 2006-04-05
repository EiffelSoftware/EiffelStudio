indexing
	description: "Convert XHTML to XML."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XML_FILTER
	
inherit
	DOCUMENT_FILTER
		redefine			
			on_start_tag,
			on_end_tag,
			on_attribute,
			on_content,
			clear
		end

create
	make

feature -- Status Setting

	clear is
			-- Clear
		do
			Precursor
			attribute_write_position := 0
			previous_attribute := Void
			Previous_elements.wipe_out
			Complex_stack.wipe_out
			Attribute_stack.wipe_out
		end		

feature -- Tag	

	on_start_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
			-- Start of tag.
		do
			can_write_content := True
			if Complex_element_mappings.has (a_local_part) then
				process_complex_element (a_local_part, True)
			elseif Basic_element_mappings.has (a_local_part) then
				write_element (a_local_part, True, False)
			elseif Element_attribute_mappings.has (a_local_part) then
				process_attribute_element (a_local_part)
			else
				can_write_content := Content_elements.has (a_local_part)
			end
			previous_elements.put (a_local_part)			
		end

	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
			-- End of tag.
		do
			if Complex_element_mappings.has (a_local_part) then
				process_complex_element (a_local_part, False)
			elseif Basic_element_mappings.has (a_local_part) then
				write_element (a_local_part, False, False)
			end
			if Element_attribute_mappings.has (a_local_part) then
				Attribute_stack.remove
			end
			previous_elements.remove
		end

	on_attribute (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING; a_value: STRING) is
			-- Attribute
		do
			process_attribute (a_local_part, a_value)
		end

	on_content (a_content: STRING) is
			-- Forward content.
		local
			l_content: STRING
		do			
			if can_write_content then
				if Previous_elements.item.is_equal ("size") then
					if a_content.is_equal ("1") then
						l_content := "<h1></h1>"
					elseif a_content.is_equal ("2") then
						l_content := "<h2></h2>"
					elseif a_content.is_equal ("3") then
						l_content := "<h3></h3>"
					elseif a_content.is_equal ("4") then
						l_content := "<h4></h4>"
					elseif a_content.is_equal ("5") then
						l_content := "<h5></h5>"
					elseif a_content.is_equal ("6") then
						l_content := "<h6></h6>"
					end
				else
					l_content := a_content
				end
				if in_attribute then
					output_string.insert_string ("%"" + l_content + "%"", content_write_position)
				else
					output_string.insert_string (l_content, content_write_position)
				end
			end			
		end

feature {NONE} -- Processing

	process_complex_element (e: STRING; is_start: BOOLEAN) is
			-- Process complex element `e'
		require
			e_not_void: e/= Void
		local
			l_previous, l_name: STRING
		do
			l_previous := Previous_elements.item
					
			if is_start then
						-- Complex start tag
				complex_stack.extend (e)
				
						-- Paragraph
				if e.is_equal ("paragraph") then
					if l_previous.is_equal ("document") then
						write_element ("document_paragraph", is_start, True)
					else
						write_element (e, is_start, True)
					end
						-- Url
				elseif e.is_equal ("url") then
					Attribute_stack.extend (e)
					if l_previous.is_equal ("link") or l_previous.is_equal ("area") or l_previous.is_equal ("image_link") then						
						write_attribute (e)
					elseif l_previous.is_equal ("image") then
						write_attribute ("image_url")										
					end
				else
					write_element (e, is_start, True)
				end					
			else
					-- Complex end tag
				check
					Complex_stack.item.is_equal (e)
				end
				if e.is_equal ("paragraph") then
						-- Paragraph
					if l_previous.is_equal ("document") then
						l_name := "document_paragraph"
					else
						l_name :=  e
					end						
				elseif e.is_equal ("list")then
						-- List
					if previous_attribute_value.is_equal ("true") then
						l_name := "list_ordered"
					elseif previous_attribute_value.is_equal ("false") then
						l_name := "list_unordered"
					end
				elseif 
						-- Block elements
					e.is_equal ("warning") or
					e.is_equal ("note") or
					e.is_equal ("tip") or
					e.is_equal ("seealso") or
					e.is_equal ("sample") or
					e.is_equal ("info")
				then
					l_name := "paragraph_end"
				else
					l_name :=  e
				end
				if not in_attribute then
					write_element (l_name, is_start, True)
				end				
				Complex_stack.remove
			end		
		end	
		
	process_attribute_element (e: STRING) is
			-- Process attribute element `e'
		require
			e_not_void: e /= Void
		local
			l_previous: STRING
		do
			attribute_stack.extend (e)				
			write_attribute (e)
		end

	process_attribute (a_name, a_value: STRING) is
			-- Process attribute
		require
			name_not_void: a_name /= Void
			value_not_void: a_value /= Void
		local
			l_prev_element: STRING
		do
			l_prev_element := Previous_elements.item
			if l_prev_element /= Void then
						-- List
				if l_prev_element.is_equal ("list") then
					if a_value.is_equal ("true") then
						write_element ("list_ordered", True, True)
					elseif a_value.is_equal ("false") then						
						write_element ("list_unordered", True, True)
					end
				end
			end
			previous_attribute := [a_name, a_value]
		end		

feature {NONE} -- Query
		
	in_attribute: BOOLEAN is
			-- Is current processing a attribute element??
		do
			Result := not Attribute_stack.is_empty
		end

	can_write_content: BOOLEAN
			-- Can content be output based Current element?

feature {NONE} -- Access

	description: STRING is
			-- Textual description of filter
		do
			Result := "Web"	
		end		

	attribute_write_position,
	attribute_value_write_position: INTEGER
			-- Position to write attribute and attribute value
	
	content_write_position: INTEGER is
			-- Position to write current content text(s)
		do
			if in_attribute then
				Result := attribute_value_write_position
			else
				Result := output_string.count + 1
			end
		end

feature {NONE} -- Output

	write_element (e: STRING; start: BOOLEAN; is_complex: BOOLEAN) is
			-- Write `e' as element
		require
			e_not_void: e /= Void
			e_not_empty: not e.is_empty
			e_maps: Complex_element_mappings.has (e) or Basic_element_mappings.has (e)
			not_in_attribute: not in_attribute
		local
			l_start_tag,
			l_name: STRING
		do	
					-- Determine correct tag format
			if start then
				l_start_tag := "<"
			else
				l_start_tag := "</"
			end
			
					-- Extract mapping from appropriate list
			if is_complex then
				l_name := Complex_element_mappings.item (e)
			else
				l_name := Basic_element_mappings.item (e)
			end
			
					-- Write value to output
			if not l_name.is_empty then
				output_string.append (l_start_tag + l_name + ">")
			end
			
					-- Set attribute write position if applicable
			if start and then attributable_elements.has (e) then
				attribute_write_position := output_string.count
			end
		end

	write_attribute (e: STRING) is
			-- Write `e' as attribute
		require
			e_not_void: e /= Void
			e_is_attribute_element: Element_attribute_mappings.has (e)
			processing_in_attribute: in_attribute
		do			
			output_string.insert_string (" " + Element_attribute_mappings.item (e) + "=", attribute_write_position)
			attribute_value_write_position := attribute_write_position + Element_attribute_mappings.item (e).count + 2
		end

feature {NONE} -- Mapping Tables

	basic_element_mappings: HASH_TABLE [STRING, STRING] is
			-- Basic element to element mapping strings
		once
			create Result.make (15)
			Result.compare_objects
			Result.extend ("html", "document")
			Result.extend ("head", "help")
			Result.extend ("table", "table")
			Result.extend ("tr", "row")
			Result.extend ("td", "cell")
			Result.extend ("li", "item")
			Result.extend ("div", "div")
			Result.extend ("span", "span")
			Result.extend ("pre", "code_block")
			Result.extend ("b", "bold")
			Result.extend ("i", "italic")
			Result.extend ("br", "line_break")					
			Result.extend ("a", "link")
			Result.extend ("img", "image")			
		end
		
	complex_element_mappings: HASH_TABLE [STRING, STRING] is
			-- Complex element to element mapping strings
		once
			create Result.make (5)
			Result.compare_objects
			Result.extend ("body", "document_paragraph")
			Result.extend ("p", "paragraph")
			Result.extend ("p", "paragraph_end")
			Result.extend ("", "url")
			Result.extend ("map", "image_map")
			Result.extend ("area", "area")
			Result.extend ("MSHelp:link", "help_link")
			Result.extend ("a", "image_link")
			Result.extend ("p class=%"warning%"", "warning")
			Result.extend ("p class=%"tip%"", "tip")
			Result.extend ("p class=%"seealso%"", "seealso")
			Result.extend ("p class=%"sample%"", "sample")
			Result.extend ("p class=%"note%"", "note")
			Result.extend ("p class=%"info%"", "info")			
			Result.extend ("ol", "list_ordered")
			Result.extend ("ul", "list_unordered")
			Result.extend ("", "list")
		end
		
	element_attribute_mappings: HASH_TABLE [STRING, STRING] is
			-- Elements which should be converted to HTML attributes
		once
			create Result.make (5)
			Result.compare_objects
			Result.extend ("id", "id")			
			Result.extend ("target", "target")
			Result.extend ("border", "border")
			Result.extend ("width", "width")
			Result.extend ("height", "height")
			Result.extend ("alt_text", "alt_text")
			Result.extend ("usemap", "usemap")
			Result.extend ("shape", "shape")
			Result.extend ("co-ordinates", "co-ordinates")
--			Result.extend ("class_name", "class_name")
--			Result.extend ("string", "string")
--			Result.extend ("keywords", "keywords")
--			Result.extend ("tab_index", "tab_index")
--			Result.extend ("hover_color", "hover_color")
--			Result.extend ("disambiguator", "disambiguator")
--			Result.extend ("error_url", "error_url")
--			Result.extend ("filter_name", "filter_name")
--			Result.extend ("filter_string", "filter_string")
--			Result.extend ("index_moniker", "index_moniker")
--			Result.extend ("namespace", "namespace")
--			Result.extend ("options", "options")
			Result.extend ("href", "url")
			Result.extend ("src", "image_url")
			Result.extend ("alt", "alt_text")			
		end	
		
	element_style_mappings: ARRAYED_LIST [STRING] is
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
		end	
		
	content_elements: ARRAYED_LIST [STRING] is
			-- Elements denoting purely content
		once
			create Result.make (5)
			Result.compare_objects
			Result.extend ("label")
		end

	attributable_elements: ARRAYED_LIST [STRING] is
			-- Elements which may contain attributes
		once
			create Result.make (5)
			Result.compare_objects
			Result.extend ("link")
			Result.extend ("image")
			Result.extend ("table")
			Result.extend ("meta")
			Result.extend ("map")
		end
		
	attributes: ARRAYED_LIST [STRING] is
			-- Attributes
		once
			create Result.make (5)
			Result.compare_objects
			Result.extend ("ordered")
			Result.extend ("output")
			Result.extend ("title")
		end

feature {NONE} -- Implementation

	previous_elements: ARRAYED_STACK [STRING] is
			-- Previously processed element name
		once
			create Result.make (5)
		end

	complex_stack: ARRAYED_STACK [STRING] is
			-- List of complex elements names currently being processed
		once
			create Result.make (2)
			Result.compare_objects
		end

	attribute_stack: ARRAYED_STACK [STRING] is
			-- List of elements names currently being processed as attributes
		once
			create Result.make (2)
			Result.compare_objects
		end

	previous_attribute: TUPLE [STRING, STRING]
			-- Previous attribute

	previous_attribute_name: STRING is
			-- Previous attribute name
		do
			Result ?= previous_attribute.item (1)
		end
		
	previous_attribute_value: STRING is
			-- Previous attribute value
		do
			Result ?= previous_attribute.item (2)
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
end -- class XML_FILTER
