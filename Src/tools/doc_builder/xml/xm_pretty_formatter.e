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
			tab_string := "%T"
			set_output_string (a_string)
		end		

feature -- Status Setting
	
	set_indent_count (a_tab_count: INTEGER) is
			-- Set current indent count
		require
			valid_count: a_tab_count > 0
		do
			indent_count := a_tab_count
		ensure
			count_set: indent_count = a_tab_count
		end

	set_tab_string (a_string: STRING) is
			-- Set `tab_string'
		require
			string_not_void: a_string /= Void
		do
			tab_string := a_string
		ensure
			tab_set: tab_string = a_string
		end		

feature -- Access

	indent_count: INTEGER
			-- Indent count

	tab_string: STRING
			-- String to use for tab formatting (default: "%T')

feature -- Tag

	on_start_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
			-- Print start of start tag.
		do			
			if root_done then
				output (new_line)
			else
				root_done := True
			end
				
			output (tab_string_value)
			increment_tab_count
			Precursor (a_namespace, a_prefix, a_local_part)
			prev_end := False
		end

	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
			-- Print end tag.
		do				
			decrement_tab_count
			if prev_end then				
				output (new_line)				
				output (tab_string_value)
			end
			Precursor (a_namespace, a_prefix, a_local_part)
			prev_end := True
		end

	on_content (a_content: STRING) is
			-- Text content.
		local
			l_content: STRING
		do
			l_content := a_content
			l_content.replace_substring_all ("%T", "")
			l_content.replace_substring_all ("%N", "")
			if l_content.is_empty then
				Precursor (l_content)
			else
				Precursor (a_content)
			end
		end

feature {NONE} -- Implementation

	tab_string_value: STRING is
			-- Tab string
		local
			cnt: INTEGER
		do
			from
				cnt := 1
				create Result.make_empty
			until
				cnt > indent_count				
			loop
				Result.append (tab_string)
				cnt := cnt + 1
			end
		end		

	increment_tab_count is
			-- Increment tab count
		do
			indent_count := indent_count + 1	
		end		
		
	decrement_tab_count is
			-- Decrement tab count
		do
			indent_count := indent_count - 1	
		end	

	new_line: STRING is
			-- Newline character
		once
			create Result.make_empty
			Result.append_character (Lf_char)
		end	
	
	prev_end: BOOLEAN
			-- Was previous element encountered an end tag
	
	root_done: BOOLEAN
			-- Root node processed

end -- class XM_PRETTY_FORMATTER
