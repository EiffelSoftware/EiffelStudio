indexing

	description: 
		"Command to display exported features of current_class.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_EXPORTED_ROUTINES 

inherit

	E_CLASS_FORMAT_CMD

creation

	make, do_nothing

feature -- Access

	criterium (f: E_FEATURE): BOOLEAN is
			-- Criterium for feature `f'
		do
			Result := any_criterium (f) and f.is_exported_to (any_class)
		ensure then
			good_criterium: Result implies
					any_criterium (f) and then
					f.is_exported_to (Any_class)
		end

end -- class E_SHOW_EXPORTED_ROUTINES
