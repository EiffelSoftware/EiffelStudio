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

	build_explain is
		do
			put_string ("Type: ");
			type.append_clickable_signature (error_window);
			new_line;
		end;
			
end
