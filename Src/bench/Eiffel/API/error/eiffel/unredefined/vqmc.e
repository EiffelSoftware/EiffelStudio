indexing

	description: 
		"Error on type of a constant feature.";
	date: "$Date$";
	revision: "$Revision $"

class VQMC 

inherit

	EIFFEL_ERROR
		redefine
			build_explain
		end;

feature -- Properties

	feature_name: STRING;
			-- Constant name
			-- [Note that the class id where the constant is written is
			-- `class_id'.]

	code: STRING is "VQMC";
			-- Error code

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Constant name: ");
			st.add_string (feature_name);
			st.add_new_line;
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_feature_name (i: STRING) is
			-- Assign `i' to `feature_name'.
		do
			feature_name := i;
		end;

end -- class VQMC
