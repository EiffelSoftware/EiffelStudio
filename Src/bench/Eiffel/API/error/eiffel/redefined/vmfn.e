-- Name clash of features

class VMFN 

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
			-- Feature implemented in the class of id `class_id'
			-- responsible for the name clash

	other_feature: FEATURE_I;
			-- Inherited feature

	set_a_feature (f: FEATURE_I) is
			-- Assign `f' to `a_feature'.
		do
			a_feature := f;
		end;

	set_other_feature (f: FEATURE_I) is
			-- Assign `f' to `other_feature'.
		do
			other_feature := f;
		end;

	code: STRING is "VMFN";
			-- Error code

	build_explain (a_clickable: CLICK_WINDOW) is
            -- Build specific explanation explain for current error
            -- in `a_clickable'.
        do
            old_build_explain (a_clickable);
			io.error.putstring ("%Tfeature ");
			io.error.putstring (a_feature.feature_name);
			io.error.putstring ("%N%Tand feature ");
			io.error.putstring (other_feature.feature_name);
			io.error.new_line;
		end;

end
