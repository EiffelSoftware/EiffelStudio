class REP_NAME

inherit

	COMPARABLE
		redefine
			is_equal
		end;

feature

	old_feature: FEATURE_I;
			-- Old feature that was replicated

	new_feature: FEATURE_I;
			-- New replicated feature 
			-- (Rep feature was recorded before select table
			-- was computed hence new feature may be unselected)

	rep_feature: FEATURE_I;
			-- Latest feature from feature table 

	infix "<" (other: REP_NAME): BOOLEAN is
			-- Is `other' greater than Current ?
		do
			Result := rep_feature.written_in < other.rep_feature.written_in
		end;

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' equal to Current ?
		do
			Result := rep_feature.written_in = other.rep_feature.written_in
		end;

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
