indexing

	description: 
		"Warning for obsolete features.";
	date: "$Date$";
	revision: "$Revision $"

class OBS_FEAT_WARN

inherit

	OBS_CLASS_WARN
		redefine
			build_explain, code, help_file_name, is_defined
		end;

feature -- Properties

	code: STRING is
		do
			Result := "Obsolete call"
		end;

	help_file_name: STRING is
		do
			Result := "OBS_CALL"
		end;

	obsolete_feature: E_FEATURE;
			-- feature name

	a_feature: E_FEATURE;
			-- Feature using the obsolete
			-- (Void `a_feature' implies feature is invariant)

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := classes_defined and then
				obsolete_feature /= Void
		ensure then
			valid_features: Result implies obsolete_feature /= Void	
		end

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Class: ");
			associated_class.append_name (st);
			if a_feature /= Void then
				st.add_new_line;
				st.add_string ("Feature: ");
				a_feature.append_name (st);
			else
				st.add_new_line;
				st.add_string ("Feature: invariant")
			end;
			st.add_new_line;
			st.add_string ("Obsolete feature: ");
			obsolete_feature.append_signature (st);
			st.add_string (" (class ");
			obsolete_class.append_name (st);
			st.add_string (")");
			st.add_new_line;
			st.add_string ("Obsolete message: ");
			st.add_string (obsolete_feature.obsolete_message);
			st.add_new_line
		end;

feature {ACCESS_FEAT_AS, PRECURSOR_AS} -- Setting

	set_obsolete_feature (f: FEATURE_I) is
			-- Assign `f' to `obsolete_feature'
		require
			valid_f: f /= Void
		do
			obsolete_feature := f.api_feature (f.written_in)
		end;

	set_feature (f: FEATURE_I) is
			-- Assign `f' to `feature'
		require
			valid_associated_class: associated_class /= Void
		do
			if f /= Void then
				a_feature := f.api_feature (associated_class.class_id)
			end
		end;

end -- class OBS_FEAT_WARN
