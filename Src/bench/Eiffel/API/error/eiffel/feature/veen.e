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

	build_explain is
			-- Build specific explanation image for current error
			-- in `error_window'.
		do
			put_string ("Identifier: ");
			put_string (identifier);
			new_line;
		end

end
