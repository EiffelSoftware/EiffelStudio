indexing
	description: "Convert XML to HTML."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_FILTER
	
inherit
	FILE_FILTER
		redefine			
			on_start_tag,
			on_end_tag,
			on_attribute,
			on_content,
			clear
		end

	HTML_FILTER_MAPPINGS

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
			if element_element_complex_mappings.has (a_local_part) then
				process_complex_element (a_local_part, True)
			elseif element_element_mappings.has (a_local_part) then
				write_element (a_local_part, True, False)
			elseif Element_attribute_mappings.has (a_local_part) then
				process_attribute_element (a_local_part)
			elseif style_elements.has (a_local_part) then
				process_class_attribute_element (a_local_part)
			elseif character_mappings.has (a_local_part) then
				process_character_mapping_element (a_local_part)
			else
				can_write_content := Content_elements.has (a_local_part)
			end
			previous_elements.put (a_local_part)			
		end

	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
			-- End of tag.
		do
			if conc_content /= Void then
				if 
					a_local_part.is_equal ("url") and then 
					not Previous_elements.linear_representation.i_th (2).has_substring ("image")
				then
					conc_content := link_convert (conc_content)
				end
				if in_attribute then
					output_string.insert_string ("%"" + conc_content + "%"", content_write_position)
				else
					output_string.insert_string (conc_content, content_write_position)
				end
				conc_content := Void
			end
			if element_element_complex_mappings.has (a_local_part) then
				process_complex_element (a_local_part, False)
			elseif element_element_mappings.has (a_local_part) then
				write_element (a_local_part, False, False)
			elseif style_elements.has (a_local_part) then
				write_element ("span", False, False)
			elseif Bufferable.has (a_local_part) then
				if not Buffered_tags.is_empty then
					output_string.append (Buffered_tags.item)
					Buffered_tags.remove
				end				
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
			l_tag,
			l_content,
			l_prev: STRING
			write: BOOLEAN
		do	
			if can_write_content then
				write := True
				l_prev := Previous_elements.item
				l_content := cleaned_content (a_content)
					-- Headings
				if l_prev.is_equal ("size") then
					l_tag := ""
					if 
						a_content.is_equal ("1") or
						a_content.is_equal ("2") or
						a_content.is_equal ("3") or
						a_content.is_equal ("4") or
						a_content.is_equal ("5") or
						a_content.is_equal ("6")
					then
						l_tag := "h" + a_content					
					end					
					l_content := "<" + l_tag + ">"
					if not l_tag.is_empty then
						Buffered_tags.extend ("</" + l_tag + ">")
					end									
				elseif Conc_content_elements.has (l_prev) then
					if conc_content = Void then
						conc_content := ""
					end
					conc_content.append (a_content)
					write := False
				end				
				if not l_content.is_equal (Empty_tag) and not l_content.is_empty and write then					
					if in_attribute then
						output_string.insert_string ("%"" + l_content + "%"", content_write_position)
					else
						output_string.insert_string (l_content, content_write_position)
					end
				end
			end			
		end

feature -- Status Setting

	set_filename (a_file: STRING) is
			-- Set filename indicating file being filtered
		require
			file_not_void: a_file /= Void
		do
			filename := a_file	
		end		

