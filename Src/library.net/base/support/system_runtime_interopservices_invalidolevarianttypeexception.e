indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.InvalidOleVariantTypeException"

external class
	SYSTEM_RUNTIME_INTEROPSERVICES_INVALIDOLEVARIANTTYPEEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_invalid_ole_variant_type_exception_2,
	make_invalid_ole_variant_type_exception_1,
	make_invalid_ole_variant_type_exception

feature {NONE} -- Initialization

	frozen make_invalid_ole_variant_type_exception_2 (message2: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Runtime.InteropServices.InvalidOleVariantTypeException"
		end

	frozen make_invalid_ole_variant_type_exception_1 (message2: STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.InteropServices.InvalidOleVariantTypeException"
		end

	frozen make_invalid_ole_variant_type_exception is
		external
			"IL creator use System.Runtime.InteropServices.InvalidOleVariantTypeException"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_INVALIDOLEVARIANTTYPEEXCEPTION
