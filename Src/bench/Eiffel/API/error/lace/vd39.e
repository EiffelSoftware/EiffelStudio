indexing

	description: 
		"Error for empty target list in cluster option.";
	date: "$Date$";
	revision: "$Revision $"

class VD39

inherit

	CLUSTER_ERROR

feature -- Property

	option_name: STRING;

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			put_cluster_name (st);
			st.add_string ("Option: ");
			st.add_string (option_name);
			st.add_new_line
		end;

feature {O_OPTION_SD} -- Setting

	set_option_name (s: STRING) is
		do
			option_name := s;
		end;

end -- class VD39
