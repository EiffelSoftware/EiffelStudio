-- Error when a redeclaration don't specify a require else or an ensure
-- then assertion block

class VDRD8 

inherit

	EIFFEL_ERROR
		rename
			build_explain as old_build_explain
		end;

	EIFFEL_ERROR
		redefine
			build_explain
		select
			build_explain
		end

feature

	a_feature: FEATURE_I;
			-- Feature violatting the rule

	set_a_feature (f: FEATURE_I) is
			-- Assign `f' to `a_feature'.
		do
			a_feature := f;
		end;

	code: STRING is "VDRD";
			-- Error code

	build_explain (a_clickable: CLICK_WINDOW) is
            -- Build specific explanation explain for current error
            -- in `a_clickable'.
        do
			old_build_explain (a_clickable);
			io.error.putstring ("%Tfeature: ");
			io.error.putstring (a_feature.feature_name);
			io.error.new_line;
		end;

end
