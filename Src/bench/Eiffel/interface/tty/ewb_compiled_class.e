indexing

	description: 
		"Abstract notion of command selected from class batch menu%
		%which is compiled.";
	date: "$Date$";
	revision: "$Revision $"

deferred class EWB_COMPILED_CLASS

inherit

	EWB_CLASS
		redefine
			want_compiled_class, process_compiled_class
		end

feature {NONE} -- Properties

	want_compiled_class: BOOLEAN is
			-- Does current menu selection want a
			-- compiled class (class_c)?
			-- (True)
		do
			Result := True
		end;

	associated_cmd: E_CLASS_CMD is
			-- Associated class command to be executed
			-- after successfully retrieving the compiled
			-- class
		deferred
		ensure
			non_void_result: Result /= Void
		end;

feature {NONE} -- Execution

	process_compiled_class (class_c: CLASS_C) is
			-- Process compiled class `class_c'.
		local
			cmd: like associated_cmd
		do
			cmd := clone (associated_cmd);  
			cmd.set (class_c, output_window);  
			cmd.execute
		end;

end -- class EWB_COMPILED_CLASS
