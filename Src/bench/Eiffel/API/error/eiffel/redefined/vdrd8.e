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

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation explain for current error
			-- in `st'.
		do
			st.add_string ("Feature: ");
			a_feature.append_name (st);
			st.add_new_line;
			if postcondition then
				if precondition then
					st.add_string ("Invalid assertion clauses: precondition and postcondition")
				else
					st.add_string ("Invalid assertion clause: postcondition")
				end;
			else
				st.add_string ("Invalid assertion clause: precondition")
			end;
			st.add_new_line
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
