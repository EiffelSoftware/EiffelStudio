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

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Class: ");
			associated_class.append_name (ow);
			if a_feature /= Void then
				ow.put_string ("%NFeature: ");
				a_feature.append_name (ow, associated_class);
			else
				ow.put_string ("%NFeature: invariant")
			end;
			ow.put_string ("%NObsolete feature: ");
			obsolete_feature.append_signature 
					(ow, obsolete_feature.written_class);
			ow.put_string (" (class ");
			obsolete_class.append_name (ow);
			ow.put_string (")%NObsolete message: ");
			ow.put_string (obsolete_feature.obsolete_message);
			ow.new_line;
		end;

feature {ACCESS_FEAT_AS_B} -- Setting

	set_obsolete_feature (f: FEATURE_I) is
			-- Assign `f' to `obsolete_feature'
		require
			valid_f: f /= Void
		do
			obsolete_feature := f.api_feature
		end;

	set_feature (f: FEATURE_I) is
			-- Assign `f' to `feature'
		do
			if f /= Void then
				a_feature := f.api_feature
			end
		end;

end -- class OBS_FEAT_WARN
