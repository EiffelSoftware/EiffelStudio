-- Error the feature called after a creation is not a creation procedure

class VGCC5 

inherit

	VGCC
		redefine
			subcode
		end

feature

	subcode: INTEGER is
		do
			Result := 6;
		end;

	creation_feature: FEATURE_I;
			-- Creation feature involved

	set_creation_feature (f: FEATURE_I) is
			-- Assign `f' to `creation_feature'.
		do
			creation_feature := f;
		end;

end
