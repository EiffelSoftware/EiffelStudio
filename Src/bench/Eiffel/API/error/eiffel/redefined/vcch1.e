indexing

	description: 
		"Error when a non-deferred class has a deferred feature.";
	date: "$Date$";
	revision: "$Revision $"

class VCCH1 

inherit

	EIFFEL_ERROR
		redefine
			build_explain, subcode, is_defined
		end
	
feature -- Properties

	deferred_feature: E_FEATURE;
			-- Deferred feature in non deferred class

	code: STRING is "VCCH";
			-- Error code

	subcode: INTEGER is 1;

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				deferred_feature /= Void
		ensure then
			valid_deferred_feature: Result implies deferred_feature /= Void
		end

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
			-- Build specific explanation explain for current error
			-- in `ow'.
		local
			wclass: E_CLASS;
		do
			wclass := deferred_feature.written_class;
			ow.put_string ("Deferred feature: ");
			deferred_feature.append_name (ow, wclass);
			ow.put_string (" From: ");
			wclass.append_name (ow);
			ow.new_line;
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_a_feature (f: FEATURE_I) is
			-- Assign `f' to `a_feature'.
		require
			valid_f: f /= Void
		do
			deferred_feature := f.api_feature (f.written_in);
		end;

end -- class VCCH1
