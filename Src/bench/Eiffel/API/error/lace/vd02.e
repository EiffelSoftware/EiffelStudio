-- Error when a use file of a cluster does not exist

class VD02

inherit

	CLUSTER_ERROR

feature

	use_name: STRING;
			-- Class name

	set_use_name (s: STRING) is
			-- Assign `s' to `use_name'.
		do
			use_name := s;
		end;

	build_explain is
		do
			put_cluster_name;
			put_string ("File name: ");
			put_string (use_name);
			new_line;
		end;

end
