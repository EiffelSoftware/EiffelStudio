-- Warning for obsolete features  

class OBS_CLASS_WARN

inherit

	WARNING
		redefine
			build_explain, infix "<"
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

feature 

	code: STRING is
			-- Error code
		do
			Result := "Obsolete";
		end;

	infix "<" (other: like Current): BOOLEAN is
		do
			Result := code < other.code or else
				(code.is_equal (other.code) and then
					associated_class < other.associated_class)
		end;

feature 

	build_explain is
		do
			put_string ("Class: ");
			associated_class.append_clickable_name (error_window);
			put_string ("%NObsolete class: ");
			obsolete_class.append_clickable_name (error_window);
			put_string ("%NObsolete message: ");
			put_string (obsolete_class.obsolete_message);
			new_line;
		end;

end
