-- Error when an external is redefined into a non-external feature or
-- when a non-external one is redefined into an external feature

class VE01 obsolete "NOT DEFINED IN THE BOOK"

inherit

	FEATURE_ERROR
		redefine
			build_explain, subcode
		end;

feature

	old_feature: FEATURE_I;
			-- Features involved in the error

	set_old_feature (f: FEATURE_I) is
			-- Assign `f' to `feature2'.
		do
			old_feature := f;
		end;

	code: STRING is "VDRD";
			-- Error code

	subcode: INTEGER is 7

	build_explain is
		local
			wclass: CLASS_C
		do
			wclass := old_feature.written_class;
			put_string ("Redeclared routine: ");
			old_feature.append_clickable_name (error_window, wclass);
			put_string (" from ");
			wclass.append_clickable_name (error_window);
			if old_feature.is_external then
				put_string (" is an external routine%N")
			else
				put_string (" is not an external routine%N")
			end;
		end;

end
