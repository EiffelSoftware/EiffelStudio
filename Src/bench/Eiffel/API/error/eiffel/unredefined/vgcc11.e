indexing
	description: "Error in creation instruction when applied to a formal generic parameter"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	VGCC11

inherit
	VGCC1
		redefine
			subcode, build_explain
		end

feature -- Properties

	subcode: INTEGER is 8

 
	creation_feature: E_FEATURE;
			-- Creation feature involved

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build the error message
		do
			st.add_string ("Creation of: ");
			st.add_string (target_name);
			st.add_new_line;
			st.add_string ("Feature name: ");
			if creation_feature /= Void then
				creation_feature.append_signature (st);
			end;
			st.add_new_line;
		end

feature {COMPILER_EXPORTER}

	set_creation_feature (f: FEATURE_I) is
			-- Assign `f' to `creation_feature'.
		do
			if f /= Void then
				creation_feature := f.api_feature (f.written_in);
			end
		end;

end -- class VGCC11
