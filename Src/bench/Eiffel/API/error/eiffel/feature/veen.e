-- Error for undeclared identifier

class VEEN 

inherit

	FEATURE_ERROR
		redefine
			build_explain
		end
	
feature 

	identifier: STRING;
			-- Undeclared identifier

	set_identifier (i: STRING) is
			-- Assign `i' to `identifier'.
		do
			identifier := i;
		end;

	code: STRING is "VEEN";
			-- Error code

	build_explain (ow: OUTPUT_WINDOW) is
			-- Build specific explanation image for current error
			-- in `ow'.
		do
			ow.put_string ("Identifier: ");
			ow.put_string (identifier);
			ow.new_line;
		end

end
