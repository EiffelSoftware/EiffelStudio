indexing

	description: 
		"Build a filtered version (troff, ..) of the class text%
		%and display the result in output_window.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_FILTER 

inherit

	EWB_COMPILED_CLASS
		rename
			make as class_make
		redefine
			process_compiled_class
		end

creation

	make

feature -- Creation

	make (cn, fn: STRING) is
			-- Initialize Current with class_name as `cn'
			-- and filter_name as `fn'.
		require
			cn_not_void: cn /= Void;
			fn_not_void: fn /= Void
		do
			class_make (class_name);
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

feature {NONE} -- Execution

	associated_cmd: E_SHOW_CLASS_FILTERED_TEXT is
			-- Associated class command to be executed
			-- after successfully retrieving the compiled
			-- class
		once
			!! Result.do_nothing
		end;

	process_compiled_class (class_c: CLASS_C) is
			-- Execute associated command
		local
			cmd: like associated_cmd;
			ctxt: FORMAT_CONTEXT_B
		do
			cmd := clone (associated_cmd);
			!! ctxt.make (class_c);
			set_context_attributes (ctxt);
			cmd.set (class_c, output_window);
			cmd.set_filter_name (filter_name);	
			cmd.set_text_formatter (ctxt);	
			cmd.execute
		end;

	set_context_attributes (ctxt: FORMAT_CONTEXT_B) is
			-- Set context attributes `ctxt'.
		do
			ctxt.set_current_class_only;
			ctxt.set_order_same_as_text;
		end;

invariant

	filter_name_not_void: filter_name /= Void

end -- class EWB_FILTER
