-- Error on type of a constant feature

class VQMC 

inherit

	EIFFEL_ERROR
		redefine
			build_explain
		end;

feature 

	feature_name: STRING;
			-- Constant name
			-- [Note that the class id where the constant is written is
			-- `class_id'.]

	set_feature_name (i: STRING) is
			-- Assign `i' to `feature_name'.
		do
			feature_name := i;
		end;

	code: STRING is "VQMC";
			-- Error code

	build_explain is
		do
			put_string ("Constant name: ");
			put_string (feature_name);
			new_line;
		end;

end
