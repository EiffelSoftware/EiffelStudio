indexing

	description: 
		"Warning for obsolete features.";
	date: "$Date$";
	revision: "$Revision $"

class OBS_CLASS_WARN

inherit

	WARNING
		redefine
			build_explain, infix "<", help_file_name,
			is_defined
		end;

feature -- Properties

	associated_class: CLASS_C;
			-- Class using the obsolete class

	obsolete_class: CLASS_C;
			-- Obsolete class

	code: STRING is
			-- Error code
		do
			Result := "Obsolete";
		end;

	help_file_name: STRING is
		do
			Result := "OBS_CLASS"
		end;

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := classes_defined
		end;

	classes_defined: BOOLEAN is
			-- Is the feature defined for error?
		do
			Result := associated_class /= Void and then
				obsolete_class /= Void
		ensure
			yes_implies_valid_classes: Result implies 
							associated_class /= Void and then
							obsolete_class /= Void
		end;


feature -- Comparison
	
	infix "<" (other: like Current): BOOLEAN is
		do
			Result := code < other.code or else
				(code.is_equal (other.code) and then
					associated_class < other.associated_class)
		end;

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Class: ");
			associated_class.append_name (st);
			st.add_new_line;
			st.add_string ("Obsolete class: ");
			obsolete_class.append_name (st);
			st.add_new_line;
			st.add_string ("Obsolete message: ");
			st.add_string (obsolete_class.obsolete_message);
			st.add_new_line;
		end;

feature {COMPILER_EXPORTER}

	set_class (c: CLASS_C) is
		require
			valid_c: c /= Void
		do
			associated_class := c
		end;

	set_obsolete_class (c: CLASS_C) is
		require
			valid_c: c /= Void
		do
			obsolete_class := c
		end;

end -- class OBS_CLASS_WARN
