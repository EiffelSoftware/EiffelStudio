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

	precondition: BOOLEAN;

	set_precondition is
		do
			precondition := True;
		end;

	postcondition: BOOLEAN;

	set_postcondition is
		do
			postcondition := True;
		end;

	code: STRING is "VDRD";
			-- Error code

	subcode: INTEGER is 3;

	build_explain (ow: OUTPUT_WINDOW) is
			-- Build specific explanation explain for current error
			-- in `ow'.
		do
			ow.put_string ("Feature: ");
			a_feature.append_name (ow, a_feature.written_class);
			if postcondition then
				if precondition then
					ow.put_string ("%NInvalid assertion clauses: precondition and postcondition%N")
				else
					ow.put_string ("%NInvalid assertion clause: postcondition%N")
				end;
			else
				ow.put_string ("%NInvalid assertion clause: precondition%N")
			end;
		end;

end
