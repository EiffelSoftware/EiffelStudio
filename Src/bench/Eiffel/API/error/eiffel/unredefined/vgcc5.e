indexing

	description: 
		"Error the feature called after a creation is not a creation procedure.";
	date: "$Date$";
	revision: "$Revision $"

class VGCC5 

inherit

	VGCC
		redefine
			subcode, build_explain
		end

feature -- Properties

	subcode: INTEGER is
		do
			Result := 6;
		end;

	creation_feature: E_FEATURE;
			-- Creation feature involved

feature -- Output


	build_explain (ow: OUTPUT_WINDOW) is
		do
			print_name (ow);
			ow.put_string ("Feature name: ");
			if creation_feature /= Void then
				creation_feature.append_signature (ow, creation_feature.written_class);
			end;
			ow.new_line;
		end;

feature {COMPILER_EXPORTER}

	set_creation_feature (f: FEATURE_I) is
			-- Assign `f' to `creation_feature'.
		do
			if f /= Void then
				creation_feature := f.api_feature (f.written_in);
			end
		end;

end -- class VGCC5
