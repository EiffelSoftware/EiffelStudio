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

	class_id: INTEGER;
			-- Id of the class where the error is encountered

	set_class_id (i: INTEGER) is
			-- Assign `i' to `class_id'.
		do
			class_id := i
		end;

	trace is
			-- Debug purpose
		local
			compiled_class: CLASS_C;
			dummy_reference: CLASS_C;
			class_stone: CLASSC_STONE
		do
			error_window.put_string (Error_string);
			error_window.put_clickable_string (stone (dummy_reference), code);
			error_window.put_string (" in class ");
			compiled_class := System.class_of_id (class_id);
			!!class_stone.make (compiled_class);
			error_window.put_clickable_string (class_stone, class_stone.signature);
			error_window.put_string (":%N");
			build_explain (error_window)
		end

end
