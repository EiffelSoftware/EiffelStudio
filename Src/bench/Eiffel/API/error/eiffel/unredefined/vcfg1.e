indexing

	description: 
		"Error for a formal generic name as a class name %
		%in the surrounding universe.";
	date: "$Date$";
	revision: "$Revision $"

class VCFG1 

inherit

	EIFFEL_ERROR
		redefine
			subcode, build_explain
		end;

feature -- Properties

	code: STRING is "VCFG";
			-- Error code

	subcode: INTEGER is
		do
			Result := 1;
		end;

	formal_name: STRING;
			-- Formal generic name

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
		do
			if formal_name /= Void then
				ow.put_string ("Parameter name: ");
				ow.put_string (formal_name);
				ow.new_line;
			end;
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_formal_name (s: STRING) is
			-- Assign `s' to `formal_name'.
		do
			formal_name := s;
		end;

end -- class VCFG1
