indexing

	description: 
		"Command to display class routines.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_ROUTINES 

inherit

	E_CLASS_FORMAT_CMD
		rename
			execute as class_execute
		export
			{NONE} class_execute
		end;

	E_CLASS_FORMAT_CMD
		redefine
			execute
		select
			execute
		end

creation

	make, do_nothing

feature -- Access

	criterium (f: E_FEATURE): BOOLEAN is
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

feature -- Execution

	execute is
			-- Display the routines and the invariant of `current_class'. 
		local
			class_f: CLASS_TEXT_FORMATTER
		do
			class_execute;
			!! class_f;
			class_f.set_clickable;
			class_f.format_invariants (current_class);
			if not class_f.error then
				structured_text.append (class_f.text)
			end
		end

end -- class E_SHOW_ROUTINES
