indexing
	description: "Objects that represent classes found in text or non-class section of text"
	date: "$Date$"
	revision: "$Revision$"

class
	MSR_CLASS_ITEM

inherit
	MSR_ITEM
		redefine
			start_index,
			context_text,
			end_index,
			set_text,
			set_start_index_in_context_text,
			make
		end 
		
create
	make

feature {NONE} -- Initialization
	
	make is
			-- Initialization, set `context_text_internal' and `text_internal' with "-"		
		do
			Precursor {MSR_ITEM}
			context_text_internal := "-"
			text_internal := "-"
		end	

feature -- Access
	
	start_index : INTEGER is
			-- 	This property in a class item takes no sense, 1 returned.
		do
			Result := 1
		ensure then
			start_index_equal_one: Result = 1
		end
			
	end_index : INTEGER is
			-- 	This property in a class item takes no sense, 0 returned. 
		do
			Result := 0
		ensure then
			end_index_equal_zero: Result = 0
		end
	
	context_text: STRING is
			-- Found text with surrounding text
		do
			Result := context_text_internal
		end

feature -- Element Change

	set_text (context: STRING) is
			-- Do nothing
		do		
			
		end
		
	set_start_index_in_context_text (p_position: INTEGER) is
			-- Do nothing
		do
			
		end		
	
feature -- Measurement

	count : INTEGER is
			-- Number of searching text in this class item
		do
			Result := child_list_internal.count
		end
	
invariant

	context_text_internal_not_void: context_text_internal /= Void
	text_internal_not_void: text_internal /= Void

end
