-- Error the feature called after a creation is not a creation procedure

class VGCC5 

inherit

	VGCC
	
feature

	creation_feature: FEATURE_I;
			-- Creation feature involved

	set_creation_feature (f: FEATURE_I) is
			-- Assign `f' to `creation_feature'.
		do
			creation_feature := f;
		end;

end
