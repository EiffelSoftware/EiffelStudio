indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "System.Boolean"
	assembly: "mscorlib", "1.0.2411.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	BOOLEAN

inherit
	VALUE_TYPE
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

	ICOMPARABLE
		undefine
			get_hash_code,
			equals,
			to_string
		end

	BOOLEAN_REF

create {NONE}

feature -- Access

	frozen type_code: TYPE_CODE is
			-- Returns the System.TypeCode for value type System.Boolean.
			--
			-- Returns:
			--   The enumerated constant, System.TypeCode.Boolean.  
		external
			"IL signature (): System.TypeCode use System.Boolean"
		alias
			"GetTypeCode"
		end

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

feature -- Conversion

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

	frozen to_string_with_format (provider: IFORMAT_PROVIDER): SYSTEM_STRING is
			-- Converts the value of this instance to its equivalent
			-- string representation.
			--
			-- Parameters:
			--   provider: (Reserved) An System.IFormatProvider object.
			--
			-- Returns:
			--   System.Boolean.TrueString if the value of this
			--   instance is true, or System.Boolean.FalseString if
			--   the value of this instance is false.
		external
			"IL signature (System.IFormatProvider): System.String use System.Boolean"
		alias
			"ToString"
		end

feature -- Comparison

	frozen compare_to (obj: SYSTEM_OBJECT): INTEGER is
			-- Compares this instance to a specified object and returns
			-- an indication of their relative values.
			--
			-- Parameters:
			--   obj: An object to compare to this instance, or null.
			--
			-- Returns:
			--   A signed integer that indicates the relative order of
			--   this instance and obj:
			--     Less than zero if this instance is false and obj is true.
			--     Zero if this instance and obj are equal (either both are
			--       true or both are false ).
			--     Greater than zero  This instance is true and obj is
			--       false -or- obj is null.
			--
			-- Exceptions:
			--   System.ArgumentException: obj is not a System.Boolean.
		external
			"IL signature (System.Object): System.Int32 use System.Boolean"
		alias
			"CompareTo"
		end

feature -- Obsolete

	frozen get_type_code: TYPE_CODE is
		obsolete
			"Use `type_code' instead"
		external
			"IL signature (): System.TypeCode use System.Boolean"
		alias
			"GetTypeCode"
		end

	frozen parse (value: SYSTEM_STRING): BOOLEAN is
		obsolete
			"Use `from_string' instead"
		external
			"IL static signature (System.String): System.Boolean use System.Boolean"
		alias
			"Parse"
		end

	frozen to_string_iformat_provider (provider: IFORMAT_PROVIDER): SYSTEM_STRING is
		obsolete
			"Use `to_string_with_format' instead"
		external
			"IL signature (System.IFormatProvider): System.String use System.Boolean"
		alias
			"ToString"
		end

end -- class BOOLEAN
