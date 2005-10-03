indexing
	description: "Objects that contain one piece of information of result of search or replace"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MSR_ITEM	

feature {NONE} -- Initialization

	make is
			-- Initialization
		do
			create child_list_internal.make (0)
			start_index_internal := 1
			start_index_internal := 0
			start_index_in_context_text_internal := 1
		end

feature -- Access

	class_name : STRING is
			-- Class name of current.
		require
			is_class_name_set: is_class_name_set
		do
			Result := class_name_internal
		ensure
			class_name_not_void: Result /= Void
		end
	
	text : STRING is
			-- Exact text found
		require
			is_text_set: is_text_set
		do
			Result := text_internal
		ensure
			text_not_void: Result /= Void
		end
		
	start_index : INTEGER is
			-- Start position of `text' in `source_text'
		deferred
		end
	
	end_index : INTEGER is
			-- End position of `text' in `source_text'
		deferred
		end
		
	start_index_in_unix_text : INTEGER is
			-- Start position of `text' in `source_text', '%R' discarded in MSR_TEXT_ITEM
		do
			Result := start_index
		end
	
	end_index_in_unix_text : INTEGER is
			-- End position of `text' in `source_text', '%R' discarded in MSR_TEXT_ITEM
		do
			Result := end_index
		end
		
	start_index_in_context_text : INTEGER is
			-- Start position of `text' in `context_text'
		do
			Result := start_index_in_context_text_internal
		ensure
			start_index_in_context_text: Result = start_index_in_context_text_internal
		end
	
	context_text : STRING is
			-- Text to be presented with surroundings
		require
			is_context_text_set: is_context_text_set
		deferred
		ensure
			context_text_not_void: Result /= Void
		end
	
	path : FILE_NAME is
			-- File path `source_text' locates
		require
			is_path_set: is_path_set
		do
			Result := path_internal
		ensure
			path_internal_not_void: path_internal /= Void
		end
			
	children: ARRAYED_LIST [MSR_ITEM] is
			-- Children of current item
		do
			Result:= child_list_internal
		end
	
	source_text: STRING is
			-- Once searched in this text
		require
			is_source_text_set: is_source_text_set
		do
			Result := source_text_internal.real_string
		ensure
			source_text_not_void: Result /= Void
		end	
		
			
	data: ANY
			-- Any data related to current.

feature -- Status report

	has_child: BOOLEAN is
			-- If the item has children
		do
			Result := (child_list_internal.count > 0)
		ensure
			has_child: Result = (child_list_internal.count > 0)
		end
	
	is_class_name_set: BOOLEAN is
			-- If the class name is set
		do		
			Result := (class_name_internal /= Void)
		ensure
			is_class_name_set: Result = (class_name_internal /= Void)
		end
	
	is_text_set: BOOLEAN is
			-- If `text' is set
		do		
			Result := (text_internal /= Void)
		ensure
			is_text_set : Result = (text_internal /= Void)
		end
	
	is_path_set: BOOLEAN is
			-- If `path' is set
		do		
			Result := (path_internal /= Void)
		ensure
			is_path_set: Result = (path_internal /= Void)
		end
	
	is_context_text_set: BOOLEAN is
			-- If `context' is set
		do
			Result := (context_text_internal /= Void)
		ensure
			is_context_text_set : Result = (context_text_internal /= Void)
		end
		
	is_source_text_set: BOOLEAN is
			-- If `source_text' is set
		do
			Result := (source_text_internal /= Void)
		ensure
			is_source_text_set: Result = (source_text_internal /= Void)
		end

feature -- Element change	
	
	set_class_name (name : STRING) is
			-- Set exactly what class name found for this item
		require
			name_not_void: name /= Void
		do
			class_name_internal := name
		ensure
			class_name_internal_not_void: class_name_internal /= Void
		end
	
	set_text (context : STRING) is
			-- Set what exactly is found
		require
			context_not_void: context /= Void
		do
			text_internal := context
		ensure
			text_internal_not_void: text_internal /= Void
		end
	
	set_path (p_path:FILE_NAME) is
			-- Set the class file path or the path of the string being searched
		require
			p_path_not_void: p_path /= Void
		do
			path_internal := p_path
		ensure
			path_internal_not_void: path_internal /= Void
		end
		
	set_source_text (a_text: MSR_STRING_ADAPTER) is
			-- Set `source_text_internal'
		require
			a_text_not_void: a_text /= Void
		do
			source_text_internal := a_text
		ensure
			source_text_implemetation_not_void: source_text_internal = a_text
		end
		
	set_source_text_real_string (a_string: STRING) is
			-- Set the actual string of `source_text'
		do
			source_text_internal.set_real_string (a_string)
		end		
	
	set_start_index_in_context_text (p_position: INTEGER) is	
			-- Start position in the present context
		require
			p_position_larger_than_zero: p_position > 0
		do
			start_index_in_context_text_internal := p_position
		end
		
	set_data (a_data: ANY) is
			-- set data
		require
			a_data_not_void: a_data /= Void
		do
			data := a_data
		ensure
			data_not_void: data /= Void
		end
		
	
feature {NONE} -- Implementation
	
	class_name_internal: STRING
			-- Class name of the current item
	
	text_internal: STRING
			-- Exact string that has been found in `source_text_internal'
			
	path_internal : FILE_NAME
			-- Path that the `source_text_internal' resides at
			
	start_index_internal : INTEGER
			-- Captured start position of `text_internal' in `source_text_internal'
			
	end_index_internal : INTEGER
			-- Captured end position of finding context in the given text.
			
	context_text_internal : STRING
			-- Text with finding context text surrounded.

	start_index_in_context_text_internal : INTEGER
			-- Start position in the present context
			
	child_list_internal: ARRAYED_LIST [MSR_TEXT_ITEM]
			-- Children, typically text items in a class item or submatches in text items.
			
	source_text_internal: MSR_STRING_ADAPTER
			-- Once searched in this text.

	
invariant

	start_index_in_context_text_internal_than_zero: start_index_in_context_text_internal > 0
	start_index_internal_larger_than_zero: start_index_internal > 0
	end_index_internal_larger_equal_than_zero: end_index_internal >= 0
	child_list_internal_not_void: child_list_internal /= Void

end
