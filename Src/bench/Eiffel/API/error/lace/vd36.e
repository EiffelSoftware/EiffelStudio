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

	build_explain (ow: OUTPUT_WINDOW) is
		do
			put_cluster_name (ow);
			ow.put_string ("Option name: ");
			ow.put_string (option_name);
			ow.new_line;
		end;

feature {CLUST_PROP_SD} -- Setting

	set_option_name (s: STRING) is
		do
			option_name := s;
		end;

end -- VD36
