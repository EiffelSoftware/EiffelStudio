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

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Option: ");
			ow.put_string (option_name);
			if option_value /= Void then
				ow.put_string ("%NInvalid option value: ");
				ow.put_string (option_value);
				ow.new_line
			else
				ow.put_string ("%NNo option value%N");
			end;
		end;

end
