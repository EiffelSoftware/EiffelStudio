-- Error for unvalid type of a unique constant

class VQUI 

inherit

	FEATURE_NAME_ERROR
		redefine
			build_explain
		end;

feature 

	code: STRING is "VQUI";
			-- Error code

	type: TYPE_A;

	set_type (t: TYPE_A) is
		do
			type := t;
		end;

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Type: ");
			type.append_to (ow);
			ow.new_line;
		end;
			
end
