-- Error when an external is redefined into a non-external feature or
-- when a non-external one is redefined into an external feature

class VE01 

inherit

	EIFFEL_ERROR
	
feature

	feature1, feature2: FEATURE_I;
			-- Features involved in the error

	set_feature1 (f: FEATURE_I) is
			-- Assign `f' to `feature1'.
		do
			feature1 := f;
		end;

	set_feature2 (f: FEATURE_I) is
			-- Assign `f' to `feature2'.
		do
			feature2 := f;
		end;

	code: STRING is "VE01";
			-- Error code

end
