indexing

	description: 
		"Command to display once routines of `current_class'.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_ONCES

inherit

	E_CLASS_FORMAT_CMD
		redefine
			display_feature
		end

creation

	make, do_nothing

feature -- Access

	criterium (f: FEATURE_I): BOOLEAN is
		do
			Result := any_criterium (f);
			Result := Result and then (f.is_once or else
							f.is_constant)
		end;

feature -- Output

	display_feature (f: FEATURE_I; c: CLASS_C) is
		local
			const: CONSTANT_I
		do
			f.append_clickable_signature (output_window, c);
			if f.is_constant then
				output_window.put_string (" is ");
				const ?= f;	--| Cannot fail
				if const.is_unique then
					output_window.put_string ("unique (");
					const.value.append_clickable_signature (output_window);
					output_window.put_char (')')
				else
					const.value.append_clickable_signature (output_window);
				end
			end
		end;

end -- class E_SHOW_ONCES
