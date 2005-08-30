indexing
	description: "Command to display class routines."
	date: "$Date$"
	revision: "$Revision$"

class E_SHOW_ROUTINES 

inherit
	E_CLASS_FORMAT_CMD

create
	make, default_create

feature -- Access

	criterium (f: E_FEATURE): BOOLEAN is
			-- Criterium for feature `f'
		do
			Result := not f.is_attribute and not f.is_constant
		ensure then
			good_criterium: Result = (not f.is_attribute and not f.is_constant)
		end

end -- class E_SHOW_ROUTINES
