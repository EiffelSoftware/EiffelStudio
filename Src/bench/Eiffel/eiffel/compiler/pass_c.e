-- Pass controler for a class_c

deferred class PASS_C

inherit

	COMPILER_EXPORTER

feature

	associated_class: CLASS_C;

	make (a_class: CLASS_C) is
			-- Create a controler for `a_class'
		do
			associated_class := a_class;
		end;

	new_compilation: BOOLEAN;

	execute (degree_output: DEGREE_OUTPUT; to_go: INTEGER) is
			-- Process a compiler pass on the `associated_class'
		require
			valid_degree_output: degree_output /= Void
			positive_to_go: to_go > 0
		deferred
		end;

	set_new_compilation is
			-- the entire pass must be applied to `associated_class'
		do
			new_compilation := True
		end;

invariant

	associated_class_not_void: associated_class /= Void

end
