indexing

	description: 
		"Formats routine text.";
	date: "$Date$";
	revision: "$Revision $"

class ROUTINE_TEXT_FORMATTER

inherit

	E_TEXT_FORMATTER

feature -- Properties

	is_flat: BOOLEAN is True;
			-- Is the format doing a flat? 

feature -- Execution

	format_debuggable (routine: E_FEATURE; c: E_CLASS) is
			-- Format text for eiffel `routine' in class
			-- `c' to show debuggable information.
		require
			valid_routine: routine /= Void;
			valid_c: c /= Void
		local
			f: DEBUG_CONTEXT
		do
			!! f.make (c);
			if is_clickable then
				f.set_in_bench_mode
			end;
			f.execute (routine);
			text := f.text;
			error := f.execution_error
		end;

	format (routine: E_FEATURE; c: E_CLASS) is
			-- Format text for eiffel `routine' in
			-- class `c'.
		require
			valid_routine: routine /= Void
			valid_c: c /= Void
		local
			f: FORMAT_FEAT_CONTEXT
		do
			!! f.make (c);
			if is_clickable then
				f.set_in_bench_mode
			end;
			f.execute (routine);
			text := f.text;
			error := f.execution_error
		end;

end -- class ROUTINE_TEXT_FORMATTER
