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

	criterium (f: FEATURE_I): BOOLEAN is
			-- Criterium for feature `f'
		local
			any_class: CLASS_C
		do
			any_class := System.any_class.compiled_class;
			if any_class /= Void then
				Result := any_criterium (f) and f.is_exported_for (any_class)
			end
		ensure then
			good_criterium: Result implies
				System.any_class.compiled_class /= Void and then
					any_criterium (f) and then
					f.is_exported_for ( System.any_class.compiled_class)
		end

end -- class E_SHOW_EXPORTED_ROUTINES
