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

	build_explain is
		do
			put_cluster_name;
			put_string ("Option: ");
			put_string (option_name);
			new_line
		end;

end
