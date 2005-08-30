indexing

	description: 
		"Command to display class externals of `current_class'.";
	date: "$Date$";
	revision: "$Revision $"


class E_SHOW_EXTERNALS 

inherit

	E_CLASS_FORMAT_CMD

create
	make, default_create

feature -- Access

	criterium (f: E_FEATURE): BOOLEAN is
			-- Criterium for feature `f'
		do
			Result := f.is_external
		ensure then
			good_criterium: Result = f.is_external
		end

end -- class E_SHOW_EXTERNALS
