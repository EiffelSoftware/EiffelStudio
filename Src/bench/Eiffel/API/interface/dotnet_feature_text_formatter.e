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
		do
			internal_format (new_format_context (a_feature, c))
		end

	format_short (a_feature: E_FEATURE; c: CONSUMED_TYPE) is
			-- Format text for .NET `a_feature'.
		require
			valid_feature: a_feature /= Void
		local
			f: DOTNET_FEATURE_CONTEXT
		do
			f := new_format_context (a_feature, c)
			f.set_use_dotnet_name_only
			internal_format (f)
		end

feature {NONE} -- Implementation

	new_format_context (a_feature: E_FEATURE; c: CONSUMED_TYPE): DOTNET_FEATURE_CONTEXT is
			-- Create a new formatting context
		require
			valid_feature: a_feature /= Void
		do
			create Result.make (a_feature, c)
			if is_clickable then
				Result.set_in_bench_mode
			end
		end
	
	internal_format (f: DOTNET_FEATURE_CONTEXT) is
			-- Text formatting implementation.
		do
			f.execute
			text := f.text
			error := f.execution_error
		end	
		
end -- class DOTNET_FEATURE_TEXT_FORMATTER
