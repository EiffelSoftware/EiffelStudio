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
			put_string ("%Tin class ");
			associated_class.append_clickable_name (error_window);
			if a_feature /= Void then
				put_string ("%N%Tin feature `");
				a_feature.append_clickable_signature (error_window);
				put_string ("':%N%T");
			else
				put_string ("%N%Tin invariant%N%T");
			end;
			obsolete_feature.append_clickable_signature (error_window);
			put_string (" is obsolete:%N%T");
			put_string (obsolete_feature.obsolete_message);
			put_string (" (class ");
			obsolete_class.append_clickable_name (error_window);
			put_string (")");
			new_line;
		end;

end
