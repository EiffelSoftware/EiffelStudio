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

	subcode: INTEGER is 6

	creation_feature: E_FEATURE;
			-- Creation feature involved

feature -- Output


	build_explain (st: STRUCTURED_TEXT) is
		do
			print_name (st);
			st.add_string ("Feature name: ");
			if creation_feature /= Void then
				creation_feature.append_signature (st);
			end;
			st.add_new_line;
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
