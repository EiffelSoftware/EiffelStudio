-- Error when root class name is unvalid

class VD20

inherit

	CLUSTER_ERROR

feature

	root_class_name: STRING;
			-- Unvalid root class name

	set_root_class_name (s: STRING) is
			-- Assign `s' to `root_class_name'.
		do
			root_class_name := s;
		end;

	code: STRING is "VD20";
			-- Error code

end
