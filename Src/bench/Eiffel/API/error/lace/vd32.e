-- Warning for unknown free option

class VD32

inherit

	ERROR
		redefine
			build_explain
		end;

feature

	code: STRING is "VD32";
			-- Error code

	option_name: STRING;
			-- Option name

	set_option_name (s: STRING) is
			-- Assign `s' to `option_name'
		do
			option_name := s
		end;

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Unknown option: ");
			ow.put_string (option_name);
			ow.new_line;
		end;

end
