indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.InvalidOleVariantTypeException"

external class
	SYSTEM_RUNTIME_INTEROPSERVICES_INVALIDOLEVARIANTTYPEEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_invalidolevarianttypeexception_2,
	make_invalidolevarianttypeexception_1,
	make_invalidolevarianttypeexception

feature {NONE} -- Initialization

	frozen make_invalidolevarianttypeexception_2 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Runtime.InteropServices.InvalidOleVariantTypeException"
		end

	frozen make_invalidolevarianttypeexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.InteropServices.InvalidOleVariantTypeException"
		end

	frozen make_invalidolevarianttypeexception is
		external
			"IL creator use System.Runtime.InteropServices.InvalidOleVariantTypeException"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_INVALIDOLEVARIANTTYPEEXCEPTION
