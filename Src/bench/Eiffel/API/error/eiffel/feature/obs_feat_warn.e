-- Warning for obsolete features  

class OBS_FEAT_WARN

inherit

	OBS_CLASS_WARN
		redefine
			build_explain, code
		end;

feature

	code: STRING is
		do
			Result := "Obsolete_call"
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

	build_explain is
		do
			put_string ("Class: ");
			associated_class.append_clickable_name (error_window);
			if a_feature /= Void then
				put_string ("%NFeature: ");
				a_feature.append_clickable_name (error_window, associated_class);
			else
				put_string ("%NFeature: invariant")
			end;
			put_string ("%NObsolete feature: ");
			obsolete_feature.append_clickable_signature (error_window, obsolete_feature.written_class);
			put_string (" (class ");
			obsolete_class.append_clickable_name (error_window);
			put_string (")%NObsolete message: ");
			put_string (obsolete_feature.obsolete_message);
			new_line;
		end;

end
