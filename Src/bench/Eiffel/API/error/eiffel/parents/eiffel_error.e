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

	e_class: E_CLASS;
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

	trace (ow: OUTPUT_WINDOW) is
		do
			print_error_message (ow);
			ow.put_string ("Class: ");
			e_class.append_signature (ow);
			ow.new_line;
			build_explain (ow)
		end;

	build_explain (ow: OUTPUT_WINDOW) is
		do
		end;

feature {COMPILER_EXPORTER}

	set_class (c: CLASS_C) is
			-- Assign `c' to `class_c'.
		require
			valid_c: c /= Void
		do
			e_class := c.e_class
		end;

end -- class EIFFEL_ERROR
