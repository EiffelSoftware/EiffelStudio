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

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Root class: ");
			root_class.append_name (ow);
			ow.put_string ("%NInvalid procedure name: ");
			ow.put_string (creation_routine);
			ow.new_line
		end;

end
