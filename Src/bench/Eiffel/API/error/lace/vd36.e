indexing

	description: 
		"Error for using system level options in cluster adaptation.";
	date: "$Date$";
	revision: "$Revision $"

class VD36

inherit

	CLUSTER_ERROR

feature -- Property

	option_name: STRING;

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			put_cluster_name (st);
			st.add_string ("Option name: ");
			st.add_string (option_name);
			st.add_new_line;
		end;

feature {CLUST_PROP_SD} -- Setting

	set_option_name (s: STRING) is
		do
			option_name := s;
		end;

end -- VD36
