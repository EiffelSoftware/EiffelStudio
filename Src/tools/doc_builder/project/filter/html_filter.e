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
			list_type_stack.wipe_out
		end		

feature -- Tag	

	on_start_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
			-- Start of tag.
		do
			can_write_content := True
			if element_element_complex_mappings.has (a_local_part) then
				process_complex_element (a_local_part, True)
			elseif element_element_mappings.has (a_local_part) or single_element_element_mappings.has (a_local_part) then
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
					a_local_part.is_equal (url_string)
				then
					if Previous_elements.linear_representation.i_th (2).has_substring (image_string) then
						conc_content := image_link_convert (conc_content)
					else
						conc_content := link_convert (conc_content)
					end
				end
					
				if in_attribute then
					output_string.insert_string ("%"" + conc_content + "%"", content_write_position)
				else
					if not a_local_part.is_equal (anchor_name_string) then						
						output_string.insert_string (conc_content, content_write_position)	
					end
				end
				conc_content := Void
			end
			if element_element_complex_mappings.has (a_local_part) then
				process_complex_element (a_local_part, False)
			elseif element_element_mappings.has (a_local_part) then
				write_element (a_local_part, False, False)
			elseif style_elements.has (a_local_part) then
				write_element (span_string, False, False)
			elseif Bufferable.has (a_local_part) then
				if not Buffered_tags.is_empty then
					output_string.append (Buffered_tags.item)
					Buffered_tags.remove
				end				
			end
			if element_attribute_mappings.has (a_local_part) and not Attribute_stack.is_empty then
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
						a_content.item (1) = '1' or
						a_content.item (1) = '2' or
						a_content.item (1) = '3' or
						a_content.item (1) = '4' or
						a_content.item (1) = '5' or
						a_content.item (1) = '6'
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
					if l_prev.is_equal (anchor_name_string) then
						anchor_content := conc_content.twin
					end
					if l_prev.is_equal (url_string) then
						url_anchor_write_position := attribute_value_write_position + a_content.count + 2
					end
					write := False
				end				
				if not l_content.is_equal (Empty_tag) and not l_content.is_empty and write then					
					if in_attribute then
						if restore_attribute_value > 0 then
							attribute_value_write_position := restore_attribute_value
						end
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
			if not previous_elements.is_empty then				
				l_previous := Previous_elements.item	
			end
					
			if is_start then
						-- Complex start tag
				complex_stack.extend (e)
				
						-- Paragraph
				if e.is_equal (paragraph_string) then
					if l_previous.is_equal (document_string) then
						write_element (document_paragraph_string, is_start, True)
					else
						write_element (e, is_start, True)
					end
				elseif e.is_equal (link_string) then
					write_element (e, True, False)
					
						-- Url				
				elseif e.is_equal (url_string) then
					Attribute_stack.extend (e)					
					if l_previous.is_equal (image_string) then
						write_attribute (image_url_string, False)
					else
						write_attribute (e, False)
						url_anchor_write_position := attribute_value_write_position + 6
					end
					in_url := True
					
					-- Anchor
				elseif e.is_equal (anchor_name_string) then	
					in_url_anchor := True
					
						-- Stylesheet
				elseif e.is_equal (stylesheet_string) then
					write_element (e, True, True)
					write_attribute (rel_string, False)
					output_string.insert_string ("%"stylesheet%"", attribute_value_write_position)
					process_attribute_element (url_string)
					
						-- Anchor
				elseif e.is_equal (anchor_string) then
					write_element (e, True, True)
					process_attribute_element (anchor_string)
				elseif e.is_equal (xml_string) then
					write_element (e, is_start, True)
					output_string.append ("<MSHelp:Attr Name=%"DocSet%" Value=%"EiffelEnvision Help%"/>")
				else
					write_element (e, is_start, True)
				end
			else
					-- Complex end tag
				check
					Complex_stack.item.is_equal (e)
				end
				if e.is_equal (paragraph_string) then
						-- Paragraph
					if l_previous.is_equal (document_string) then
						l_name := document_paragraph_string
					else
						l_name :=  e
					end	
				elseif e.is_equal (link_string) then
					 in_url := False
					 in_url_anchor := False
				elseif e.is_equal (document_string) then
						-- Document
					l_name := e
					output_string.remove_tail (4)
					output_string.append ("</body>")
				elseif e.is_equal (meta_data_string) then
						-- Meta Data
					if title /= Void then
						output_string.append ("<title>" + title + "</title>")
					end
				elseif e.is_equal (list_string)then
						-- List					
					if list_type_stack.item then						
						l_name := list_ordered_string
					else
						l_name := list_unordered_string
					end				
				elseif e.is_equal (start_string) then
						-- Start
					output_string.insert_string ("<table><tr><td class=%"tagged_text_bottom%">..end text for " + type_value + " version</td></tr></table>", content_write_position)
					l_name := start_end_string
				elseif e.is_equal (url_string) then
					if in_url_anchor then
						if not anchor_content.is_equal ("") then 
							if url_anchor_write_position < output_string.count then
								output_string.insert_string ("#" + anchor_content, url_anchor_write_position)
							else
								output_string.insert_string ("#" + anchor_content, output_string.count - 1)
							end
						end						
						in_url_anchor := False
						in_url := False
						anchor_content := ""					
					end
				elseif e.is_equal (anchor_name_string) then
					if in_url then
						if anchor_content /= Void and then not anchor_content.is_empty then
							if url_anchor_write_position < output_string.count then
								output_string.insert_string ("#" + anchor_content, url_anchor_write_position)
							else
								output_string.insert_string ("#" + anchor_content, output_string.count - 1)
							end
						end
						in_url_anchor := False
						in_url := False
						anchor_content := ""
						conc_content := ""
					else
						in_url_anchor := True
					end					
				elseif 
						-- Block elements
					e.is_equal (warning_string) or
					e.is_equal (note_string) or
					e.is_equal (tip_string) or
					e.is_equal (seealso_string) or
					e.is_equal (sample_string) or
					e.is_equal (info_string)
				then
					l_name := paragraph_end_string
				elseif e.is_equal (anchor_string) then
						-- Anchor
					output_string.append ("</a>")
				elseif e.is_equal (stylesheet_string) then
					output_string.append ("</link>")
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
										
				if l_prev_element.is_equal (document_string) and then a_name.is_equal (title_string) then
						-- Document
					title := a_value
				elseif l_prev_element.is_equal (list_string) then
						-- List
					if a_value.is_equal ("true") then
						write_element (list_ordered_string, True, True)
						list_type_stack.extend (True)
					elseif a_value.is_equal ("false") then						
						write_element (list_unordered_string, True, True)
						list_type_stack.extend (False)
					end						
				elseif l_prev_element.is_equal (output_string) then
						-- Output
					if a_name.is_equal (output_string) then
						l_att := " id=%"" + a_value + "%""
						output_string.insert_string (l_att, attribute_write_position)
						attribute_write_position := output_string.count
					end		
				elseif l_prev_element.is_equal (start_string) then
						-- Start
					if a_name.is_equal ("type") then
						type_value := a_value						
						output_string.insert_string ("<table><tr><td class=%"tagged_text_top%">Start text for " + type_value + " version..</td></tr></table>", content_write_position)
					end		
				else										
					output_string.insert_string (l_att, attribute_write_position)
					attribute_write_position := output_string.count
				end					
				
				if attributable_elements.has (l_prev_element) and in_attribute then
					restore_attribute_value := attribute_value_write_position + l_att.count
				else
					restore_attribute_value := 0
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
			-- Converts `a_url' file link to html file link.  
			-- Optionally converts it to relative links also.
			-- Leaves directory urls unchanged.
		require
			url_not_void: a_url /= Void
			url_not_empty: not a_url.is_empty
		local
			l_util: UTILITY_FUNCTIONS
			l_filename: FILE_NAME
			l_link: DOCUMENT_LINK
			l_shared: SHARED_OBJECTS
			l_dir: DIRECTORY
		do
			create l_util
			create l_shared			
			create l_link.make (filename, a_url)
			if not l_link.external_link then
				create l_filename.make_from_string (l_link.absolute_url)
				create l_dir.make (l_filename.string)
				if not l_dir.exists then							
						-- Convert to relative links
					Result := l_link.relative_url
						-- If link is an XML link, convert it to HTML (otherwise leave it as is)
					if l_util.file_type (a_url).is_equal (xml_string) then
						create l_filename.make_from_string (l_util.file_no_extension (Result))
						if not l_filename.is_empty then
							l_filename.add_extension ("html")
							Result := l_filename.string
						end
					end					
				else
						-- A directory
					Result := a_url
				end
			else
					-- A external link
				Result := a_url			
			end
			if Result.has_substring ("ms-help//") then
				Result.replace_substring_all ("ms-help//", "ms-help://")
			end
		end
		
	image_link_convert (a_url: STRING): STRING is
			-- Converts `a_url' image file link to relative link
		require
			url_not_void: a_url /= Void
			url_not_empty: not a_url.is_empty
		local
			l_util: UTILITY_FUNCTIONS
			l_filename: FILE_NAME
			l_link: DOCUMENT_LINK
			l_shared: SHARED_OBJECTS
			l_dir: DIRECTORY
		do
			create l_util
			create l_shared			
			create l_link.make (filename, a_url)
			if not l_link.external_link then
				create l_filename.make_from_string (l_link.absolute_url)
				create l_dir.make (l_filename.string)
				if not l_dir.exists then							
						-- Convert to relative links
					Result := l_link.relative_url
				else
						-- A directory
					Result := a_url
				end
			else
					-- A external link
				Result := a_url			
			end		
		end	

