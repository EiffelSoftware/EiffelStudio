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
			a_clickable.put_string ("%Tfeature ");
			a_feature.append_clickable_signature (a_clickable);
			a_clickable.put_string ("%N%Tand feature ");
			other_feature.append_clickable_signature (a_clickable);
			a_clickable.new_line;
		end;

end
