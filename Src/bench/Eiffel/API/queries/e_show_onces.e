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

	display_feature (f: E_FEATURE; st: STRUCTURED_TEXT) is
		local
			const: E_CONSTANT;
			ec: CLASS_C;
			str: STRING
		do
			f.append_signature (st);
			if f.is_constant then
				st.add_string (" is ");
				const ?= f;	--| Cannot fail
				ec := const.type.associated_class;
				if equal (ec.name, "character") then
					str := "'"
				elseif equal (ec.name, "string") then
					str := "%""
				else
					str := ""
				end;
				if const.is_unique then
					st.add_string ("unique (");
					st.add_string (str);
					st.add_string (const.value);
					st.add_string (str);
					st.add_char (')')
				else
					st.add_string (str);
					st.add_string (const.value);
					st.add_string (str);
				end
			end
		end;

end -- class E_SHOW_ONCES
