
indexing

	description: 
		"";
	date: "$Date$";
	revision: "$Revision $"


class E_SHOW_ATTRIBUTES 

inherit

	E_CLASS_FORMAT_CMD

creation

	make, do_nothing

feature -- Access

	criterium (f: E_FEATURE): BOOLEAN is
			-- Criterium for feature `f'
		do
				-- Only shows attribute. If an attribute is of type NONE
				-- like `Void' in ANY we do not show them.
			Result := f.is_attribute and not f.type.is_none
		ensure then
			good_criterium: Result = f.is_attribute	and not f.type.is_none
		end
	
end -- class E_SHOW_ATTRIBUTES
