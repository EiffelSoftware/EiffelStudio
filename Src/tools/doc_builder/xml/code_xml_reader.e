indexing
	description: "Reader of Eiffel XML code file.  Works by creating code object structures%
		%from xml tags and maintaining state by using stacks to determine the current code%
		%context."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_XML_READER

inherit
	DOCUMENT_FILTER
		rename
			make as make_with_id
		redefine			
			on_start_tag,
			on_end_tag,
			on_content
		end

	CODE_XML_READER_CONSTANTS
	
	SHARED_CONSTANTS

	UTILITY_FUNCTIONS

create
	make

feature -- Creation

	make (a_file: PLAIN_TEXT_FILE) is
			-- Create
		require
			file_not_void: a_file /= Void
			file_exists: a_file.exists
		do
			file := a_file
			make_with_id (1)
		end

feature -- Tag

	on_start_tag (a_namespace, a_prefix, a_local_part: STRING) is
			-- Start tag
		do
			element_stack.extend (a_local_part)
			if not root_done then
					-- Determine type of code we are reading
				root_done := True
				create output_string.make_empty
			else
				process_tag (a_local_part, True)
			end			
		end
		
	on_end_tag (a_namespace, a_prefix, a_local_part: STRING) is
			-- End tag
		do				
			process_tag (a_local_part, False)
			Element_stack.remove
		end	
		
	on_content (a_content: STRING) is
			-- Content
		local
			l_start_pos,
			l_end_pos: INTEGER
			l_tag_string: STRING
			l_content,
			l_url: STRING
		do
			if current_tag.is_equal ("string") then
				l_content := ""
			end
			l_content := a_content			
			if current_tag.is_equal (Location_tag) then
				l_url := parsed_url (a_content)
				output_string.insert_string (" href=%"" + l_url + "%"", attribute_write_position)
				l_start_pos := output_string.last_index_of ('<', output_string.count)
				if l_start_pos > 0 then
					l_tag_string := output_string.substring (l_start_pos, output_string.count)					
					if l_tag_string /= Void and then not l_tag_string.is_empty then
						l_end_pos := l_tag_string.index_of (' ', 1)
						if l_end_pos > 0 then
							l_end_pos := l_end_pos + l_start_pos
							output_string.remove_substring (l_start_pos + 1, l_end_pos - 1)
							output_string.insert_string (Html_anchor_tag + " ", l_start_pos + 1)
						end
					end					
				end
			elseif current_tag.is_equal (Anchor_tag) then
				output_string.insert_string (" name=%"" + l_content + "%"", attribute_write_position)
			elseif not current_tag.is_equal (include_tag) then				
				output_string.append (l_content)
			end
		end

feature {NONE} -- Tag
		
	current_tag: STRING is
			-- Current tag
		do
			Result := element_stack.item
		end
		
	process_tag (a_tag: STRING; is_start: BOOLEAN) is
			-- Process `a_tag'
		require
			tag_not_void: a_tag /= Void
		do			
			if is_start then
				if tags.has (a_tag) then
					write_style_tag (a_tag, is_start)
					attribute_write_position := output_string.count
				elseif a_tag.is_equal (Anchor_tag) then
					output_string.append ("<a>")
					attribute_write_position := output_string.count
				end
			else
				if Tags.has (a_tag) then
					if location_done then
						output_string.append ("</" + Html_anchor_tag + ">")
						location_done := False
					else
						output_string.append ("</span>")
					end
--				elseif a_tag.is_equal (Anchor_tag) then
--					output_string.append ("</a>")
				elseif a_tag.is_equal (Location_tag) then
					location_done := True
				end
			end			
		end		

feature {NONE} -- Implementation

	file: PLAIN_TEXT_FILE
			-- File from which XML is being read

	description: STRING is
			-- Description
		do
			Result := "Eiffel XML code file reader"
		end

	element_stack: ARRAYED_STACK [STRING] is
			-- Stack of element names
		once
			create Result.make (2)
			Result.compare_objects
		end

	root_done: BOOLEAN
			-- Has root node been read yet?
	
	write_style_tag (a_tag_name: STRING; is_start: BOOLEAN) is
			-- Write HTML style tag of `a_tag_name'
		require
			tag_not_void: a_tag_name /= Void
		do
			if is_start then
				output_string.append ("<span class=%"" + a_tag_name + "%">")	
			else
				output_string.append ("</span>")
			end
		end		
	
	attribute_write_position: INTEGER
			-- Position in `output_String' to write attribute
			
	location_done: BOOLEAN		
			
	parsed_url (a_url: STRING): STRING is
			-- Parsed url
		local
			l_name,
			l_anchor: STRING
			l_ref_pos: INTEGER
			l_filename: FILE_NAME
		do
			l_name := file_no_extension (a_url)
			l_name.replace_substring_all ("../", "")
			l_ref_pos := a_url.last_index_of ('#', a_url.count)
			if l_ref_pos > 0 then
				l_anchor := a_url.substring (l_ref_pos, a_url.count)
			else
				l_anchor := ""
			end
			l_ref_pos := l_name.index_of ('/', 1)
			if l_ref_pos > 0 then
				l_name.insert_string ("/reference", l_ref_pos)				
			end
			create l_filename.make_from_string (Application_constants.html_location)
			l_filename.extend ("libraries")
			l_filename.extend (l_name)
			l_filename.add_extension ("html")
			Result := l_filename.string + l_anchor
		end		
			
end -- class CODE_XML_READER
