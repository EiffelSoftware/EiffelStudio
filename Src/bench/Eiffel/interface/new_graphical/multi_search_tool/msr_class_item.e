indexing
	description: "Objects that represent classes found in text or non-class section of text"
	date: "$Date$"
	revision: "$Revision$"

class
	MSR_CLASS_ITEM

inherit
	MSR_ITEM
		rename
			make as make_item
		end 
		
create
	make

feature {NONE} -- Initialization
	
	make (a_name: like class_name; a_path: like path; a_text: MSR_STRING_ADAPTER) is
			-- Initialization, set `context_text_internal' and `text_internal' with "-"	
		require	
			name_attached: a_name /= Void
			not_name_is_empty: not a_name.is_empty
			path_attached: a_path /= Void
			text_attached: a_text /= Void
		do
			make_item (a_name, a_path, a_text)
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

		
end -- class MSR_CLASS_ITEM
