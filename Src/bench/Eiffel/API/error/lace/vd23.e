-- No basic class in cluster

class VD23

inherit

	LACE_ERROR

feature

	class_name: STRING;
			-- Class nam involved

	set_class_name (s: STRING) is
			-- Assign `s' to `class_name'.
		do
			class_name := s;
		end;

	build_explain is
		do
			put_string ("Class name: ");
			put_string (class_name);
			new_line;
		end;

end
