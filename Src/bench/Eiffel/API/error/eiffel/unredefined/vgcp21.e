-- Error when a creation procedure is not a procedure or a once procedure

class VGCP21 

inherit

	VGCP1
	
feature

	creation_feature: FEATURE_I;
			-- Feature involved

	set_creation_feature (f: FEATURE_I) is
			-- Assign `f' to `creation_feature'.
		do
			creation_feature := f;
		end;

end
