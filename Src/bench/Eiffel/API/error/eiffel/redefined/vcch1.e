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
		local
			wclass: CLASS_C;
		do
			wclass := a_feature.written_class;
			put_string ("Deferred feature: ");
			a_feature.append_clickable_name (error_window, wclass);
			put_string (" From: ");
			wclass.append_clickable_name (error_window);
			new_line;
		end;

end
