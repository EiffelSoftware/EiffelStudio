indexing
	description: "Formats .NET feature text."
	date: "$Date: 2002/07/23"
	revision: "$Revision 1.0$"
	
class
	DOTNET_FEATURE_TEXT_FORMATTER

inherit
	E_TEXT_FORMATTER

feature -- Properties

	is_flat: BOOLEAN is True
			-- Is the format doing a flat? 

feature -- Execution

	format (a_feature: E_FEATURE; c: CONSUMED_TYPE) is
			-- Format text for .NET `a_feature'.
		require
			valid_feature: a_feature /= Void
		local
			f: DOTNET_FEATURE_CONTEXT
		do
			create f.make (a_feature, c)

			if is_clickable then
				f.set_in_bench_mode
			end
			f.execute
			text := f.text
			error := f.execution_error
		end

end -- class DOTNET_FEATURE_TEXT_FORMATTER
