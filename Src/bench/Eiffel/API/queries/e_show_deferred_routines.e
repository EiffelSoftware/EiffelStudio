indexing

	description: 
		"Command to display deferred routines of `current_class'.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_DEFERRED_ROUTINES

inherit

	E_CLASS_FORMAT_CMD

creation

	make, do_nothing

feature -- Access

	criterium (f: FEATURE_I): BOOLEAN is
			-- Criterium for feature `f'
		do
			Result := any_criterium (f);
			Result := Result and f.is_deferred
		ensure then
			good_criterium: Result implies
						any_criterium (f) and then f.is_deferred
		end

end -- class E_SHOW_DEFERRED_ROUTINES
