-- Error for class violating the expanded client rule

class VLEC 

inherit

	EIFFEL_ERROR
		redefine
			build_explain
		end;

feature 

	client: CLASS_C;
			-- Unvalid class type

	code: STRING is "VLEC";
			-- Error code

	set_client (c: CLASS_C) is
		do
			client := c;
		end;

	build_explain is
		do
			put_string ("Name of class involved in cycle: ");
			client.append_clickable_name (error_window);
			new_line;
		end;

end
