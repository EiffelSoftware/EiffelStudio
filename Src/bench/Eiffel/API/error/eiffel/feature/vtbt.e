indexing

	description: 
		"";
	date: "$Date$";
	revision: "$Revision $"

class VTBT 

inherit

	FEATURE_ERROR
		redefine
			build_explain
		end;

feature -- Property

	code: STRING is "VTBT";
			-- Error code

	value: INTEGER;

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
		do
			if value < 0 then
				ow.put_string ("Constant: ");
				ow.put_int (value);
				ow.new_line;
			end;
		end;

feature {COMPILER_EXPORTER}

	set_value (i: INTEGER) is
		do
			value := i;
		end;

end -- class VTBT
