indexing

	description: 
		"Error in a file in a cluster.";
	date: "$Date$";
	revision: "$Revision $"

class FILE_ERROR

inherit

	CLUSTER_ERROR
		redefine
			file_name
		end

feature -- Property

	file_name: STRING;
			-- File name involved

feature -- Output

	put_file_name (st: STRUCTURED_TEXT) is
		do
			st.add_string ("File name: ");
			st.add_string (file_name);
			st.add_new_line;
		end;

	build_explain (st: STRUCTURED_TEXT) is
		do
			put_cluster_name (st);
			put_file_name (st);
		end;

feature {AST_LACE, COMPILER_EXPORTER} -- Setting

	set_file_name (s: STRING) is
			-- Assign `s' to `file_name'.
		do
			file_name := s;
		end;

end -- class FILE_ERROR
