class VTBT 

inherit

	FEATURE_ERROR
		redefine
			build_explain
		end;

feature 

	code: STRING is "VTBT";
			-- Error code

	value: INTEGER;

	set_value (i: INTEGER) is
		do
			value := i;
		end;

	build_explain (ow: OUTPUT_WINDOW) is
		do
			if value < 0 then
				ow.put_string ("Constant: ");
				ow.put_int (value);
				ow.new_line;
			end;
		end;

end 
