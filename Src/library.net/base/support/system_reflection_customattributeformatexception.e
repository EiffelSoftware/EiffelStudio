indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.CustomAttributeFormatException"

external class
	SYSTEM_REFLECTION_CUSTOMATTRIBUTEFORMATEXCEPTION

inherit
	SYSTEM_FORMATEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_custom_attribute_format_exception_2,
	make_custom_attribute_format_exception_1,
	make_custom_attribute_format_exception

feature {NONE} -- Initialization

	frozen make_custom_attribute_format_exception_2 (message2: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Reflection.CustomAttributeFormatException"
		end

	frozen make_custom_attribute_format_exception_1 (message2: STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.CustomAttributeFormatException"
		end

	frozen make_custom_attribute_format_exception is
		external
			"IL creator use System.Reflection.CustomAttributeFormatException"
		end

end -- class SYSTEM_REFLECTION_CUSTOMATTRIBUTEFORMATEXCEPTION
