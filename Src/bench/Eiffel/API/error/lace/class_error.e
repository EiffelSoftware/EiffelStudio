-- Error for a class in a cluster

class CLASS_ERROR

inherit

	CLUSTER_ERROR

feature

	class_name: STRING;
			-- Class nam involved

	set_class_name (s: STRING) is
			-- Assign `s' to `class_name'.
		do
			class_name := s;
		end;

	put_class_name is
		do
			put_string ("Class name: `");
			put_string (class_name);
			put_char ('%'');
			new_line;
		end;

	build_explain is
		do
			put_cluster_name;
			put_class_name;
		end;

end
