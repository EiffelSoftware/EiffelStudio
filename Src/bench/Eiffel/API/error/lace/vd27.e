-- Error when root creation procedure name is not valid

class VD27

inherit

	LACE_ERROR

feature

	creation_routine: STRING;

	root_class: CLASS_C;

	set_creation_routine (a_name: STRING) is
		do
			creation_routine := a_name;
		end;

	set_root_class (a_class_c: CLASS_C) is
		do
			root_class := a_class_c;
		end;

	build_explain is
		do
			put_string ("Root class: ");
			root_class.append_clickable_name (error_window);
			put_string ("%NInvalid procedure name: ");
			put_string (creation_routine);
			new_line
		end;

end
