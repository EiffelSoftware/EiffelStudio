indexing

	description: 
		"Error for invalid type of a unique constant.";
	date: "$Date$";
	revision: "$Revision $"

class VQUI 

inherit

	FEATURE_NAME_ERROR
		redefine
			build_explain
		end;

feature -- Properties

	code: STRING is "VQUI";
			-- Error code

	type: TYPE_A;

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Type: ");
			type.append_to (ow);
			ow.new_line;
		end;
			
feature {COMPILER_EXPORTER} -- Setting

	set_type (t: TYPE_A) is
		do
			type := t;
		end;

end
