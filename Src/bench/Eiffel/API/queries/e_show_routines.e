indexing

	description: 
		"Command to display class routines.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_ROUTINES 

inherit

	E_CLASS_FORMAT_CMD

creation

	make, do_nothing

feature -- Access

	criterium (f: FEATURE_I): BOOLEAN is
			-- Criterium for feature `f'
		do
			Result := any_criterium (f);
			Result := Result and (not f.is_attribute);
			Result := Result and (not f.is_constant)
		ensure then
			good_criterium: 
				Result implies any_criterium (f) and then
						not f.is_attribute and then
						not f.is_constant
		end

end -- class E_SHOW_ROUTINES
