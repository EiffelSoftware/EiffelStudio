-- Error when a non-deferred class has a deferred feature

class VCCH1 

inherit

	EIFFEL_ERROR
		redefine
			build_explain, subcode
		end
	
feature

	a_feature: FEATURE_I;
			-- Deferred feature in non deferred class

	set_a_feature (f: FEATURE_I) is
			-- Assign `f' to `a_feature'.
		do
			a_feature := f;
		end;

	code: STRING is "VCCH";
			-- Error code

	subcode: INTEGER is 1;

	build_explain is
			-- Build specific explanation explain for current error
			-- in `error_window'.
		do
			put_string ("%Tfeature ");
			a_feature.append_clickable_signature (error_window, a_feature.written_class);
			put_string (" written in ");
			a_feature.written_class.append_clickable_name (error_window);
			new_line;
		end;

end
