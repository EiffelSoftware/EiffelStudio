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

	criterium (f: E_FEATURE): BOOLEAN is
		do
			Result := any_criterium (f);
			Result := Result and then (f.is_once or else
							f.is_constant)
		end;

feature -- Output

	display_feature (f: E_FEATURE; c: E_CLASS) is
		local
			const: E_CONSTANT;
			ec: E_CLASS;
			str: STRING
		do
			f.append_clickable_signature (output_window, c);
			if f.is_constant then
				output_window.put_string (" is ");
				const ?= f;	--| Cannot fail
				ec := const.type.associated_eclass;
				if equal (ec.name, "character") then
					str := "%""
				elseif equal (ec.name, "string") then
					str := "'"
				else
					str := ""
				end;
				if const.is_unique then
					output_window.put_string ("unique (");
					output_window.put_string (str);
					output_window.put_string (const.value);
					output_window.put_string (str);
					output_window.put_char (')')
				else
					output_window.put_string (str);
					output_window.put_string (const.value);
					output_window.put_string (str);
				end
			end
		end;

end -- class E_SHOW_ONCES
