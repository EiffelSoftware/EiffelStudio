-- Error when an external is redefined into a non-external feature or
-- when a non-external one is redefined into an external feature

class VE01 obsolete "NOT DEFINED IN THE BOOK"

inherit

	EIFFEL_ERROR
		redefine
			subcode
		end;

feature

	new_feature, old_feature: FEATURE_I;
			-- Features involved in the error

	set_new_feature (f: FEATURE_I) is
			-- Assign `f' to `feature1'.
		do
			new_feature := f;
		end;

	set_old_feature (f: FEATURE_I) is
			-- Assign `f' to `feature2'.
		do
			old_feature := f;
		end;

	code: STRING is "VDRD";
			-- Error code

	subcode: INTEGER is 7

end
