-- Error when a class name in a visible clause is not
-- in the system any more

class VD31

inherit

	CLUSTER_ERROR

feature

	class_name: STRING;
			-- Class name involved

	set_class_name (s: STRING) is
			-- Assign `s' to `class_name'.
		do
			class_name := s;
		end;

	code: STRING is "VD31";
			-- Error code

end
