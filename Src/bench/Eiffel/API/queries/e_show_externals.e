indexing

	description: 
		"Command to display class externals of `current_class'.";
	date: "$Date$";
	revision: "$Revision $"


class E_SHOW_EXTERNALS 

inherit

	E_CLASS_FORMAT_CMD

creation

	make, do_nothing

feature -- Access

	criterium (f: E_FEATURE): BOOLEAN is
			-- Criterium for feature `f'
		do
			Result := any_criterium (f);
			Result := Result and then f.is_external
		ensure then
			good_criterium: Result implies any_criterium (f) and then
							f.is_external
		end

end -- class E_SHOW_EXTERNALS
