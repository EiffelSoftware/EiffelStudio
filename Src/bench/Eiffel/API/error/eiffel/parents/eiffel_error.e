-- Error object sent by the compiler to the workbench

deferred class EIFFEL_ERROR 

inherit

	SHARED_WORKBENCH
		export
			{NONE} all
		end;
	ERROR
		redefine
			trace
		end

feature 

	class_c: CLASS_C;
			-- Class where the error is encountered

	set_class (c: CLASS_C) is
			-- Assign `c' to `class_c'.
		do
			class_c := c
		end;

	set_class_id (id: INTEGER) is
		obsolete "Use `set_class'"
			-- Assign `c' to `class_c'.
		do
			class_c := System.class_of_id (id)
		end;

	trace is
		do
			print_error_message;
			put_string ("Class: ");
			class_c.e_class.append_clickable_signature (error_window);
			new_line;
			build_explain
		end;

	build_explain is
		do
		end;

end
