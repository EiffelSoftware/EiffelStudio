indexing

	description: 
		"Error when a class name in a target list of an option%
		%clause is not a class of the cluster at hand.";
	date: "$Date$";
	revision: "$Revision $"

class VD16

inherit

	CLASS_ERROR
		redefine
			build_explain
		end

feature -- Property

	node: O_OPTION_SD;
			-- Option node

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			put_cluster_name (st);
			st.add_string ("Option: ");
			st.add_string (node.option.option_name);
			st.add_new_line;
			put_class_name (st);
		end;

feature {O_OPTION_SD} -- Setting

	set_node (n: like node) is
			-- Assign `n' to `node'.
		do
			node := n;
		end;

end -- class VD16
