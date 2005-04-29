indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUG_NATIVE_ARRAY_VALUE

inherit
	ABSTRACT_SPECIAL_VALUE

feature -- Access

	dynamic_class: CLASS_C is
			-- Find corresponding CLASS_C to type represented by `value'.
		once
		end

	dump_value: DUMP_VALUE is
			-- Dump_value corresponding to `Current'.
		do
		end

feature -- Output

	append_type_and_value (st: STRUCTURED_TEXT) is 
		do 
		end;

feature {ABSTRACT_DEBUG_VALUE} -- Output
		
	append_value (st: STRUCTURED_TEXT) is 
			-- Append only the value of Current to `st'.
		do 
		end;
		
feature -- Output	

	children: DS_LIST [ABSTRACT_DEBUG_VALUE] is
			-- List of all sub-items of `Current'. May be void if there are no children.
			-- Generated on demand.
		do
		end

	get_items (a_slice_min, a_slice_max: INTEGER) is
			-- Get Items for attributes
		do
		end

	fill_items (a_slice_min, a_slice_max: INTEGER) is
			-- Get Items for attributes
		do
		end

	string_value: STRING is
		do
		end

end -- class EIFNET_DEBUG_NATIVE_ARRAY_VALUE

