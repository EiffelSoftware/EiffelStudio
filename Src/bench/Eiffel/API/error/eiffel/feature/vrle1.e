-- Error when a local variable name is a feature name also

class VRLE1 

inherit

	FEATURE_ERROR
		redefine
			build_explain, subcode
		end;

feature 

	code: STRING is "VRLE";
			-- Error code

	subcode: INTEGER is 2;

	build_explain is
		do
			put_string ("%T`");
			feature_i.append_clickable_name (error_window, feature_i.written_class);
			put_string ("' is a feature and cannot be used as a local%N");
		end;

end
