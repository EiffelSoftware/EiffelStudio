indexing

	description: 
		"Error when a redeclaration don't specify a require %
		%else or an ensure then assertion block.";
	date: "$Date$";
	revision: "$Revision $"

class VDRD8 

inherit

	EIFFEL_ERROR
		redefine
			build_explain, subcode, is_defined
		end

feature -- Properties

	a_feature: E_FEATURE;
			-- Feature violating the rule

	precondition: BOOLEAN;

	postcondition: BOOLEAN;

	code: STRING is "VDRD";
			-- Error code

	subcode: INTEGER is 3;

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				a_feature /= Void 
		ensure then
			valid_a_feature: Result implies a_feature /= Void
		end

feature -- Output

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

feature {COMPILER_EXPORTER}

	set_feature (f: FEATURE_I) is
			-- Assign `f' to `a_feature'.
		require
			valid_f: f /= Void
		do
			a_feature := f.api_feature (f.written_in);
		end;

	set_postcondition is
		do
			postcondition := True;
		end;

	set_precondition is
		do
			precondition := True;
		end;

end -- class VDRD8
