-- Error when two different basic classes in two clusters

class VD24

inherit

	CLUSTER_ERROR

feature

	other_cluster: CLUSTER_I;
			-- Other cluster involved

	class_name: STRING;
			-- Class name involved

	set_other_cluster (c: CLUSTER_I) is
			-- Assign `c' to `other_cluster'.
		do
			other_cluster := c;
		end;

	set_class_name (s: STRING) is
			-- Assign `s' to `class_name'.
		do
			class_name := s;
		end;

	code: STRING is "VD24";
			-- Error code

end
