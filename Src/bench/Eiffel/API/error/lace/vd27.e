-- Error when root creation routine name is not valid

class VD27

inherit

	ERROR
		redefine
			build_explain
		end;

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

	code: STRING is "VD27";

	build_explain (a_clickable: CLICK_WINDOW) is
		do
			a_clickable.put_string ("There is no creation routine called ");
			a_clickable.put_string (creation_routine);
			a_clickable.put_string (" in the root class (");
			root_class.append_clickable_name (a_clickable);
			a_clickable.put_string (")%N");
		end;

end

