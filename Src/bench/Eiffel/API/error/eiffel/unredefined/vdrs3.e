-- Error when a feature name is twice in a redefine clause

class VDRS3 

inherit

	EIFFEL_ERROR
	
feature 

	parent: PARENT_AS;
			-- Parent node

	feature_name: FEATURE_NAME;
			-- Feature name node

	set_parent (p: like parent) is
			-- Assign `p' to `parent'.
		do
			parent := p;
		end;

	set_feature_name (f: like feature_name) is
			-- Assign `f' to `feature_name'.
		do
			feature_name := f;
		end;

	code: STRING is
			-- Error code
		do
			Result := "VDRS";
		end;

end
