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

	build_explain (ow: OUTPUT_WINDOW) is
		do
			put_cluster_name (ow);
			ow.put_string ("File name: ");
			ow.put_string (use_name);
			ow.new_line;
		end;

end
