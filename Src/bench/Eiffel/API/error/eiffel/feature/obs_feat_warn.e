-- Warning for obsolete features  

class OBS_FEAT_WARN

inherit

	OBS_CLASS_WARN
		redefine
			build_explain, code, help_file_name
		end;

feature

	code: STRING is
		do
			Result := "Obsolete call"
		end;

	help_file_name: STRING is
		do
			Result := "OBS_CALL"
		end;

	obsolete_feature: FEATURE_I;
			-- feature name

	a_feature: FEATURE_I;
			-- feature using the obsolete

	set_obsolete_feature (f: FEATURE_I) is
			-- Assign `f' to `obsolete_feature'
		do
			obsolete_feature := f
		end;

	set_feature (f: FEATURE_I) is
			-- Assign `f' to `feature'
		do
			a_feature := f
		end;

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

end
