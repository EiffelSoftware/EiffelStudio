-- error in a file in a cluster

class FILE_ERROR

inherit

	CLUSTER_ERROR

feature

	file_name: STRING;
			-- File name involved

	set_file_name (s: STRING) is
			-- Assign `s' to `file_name'.
		do
			file_name := s;
		end;

	put_file_name is
		do
			put_string ("File name: ");
			put_string (file_name);
			new_line;
		end;

	build_explain is
		do
			put_cluster_name;
			put_file_name;
		end;


end
