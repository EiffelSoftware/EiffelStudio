indexing

	description: 
		"Error when the root class is in two different clusters%
		%and none of them is specified in the ace file";
	date: "$Date$";
	revision: "$Revision $"

class VD29

inherit

	CLUSTER_ERROR

feature -- Property

	second_cluster_name: STRING;

	root_class_name: STRING;

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Class name: ");
			ow.put_string (root_class_name);
			ow.put_string ("%NFirst cluster: ");
			ow.put_string (cluster.cluster_name);
			ow.put_string ("%NSecond cluster: ");
			ow.put_string (second_cluster_name);
			ow.new_line
		end;

feature {ROOT_SD} -- Setting

	set_second_cluster_name (s: STRING) is
		do
			second_cluster_name := s;
		end;

	set_root_class_name (s: STRING) is
		do
			root_class_name := s;
		end;

end -- class VD29
