indexing

	description: 
		"Error for undeclared identifier.";
	date: "$Date$";
	revision: "$Revision $"

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

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation image for current error
			-- in `st'.
		do
			st.add_string ("Identifier: ");
			st.add_string (identifier);
			st.add_new_line;
		end

end -- class VEEN
