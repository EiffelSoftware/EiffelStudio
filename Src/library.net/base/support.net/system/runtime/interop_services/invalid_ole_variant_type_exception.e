indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.InvalidOleVariantTypeException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	INVALID_OLE_VARIANT_TYPE_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_invalid_ole_variant_type_exception,
	make_invalid_ole_variant_type_exception_2,
	make_invalid_ole_variant_type_exception_1

feature {NONE} -- Initialization

	frozen make_invalid_ole_variant_type_exception is
		external
			"IL creator use System.Runtime.InteropServices.InvalidOleVariantTypeException"
		end

	frozen make_invalid_ole_variant_type_exception_2 (message: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Runtime.InteropServices.InvalidOleVariantTypeException"
		end

	frozen make_invalid_ole_variant_type_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.InteropServices.InvalidOleVariantTypeException"
		end

end -- class INVALID_OLE_VARIANT_TYPE_EXCEPTION
