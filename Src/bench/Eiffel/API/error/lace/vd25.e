-- Error when a class name in the visible paragraph is not valid

class VD25

inherit

	CLUSTER_ERROR

feature

	class_name: ID_SD;
			-- Class nam involved

	node: CLAS_VISI_SD;
			-- Visible node

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

	code: STRING is "VD25";
			-- Error code

end
