-- Error when a creation procedure is not a procedure or a once procedure

class VGCP21 

inherit

	VGCP
		redefine
			subcode, build_explain
		end;

feature

	subcode: INTEGER is
		do
			Result := 2;
		end;

	creation_feature: FEATURE_I;
			-- Feature involved

	set_feature (f: FEATURE_I) is
			-- Assign `f' to `creation_feature'.
		do
			creation_feature := f;
		end;

	build_explain is
		do
			put_string ("Creation procedure name: ");
			creation_feature.append_clickable_signature (error_window, creation_feature.written_class);
		end;

end
