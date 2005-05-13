indexing
	description: "Document content filter.  Filter DOCUMENTs based%
		%on content tags, does not alter actual content structure."
	date: "$Date$"
	revision: "$Revision$"

class
	OUTPUT_FILTER
	
inherit
	DOCUMENT_FILTER	
		rename
			make as make_basic_filter
		redefine			
			on_start_tag,
			on_end_tag,
			on_attribute,
			on_content		
		end
		
	OUTPUT_CONSTANTS

create
	make,
	make_with_default_flag
	
feature -- Creation

	make (a_description: STRING) is
				-- Create with description
		require			
			description_not_void: a_description /= Void
		do
			make_basic_filter
			create output_flags.make (1)
			output_flags.compare_objects
			description := a_description
			set_color ((create {EV_STOCK_COLORS}).white)
			can_output_stack.wipe_out
			can_output_stack.extend (True)
		ensure
			has_description: description /= Void
		end

	make_with_default_flag (a_output_flag, a_description: STRING) is
				-- Create with initial output flag and description
		require			
			flag_not_void: a_output_flag /= Void
			description_not_void: a_description /= Void
		do
			make_basic_filter
			make (a_description)
			add_output_flag (unfiltered_flag)
			if not a_output_flag.is_empty then
				add_output_flag (a_output_flag)				
			end
			primary_output_flag := a_output_flag
		ensure
			has_description: description /= Void
		end	
		
feature -- Access	

	primary_output_flag: STRING
			-- Primary output flag

	output_flags: ARRAYED_LIST [STRING]
			-- Output determinants

	color: EV_COLOR
			-- Display color, if any		

feature -- Query

	highlighting_enabled: BOOLEAN
			-- Is highlighting enabled?

feature -- Status Setting

	add_output_flag (a_flag: STRING) is
			-- Add new output flag
		require
			flag_not_void: a_flag /= Void
			flag_not_empty: not a_flag.is_empty
		do
			if not output_flags.has (a_flag) then
				output_flags.extend (a_flag)
			end
		end	
		
	set_color (a_color: EV_COLOR) is
			-- Set the display color
		require
			color_not_void: a_color /= Void
		do
			color := a_color
		ensure
			color_set: color = a_color
		end		

	enable_highlighting (a_flag: BOOLEAN) is
			-- Set `highlighting_enabled'
		do
			highlighting_enabled := a_flag
		ensure
			highlighting_set: highlighting_enabled = a_flag
		end
	
	set_primary_output_flag (a_flag: STRING) is
			-- Set `primary_output_flag '
		require
			flag_not_void: a_flag /= Void
		do
			primary_output_flag := a_flag
		ensure
			primary_output_flag_set: primary_output_flag = a_flag
		end	

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
		local
			l_content: STRING
		do
			if can_output then
				l_content := rt_output_escaped (a_content)
				output_string.append (l_content)
			end			
		end

feature -- Processing

	process_element (e: STRING; is_start: BOOLEAN) is
			-- Process element `e'
		require
			e_not_void: e/= Void
		do			
			last := e			
		
			if filterable_elements.has (e) then
				last_was_filterable := True					
				last_was_start := is_start
				if is_start then
					filter_depth := filter_depth + 1				
				else
					if can_output then				
						write_tag (e, is_start)
					end
					filter_depth := filter_depth - 1
					can_output_stack.go_i_th (can_output_stack.count)
					can_output_stack.remove
				end
			else
				if can_output then
					write_tag (e, is_start)
				end
				last_was_filterable := False
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
				if a_name.is_equal ("output") and then (output_flags.has (a_value)) then
					can_output_stack.extend (can_output_stack.i_th (can_output_stack.count))
				elseif last_was_filterable and a_name.is_equal ("output") and then not (output_flags.has (a_value)) then					
					can_output_stack.extend (False)
				end
			end
			
			if can_output then
				if last_was_filterable then
					write_tag (last, last_was_start)
				end
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

	last_was_filterable: BOOLEAN
			-- Was last element a filterable one?
		
	last_was_start: BOOLEAN
			-- Was last processed element a start element?

	last: STRING
			-- Last element name			

	can_output_stack: ARRAYED_LIST [BOOLEAN] is
			-- Can current node be output stack
		once
			create Result.make (1)
			Result.extend (True)
		end

	can_output: BOOLEAN is
			-- Can current node be output?	
		do
			Result := can_output_stack.i_th (can_output_stack.count)
		end

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
		end		

	write_tag (e: STRING; is_start: BOOLEAN) is
			-- Write tag
		local
			l_start_tag: STRING
		do
			if is_start then
				l_start_tag := "<"
			else
				l_start_tag := "</"
			end
			output_string.append (l_start_tag + e + ">")
			attribute_write_position := output_string.count
		end		

invariant
	has_description: description /= Void
	has_color: color /= Void

end -- class STUDIO_FILTER