feature {NONE} -- Processing

	process_complex_element (e: STRING; is_start: BOOLEAN) is
			-- Process complex element `e'
		require
			e_not_void: e/= Void
		local
			l_previous,
			l_name: STRING
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
					if l_previous.is_equal ("image") then
						write_attribute ("image_url", False)
					else
						write_attribute (e, False)
					end
				elseif e.is_equal ("stylesheet") then
					write_element (e, True, True)
					write_attribute ("rel", False)
					output_string.insert_string ("%"stylesheet%"", attribute_value_write_position)
					process_attribute_element ("url")
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
					if previous_attribute /= Void then
						if previous_attribute_value.is_equal ("true") then
							l_name := "list_ordered"
						elseif previous_attribute_value.is_equal ("false") then
							l_name := "list_unordered"
						end
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
				end
				
				if l_name = Void then
					l_name := e
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
		do
			attribute_stack.extend (e)				
			write_attribute (e, False)
		end
		
	process_class_attribute_element (e: STRING) is
			-- Process class attribute element `e'
		require
			e_not_void: e /= Void
		do						
			write_attribute (e, True)
		end
		
	process_character_mapping_element (e: STRING) is
			-- Convert element to associated character mapping
		require
			e_not_void: e /= Void
		do						
			on_content (character_mappings.item (e))
		end

	process_attribute (a_name, a_value: STRING) is
			-- Process attribute
		require
			name_not_void: a_name /= Void
			value_not_void: a_value /= Void
		local
			l_prev_element,
			l_att: STRING
		do
			l_prev_element := Previous_elements.item
			
			if l_prev_element /= Void and attributable_elements.has (l_prev_element) then
				if attribute_attribute_mappings.has (a_name) then
					l_att := " " + attribute_attribute_mappings.item (a_name) + "=%"" + a_value + "%""	
				else
					l_att := " " + a_name + "=%"" + a_value + "%""
				end				
				
						-- List
				if l_prev_element.is_equal ("list") then
					if a_value.is_equal ("true") then
						write_element ("list_ordered", True, True)
					elseif a_value.is_equal ("false") then						
						write_element ("list_unordered", True, True)
					end
				else					
					output_string.insert_string (l_att, attribute_write_position)
					attribute_write_position := output_string.count
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

	link_convert (a_url: STRING): STRING is
			-- Converts `a_url' file link to html file link
		require
			url_not_void: a_url /= Void
			url_not_empty: not a_url.is_empty
		local
			l_util: UTILITY_FUNCTIONS
			l_filename: FILE_NAME
			l_link: DOCUMENT_LINK
		do
			create l_util
			create l_link.make (filename, a_url)
			if not l_link.external_link then
				create l_filename.make_from_string (l_util.file_no_extension (a_url))
				if not l_filename.is_empty then
					l_filename.add_extension ("html")
				end				
				Result := l_filename.string
			else
				Result := a_url
			end			
		end		

feature {NONE} -- Access

	file_type: STRING is "html"

	attribute_write_position,
	attribute_value_write_position: INTEGER
			-- Position to write attribute and attribute value
	
	content_offset: INTEGER
			-- Content offset
	
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
			e_maps: element_element_complex_mappings.has (e) or element_element_mappings.has (e)
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
				l_name := element_element_complex_mappings.item (e)
			else
				l_name := element_element_mappings.item (e)
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

	write_attribute (e: STRING; is_class: BOOLEAN) is
			-- Write `e' as attribute
		require
			e_not_void: e /= Void
			e_is_valid_element: element_attribute_mappings.has (e) or style_elements.has (e)
			processing_in_attribute: in_attribute
		local
			l_att: STRING
		do			
			if is_class then
				write_element ("span", True, False)
				l_att := " class=%"" + e + "%""
			else
				l_att := " " + Element_attribute_mappings.item (e) + "="
				attribute_value_write_position := attribute_write_position + Element_attribute_mappings.item (e).count + 2
			end
			output_string.insert_string (l_att, attribute_write_position)
		end

feature {NONE} -- Implementation

	buffered_tags: ARRAYED_STACK [STRING] is
			-- Buffered tag
		once
			create Result.make (1)
		end

	previous_elements: ARRAYED_STACK [STRING] is
			-- Previously processed element name
		once
			create Result.make (1)
			Result.compare_objects
		end

	complex_stack: ARRAYED_STACK [STRING] is
			-- List of complex elements names currently being processed
		once
			create Result.make (1)
			Result.compare_objects
		end

	attribute_stack: ARRAYED_STACK [STRING] is
			-- List of elements names currently being processed as attributes
		once
			create Result.make (1)
			Result.compare_objects
		end

	previous_element: STRING is
			-- Name of last processed element
		do
			Result := Previous_elements.item	
		end		

	previous_attribute: TUPLE [STRING, STRING]
			-- Previous attribute

	previous_attribute_name: STRING is
			-- Previous attribute name
		do
			if previous_attribute /= Void then
				Result ?= previous_attribute.item (1)
			end			
		end
		
	previous_attribute_value: STRING is
			-- Previous attribute value
		do
			if previous_attribute /= Void then
				Result ?= previous_attribute.item (2)
			end			
		end

	filename: STRING
			-- File name

	empty_tag: STRING is
			-- Empty tag
		once
			Result := "<>"
		end		
		
	conc_content: STRING
			-- Current concatenated content string	

	cleaned_content (a_content: STRING): STRING is
			-- Content cleaned
		do
			Result := a_content.twin
			if not in_pre_tag then
				Result.prune_all_leading ('%N')
				Result.prune_all_leading ('%T')
				Result.prune_all_trailing ('%T')
				Result.replace_substring_all ("amp;", "")
			end
		end

	in_pre_tag: BOOLEAN is
			-- Are we inside a tag which should be treated as a pre tag?
		do
			Result := Previous_elements.has ("code_block")
		end

end -- class HTML_FILTER
