-- Error when a class name in a target list of an option clause is not
-- a class of the cluster at hand.

class VD16

inherit

	CLASS_ERROR
		redefine
			build_explain
		end

feature

	node: O_OPTION_SD;
			-- Option node

	set_node (n: like node) is
			-- Assign `n' to `node'.
		do
			node := n;
		end;

	build_explain is
		do
			put_cluster_name;
			put_class_name;
			put_string ("Option: `");
			put_string (node.option.option_name);
			put_char ('%'');
			new_line
		end;
end
