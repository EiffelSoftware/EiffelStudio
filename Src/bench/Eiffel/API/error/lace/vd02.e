indexing

	description: 
		"Error when a use file of a cluster does not exist.";
	date: "$Date$";
	revision: "$Revision $"

class VD02

inherit

	CLUSTER_ERROR

feature -- Property

	use_name: STRING;
			-- Class name

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
		do
			put_cluster_name (ow);
			ow.put_string ("File name: ");
			ow.put_string (use_name);
			ow.new_line;
		end;

feature {CLUST_PROP_SD} -- Setting

	set_use_name (s: STRING) is
			-- Assign `s' to `use_name'.
		do
			use_name := s;
		end;

end -- class VD02
