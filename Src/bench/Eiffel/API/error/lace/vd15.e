-- Error for invalid value for option

class VD15

inherit

	LACE_ERROR
		redefine
			build_explain
		end

feature

	option_name: STRING;

	option_value: STRING;

	set_option_name (s: STRING) is
		do
			option_name := s;
		end;

	set_option_value (s: STRING) is
		do
			option_value := s;
		end;

	build_explain is
		do
			put_string ("Option: ");
			put_string (option_name);
			put_string ("%NInvalid option value: ");
			put_string (option_value);
			new_line
		end;

end
