-- Warning for obsolete features  

class OBS_CLASS_WARN

inherit

	WARNING
		redefine
			build_explain
		end;

feature

	associated_class: CLASS_C;
			-- feature name

	set_class (c: CLASS_C) is
			-- Assign `s' to `option_name'
		do
			associated_class := c
		end;

	code: STRING is
			-- Error code
		do
			Result := "Warning";
		end;

	build_explain (a_clickable: CLICK_WINDOW) is
		do
			a_clickable.put_string ("%TWarning: ");
			a_clickable.put_string (associated_class.class_name);
			a_clickable.put_string (" is obsolete: ");
			a_clickable.put_string (associated_class.obsolete_message);
			a_clickable.new_line;
		end;

end
