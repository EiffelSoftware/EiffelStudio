indexing
	description: "Pretty formatter for XML, applying indenting."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XM_PRETTY_FORMATTER

inherit
	XM_PRETTY_PRINT_FILTER
		redefine
			on_start_tag,
			on_end_tag,
			on_content
		end

feature -- Status Setting

	format (a_string: STRING) is
			-- Format `a_string'
		require
			string_not_void: a_string /= Void
		do			
			make_null
			set_output_string (a_string)
			Elements.wipe_out
			Ignore_stack.wipe_out
		end	

feature -- Tag

	on_start_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
			-- Print start of start tag.
		do
			Elements.extend (a_local_part)
			prev_was_end := False
			curr_has_content := False
			if not in_ignore_element then
				output_formatting_text
			end	
			if ignorable_elements.has (a_local_part) then				
				Ignore_stack.extend (a_local_part)				
			end											
			Precursor (a_namespace, a_prefix, a_local_part)
		end

	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
			-- Print end tag.
		do			
			if prev_was_end and not in_ignore_element then
				output_formatting_text
			end
			if in_ignore_element and then Ignore_stack.item.is_equal (a_local_part) then
				Ignore_stack.remove
			end
			Elements.remove
			prev_was_end := True
			if curr_has_content then				
				Precursor (a_namespace, a_prefix, a_local_part)
			else
				last_output.insert_character ('/', last_output.count)
			end
			curr_has_content := True
		end

	on_content (a_content: STRING) is
			-- Text content.
		local
			l_content: STRING
		do
			l_content := a_content
			if not in_ignore_element then
				l_content.replace_substring_all ("%T", "")
				l_content.replace_substring_all ("%N", "")
				if not curr_has_content then
					curr_has_content := not l_content.is_empty
				end
			else
				if l_content.is_empty then
					l_content := new_line
				end
				curr_has_content := True
			end
			Precursor (l_content)			
		end

feature {NONE} -- Implementation

	output_formatting_text is
			-- Output the format characters based on current state
		do
			if Elements.count > 1 and not in_ignore_element then
				output (new_line)
			end
			output (tab_string)
		end

	prev_was_end: BOOLEAN
			-- Was last tag an ending tag?		
			
	curr_has_content: BOOLEAN
			-- Does current tag contain any content?  Content here denotes either text or elements
			-- and therefore indicates if end tag should be <a_tag/> or </a_tag>

	tab_string: STRING is
			-- Tab string
		local
			cnt: INTEGER
		do
			from
				cnt := 2
				create Result.make_empty
			until
				cnt > Elements.count		
			loop
				Result.append_character (Tab_char)
				cnt := cnt + 1
			end
		end		

	new_line: STRING is
			-- Newline character
		once
			create Result.make_empty
			Result.append_character (Lf_char)
		end	

	elements: ARRAYED_STACK [STRING] is
			-- Elements
		once
			create Result.make (1)
			Result.compare_objects
		end		

	ignore_stack: ARRAYED_STACK [STRING] is
			-- Ignore stack
		once
			create Result.make (1)
			Result.compare_objects
		end		
		
	in_ignore_element: BOOLEAN is
			-- Should we be ignoring element?
		do
			Result := not ignore_stack.is_empty			
		end
		
	ignorable_elements: ARRAYED_LIST [STRING] is
			-- Element which can be ignored during formatting
		once
			create Result.make (1)
			Result.compare_objects
			Result.extend ("code_block")
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
end -- class XM_PRETTY_FORMATTER
