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

	build_explain (ow: OUTPUT_WINDOW) is
		do
			put_cluster_name (ow);
			ow.put_string ("Option: ");
			ow.put_string (option_name);
			ow.new_line
		end;

feature {O_OPTION_SD} -- Setting

	set_option_name (s: STRING) is
		do
			option_name := s;
		end;

end -- class VD39
