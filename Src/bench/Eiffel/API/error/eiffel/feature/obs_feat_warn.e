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
			a_clickable.put_string ("%Tin class ");
			associated_class.append_clickable_name (a_clickable);
			if a_feature /= Void then
				a_clickable.put_string ("%N%Tin feature `");
				a_feature.append_clickable_signature (a_clickable);
				a_clickable.put_string ("':%N%T");
			else
				a_clickable.put_string ("%N%Tin invariant%N%T");
			end;
			obsolete_feature.append_clickable_signature (a_clickable);
			a_clickable.put_string (" is obsolete:%N%T");
			a_clickable.put_string (obsolete_feature.obsolete_message);
			a_clickable.put_string (" (class ");
			obsolete_class.append_clickable_name (a_clickable);
			a_clickable.put_string (")");
			a_clickable.new_line;
		end;

end
