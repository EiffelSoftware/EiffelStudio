-- Error for a feature call

class VUAR 

inherit

	FEATURE_ERROR
	
feature 

	feature_i: FEATURE_I;
			-- Feature_i of the involved feature

	set_feature_i (f: FEATURE_I) is
			-- Assign `f' to `feature_i'.
		do
			feature_i := f;
			
		end;

	code: STRING is
			-- Error code
		do
			Result := "VUAR"
		end
end
