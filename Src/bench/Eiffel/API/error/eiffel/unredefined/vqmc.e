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

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Constant name: ");
			ow.put_string (feature_name);
			ow.new_line;
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_feature_name (i: STRING) is
			-- Assign `i' to `feature_name'.
		do
			feature_name := i;
		end;

end -- class VQMC
