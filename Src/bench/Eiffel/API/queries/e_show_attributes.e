indexing
	description: "Show attributes of a class"
	date: "$Date$";
	revision: "$Revision$"

class E_SHOW_ATTRIBUTES 

inherit
	E_CLASS_FORMAT_CMD

create
	make, do_nothing

feature -- Access

	criterium (f: E_FEATURE): BOOLEAN is
			-- Criterium for feature `f'
		do
				-- Only shows attribute.
			Result := f.is_attribute
		ensure then
			good_criterium: Result = f.is_attribute
		end
	
end -- class E_SHOW_ATTRIBUTES
