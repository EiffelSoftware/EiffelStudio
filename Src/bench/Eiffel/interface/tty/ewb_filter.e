indexing

	description: 
		"Build a filtered version (troff, ..) of the class text%
		%and display the result in output_window.";
	date: "$Date$";
	revision: "$Revision $"

deferred class EWB_FILTER 

inherit

	EWB_CLASS
		rename
			make as class_make
		redefine
			process_compiled_class, loop_action
		end

feature -- Initialization

	make (fn, cn: STRING) is
			-- Initialize Current with class_name `cn'
			-- and filtername `fn'.
		require
			fn_not_void: fn /= Void;
			cn_not_void: cn /= Void
		do
			class_make (cn);
			init(fn);
		ensure
			filter_name_set: equal (filter_name, fn);
			class_name_set: class_name = cn
		end;

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

	name: STRING is
		do
			Result := filter_cmd_name;
		end;

	help_message: STRING is
		do
			Result := filter_help
		end;

	abbreviation: CHARACTER is
		do
			Result := filter_abb
		end;

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
			ctxt: CLASS_TEXT_FORMATTER;
			st: STRUCTURED_TEXT
		do
			!! st.make;
			cmd := clone (associated_cmd);
			!! ctxt;
			cmd.set (e_class, st);
			cmd.execute;
			output_window.put_string (cmd.structured_text.image);
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

end -- class EWB_FILTER
