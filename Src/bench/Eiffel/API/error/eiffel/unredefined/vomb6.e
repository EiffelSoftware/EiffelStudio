indexing

	description: 
		"Error when all unique constants involved in an inspect %
		%instruction don't have the same origin class.";
	date: "$Date$";
	revision: "$Revision $"

class VOMB6 

inherit

	VOMB
		redefine
			subcode, build_explain, is_defined
		end;

feature -- Properties

	subcode: INTEGER is 6;

	unique_feature: E_FEATURE;
			-- Unique feature name

	written_class: CLASS_C;
			-- Class involved

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				is_feature_defined and then
				unique_feature /= Void and then
				written_class /= Void
		ensure then
			valid_written_class: Result implies written_class /= Void;
			valid_unique_feature: Result implies unique_feature /= Void
		end

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		local
			wclass: CLASS_C
		do
			wclass := unique_feature.written_class;
			st.add_string ("Constant: ");
			unique_feature.append_name (st);
			st.add_string (" From: ");
			wclass.append_name (st);
			st.add_new_line;
			st.add_string ("Origin of conflicting constants: ");
			written_class.append_name (st);
			st.add_new_line;
		end;

feature {COMPILER_EXPORTEr}

	set_unique_feature (f: FEATURE_I) is
			-- Assign `s' to `unique_name'.
		require
			valid_f: f /= Void
		do
			unique_feature := f.api_feature (f.written_in);
		end;

	set_written_class (c: CLASS_C) is
			-- Assign `c' to `written_class'.
		require
			valid_c: c /= Void
		do
			written_class := c
		end;

end -- class VOMB6
