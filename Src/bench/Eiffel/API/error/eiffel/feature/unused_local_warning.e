indexing
	description	: "Warning for unreferenced local variable within a feature."
	date		: "$Date$";
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

class UNUSED_LOCAL_WARNING

inherit
	WARNING
		redefine
			build_explain
		end

feature -- Properties

	associated_type: CL_TYPE_A
			-- Type of the class containing the feature that contains 
			-- the unused local variable.

	associated_feature: E_FEATURE
			-- Feature containing the unused local variable.

	associated_local: STRING
			-- Name of the unused local variable.

	code: STRING is
			-- Error code
		do
			Result := "Unused_local_warning"
		end
	
feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Class: ")
			associated_type.append_to (st)
			st.add_new_line
			st.add_char ('`')
			st.add_string (associated_local)
			st.add_string ("', unreferenced local variable in routine `")
			associated_feature.append_name (st)
			st.add_char ('%'')
			st.add_new_line
		end

feature {COMPILER_EXPORTER}

	set_associated_type (t: CL_TYPE_A) is
			-- Set `associated_type' to `t'
		require
			valid_t: t /= Void
		do
			associated_type := t
		end

	set_associated_feature (f: E_FEATURE) is
			-- Set `associated_feature' to `f'
		require
			valid_f: f /= Void
		do
			associated_feature := f
		end

	set_associated_feature_i (f: FEATURE_I) is
			-- Set `associated_feature' to the E_FEATURE corresponding to `f'.
		require
			valid_f: f /= Void
		do
			associated_feature := f.api_feature (f.written_in)
		end

	set_associated_local (s: STRING) is
			-- Set `associated_local' to `s'
		require
			valid_s: s /= Void
		do
			associated_local := s
		end

end -- class UNUSED_LOCAL_WARNING
