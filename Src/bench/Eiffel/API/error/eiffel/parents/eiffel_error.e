indexing

	description: 
		"Error object sent by the compiler to the workbench.";
	date: "$Date$";
	revision: "$Revision $"

deferred class EIFFEL_ERROR 

inherit

	ERROR
		redefine
			trace, is_defined
		end

feature -- Properties

	class_c: CLASS_C;
			-- Class where the error is encountered

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined
		ensure then
			yes_implies_class_defined: Result implies is_class_defined
		end;

	is_class_defined: BOOLEAN is
			-- Is `class_c' defined for error?
		do
			Result := class_c /= Void
		ensure
			yes_implies_valid_class: Result implies class_c /= Void
		end;

feature -- Output

	trace (st: STRUCTURED_TEXT) is
		do
			print_error_message (st);
			st.add_string ("Class: ");
			class_c.append_signature (st);
			st.add_new_line;
			build_explain (st)
		end;

	build_explain (st: STRUCTURED_TEXT) is
		do
		end;

feature {COMPILER_EXPORTER}

	set_class (c: CLASS_C) is
			-- Assign `c' to `class_c'.
		require
			valid_c: c /= Void
		do
			class_c := c
		end;

end -- class EIFFEL_ERROR
