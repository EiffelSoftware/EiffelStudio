indexing
	description: "Reader of Eiffel XML code file."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_XML_READER

inherit
	DOCUMENT_FILTER
		rename
			make as make_filter
		redefine			
			on_start_tag,
			on_end_tag,
			on_content,
			clear
		end

	CODE_XML_READER_CONSTANTS

	UTILITY_FUNCTIONS

create
	make, make_filter

feature -- Creation

	make (a_file: PLAIN_TEXT_FILE) is
			-- Create
		require
			file_not_void: a_file /= Void
			file_exists: a_file.exists
		do
			clear
			file := a_file			
		end

	clear is
		do
			Precursor {DOCUMENT_FILTER}
			conc_content := Void
			file := Void
		end

feature -- Tag

	on_start_tag (a_namespace, a_prefix, a_local_part: STRING) is
			-- Start tag
		do
			if conc_content /= Void then
				write_content (False)
			end
			element_stack.extend (a_local_part)
			if not root_done then
					-- Determine type of code we are reading
				root_done := True
			else
				process_tag (a_local_part, True)
			end			
		end
		
	on_end_tag (a_namespace, a_prefix, a_local_part: STRING) is
			-- End tag
		do	
			if conc_content /= Void then
				write_content (True)				
			end			
			process_tag (a_local_part, False)
			Element_stack.remove			
			location_replaced := False
		end	
		
	on_content (a_content: STRING) is
			-- Content
		local
			l_start_pos,
			l_end_pos: INTEGER
			l_content,
			l_tag_string: STRING
		do		
			l_content := rt_output_escaped (a_content)
			if conc_content = Void then
				create conc_content.make_from_string (l_content)
				Content_stack.extend (conc_content)
			else
				conc_content.append (l_content)
			end
			
					-- In case this is a location tag replace html tag with 'a' tag.
			if current_tag.is_equal (Location_tag) and then not location_replaced then
				l_start_pos := output_string.last_index_of ('<', output_string.count)
				if l_start_pos > 0 then
					l_tag_string := output_string.substring (l_start_pos, output_string.count)					
					if l_tag_string /= Void and then not l_tag_string.is_empty then
						l_end_pos := l_tag_string.index_of (' ', 1)
						if l_end_pos > 0 then
							l_end_pos := l_end_pos + l_start_pos
							attribute_write_position := attribute_write_position - (l_end_pos - l_start_pos) + 3
							output_string.remove_substring (l_start_pos + 1, l_end_pos - 1)
							output_string.insert_string (Html_anchor_tag + " ", l_start_pos + 1)
						end
					end					
				end
				location_replaced := True
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
				elseif a_tag.is_equal (Location_tag) then
					location_done := True
				end
			end			
		end		

feature {NONE} -- Implementation

	file: PLAIN_TEXT_FILE
			-- File from which XML is being read

	element_stack: ARRAYED_STACK [STRING] is
			-- Stack of element names
		once
			create Result.make (2)
			Result.compare_objects
		end
		
	content_stack: ARRAYED_STACK [STRING] is
			-- Stack of element names
		once
			create Result.make (2)
			Result.compare_objects
		end

	root_done: BOOLEAN
			-- Has root node been read yet?

	conc_content: STRING
			-- Current concatenated content string		
	
	location_replaced: BOOLEAN
	
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
			l_name: STRING
			l_slash_index,
			l_start_pos: INTEGER
			l_next_char: CHARACTER
			l_done: BOOLEAN
		do
			l_name := a_url
			if not (l_name.has_substring ("http://") or l_name.has_substring ("mailto:")) then			
				from
					l_start_pos := 1
				until
					l_done
				loop
					l_slash_index := l_name.index_of ('/', l_start_pos)
					if l_slash_index > 0 then
						l_next_char := l_name.item (l_slash_index + 1)					
						l_start_pos := l_slash_index + 1
						l_done := l_next_char /= '.'
					else
						l_done := True
					end
				end
				
				if l_next_char /= '.' then
					l_slash_index := l_name.index_of ('/', l_start_pos)
					if l_slash_index > 0 then
						l_name.insert_string ("/reference", l_slash_index)
						l_name.prepend ("../")
					end
				end			
				l_name.replace_substring_all (".xml", ".html")
			end
			Result := l_name
		end		
		
	write_content (remove: BOOLEAN) is
			-- Write built content string,  Remove from stack after if `remove', otherwise 
			-- clear for next batch of content.
		local			
			l_url: STRING
		do
			if current_tag.is_equal (Location_tag) then		
				conc_content.replace_substring_all ("%"", "&quot;")
				l_url := parsed_url (conc_content)
				output_string.insert_string (" href=%"" + l_url + "%"", attribute_write_position)				
			elseif current_tag.is_equal (Anchor_tag) then
				conc_content.replace_substring_all ("%"", "&quot;")
				output_string.insert_string (" name=%"" + conc_content + "%"", attribute_write_position)
			elseif not current_tag.is_equal (include_tag) then				
				output_string.append (conc_content)
			end
			
			if remove then
				Content_stack.remove
			else
				Content_stack.item.wipe_out
			end
			
			if Content_stack.is_empty then
				conc_content := Void
			else
				create conc_content.make_empty
				Content_stack.extend (conc_content)
			end
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
end -- class CODE_XML_READER
