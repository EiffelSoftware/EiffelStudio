
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
			Result := any_criterium (f);
			Result := Result and f.is_attribute
		ensure then
			good_criterium: Result implies
					any_criterium (f) and then
					f.is_attribute	
		end
	
end -- class E_SHOW_ATTRIBUTES
