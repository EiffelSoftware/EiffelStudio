-- Error when root class name is invalid

class VD30

inherit

	LACE_ERROR
		redefine
			build_explain
		end;

feature

	root_class_name: STRING;
			-- Invalid root class name

	set_root_class_name (s: STRING) is
			-- Assign `s' to `root_class_name'.
		do
			root_class_name := s;
		end;

	build_explain is
		do
			put_string ("Root class name: `");
			put_string (root_class_name);
			put_char ('%'');
			new_line
		end;

end
