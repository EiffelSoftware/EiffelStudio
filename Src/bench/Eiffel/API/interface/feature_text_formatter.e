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

	format_debuggable (a_feature: E_FEATURE) is
			-- Format text for eiffel `a_feature' and take
			-- into consideration renaming.
		require
			valid_feature: a_feature /= Void
		local
			f: DEBUG_CONTEXT
		do
			!! f.make (a_feature.associated_class);
			if is_clickable then
				f.set_in_bench_mode
			end;
			f.execute (a_feature);
			text := f.text;
			error := f.execution_error
		end;

	simple_format_debuggable (a_feature: E_FEATURE) is
			-- Do a simple format for eiffel `a_feature' 
			-- which doesn't only formats the text and doesn't
			-- take into consideration renaming.
		require
			valid_feature: a_feature /= Void
		local
			f: SIMPLE_DEBUG_CONTEXT
		do
			!! f.make (a_feature);
			text := f.text;
			error := f.execution_error
		end;

	format (a_feature: E_FEATURE) is
			-- Format text for eiffel `a_feature' and take
			-- into consideration renaming.
		require
			valid_feature: a_feature /= Void
		local
			f: FORMAT_FEAT_CONTEXT
		do
			!! f.make (a_feature.associated_class);
			if is_clickable then
				f.set_in_bench_mode
			end;
			f.execute (a_feature);
			text := f.text;
			error := f.execution_error
		end;

end -- class FEATURE_TEXT_FORMATTER
