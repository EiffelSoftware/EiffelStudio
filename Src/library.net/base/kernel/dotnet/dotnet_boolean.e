indexing
	description: "Set of static routines belonging to System.Boolean"
	date: "$Date$"
	revision: "$Revision$"

frozen external class
	DOTNET_BOOLEAN

create {NONE}

feature -- Statics

	frozen false_string: SYSTEM_STRING is
			-- (Static)
			-- Represents the Boolean value false as a string.
			-- This field is read-only.  
		external
			"IL static_field signature :System.String use System.Boolean"
		alias
			"FalseString"
		end

	frozen true_string: SYSTEM_STRING is
			-- (Static)
			-- Represents the Boolean value true as a string.
			-- This field is read-only.  
		external
			"IL static_field signature :System.String use System.Boolean"
		alias
			"TrueString"
		end

	frozen from_string (value: SYSTEM_STRING): BOOLEAN is
			-- (Static)
			-- Converts the specified string representation of
			-- a logical value to its System.Boolean equivalent.
			--
			-- Parameters:
			--   value: A string containing the value to convert.
			--
			-- Returns:
			--   true if value is equivalent to
			--   System.Boolean.TrueString; otherwise, false.
			--
			-- Exceptions:
			--   System.ArgumentNullException: value is null.
			--   System.FormatException: value is not equivalent
			--     to System.Boolean.TrueString nor
			--     System.Boolean.FalseString.
		external
			"IL static signature (System.String): System.Boolean use System.Boolean"
		alias
			"Parse"
		end

end -- class DOTNET_BOOLEAN
