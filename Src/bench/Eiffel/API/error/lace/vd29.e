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

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Class name: ");
			st.add_string (root_class_name);
			st.add_string ("%NFirst cluster: ");
			st.add_string (cluster.cluster_name);
			st.add_string ("%NSecond cluster: ");
			st.add_string (second_cluster_name);
			st.add_new_line
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
