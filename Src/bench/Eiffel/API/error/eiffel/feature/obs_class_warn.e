-- Warning for obsolete features  

class OBS_CLASS_WARN

inherit

	WARNING
		redefine
			build_explain
		end;

feature

	associated_class: CLASS_C;
			-- Class using the obsolete class

	obsolete_class: CLASS_C;
			-- Obsolete class

	set_class (c: CLASS_C) is
		do
			associated_class := c
		end;

	set_obsolete_class (c: CLASS_C) is
		do
			obsolete_class := c
		end;

	code: STRING is
			-- Error code
		do
			Result := "Obsolete";
		end;

	build_explain (a_clickable: CLICK_WINDOW) is
		do
			a_clickable.put_string ("%Tin class ");
			associated_class.append_clickable_name (a_clickable);
			a_clickable.put_string ("%T");
			obsolete_class.append_clickable_name (a_clickable);
			a_clickable.put_string (" is obsolete:%N%T");
			a_clickable.put_string (obsolete_class.obsolete_message);
			a_clickable.new_line;
		end;

end
