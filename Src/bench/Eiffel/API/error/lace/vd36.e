-- Error for using system level options in cluster adaptation

class VD36

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
			ow.put_string ("Option name: ");
			ow.put_string (option_name);
			ow.new_line;
		end;

end
