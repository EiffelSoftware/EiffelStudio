-- Error for variant loop of bad type

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

	build_explain is
		do
			put_string ("Expression type: ");
			type.append_clickable_signature (error_window);
			new_line;
		end;

end
