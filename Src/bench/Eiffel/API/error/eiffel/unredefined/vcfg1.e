-- Error for a formal generic name as a class name in the surrounding
-- universe.

class VCFG1 

inherit

	EIFFEL_ERROR
		redefine
			subcode, build_explain
		end;

feature 

	code: STRING is "VCFG";
			-- Error code

	subcode: INTEGER is
		do
			Result := 1;
		end;

	formal_name: STRING;
			-- Formal generic name

	set_formal_name (s: STRING) is
			-- Assign `s' to `formal_name'.
		do
			formal_name := s;
		end;

	build_explain (ow: OUTPUT_WINDOW) is
		do
			if formal_name /= Void then
				ow.put_string ("Parameter name: ");
				ow.put_string (formal_name);
				ow.new_line;
			end;
		end;

end
