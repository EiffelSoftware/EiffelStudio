-- Error when adaptation of a cluster contains a paragraph about itself

class VD05

inherit

	VD03
		redefine
			build_explain
		end;

feature

	build_explain is
		do
			put_string ("Cluster name: ");
			put_string (cluster_name);
			new_line
		end;

end
