-- Error the feature called after a creation is not a creation procedure

class VGCC5 

inherit

	VGCC
		redefine
			subcode, build_explain
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

	build_explain is
		do
			print_name;
			put_string ("Feature name: ");
			if creation_feature /= Void then
				creation_feature.append_clickable_signature (error_window, creation_feature.written_class);
			end;
			new_line;
		end;

end
