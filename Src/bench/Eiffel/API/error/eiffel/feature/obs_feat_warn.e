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

	build_explain (a_clickable: CLICK_WINDOW) is
		do
			if a_feature /= Void then
				a_clickable.put_string ("%T%Tin feature `");
				a_clickable.put_string (a_feature.feature_name);
				a_clickable.put_string ("':%N%T%T");
			else
				a_clickable.put_string ("%T%Tin invariant%N%T%T");
			end;
			a_clickable.put_string (obsolete_feature.feature_name);
			a_clickable.put_string (" is obsolete: ");
			a_clickable.put_string (obsolete_feature.obsolete_message);
			a_clickable.put_string (" (class ");
			a_clickable.put_string (associated_class.class_name);
			a_clickable.put_string (")");
			a_clickable.new_line;
		end;

end
