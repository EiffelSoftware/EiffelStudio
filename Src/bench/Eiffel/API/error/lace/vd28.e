indexing

	description: 
		"Error when two clusters have the same path.";
	date: "$Date$";
	revision: "$Revision $"

class VD28

inherit

	CLUSTER_ERROR

feature -- Property

	second_cluster_name: STRING;

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
		do
			put_cluster_path (ow);
			ow.put_string ("First cluster: ");
			ow.put_string (cluster.cluster_name);
			ow.put_string ("%NSecond cluster: ");
			ow.put_string (second_cluster_name);
			ow.new_line;
		end;

feature {CLUSTER_SD} -- Setting

	set_second_cluster_name (s: STRING) is
		do
			second_cluster_name := s;
		end;

end -- class VD28
