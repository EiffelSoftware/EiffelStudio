indexing

	description: 
		"Error for variant loop of bad type.";
	date: "$Date$";
	revision: "$Revision $"

class VAVE 

inherit

	FEATURE_ERROR
		redefine
			build_explain
		end
	
feature 

	code: STRING is "VAVE";
			-- Error code

	type: TYPE_A;

	set_type (t: TYPE_A) is
		do
			type := t;
		end;

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Expression type: ");
			type.append_to (st);
			st.add_new_line;
		end;

end -- class VAVE
