indexing

	description:
		"Build a filtered version (troff, ..) of some text.";
	date: "$Date$";
	revision: "$Revision $"

deferred class EWB_FILTER 

feature -- Initialization

	init (fn: STRING) is
			-- Initialize Current filter_name as `fn'.
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

feature {NONE} -- Execution

	associated_cmd: E_OUTPUT_CMD is
			-- Associated class command to be executed
			-- after successfully retrieving the compiled
			-- class
		deferred
		ensure
			non_void_result: Result /= Void
		end;

	loop_action is
			-- Execute Current command from loop.
		deferred
		end;

invariant

	filter_name_not_void: filter_name /= Void

end -- class EWB_FILTER
