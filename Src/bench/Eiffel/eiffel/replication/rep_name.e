class REP_NAME

feature

	old_feature: FEATURE_I;
			-- Old feature that was replicated

	new_feature: FEATURE_I;
			-- New replicated feature 
			-- (Rep feature was recorded before select table
			-- was computed hence new feature may be unselected)

	rep_feature: FEATURE_I;
			-- Latest feature from feature table 

	set_old_feature (f: FEATURE_I) is
			-- Assign `f' to old_feature.
		do
			old_feature := f;
		end;

	set_new_feature (f: FEATURE_I) is
			-- Assign `f' to new_feature.
		do
			new_feature := f
		end;

	set_rep_feature (f: FEATURE_I) is
			-- Assign `f' to latest_feature.
		do
			rep_feature := f
		end;

end
