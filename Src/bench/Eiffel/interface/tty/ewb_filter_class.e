indexing

	description: 
		"Build a filtered version (troff, ..) of the class text%
		%and display the result in output_window.";
	date: "$Date$";
	revision: "$Revision $"

deferred class EWB_FILTER_CLASS

inherit

	EWB_FILTER;
	EWB_CLASS
		redefine
			process_compiled_class, loop_action
		end

feature {NONE} -- Execution

	associated_cmd: E_CLASS_CMD is
			-- Command to be executed after successful
			-- retrieving of the class text.
		deferred
		end;

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
