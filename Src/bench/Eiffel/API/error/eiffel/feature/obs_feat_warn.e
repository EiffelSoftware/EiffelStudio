-- Warning for obsolete features  

class OBS_FEAT_WARN

inherit

	OBS_CLASS_WARN
		redefine
			build_explain
		end;

feature

	obsolete_feature: FEATURE_I;
			-- feature name

	set_feature (f: FEATURE_I) is
			-- Assign `s' to `option_name'
		do
			obsolete_feature := f
		end;

	build_explain (a_clickable: CLICK_WINDOW) is
		do
			a_clickable.put_string ("%TWarning: ");
			a_clickable.put_string (obsolete_feature.feature_name);
			a_clickable.put_string (" is obsolete: ");
			a_clickable.put_string (obsolete_feature.obsolete_message);
			a_clickable.put_string (" (class ");
			a_clickable.put_string (associated_class.class_name);
			a_clickable.put_string (")");
			a_clickable.new_line;
		end;

end
