-- Error when root class name is unvalid

class VD30

inherit

	ERROR
		redefine
			build_explain
		end;

feature

	root_class_name: STRING;
			-- Unvalid root class name

	set_root_class_name (s: STRING) is
			-- Assign `s' to `root_class_name'.
		do
			root_class_name := s;
		end;

	code: STRING is "VD30";
			-- Error code

	build_explain (a_clickable: CLICK_WINDOW) is
		do
			a_clickable.put_string ("%TThe root class ");
			a_clickable.put_string (root_class_name);
			a_clickable.put_string (" cannot be found in the system");
			a_clickable.new_line;
		end;

end
