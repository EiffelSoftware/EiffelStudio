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

	e_class: CLASS_C;
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
			-- Is `e_class' defined for error?
		do
			Result := e_class /= Void
		ensure
			yes_implies_valid_class: Result implies e_class /= Void
		end;

feature -- Output

	trace (st: STRUCTURED_TEXT) is
		do
			print_error_message (st);
			st.add_string ("Class: ");
			e_class.append_signature (st);
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
			e_class := c
		end;

end -- class EIFFEL_ERROR
