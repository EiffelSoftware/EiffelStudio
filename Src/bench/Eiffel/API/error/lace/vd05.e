-- Error when adaptation of a cluster contains a paragraph about itself

class VD05

inherit

	VD03
		redefine
			build_explain
		end;

feature

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Cluster name: ");
			ow.put_string (cluster_name);
			ow.new_line
		end;

end
