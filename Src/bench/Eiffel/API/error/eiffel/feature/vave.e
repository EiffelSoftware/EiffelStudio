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

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Expression type: ");
			type.append_to (ow);
			ow.new_line;
		end;

end -- class VAVE
