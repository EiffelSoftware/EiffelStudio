-- Pass controler for a class_c

deferred class PASS_C

feature

	associated_class: CLASS_C;

	make (a_class: CLASS_C) is
			-- Create a controler for `a_class'
		do
			associated_class := a_class;
		end;

	new_compilation: BOOLEAN;

	execute is
			-- Process a compiler pass on the `associated_class'
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
