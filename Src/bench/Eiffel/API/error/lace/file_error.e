indexing

	description: 
		"Error in a file in a cluster.";
	date: "$Date$";
	revision: "$Revision $"

class FILE_ERROR

inherit

	CLUSTER_ERROR

feature -- Property

	file_name: STRING;
			-- File name involved

feature -- Output

	put_file_name (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("File name: ");
			ow.put_string (file_name);
			ow.new_line;
		end;

	build_explain (ow: OUTPUT_WINDOW) is
		do
			put_cluster_name (ow);
			put_file_name (ow);
		end;

feature {AST_LACE, COMPILER_EXPORTER} -- Setting

	set_file_name (s: STRING) is
			-- Assign `s' to `file_name'.
		do
			file_name := s;
		end;

end -- class FILE_ERROR
