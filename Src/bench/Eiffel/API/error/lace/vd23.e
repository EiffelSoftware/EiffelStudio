-- No basic class in cluster

class VD23

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

	code: STRING is "VD23";
			-- Error code

end
