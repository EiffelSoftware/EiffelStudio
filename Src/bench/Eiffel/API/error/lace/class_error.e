indexing

	description: 
		"Error for a class in a cluster.";
	date: "$Date$";
	revision: "$Revision $"

class CLASS_ERROR

inherit

	CLUSTER_ERROR

feature -- Properties

	class_name: STRING;
			-- Class nam involved

feature -- Output

	put_class_name (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Class name: ");
			ow.put_string (class_name);
			ow.new_line;
		end;

	build_explain (ow: OUTPUT_WINDOW) is
		do
			put_cluster_name (ow);
			put_class_name (ow);
		end;

feature {AST_LACE, COMPILER_EXPORTER} -- Setting

	set_class_name (s: STRING) is
			-- Assign `s' to `class_name'.
		do
			class_name := s;
		end;

end -- class CLASS_ERROR
