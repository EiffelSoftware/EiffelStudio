indexing

	description: 
		"Build a filtered version (troff, ..) of the class text%
		%and display the result in output_window.";
	date: "$Date$";
	revision: "$Revision $"

deferred class EWB_FILTER_CLASS

inherit

	EWB_CLASS
		redefine
			process_compiled_class, loop_action
		end

feature -- Initialization

	init (fn: STRING) is
			-- Initialize Current with class_name as `cn'
			-- and filter_name as `fn'.
		require
			fn_not_void: fn /= Void
		do
			filter_name := fn
		ensure
			filter_set: filter_name = fn
		end;

feature -- Properties

	filter_name: STRING;
			-- Name of the filter to be used


feature {NONE} -- Properties

	associated_cmd: E_CLASS_CMD is
			-- Associated class command to be executed
			-- after successfully retrieving the compiled
			-- class
		deferred
		ensure
			non_void_result: Result /= Void
		end;

feature {NONE} -- Execution

	process_compiled_class (e_class: E_CLASS) is
			-- Execute associated command
		local
			cmd: like associated_cmd;
			st: STRUCTURED_TEXT;
			filter: TEXT_FILTER
		do
			!! st.make;
			cmd := clone (associated_cmd);
			cmd.set (e_class, st);
			cmd.execute;
			st := cmd.structured_text;
			!! filter.make (filter_name);
			filter.process_text (st);
			output_window.put_string (filter.image);
			output_window.new_line
		end;

	loop_action is
			-- Execute Current command from loop.
		do
			command_line_io.get_class_name;
			class_name := command_line_io.last_input;
			command_line_io.get_filter_name;
			filter_name := command_line_io.last_input;
			check_arguments_and_execute
		end;

invariant

	filter_name_not_void: filter_name /= Void

end -- class EWB_FILTER_CLASS