feature {NONE} -- Access

	file_type: STRING is "html"

	attribute_write_position,
	attribute_value_write_position: INTEGER
			-- Position to write attribute and attribute value
	
	url_anchor_write_position: INTEGER
	
	in_url,
	in_url_anchor: BOOLEAN
	
	anchor_content: STRING
	
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
			e_maps: element_element_complex_mappings.has (e) or element_element_mappings.has (e) or single_element_element_mappings.has (e)			
		local
			l_start_tag,
			l_end_tag,
			l_name: STRING
		do		
					-- Determine correct tag formats
			if start then
				l_start_tag := "<"
			else
				l_start_tag := "</"
			end
			
			if single_element_element_mappings.has (e) then
				l_end_tag := "/>"
			else
				l_end_tag := ">"
			end				
			
					-- Extract mapping from appropriate list
			if is_complex then
				l_name := element_element_complex_mappings.item (e)
			else
				l_name := element_element_mappings.item (e)
				if l_name = Void then
					l_name := single_element_element_mappings.item (e)
				end
			end
			
					-- Write value to output
			if not l_name.is_empty then				
				output_string.append (l_start_tag + l_name + l_end_tag)	
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
		local
			l_att: STRING
		do			
			if is_class then
				write_element (span_string, True, False)
				if in_pre_tag then					
					l_att := " class=%"block_" + e + "%""
				else					
					l_att := " class=%"" + e + "%""	
				end
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

	list_type_stack: ARRAYED_STACK [BOOLEAN] is
			-- Stack indicating list type
		once
			create Result.make (1)		
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

	type_value: STRING

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
			end
			Result := rt_output_escaped (Result)
		end

	in_pre_tag: BOOLEAN is
			-- Are we inside a tag which should be treated as a pre tag?
		do
			Result := Previous_elements.has (code_block_string) or previous_elements.has (code_string)
		end

	restore_attribute_value: INTEGER
			-- Value to restore `attribute_value_write_position' to after regaulr attribute processing
	
	title: STRING
			-- Document title
	
end -- class HTML_FILTER
