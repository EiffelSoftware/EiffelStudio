indexing

	description: 
		"Error when adaptation of a cluster contains%
		%a paragraph about itself.";
	date: "$Date$";
	revision: "$Revision $"

class VD05

inherit

	VD03
		redefine
			build_explain
		end;

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Cluster name: ");
			ow.put_string (cluster_name);
			ow.new_line
		end;

end -- class VD05
