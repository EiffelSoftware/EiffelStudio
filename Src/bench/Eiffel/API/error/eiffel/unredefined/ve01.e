indexing

	description: 
		"Error when an external is redefined into a non-external feature or %
		%when a non-external one is redefined into an external feature.";
	date: "$Date$";
	revision: "$Revision $"

class VE01 obsolete "NOT DEFINED IN THE BOOK"

inherit

	FEATURE_ERROR
		redefine
			build_explain, subcode, is_defined
		end;

feature -- Properties

	old_feature: E_FEATURE;
			-- Features involved in the error

	code: STRING is "VDRD";
			-- Error code

	subcode: INTEGER is 7

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				is_feature_defined and then
				old_feature /= Void
		ensure then
			valid_old_feature: Result implies old_feature /= Void
		end

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
		local
			wclass: E_CLASS
		do
			wclass := old_feature.written_class;
			ow.put_string ("Redeclared routine: ");
			old_feature.append_name (ow, wclass);
			ow.put_string (" from ");
			wclass.append_name (ow);
			if old_feature.is_external then
				ow.put_string (" is an external routine%N")
			else
				ow.put_string (" is not an external routine%N")
			end;
		end;

feature {COMPILER_EXPORTER}

	set_old_feature (f: FEATURE_I) is
			-- Assign `f' to `feature2'.
		require
			valid_f: f /= Void
		do
			old_feature := f.api_feature;
		end;

end -- class VE01
