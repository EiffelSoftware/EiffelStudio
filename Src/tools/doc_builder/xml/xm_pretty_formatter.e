indexing
	description: "Pretty formatter for XML, applying indenting."
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

create
	make
	
feature -- Creation

	make (a_string: STRING) is
			-- Create
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
			if not Ignorable_elements.has (a_local_part) then
				output_formatting_text
			else
				Ignore_stack.extend (a_local_part)
			end						
			Precursor (a_namespace, a_prefix, a_local_part)
		end

	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
			-- Print end tag.
		do			
			if prev_was_end then
				output_formatting_text
			end
			if in_ignore_element and then Ignore_stack.item.is_equal (a_local_part) then
				Ignore_stack.remove
			end
			Elements.remove
			prev_was_end := True
			Precursor (a_namespace, a_prefix, a_local_part)
		end

	on_content (a_content: STRING) is
			-- Text content.
		local
			l_content: STRING
			l_char: CHARACTER
		do
			l_content := a_content
--			if Elements.item.is_equal ("code_block") then
--				if l_content.is_empty then
--					if l_content.area.count > 0 then
--						l_char := l_content.area.item (0)
--						if l_char = Lf_char then
--							l_content := l_char.out
--						end
--					end					
--				end				
--			end			
			if not in_ignore_element then
				l_content.replace_substring_all ("%T", "")
				l_content.replace_substring_all ("%N", "")
			end
			Precursor (l_content)			
		end

feature {NONE} -- Implementation

	output_formatting_text is
			-- Output the format characters based on current state
		do
			if Elements.count > 1 then
				output (new_line)
			end
			output (tab_string)
		end

	prev_was_end: BOOLEAN

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

end -- class XM_PRETTY_FORMATTER
