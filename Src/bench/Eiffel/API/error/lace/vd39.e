-- Error for empty target list in cluster option

class VD39

inherit

	CLUSTER_ERROR

feature

	option_name: STRING;

	set_option_name (s: STRING) is
		do
			option_name := s;
		end;

	build_explain (ow: OUTPUT_WINDOW) is
		do
			put_cluster_name (ow);
			ow.put_string ("Option: ");
			ow.put_string (option_name);
			ow.new_line
		end;

end
