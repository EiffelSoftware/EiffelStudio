-- Error when a redeclaration don't specify a require else or an ensure
-- then assertion block

class VDRD8 

inherit

	EIFFEL_ERROR
		redefine
			build_explain, subcode
		end

feature

	a_feature: FEATURE_I;
			-- Feature violatting the rule

	set_feature (f: FEATURE_I) is
			-- Assign `f' to `a_feature'.
		do
			a_feature := f;
		end;

	code: STRING is "VDRD";
			-- Error code

	subcode: INTEGER is 8;

	build_explain is
            -- Build specific explanation explain for current error
            -- in `error_window'.
        do
			put_string ("%Tfeature: ");
			a_feature.append_clickable_signature (error_window);
			new_line;
		end;

end
