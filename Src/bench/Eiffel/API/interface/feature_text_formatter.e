indexing

	description: 
		"Formats feature text.";
	date: "$Date$";
	revision: "$Revision $"

class FEATURE_TEXT_FORMATTER

inherit

	E_TEXT_FORMATTER

feature -- Properties

	is_flat: BOOLEAN is True;
			-- Is the format doing a flat? 

feature -- Execution

	format_debuggable (routine: E_FEATURE) is
			-- Format text for eiffel `routine' and take
			-- into consideration renaming.
		require
			valid_routine: routine /= Void
		local
			f: DEBUG_CONTEXT
		do
			!! f.make (routine.associated_class);
			if is_clickable then
				f.set_in_bench_mode
			end;
			f.execute (routine);
			text := f.text;
			error := f.execution_error
		end;

	simple_format_debuggable (routine: E_FEATURE) is
			-- Do a simple format for eiffel `routine' 
			-- which doesn't only formats the text and doesn't
			-- take into consideration renaming.
		require
			valid_routine: routine /= Void
		local
			f: SIMPLE_DEBUG_CONTEXT
		do
			!! f.make (routine);
			text := f.text;
			error := f.execution_error
		end;

	format (routine: E_FEATURE) is
			-- Format text for eiffel `routine' and take
			-- into consideration renaming.
		require
			valid_routine: routine /= Void
		local
			f: FORMAT_FEAT_CONTEXT
		do
			!! f.make (routine.associated_class);
			if is_clickable then
				f.set_in_bench_mode
			end;
			f.execute (routine);
			text := f.text;
			error := f.execution_error
		end;

end -- class FEATURE_TEXT_FORMATTER
