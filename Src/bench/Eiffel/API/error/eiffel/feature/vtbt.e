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

	build_explain is
		do
			if value < 0 then
				put_string ("Constant: ");
				put_int (value);
				new_line;
			end;
		end;

end 
