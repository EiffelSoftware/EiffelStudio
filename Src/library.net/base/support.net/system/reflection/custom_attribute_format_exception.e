indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.CustomAttributeFormatException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	CUSTOM_ATTRIBUTE_FORMAT_EXCEPTION

inherit
	FORMAT_EXCEPTION
	ISERIALIZABLE

create
	make_custom_attribute_format_exception_1,
	make_custom_attribute_format_exception_2,
	make_custom_attribute_format_exception

feature {NONE} -- Initialization

	frozen make_custom_attribute_format_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.CustomAttributeFormatException"
		end

	frozen make_custom_attribute_format_exception_2 (message: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Reflection.CustomAttributeFormatException"
		end

	frozen make_custom_attribute_format_exception is
		external
			"IL creator use System.Reflection.CustomAttributeFormatException"
		end

end -- class CUSTOM_ATTRIBUTE_FORMAT_EXCEPTION
