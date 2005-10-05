indexing
	description: "Objects that contain one piece of information of result of search or replace"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MSR_ITEM	

feature {NONE} -- Initialization

	make (a_name: like class_name; a_path: like path; a_text: MSR_STRING_ADAPTER) is
			-- Initialization
		require
			name_attached: a_name /= Void
			not_name_is_empty: not a_name.is_empty
			path_attached: a_path /= Void
			text_attached: a_text /= Void
		do
			create children_internal.make (0)
			start_index_in_context_text_internal := 1
			
			class_name := a_name
			path := a_path
			source_text_internal := a_text
		ensure
			class_name_set: class_name = a_name
			path_set: path = a_path
			source_text_set: source_text_internal = a_text
		end

feature -- Access

	class_name : STRING
			-- Class name of current

	path : FILE_NAME
			-- File path `source_text' locates
			
	source_text: STRING is
			-- Once searched in this text
		do
			Result := source_text_internal.real_string
		ensure
			source_text_attached: Result /= Void
		end		
			
	data: ANY
			-- Any data related to current		
		
	children: DYNAMIC_LIST [MSR_ITEM] is
			-- Children of current item
		do
			Result := children_internal
		end
		
	date: INTEGER
			-- Date of lastest source text before current made.

feature -- Measurement

	children_count: INTEGER is
			-- Number of child items in `children'
		do
			Result := children_internal.count
		ensure
			children_count_positive: children_count >= 0
			children_count_correct: Result = children.count
		end

feature -- Status report

	has_child: BOOLEAN is
			-- If the item has children
		do
			Result := children_count > 0
		ensure
			has_child: Result = (children_count > 0)
		end

feature -- Element change
	
	set_data (a_data: like data) is
			-- Set `data' with `a_data'.
		do
			data := a_data
		ensure
			data_set: data = a_data
		end
	
	set_date (a_date: INTEGER) is
			-- Set `date' with a_date
		do
			date := a_date
		end
		
	set_source_text_real_string (a_string: STRING) is
			-- Set the actual string of `source_text'.
		require
			a_string_attached: a_string /= Void
			not_a_string_is_empty: not a_string.is_empty
		do
			source_text_internal.set_real_string (a_string)
		ensure
			source_text_set: source_text.is_equal (a_string)
		end		
	
	set_start_index_in_context_text (p_position: INTEGER) is	
			-- Start position in the present context.
		require
			p_position_larger_than_zero: p_position > 0
		do
			start_index_in_context_text_internal := p_position
		end
		
feature {MSR_SEARCH_TEXT_STRATEGY, MSR_SEARCH_CLASS_STRATEGY} -- Element change

	set_children (a_children: like children_internal) is
			-- Set `children' with `a_children'.
		require
			a_children_attached: a_children /= Void
		do
			children_internal := a_children
		ensure
			children_set: children = a_children
		end
	
feature {NONE} -- Implementation

	start_index_in_context_text_internal : INTEGER
			-- Start position in the present context
			
	children_internal: ARRAYED_LIST [MSR_TEXT_ITEM]
			-- Children, typically text items in a class item or submatches in text items
			
	source_text_internal: MSR_STRING_ADAPTER
			-- Once searched in this text.
	
invariant
	start_index_in_context_text_internal_than_zero: start_index_in_context_text_internal > 0
	children_internal_attached: children_internal /= Void

end -- class MSR_ITEM
