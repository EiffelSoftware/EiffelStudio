-- This only stores the old_feature and new_feature (i.e 
-- the latest feature from feature_table). Used for 
-- storage purpose (in S_REP_NAME_LIST). It does not
-- need the "rep_feature" attribute of REP_NAME.

class S_REP_NAME

feature

	old_feature: FEATURE_I;
			-- Old feature that was replicated

	new_feature: FEATURE_I;
			-- New replicated feature 

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

end
