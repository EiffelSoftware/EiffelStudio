indexing
	description: "Content filter.  Use directly to retrieve unfiltered%
		%content, use/create descendents for content specific output."
	date: "$Date$"
	revision: "$Revision$"

class
	OUTPUT_FILTER
	
inherit
	DOCUMENT_FILTER	
		rename
			make as make_basic_filter
		redefine			
			description,	
			on_start_tag,
			on_end_tag,
			on_attribute,
			on_content		
		end
		
	OUTPUT_CONSTANTS

create
	make	
	
feature -- Creation

	make (a_id: INTEGER; a_output_flag: STRING) is
				-- Create with `a_id'
		require			
			flag_not_void: a_output_flag /= Void
		do
			make_basic_filter (a_id)
			output_flag := a_output_flag
		end	
		
feature -- Access	

	description: STRING is
			-- Textual description of filter
		do
			Result := unfiltered
		end

	output_flag: STRING
			-- Output determinant

feature -- Tag

	on_start_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
			-- Start of tag.
		do
			process_element (a_local_part, True)
		end
		
	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
			-- End of tag.
		do			
			process_element (a_local_part, False)
		end	
		
	on_attribute (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING; a_value: STRING) is
			-- Attribute
		do
			process_attribute (a_local_part, a_value)
		end
		
	on_content (a_content: STRING) is
			-- Forward content.
		do			
			if can_output then
				output_string.append (a_content)
			end			
		end

feature -- Processing

	process_element (e: STRING; is_start: BOOLEAN) is
			-- Process element `e'
		require
			e_not_void: e/= Void
		local
			l_start_tag: STRING
		do			
			if not in_filterable_element then
				can_output := True
			end
		
			if filterable_elements.has (e) then
					-- This is a output tag.  Output is disabled because we don't want
					-- to actually output the output tag in the document
				can_output := False
				if is_start then
					filter_depth := filter_depth + 1				
				else
					filter_depth := filter_depth - 1
				end			
			end
			
			if can_output then
				if is_start then
					l_start_tag := "<"
				else
					l_start_tag := "</"
				end
				output_string.append (l_start_tag + e + ">")
				attribute_write_position := output_string.count
			end
		end

	process_attribute (a_name, a_value: STRING) is
			-- Process attribute
		require
			name_not_void: a_name /= Void
			value_not_void: a_value /= Void
		local
			l_string: STRING
		do
					-- Determine if current is in filterable mode
			if in_filterable_element then
				if a_name.is_equal ("output") and then (a_value.is_equal (output_flag) or output_flag.is_empty) then
					can_output := True
				end
			elseif can_output then							
				l_string := " " + a_name + "=%"" + a_value + "%""
				output_string.insert_string (l_string, attribute_write_position)
				attribute_write_position := output_string.count
			end		
		end	

feature {NONE} -- Implementation

	in_filterable_element: BOOLEAN is
			-- Is current parsing inside a filterable element tag?
		do
			Result := filter_depth > 0
		end

	can_output: BOOLEAN
			-- Can current node be output?	

	attribute_write_position: INTEGER
			-- Index position to write attribute at in `output_string'	

	filter_depth: INTEGER
			-- Depth of filtering

	filterable_elements: ARRAYED_LIST [STRING] is
			-- Filterable element names
		once
			create Result.make (1)
			Result.compare_objects
			Result.extend ("output")
--			Result.extend ("document")
		end		

end -- class STUDIO_FILTER
