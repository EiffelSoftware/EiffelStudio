-- Error when a class name in a target list of an option clause is not
-- valid

class VD16

inherit

	CLUSTER_ERROR

feature

	class_name: ID_SD;
			-- Class name involved

	node: O_OPTION_SD;
			-- Option node

	set_class_name (s: ID_SD) is
			-- Assign `s' to `class_name'.
		do
			class_name := s;
		end;

	set_node (n: like node) is
			-- Assign `n' to `node'.
		do
			node := n;
		end;

	code: STRING is "VD16";
			-- Error code

end
